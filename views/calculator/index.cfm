<cfoutput>
	#getInstance("messagebox@cbMessagebox").renderit()#

	<cfif structKeyExists(rc, "results")>
		
	<!--- mortgage content --->
	<div class="row">

		<div class="col-md-12">
			<p>La tua rata &egrave; di: <b>&##8364; #rc.results.monthlyPayment#</b>.</p>
			<p> Costo totale del finanziamento: <b>&##8364; #rc.results.total#</b> di cui 
			<b>&##8364; #rc.balance#</b> di capitale e 
			<b>&##8364; #DecimalFormat(rc.results.totalInterests)#</b> di interessi, pari al <b>#rc.results.totalInterestsRate#%</b>.
			</p>
		</div>		
		<br />

		<cfif structKeyExists(rc, "ammortamento")>
		<div class="col-md-12">
		<table class="table table-striped"> 
		     <tr> 
		          <td colspan="7">Piano di ammortamento</td> 
		     </tr> 
		     <tr> 
		          <td>Rata</td> 
		          <td>Importo rata</td> 
		          <td>Quota Interessi</td> 
		          <td>Totale interessi</td> 
		          <td>Capitale</td> 
		          <td>Capitale Pagato</td> 
		          <td>Montante</td> 
		     </tr> 
		     <cfoutput> 
	          		<cfset counter = 0> 
					<cfloop from="1" to="#prc.NumberOfPeriods#" index="PaymentNumber">
						<cfset Interest=prc.PreviousBalance * prc.monthly_interest> 
						<cfset prc.CumulativeInterest=prc.CumulativeInterest+Interest> 
						<cfset prc.CumulativePrincipalPaid=prc.CumulativePrincipalPaid+(rc.results.monthlyPayment-Interest)> 
						<tr> 
							<td>#NumberFormat(PaymentNumber)#</td> 
							<td>#numberFormat(rc.results.monthlyPayment, "0.000")#</td> 
							<td>#numberFormat(Interest, "0.000")#</td> 
							<td>#numberFormat(prc.CumulativeInterest, "0.000")#</td> 
							<td>#numberFormat((rc.results.monthlyPayment-Interest), "0.000")#</td> 
							<td>#numberFormat(prc.CumulativePrincipalPaid, "0.000")#</td> 
							<td>#numberFormat((prc.PreviousBalance-(rc.results.monthlyPayment-Interest)), "0.000")#</td> 
						</tr> 
					   <cfset prc.PreviousBalance=numberFormat((prc.PreviousBalance-(rc.results.monthlyPayment-Interest)), "0.000")>
					   <cfset counter= counter+1>
					   <cfif (counter EQ rc.period)>
					   	<cfset annualTotal = DecimalFormat(prc.CumulativeInterest + prc.CumulativePrincipalPaid) />
					   		<tr>
					   			<td colspan="7">Totale <b>#annualTotal#</b>: di cui <b>#DecimalFormat(prc.CumulativeInterest)#</b> di interessi 
					   			e <b>#DecimalFormat(prc.CumulativePrincipalPaid)#</b> di capitale.</td>
					   		</tr>
					   		<cfset counter = 0>
					   </cfif>
					</cfloop> 
		     </cfoutput> 
		</table>
		</div>		
		</cfif>

	</div>
	</cfif>

</cfoutput>
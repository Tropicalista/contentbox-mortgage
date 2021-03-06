<cfscript> 
function customFormat(x){
  y = round(arguments.x*100)/100
  if(y<0){
  	return 0;
  }
  return NumberFormat(y, "9.99");
}
</cfscript> 
<cfoutput>
	#getInstance("messagebox@cbMessagebox").renderit()#

	<cfif structKeyExists(rc, "results")>
		
	<!--- mortgage content --->
	<div class="row">

		<div class="col-md-12 alert alert-info">
			<p>La tua rata &egrave; di: <b>&##8364; #NumberFormat(rc.results.monthlyPayment, "9.99")#</b>.</p>
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
							<td>#customFormat(rc.results.monthlyPayment)#</td> 
							<td>#customFormat(Interest)#</td> 
							<td>#customFormat(prc.CumulativeInterest)#</td> 
							<td>#customFormat(rc.results.monthlyPayment-Interest)#</td> 
							<td>#customFormat(prc.CumulativePrincipalPaid)#</td> 
							<td>#customFormat((prc.PreviousBalance-(rc.results.monthlyPayment-Interest)))#</td> 
						</tr> 
					   <cfset prc.PreviousBalance=numberFormat((prc.PreviousBalance-(rc.results.monthlyPayment-Interest)), "0.00")>
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
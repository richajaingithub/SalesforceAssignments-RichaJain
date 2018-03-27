trigger OpportuintyTriggerToUpdateCloseDate on Opportunity (BEFORE INSERT,BEFORE UPDATE) {
	for (Opportunity objOpportunity:Trigger.New) {
			if (objOpportunity.StageName == 'CLOSED WON' || objOpportunity.StageName == 'CLOSED LOST') {
				objOpportunity.CloseDate = System.Today();
			}
		}
}
trigger OpportuintyTriggerToUpdateCloseDate on Opportunity (BEFORE INSERT,BEFORE UPDATE) {
	for (Opportunity objOpportunity:Trigger.New) {
			if (objOpportunity.StageName == 'CLOSED_WON' || objOpportunity.StageName == 'CLOSED_LOST') {
				objOpportunity.CloseDate = System.Today();
			}
		}
}
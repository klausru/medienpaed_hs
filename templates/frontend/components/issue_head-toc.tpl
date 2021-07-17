
<div class="container page-issue page-content">

	{* Display a message if no current issue exists *}
	{if !$issue}
		<div class="page-header page-issue-header">
			{include file="frontend/components/notification.tpl" messageKey="current.noCurrentIssueDesc"}
		</div>
		{else}
	{* Display an issue with the Table of Contents *}


		<div class="row justify-content-center page-issue-details">
			{if $issueGalleys || $issue->hasDescription() || $issue->getLocalizedTitle()}
				<div class="col-lg-9">
					<div class="page-issue-description-wrapper">
						{if $issue->hasDescription() || $issue->getLocalizedTitle()}
							<div class="page-issue-description">
								<div class="h2">
								
		{* Indicate if this is only a preview *}
		{if !$issue->getPublished()}
			{include file="frontend/components/notification.tpl" messageKey="editor.issues.preview"}
		{/if}

		{if $issue->getIssueSeries()}
			{$issue->getIssueSeries()|escape}: 
			{/if}								
								
								
									{if $issue->getLocalizedTitle()}
										{$issue->getLocalizedTitle()}
									{else}
										{translate key="plugins.themes.medienpaed_hs.issueDescription"}
									{/if}
								</div>
								{$issue->getLocalizedDescription()|strip_unsafe_html}
							</div>
						{/if}

					</div>
					
						{if $issueGalleys}
							<div class="page-issue-galleys">
								<h2>{translate key="issue.fullIssue"}</h2>
								<div>{foreach from=$issueGalleys item=galley}
									{include file="frontend/objects/galley_link.tpl" parent=$issue purchaseFee=$currentJournal->getSetting('purchaseIssueFee') purchaseCurrency=$currentJournal->getSetting('currency')}
								{/foreach}
								</div>
							</div>
						{/if}			
			
			<div class="page-issue-date">
				{translate key="plugins.themes.medienpaed_hs.currentIssuePublished" date=$issue->getDatePublished()|date_format:$dateFormatShort}
			</div>

			{* PUb IDs (eg - DOI) *}
			{foreach from=$pubIdPlugins item=pubIdPlugin}
				{assign var=pubId value=$issue->getStoredPubId($pubIdPlugin->getPubIdType())}
				{if $pubId}
					{assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
					{if $doiUrl}
						{capture assign="pubId"}
							<a href="{$doiUrl}">{$doiUrl}</a>
						{/capture}
					{/if}
					<div class="page-issue-doi">
						{if $pubIdPlugin->getPubIdType() == 'doi'}
							{$pubId}
						{else}
							{translate key="plugins.themes.medienpaed_hs.issuePubId" pubIdType=$pubIdPlugin->getPubIdDisplayType()|escape pubId=$pubId}
						{/if}
					</div>
				{/if}
			{/foreach}					

				</div>
			{/if}
			
			{if $issue->getLocalizedCoverImageUrl()}
				<div class="col-lg-3">
					<a href="{url op="view" page="issue" path=$issue->getBestIssueId()}">
						<img class="img-fluid page-issue-cover" src="{$issue->getLocalizedCoverImageUrl()|escape}"{if $issue->getLocalizedCoverImageAltText() != ''} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
					</a>
				</div>
			{/if}
		</div><!-- .row -->

		<div class="row{if !$issue->getLocalizedDescription() || !$issue->getLocalizedCoverImageUrl()} issue-wrapper{/if}">
			<div class="col-12">
				{include file="frontend/objects/issue_toc.tpl" sectionHeading="h2"}
			</div>
		</div>
	{/if}
</div>


{**
 * templates/frontend/objects/issue_summary.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Issue which displays a summary for use in lists
 *
 * @uses $issue Issue The issue
 * @uses $heading string The HTML tag to use for each issue title.
 *}
{if $issue->getShowTitle() && $issue->getLocalizedTitle()}
	{assign var="showTitle" value=true}
{else}
	{assign var="showTitle" value=false}
{/if}


{capture assign="issueTitle"}
	{if $issue->getIssueSeries()}
		{$issue->getIssueSeries()|escape}
	{elseif $showTitle}
		{$issue->getLocalizedTitle()|escape}
	{else}
		{** probably can occur only in OJS versions prior to 3.1 *}
		{translate key="issue.issue"}
	{/if}
{/capture}

<div class="card issue-summary">

			{* Cover *}
{assign var=myvar value=1|mt_rand:50}
    
			
			{if ($issue->getData('isThemeIssue')) && (!in_array($issue->getVolume(), array(37, 20)))}
			<a href="{$baseUrl}/issue/view/{$issue->getBestIssueId()}">
                {** <img class="card-img-top page-issue-cover" src="http://localhost/public/journals/1/cover/cover_mountains{$issue->getVolume()}({$myvar}).svg" alt="{$issue->getLocalizedCoverImageAltText()|escape}"> *}
                {** The generative Cover plugin *}
                    {include file="frontend/objects/cover.tpl"}
            </a>

			
            {else}
            
            <a href="{$baseUrl}/issue/view/{$issue->getBestIssueId()}">
                <img class="card-img-top page-issue-cover" src="{$issue->getLocalizedCoverImageUrl()|escape}"{if $issue->getLocalizedCoverImageAltText() != ''} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
            </a>
			{/if}

			
			

{** backup Cover 
*	{if $issue->getLocalizedCoverImageUrl()}
*		<a href="{$baseUrl}/issue/view/{$issue->getBestIssueId()}">
*			<img class="card-img-top page-issue-cover" src="{$issue->getLocalizedCoverImageUrl()|escape}"{if $issue->getLocalizedCoverImageAltText() != ''} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
*		</a>
*	{/if}
*}
 
 
 
<div class="card-body">
		<{$heading} class="h2 card-title issue-summary-series">
			<a href="{$baseUrl}/issue/view/{$issue->getBestIssueId()}">
				{$issueTitle|escape}
			</a>
		</{$heading}>
		{if $showTitle || $issue->getDatePublished()}
			<div class="card-text">
				{if $issue->getDatePublished()}
					<p class="issue-summary-date">{$issue->getDatePublished()|date_format:$dateFormatLong}</p>
				{/if}
				{if $issue->getIssueSeries() && $showTitle}
					<p class="issue-summary-title">{$issue->getLocalizedTitle()|escape}</p>
				{/if}
			</div>
		{/if}
	</div>
</div>

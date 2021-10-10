{extends file="{$parent_template_path}/productdetails/tabs.tpl"}


{block name='productdetails-tabs-tabs'}
    {container class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
        <nav class="tab-navigation">
        {tabs id="product-tabs"}
        {if $useDescription}
            {block name='productdetails-tabs-tab-description'}
                {tab title="{lang key="description" section="productDetails"}" active=$setActiveClass.description id="description"}
                    {block name='productdetails-tabs-tab-content'}
                        {block name='tab-description-media-types'}
                            {opcMountPoint id='opc_before_desc'}
                            <div class="desc">
                                <p>{$Artikel->cBeschreibung}</p>
                                {if $useDescriptionWithMediaGroup}
                                    {foreach $Artikel->getMediaTypes() as $mediaType}
                                        <div class="h3">{$mediaType->name}</div>
                                        <div class="media">
                                            {include file='productdetails/mediafile.tpl'}
                                        </div>
                                    {/foreach}
                                {/if}
                            </div>
                            {opcMountPoint id='opc_after_desc'}
                        {/block}
                        {block name='productdetails-tabs-tab-description-include-attributes'}
                            {include file='productdetails/attributes.tpl' tplscope='details'
                            showProductWeight=$showProductWeight showShippingWeight=$showShippingWeight
                            dimension=$dimension showAttributesTable=$showAttributesTable}
                        {/block}
                    {/block}
                {/tab}
            {/block}
        {/if}

        {if $useDownloads}
            {block name='productdetails-tabs-tab-downloads'}
                {tab title="{lang section="productDownloads" key="downloadSection"}" active=$setActiveClass.downloads id="downloads"}
                    {opcMountPoint id='opc_before_download'}
                    {include file='productdetails/download.tpl'}
                    {opcMountPoint id='opc_after_download'}
                {/tab}
            {/block}
        {/if}

        {if !empty($separatedTabs)}
            {block name='productdetails-tabs-tab-separated-tabs'}
                {foreach $separatedTabs as $separatedTab}
                    {tab title=$separatedTab.name active=$setActiveClass.separatedTabs && $separatedTab@first id="{$separatedTab.name|@seofy}"}
                        {opcMountPoint id='opc_before_separated_'|cat:$separatedTab.id}
                        {$separatedTab.content}
                        {opcMountPoint id='opc_after_separated_'|cat:$separatedTab.id}
                    {/tab}
                {/foreach}
            {/block}
        {/if}

        {if $useVotes}
            {block name='productdetails-tabs-tab-votes'}
                {tab title="{lang key='Votes'}" active=$setActiveClass.votes id="votes"}
                    {opcMountPoint id='opc_before_tab_votes'}
                    {include file='productdetails/reviews.tpl' stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt}
                    {opcMountPoint id='opc_after_tab_votes'}
                {/tab}
            {/block}
        {/if}

        {if $useQuestionOnItem}
            {block name='productdetails-tabs-tab-question-on-item'}
                {tab title="{lang key="productQuestion" section="productDetails"}" active=$setActiveClass.questionOnItem id="questionOnItem"}
                    {opcMountPoint id='opc_before_tab_question'}
                    {include file='productdetails/question_on_item.tpl' position="tab"}
                    {opcMountPoint id='opc_after_tab_question'}
                {/tab}
            {/block}
        {/if}

        {if $usePriceFlow}
            {block name='productdetails-tabs-tab-price-flow'}
                {tab title="{lang key='priceFlow' section='productDetails'}" active=$setActiveClass.priceFlow id="priceFlow"}
                    {opcMountPoint id='opc_before_tab_price_history'}
                    {include file='productdetails/price_history.tpl'}
                    {opcMountPoint id='opc_after_tab_price_history'}
                {/tab}
            {/block}
        {/if}

        {if $useAvailabilityNotification}
            {block name='productdetails-tabs-tab-availability-notification'}
                {tab title="{lang key='notifyMeWhenProductAvailableAgain'}" active=$setActiveClass.availabilityNotification id="availabilityNotification"}
                    {opcMountPoint id='opc_before_tab_availability'}
                    {include file='productdetails/availability_notification_form.tpl' position='tab' tplscope='artikeldetails'}
                    {opcMountPoint id='opc_after_tab_availability'}
                {/tab}
            {/block}
        {/if}

        {if $useMediaGroup}
            {block name='productdetails-tabs-tab-mediagroup'}
                {foreach $Artikel->getMediaTypes() as $mediaType}
                    {$cMedienTypId = $mediaType->name|@seofy}
                    {tab title="{$mediaType->name} ({$mediaType->count})" active=$setActiveClass.mediaGroup && $mediaType@first id="{$cMedienTypId}"}
                        {include file='productdetails/mediafile.tpl'}
                    {/tab}
                {/foreach}
            {/block}
        {/if}
{* WSC Musteranfrage in Tabs START *}
            {tab title="{lang key='wsc_Musteranfrage' section='productDetails'}" active=$setActiveClass.availabilityNotification id="availabilityNotification"}
                <div class="col-12 col-sm-12 col-md-10 col-lg-8 col-xl-8 offset-md-1 offset-lg-2 offset-xl-2">
                    <a href="/Kontakt" class="btn btn-primary btn-lg btn-block m-3 popup">{lang key='wsc_Musteranfrage' section='productDetails'}</a>
                    <p class="mx-3 text-center">{lang key='wsc_MusteranfrageDetail' section='productDetails'}</p>
                </div>
            {/tab}
{* WSC Musteranfrage in Tabs ENDE *}
        {/tabs}
        </nav>
    {/container}
{/block}

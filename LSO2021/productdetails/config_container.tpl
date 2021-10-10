{extends file="{$parent_template_path}/productdetails/config_container.tpl"}

{block name='productdetails-config-container'}
    {block name='productdetails-config-container-main'}
        <div id="cfg-container" class="w-100"> {* WSC Modal nun DIV START*}

            <div class="container">
                <div class="tab-content" id="cfg-container-tab-panes">
                    <div class="tab-pane fade show active" id="cfg-tab-pane-options" role="tabpanel" aria-labelledby="cfg-tab-options">
                        {block name='productdetails-config-container-options'}
                            {include file='productdetails/config_options.tpl'}
                        {/block}
                    </div>
                    <div class="tab-pane fade" id="cfg-tab-pane-summary" role="tabpanel" aria-labelledby="cfg-tab-summary">
                        {block name='productdetails-config-container-include-config-sidebar'}
                            {include file='productdetails/config_sidebar.tpl'}
                        {/block}
                    </div>
                </div>
            </div>

            <div class="container">
{* WSC Noch einen DIV mit COL-12 START *}
                <div class="col-12">
                    {nav id="cfg-modal-tabs" pills=true fill=true role="tablist"}
                        {navitem id="cfg-tab-options" active=true
                            href="#cfg-tab-pane-options" role="tab" router-data=["toggle"=>"pill"]
                            router-aria=["controls"=>"cfg-tab-pane-options", "selected"=>"true"]
                        }
                            <i class="fas fa-cogs"></i> <span class="nav-link-text">{lang key='configComponents' section='productDetails'}</span>
                        {/navitem}
                        {navitem id="cfg-tab-summary"
                            href="#cfg-tab-pane-summary" role="tab" router-data=["toggle"=>"pill"]
                            router-aria=["controls"=>"cfg-tab-pane-summary", "selected"=>"false"]
                        }
                            <i class="fas fa-cart-plus"></i> <span class="nav-link-text">{lang key='yourConfiguration'}</span>
{* WSC aus dem eusgeblendeten NAVITEM START *}
                            <strong id="cfg-price" class="price"></strong>&nbsp;<span class="footnote-reference">*</span>
{* WSC aus dem eusgeblendeten NAVITEM ENDE *}
                        {/navitem}
{* WSC Navitem ausblenden
                        {navitem href="#" disabled=true class="cfg-tab-total"}
                            weg
                        {/navitem}
*}
                    {/nav}
                </div>

{* WSC Noch einen DIV mit COL-12 ENDE *}
{* WSC Noch einen DIV mit COL-12 START *}
                <div class="col-12">
                    <div class="cfg-footnote small">
                        <span class="footnote-reference">*</span>{include file='snippets/shipping_tax_info.tpl' taxdata=$Artikel->taxData}
                    </div>
                </div>
{* WSC Noch einen DIV mit COL-12 ENDE *}
            </div>

        </div> {* WSC Modal nun DIV START*}
    {/block}
    {block name='productdetails-config-container-script'}
        {* WSC JS Script gelöscht *}
    {/block}
{/block}

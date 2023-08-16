<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "form">
       <div class="vnm-flex vnm-h-screen">
            <div class="vnm-hidden lg:vnm-block lg:vnm-w-2/3 vnm-h-screen vnm-relative"
                style="background: repeating-linear-gradient(-45deg, rgb(2, 19, 175), rgb(2, 19, 175) 10%, rgb(52, 89, 255) 10%, rgb(52, 89, 255) 20%);"
            >
                <img src="${url.resourcesPath}/img/vnm-text-white.svg"
                    class="vnm-absolute vnm-top-1/2 vnm-left-1/2 vnm-w-2/5 -vnm-translate-x-1/2 -vnm-translate-y-1/2"
                    alt=""
                />
            </div>
            <div class="vnm-w-full vnm-bg-white lg:vnm-w-1/3 vnm-flex vnm-flex-col">
                <div class="lg:vnm-w-3/4 vnm-bg-white vnm-mx-auto vnm-my-10 vnm-flex vnm-flex-1 vnm-flex-col vnm-justify-center vnm-items-start">
                    <div class="vnm-mb-5">
                        <div class="vnm-text-2xl vnm-text-main vnm-font-extrabold vnm-uppercase">
                             ${msg("pageExpiredTitle")}
                        </div>
                    </div>
                    <div class="vnm-flex vnm-w-full vnm-flex-col vnm-gap-4">
                         <p id="instruction1" class="instruction">
                            ${msg("pageExpiredMsg1")} <a id="loginRestartLink" class="vnm-text-main vnm-underline" href="${url.loginRestartFlowUrl}">${msg("doClickHere")}</a> .<br/>
                            ${msg("pageExpiredMsg2")} <a id="loginContinueLink" class="vnm-text-main vnm-underline" href="${url.loginAction}">${msg("doClickHere")}</a> .
                        </p>
                    </div>
                </div>
                <div class="vnm-bg-neutral-100 vnm-p-4 vnm-text-center vnm-text-xs">© Copyright 2023 by Vinamilk.</div>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>
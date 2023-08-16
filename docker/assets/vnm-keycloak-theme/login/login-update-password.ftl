<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>
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
                        <div class="vnm-text-3xl vnm-text-main vnm-font-extrabold vnm-uppercase">
                            ${msg("updatePasswordTitle")}
                        </div>
                    </div>

                </div>
                <div class="vnm-bg-neutral-100 vnm-p-4 vnm-text-center vnm-text-xs">© Copyright 2023 by Vinamilk.</div>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>

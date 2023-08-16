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
                <div class="vnm-flex vnm-w-full vnm-flex-col vnm-gap-4">
                    <div id="kc-form">
                        <div id="kc-form-wrapper">
                            <form id="kc-passwd-update-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
                                <input type="text" id="username" name="username" value="${username}" autocomplete="username"
                                    readonly="readonly" style="display:none;"/>
                                <input type="password" id="password" name="password" autocomplete="current-password" style="display:none;"/>

                                <div class="vnm-col-span-12 vnm-mt-4">
                                    <div class="${properties.kcFormGroupClass!}">
                                        <div class="${properties.kcInputWrapperClass!}">
                                            <div class="rs-input-group rs-input-group-inside">
                                                <input placeholder="${msg("passwordNew")}" type="password" id="password-new" name="password-new" class="rs-input ${properties.kcInputClass!}"
                                                    autofocus autocomplete="new-password"
                                                    aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"
                                                />
                                            </div>
                                            <#if messagesPerField.existsError('password')>
                                                <span id="input-error-password" class="vnm-text-red-500 dark:vnm-text-red-400 vnm-pt-0.5 vnm-text-xs ${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                                    ${kcSanitize(messagesPerField.get('password'))?no_esc}
                                                </span>
                                            </#if>
                                        </div>
                                    </div>
                                </div>
                                <div class="vnm-col-span-12 vnm-mt-4">
                                    <div class="${properties.kcFormGroupClass!}">
                                        <div class="${properties.kcInputWrapperClass!}">
                                            <input type="password" id="password-confirm" name="password-confirm"
                                                class="rs-input ${properties.kcInputClass!}"
                                                placeholder="${msg("passwordConfirm")}"
                                                autocomplete="new-password"
                                                aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                                            />
                                            <#if messagesPerField.existsError('password-confirm')>
                                                <span id="input-error-password-confirm" class="vnm-text-red-500 dark:vnm-text-red-400 vnm-pt-0.5 vnm-text-xs ${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                                    ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                                                </span>
                                            </#if>

                                        </div>
                                    </div>
                                </div>

                                <div class="${properties.kcFormGroupClass!}">
                                    <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                                        <div class="vnm-mt-4 ${properties.kcFormOptionsWrapperClass!}">
                                            <div class="checkbox">
                                                <label><input type="checkbox" id="logout-sessions" name="logout-sessions" value="on" checked> ${msg("logoutOtherSessions")}</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div id="kc-form-buttons" class="vnm-mt-4 ${properties.kcFormButtonsClass!}">
                                        <#if isAppInitiatedAction??>
                                            <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}" />
                                            <button class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" type="submit" name="cancel-aia" value="true" />${msg("doCancel")}</button>
                                        <#else>
                                            <input class="rs-btn rs-btn-primary rs-btn-block ${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}" />
                                        </#if>
                                    </div>
                                </div>
                            </form>
            </div>
        <div class="vnm-bg-neutral-100 vnm-p-4 vnm-text-center vnm-text-xs">© Copyright 2023 by Vinamilk.</div>
        </div>
        </div>
         </div>
    </#if>
</@layout.registrationLayout>

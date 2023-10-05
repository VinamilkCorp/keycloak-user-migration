<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
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
                        ${msg("emailForgotTitle")}
                    </div>
                </div>
                <div class="vnm-flex vnm-w-full vnm-flex-col vnm-gap-4">
                    <div id="kc-form">
                        <div id="kc-form-wrapper">
                                <form id="kc-reset-password-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
                                    <div class="${properties.kcFormGroupClass!}">
                                        <div class="${properties.kcLabelWrapperClass!}">
                                            <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>
                                        </div>
                                        <div class="${properties.kcInputWrapperClass!}">
                                            <input type="text" id="username" name="username" class="${properties.kcInputClass!}" autofocus value="${(auth.attemptedUsername!'')}" aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"/>
                                            <#if messagesPerField.existsError('username')>
                                                <span id="input-error-username" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                                            ${kcSanitize(messagesPerField.get('username'))?no_esc}
                                                </span>
                                            </#if>
                                        </div>
                                    </div>
                                    <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                                        <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                                            <div class="${properties.kcFormOptionsWrapperClass!}">
                                                <span><a href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a></span>
                                            </div>
                                        </div>

                                        <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                                            <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}"/>
                                        </div>
                                    </div>
                                </form>
                        </div>
                    </div>
            </div>
        </div>
        <div class="vnm-bg-neutral-100 vnm-p-4 vnm-text-center vnm-text-xs">© Copyright 2023 by Vinamilk.</div>
        </div>
    </#if>
    <#elseif section = "info" >
        <#if realm.duplicateEmailsAllowed>
            ${msg("emailInstructionUsername")}
        <#else>
            ${msg("emailInstruction")}
        </#if>
    </#if>
</@layout.registrationLayout>

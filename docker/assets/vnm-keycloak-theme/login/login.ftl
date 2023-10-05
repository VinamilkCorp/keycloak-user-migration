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
                    ${msg("loginAccountTitle")}
                </div>
            </div>
            <div class="vnm-flex vnm-w-full vnm-flex-col vnm-gap-4">
                <div id="kc-form">
                    <div id="kc-form-wrapper">
                        <#if realm.password>
                            <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                                <#if !usernameHidden??>
                                    <div class="vnm-col-span-12 vnm-mt-4">
                                        <div class="${properties.kcFormGroupClass!}">
                                            <div class="rs-input-group rs-input-group-inside">
                                                <input placeholder="<#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>" tabindex="1" id="username" class="rs-input ${properties.kcInputClass!}" name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="off"
                                                    aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                                />
                                            </div>
                                            <#if messagesPerField.existsError('username','password')>
                                                    <span id="input-error" class="vnm-text-red-500 dark:vnm-text-red-400 vnm-pt-0.5 vnm-text-xs ${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                                            ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                                    </span>
                                            </#if>
                                        </div>
                                    </div>
                                </#if>
                                <div class="vnm-col-span-12 vnm-mt-4">
                                    <div class="${properties.kcFormGroupClass!}">
                                        <div class="rs-input-group rs-input-group-inside">
                                            <input placeholder="${msg("password")}" tabindex="2" id="password" class="rs-input ${properties.kcInputClass!}" name="password" type="password" autocomplete="off"
                                                aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                            />

                                            <#if usernameHidden?? && messagesPerField.existsError('username','password')>
                                                <span id="input-error" class="vnm-text-red-500 dark:vnm-text-red-400 vnm-pt-0.5 vnm-text-xs ${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                                        ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                                </span>
                                            </#if>
                                        </div>
                                    </div>
                                </div>
                                <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                                    <div id="kc-form-options">
                                        <#if realm.rememberMe && !usernameHidden??>
                                            <div class="checkbox">
                                                <label>
                                                    <#if login.rememberMe??>
                                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                                                    <#else>
                                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                                                    </#if>
                                                </label>
                                            </div>
                                        </#if>
                                        </div>
                                        <div class="${properties.kcFormOptionsWrapperClass!}">
                                            <#if realm.resetPasswordAllowed>
                                                <div class="vnm-text-sm vnm-mt-2"><a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></div>
                                            </#if>
                                        </div>
                                </div>
                                <div id="kc-form-buttons" class="vnm-mt-4 ${properties.kcFormGroupClass!}">
                                    <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                                    <input tabindex="4" class="rs-btn rs-btn-primary rs-btn-block ${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                                </div>
                            </form>
                        </#if>
                    </div>
                </div>
                 <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                    <div id="kc-registration-container">
                        <div id="kc-registration">
                            <span>${msg("noAccount")} <a tabindex="6"
                                                        href="${url.registrationUrl}">${msg("doRegister")}</a></span>
                        </div>
                    </div>
                </#if>
                <#if realm.password && social.providers??>
                    <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                        <div class="vnm-text-center">
                            <div class="vnm-text-sm">${msg("identity-provider-login-label")}</div>
                            <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                                <#list social.providers as p>
                                    <li>
                                        <a id="social-${p.alias}" class="rs-btn rs-btn-ghost rs-btn-block vnm-mt-4 vnm-font-bold ${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                                                type="button" href="${p.loginUrl}">
                                            <#if p.iconClasses?has_content>
                                                <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                                <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                                            <#else>
                                                <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                                            </#if>
                                        </a>
                                    </li>
                                </#list>
                            </ul>
                        </div>
                    </div>
                </#if>
        </div>
    </div>
      <div class="vnm-bg-neutral-100 vnm-p-4 vnm-text-center vnm-text-xs">© Copyright 2023 by Vinamilk.</div>
    </div>
    </#if>

</@layout.registrationLayout>

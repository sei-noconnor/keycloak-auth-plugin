<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=true displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "form">
        <#if realm.loginWithEmailAllowed>
            <form onsubmit="login.disabled=true;return true;" action="${url.loginAction}" method="post">
                <div class="form-group">
                    <label class="form-label" for="username">
                        <#if !realm.loginWithEmailAllowed>${msg("username")}
                        <#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}
                        <#else>${msg("email")}</#if>
                    </label>
                    <input tabindex="1" id="username" class="form-control " name="username"
                            value="${(login.username!'')}" type="text" autofocus autocomplete="off"/>
                </div>
                <div class="form-group">
                    <label for="password" class="form-label">${msg("password")}</label>
                    <input tabindex="2" id="password" class="form-control " name="password"
                            type="password" autocomplete="off"/>
                </div>

                <div class="form-group text-right">
                    <#if realm.resetPasswordAllowed>
                        <a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
                    </#if>
                </div>

                <div id="form-buttons" class="form-group">
                    <input type="hidden" id="id-hidden-input" name="credentialId"
                            <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                    <input tabindex="4"
                            class="btn btn-primary btn-block"
                            name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                </div>

            </form>
        <#else>
            Form Login is disabled, Please register a CAC or softcert.
        </#if>
        
        <div class="footer-text">
            No account? <a href="${url.registrationUrl}">Click here</a> to register now.<br>
            <a id="helpdesk" href="mailto:info@sei.cmu.edu">email us</a>
        </div>
        
    </#if>

</@layout.registrationLayout>

<script>

  (function () {
    // let errorDiv;
    let regLink;
    // Remove html encoded special characters
    <#if cacIdentity??>
      regLink = document.getElementById('registration-link');
      regLink.classList.add('display-none');
    <#else>
      // errorDiv = document.getElementById('kc-error-message');
      // errorDiv.classList.add('display-none');
      console.log('CACIdentity does NOT have content')
      regLink = document.getElementById('registration-link');
      regLink.classList.add('display-none');
    </#if>
  }());

  const feedback = document.getElementById('alert-error');
  if (feedback && feedback.innerHTML.indexOf('X509 certificate') > -1 && feedback.innerHTML.indexOf('Invalid user') > -1) {
      feedback.outerHTML = [
          '<div class="alert alert-info cac-info">',
          '<h2>New DoD PKI Detected</h2>',
          '<div style="line-height: 2rem;">If you do not have an account yet, <a href="${url.registrationUrl}">click to register</a> now.',
          '</div></div>'
      ].join('');
  }
</script>
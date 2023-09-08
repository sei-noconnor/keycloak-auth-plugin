<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "form">
        <form id="kc-x509-login-info" class="" action="${url.loginAction}" method="post">
            <div class="form-group">

                <div class="alert alert-info cac-info">
                    <h2>DoD PKI Detected</h2>
                    <#if x509.formData.subjectDN??>
                        <p id="certificate_subjectDN" class="">${(x509.formData.subjectDN!"")}</p>
                    <#else>
                        <p id="certificate_subjectDN" class="">${msg("noCertificate")}</p>
                    </#if>
                </div>
            </div>

            <div class="form-group">

                <#if x509.formData.isUserEnabled??>
                    <label for="username" class="">${msg("doX509Login")}</label>
                    <label id="username" class="font-weight-bold">${(x509.formData.username!'')}</label>
                </#if>

            </div>

            <div class="form-group">
                <div id="kc-form-buttons" class="">
                    <div class="text-right">
                        <input class="btn btn-primary" name="login" id="kc-login" type="submit" value="${msg("doContinue")}" autofocus />
                        <#if x509.formData.isUserEnabled??>
                            <input class="btn btn-light" name="cancel" id="kc-cancel" type="submit" value="${msg("doIgnore")}" />
                        </#if>
                    </div>
                </div>
            </div>
        </form>
    </#if>

</@layout.registrationLayout>
<script>

  (function () {
    let regLink;
    <#if cacIdentity??>
      
      regLink = document.getElementById('registration-link');
      regLink.classList.add('display-none');
    <#else>
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
          '<div style="line-height: 2rem;">If you do not have an account yet, <a href="${url.registrationUrl}">click to register</a> now.  Otherwise, please login with your username/password to associate this CAC with your existing account.',
          '</div></div>'
      ].join('');
  }

</script>
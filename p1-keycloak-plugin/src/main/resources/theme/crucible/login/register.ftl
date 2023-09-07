<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('firstName','lastName','email','username','password','password-confirm'); section>
    <#if section = "form">
        <form action="/chuck-norris-calendar-goes-straight-from-march-31st-to-april-2nd-because-no-one-fools-chuck-norris"
              id="baby-yoda-form" method="post">

            <#if cacIdentity??>
                <div class="alert alert-info cac-info">
                    <h2>DoD PKI User Registration</h2>
                    <p>${cacIdentity}</p>
                </div>
            <#else>
                <div class="alert alert-info cac-info">
                    <h2>Regular User Registration</h2>
                    <p>Use your company or government email address as your access will be based off of your validated email address.</p>
                    <p class="font-weight-bold">For assistance contact your team admin, <a
                                href="https://sso-info.il2.dso.mil/" target="_blank">click here</a> or <a id="helpdesk"
                                                                                                          href="mailto:help@dsop.io">email us</a>.
                    </p>
                </div>
            </#if>

            <div class="row">
                <div class="col-lg-6 form-group ${messagesPerField.printIfExists('firstName','has-error')}">
                    <label for="firstName" class="form-label">${msg("firstName")}</label>
                    <input <#if cacIdentity??> readonly </#if> type="text" id="firstName" class="form-control" name="firstName"
                           value="${(register.formData.firstName!'')}"/>
                    <#if messagesPerField.existsError('firstName')>
                        <span class="message-details" aria-live="polite">${kcSanitize(messagesPerField.get('firstName'))?no_esc}</span>
                    </#if>
                </div>

                <div class="col-lg-6 form-group ${messagesPerField.printIfExists('lastName','has-error')}">
                    <label for="lastName" class="form-label">${msg("lastName")}</label>
                    <input <#if cacIdentity??> readonly </#if> type="text" id="lastName" class="form-control" name="lastName"
                            value="${(register.formData.lastName!'')}"/>
                    <#if messagesPerField.existsError('lastName')>
                        <span class="message-details" aria-live="polite">${kcSanitize(messagesPerField.get('lastName'))?no_esc}</span>
                    </#if>
                </div>

            </div>

            <div class="row" <#if cacIdentity??>style="display: none;"</#if>>

                <div class="col-lg-6 form-group ${messagesPerField.printIfExists('user.attributes.affiliation','has-error')}">
                    <label for="user.attributes.affiliation" class="form-label">Affiliation</label>
                    <select <#if cacIdentity??> readonly </#if> id="user.attributes.affiliation" name="user.attributes.affiliation" class="form-control">
                      <option selected>FFRDC</option>
                    </select>
                    <#if messagesPerField.existsError('user.attributes.affiliation')>
                        <span class="message-details" aria-live="polite">${kcSanitize(messagesPerField.get('user.attributes.affiliation'))?no_esc}</span>
                    </#if>  
                </div>

                <div class="col-lg-6 form-group ${messagesPerField.printIfExists('user.attributes.rank','has-error')}">
                    <label for="user.attributes.rank" class="form-label">Pay Grade</label>
                    <select <#if cacIdentity??> readonly </#if> id="user.attributes.rank" name="user.attributes.rank" class="form-control">
                        <option value="N/A" selected>N/A</option>
                    </select>
                    <#if messagesPerField.existsError('user.attributes.rank')>
                        <span class="message-details" aria-live="polite">${kcSanitize(messagesPerField.get('user.attributes.rank'))?no_esc}</span>
                    </#if>                      
                </div>

            </div>

            <div class="form-group ${messagesPerField.printIfExists('user.attributes.organization','has-error')}" <#if cacIdentity??>style="display: none;"</#if>>
                <label for="user.attributes.organization" class="form-label">Unit, Organization or Company Name</label>
                <input <#if cacIdentity??> readonly </#if> id="user.attributes.organization" class="form-control" name="user.attributes.organization" type="text"
                        value="${(register.formData['user.attributes.organization']!'SEI')}" autocomplete="company"/>
                <#if messagesPerField.existsError('user.attributes.organization')>
                    <span class="message-details" aria-live="polite">${kcSanitize(messagesPerField.get('user.attributes.organization'))?no_esc}</span>
                </#if>                    
            </div>
            <div class="location-input">
                <div class="form-group">
                    <label for="user.attributes.location" class="form-label">Location</label>
                    <input id="user.attributes.location" class="form-control" name="user.attributes.location" tabindex="-1 type="text" />
                </div>
            </div>

            <#if !realm.registrationEmailAsUsername>
                <div class="form-group ${messagesPerField.printIfExists('username','has-error')}">
                    <label for="username" class="form-label">${msg("username")}</label>
                    <input id="username" class="form-control" name="username" type="text"
                            value="${(register.formData.username!'')}" autocomplete="username"/>
                    <#if messagesPerField.existsError('username')>
                        <span class="message-details" aria-live="polite">${kcSanitize(messagesPerField.get('username'))?no_esc}</span>
                    </#if>    
                </div>
            </#if>

            <div class="form-group ${messagesPerField.printIfExists('email','has-error')}">
                <label for="email" class="form-label">${msg("email")}</label>
                <input id="email" class="form-control" name="email" type="text"
                        value="${(register.formData.email!'')}" autocomplete="email"/>
                <#if messagesPerField.existsError('email')>
                    <span class="message-details" aria-live="polite">${kcSanitize(messagesPerField.get('email'))?no_esc}</span>
                </#if>                    
            </div>
            <#if !cacIdentity??>
            <div class="form-group ${messagesPerField.printIfExists('notes','has-error')}">
                <label for="user.attributes.notes" class="form-label ">${msg("accessRequest")}</label>
                <textarea id="user.attributes.notes" class="form-control " name="user.attributes.notes"></textarea>
            </div>                       
            </#if>
            
            <div class="form-group ${messagesPerField.printIfExists('password','has-error')}" <#if cacIdentity??> style="display: none;" </#if>>
                <#if cacIdentity??>
                    <div class="alert alert-info cac-info">
                        ${msg("passwordCacMessage1")}
                        <span class="note-important">${msg("passwordCacMessage2")}</span>
                        ${msg("passwordCacMessage3")}
                    </div>
                    <label for="password" class="form-label ">${msg("passwordOptional")}</label>
                <#else>
                    <label for="password" class="form-label ">${msg("password")}</label>
                </#if>
                <input id="password" class="form-control " name="password"
                        type="password" autocomplete="new-password"/>
                <#if messagesPerField.existsError('password')>
                    <span class="message-details" aria-live="polite">${kcSanitize(messagesPerField.get('password'))?no_esc}</span>
                </#if>                        
            </div>
            
            <div class="form-group ${messagesPerField.printIfExists('password-confirm','has-error')}" <#if cacIdentity??> style="display: none;" </#if>>
                <label for="password-confirm" class="form-label ">${msg("passwordConfirm")}</label>
                <input id="password-confirm" class="form-control " name="password-confirm"
                        type="password" autocomplete="new-password"/>
                <#if messagesPerField.existsError('password-confirm')>
                    <span class="message-details" aria-live="polite">${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}</span>
                </#if>                                                
            </div>
            
            <#if recaptchaRequired??>
                <div class="form-group">
                    <div>
                        <div class="g-recaptcha" data-theme="dark" data-size="normal"
                             data-sitekey="${recaptchaSiteKey}"></div>
                    </div>
                </div>
            </#if>

            <div class="form-group">
                <div id="kc-form-buttons">
                    <input id="do-register" disabled="disabled"
                           class="btn btn-primary btn-block"
                           type="submit" value="${msg("doRegister")}"/>
                </div>
            </div>

        </form>

        <div class="footer-text" id="footer-text">
            You must be a human to register, confidence is increased as you interact with this page.
            <br><br>
            <a>Currently only <span id="confidence">1</span>% convinced you're not a robot.</a>
        </div>

    </#if>
</@layout.registrationLayout>

<script>
    //document.getElementById('user.attributes.affiliation').value = "${(register.formData['user.attributes.affiliation']!'')}";
    //document.getElementById('user.attributes.rank').value = "${(register.formData['user.attributes.rank']!'')}";

    (function () {
        const threshold = 50;
        let count = 0;
        let complete = false;
        let regLink;
        // Remove html encoded special characters
        <#if cacIdentity??>
          let safeCacIdentity = "${cacIdentity}".replace(/(.+)(&#.+;)/gi, '\$1');
          let lastName = safeCacIdentity.split('.')[0];
          let firstName = safeCacIdentity.split('.')[1];
          // Remove any special characters.
          firstName = firstName.replace(/[^\w\s]/gi, '');
          lastName = lastName.replace(/[^\w\s]/gi, '');
          // Set form fields
          regLink = document.getElementById('registration-link');
          regLink.classList.add('display-none');
          document.getElementById('firstName').value = firstName;
          document.getElementById('lastName').value = lastName;
          if (!${(realm.registrationEmailAsUsername?c)}) {
          document.getElementById('username').value = firstName + "." + lastName;
        }
        <#else>
          console.log('CACIdentity does NOT have content')
          regLink = document.getElementById('registration-link');
          reglink.classList.remove('display-none');
        </#if>
        
        window.onload = tracker;
        window.onmousemove = tracker;
        window.onmousedown = tracker;
        window.ontouchstart = tracker;
        window.onclick = tracker;
        window.onkeypress = tracker;
        window.addEventListener('scroll', tracker, true);

        const confidence = document.getElementById('confidence');
        const footer = document.getElementById('footer-text');

        function tracker() {
            if (complete) {
                return;
            }

            count++;
            confidence.innerText = Math.round((count / threshold) * 100);

            if (count > threshold) {
                complete = true;

                const form = document.getElementById('baby-yoda-form');
                const register = document.getElementById('do-register');
                const location = document.getElementById('user.attributes.location');

                location.value = '42';
                footer.parentNode.removeChild(footer);
                form.setAttribute('action', '${url.registrationAction?no_esc}');
                register.removeAttribute('disabled');
            }
        }
    }());
</script>
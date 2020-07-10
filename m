Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726872AbgGJS4Q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Jul 2020 14:56:16 -0400
Message-ID: <1594407288.14405.36.camel@linux.ibm.com>
Subject: Re: [PATCH v5] ima: move APPRAISE_BOOTPARAM dependency on
 ARCH_POLICY to runtime
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 10 Jul 2020 14:54:48 -0400
In-Reply-To: <20200710183420.GB10547@glitch>
References: <20200709164647.45153-1-bmeneg@redhat.com>
         <1594401804.14405.8.camel@linux.ibm.com> <20200710180338.GA10547@glitch>
         <20200710183420.GB10547@glitch>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Bruno Meneguele <bmeneg@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org, erichte@linux.ibm.com, nayna@linux.ibm.com, stable@vger.kernel.org

On Fri, 2020-07-10 at 15:34 -0300, Bruno Meneguele wrote:
> On Fri, Jul 10, 2020 at 03:03:38PM -0300, Bruno Meneguele wrote:
> > On Fri, Jul 10, 2020 at 01:23:24PM -0400, Mimi Zohar wrote:
> > > On Thu, 2020-07-09 at 13:46 -0300, Bruno Meneguele wrote:
> > > > APPRAISE_BOOTPARAM has been marked as dependent on !ARCH_POLICY in compile
> > > > time, enforcing the appraisal whenever the kernel had the arch policy option
> > > > enabled.
> > > 
> > > > However it breaks systems where the option is set but the system didn't
> > > > boot in a "secure boot" platform. In this scenario, anytime an appraisal
> > > > policy (i.e. ima_policy=appraisal_tcb) is used it will be forced, without
> > > > giving the user the opportunity to label the filesystem, before enforcing
> > > > integrity.
> > > > 
> > > > Considering the ARCH_POLICY is only effective when secure boot is actually
> > > > enabled this patch remove the compile time dependency and move it to a
> > > > runtime decision, based on the secure boot state of that platform.
> > > 
> > > Perhaps we could simplify this patch description a bit?
> > > 
> > > The IMA_APPRAISE_BOOTPARAM config allows enabling different
> > > "ima_appraise=" modes - log, fix, enforce - at run time, but not when
> > > IMA architecture specific policies are enabled.  This prevents
> > > properly labeling the filesystem on systems where secure boot is
> > > supported, but not enabled on the platform.  Only when secure boot is
> > > enabled, should these IMA appraise modes be disabled.
> > > 
> > > This patch removes the compile time dependency and makes it a runtime
> > > decision, based on the secure boot state of that platform.
> > > 
> > 
> > Sounds good to me.
> > 
> > > <snip>
> > > 
> > > > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> > > > index a9649b04b9f1..884de471b38a 100644
> > > > --- a/security/integrity/ima/ima_appraise.c
> > > > +++ b/security/integrity/ima/ima_appraise.c
> > > > @@ -19,6 +19,11 @@
> > > >  static int __init default_appraise_setup(c
> > > 
> > > > har *str)
> > > >  {
> > > >  #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
> > > > +	if (arch_ima_get_secureboot()) {
> > > > +		pr_info("appraise boot param ignored: secure boot enabled");
> > > 
> > > Instead of a generic statement, is it possible to include the actual
> > > option being denied?  Perhaps something like: "Secure boot enabled,
> > > ignoring %s boot command line option"
> > > 
> > > Mimi
> > > 
> > 
> > Yes, sure.
> > 
> 
> Btw, would it make sense to first make sure we have a valid "str"
> option and not something random to print?
>  
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index a9649b04b9f1..1f1175531d3e 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -25,6 +25,16 @@ static int __init default_appraise_setup(char *str)
>                 ima_appraise = IMA_APPRAISE_LOG;
>         else if (strncmp(str, "fix", 3) == 0)
>                 ima_appraise = IMA_APPRAISE_FIX;
> +       else
> +               pr_info("invalid \"%s\" appraise option");
> +
> +       if (arch_ima_get_secureboot()) {
> +               if (!is_ima_appraise_enabled()) {
> +                       pr_info("Secure boot enabled: ignoring ima_appraise=%s boot parameter option",
> +                               str);
> +                       ima_appraise = IMA_APPRAISE_ENFORCE;
> +               }
> +       }

Providing feedback is probably a good idea.  However, the
"arch_ima_get_secureboot" test can't come after setting
"ima_appraise."

Mimi

>  #endif
>         return 1;
>  }
> 
> 
> The "else" there I think would make sense as well, at least to give the
> user some feedback about a possible mispelling of him (as a separate
> patch).
> 
> And "if(!is_ima_appraise_enabled())" would avoid to print anything about
> "ignoring the option" to the user in case he explicitly set "enforce",
> which we know there isn't any real effect but is allowed and shown in
> kernel-parameters.txt.
> 
> > Thanks!
> > 
> > > > +		return 1;
> > > > +	}
> > > > +
> > > >  	if (strncmp(str, "off", 3) == 0)
> > > >  		ima_appraise = 0;
> > > >  	else if (strncmp(str, "log", 3) == 0)
> > > 
> > 
> > -- 
> > bmeneg 
> > PGP Key: http://bmeneg.com/pubkey.txt
> 
> 
> 

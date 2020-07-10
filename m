Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726950AbgGJRXm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Jul 2020 13:23:42 -0400
Message-ID: <1594401804.14405.8.camel@linux.ibm.com>
Subject: Re: [PATCH v5] ima: move APPRAISE_BOOTPARAM dependency on
 ARCH_POLICY to runtime
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 10 Jul 2020 13:23:24 -0400
In-Reply-To: <20200709164647.45153-1-bmeneg@redhat.com>
References: <20200709164647.45153-1-bmeneg@redhat.com>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Bruno Meneguele <bmeneg@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org
Cc: erichte@linux.ibm.com, nayna@linux.ibm.com, stable@vger.kernel.org

On Thu, 2020-07-09 at 13:46 -0300, Bruno Meneguele wrote:
> APPRAISE_BOOTPARAM has been marked as dependent on !ARCH_POLICY in compile
> time, enforcing the appraisal whenever the kernel had the arch policy option
> enabled.

> However it breaks systems where the option is set but the system didn't
> boot in a "secure boot" platform. In this scenario, anytime an appraisal
> policy (i.e. ima_policy=appraisal_tcb) is used it will be forced, without
> giving the user the opportunity to label the filesystem, before enforcing
> integrity.
> 
> Considering the ARCH_POLICY is only effective when secure boot is actually
> enabled this patch remove the compile time dependency and move it to a
> runtime decision, based on the secure boot state of that platform.

Perhaps we could simplify this patch description a bit?

The IMA_APPRAISE_BOOTPARAM config allows enabling different
"ima_appraise=" modes - log, fix, enforce - at run time, but not when
IMA architecture specific policies are enabled.  This prevents
properly labeling the filesystem on systems where secure boot is
supported, but not enabled on the platform.  Only when secure boot is
enabled, should these IMA appraise modes be disabled.

This patch removes the compile time dependency and makes it a runtime
decision, based on the secure boot state of that platform.

<snip>

> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index a9649b04b9f1..884de471b38a 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -19,6 +19,11 @@
>  static int __init default_appraise_setup(c

> har *str)
>  {
>  #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
> +	if (arch_ima_get_secureboot()) {
> +		pr_info("appraise boot param ignored: secure boot enabled");

Instead of a generic statement, is it possible to include the actual
option being denied?  Perhaps something like: "Secure boot enabled,
ignoring %s boot command line option"

Mimi

> +		return 1;
> +	}
> +
>  	if (strncmp(str, "off", 3) == 0)
>  		ima_appraise = 0;
>  	else if (strncmp(str, "log", 3) == 0)

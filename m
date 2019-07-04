Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727385AbfGDKyi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Jul 2019 06:54:38 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x64Aqwjf128639
        for <linux-s390@vger.kernel.org>; Thu, 4 Jul 2019 06:54:37 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2thf08tjy9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 04 Jul 2019 06:54:36 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <prudo@linux.ibm.com>;
        Thu, 4 Jul 2019 11:54:35 +0100
Date: Thu, 4 Jul 2019 12:54:27 +0200
From: Philipp Rudo <prudo@linux.ibm.com>
Subject: Re: [PATCH v12 01/11] MODSIGN: Export module signature definitions
In-Reply-To: <87lfxel2q6.fsf@morokweng.localdomain>
References: <20190628021934.4260-1-bauerman@linux.ibm.com>
        <20190628021934.4260-2-bauerman@linux.ibm.com>
        <20190701144752.GC25484@linux-8ccs>
        <87lfxel2q6.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190704125427.31146026@laptop-ibm>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org>, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org

Hi Thiago,


On Thu, 04 Jul 2019 03:42:57 -0300
Thiago Jung Bauermann <bauerman@linux.ibm.com> wrote:

> Jessica Yu <jeyu@kernel.org> writes:
> 
> > +++ Thiago Jung Bauermann [27/06/19 23:19 -0300]:  
> >>IMA will use the module_signature format for append signatures, so export
> >>the relevant definitions and factor out the code which verifies that the
> >>appended signature trailer is valid.
> >>
> >>Also, create a CONFIG_MODULE_SIG_FORMAT option so that IMA can select it
> >>and be able to use mod_check_sig() without having to depend on either
> >>CONFIG_MODULE_SIG or CONFIG_MODULES.
> >>
> >>Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> >>Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> >>Cc: Jessica Yu <jeyu@kernel.org>
> >>---
> >> include/linux/module.h           |  3 --
> >> include/linux/module_signature.h | 44 +++++++++++++++++++++++++
> >> init/Kconfig                     |  6 +++-
> >> kernel/Makefile                  |  1 +
> >> kernel/module.c                  |  1 +
> >> kernel/module_signature.c        | 46 ++++++++++++++++++++++++++
> >> kernel/module_signing.c          | 56 +++++---------------------------
> >> scripts/Makefile                 |  2 +-
> >> 8 files changed, 106 insertions(+), 53 deletions(-)
> >>
> >>diff --git a/include/linux/module.h b/include/linux/module.h
> >>index 188998d3dca9..aa56f531cf1e 100644
> >>--- a/include/linux/module.h
> >>+++ b/include/linux/module.h
> >>@@ -25,9 +25,6 @@
> >> #include <linux/percpu.h>
> >> #include <asm/module.h>
> >>
> >>-/* In stripped ARM and x86-64 modules, ~ is surprisingly rare. */
> >>-#define MODULE_SIG_STRING "~Module signature appended~\n"
> >>-  
> >
> > Hi Thiago, apologies for the delay.  
> 
> Hello Jessica, thanks for reviewing the patch!
> 
> > It looks like arch/s390/kernel/machine_kexec_file.c also relies on
> > MODULE_SIG_STRING being defined, so module_signature.h will need to be
> > included there too, otherwise we'll run into a compilation error.  
> 
> Indeed. Thanks for spotting that. The patch below fixes it. It's
> identical to the previous version except for the changes in 
> arch/s390/kernel/machine_kexec_file.c and their description in the
> commit message. I'm also copying some s390 people in this email.

to me the s390 part looks good but for one minor nit.

In arch/s390/Kconfig KEXEC_VERIFY_SIG currently depends on
SYSTEM_DATA_VERIFICATION. I'd prefer when you update this to the new
MODULE_SIG_FORMAT. It shouldn't make any difference right now, as we don't
use mod_check_sig in our code path. But it could cause problems in the future,
when more code might be shared.

Thanks
Philipp

> > Other than that, the module-related changes look good to me:
> >
> > Acked-by: Jessica Yu <jeyu@kernel.org>  
> 
> Thank you very much!
> 

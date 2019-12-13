Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32658 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728552AbfLMTCk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 13 Dec 2019 14:02:40 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBDIrbSM019895
        for <linux-s390@vger.kernel.org>; Fri, 13 Dec 2019 14:02:38 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wurcs62d1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 13 Dec 2019 14:02:38 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 13 Dec 2019 19:02:36 -0000
Subject: Re: [PATCH resend] s390/purgatory: Make sure we fail the build if
 purgatory has missing symbols
References: <20191212205304.191610-1-hdegoede@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 13 Dec 2019 20:02:33 +0100
MIME-Version: 1.0
In-Reply-To: <20191212205304.191610-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <31fd8562-7591-ccc0-f170-4f2d3d0eb25a@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Philipp Rudo <prudo@linux.ibm.com>

Thanks applied.

Now that the build fixes have been merged I do not see a reasons to
defer this any longer.
I also added a Tested-by: Philipp Rudo <prudo@linux.ibm.com>
as he successfully tested v2 in October.



On 12.12.19 21:53, Hans de Goede wrote:
> Since we link purgatory with -r aka we enable "incremental linking"
> no checks for unresolved symbols are done while linking the purgatory.
> 
> This commit adds an extra check for unresolved symbols by calling ld
> without -r before running objcopy to generate purgatory.ro.
> 
> This will help us catch missing symbols in the purgatory sooner.
> 
> Note this commit also removes --no-undefined from LDFLAGS_purgatory
> as that has no effect.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Using 2 if_changed lines under a single rule does not work, then
>   1 of the 2 will always execute each build.
>   Instead add a new (unused) purgatory.chk intermediate which gets
>   linked from purgatory.ro without -r to do the missing symbols check
> - This also fixes the check generating an a.out file (oops)
> ---
>  arch/s390/purgatory/.gitignore |  1 +
>  arch/s390/purgatory/Makefile   | 13 ++++++++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/purgatory/.gitignore b/arch/s390/purgatory/.gitignore
> index 04a03433c720..c82157f46b18 100644
> --- a/arch/s390/purgatory/.gitignore
> +++ b/arch/s390/purgatory/.gitignore
> @@ -1,3 +1,4 @@
>  purgatory
> +purgatory.chk
>  purgatory.lds
>  purgatory.ro
> diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
> index bc0d7a0d0394..13e9a5dc0a07 100644
> --- a/arch/s390/purgatory/Makefile
> +++ b/arch/s390/purgatory/Makefile
> @@ -4,7 +4,7 @@ OBJECT_FILES_NON_STANDARD := y
>  
>  purgatory-y := head.o purgatory.o string.o sha256.o mem.o
>  
> -targets += $(purgatory-y) purgatory.lds purgatory purgatory.ro
> +targets += $(purgatory-y) purgatory.lds purgatory purgatory.chk purgatory.ro
>  PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
>  
>  $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
> @@ -26,15 +26,22 @@ KBUILD_CFLAGS += $(CLANG_FLAGS)
>  KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
>  KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
>  
> -LDFLAGS_purgatory := -r --no-undefined -nostdlib -z nodefaultlib -T
> +# Since we link purgatory with -r unresolved symbols are not checked, so we
> +# also link a purgatory.chk binary without -r to check for unresolved symbols.
> +PURGATORY_LDFLAGS := -nostdlib -z nodefaultlib
> +LDFLAGS_purgatory := -r $(PURGATORY_LDFLAGS) -T
> +LDFLAGS_purgatory.chk := -e purgatory_start $(PURGATORY_LDFLAGS)
>  $(obj)/purgatory: $(obj)/purgatory.lds $(PURGATORY_OBJS) FORCE
>  		$(call if_changed,ld)
>  
> +$(obj)/purgatory.chk: $(obj)/purgatory FORCE
> +		$(call if_changed,ld)
> +
>  OBJCOPYFLAGS_purgatory.ro := -O elf64-s390
>  OBJCOPYFLAGS_purgatory.ro += --remove-section='*debug*'
>  OBJCOPYFLAGS_purgatory.ro += --remove-section='.comment'
>  OBJCOPYFLAGS_purgatory.ro += --remove-section='.note.*'
> -$(obj)/purgatory.ro: $(obj)/purgatory FORCE
> +$(obj)/purgatory.ro: $(obj)/purgatory $(obj)/purgatory.chk FORCE
>  		$(call if_changed,objcopy)
>  
>  $(obj)/kexec-purgatory.o: $(obj)/kexec-purgatory.S $(obj)/purgatory.ro FORCE
> 

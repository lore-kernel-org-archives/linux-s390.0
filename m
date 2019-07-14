Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728362AbfGNOfo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 14 Jul 2019 10:35:44 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6EEWde6104353
        for <linux-s390@vger.kernel.org>; Sun, 14 Jul 2019 10:35:43 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tqvdu0avd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sun, 14 Jul 2019 10:35:43 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Sun, 14 Jul 2019 15:35:40 +0100
Date: Sun, 14 Jul 2019 16:35:33 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390: add Linux banner to the compressed image
References: <cover.1562950641.git.ptesarik@suse.com>
 <aa477dd145aa2beb37fe813619b0723744a22a0a.1562950641.git.ptesarik@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa477dd145aa2beb37fe813619b0723744a22a0a.1562950641.git.ptesarik@suse.com>
Message-Id: <your-ad-here.call-01563114933-ext-9422@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Laura Abbott <labbott@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 07:21:01PM +0200, Petr Tesarik wrote:
> Various tools determine the kernel version from a given binary by
> scanning for the Linux banner string. This does not work if the
> banner string is compressed, but we can link it once more into the
> uncompressed portion of bzImage.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  arch/s390/boot/compressed/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
> index fa529c5b4486..9bc4685477c5 100644
> --- a/arch/s390/boot/compressed/Makefile
> +++ b/arch/s390/boot/compressed/Makefile
> @@ -11,6 +11,7 @@ UBSAN_SANITIZE := n
>  KASAN_SANITIZE := n
>  
>  obj-y	:= $(if $(CONFIG_KERNEL_UNCOMPRESSED),,decompressor.o) piggy.o info.o
> +obj-y   += ../../../../init/banner.o

We don't reuse objects from another build stage, we rebuild them with
distinct decompressor's build flags.
$ git grep "ctype.[oc]" -- arch/s390/boot
arch/s390/boot/Makefile:obj-y   += ctype.o text_dma.o
arch/s390/boot/ctype.c:#include "../../../lib/ctype.c"

Besides that, there is a special CONFIG_KERNEL_UNCOMPRESSED mode, with
which "strings vmlinuz | grep 'Linux version'" I assume you are using
would still yield result. Adding the second version of banner would
produce duplicated result in this case.

But even before discussing solutions I would like to understand the
problem first. Which specific tools are you referring to? What are they
good for? And how do they get the kernel version from other architectures
compressed images?

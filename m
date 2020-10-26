Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31864 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1768773AbgJZMtQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 26 Oct 2020 08:49:16 -0400
Date: Mon, 26 Oct 2020 13:49:05 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [Regression] s390x build broken with 5.10-rc1 (bisected)
Message-ID: <cover.thread-96dc81.your-ad-here.call-01603716370-ext-5478@work.hours>
References: <20201026104811.22ta4pby2chmz4pv@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201026104811.22ta4pby2chmz4pv@lion.mk-sys.cz>
List-ID: <linux-s390.vger.kernel.org>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: linux-s390@vger.kernel.org, Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Mon, Oct 26, 2020 at 11:48:11AM +0100, Michal Kubecek wrote:
> Hello,
> 
> 5.10-rc1 builds on s390x fail with
> 
>   make -f ./scripts/Makefile.build obj=arch/s390/boot arch/s390/boot/bzImage
>   make -f ./scripts/Makefile.modpost
>   make -f ./scripts/Makefile.modfinal
>   make -f ./scripts/Makefile.build obj=arch/s390/boot/compressed arch/s390/boot/compressed/vmlinux
>           s1=`s390x-suse-linux-objdump -t -j ".boot.data" "vmlinux" | sort | sed -n "/0000000000000000/! s/.*\s.boot.data\s\+//p" | sha256sum`; s2=`s390x-suse-linux-objdump -t -j ".boot.data" "arch/s390/boot/compressed/vmlinux" | sort | sed -n "/0000000000000000/! s/.*\s.boot.data\s\+//p" | sha256sum`; if [ "$s1" != "$s2" ]; then echo "error: section .boot.data differs between vmlinux and arch/s390/boot/compressed/vmlinux" >&2; exit 1; fi; touch arch/s390/boot/section_cmp.boot.data
>           s1=`s390x-suse-linux-objdump -t -j ".boot.preserved.data" "vmlinux" | sort | sed -n "/0000000000000000/! s/.*\s.boot.preserved.data\s\+//p" | sha256sum`; s2=`s390x-suse-linux-objdump -t -j ".boot.preserved.data" "arch/s390/boot/compressed/vmlinux" | sort | sed -n "/0000000000000000/! s/.*\s.boot.preserved.data\s\+//p" | sha256sum`; if [ "$s1" != "$s2" ]; then echo "error: section .boot.preserved.data differs between vmlinux and arch/s390/boot/compressed/vmlinux" >&2; exit 1; fi; touch arch/s390/boot/section_cmp.boot.preserved.data
>   error: section .boot.data differs between vmlinux and arch/s390/boot/compressed/vmlinux
>   make[1]: *** [arch/s390/boot/Makefile:65: arch/s390/boot/section_cmp.boot.data] Error 1
>   make[1]: *** Waiting for unfinished jobs....
>   error: section .boot.preserved.data differs between vmlinux and arch/s390/boot/compressed/vmlinux
>   make[1]: *** [arch/s390/boot/Makefile:65: arch/s390/boot/section_cmp.boot.preserved.data] Error 1
>   make: *** [arch/s390/Makefile:153: bzImage] Error 2
>   make: *** Waiting for unfinished jobs....
> 
> Bisect identified commit 33def8498fdd ("treewide: Convert macro and uses
> of __section(foo) to __section("foo")"), i.e. the very last commit
> before tagging v5.10-rc1.
> 
> I can reproduce this with e.g. defconfig and both native s390x build and
> build on x86_64 using cross compiler. I used gcc 10.2.1 and binutils 2.34.
> 
> Michal

Hello Michal,

I've already fixed that. The fix will appear shortly on s390/fixes
Thank you for reporting!

Vasily Gorbik (1):
  s390: correct __bootdata / __bootdata_preserved macros

 arch/s390/include/asm/sections.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.4

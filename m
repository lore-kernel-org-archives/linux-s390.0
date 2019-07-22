Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726846AbfGVMaS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 22 Jul 2019 08:30:18 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MCRPX7147139
        for <linux-s390@vger.kernel.org>; Mon, 22 Jul 2019 08:30:17 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2twbppctvr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 22 Jul 2019 08:30:16 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 22 Jul 2019 13:30:15 +0100
Date: Mon, 22 Jul 2019 14:30:09 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: use __u{16,32,64} instead of uint{16,32,64}_t in
 uapi header
References: <20190721142008.30093-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721142008.30093-1-yamada.masahiro@socionext.com>
Message-Id: <20190722123009.GA5864@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Harald Freudenberger <freude@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 11:20:08PM +0900, Masahiro Yamada wrote:
> When CONFIG_UAPI_HEADER_TEST=y, exported headers are compile-tested to
> make sure they can be included from user-space.
> 
> Currently, zcrypt.h is excluded from the test coverage. To make it
> join the compile-test, we need to fix the build errors attached below.
> 
> For a case like this, we decided to use __u{8,16,32,64} variable types
> in this discussion:
> 
>   https://lkml.org/lkml/2019/6/5/18
...
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/s390/include/uapi/asm/zcrypt.h | 35 +++++++++++++++--------------
>  1 file changed, 18 insertions(+), 17 deletions(-)

Applied, thanks!

I also added the patch below:

From b312d5e2244f635f83cbf19b850e26c1c443f465 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Mon, 22 Jul 2019 14:16:46 +0200
Subject: [PATCH 2/2] kbuild: enable arch/s390/include/uapi/asm/zcrypt.h for
 uapi header test

Masahiro Yamada changed the zcrypt.h header file to use __u{16,32,64}
instead of uint{16,32,64}_t with ("s390: use __u{16,32,64} instead of
uint{16,32,64}_t in uapi header").

This makes all s390 header files pass - remove zcrypt.h from the blacklist.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 usr/include/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/usr/include/Makefile b/usr/include/Makefile
index aa316d99e035..1fb6abe29b2f 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -101,10 +101,6 @@ ifeq ($(SRCARCH),riscv)
 header-test- += linux/bpf_perf_event.h
 endif
 
-ifeq ($(SRCARCH),s390)
-header-test- += asm/zcrypt.h
-endif
-
 ifeq ($(SRCARCH),sparc)
 header-test- += asm/stat.h
 header-test- += asm/uctx.h
-- 
2.17.1

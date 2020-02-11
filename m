Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728683AbgBKNBj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Feb 2020 08:01:39 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BCx83Y125930
        for <linux-s390@vger.kernel.org>; Tue, 11 Feb 2020 08:01:38 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1tpcs4ma-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 11 Feb 2020 08:01:38 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Tue, 11 Feb 2020 13:01:36 -0000
Date: Tue, 11 Feb 2020 14:01:29 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: -Wtautological-constant-compare in arch/s390/include/asm/page.h
References: <20200208125714.GA9164@ubuntu-x2-xlarge-x86>
 <1f54ae4c-8748-496b-0833-80749d8d4f6c@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f54ae4c-8748-496b-0833-80749d8d4f6c@de.ibm.com>
Message-Id: <your-ad-here.call-01581426089-ext-6170@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com

On Mon, Feb 10, 2020 at 08:55:46AM +0100, Christian Borntraeger wrote:
> 
> 
> On 08.02.20 13:57, Nathan Chancellor wrote:
> > Hi all,
> > 
> > We noticed that you all added support for building s390 with clang,
> > which is great! I have noticed a few warnings for which I will send
> > patches but this one has me stumped.
> > 
> > In file included from ../lib/crypto/sha256.c:16:
> > In file included from ../include/linux/module.h:13:
> > In file included from ../include/linux/stat.h:19:
> > In file included from ../include/linux/time.h:6:
> > In file included from ../include/linux/seqlock.h:36:
> > In file included from ../include/linux/spinlock.h:51:
> > In file included from ../include/linux/preempt.h:78:
> > In file included from ../arch/s390/include/asm/preempt.h:6:
> > In file included from ../include/linux/thread_info.h:38:
> > In file included from ../arch/s390/include/asm/thread_info.h:26:
> > ../arch/s390/include/asm/page.h:45:6: warning: converting the result of '<<' to a boolean always evaluates to false [-Wtautological-constant-compare]
> >         if (PAGE_DEFAULT_KEY)
> >             ^
> > ../arch/s390/include/asm/page.h:23:44: note: expanded from macro 'PAGE_DEFAULT_KEY'
> > #define PAGE_DEFAULT_KEY        (PAGE_DEFAULT_ACC << 4)
> >                                                   ^
> > 1 warning generated.

This warning only shows up for the decompressor code and purgatory which
have separate set of build flags not derived from top level KBUILD_CFLAGS.
For the rest of the code this warning is suppressed by:
Makefile:
 740 ifdef CONFIG_CC_IS_CLANG
...
 744 # Quiet clang warning: comparison of unsigned expression < 0 is always false
 745 KBUILD_CFLAGS += -Wno-tautological-compare

At the same time both decompressor and purgatory Makefiles include
CLANG_FLAGS into their CFLAGS. And this -Wno-tautological-compare is
clang specific. So I believe this option belongs to CLANG_FLAGS
rather than being included into KBUILD_CFLAGS under ifdef
CONFIG_CC_IS_CLANG. But this raises question about other clang
specific options inside that ifdef CONFIG_CC_IS_CLANG. Should they all
be made part of CLANG_FLAGS?

> > 
> > PAGE_DEFAULT_PAGE is always 0, meaning this function never does what it
> > is supposed to. Is this intentional? It seems that commit 0b642ede4796
> > ("[PATCH] s390: default storage key") added this and it mentions that it
> > can be overwritten at build time but I do not see any infrastructure for
> > doing that. Any clarification that you can give so we can solve this
> > warning would be much appreciated!
> 
> Yes, it is a debugging tool that we use from time to time. The user would then
> change PAGE_DEFAULT_ACC in the header file when needed. It was not worth a config
> option as normal users should not use it. 
> 

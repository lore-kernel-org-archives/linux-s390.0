Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40562 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgBHM5R (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 8 Feb 2020 07:57:17 -0500
Date: Sat, 8 Feb 2020 05:57:14 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
Subject: -Wtautological-constant-compare in arch/s390/include/asm/page.h
Message-ID: <20200208125714.GA9164@ubuntu-x2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com

Hi all,

We noticed that you all added support for building s390 with clang,
which is great! I have noticed a few warnings for which I will send
patches but this one has me stumped.

In file included from ../lib/crypto/sha256.c:16:
In file included from ../include/linux/module.h:13:
In file included from ../include/linux/stat.h:19:
In file included from ../include/linux/time.h:6:
In file included from ../include/linux/seqlock.h:36:
In file included from ../include/linux/spinlock.h:51:
In file included from ../include/linux/preempt.h:78:
In file included from ../arch/s390/include/asm/preempt.h:6:
In file included from ../include/linux/thread_info.h:38:
In file included from ../arch/s390/include/asm/thread_info.h:26:
../arch/s390/include/asm/page.h:45:6: warning: converting the result of '<<' to a boolean always evaluates to false [-Wtautological-constant-compare]
        if (PAGE_DEFAULT_KEY)
            ^
../arch/s390/include/asm/page.h:23:44: note: expanded from macro 'PAGE_DEFAULT_KEY'
#define PAGE_DEFAULT_KEY        (PAGE_DEFAULT_ACC << 4)
                                                  ^
1 warning generated.

PAGE_DEFAULT_PAGE is always 0, meaning this function never does what it
is supposed to. Is this intentional? It seems that commit 0b642ede4796
("[PATCH] s390: default storage key") added this and it mentions that it
can be overwritten at build time but I do not see any infrastructure for
doing that. Any clarification that you can give so we can solve this
warning would be much appreciated!

Cheers,
Nathan

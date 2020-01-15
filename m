Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36916 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgAOGhc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Jan 2020 01:37:32 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so8028221pfn.4
        for <linux-s390@vger.kernel.org>; Tue, 14 Jan 2020 22:37:31 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
Subject: [PATCH 0/2] Fix some incompatibilites between KASAN and FORTIFY_SOURCE
Date: Wed, 15 Jan 2020 17:37:08 +1100
Message-Id: <20200115063710.15796-1-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, kasan-dev@googlegroups.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org, Daniel Axtens <dja@axtens.net>

3 KASAN self-tests fail on a kernel with both KASAN and FORTIFY_SOURCE:
memchr, memcmp and strlen. I have observed this on x86 and powerpc.

When FORTIFY_SOURCE is on, a number of functions are replaced with
fortified versions, which attempt to check the sizes of the
operands. However, these functions often directly invoke __builtin_foo()
once they have performed the fortify check.

This breaks things in 2 ways:

 - the three function calls are technically dead code, and can be
   eliminated. When __builtin_ versions are used, the compiler can detect
   this.

 - Using __builtins may bypass KASAN checks if the compiler decides to
   inline it's own implementation as sequence of instructions, rather than
   emit a function call that goes out to a KASAN-instrumented
   implementation.

The patches address each reason in turn.

As a result, we're also able to remove a snippet of code copy-pasted
between every KASAN implementation that tries (largely unsuccessfully) to
disable FORTIFY_SOURCE under KASAN.

Daniel Axtens (2):
  kasan: stop tests being eliminated as dead code with FORTIFY_SOURCE
  string.h: fix incompatibility between FORTIFY_SOURCE and KASAN

 arch/arm64/include/asm/string.h   |  4 ---
 arch/powerpc/include/asm/string.h |  4 ---
 arch/s390/include/asm/string.h    |  4 ---
 arch/x86/include/asm/string_64.h  |  4 ---
 arch/xtensa/include/asm/string.h  |  3 --
 include/linux/string.h            | 49 +++++++++++++++++++++++--------
 lib/test_kasan.c                  | 30 ++++++++++++-------
 7 files changed, 56 insertions(+), 42 deletions(-)

-- 
2.20.1

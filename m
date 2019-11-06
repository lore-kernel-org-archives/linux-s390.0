Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51755 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfKFONZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 09:13:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id q70so3626719wme.1
        for <linux-s390@vger.kernel.org>; Wed, 06 Nov 2019 06:13:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 00/10] Improvements for random.h/archrandom.h
Date: Wed,  6 Nov 2019 15:12:58 +0100
Message-Id: <20191106141308.30535-1-rth@twiddle.net>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au, linux-arch@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org

During patch review for an addition of archrandom.h for arm64, it was
suggeted that the arch_random_get_* functions should be marked __must_check.
Which does sound like a good idea, since the by-reference integer output
may be uninitialized when the boolean result is false.

In addition, it turns out that arch_has_random() and arch_has_random_seed()
are not used, and not easy to support for arm64.  Rather than cobble
something together that would not be testable, remove the interfaces
against some future accidental use.

In addition, I noticed a few other minor inconsistencies between the
different architectures, e.g. powerpc isn't using bool.

Change since v1:
  * Remove arch_has_random, arch_has_random_seed.


r~


Richard Henderson (10):
  x86: Remove arch_has_random, arch_has_random_seed
  powerpc: Remove arch_has_random, arch_has_random_seed
  s390: Remove arch_has_random, arch_has_random_seed
  linux/random.h: Remove arch_has_random, arch_has_random_seed
  linux/random.h: Use false with bool
  linux/random.h: Mark CONFIG_ARCH_RANDOM functions __must_check
  x86: Mark archrandom.h functions __must_check
  powerpc: Use bool in archrandom.h
  powerpc: Mark archrandom.h functions __must_check
  s390x: Mark archrandom.h functions __must_check

 arch/powerpc/include/asm/archrandom.h | 27 +++++++++-----------------
 arch/s390/include/asm/archrandom.h    | 20 ++++---------------
 arch/x86/include/asm/archrandom.h     | 28 ++++++++++++---------------
 include/linux/random.h                | 24 ++++++++---------------
 4 files changed, 33 insertions(+), 66 deletions(-)

-- 
2.17.1

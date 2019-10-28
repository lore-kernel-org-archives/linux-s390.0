Return-Path: <linux-arch-owner@vger.kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/6] Improvements for random.h/archrandom.h
Date: Mon, 28 Oct 2019 22:05:53 +0100
Message-Id: <20191028210559.8289-1-rth@twiddle.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org

During patch review for an addition of archrandom.h for arm64,
it was suggeted that the arch_random_get_* functions should be
marked __must_check.  Which does sound like a good idea, since
the by-reference integer output may be uninitialized when the
boolean result is false.

In addition, I noticed a few other minor inconsistencies between
the different architectures: x86 defines some functional macros
outside CONFIG_ARCH_RANDOM, and powerpc isn't using bool.


r~


Richard Henderson (6):
  random: Mark CONFIG_ARCH_RANDOM functions __must_check
  x86: Move arch_has_random* inside CONFIG_ARCH_RANDOM
  x86: Mark archrandom.h functions __must_check
  powerpc: Use bool in archrandom.h
  powerpc: Mark archrandom.h functions __must_check
  s390x: Mark archrandom.h functions __must_check

 arch/powerpc/include/asm/archrandom.h | 24 +++++++++++++-----------
 arch/s390/include/asm/archrandom.h    |  8 ++++----
 arch/x86/include/asm/archrandom.h     | 24 ++++++++++++------------
 include/linux/random.h                |  8 ++++----
 4 files changed, 33 insertions(+), 31 deletions(-)

-- 
2.17.1

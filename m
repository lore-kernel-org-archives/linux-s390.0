Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39387 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFIUfs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 9 Jun 2019 16:35:48 -0400
From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] s390: mark __ctl_set_bit and __ctl_clear_bit as __always_inline
Date: Sun,  9 Jun 2019 13:35:44 -0700
Message-Id: <1560112544-10440-1-git-send-email-linux@roeck-us.net>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

s390:tinyconfig fails to build with gcc 8.3.0.

arch/s390/include/asm/ctl_reg.h:52:2: error: impossible constraint in 'asm'
  asm volatile(       \
  ^~~
arch/s390/include/asm/ctl_reg.h:62:2: note: in expansion of macro '__ctl_store'
  __ctl_store(reg, cr, cr);
  ^~~~~~~~~~~
s390/include/asm/ctl_reg.h:41:2: error: impossible constraint in 'asm'
  asm volatile(       \
  ^~~
arch/s390/include/asm/ctl_reg.h:64:2:
note: in expansion of macro '__ctl_load'
  __ctl_load(reg, cr, cr);
  ^~~~~~~~~~

Marking __ctl_set_bit and __ctl_clear_bit as __always_inline fixes the
problem.

Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/s390/include/asm/ctl_reg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/ctl_reg.h b/arch/s390/include/asm/ctl_reg.h
index 4600453536c2..3bda757317cf 100644
--- a/arch/s390/include/asm/ctl_reg.h
+++ b/arch/s390/include/asm/ctl_reg.h
@@ -55,7 +55,7 @@
 		: "i" (low), "i" (high));				\
 } while (0)
 
-static inline void __ctl_set_bit(unsigned int cr, unsigned int bit)
+static __always_inline void __ctl_set_bit(unsigned int cr, unsigned int bit)
 {
 	unsigned long reg;
 
@@ -64,7 +64,7 @@ static inline void __ctl_set_bit(unsigned int cr, unsigned int bit)
 	__ctl_load(reg, cr, cr);
 }
 
-static inline void __ctl_clear_bit(unsigned int cr, unsigned int bit)
+static __always_inline void __ctl_clear_bit(unsigned int cr, unsigned int bit)
 {
 	unsigned long reg;
 
-- 
2.7.4

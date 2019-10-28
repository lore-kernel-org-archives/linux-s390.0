Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38973 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389625AbfJ1VGL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Oct 2019 17:06:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id a11so11377543wra.6
        for <linux-s390@vger.kernel.org>; Mon, 28 Oct 2019 14:06:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 6/6] s390x: Mark archrandom.h functions __must_check
Date: Mon, 28 Oct 2019 22:05:59 +0100
Message-Id: <20191028210559.8289-7-rth@twiddle.net>
In-Reply-To: <20191028210559.8289-1-rth@twiddle.net>
References: <20191028210559.8289-1-rth@twiddle.net>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

We cannot use the pointer output without validating the
success of the random read.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/archrandom.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/archrandom.h b/arch/s390/include/asm/archrandom.h
index c67b82dfa558..f3f1ee0a8c38 100644
--- a/arch/s390/include/asm/archrandom.h
+++ b/arch/s390/include/asm/archrandom.h
@@ -33,17 +33,17 @@ static inline bool arch_has_random_seed(void)
 	return false;
 }
 
-static inline bool arch_get_random_long(unsigned long *v)
+static inline bool __must_check arch_get_random_long(unsigned long *v)
 {
 	return false;
 }
 
-static inline bool arch_get_random_int(unsigned int *v)
+static inline bool __must_check arch_get_random_int(unsigned int *v)
 {
 	return false;
 }
 
-static inline bool arch_get_random_seed_long(unsigned long *v)
+static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
 {
 	if (static_branch_likely(&s390_arch_random_available)) {
 		return s390_arch_random_generate((u8 *)v, sizeof(*v));
@@ -51,7 +51,7 @@ static inline bool arch_get_random_seed_long(unsigned long *v)
 	return false;
 }
 
-static inline bool arch_get_random_seed_int(unsigned int *v)
+static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
 {
 	if (static_branch_likely(&s390_arch_random_available)) {
 		return s390_arch_random_generate((u8 *)v, sizeof(*v));
-- 
2.17.1

Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 3 Apr 2019 05:45:26 GMT
Message-Id: <201904030545.x335jQJO015258@sdf.org>
From: George Spelvin <lkml@sdf.org>
Subject: [PATCH v2] ubsan: Avoid unnecessary 128-bit shifts
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, George Spelvin <lkml@sdf.org>
List-ID: <linux-s390.vger.kernel.org>

If CONFIG_ARCH_SUPPORTS_INT128, s_max is 128 bits, and variable
sign-extending shifts of such a double-word data type are a non-trivial
amount of code and complexity.  Do a single-word shift *before* the cast
to (s_max), greatly simplifying the object code.

(Yes, I know "signed long" is redundant.  It's there for emphasis.)

On s390 (and perhaps some other arches), gcc implements variable
128-bit shifts using an __ashrti3 helper function which the kernel
doesn't provide, causing a link error.  In that case, this patch is
a prerequisite for enabling INT128 support.  Andrey Ryabinin has gven
permission for any arch that needs it to cherry-pick it so they don't
have to wait for ubsan to be merged into Linus' tree.

We *could*, alternatively, implement __ashrti3, but that becomes dead as
soon as this patch is merged, so it seems like a waste of time and its
absence discourages people from adding inefficient code.  Note that the
shifts in <math64.h> (unsigned, and by a compile-time constant amount)
are simpler and generated inline.

Signed-off-by: George Spelvin <lkml@sdf.org>
Acked-By: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 lib/ubsan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

v1->v2:	Eliminated redundant cast to (s_max).
	Rewrote commit message without "is this the right thing to do?"
	verbiage.
	Incorporated ack from Andrey Ryabinin.

diff --git a/lib/ubsan.c b/lib/ubsan.c
index e4162f59a81c..a7eb55fbeede 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -89,8 +89,8 @@ static bool is_inline_int(struct type_descriptor *type)
 static s_max get_signed_val(struct type_descriptor *type, unsigned long val)
 {
 	if (is_inline_int(type)) {
-		unsigned extra_bits = sizeof(s_max)*8 - type_bit_width(type);
-		return ((s_max)val) << extra_bits >> extra_bits;
+		unsigned extra_bits = sizeof(val)*8 - type_bit_width(type);
+		return (signed long)val << extra_bits >> extra_bits;
 	}
 
 	if (type_bit_width(type) == 64)
-- 
2.20.1

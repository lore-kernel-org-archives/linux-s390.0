Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 5 Apr 2019 01:58:53 GMT
Message-Id: <201904050158.x351wr9f016512@sdf.org>
From: George Spelvin <lkml@sdf.org>
Subject: [PATCH v3] ubsan: Avoid unnecessary 128-bit shifts
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, George Spelvin <lkml@sdf.org>
List-ID: <linux-s390.vger.kernel.org>

If CONFIG_ARCH_SUPPORTS_INT128, s_max is 128 bits, and variable
sign-extending shifts of such a double-word data type are a non-trivial
amount of code and complexity.  Do a single-word sign-extension *before*
the cast to (s_max), greatly simplifying the object code.

Rasmus Villemoes suggested using sign_extend* from <linux/bitops.h>.

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
Feedback-from: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 include/linux/bitops.h |  7 +++++++
 lib/ubsan.c            | 13 +++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

v3:	Added sign_extend_long() to sign_extend{32,64} in <linux/bitops.h>.
	Used sign_extend_long rather than hand-rolling sign extension.
	Changed to more uniform if ... else if ... else ... structure.
v2:	Eliminated redundant cast to (s_max).
        Rewrote commit message without "is this the right thing to do?"
        verbiage.
        Incorporated ack from Andrey Ryabinin.

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 705f7c442691..8d33c2bfe6c5 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -157,6 +157,13 @@ static inline __s64 sign_extend64(__u64 value, int index)
 	return (__s64)(value << shift) >> shift;
 }
 
+static inline long sign_extend_long(unsigned long value, int index)
+{
+	if (sizeof(value) == 4)
+		return sign_extend32(value);
+	return sign_extend64(value);
+}
+
 static inline unsigned fls_long(unsigned long l)
 {
 	if (sizeof(l) == 4)
diff --git a/lib/ubsan.c b/lib/ubsan.c
index e4162f59a81c..24d4920317e4 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -88,15 +88,12 @@ static bool is_inline_int(struct type_descriptor *type)
 
 static s_max get_signed_val(struct type_descriptor *type, unsigned long val)
 {
-	if (is_inline_int(type)) {
-		unsigned extra_bits = sizeof(s_max)*8 - type_bit_width(type);
-		return ((s_max)val) << extra_bits >> extra_bits;
-	}
+	if (is_inline_int(type))
+		return sign_extend_long(val, type_bit_width(type) - 1);
-
-	if (type_bit_width(type) == 64)
+	else if (type_bit_width(type) == 64)
 		return *(s64 *)val;
-
-	return *(s_max *)val;
+	else
+		return *(s_max *)val;
 }
 
 static bool val_is_negative(struct type_descriptor *type, unsigned long val)
-- 
2.20.1

Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 13 Sep 2018 14:01:49 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.19 #3
Message-Id: <20180913140149.3c39485c@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

this is the first try to do a pull request for s390 with a signed tag.
I keep my fingers crossed that the setup works as intended.

I have used the 8A8FDAE0 signing sub-key of my 26AE5DD2 master key:

pub   rsa4096/26AE5DD2 2011-10-10 [SC]
uid         [ultimate] Martin Schwidefsky <schwidefsky@de.ibm.com>
sub   rsa4096/1F2A4B67 2011-10-10 [E]
sub   rsa2048/59DAAB8E 2018-09-11 [A]
sub   rsa2048/8A8FDAE0 2018-09-12 [S]

So here we go:

Please pull s390 fixes for 4.19-rc4

The following changes since commit 60c1f89241d49bacf71035470684a8d7b4bb46ea:

  Merge tag 'dma-mapping-4.19-2' of git://git.infradead.org/users/hch/dma-mapping (2018-09-02 20:09:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-4.19-3

for you to fetch changes up to fa108f95c6769ec15ea59b7db00454b82afc6121:

  s390/zcrypt: remove VLA usage from the AP bus (2018-09-12 11:33:37 +0200)

----------------------------------------------------------------
s390 fixes for 4.19-rc4

One fix for the zcrypt driver to correctly handle incomplete
encryption/decryption operations.

A cleanup for the aqmask/apmask parsing to avoid variable
length arrays on the stack.

----------------------------------------------------------------
Ingo Franzki (1):
      s390/crypto: Fix return code checking in cbc_paes_crypt()

Martin Schwidefsky (1):
      s390/zcrypt: remove VLA usage from the AP bus

 arch/s390/crypto/paes_s390.c |  2 +-
 drivers/s390/crypto/ap_bus.c | 86 +++++++++++++++++---------------------------
 2 files changed, 34 insertions(+), 54 deletions(-)

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index 80b2729..ab9a0eb 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -208,7 +208,7 @@ static int cbc_paes_crypt(struct blkcipher_desc *desc, unsigned long modifier,
 			      walk->dst.virt.addr, walk->src.virt.addr, n);
 		if (k)
 			ret = blkcipher_walk_done(desc, walk, nbytes - k);
-		if (n < k) {
+		if (k < n) {
 			if (__cbc_paes_set_key(ctx) != 0)
 				return blkcipher_walk_done(desc, walk, -EIO);
 			memcpy(param.key, ctx->pk.protkey, MAXPROTKEYSIZE);
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index ec891bc..f039266 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -872,8 +872,6 @@ static int hex2bitmap(const char *str, unsigned long *bitmap, int bits)
 	if (bits & 0x07)
 		return -EINVAL;
 
-	memset(bitmap, 0, bits / 8);
-
 	if (str[0] == '0' && str[1] == 'x')
 		str++;
 	if (*str == 'x')
@@ -895,25 +893,23 @@ static int hex2bitmap(const char *str, unsigned long *bitmap, int bits)
 }
 
 /*
- * str2clrsetmasks() - parse bitmask argument and set the clear and
- * the set bitmap mask. A concatenation (done with ',') of these terms
- * is recognized:
+ * modify_bitmap() - parse bitmask argument and modify an existing
+ * bit mask accordingly. A concatenation (done with ',') of these
+ * terms is recognized:
  *   +<bitnr>[-<bitnr>] or -<bitnr>[-<bitnr>]
  * <bitnr> may be any valid number (hex, decimal or octal) in the range
  * 0...bits-1; the leading + or - is required. Here are some examples:
  *   +0-15,+32,-128,-0xFF
  *   -0-255,+1-16,+0x128
  *   +1,+2,+3,+4,-5,-7-10
- * Returns a clear and a set bitmask. Every positive value in the string
- * results in a bit set in the set mask and every negative value in the
- * string results in a bit SET in the clear mask. As a bit may be touched
- * more than once, the last 'operation' wins: +0-255,-128 = all but bit
- * 128 set in the set mask, only bit 128 set in the clear mask.
+ * Returns the new bitmap after all changes have been applied. Every
+ * positive value in the string will set a bit and every negative value
+ * in the string will clear a bit. As a bit may be touched more than once,
+ * the last 'operation' wins:
+ * +0-255,-128 = first bits 0-255 will be set, then bit 128 will be
+ * cleared again. All other bits are unmodified.
  */
-static int str2clrsetmasks(const char *str,
-			   unsigned long *clrmap,
-			   unsigned long *setmap,
-			   int bits)
+static int modify_bitmap(const char *str, unsigned long *bitmap, int bits)
 {
 	int a, i, z;
 	char *np, sign;
@@ -922,9 +918,6 @@ static int str2clrsetmasks(const char *str,
 	if (bits & 0x07)
 		return -EINVAL;
 
-	memset(clrmap, 0, bits / 8);
-	memset(setmap, 0, bits / 8);
-
 	while (*str) {
 		sign = *str++;
 		if (sign != '+' && sign != '-')
@@ -940,13 +933,10 @@ static int str2clrsetmasks(const char *str,
 			str = np;
 		}
 		for (i = a; i <= z; i++)
-			if (sign == '+') {
-				set_bit_inv(i, setmap);
-				clear_bit_inv(i, clrmap);
-			} else {
-				clear_bit_inv(i, setmap);
-				set_bit_inv(i, clrmap);
-			}
+			if (sign == '+')
+				set_bit_inv(i, bitmap);
+			else
+				clear_bit_inv(i, bitmap);
 		while (*str == ',' || *str == '\n')
 			str++;
 	}
@@ -970,44 +960,34 @@ static int process_mask_arg(const char *str,
 			    unsigned long *bitmap, int bits,
 			    struct mutex *lock)
 {
-	int i;
+	unsigned long *newmap, size;
+	int rc;
 
 	/* bits needs to be a multiple of 8 */
 	if (bits & 0x07)
 		return -EINVAL;
 
+	size = BITS_TO_LONGS(bits)*sizeof(unsigned long);
+	newmap = kmalloc(size, GFP_KERNEL);
+	if (!newmap)
+		return -ENOMEM;
+	if (mutex_lock_interruptible(lock)) {
+		kfree(newmap);
+		return -ERESTARTSYS;
+	}
+
 	if (*str == '+' || *str == '-') {
-		DECLARE_BITMAP(clrm, bits);
-		DECLARE_BITMAP(setm, bits);
-
-		i = str2clrsetmasks(str, clrm, setm, bits);
-		if (i)
-			return i;
-		if (mutex_lock_interruptible(lock))
-			return -ERESTARTSYS;
-		for (i = 0; i < bits; i++) {
-			if (test_bit_inv(i, clrm))
-				clear_bit_inv(i, bitmap);
-			if (test_bit_inv(i, setm))
-				set_bit_inv(i, bitmap);
-		}
+		memcpy(newmap, bitmap, size);
+		rc = modify_bitmap(str, newmap, bits);
 	} else {
-		DECLARE_BITMAP(setm, bits);
-
-		i = hex2bitmap(str, setm, bits);
-		if (i)
-			return i;
-		if (mutex_lock_interruptible(lock))
-			return -ERESTARTSYS;
-		for (i = 0; i < bits; i++)
-			if (test_bit_inv(i, setm))
-				set_bit_inv(i, bitmap);
-			else
-				clear_bit_inv(i, bitmap);
+		memset(newmap, 0, size);
+		rc = hex2bitmap(str, newmap, bits);
 	}
+	if (rc == 0)
+		memcpy(bitmap, newmap, size);
 	mutex_unlock(lock);
-
-	return 0;
+	kfree(newmap);
+	return rc;
 }
 
 /*

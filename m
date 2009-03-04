From: akpm@linux-foundation.org
Date: Wed, 04 Mar 2009 20:04:50 +0000
Subject: [patch 1/1] s390: use kzfree()
Message-Id: <200903042004.n24K4pM4029139@imap1.linux-foundation.org>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Johannes Weiner <hannes@cmpxchg.org>

Use kzfree() instead of memset() + kfree().

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/s390/crypto/prng.c             |    3 +--
 drivers/s390/crypto/zcrypt_pcixcc.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff -puN arch/s390/crypto/prng.c~s390-use-kzfree arch/s390/crypto/prng.c
--- a/arch/s390/crypto/prng.c~s390-use-kzfree
+++ a/arch/s390/crypto/prng.c
@@ -201,8 +201,7 @@ out_free:
 static void __exit prng_exit(void)
 {
 	/* wipe me */
-	memset(p->buf, 0, prng_chunk_size);
-	kfree(p->buf);
+	kzfree(p->buf);
 	kfree(p);
 
 	misc_deregister(&prng_dev);
diff -puN drivers/s390/crypto/zcrypt_pcixcc.c~s390-use-kzfree drivers/s390/crypto/zcrypt_pcixcc.c
--- a/drivers/s390/crypto/zcrypt_pcixcc.c~s390-use-kzfree
+++ a/drivers/s390/crypto/zcrypt_pcixcc.c
@@ -781,8 +781,7 @@ static long zcrypt_pcixcc_send_cprb(stru
 		/* Signal pending. */
 		ap_cancel_message(zdev->ap_dev, &ap_msg);
 out_free:
-	memset(ap_msg.message, 0x0, ap_msg.length);
-	kfree(ap_msg.message);
+	kzfree(ap_msg.message);
 	return rc;
 }
 
_

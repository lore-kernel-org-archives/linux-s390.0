From: George Spelvin <lkml@sdf.org>
Date: Thu, 21 Mar 2019 12:15:18 +0000
Subject: [PATCH] arch/s390/crypto/prng: Stop being stupidly wasteful with /dev/urandom
Message-Id: <201903211215.x2LCFIr3029539@sdf.org>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

generate_entropy() was asking for 8K of high-quality entropy per 64 bytes
of output, which is ridiculous.  Only ask get_random_bytes for the
requested amount of entropy, and XOR with the hash of the timer-based
seed material.

(A possible followon improvement: the msbits of get_tod_clock_fast() are
unchanging and therefore useless; you could store and hash only the low
32 bits and save half the hashing effort.)

A second latent bugfix: prng_tdes_seed() was not copying the final partial
doubleword of get_random_bytes() output to the parameter block.  It's
only ever called with 8- and 16-byte requests, so the bug never triggered,
but fix it so it won't be (silently) buggy in future.

Not tested as I don't have access to an S/390, but the code is
straightforward.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: linux-s390@vger.kernel.org
Cc: Harald Freudenberger <freude@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Fixes: 57127645d79d2e83e801f141f7d03f64accf28aa
Cc: Jan Glauber <jan.glauber@de.ibm.com>
Fixes: 1b2782948997cf5a0d1747de13d43ba7dfa7c543
---
 arch/s390/crypto/prng.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/s390/crypto/prng.c b/arch/s390/crypto/prng.c
index a97a1802cfb4..e3f649e66c91 100644
--- a/arch/s390/crypto/prng.c
+++ b/arch/s390/crypto/prng.c
@@ -122,33 +122,30 @@ static const u8 initial_parm_block[32] __initconst = {
  */
 static int generate_entropy(u8 *ebuf, size_t nbytes)
 {
-	int n, ret = 0;
-	u8 *pg, *h, hash[64];
+	int n, i, ret = 0;
+	u64 *pg;
+	u8 hash[64];
 
 	/* allocate 2 pages */
-	pg = (u8 *) __get_free_pages(GFP_KERNEL, 1);
+	pg = (u64 *) __get_free_pages(GFP_KERNEL, 1);
 	if (!pg) {
 		prng_errorflag = PRNG_GEN_ENTROPY_FAILED;
 		return -ENOMEM;
 	}
 
+	get_random_bytes(ebuf, nbytes);
 	while (nbytes) {
-		/* fill pages with urandom bytes */
-		get_random_bytes(pg, 2*PAGE_SIZE);
-		/* exor pages with 1024 stckf values */
-		for (n = 0; n < 2 * PAGE_SIZE / sizeof(u64); n++) {
-			u64 *p = ((u64 *)pg) + n;
-			*p ^= get_tod_clock_fast();
-		}
-		n = (nbytes < sizeof(hash)) ? nbytes : sizeof(hash);
-		if (n < sizeof(hash))
-			h = hash;
-		else
-			h = ebuf;
+		/* fill pages with 1024 stckf values */
+		for (n = 0; n < 2 * PAGE_SIZE / sizeof(u64); n++)
+			pg[n] = get_tod_clock_fast();
+
 		/* hash over the filled pages */
-		cpacf_kimd(CPACF_KIMD_SHA_512, h, pg, 2*PAGE_SIZE);
-		if (n < sizeof(hash))
-			memcpy(ebuf, hash, n);
+		cpacf_kimd(CPACF_KIMD_SHA_512, hash, (u8 *)pg, 2*PAGE_SIZE);
+
+		/* xor with the urandom bytes */
+		n = (nbytes < sizeof(hash)) ? nbytes : sizeof(hash);
+		for (i = 0; i < n; i++)
+			ebuf[i] ^= hash[i];
 		ret += n;
 		ebuf += n;
 		nbytes -= n;
@@ -185,13 +182,12 @@ static void prng_tdes_seed(int nbytes)
 	get_random_bytes(buf, nbytes);
 
 	/* Add the entropy */
-	while (nbytes >= 8) {
+	while (nbytes = 0) {
 		*((__u64 *)prng_data->prngws.parm_block) ^= *((__u64 *)(buf+i));
 		prng_tdes_add_entropy();
 		i += 8;
 		nbytes -= 8;
 	}
-	prng_tdes_add_entropy();
 	prng_data->prngws.reseed_counter = 0;
 }
 
-- 
2.20.1

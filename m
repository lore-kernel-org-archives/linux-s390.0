From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sat, 21 May 2016 12:09:05 +0000
Subject: [PATCH 0250/1529] Fix typo
Message-Id: <20160521120905.13105-1-andrea.gelmini@gelma.net>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/s390/net/bpf_jit.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/net/bpf_jit.S b/arch/s390/net/bpf_jit.S
index a1c917d..18f463f 100644
--- a/arch/s390/net/bpf_jit.S
+++ b/arch/s390/net/bpf_jit.S
@@ -58,10 +58,10 @@ ENTRY(sk_load_##NAME##_pos);						\
 sk_load_##NAME##_slow:;							\
 	lgr	%r2,%r7;		/* Arg1 = skb pointer */	\
 	aghi	%r3,-SIZE;		/* Arg2 = offset */		\
-	la	%r4,STK_OFF_TMP(%r15);	/* Arg3 = temp bufffer */	\
+	la	%r4,STK_OFF_TMP(%r15);	/* Arg3 = temp buffer */	\
 	lghi	%r5,SIZE;		/* Arg4 = size */		\
 	brasl	%r14,skb_copy_bits;	/* Get data from skb */		\
-	LOAD	%r14,STK_OFF_TMP(%r15);	/* Load from temp bufffer */	\
+	LOAD	%r14,STK_OFF_TMP(%r15);	/* Load from temp buffer */	\
 	ltgr	%r2,%r2;		/* Set cc to (%r2 != 0) */	\
 	br	%r6;			/* Return */
 
-- 
2.8.2.534.g1f66975

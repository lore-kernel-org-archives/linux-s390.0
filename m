From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/2] s390/cpacf: query instructions use unique parameters for compatibility with KMA
Date: Wed, 26 Apr 2017 14:38:10 +0200
Message-ID: <1493210291-58638-2-git-send-email-borntraeger@de.ibm.com>
References: <1493210291-58638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1493210291-58638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

The new KMA instruction requires unique parameters. Update __cpacf_query to
generate a compatible assembler instruction.

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Acked-by: Harald Freudenberger <freude@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/cpacf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
index e2dfbf2..175a5d7 100644
--- a/arch/s390/include/asm/cpacf.h
+++ b/arch/s390/include/asm/cpacf.h
@@ -149,8 +149,8 @@ static inline void __cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
 
 	asm volatile(
 		"	spm 0\n" /* pckmo doesn't change the cc */
-		/* Parameter registers are ignored, but may not be 0 */
-		"0:	.insn	rrf,%[opc] << 16,2,2,2,0\n"
+		/* Parameter regs are ignored, but must be nonzero and unique */
+		"0:	.insn	rrf,%[opc] << 16,2,4,6,0\n"
 		"	brc	1,0b\n"	/* handle partial completion */
 		: "=m" (*mask)
 		: [fc] "d" (r0), [pba] "a" (r1), [opc] "i" (opcode)
-- 
2.7.4

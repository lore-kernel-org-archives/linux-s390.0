From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 17/52] s390/crypto: allow to query all known cpacf functions
Date: Tue, 14 Jun 2016 20:56:54 +0200
Message-ID: <1465930649-181383-18-git-send-email-borntraeger@de.ibm.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

KVM will have to query these functions, let's add at least the query
capabilities.

PCKMO has RRE format, as bit 16-31 are ignored, we can still use the
existing function. As PCKMO won't touch the cc, let's force it to 0
upfront.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Ingo Tuchscherer <ingo.tuchscherer@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/cpacf.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
index 1a82cf2..d28621d 100644
--- a/arch/s390/include/asm/cpacf.h
+++ b/arch/s390/include/asm/cpacf.h
@@ -20,6 +20,9 @@
 #define CPACF_KMC		0xb92f		/* MSA	*/
 #define CPACF_KIMD		0xb93e		/* MSA	*/
 #define CPACF_KLMD		0xb93f		/* MSA	*/
+#define CPACF_PCKMO		0xb928		/* MSA3 */
+#define CPACF_KMF		0xb92a		/* MSA4 */
+#define CPACF_KMO		0xb92b		/* MSA4 */
 #define CPACF_PCC		0xb92c		/* MSA4 */
 #define CPACF_KMCTR		0xb92d		/* MSA4 */
 #define CPACF_PPNO		0xb93c		/* MSA5 */
@@ -136,6 +139,7 @@ static inline void __cpacf_query(unsigned int opcode, unsigned char *status)
 	register unsigned long r1 asm("1") = (unsigned long) status;
 
 	asm volatile(
+		"	spm 0\n" /* pckmo doesn't change the cc */
 		/* Parameter registers are ignored, but may not be 0 */
 		"0:	.insn	rrf,%[opc] << 16,2,2,2,0\n"
 		"	brc	1,0b\n"	/* handle partial completion */
@@ -157,6 +161,12 @@ static inline int cpacf_query(unsigned int opcode, unsigned int func)
 		if (!test_facility(17))	/* check for MSA */
 			return 0;
 		break;
+	case CPACF_PCKMO:
+		if (!test_facility(76))	/* check for MSA3 */
+			return 0;
+		break;
+	case CPACF_KMF:
+	case CPACF_KMO:
 	case CPACF_PCC:
 	case CPACF_KMCTR:
 		if (!test_facility(77))	/* check for MSA4 */
-- 
2.5.5

From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/3] s390/cpacf: Introduce kma instruction
Date: Wed, 26 Apr 2017 14:38:14 +0200
Message-ID: <1493210295-58687-3-git-send-email-borntraeger@de.ibm.com>
References: <1493210295-58687-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1493210295-58687-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

Provide a kma instruction definition for use by callers of __cpacf_query.

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/cpacf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
index 175a5d7..31cac7d 100644
--- a/arch/s390/include/asm/cpacf.h
+++ b/arch/s390/include/asm/cpacf.h
@@ -26,6 +26,7 @@
 #define CPACF_PCC		0xb92c		/* MSA4 */
 #define CPACF_KMCTR		0xb92d		/* MSA4 */
 #define CPACF_PPNO		0xb93c		/* MSA5 */
+#define CPACF_KMA		0xb929		/* MSA8 */
 
 /*
  * En/decryption modifier bits
-- 
2.7.4

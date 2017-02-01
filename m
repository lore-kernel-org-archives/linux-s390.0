From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 04/12] KVM: s390: get rid of bogus cc initialization
Date: Wed,  1 Feb 2017 12:38:06 +0100
Message-ID: <1485949094-138708-5-git-send-email-borntraeger@de.ibm.com>
References: <1485949094-138708-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1485949094-138708-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The plo inline assembly has a cc output operand that is always written
to and is also as such an operand declared. Therefore the compiler is
free to omit the rather pointless and misleading initialization.

Get rid of this.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e513081..4f74511 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -217,7 +217,7 @@ static void allow_cpu_feat(unsigned long nr)
 static inline int plo_test_bit(unsigned char nr)
 {
 	register unsigned long r0 asm("0") = (unsigned long) nr | 0x100;
-	int cc = 3; /* subfunction not available */
+	int cc;
 
 	asm volatile(
 		/* Parameter registers are ignored for "test bit" */
-- 
2.7.4

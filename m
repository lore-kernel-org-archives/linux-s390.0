From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/8] KVM: s390: fix pfmf non-quiescing control handling
Date: Fri, 26 Jul 2013 15:04:01 +0200
Message-ID: <1374843847-5046-3-git-send-email-borntraeger@de.ibm.com>
References: <1374843847-5046-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1374843847-5046-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Fix the test within handle_pfmf() if the host has the NQ key-setting
facility installed.
Right now the code would incorrectly generate a program check in the
guest if the NQ control bit for a pfmf request was set and if the host
has the NQ key-setting facility installed.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 0da3e6e..4cdc54e 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -16,6 +16,7 @@
 #include <linux/errno.h>
 #include <linux/compat.h>
 #include <asm/asm-offsets.h>
+#include <asm/facility.h>
 #include <asm/current.h>
 #include <asm/debug.h>
 #include <asm/ebcdic.h>
@@ -532,8 +533,7 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	/* Only provide non-quiescing support if the host supports it */
-	if (vcpu->run->s.regs.gprs[reg1] & PFMF_NQ &&
-	    S390_lowcore.stfl_fac_list & 0x00020000)
+	if (vcpu->run->s.regs.gprs[reg1] & PFMF_NQ && !test_facility(14))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	/* No support for conditional-SSKE */
-- 
1.8.3.1

From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 06/16] KVM: s390: Improve vcpu event debugging for diagnoses
Date: Wed, 29 Jul 2015 11:05:56 +0200
Message-ID: <1438160766-108179-7-git-send-email-borntraeger@de.ibm.com>
References: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Let's add a vcpu event for the page reference handling and change
the default debugging level for the ipl diagnose. Both are not
frequent AND change the global state, so lets log them always.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/diag.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 9806616..1871754 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -75,6 +75,8 @@ static int __diag_page_ref_service(struct kvm_vcpu *vcpu)
 	u16 rx = (vcpu->arch.sie_block->ipa & 0xf0) >> 4;
 	u16 ry = (vcpu->arch.sie_block->ipa & 0x0f);
 
+	VCPU_EVENT(vcpu, 3, "diag page reference parameter block at 0x%llx",
+		   vcpu->run->s.regs.gprs[rx]);
 	vcpu->stat.diagnose_258++;
 	if (vcpu->run->s.regs.gprs[rx] & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
@@ -175,7 +177,7 @@ static int __diag_ipl_functions(struct kvm_vcpu *vcpu)
 	unsigned int reg = vcpu->arch.sie_block->ipa & 0xf;
 	unsigned long subcode = vcpu->run->s.regs.gprs[reg] & 0xffff;
 
-	VCPU_EVENT(vcpu, 5, "diag ipl functions, subcode %lx", subcode);
+	VCPU_EVENT(vcpu, 3, "diag ipl functions, subcode %lx", subcode);
 	vcpu->stat.diagnose_308++;
 	switch (subcode) {
 	case 3:
-- 
2.3.0

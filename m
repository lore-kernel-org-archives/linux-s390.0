From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 1/8] KVM: s390: also set guest pages back to stable on kexec/kdump
Date: Wed,  9 Apr 2014 12:44:51 +0200
Message-ID: <1397040298-59306-2-git-send-email-borntraeger@de.ibm.com>
References: <1397040298-59306-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397040298-59306-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

We need to reset the usage state of the pages on kexec/kdump,
which use subcode 0 and 1. We will only do the cmma reset in
the kernel, everything else is done in userspace as before.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/diag.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 03a05ff..08dfc83 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -167,6 +167,10 @@ static int __diag_ipl_functions(struct kvm_vcpu *vcpu)
 
 	VCPU_EVENT(vcpu, 5, "diag ipl functions, subcode %lx", subcode);
 	switch (subcode) {
+	case 0:
+	case 1:
+		page_table_reset_pgste(current->mm, 0, TASK_SIZE);
+		return -EOPNOTSUPP;
 	case 3:
 		vcpu->run->s390_reset_flags = KVM_S390_RESET_CLEAR;
 		page_table_reset_pgste(current->mm, 0, TASK_SIZE);
-- 
1.8.4.2

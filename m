From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 06/10] KVM: s390: force ibc into valid range
Date: Mon,  9 May 2016 11:20:17 +0200
Message-ID: <1462785621-12600-7-git-send-email-borntraeger@de.ibm.com>
References: <1462785621-12600-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1462785621-12600-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Some hardware variants will round the ibc value up/down themselves,
others will report a validity intercept. Let's always round it up/down.

This patch will also make sure that the ibc is set to 0 in case we don't
have ibc support (lowest_ibc == 0).

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 0d2f242..eb52b36 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -638,6 +638,7 @@ static int kvm_s390_get_tod(struct kvm *kvm, struct kvm_device_attr *attr)
 static int kvm_s390_set_processor(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	struct kvm_s390_vm_cpu_processor *proc;
+	u16 lowest_ibc, unblocked_ibc;
 	int ret = 0;
 
 	mutex_lock(&kvm->lock);
@@ -653,7 +654,16 @@ static int kvm_s390_set_processor(struct kvm *kvm, struct kvm_device_attr *attr)
 	if (!copy_from_user(proc, (void __user *)attr->addr,
 			    sizeof(*proc))) {
 		kvm->arch.model.cpuid = proc->cpuid;
-		kvm->arch.model.ibc = proc->ibc;
+		lowest_ibc = sclp.ibc >> 16 & 0xfff;
+		unblocked_ibc = sclp.ibc & 0xfff;
+		if (lowest_ibc) {
+			if (proc->ibc > unblocked_ibc)
+				kvm->arch.model.ibc = unblocked_ibc;
+			else if (proc->ibc < lowest_ibc)
+				kvm->arch.model.ibc = lowest_ibc;
+			else
+				kvm->arch.model.ibc = proc->ibc;
+		}
 		memcpy(kvm->arch.model.fac_list, proc->fac_list,
 		       S390_ARCH_FAC_LIST_SIZE_BYTE);
 	} else
-- 
2.5.5

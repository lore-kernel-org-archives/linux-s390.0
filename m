From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 22/24] KVM: s390: avoid memory leaks if __inject_vm() fails
Date: Fri, 23 Jan 2015 13:37:20 +0100
Message-ID: <1422016642-52513-4-git-send-email-borntraeger@de.ibm.com>
References: <1422016642-52513-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1422016642-52513-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Graf <agraf@suse.de>, David Hildenbrand <dahi@linux.vnet.ibm.com>, stable@vger.kernel.org, #@tuxmaker.boeblingen.de.ibm.com, v3.15+@tuxmaker.boeblingen.de.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We have to delete the allocated interrupt info if __inject_vm() fails.

Otherwise user space can keep flooding kvm with floating interrupts and
provoke more and more memory leaks.

Reported-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Reviewed-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org # v3.15+
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index a6cb238..6d7513e 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1277,6 +1277,7 @@ int kvm_s390_inject_vm(struct kvm *kvm,
 		       struct kvm_s390_interrupt *s390int)
 {
 	struct kvm_s390_interrupt_info *inti;
+	int rc;
 
 	inti = kzalloc(sizeof(*inti), GFP_KERNEL);
 	if (!inti)
@@ -1324,7 +1325,10 @@ int kvm_s390_inject_vm(struct kvm *kvm,
 	trace_kvm_s390_inject_vm(s390int->type, s390int->parm, s390int->parm64,
 				 2);
 
-	return __inject_vm(kvm, inti);
+	rc = __inject_vm(kvm, inti);
+	if (rc)
+		kfree(inti);
+	return rc;
 }
 
 void kvm_s390_reinject_io_int(struct kvm *kvm,
-- 
1.9.3

From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/9] KVM: s390: Make the simple ipte mutex specific to a VM instead of global
Date: Tue, 28 Oct 2014 20:39:51 +0100
Message-ID: <1414525199-53989-2-git-send-email-borntraeger@de.ibm.com>
References: <1414525199-53989-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1414525199-53989-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

The ipte-locking should be done for each VM seperately, not globally.
This way we avoid possible congestions when the simple ipte-lock is used
and multiple VMs are running.

Suggested-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  2 ++
 arch/s390/kvm/gaccess.c          | 20 +++++++++-----------
 arch/s390/kvm/kvm-s390.c         |  1 +
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 2175f911..584b820 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -434,6 +434,8 @@ struct kvm_arch{
 	int user_cpu_state_ctrl;
 	struct s390_io_adapter *adapters[MAX_S390_IO_ADAPTERS];
 	wait_queue_head_t ipte_wq;
+	int ipte_lock_count;
+	struct mutex ipte_mutex;
 	spinlock_t start_stop_lock;
 	struct kvm_s390_crypto crypto;
 };
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 0f961a1..c1424e8 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -207,8 +207,6 @@ union raddress {
 	unsigned long pfra : 52; /* Page-Frame Real Address */
 };
 
-static int ipte_lock_count;
-static DEFINE_MUTEX(ipte_mutex);
 
 int ipte_lock_held(struct kvm_vcpu *vcpu)
 {
@@ -216,16 +214,16 @@ int ipte_lock_held(struct kvm_vcpu *vcpu)
 
 	if (vcpu->arch.sie_block->eca & 1)
 		return ic->kh != 0;
-	return ipte_lock_count != 0;
+	return vcpu->kvm->arch.ipte_lock_count != 0;
 }
 
 static void ipte_lock_simple(struct kvm_vcpu *vcpu)
 {
 	union ipte_control old, new, *ic;
 
-	mutex_lock(&ipte_mutex);
-	ipte_lock_count++;
-	if (ipte_lock_count > 1)
+	mutex_lock(&vcpu->kvm->arch.ipte_mutex);
+	vcpu->kvm->arch.ipte_lock_count++;
+	if (vcpu->kvm->arch.ipte_lock_count > 1)
 		goto out;
 	ic = &vcpu->kvm->arch.sca->ipte_control;
 	do {
@@ -238,16 +236,16 @@ static void ipte_lock_simple(struct kvm_vcpu *vcpu)
 		new.k = 1;
 	} while (cmpxchg(&ic->val, old.val, new.val) != old.val);
 out:
-	mutex_unlock(&ipte_mutex);
+	mutex_unlock(&vcpu->kvm->arch.ipte_mutex);
 }
 
 static void ipte_unlock_simple(struct kvm_vcpu *vcpu)
 {
 	union ipte_control old, new, *ic;
 
-	mutex_lock(&ipte_mutex);
-	ipte_lock_count--;
-	if (ipte_lock_count)
+	mutex_lock(&vcpu->kvm->arch.ipte_mutex);
+	vcpu->kvm->arch.ipte_lock_count--;
+	if (vcpu->kvm->arch.ipte_lock_count)
 		goto out;
 	ic = &vcpu->kvm->arch.sca->ipte_control;
 	do {
@@ -256,7 +254,7 @@ static void ipte_unlock_simple(struct kvm_vcpu *vcpu)
 	} while (cmpxchg(&ic->val, old.val, new.val) != old.val);
 	wake_up(&vcpu->kvm->arch.ipte_wq);
 out:
-	mutex_unlock(&ipte_mutex);
+	mutex_unlock(&vcpu->kvm->arch.ipte_mutex);
 }
 
 static void ipte_lock_siif(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 55aade4..3e83d4b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -453,6 +453,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	spin_lock_init(&kvm->arch.float_int.lock);
 	INIT_LIST_HEAD(&kvm->arch.float_int.list);
 	init_waitqueue_head(&kvm->arch.ipte_wq);
+	mutex_init(&kvm->arch.ipte_mutex);
 
 	debug_register_view(kvm->arch.dbf, &debug_sprintf_view);
 	VM_EVENT(kvm, 3, "%s", "vm created");
-- 
1.9.3

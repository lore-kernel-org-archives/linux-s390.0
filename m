From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/1] KVM: s390: fix ais handling vs cpu model
Date: Thu,  8 Jun 2017 15:57:31 +0200
Message-ID: <1496930251-16710-2-git-send-email-borntraeger@de.ibm.com>
References: <1496930251-16710-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1496930251-16710-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

If ais is disabled via cpumodel, we must act accordingly, even if
KVM_CAP_S390_AIS was enabled.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 1 -
 arch/s390/kvm/interrupt.c        | 4 ++--
 arch/s390/kvm/kvm-s390.c         | 2 --
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 426614a..65d07ac 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -541,7 +541,6 @@ struct kvm_s390_float_interrupt {
 	struct mutex ais_lock;
 	u8 simm;
 	u8 nimm;
-	int ais_enabled;
 };
 
 struct kvm_hw_wp_info_arch {
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index caf15c8a..2d120fe 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2160,7 +2160,7 @@ static int modify_ais_mode(struct kvm *kvm, struct kvm_device_attr *attr)
 	struct kvm_s390_ais_req req;
 	int ret = 0;
 
-	if (!fi->ais_enabled)
+	if (!test_kvm_facility(kvm, 72))
 		return -ENOTSUPP;
 
 	if (copy_from_user(&req, (void __user *)attr->addr, sizeof(req)))
@@ -2204,7 +2204,7 @@ static int kvm_s390_inject_airq(struct kvm *kvm,
 	};
 	int ret = 0;
 
-	if (!fi->ais_enabled || !adapter->suppressible)
+	if (!test_kvm_facility(kvm, 72) || !adapter->suppressible)
 		return kvm_s390_inject_vm(kvm, &s390int);
 
 	mutex_lock(&fi->ais_lock);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 689ac48..f28e2e7 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -558,7 +558,6 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 		} else {
 			set_kvm_facility(kvm->arch.model.fac_mask, 72);
 			set_kvm_facility(kvm->arch.model.fac_list, 72);
-			kvm->arch.float_int.ais_enabled = 1;
 			r = 0;
 		}
 		mutex_unlock(&kvm->lock);
@@ -1533,7 +1532,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	mutex_init(&kvm->arch.float_int.ais_lock);
 	kvm->arch.float_int.simm = 0;
 	kvm->arch.float_int.nimm = 0;
-	kvm->arch.float_int.ais_enabled = 0;
 	spin_lock_init(&kvm->arch.float_int.lock);
 	for (i = 0; i < FIRQ_LIST_COUNT; i++)
 		INIT_LIST_HEAD(&kvm->arch.float_int.lists[i]);
-- 
2.7.4

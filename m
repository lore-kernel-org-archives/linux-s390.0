From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/7] KVM: CPACF: Enable MSA4 instructions for kvm guest
Date: Wed, 10 Sep 2014 15:53:48 +0200
Message-ID: <1410357234-8937-2-git-send-email-borntraeger@de.ibm.com>
References: <1410357234-8937-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1410357234-8937-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>

We have to provide a per guest crypto block for the CPUs to
enable MSA4 instructions. According to icainfo on z196 or
later this enables CCM-AES-128, CMAC-AES-128, CMAC-AES-192
and CMAC-AES-256.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[split MSA4/protected key into two patches]
---
 arch/s390/include/asm/kvm_host.h | 14 +++++++++++++-
 arch/s390/kvm/kvm-s390.c         | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index a76a124..1a6f6fd 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -157,7 +157,9 @@ struct kvm_s390_sie_block {
 	__u8	armid;			/* 0x00e3 */
 	__u8	reservede4[4];		/* 0x00e4 */
 	__u64	tecmc;			/* 0x00e8 */
-	__u8	reservedf0[16];		/* 0x00f0 */
+	__u8	reservedf0[12];		/* 0x00f0 */
+#define CRYCB_FORMAT1 0x00000001
+	__u32	crycbd;			/* 0x00fc */
 	__u64	gcr[16];		/* 0x0100 */
 	__u64	gbea;			/* 0x0180 */
 	__u8	reserved188[24];	/* 0x0188 */
@@ -410,6 +412,15 @@ struct s390_io_adapter {
 #define MAX_S390_IO_ADAPTERS ((MAX_ISC + 1) * 8)
 #define MAX_S390_ADAPTER_MAPS 256
 
+struct kvm_s390_crypto {
+	struct kvm_s390_crypto_cb *crycb;
+	__u32 crycbd;
+};
+
+struct kvm_s390_crypto_cb {
+	__u8    reserved00[128];                /* 0x0000 */
+};
+
 struct kvm_arch{
 	struct sca_block *sca;
 	debug_info_t *dbf;
@@ -423,6 +434,7 @@ struct kvm_arch{
 	struct s390_io_adapter *adapters[MAX_S390_IO_ADAPTERS];
 	wait_queue_head_t ipte_wq;
 	spinlock_t start_stop_lock;
+	struct kvm_s390_crypto crypto;
 };
 
 #define KVM_HVA_ERR_BAD		(-1UL)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 628e992..2037738 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -392,6 +392,22 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	return r;
 }
 
+static int kvm_s390_crypto_init(struct kvm *kvm)
+{
+	if (!test_vfacility(76))
+		return 0;
+
+	kvm->arch.crypto.crycb = kzalloc(sizeof(*kvm->arch.crypto.crycb),
+					 GFP_KERNEL | GFP_DMA);
+	if (!kvm->arch.crypto.crycb)
+		return -ENOMEM;
+
+	kvm->arch.crypto.crycbd = (__u32) (unsigned long) kvm->arch.crypto.crycb |
+				  CRYCB_FORMAT1;
+
+	return 0;
+}
+
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
 	int rc;
@@ -429,6 +445,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (!kvm->arch.dbf)
 		goto out_nodbf;
 
+	if (kvm_s390_crypto_init(kvm) < 0)
+		goto out_crypto;
+
 	spin_lock_init(&kvm->arch.float_int.lock);
 	INIT_LIST_HEAD(&kvm->arch.float_int.list);
 	init_waitqueue_head(&kvm->arch.ipte_wq);
@@ -453,6 +472,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	return 0;
 out_nogmap:
+	kfree(kvm->arch.crypto.crycb);
+out_crypto:
 	debug_unregister(kvm->arch.dbf);
 out_nodbf:
 	free_page((unsigned long)(kvm->arch.sca));
@@ -507,6 +528,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_free_vcpus(kvm);
 	free_page((unsigned long)(kvm->arch.sca));
 	debug_unregister(kvm->arch.dbf);
+	kfree(kvm->arch.crypto.crycb);
 	if (!kvm_is_ucontrol(kvm))
 		gmap_free(kvm->arch.gmap);
 	kvm_s390_destroy_adapters(kvm);
@@ -588,6 +610,14 @@ int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
+{
+	if (!test_vfacility(76))
+		return;
+
+	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
+}
+
 void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
 {
 	free_page(vcpu->arch.sie_block->cbrlo);
@@ -634,6 +664,9 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	vcpu->arch.ckc_timer.function = kvm_s390_idle_wakeup;
 	get_cpu_id(&vcpu->arch.cpu_id);
 	vcpu->arch.cpu_id.version = 0xff;
+
+	kvm_s390_vcpu_crypto_setup(vcpu);
+
 	return rc;
 }
 
-- 
1.8.4.2

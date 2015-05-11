From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 5/9] KVM: s390: make exit_sie_sync more robust
Date: Mon, 11 May 2015 10:44:33 +0200
Message-ID: <1431333877-28700-6-git-send-email-borntraeger@de.ibm.com>
References: <1431333877-28700-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1431333877-28700-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

exit_sie_sync is used to kick CPUs out of SIE and prevent reentering at
any point in time. This is used to reload the prefix pages and to
set the IBS stuff in a way that guarantees that after this function
returns we are no longer in SIE. All current users trigger KVM requests.

The request must be set before we block the CPUs to avoid races. Let's
make this implicit by adding the request into a new function
kvm_s390_sync_requests that replaces exit_sie_sync and split out
s390_vcpu_block and s390_vcpu_unblock, that can be used to keep
CPUs out of SIE independent of requests.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  3 ++-
 arch/s390/kernel/entry.S         |  2 +-
 arch/s390/kvm/kvm-s390.c         | 28 ++++++++++++++++++----------
 arch/s390/kvm/kvm-s390.h         |  2 +-
 4 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 1011ac1..444c412 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -96,7 +96,8 @@ struct kvm_s390_sie_block {
 #define PROG_IN_SIE (1<<0)
 	__u32	prog0c;			/* 0x000c */
 	__u8	reserved10[16];		/* 0x0010 */
-#define PROG_BLOCK_SIE 0x00000001
+#define PROG_BLOCK_SIE	(1<<0)
+#define PROG_REQUEST	(1<<1)
 	atomic_t prog20;		/* 0x0020 */
 	__u8	reserved24[4];		/* 0x0024 */
 	__u64	cputm;			/* 0x0028 */
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 99b44ac..3238893 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -1005,7 +1005,7 @@ ENTRY(sie64a)
 .Lsie_gmap:
 	lg	%r14,__SF_EMPTY(%r15)		# get control block pointer
 	oi	__SIE_PROG0C+3(%r14),1		# we are going into SIE now
-	tm	__SIE_PROG20+3(%r14),1		# last exit...
+	tm	__SIE_PROG20+3(%r14),3		# last exit...
 	jnz	.Lsie_done
 	LPP	__SF_EMPTY(%r15)		# set guest id
 	sie	0(%r14)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 142d9b4..9bc57af 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1424,6 +1424,16 @@ void s390_vcpu_unblock(struct kvm_vcpu *vcpu)
 	atomic_clear_mask(PROG_BLOCK_SIE, &vcpu->arch.sie_block->prog20);
 }
 
+static void kvm_s390_vcpu_request(struct kvm_vcpu *vcpu)
+{
+	atomic_set_mask(PROG_REQUEST, &vcpu->arch.sie_block->prog20);
+}
+
+static void kvm_s390_vcpu_request_handled(struct kvm_vcpu *vcpu)
+{
+	atomic_clear_mask(PROG_REQUEST, &vcpu->arch.sie_block->prog20);
+}
+
 /*
  * Kick a guest cpu out of SIE and wait until SIE is not running.
  * If the CPU is not running (e.g. waiting as idle) the function will
@@ -1435,10 +1445,11 @@ void exit_sie(struct kvm_vcpu *vcpu)
 		cpu_relax();
 }
 
-/* Kick a guest cpu out of SIE and prevent SIE-reentry */
-void exit_sie_sync(struct kvm_vcpu *vcpu)
+/* Kick a guest cpu out of SIE to process a request synchronously */
+void kvm_s390_sync_request(int req, struct kvm_vcpu *vcpu)
 {
-	s390_vcpu_block(vcpu);
+	kvm_make_request(req, vcpu);
+	kvm_s390_vcpu_request(vcpu);
 	exit_sie(vcpu);
 }
 
@@ -1452,8 +1463,7 @@ static void kvm_gmap_notifier(struct gmap *gmap, unsigned long address)
 		/* match against both prefix pages */
 		if (kvm_s390_get_prefix(vcpu) == (address & ~0x1000UL)) {
 			VCPU_EVENT(vcpu, 2, "gmap notifier for %lx", address);
-			kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
-			exit_sie_sync(vcpu);
+			kvm_s390_sync_request(KVM_REQ_MMU_RELOAD, vcpu);
 		}
 	}
 }
@@ -1728,7 +1738,7 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 	if (!vcpu->requests)
 		return 0;
 retry:
-	s390_vcpu_unblock(vcpu);
+	kvm_s390_vcpu_request_handled(vcpu);
 	/*
 	 * We use MMU_RELOAD just to re-arm the ipte notifier for the
 	 * guest prefix page. gmap_ipte_notify will wait on the ptl lock.
@@ -2213,8 +2223,7 @@ int kvm_s390_vcpu_store_adtl_status(struct kvm_vcpu *vcpu, unsigned long addr)
 static void __disable_ibs_on_vcpu(struct kvm_vcpu *vcpu)
 {
 	kvm_check_request(KVM_REQ_ENABLE_IBS, vcpu);
-	kvm_make_request(KVM_REQ_DISABLE_IBS, vcpu);
-	exit_sie_sync(vcpu);
+	kvm_s390_sync_request(KVM_REQ_DISABLE_IBS, vcpu);
 }
 
 static void __disable_ibs_on_all_vcpus(struct kvm *kvm)
@@ -2230,8 +2239,7 @@ static void __disable_ibs_on_all_vcpus(struct kvm *kvm)
 static void __enable_ibs_on_vcpu(struct kvm_vcpu *vcpu)
 {
 	kvm_check_request(KVM_REQ_DISABLE_IBS, vcpu);
-	kvm_make_request(KVM_REQ_ENABLE_IBS, vcpu);
-	exit_sie_sync(vcpu);
+	kvm_s390_sync_request(KVM_REQ_ENABLE_IBS, vcpu);
 }
 
 void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index ca108b9..8edca85 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -214,7 +214,7 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu);
 void s390_vcpu_block(struct kvm_vcpu *vcpu);
 void s390_vcpu_unblock(struct kvm_vcpu *vcpu);
 void exit_sie(struct kvm_vcpu *vcpu);
-void exit_sie_sync(struct kvm_vcpu *vcpu);
+void kvm_s390_sync_request(int req, struct kvm_vcpu *vcpu);
 int kvm_s390_vcpu_setup_cmma(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu);
 /* is cmma enabled */
-- 
2.3.0

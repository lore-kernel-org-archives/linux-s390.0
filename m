From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v8 06/22] KVM: s390: introduce and use KVM_REQ_VSIE_RESTART
Date: Wed,  8 Aug 2018 10:44:16 -0400
Message-ID: <1533739472-7172-7-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <david@redhat.com>

When we change the crycb (or execution controls), we also have to make sure
that the vSIE shadow datastructures properly consider the changed
values before rerunning the vSIE. We can achieve that by simply using a
VCPU request now.

This has to be a synchronous request (== handled before entering the
(v)SIE again).

The request will make sure that the vSIE handler is left, and that the
request will be processed (NOP), therefore forcing a reload of all
vSIE data (including rebuilding the crycb) when re-entering the vSIE
interception handler the next time.

Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |    1 +
 arch/s390/kvm/kvm-s390.c         |    7 ++++++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index a2188e3..af39561 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -44,6 +44,7 @@
 #define KVM_REQ_ICPT_OPEREXC	KVM_ARCH_REQ(2)
 #define KVM_REQ_START_MIGRATION KVM_ARCH_REQ(3)
 #define KVM_REQ_STOP_MIGRATION  KVM_ARCH_REQ(4)
+#define KVM_REQ_VSIE_RESTART	KVM_ARCH_REQ(5)
 
 #define SIGP_CTRL_C		0x80
 #define SIGP_CTRL_SCN_MASK	0x3f
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 6df2d12..19f4f44 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -798,8 +798,11 @@ void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
 
 	kvm_s390_vcpu_block_all(kvm);
 
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(i, vcpu, kvm) {
 		kvm_s390_vcpu_crypto_setup(vcpu);
+		/* recreate the shadow crycb by leaving the VSIE handler */
+		kvm_s390_sync_request(KVM_REQ_VSIE_RESTART, vcpu);
+	}
 
 	kvm_s390_vcpu_unblock_all(kvm);
 }
@@ -3090,6 +3093,8 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 
 	/* nothing to do, just clear the request */
 	kvm_clear_request(KVM_REQ_UNHALT, vcpu);
+	/* we left the vsie handler, nothing to do, just clear the request */
+	kvm_clear_request(KVM_REQ_VSIE_RESTART, vcpu);
 
 	return 0;
 }
-- 
1.7.1

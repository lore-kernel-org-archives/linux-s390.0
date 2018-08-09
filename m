Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 2/2] KVM: s390: introduce and use KVM_REQ_VSIE_RESTART
Date: Thu,  9 Aug 2018 10:06:01 +0200
Message-Id: <20180809080601.31797-3-david@redhat.com>
In-Reply-To: <20180809080601.31797-1-david@redhat.com>
References: <20180809080601.31797-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

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

Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/kvm_host.h | 1 +
 arch/s390/kvm/kvm-s390.c         | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 29c940bf8506..75d39628f21d 100644
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
index c87734a31fdb..2fdc017d91f0 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -842,8 +842,11 @@ void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
 
 	kvm_s390_vcpu_block_all(kvm);
 
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(i, vcpu, kvm) {
 		kvm_s390_vcpu_crypto_setup(vcpu);
+		/* recreate the shadow crycb by leaving the VSIE handler */
+		kvm_s390_sync_request(KVM_REQ_VSIE_RESTART, vcpu);
+	}
 
 	kvm_s390_vcpu_unblock_all(kvm);
 }
@@ -3201,6 +3204,8 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 
 	/* nothing to do, just clear the request */
 	kvm_clear_request(KVM_REQ_UNHALT, vcpu);
+	/* we left the vsie handler, nothing to do, just clear the request */
+	kvm_clear_request(KVM_REQ_VSIE_RESTART, vcpu);
 
 	return 0;
 }
-- 
2.17.1

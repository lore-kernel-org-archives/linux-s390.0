From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 07/12] KVM: s390: abstract adapter interruption word generation from ISC
Date: Tue, 16 Jan 2018 21:02:12 +0100
Message-ID: <20180116200217.211897-8-borntraeger@de.ibm.com>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180116200217.211897-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

The function isc_to_int_word() allows the generation of interruption
words for adapter interrupts.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 6c34133f3842..f4d81730d52d 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -198,6 +198,11 @@ static uint64_t isc_to_isc_bits(int isc)
 	return (0x80 >> isc) << 24;
 }
 
+static inline u32 isc_to_int_word(u8 isc)
+{
+	return ((u32)isc << 27) | 0x80000000;
+}
+
 static inline u8 int_word_to_isc(u32 int_word)
 {
 	return (int_word & 0x38000000) >> 27;
@@ -969,7 +974,7 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
 		if (kvm_s390_gisa_tac_ipm_gisc(vcpu->kvm->arch.gisa, isc)) {
 			VCPU_EVENT(vcpu, 4, "%s isc %u", "deliver: I/O (AI/gisa)", isc);
 			memset(&io, 0, sizeof(io));
-			io.io_int_word = (isc << 27) | 0x80000000;
+			io.io_int_word = isc_to_int_word(isc);
 			vcpu->stat.deliver_io_int++;
 			trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
 				KVM_S390_INT_IO(1, 0, 0, 0),
@@ -2280,7 +2285,7 @@ static int kvm_s390_inject_airq(struct kvm *kvm,
 	struct kvm_s390_interrupt s390int = {
 		.type = KVM_S390_INT_IO(1, 0, 0, 0),
 		.parm = 0,
-		.parm64 = (adapter->isc << 27) | 0x80000000,
+		.parm64 = isc_to_int_word(adapter->isc),
 	};
 	int ret = 0;
 
-- 
2.13.4

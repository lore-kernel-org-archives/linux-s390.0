From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH] KVM: s390: Fix handling of iscs.
Date: Thu,  7 Feb 2013 13:20:52 +0100
Message-ID: <1360239652-52350-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1360239652-52350-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1360239652-52350-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

There are two ways to express an interruption subclass:
- As a bitmask, as used in cr6.
- As a number, as used in the I/O interruption word.

Unfortunately, we have treated the I/O interruption word as if it
contained the bitmask as well, which went unnoticed so far as
- (not-yet-released) qemu made the same mistake, and
- Linux guest kernels don't check the isc value in the I/O interruption
  word for subchannel interrupts.

Make sure that we treat the I/O interruption word correctly.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 9a12835..2f6ccb0 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -55,6 +55,13 @@ static int psw_interrupts_disabled(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+static u64 int_word_to_isc_bits(u32 int_word)
+{
+	u8 isc = (int_word & 0x38000000) >> 27;
+
+	return (0x80 >> isc) << 24;
+}
+
 static int __interrupt_is_deliverable(struct kvm_vcpu *vcpu,
 				      struct kvm_s390_interrupt_info *inti)
 {
@@ -96,7 +103,8 @@ static int __interrupt_is_deliverable(struct kvm_vcpu *vcpu,
 	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
 		if (psw_ioint_disabled(vcpu))
 			return 0;
-		if (vcpu->arch.sie_block->gcr[6] & inti->io.io_int_word)
+		if (vcpu->arch.sie_block->gcr[6] &
+		    int_word_to_isc_bits(inti->io.io_int_word))
 			return 1;
 		return 0;
 	default:
@@ -724,7 +732,8 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 	list_for_each_entry(iter, &fi->list, list) {
 		if (!is_ioint(iter->type))
 			continue;
-		if (cr6 && ((cr6 & iter->io.io_int_word) == 0))
+		if (cr6 &&
+		    ((cr6 & int_word_to_isc_bits(iter->io.io_int_word)) == 0))
 			continue;
 		if (schid) {
 			if (((schid & 0x00000000ffff0000) >> 16) !=
@@ -811,11 +820,14 @@ int kvm_s390_inject_vm(struct kvm *kvm,
 	if (!is_ioint(inti->type))
 		list_add_tail(&inti->list, &fi->list);
 	else {
+		u64 isc_bits = int_word_to_isc_bits(inti->io.io_int_word);
+
 		/* Keep I/O interrupts sorted in isc order. */
 		list_for_each_entry(iter, &fi->list, list) {
 			if (!is_ioint(iter->type))
 				continue;
-			if (iter->io.io_int_word <= inti->io.io_int_word)
+			if (int_word_to_isc_bits(iter->io.io_int_word)
+			    <= isc_bits)
 				continue;
 			break;
 		}
-- 
1.7.12.4

From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 07/11] KVM: s390: fix stsi exception handling
Date: Mon, 25 Mar 2013 17:22:54 +0100
Message-ID: <1364228578-20528-8-git-send-email-cornelia.huck@de.ibm.com>
References: <1364228578-20528-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1364228578-20528-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

In case of an exception the guest psw condition code should be left alone.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Acked-By: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/priv.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 23a8370..de1b1b6 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -343,8 +343,8 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 	int fc = (vcpu->run->s.regs.gprs[0] & 0xf0000000) >> 28;
 	int sel1 = vcpu->run->s.regs.gprs[0] & 0xff;
 	int sel2 = vcpu->run->s.regs.gprs[1] & 0xffff;
+	unsigned long mem = 0;
 	u64 operand2;
-	unsigned long mem;
 	int rc = 0;
 
 	vcpu->stat.instruction_stsi++;
@@ -364,36 +364,36 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 	case 2:
 		mem = get_zeroed_page(GFP_KERNEL);
 		if (!mem)
-			goto out_fail;
+			goto out_no_data;
 		if (stsi((void *) mem, fc, sel1, sel2))
-			goto out_mem;
+			goto out_no_data;
 		break;
 	case 3:
 		if (sel1 != 2 || sel2 != 2)
-			goto out_fail;
+			goto out_no_data;
 		mem = get_zeroed_page(GFP_KERNEL);
 		if (!mem)
-			goto out_fail;
+			goto out_no_data;
 		handle_stsi_3_2_2(vcpu, (void *) mem);
 		break;
 	default:
-		goto out_fail;
+		goto out_no_data;
 	}
 
 	if (copy_to_guest_absolute(vcpu, operand2, (void *) mem, PAGE_SIZE)) {
 		rc = kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-		goto out_mem;
+		goto out_exception;
 	}
 	trace_kvm_s390_handle_stsi(vcpu, fc, sel1, sel2, operand2);
 	free_page(mem);
 	vcpu->arch.sie_block->gpsw.mask &= ~(3ul << 44);
 	vcpu->run->s.regs.gprs[0] = 0;
 	return 0;
-out_mem:
-	free_page(mem);
-out_fail:
+out_no_data:
 	/* condition code 3 */
 	vcpu->arch.sie_block->gpsw.mask |= 3ul << 44;
+out_exception:
+	free_page(mem);
 	return rc;
 }
 
-- 
1.7.12.4

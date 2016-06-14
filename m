From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 14 Jun 2016 18:57:24 +0000
Subject: [GIT PULL 47/52] KVM: s390: pfmf: take care of amode when setting reg2
Message-Id: <201606141857.u5EIs1o5000783@mx0b-001b2d01.pphosted.com>
In-Reply-To: <201606141857.u5EIs0dO141856@mx0a-001b2d01.pphosted.com>
References: <201606141857.u5EIs0dO141856@mx0a-001b2d01.pphosted.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Depending on the addressing mode, we must not overwrite bit 0-31 of the
register. In addition, 24 bit and 31 bit have to set certain bits to 0,
which is guaranteed by converting the end address to an effective
address.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 5c926b7..71fa603 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -733,8 +733,15 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 
 		start += PAGE_SIZE;
 	}
-	if (vcpu->run->s.regs.gprs[reg1] & PFMF_FSC)
-		vcpu->run->s.regs.gprs[reg2] = end;
+	if (vcpu->run->s.regs.gprs[reg1] & PFMF_FSC) {
+		if (psw_bits(vcpu->arch.sie_block->gpsw).eaba == PSW_AMODE_64BIT) {
+			vcpu->run->s.regs.gprs[reg2] = end;
+		} else {
+			vcpu->run->s.regs.gprs[reg2] &= ~0xffffffffUL;
+			end = kvm_s390_logical_to_effective(vcpu, end);
+			vcpu->run->s.regs.gprs[reg2] |= end;
+		}
+	}
 	return 0;
 }
 
-- 
2.5.5

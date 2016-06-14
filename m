From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 47/52] KVM: s390: pfmf: take care of amode when setting reg2
Date: Tue, 14 Jun 2016 20:57:24 +0200
Message-ID: <201606141857.u5EIs0dO141856@mx0a-001b2d01.pphosted.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
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

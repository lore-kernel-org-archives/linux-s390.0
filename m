From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/2] KVM: s390: sthyi: fix specification exception detection
Date: Mon, 21 Aug 2017 14:27:45 +0200
Message-ID: <1503318465-19013-3-git-send-email-borntraeger@de.ibm.com>
References: <1503318465-19013-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1503318465-19013-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

sthyi should only generate a specification exception if the function
code is zero and the response buffer is not on a 4k boundary.

The current code would also test for unknown function codes if the
response buffer, that is currently only defined for function code 0,
is not on a 4k boundary and incorrectly inject a specification
exception instead of returning with condition code 3 and return code 4
(unsupported function code).

Fix this by moving the boundary check.

Fixes: 95ca2cb57985 ("KVM: s390: Add sthyi emulation")
Cc: <stable@vger.kernel.org> # 4.8+
Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/sthyi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/sthyi.c b/arch/s390/kvm/sthyi.c
index 2773a2f..a2e5c24 100644
--- a/arch/s390/kvm/sthyi.c
+++ b/arch/s390/kvm/sthyi.c
@@ -425,7 +425,7 @@ int handle_sthyi(struct kvm_vcpu *vcpu)
 	VCPU_EVENT(vcpu, 3, "STHYI: fc: %llu addr: 0x%016llx", code, addr);
 	trace_kvm_s390_handle_sthyi(vcpu, code, addr);
 
-	if (reg1 == reg2 || reg1 & 1 || reg2 & 1 || addr & ~PAGE_MASK)
+	if (reg1 == reg2 || reg1 & 1 || reg2 & 1)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	if (code & 0xffff) {
@@ -433,6 +433,9 @@ int handle_sthyi(struct kvm_vcpu *vcpu)
 		goto out;
 	}
 
+	if (addr & ~PAGE_MASK)
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+
 	/*
 	 * If the page has not yet been faulted in, we want to do that
 	 * now and not after all the expensive calculations.
-- 
2.7.4

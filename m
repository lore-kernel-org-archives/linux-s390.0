Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730315AbgCJNBt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Mar 2020 09:01:49 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 5/5] selftests: KVM: s390: fix format strings for access reg test
Date: Tue, 10 Mar 2020 09:01:44 -0400
Message-Id: <20200310130144.9921-6-borntraeger@de.ibm.com>
In-Reply-To: <20200310130144.9921-1-borntraeger@de.ibm.com>
References: <20200310130144.9921-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Andrew Jones <drjones@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

acrs are 32 bit and not 64 bit.

Reported-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 tools/testing/selftests/kvm/s390x/sync_regs_test.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
index b705637ca14b..70a56580042b 100644
--- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
@@ -42,6 +42,13 @@ static void guest_code(void)
 		    " values did not match: 0x%llx, 0x%llx\n", \
 		    left->reg, right->reg)
 
+#define REG_COMPARE32(reg) \
+	TEST_ASSERT(left->reg == right->reg, \
+		    "Register " #reg \
+		    " values did not match: 0x%x, 0x%x\n", \
+		    left->reg, right->reg)
+
+
 static void compare_regs(struct kvm_regs *left, struct kvm_sync_regs *right)
 {
 	int i;
@@ -55,7 +62,7 @@ static void compare_sregs(struct kvm_sregs *left, struct kvm_sync_regs *right)
 	int i;
 
 	for (i = 0; i < 16; i++)
-		REG_COMPARE(acrs[i]);
+		REG_COMPARE32(acrs[i]);
 
 	for (i = 0; i < 16; i++)
 		REG_COMPARE(crs[i]);
@@ -155,7 +162,7 @@ int main(int argc, char *argv[])
 		    "r11 sync regs value incorrect 0x%llx.",
 		    run->s.regs.gprs[11]);
 	TEST_ASSERT(run->s.regs.acrs[0]  == 1 << 11,
-		    "acr0 sync regs value incorrect 0x%llx.",
+		    "acr0 sync regs value incorrect 0x%x.",
 		    run->s.regs.acrs[0]);
 
 	vcpu_regs_get(vm, VCPU_ID, &regs);
-- 
2.25.0

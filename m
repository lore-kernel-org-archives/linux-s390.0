Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730318AbgCJNBu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Mar 2020 09:01:50 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4/5] selftests: KVM: s390: fixup fprintf format error in reset.c
Date: Tue, 10 Mar 2020 09:01:43 -0400
Message-Id: <20200310130144.9921-5-borntraeger@de.ibm.com>
In-Reply-To: <20200310130144.9921-1-borntraeger@de.ibm.com>
References: <20200310130144.9921-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Andrew Jones <drjones@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

value is u64 and not string.

Reported-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 tools/testing/selftests/kvm/s390x/resets.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testing/selftests/kvm/s390x/resets.c
index b567705f0d41..221e9c9a8bd2 100644
--- a/tools/testing/selftests/kvm/s390x/resets.c
+++ b/tools/testing/selftests/kvm/s390x/resets.c
@@ -66,7 +66,7 @@ static void test_one_reg(uint64_t id, uint64_t value)
 	reg.addr = (uintptr_t)&eval_reg;
 	reg.id = id;
 	vcpu_get_reg(vm, VCPU_ID, &reg);
-	TEST_ASSERT(eval_reg == value, "value == %s", value);
+	TEST_ASSERT(eval_reg == value, "value == 0x%lx", value);
 }
 
 static void assert_noirq(void)
-- 
2.25.0

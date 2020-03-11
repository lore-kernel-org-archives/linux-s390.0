Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729331AbgCKNPG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Mar 2020 09:15:06 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BDEtls047833
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2020 09:15:04 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yq03v9umc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2020 09:15:02 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 11 Mar 2020 13:11:00 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/2] selftests: KVM: s390: fixup fprintf format error in reset.c
Date: Wed, 11 Mar 2020 14:10:55 +0100
In-Reply-To: <20200311131056.140016-1-borntraeger@de.ibm.com>
References: <20200311131056.140016-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200311131056.140016-2-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Andrew Jones <drjones@redhat.com>

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
2.24.1

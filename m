Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69DF376BCE;
	Wed, 18 Mar 2026 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821187; cv=none; b=fMuR2a+YJGui4KmiQHIT+Cwzqftnmxv9sFDthdLwfdJXMRKCmRWyQdHYZIXWBgjWxsbFOp47SdNzEhC5JzDvmtY3VOjrv6uVMvNCfZtx6SVu3J1Ts5N75oRqiPQgS+KkR5eGGUuHeOIOQYQdqR2EuzF268xLcb8XRGiPlOobrYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821187; c=relaxed/simple;
	bh=ozcNbmljNIjB+PopZIGtNxMtSZqdY4eAshlOSLAZ+1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WN02l+EYmYz4y+ayWGyBx+5FI91WY7XbDOVSTd0IeMOpY9FzllWqp40/eQSvFiurKxnbSE0KQ46EYz1/79kDqdVMHFgM3h/no6LUNd/5R+e8uHoibazQi9u5s2vTHyXN92rH3exrglO1OTXjyluBui2dQ7tQRCcZYmJltGMqwVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NEWmf4QO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NEWmf4QO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HIDak1700502;
	Wed, 18 Mar 2026 08:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QYD0QKvUeOcH9T8XY
	JbfVKsZdQXTN1Qj5kMINd+qhDk=; b=NEWmf4QOnI/rhgZ2v7B81JI3wGCf7BUgf
	lZwa+6FIvDb8jixQJcPl8X2sA9qDsXAYncDJpVxyxzFODRXgUqfXbNBbD/Is01td
	r1/UUkCCntoX0goloA+2vZ6rRR4+bagihod5ZOTpxLYzxTO2lpIQDp+KfGmKTYFf
	ujkx4jdrPCa1eVf0RIx1giElZISR4Q2aYvyodR09aXbpuHXp7C0jUpx7GQDpLJk1
	7zHaeE8A2MgVCQ96QS3ZOa/vrYgmIEZslPUma9jHxVIqmpJYzFGKdrTRcenFzGD0
	sAclVM9naLK84WsBRgv0f+u9/wYAuaXqocjd5DgCcAlW5vf4cZgZw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3j0dmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 08:06:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I4sFfq029194;
	Wed, 18 Mar 2026 08:06:21 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgkd13e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 08:06:21 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62I86JrS27722254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 08:06:19 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52CEF58057;
	Wed, 18 Mar 2026 08:06:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72D7E58061;
	Wed, 18 Mar 2026 08:06:17 +0000 (GMT)
Received: from li-d98989cc-2c66-11b2-a85c-93ab83b7dd53.ibm.com.com (unknown [9.111.93.190])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 08:06:17 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [GIT PULL 4/6] KVM: s390: selftests: Add IRQ routing address offset tests
Date: Wed, 18 Mar 2026 09:06:04 +0100
Message-ID: <20260318080606.2450514-5-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318080606.2450514-1-borntraeger@de.ibm.com>
References: <20260318080606.2450514-1-borntraeger@de.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RvOxfXZz8Vo5qVswaGmT0iNvnHPrPpEi
X-Proofpoint-ORIG-GUID: RvOxfXZz8Vo5qVswaGmT0iNvnHPrPpEi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA2NCBTYWx0ZWRfX+Gx6YWiIRwlI
 SOVBRNtJ8htoR+EYqRj2XfE7KQo1U6uNiAaCPPJYzgyhBFOGpGC2xV1zzEzmH0tDIPP93nqWC+1
 SdsTW4xLdX3nZfaFvQF48Ii3odYFO9pqCO1LTr6GKSb+F2BrvhxvVKutxwcAJUhSsAhXjg4pmWI
 7TDMmZOvPuIvRUOUNw0YcM+6ZY/Q1yv3/hUbuIqVLQys9C48thkWyF/6UbgsdrGgeDsRWPESVe7
 5QqTbjfQY0uQAhWkvwyjxEV36oF5iJBc3fNtdAAOO2cQu58HcJIc5QjKN3oUXeBioL2nv9t7Izq
 6RittUrZIlsVjJIcdjbb9BtiZNHqb7/SXOF3BZM/EjOHRzcY60SmHvJLo0Z3ScGEIJX5WWP97si
 nrL6bL1BdbcmXYIUs6xrvaGupYPUNZ/yylBRyiPe1SQ1ZJ54XE0QQz6RHNuPK5ubNoI/tLF2bdL
 nE/YOOuIkDXw3BVHlhA==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69ba5cfd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=nmqUFfGTdH_2drHDQF0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180064

From: Janosch Frank <frankja@linux.ibm.com>

This test tries to setup routes which have address + offset
combinations which cross a page.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../testing/selftests/kvm/s390/irq_routing.c  | 75 +++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/s390/irq_routing.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index fdec90e854671..271cbb63af36d 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -205,6 +205,7 @@ TEST_GEN_PROGS_s390 += s390/ucontrol_test
 TEST_GEN_PROGS_s390 += s390/user_operexec
 TEST_GEN_PROGS_s390 += s390/keyop
 TEST_GEN_PROGS_s390 += rseq_test
+TEST_GEN_PROGS_s390 += s390/irq_routing
 
 TEST_GEN_PROGS_riscv = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_riscv += riscv/sbi_pmu_test
diff --git a/tools/testing/selftests/kvm/s390/irq_routing.c b/tools/testing/selftests/kvm/s390/irq_routing.c
new file mode 100644
index 0000000000000..7819a0af19a8e
--- /dev/null
+++ b/tools/testing/selftests/kvm/s390/irq_routing.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * IRQ routing offset tests.
+ *
+ * Copyright IBM Corp. 2026
+ *
+ * Authors:
+ *  Janosch Frank <frankja@linux.ibm.com>
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "kselftest.h"
+#include "ucall_common.h"
+
+extern char guest_code[];
+asm("guest_code:\n"
+    "diag %r0,%r0,0\n"
+    "j .\n");
+
+static void test(void)
+{
+	struct kvm_irq_routing *routing;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	vm_paddr_t mem;
+	int ret;
+
+	struct kvm_irq_routing_entry ue = {
+		.type = KVM_IRQ_ROUTING_S390_ADAPTER,
+		.gsi = 1,
+	};
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	mem = vm_phy_pages_alloc(vm, 2, 4096 * 42, 0);
+
+	routing = kvm_gsi_routing_create();
+	routing->nr = 1;
+	routing->entries[0] = ue;
+	routing->entries[0].u.adapter.summary_addr = (uintptr_t)mem;
+	routing->entries[0].u.adapter.ind_addr = (uintptr_t)mem;
+
+	routing->entries[0].u.adapter.summary_offset = 4096 * 8;
+	ret = __vm_ioctl(vm, KVM_SET_GSI_ROUTING, routing);
+	ksft_test_result(ret == -1 && errno == EINVAL, "summary offset outside of page\n");
+
+	routing->entries[0].u.adapter.summary_offset -= 4;
+	ret = __vm_ioctl(vm, KVM_SET_GSI_ROUTING, routing);
+	ksft_test_result(ret == 0, "summary offset inside of page\n");
+
+	routing->entries[0].u.adapter.ind_offset = 4096 * 8;
+	ret = __vm_ioctl(vm, KVM_SET_GSI_ROUTING, routing);
+	ksft_test_result(ret == -1 && errno == EINVAL, "ind offset outside of page\n");
+
+	routing->entries[0].u.adapter.ind_offset -= 4;
+	ret = __vm_ioctl(vm, KVM_SET_GSI_ROUTING, routing);
+	ksft_test_result(ret == 0, "ind offset inside of page\n");
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_IRQ_ROUTING));
+
+	ksft_print_header();
+	ksft_set_plan(4);
+	test();
+
+	ksft_finished();	/* Print results and exit() accordingly */
+}
-- 
2.53.0


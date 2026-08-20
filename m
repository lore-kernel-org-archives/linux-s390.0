Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7DE443ABC;
	Thu, 20 Aug 2026 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229617; cv=none; b=Y9vp7rFanEYoiRbDTmH/YaNE1GNqgzXeUEfrmKOfkm9kOkDSJ7wDALsUGmYEDiN4TmAkgKShTNec5ME1yvH68D0J8oSo1lCsmUkSdwnwrgfIKH96/B7JKF+h5TQZqoalSqCNw9p+EPNu74xkCRBx7719EPOBljI+ZCCYGgf/16Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229617; c=relaxed/simple;
	bh=NhsvfGLHd/fhjTxGANUguG71YeC2Afb3/dUOF3wjDC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XdrX3N56spMcHxoLAxtLix7RERcd9VAlrgbofmk5VoRqP670m88PL/XfNzw+3Zq/+3BO5db4OJUOLZrMe3fD4LK+TlVEE5261ZkYeuRMB2lWR985Bl/dEwJM4mJcoX+KTfI9pk9VUipRJsPAPYz0QNQprGwOOQoeWO2iG3R60p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KJxZlQMq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KJxZlQMq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8hXUJ503913;
	Thu, 20 Aug 2026 12:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=yCO/+kwGsXaDN4jIraW/e7CegfUev0faDwZ7zdP5D
	JY=; b=KJxZlQMqoZ0YgVM9cZHL6qXL8y8BtLWQJztsjBorhG0JDvd9scD7MQPPf
	aGjgVgxc1I5ApzSDgyg0Pw81ODyNmPemyF9UQwdqlPWPes31LFqY5YK/yoa/99vd
	/G2I21F/X/3tvpFVJ1Ue0QzHTpR9feo42BUmkMvmx3km3OO+pUVj0+E/tIHpQs9s
	PAezuEyC1NWbbSkQEtrYgmNiyreM5G5C4McXIDJL+cvcXpXTsD0QZqmE8U5pru/U
	YwTfPy5YlX5sp3yPz4qFOWqblNB9Ak5gcErf1/o6i5lmFeqKfLS/cfAOB/97x9wT
	dYNQmi8bjJBFZA7yjLH4f6Y98voYQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4a4gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 12:40:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KCQP9N007840;
	Thu, 20 Aug 2026 12:40:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekehj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 12:40:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KCe9Yj44630282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 12:40:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FCE62004E;
	Thu, 20 Aug 2026 12:40:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7ED62004D;
	Thu, 20 Aug 2026 12:40:08 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 12:40:08 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: imbrenda@linux.ibm.com, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com
Subject: [PATCH] KVM: s390: selftests: Add IRQ injection selftests
Date: Thu, 20 Aug 2026 12:20:35 +0000
Message-ID: <20260820123728.26284-2-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a86f5ad cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=HrADI_whcFcx6oX9QEwA:9
X-Proofpoint-ORIG-GUID: ryzR7hAINnYRaSpS3rY9ULmZjheBqnJK
X-Proofpoint-GUID: ryzR7hAINnYRaSpS3rY9ULmZjheBqnJK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA5MyBTYWx0ZWRfXzjvuFV3o/qFy
 +oVCKhkvA/mdb6HEwTZILzu4LhNQEJUIFcx54zmzCksPKyxzEiNB+y3i10fP/yuSB2G5rJ6AfJi
 R44Ho5+1dTd7XFnOB9ay1rtgMsU26CU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA5MyBTYWx0ZWRfX+HyemUoAsSUR
 ENwrM220xPk+fGUXhY/EypASAQME6A2nefOpMZujBxlAsh65rZFY+SjyXSZp9ZvU9QCRxCHioDW
 Moj4r3LCh17xn6PPe3E7O2JoQdzILO4iFJa0lLYJlvH76naJUX3gcGQ+MU85RBHtycOQXAaSFZU
 iTc/ncNTbQbYKj180K7ldRJMKTdY5Yui2ivvhQ0/nTcAqAWkVv8Nnnb/EgoDS+T0aDWPs27H9hH
 GID/6I2L5t+v8bvb50nBidu4DwFUwrBTT+xYaNrTlEnUwUduo6POIXBXyie/2QLCp6146vmUjTO
 LtzJHHflMIX12DUq9p/89i1eHQ4kVMZSwlplrjhtBms7x0mkgmA4wJFzXuMoF4uwDzCBXTJtSEr
 /nUp7EvGXrSK4JZc8Lc/UPCH4GTZZlkgC6VaGZ+fXW21h2VBb1KGCMZ3RhDfw5g60oCV1sqf2Vr
 rJzDo1H0lbZPGcE+8PQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200093

From: Gabriella Seifert <gseifert@linux.ibm.com>

The IRQ injection selftests haven't been added to the selftests yet so
let's do that now. We start off with a couple simple error checks for
invalid data.

Signed-off-by: Gabriella Seifert <gseifert@linux.ibm.com>
[frankja@linux.ibm.com: Improved formatting and wording]
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---

Written by Gabriela in her internship as a side project. Unfortunately
she wasn't able to send it out herself due to a bit of time crunch.
She did prepare additional code that's more in-depth with guest side
checks but didn't have the time to fully test and clean it up. We'll
see if and when that code will be posted.

I have her permission to fix up review comments and she's in bcc.

---
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/s390/irq_injection.c        | 74 +++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/s390/irq_injection.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 6fc34e9bf8e1..423c0cb6f17d 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -215,6 +215,7 @@ TEST_GEN_PROGS_s390 += rseq_test
 TEST_GEN_PROGS_s390 += s390/irq_routing
 TEST_GEN_PROGS_s390 += mmu_stress_test
 TEST_GEN_PROGS_s390 += pre_fault_memory_test
+TEST_GEN_PROGS_s390 += s390/irq_injection
 
 TEST_GEN_PROGS_riscv = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_riscv += riscv/sbi_pmu_test
diff --git a/tools/testing/selftests/kvm/s390/irq_injection.c b/tools/testing/selftests/kvm/s390/irq_injection.c
new file mode 100644
index 000000000000..75e0528f9b01
--- /dev/null
+++ b/tools/testing/selftests/kvm/s390/irq_injection.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test for KVM_S390_IRQ - s390x IRQ injection API
+ *
+ * Verifies that VM-level interrupt types are correctly rejected when
+ * injected via the vCPU file descriptor, and that invalid arguments
+ * to vCPU-level interrupts are also rejected.
+ *
+ * Copyright IBM Corp. 2026
+ * Author: Gabriella Seifert <gseifert@linux.ibm.com>
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include "kvm_util.h"
+#include "test_util.h"
+#include <linux/kvm.h>
+
+static void test_vm_irq_on_vcpu_fails(struct kvm_vcpu *vcpu, __u64 type)
+{
+	struct kvm_s390_irq irq = { .type = type };
+	int rc;
+
+	rc = __vcpu_ioctl(vcpu, KVM_S390_IRQ, &irq);
+	ksft_test_result(rc == -1 && errno == EINVAL,
+			 "VM on VCPU IRQ type 0x%llx: expected %d, got %d\n",
+			 type, EINVAL, errno);
+}
+
+static void test_vcpu_irq_bad_param_fails(struct kvm_vcpu *vcpu,
+					  struct kvm_s390_irq *irq)
+{
+	int rc;
+
+	rc = __vcpu_ioctl(vcpu, KVM_S390_IRQ, irq);
+	ksft_test_result(rc == -1 && errno == EINVAL,
+			 "VCPU IRQ bad param type 0x%llx: expected %d got %d\n",
+			 irq->type, EINVAL, errno);
+}
+
+int main(void)
+{
+	struct kvm_s390_irq irq;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	ksft_print_header();
+	ksft_set_plan(6);
+	vm = vm_create_with_one_vcpu(&vcpu, NULL);
+
+	test_vm_irq_on_vcpu_fails(vcpu, KVM_S390_INT_VIRTIO);
+	test_vm_irq_on_vcpu_fails(vcpu, KVM_S390_INT_SERVICE);
+	test_vm_irq_on_vcpu_fails(vcpu, KVM_S390_INT_IO_MIN);
+
+	memset(&irq, 0, sizeof(irq));
+	irq.type = KVM_S390_INT_EMERGENCY;
+	irq.u.emerg.code = 0xffff;
+	test_vcpu_irq_bad_param_fails(vcpu, &irq);
+
+	memset(&irq, 0, sizeof(irq));
+	irq.type = KVM_S390_INT_EXTERNAL_CALL;
+	irq.u.extcall.code = 0xffff;
+	test_vcpu_irq_bad_param_fails(vcpu, &irq);
+
+	memset(&irq, 0, sizeof(irq));
+	irq.type = 0xdeadbeef;
+	test_vcpu_irq_bad_param_fails(vcpu, &irq);
+
+	kvm_vm_free(vm);
+	ksft_finished();
+}
-- 
2.53.0


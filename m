Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04C227B32C;
	Wed, 24 Jun 2026 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299981; cv=none; b=UJ5DGUwGuMnjqC3jFGglQBA5f3J6mx7NKst7ckDiZqdo6x9cRS0UN7hE9eMWObhF+4SD6n3jB4J9FYxmMi6o7qzGsASW78Cya/MkTDzZ+5ZiBJuSlar3K2s1FYQ0AeH4+QHeHKFOErv0zMN4MvQlv355Y+DaVXFFtxBWqh8a8Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299981; c=relaxed/simple;
	bh=2FbTNN/X/m+4A3AAdmU6TQg5j3VsRzWgcAFTsIS5RVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKJkHcvYVipDR2kZF6gwxNOiuuB0xvGNODgJIkZbjm9QurNU/o5uC0iorM58QWuLEKXI1rymkBPqSLL6zPYSit8kxU1xKMTJZvs2/oZKUQLXbNM3jX2KWD0isBZpBL1Nfi/KezaOC8+4uK6TljHEmY2/NMjgrRr6lfWmEpa6OhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sg7Rtc4Z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sg7Rtc4Z"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OAmG6h866173;
	Wed, 24 Jun 2026 11:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7Llnz/V3L0rT/tbu0
	EucnTz+O7lTDond0g7sgqb+rUc=; b=Sg7Rtc4ZTKwM0KRDs+i2Qp9RFq3/thGXA
	qyjl+DoadyqCPPkBJaGep7r4CSt9mdCyHBVz9FNBu2A1JUtbj9hb2aztpUFPSh+Y
	aZ5hkGEYGwIDI2KE2UpzLVpMQLZg08XahSDr+WgX9ssJ7vtCswYqRLk7ApvM9QpC
	ZhuGYtfbwHX4vqiH39MrEZHJzzBz3sR3rfmMG+DA+RpEUhs7IbUzXZgtaUGNUibw
	jNyaiE9EKzTey9TdOV/RXktauGPD/GUPUoXyLB7svV1W+capiqjb3cBr/3p3PuUL
	URjr72Kpl6jhBBVNRqKMMpgAXRpXAYf9W+MxTQUKeuNNZUltvPg/g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhquqg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OB4e7G018103;
	Wed, 24 Jun 2026 11:19:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyqxf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OBJTFV49283358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 11:19:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B65A20040;
	Wed, 24 Jun 2026 11:19:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25D9B2004E;
	Wed, 24 Jun 2026 11:19:29 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 11:19:29 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 02/12] KVM: s390: selftests: Extended user_operexec tests
Date: Wed, 24 Jun 2026 13:19:18 +0200
Message-ID: <20260624111928.144283-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624111928.144283-1-imbrenda@linux.ibm.com>
References: <20260624111928.144283-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3bbd48 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=vLmQqXtnAFf_hZV6vNAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfX9TazEch27UNx
 NOXtCfJXKSXj7/a1GI5+vnoWNcSHJQP2YP+ZJdJ8F+ddlcUnIcYUa4Qh1ubT9CKme00zP2wfI0F
 eHiOb/CfYlDkCHF5ROAfGEyPXq0NbETTyA8xcUMhzm0Skb6ZDyOLZpmrgpTXuzMkKMrs8251xRS
 xLnKu6fKYgy3y/MHfZEBZLphvU5vuDRoHlo2edsKgTtKrrQDHWy7A8pOGaf8IogSE+ldlOE05tJ
 YQ5dbCQ50ff06BWiKUPHEwCCOaZCTbErqu4JYU3w9gZ/gt0Xtrhr0R6K/ApbQ/zJNh3dwf7it+d
 jbdpEFMZhCnPATu2zFuSDR29ejSdpm9Ee2jU0lpuFdi9fDpfw9MY3uYAemr4mi9xu1YrB7t/qyg
 jGWYAaOif1msrqINElvRQv+znyhBMw==
X-Proofpoint-GUID: TJ2DDOCU2ur5SJjQxAQA2LvMb0LF5H3c
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfX0J5BaFt9Xfru
 xPi6fN3+qD91CYvvXFUpOEf+0BFIUwzJNQvP/1/pAxA0wY3TWRox2gf8pQ8VxTWYD3L270/uUDG
 jXGX7lJ7w5RpiypsSLlw6Kh/lksjn0c=
X-Proofpoint-ORIG-GUID: TJ2DDOCU2ur5SJjQxAQA2LvMb0LF5H3c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240094

From: Eric Farman <farman@linux.ibm.com>

There is a possibility that the user_operexec capability
only works if facility bit 74 is enabled. This is now fixed,
but add a selftest to demonstrate that.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260507200836.3500368-3-farman@linux.ibm.com>
---
 .../selftests/kvm/include/s390/facility.h     |   6 +
 .../selftests/kvm/s390/user_operexec.c        | 110 ++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/s390/facility.h b/tools/testing/selftests/kvm/include/s390/facility.h
index 41a265742666..e5259f63be22 100644
--- a/tools/testing/selftests/kvm/include/s390/facility.h
+++ b/tools/testing/selftests/kvm/include/s390/facility.h
@@ -11,6 +11,7 @@
 #ifndef SELFTEST_KVM_FACILITY_H
 #define SELFTEST_KVM_FACILITY_H
 
+#include <linux/atomic.h>
 #include <linux/bitops.h>
 
 /* alt_stfle_fac_list[16] + stfle_fac_list[16] */
@@ -19,6 +20,11 @@
 extern u64 stfl_doublewords[NB_STFL_DOUBLEWORDS];
 extern bool stfle_flag;
 
+static inline bool clear_bit_inv(unsigned long nr, unsigned long *ptr)
+{
+	return clear_bit(nr ^ (BITS_PER_LONG - 1), ptr);
+}
+
 static inline bool test_bit_inv(unsigned long nr, const unsigned long *ptr)
 {
 	return test_bit(nr ^ (BITS_PER_LONG - 1), ptr);
diff --git a/tools/testing/selftests/kvm/s390/user_operexec.c b/tools/testing/selftests/kvm/s390/user_operexec.c
index 714906c1d12a..b24c1f9dbbe8 100644
--- a/tools/testing/selftests/kvm/s390/user_operexec.c
+++ b/tools/testing/selftests/kvm/s390/user_operexec.c
@@ -6,6 +6,7 @@
  * Authors:
  *  Janosch Frank <frankja@linux.ibm.com>
  */
+#include "facility.h"
 #include "kselftest.h"
 #include "kvm_util.h"
 #include "test_util.h"
@@ -109,6 +110,111 @@ static void test_user_operexec_combined(void)
 	kvm_vm_free(vm);
 }
 
+static struct kvm_vm *create_vm_without_sthyi(void)
+{
+	struct kvm_s390_vm_cpu_processor info;
+	struct kvm_vm *vm;
+
+	vm = vm_create(1);
+
+	kvm_device_attr_get(vm->fd, KVM_S390_VM_CPU_MODEL,
+			    KVM_S390_VM_CPU_PROCESSOR, &info);
+
+	clear_bit_inv(74, (unsigned long *)&info.fac_list);
+	kvm_device_attr_set(vm->fd, KVM_S390_VM_CPU_MODEL,
+			    KVM_S390_VM_CPU_PROCESSOR, &info);
+
+	return vm;
+}
+
+static void test_user_instr0_no_stfle_74(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int rc;
+
+	vm = create_vm_without_sthyi();
+
+	rc = __vm_enable_cap(vm, KVM_CAP_S390_USER_INSTR0, 0);
+	TEST_ASSERT_EQ(0, rc);
+
+	vcpu = vm_vcpu_add(vm, 0, guest_code_instr0);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_S390_SIEIC);
+	TEST_ASSERT_EQ(vcpu->run->s390_sieic.icptcode, ICPT_OPEREXC);
+	TEST_ASSERT_EQ(vcpu->run->s390_sieic.ipa, 0x0000);
+
+	kvm_vm_free(vm);
+}
+
+static void test_user_operexec_no_stfle_74(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int rc;
+
+	vm = create_vm_without_sthyi();
+
+	rc = __vm_enable_cap(vm, KVM_CAP_S390_USER_OPEREXEC, 0);
+	TEST_ASSERT_EQ(0, rc);
+
+	vcpu = vm_vcpu_add(vm, 0, guest_code_user_operexec);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_S390_SIEIC);
+	TEST_ASSERT_EQ(vcpu->run->s390_sieic.icptcode, ICPT_OPEREXC);
+	TEST_ASSERT_EQ(vcpu->run->s390_sieic.ipa, 0x0807);
+
+	kvm_vm_free(vm);
+}
+
+static void test_instr0_combined_no_stfle_74(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int rc;
+
+	vm = create_vm_without_sthyi();
+
+	rc = __vm_enable_cap(vm, KVM_CAP_S390_USER_INSTR0, 0);
+	TEST_ASSERT_EQ(0, rc);
+	rc = __vm_enable_cap(vm, KVM_CAP_S390_USER_OPEREXEC, 0);
+	TEST_ASSERT_EQ(0, rc);
+
+	vcpu = vm_vcpu_add(vm, 0, guest_code_instr0);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_S390_SIEIC);
+	TEST_ASSERT_EQ(vcpu->run->s390_sieic.icptcode, ICPT_OPEREXC);
+	TEST_ASSERT_EQ(vcpu->run->s390_sieic.ipa, 0x0000);
+
+	kvm_vm_free(vm);
+}
+
+static void test_operexec_combined_no_stfle_74(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int rc;
+
+	vm = create_vm_without_sthyi();
+
+	rc = __vm_enable_cap(vm, KVM_CAP_S390_USER_INSTR0, 0);
+	TEST_ASSERT_EQ(0, rc);
+	rc = __vm_enable_cap(vm, KVM_CAP_S390_USER_OPEREXEC, 0);
+	TEST_ASSERT_EQ(0, rc);
+
+	vcpu = vm_vcpu_add(vm, 0, guest_code_user_operexec);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_S390_SIEIC);
+	TEST_ASSERT_EQ(vcpu->run->s390_sieic.icptcode, ICPT_OPEREXC);
+	TEST_ASSERT_EQ(vcpu->run->s390_sieic.ipa, 0x0807);
+
+	kvm_vm_free(vm);
+}
+
 /*
  * Run all tests above.
  *
@@ -122,6 +228,10 @@ static struct testdef {
 	{ "instr0", test_user_instr0 },
 	{ "operexec", test_user_operexec },
 	{ "operexec_combined", test_user_operexec_combined},
+	{ "instr0_no_stfle_74", test_user_instr0_no_stfle_74 },
+	{ "instr0_combined_no_stfle_74", test_instr0_combined_no_stfle_74 },
+	{ "operexec_combined_no_stfle_74", test_operexec_combined_no_stfle_74 },
+	{ "operexec_no_stfle_74", test_user_operexec_no_stfle_74 },
 };
 
 int main(int argc, char *argv[])
-- 
2.54.0


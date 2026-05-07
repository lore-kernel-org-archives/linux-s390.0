Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE7F175A85;
	Thu,  7 May 2026 20:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184530; cv=none; b=uL3/irQnwjPLfhaOJMJOwhGGN33bot1TSYRLFB5WILzJXO2tXJwFCCFVeO4XaUU4+jv0Yu/Ia0FS1pMVgwTruAcWoSCpy13B+iM4Yrlo4aNIFJ/xX0hvsG/jDDF4PD8WLpZ+YGioh10kF7NSWwtMrPN0XbEE8QRpuH4pLoEc5Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184530; c=relaxed/simple;
	bh=gE8XJ4jM2y79zvKfjmyjgHB0EFa534eAvwru0VugIEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drReSNuwMXyV8s0uiDmul4QrlgTE+e4foK+SVYcNb3jDA3A1D3gYMlaw/Abo8rBonbko4l4+7vmIEVNeV1UASIi4R4HbsmtmaYNdb0lcsIZubw5whQb+e8K1oxNlHLiUJUQlNc8EMvhms+EEYxNrIazForGqojr6xiEuOM+R4CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F5oAwbzB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F5oAwbzB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647EoTdr347004;
	Thu, 7 May 2026 20:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UkrXLdEIbMp8HVgFP
	1bHWJS/g7YmILI7XG7Su/E8QSQ=; b=F5oAwbzBkjKhWXwHdVxOz7bvoqndMI4Qj
	SB22Wu9gQa6Zw4AgUB2AfvKsFGUr5Izk6L3XE5rNiW4fCTizEjbAEo3UA4uw80Aw
	dW7FKX6oxV+m2Yq1kKFtjLjZ08bHhtrIp0AO8HFRZJZIG7mwGcD8cZqLhvSRZn3K
	5zIqKI5+LirZGFwdMS01toXqF+OJT96wHsBJV0cB8GfnmVI2q1nKwQi7sng8ebUy
	eJjCTddyd4h0NMJiWeCad/V5Lya3MVGWhsTur4awgSwA9mAXAWQQYyWC2Oye+2EM
	U8OzoUpHd/8mJAL9wwEBOkp6VM1V+5/1kGuTrBluQDw8mEpmOFUZw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x50kr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 20:08:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647JshAW012851;
	Thu, 7 May 2026 20:08:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuywdfha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 20:08:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647K8gew48431492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 20:08:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DF1820067;
	Thu,  7 May 2026 20:08:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0799520063;
	Thu,  7 May 2026 20:08:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  7 May 2026 20:08:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id E1B16E05E9; Thu, 07 May 2026 22:08:41 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 2/3] KVM: s390: selftests: Extended user_operexec tests
Date: Thu,  7 May 2026 22:08:35 +0200
Message-ID: <20260507200836.3500368-3-farman@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260507200836.3500368-1-farman@linux.ibm.com>
References: <20260507200836.3500368-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIwMyBTYWx0ZWRfXw9mQsz5ZTRyK
 1CqCA9qkXbqEECemXggt5xwRAlCXX0QIZFTEQCKcJyVu0ucF6jEo86WaV/UWj/1JmPGDAS6pNgy
 Jv4EOT711PoXpP/DH65BZQo1a6T98E5DfM9VI7CWnzMuvrFYRtetKRVjvPGNYw3cyE0FY5s7Gre
 gfSwKjUB5rdkL5HGiCzPppqjY0QDcZpUk2CSiJ+7mfp7hlRrWeCl4nqDy54BqtGRRX8K5CvPXOX
 41p9iCFB71wTIL0HruzgSW94AKlyQ2mWSDrRi37qvQFDv9ybqNpyc7sQPVFO0eEslz0NzUfjXsW
 xOhDC9Tfj3W4OeQ++aMMg/YsSqqPSg1C7gdId9m6QMiS22LofTLWLuJNMsb1CXc0gcqCj1oBG+C
 cBNp8hA6PdRThe2ZoJ8xnD71t274GP24H5qoXbVKFkRVuyXFUYR7UPfpVnLDSLIiBGHP5PyxNNi
 fpQzgYkz19pLnz6U7TQ==
X-Proofpoint-ORIG-GUID: vH4y-p2eMOUycH-848wiEm95gTW9NLH7
X-Proofpoint-GUID: vH4y-p2eMOUycH-848wiEm95gTW9NLH7
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fcf14f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Yig_oxQC0P1p03koVSYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070203

There is a possibility that the user_operexec capability
only works if facility bit 74 is enabled. This is now fixed,
but add a selftest to demonstrate that.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 .../selftests/kvm/include/s390/facility.h     |   6 +
 .../selftests/kvm/s390/user_operexec.c        | 110 ++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/s390/facility.h b/tools/=
testing/selftests/kvm/include/s390/facility.h
index 41a265742666..e5259f63be22 100644
--- a/tools/testing/selftests/kvm/include/s390/facility.h
+++ b/tools/testing/selftests/kvm/include/s390/facility.h
@@ -11,6 +11,7 @@
 #ifndef SELFTEST_KVM_FACILITY_H
 #define SELFTEST_KVM_FACILITY_H
=20
+#include <linux/atomic.h>
 #include <linux/bitops.h>
=20
 /* alt_stfle_fac_list[16] + stfle_fac_list[16] */
@@ -19,6 +20,11 @@
 extern u64 stfl_doublewords[NB_STFL_DOUBLEWORDS];
 extern bool stfle_flag;
=20
+static inline bool clear_bit_inv(unsigned long nr, unsigned long *ptr)
+{
+	return clear_bit(nr ^ (BITS_PER_LONG - 1), ptr);
+}
+
 static inline bool test_bit_inv(unsigned long nr, const unsigned long *p=
tr)
 {
 	return test_bit(nr ^ (BITS_PER_LONG - 1), ptr);
diff --git a/tools/testing/selftests/kvm/s390/user_operexec.c b/tools/tes=
ting/selftests/kvm/s390/user_operexec.c
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
=20
+static struct kvm_vm *create_vm_without_sthyi(void)
+{
+	struct kvm_s390_vm_cpu_processor info;
+	struct kvm_vm *vm;
+
+	vm =3D vm_create(1);
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
+	vm =3D create_vm_without_sthyi();
+
+	rc =3D __vm_enable_cap(vm, KVM_CAP_S390_USER_INSTR0, 0);
+	TEST_ASSERT_EQ(0, rc);
+
+	vcpu =3D vm_vcpu_add(vm, 0, guest_code_instr0);
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
+	vm =3D create_vm_without_sthyi();
+
+	rc =3D __vm_enable_cap(vm, KVM_CAP_S390_USER_OPEREXEC, 0);
+	TEST_ASSERT_EQ(0, rc);
+
+	vcpu =3D vm_vcpu_add(vm, 0, guest_code_user_operexec);
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
+	vm =3D create_vm_without_sthyi();
+
+	rc =3D __vm_enable_cap(vm, KVM_CAP_S390_USER_INSTR0, 0);
+	TEST_ASSERT_EQ(0, rc);
+	rc =3D __vm_enable_cap(vm, KVM_CAP_S390_USER_OPEREXEC, 0);
+	TEST_ASSERT_EQ(0, rc);
+
+	vcpu =3D vm_vcpu_add(vm, 0, guest_code_instr0);
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
+	vm =3D create_vm_without_sthyi();
+
+	rc =3D __vm_enable_cap(vm, KVM_CAP_S390_USER_INSTR0, 0);
+	TEST_ASSERT_EQ(0, rc);
+	rc =3D __vm_enable_cap(vm, KVM_CAP_S390_USER_OPEREXEC, 0);
+	TEST_ASSERT_EQ(0, rc);
+
+	vcpu =3D vm_vcpu_add(vm, 0, guest_code_user_operexec);
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
+	{ "operexec_combined_no_stfle_74", test_operexec_combined_no_stfle_74 }=
,
+	{ "operexec_no_stfle_74", test_user_operexec_no_stfle_74 },
 };
=20
 int main(int argc, char *argv[])
--=20
2.51.0


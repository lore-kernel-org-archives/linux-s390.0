Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D234070FE;
	Tue, 24 Mar 2026 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366140; cv=none; b=bHfZtwNspJdwYCMhsHvCZG2Yk2QZTnzvmIfYsqbW9H+V1IljGN9kCTCk95NHRfgJuLOLlYnbv+5SFlrGGRS7IycRcCa1++rHASAmDnd+w40dge3jXB3/Y9fTPeh8lufSAukH1MezJri1UL9hFcaLJTKNmFAJwbx0FC/WDJKsONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366140; c=relaxed/simple;
	bh=YcvNaSUlHBkGQne0v8ktVxukyOwK0b0ScwezgaS9BZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W6s+rJ/tjg7ijk5ACrBVl3L/qYEGPrfoIhQKOWn94qSZ1kwCG+VqmcBCdreQSLaBV/ZuBXWxmlEOxVf90mtPa2L2nxeo1Gk5KHOjrOEqL/fRJcVm8b/dOnssP/md7t9nLEN5dTSXu4fE2hSS75+xK2vYOHstUlmY+Ep7NoFRQ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V79pGryY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V79pGryY"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O3JbUR3655956;
	Tue, 24 Mar 2026 15:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AyrE2w
	M7n70s5a2CVjgJeVZS2Y7v1AEYWcdgbBJVC14=; b=V79pGryY0NGCkJzEbgfMB/
	H+iE0J1Zt30e26JMBWCkJURzKVfp6z4cSvtZcSsyMiEUxQcz2wepntrupqo+wtF1
	WPp3VYgHNhBNOxaI9U5r01muamAymfxF0A++yyi8x4GGfC2p5e52V4SJu3pLEtny
	v81WmI2VnerY/iua0IuwtbnYLMZf/SuulDJOzbgszzXxK9AzVw1mWye6IubIeOq7
	LAa0gUrjJNUTR5Q4LMk8NgJvhAzm7I46NP3Dp4ybql4G9JxsFvn+vDQu6OvaNPeD
	wyoS7UFw9SXEiuCFndbr+c8WBaJkkEh+D7Td1ocFgym9HHxGO6NJcmKagLwbqdnQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky03kd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:28:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62ODTgC5004407;
	Tue, 24 Mar 2026 15:28:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c228kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:28:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OFSn5s30212434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 15:28:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EC9020043;
	Tue, 24 Mar 2026 15:28:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB05820040;
	Tue, 24 Mar 2026 15:28:48 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.21.79])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 15:28:48 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 24 Mar 2026 16:28:09 +0100
Subject: [kvm-unit-tests PATCH v2 5/5] s390x: Add test for STFLE
 interpretive execution (format-2)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-vsie-stfle-fac-v2-5-5e52be2e4081@linux.ibm.com>
References: <20260324-vsie-stfle-fac-v2-0-5e52be2e4081@linux.ibm.com>
In-Reply-To: <20260324-vsie-stfle-fac-v2-0-5e52be2e4081@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        kvm@vger.kernel.org, Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6004;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=5yUzwT3iFxTedeamVdiFlTNO10wcG28UZ+ikrcuth5Q=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJmH1q7RvunTf2vPDO1TjnumndqpJ8Bn43/8wnPHZTN3r
 jjxpre6v6OUhUGMi0FWTJGlWtw6r6qvdemcg5bXYOawMoEMYeDiFICJTHnPyHBI3LVtsWN3+SdB
 rZrDG+P36rKUZ++q8Z3QsnTByrSenR8ZGY7HP1sSIdq60etkOitbu4X96/U35h2UyWydwzJ992n
 1RewA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX/XIqJmc5AsnT
 1CPmfHxIm7/hYcVPnbvRegmPVPIRjTvEEWrp96hOmN8A1tPjWjFKjoNllCgF453jOhp5yAVM3K8
 viIeUNGQ8tZm8H4+XI2FCaqJZL6J0lwARwADytHFIM7eO+TlJnSl6lvwW2zc6471Yp9pjlZdOPF
 78ZxDH6FVjftksrALsAGNdV9hvITjqTPmm0mqdSMSYzrg6A02ufUyxcM1ujmAOjj216eTFI+dNJ
 vODgCckuTxSouOMQ7evTIMelPnjzk3INOIexBi7Vrf2ouA9ZySGV5Otst2GDekRgcLCKKBMV/ba
 n/lc+Fgi3BlmE1cFr3qmLnW2NN734bu/oy97z/rBfbnOsYMUnmtwzanQgq4y2HYb4fkLbBIyCnt
 iGNWDuHap1PI2fxyWwAkBOuLTMG3v18YzBlYA9/EeKkn95Ofzqupl2IGIBLuqGrj4LWAGQ+qG4G
 yGmqTUODG7UNMhdVBzA==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c2adb5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=g3eoNvHwOKj1BpS12hIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UJOSDnYy7t1D0E_Fkte1alxrfcGhL2Qj
X-Proofpoint-GUID: UJOSDnYy7t1D0E_Fkte1alxrfcGhL2Qj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240119

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

The STFLE instruction indicates installed facilities.
SIE has facilities for the interpretive execution of STFLE.
There are multiple possible formats for the control block.
Use a snippet guest executing STFLE to get the result of
interpretive execution and check the result.
With the addition of the format-2 control block invalid format
specifiers are now possible.
Test for the occurrence of optional validity intercepts.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 lib/s390x/sie.c   | 11 +++++++
 lib/s390x/sie.h   |  1 +
 s390x/stfle-sie.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 92 insertions(+), 11 deletions(-)

diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
index 0fa915cf028a1b35a76aa316dfd97308094a4682..17f0ef7eff427002dd6d74d98f58ed493457a7ce 100644
--- a/lib/s390x/sie.c
+++ b/lib/s390x/sie.c
@@ -42,6 +42,17 @@ void sie_check_validity(struct vm *vm, uint16_t vir_exp)
 	report(vir_exp == vir, "VALIDITY: %x", vir);
 }
 
+void sie_check_optional_validity(struct vm *vm, uint16_t vir_exp)
+{
+	uint16_t vir = sie_get_validity(vm);
+
+	if (vir == 0xffff)
+		report_pass("optional VALIDITY: no");
+	else
+		report(vir_exp == vir, "optional VALIDITY: %x", vir);
+	vm->validity_expected = false;
+}
+
 void sie_handle_validity(struct vm *vm)
 {
 	if (vm->sblk->icptcode != ICPT_VALIDITY)
diff --git a/lib/s390x/sie.h b/lib/s390x/sie.h
index 3ec49ed0da6459a70689ce5a1a8a027a4113f2a4..8bea0b10b0a6894096ee83933a8bda11711a1949 100644
--- a/lib/s390x/sie.h
+++ b/lib/s390x/sie.h
@@ -51,6 +51,7 @@ void sie(struct vm *vm);
 void sie_expect_validity(struct vm *vm);
 uint16_t sie_get_validity(struct vm *vm);
 void sie_check_validity(struct vm *vm, uint16_t vir_exp);
+void sie_check_optional_validity(struct vm *vm, uint16_t vir_exp);
 void sie_handle_validity(struct vm *vm);
 
 static inline bool sie_is_pv(struct vm *vm)
diff --git a/s390x/stfle-sie.c b/s390x/stfle-sie.c
index 21cf8ff8b6f6e9d61ee304c5748c36f718da65ab..5b642d9e8c3d775e078c1f09b87ad6822cd28a32 100644
--- a/s390x/stfle-sie.c
+++ b/s390x/stfle-sie.c
@@ -42,6 +42,7 @@ static struct guest_stfle_res run_guest(void)
 	uint64_t guest_stfle_addr;
 	uint64_t reg;
 
+	reset_guest(&vm);
 	sie(&vm);
 	assert(snippet_is_force_exit_value(&vm));
 	guest_stfle_addr = snippet_get_force_exit_value(&vm);
@@ -55,18 +56,73 @@ static struct guest_stfle_res run_guest(void)
 static void test_stfle_format_0(void)
 {
 	struct guest_stfle_res res;
+	int format_mask;
 
 	report_prefix_push("format-0");
-	for (int j = 0; j < stfle_size(); j++)
-		WRITE_ONCE((*fac)[j], prng64(&prng_s));
-	vm.sblk->fac = (uint32_t)(uint64_t)fac;
-	res = run_guest();
-	report(res.len == stfle_size(), "stfle len correct");
-	report(!memcmp(*fac, res.mem, res.len * sizeof(uint64_t)),
-	       "Guest facility list as specified");
+	/*
+	 * There are multiple valid two bit format control values depending on
+	 * the available facilities.
+	 * The facility introduced last defines the validity of control bits.
+	 */
+	format_mask = sclp_facilities.has_astfleie2 ? 3 : sclp_facilities.has_astfleie1;
+	for (int i = 0; i < 4; i++) {
+		if (i & format_mask)
+			continue;
+		report_prefix_pushf("format control %d", i);
+		for (int j = 0; j < stfle_size(); j++)
+			WRITE_ONCE((*fac)[j], prng64(&prng_s));
+		vm.sblk->fac = (uint32_t)(uint64_t)fac | i;
+		res = run_guest();
+		report(res.len == stfle_size(), "stfle len correct");
+		report(!memcmp(*fac, res.mem, res.len * sizeof(uint64_t)),
+		       "Guest facility list as specified");
+		report_prefix_pop();
+	}
 	report_prefix_pop();
 }
 
+static void test_stfle_format_2(void)
+{
+	const int max_stfle_len = 8;
+	int guest_max_stfle_len = 0;
+	struct guest_stfle_res res;
+	bool saturated = false;
+
+	report_prefix_push("format-2");
+	for (int i = 1; i <= max_stfle_len; i++) {
+		report_prefix_pushf("max STFLE len %d", i);
+
+		WRITE_ONCE((*fac)[0], i - 1);
+		for (int j = 0; j < i; j++)
+			WRITE_ONCE((*fac)[j + 1], prng64(&prng_s));
+		vm.sblk->fac = (uint32_t)(uint64_t)fac | 2;
+		res = run_guest();
+		/* len increases up to maximum (machine specific) */
+		if (res.len < i)
+			saturated = true;
+		if (saturated) {
+			report(res.len == guest_max_stfle_len, "stfle len correct");
+		} else {
+			report(res.len == i, "stfle len correct");
+			guest_max_stfle_len = i;
+		}
+		report(!memcmp(&(*fac)[1], res.mem, guest_max_stfle_len * sizeof(uint64_t)),
+		       "Guest facility list as specified");
+
+		report_prefix_pop();
+	}
+	report_prefix_pop();
+}
+
+static void test_no_stfle_format(int format)
+{
+	reset_guest(&vm);
+	vm.sblk->fac = (uint32_t)(uint64_t)fac | format;
+	sie_expect_validity(&vm);
+	sie(&vm);
+	sie_check_optional_validity(&vm, 0x1330);
+}
+
 struct args {
 	uint64_t seed;
 };
@@ -119,20 +175,33 @@ static struct args parse_args(int argc, char **argv)
 int main(int argc, char **argv)
 {
 	struct args args = parse_args(argc, argv);
-	bool run_format_0 = test_facility(7);
 
 	if (!sclp_facilities.has_sief2) {
 		report_skip("SIEF2 facility unavailable");
 		goto out;
 	}
-	if (!run_format_0)
+	if (!test_facility(7)) {
 		report_skip("STFLE facility not available");
+		goto out;
+	}
 
 	report_info("PRNG seed: 0x%lx", args.seed);
 	prng_s = prng_init(args.seed);
 	setup_guest();
-	if (run_format_0)
-		test_stfle_format_0();
+	test_stfle_format_0();
+
+	if (!sclp_facilities.has_astfleie1)
+		test_no_stfle_format(1);
+
+	if (!sclp_facilities.has_astfleie2) {
+		test_no_stfle_format(2);
+		report_skip("alternate STFLE interpretive-execution facility 2 not available");
+	} else {
+		test_stfle_format_2();
+	}
+
+	test_no_stfle_format(3);
+
 out:
 	return report_summary();
 }

-- 
2.53.0


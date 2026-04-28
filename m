Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927853CD8BD;
	Tue, 28 Apr 2026 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364145; cv=none; b=H7RJErBDg2sQxzMoY8CYTM2clpjH8I13rNQYLB94/NJop2Zou5n+wEwSs1SIsIWyx6syyWufZ9f2Ju3Cat9J036Om8xvS3/GCgFyBlsPP184SRBe4Xot2KEj2DheFjmVXKhAqCkxxKP8xQu5b2tfta6seVpb1Ff6aFUBBYMQttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364145; c=relaxed/simple;
	bh=ngk7H6gd/6/j9vWhxPNmol+zfoGVcFaoI1uzwCBjlso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AvYpl36r+bzQnfo61HQhRbzRH4hwHD8+KciY7B/jgBmig2nqcjBEYJfuIU8j/bfdy2md06CYEcl3zYKabHWD+9OO2WjdUORheTqa297jC6WppzFFMxfAqQp56JV+pGqBBm9WpLoLI36gEPwr2BRkRnONF6SBc20zkk0H0nHLRHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xn3KZOfI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xn3KZOfI"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RNsUQr1524774;
	Tue, 28 Apr 2026 08:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cg0N1A
	p/AkOV8nqotfOft0LNoDiYngooS5NcOQmwaqs=; b=Xn3KZOfI1gfH1dVnyGa6oi
	Bs2f84GIDEyLcgy9GQ2p/MApFpHtmmRLBUndckB3aVwgsJeXRTJykRIjUDL6TBww
	ezj34h98h1iVuuQ2mNnGhP8GwoJRwvLJlGb+XtT/FQtIm4iJWCyQqT/+K1nroh4R
	XiELfaNsuZoCoFCCeR8wR9PdBaF8rRpK5UgaxMwxPLUoxWKSmnvtJdYVbKS7PyKk
	ppVdkrn+e4EfenRuhhgWLpJ6WP6UnHt8DynjFpm+FBRsA2QAngNFBqu1ArWh+vqt
	e9u6N+W6fTHiNwa8E7dUxuXxFwHroC3QeL30LY4xdZV9ohR9IXfzYTDz/Fg6hOSg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vba5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 08:15:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63S88tV5021046;
	Tue, 28 Apr 2026 08:15:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamy8k2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 08:15:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63S8FYGR49414594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 08:15:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD12D20040;
	Tue, 28 Apr 2026 08:15:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99B902004E;
	Tue, 28 Apr 2026 08:15:34 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 08:15:34 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 28 Apr 2026 10:15:27 +0200
Subject: [kvm-unit-tests PATCH v5 6/6] s390x: Add test for STFLE
 interpretive execution (format-2)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-vsie-stfle-fac-v5-6-34c5933a218c@linux.ibm.com>
References: <20260428-vsie-stfle-fac-v5-0-34c5933a218c@linux.ibm.com>
In-Reply-To: <20260428-vsie-stfle-fac-v5-0-34c5933a218c@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5416;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=ngk7H6gd/6/j9vWhxPNmol+zfoGVcFaoI1uzwCBjlso=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJkfcpZa6pVYxOxn5dq15JeM0Hs+lx5zD4kJxZ4XPyb5X
 an/7PWqo5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgIlopjAy3FdU4H/Qev6Gu+rH
 /dpP4pQEH2srGi1buESju8vJrOecK8NPxt+tbmulduUbzJv04xyjQE/a/LthCw4Lxqs+mP5nmYE
 hLwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f06cab cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=XzANROlTOifqWwnuM_MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nuZjBz-xbYWMuv9xEXRa3fAPCDzd6TZs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA3MSBTYWx0ZWRfX/TDbG7kYuuO7
 5Aor2GPIOmXhDHkqKnlqABh5+ESdTwuQifVk2aBycaQNOwHiVhPIwsY0k5PmvAWVeDdAEryD2tW
 X2fCAEfF8lt87mt0fdJ0MaBoR1fcOBV9C57dphwZVu8Lq4S8gZRijQRB4uQcsOgCYP344qhQzY0
 9xQGHukbxHWtnWXzlNXYJnNQcbXJUM0+SbDtAnb2W8Z0OCQr7wmqYncOlGWK4UUnfWAgOOk8RV5
 aIurrMCrcbcv4hn+RRvG/9cQOWEvXpOvoTvjQOWOOjPAIGL7WGwgZwVey9u9RRfeLPq/wO6i0R2
 UuZWIFhDYGTPQJfwoHRxpqsrqltm9Qd9VfQtKJBRWIS7jG4m8Vwt6bvDIyXo9+vmdYcSpd428xO
 YrrSdy5pXoSIlxti5dUF029C1WmlxLutIpayBw31+sHZNjtdi7aQ2mUjuqqpKRd9UL+MJ0wMX7L
 IpZu0W0HYnuE/1TWB6Q==
X-Proofpoint-GUID: nuZjBz-xbYWMuv9xEXRa3fAPCDzd6TZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280071

The STFLE instruction indicates installed facilities.
SIE has facilities for the interpretive execution of STFLE.
There are multiple possible formats for the control block.
Use a snippet guest executing STFLE to get the result of
interpretive execution and check the result.
With the addition of the format-2 control block invalid format
specifiers are now possible.
Test for the occurrence of optional validity intercepts.

Move prefixes into main method to improve the readability of the
log by having prefixes for reports by tests called from multiple
places.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/sie.c   | 11 +++++++++
 lib/s390x/sie.h   |  1 +
 s390x/stfle-sie.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
index 0fa915cf028a..17f0ef7eff42 100644
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
index 3ec49ed0da64..8bea0b10b0a6 100644
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
index 21cf8ff8b6f6..e3ed22ee536e 100644
--- a/s390x/stfle-sie.c
+++ b/s390x/stfle-sie.c
@@ -42,6 +42,7 @@ static struct guest_stfle_res run_guest(void)
 	uint64_t guest_stfle_addr;
 	uint64_t reg;
 
+	reset_guest(&vm);
 	sie(&vm);
 	assert(snippet_is_force_exit_value(&vm));
 	guest_stfle_addr = snippet_get_force_exit_value(&vm);
@@ -56,7 +57,6 @@ static void test_stfle_format_0(void)
 {
 	struct guest_stfle_res res;
 
-	report_prefix_push("format-0");
 	for (int j = 0; j < stfle_size(); j++)
 		WRITE_ONCE((*fac)[j], prng64(&prng_s));
 	vm.sblk->fac = (uint32_t)(uint64_t)fac;
@@ -64,6 +64,47 @@ static void test_stfle_format_0(void)
 	report(res.len == stfle_size(), "stfle len correct");
 	report(!memcmp(*fac, res.mem, res.len * sizeof(uint64_t)),
 	       "Guest facility list as specified");
+}
+
+static void test_stfle_format_2(void)
+{
+	const int max_stfle_len = 8;
+	int guest_max_stfle_len = 0;
+	struct guest_stfle_res res;
+	bool saturated = false;
+
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
+}
+
+static void test_no_stfle_format(int format)
+{
+	report_prefix_pushf("no-stfle");
+	reset_guest(&vm);
+	vm.sblk->fac = (uint32_t)(uint64_t)fac | format;
+	sie_expect_validity(&vm);
+	sie(&vm);
+	sie_check_optional_validity(&vm, 0x1330);
 	report_prefix_pop();
 }
 
@@ -119,20 +160,41 @@ static struct args parse_args(int argc, char **argv)
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
+	report_prefix_pushf("format-0");
+	test_stfle_format_0();
+	report_prefix_pop();
+
+	report_prefix_pushf("format-1");
+	if (!sclp_facilities.has_astfleie1)
+		test_no_stfle_format(1);
+	report_prefix_pop();
+
+	report_prefix_pushf("format-2");
+	if (!sclp_facilities.has_astfleie2) {
+		test_no_stfle_format(2);
+		report_skip("alternate STFLE interpretive-execution facility 2 not available");
+	} else {
+		test_stfle_format_2();
+	}
+	report_prefix_pop();
+
+	report_prefix_pushf("format-3");
+	test_no_stfle_format(3);
+	report_prefix_pop();
+
 out:
 	return report_summary();
 }

-- 
2.53.0


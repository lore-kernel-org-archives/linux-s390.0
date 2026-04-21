Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9573783DE;
	Tue, 21 Apr 2026 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771948; cv=none; b=Ah4ysZoAPczL0Nm+HS+A8F5L2N+WTMnZ/Qo1qavW8oItMIQ+CEjK81Nm3e+RBZy28ollfir6SCqqfHuSLaBupkvC4j9Rdj98nxRBF3+WSI3E/fgtZBZknJK+PPyplrCLOXlfVQGijCCVeY/he8ACySXEQ0kv7lToMxO6DSIKxiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771948; c=relaxed/simple;
	bh=wamwS79G6m+uNkDP3zeAdFQro0g9XrC4bv3ODNZ6Ek0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rnu1sWTP1bxFkNTNyeGu76ehWJ1ktEeKxSYG7IVzJ8cnOjQTT3HwUIonKYxgSeswaZ84fSM7Gz9j4IvpHHMdqN23bBZYGiuVwRUQ1vVTKk0/NX4sd7KQ+wSHsnvGBKguPAf80AdBkB1MtkMinTgTwmOBQ0gBh8doggtiRr47zLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jpvUy7aZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jpvUy7aZ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KJgVb21684490;
	Tue, 21 Apr 2026 11:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZvnHdG
	5+r2cAu/h7YERd8ZHS6UHIEinOrphrFLbRCMU=; b=jpvUy7aZtCrnK4XhKEcaph
	wIj2Rq0Ke5mdhZ+EV0FtcEc56B234jWgt9d4h+3f7YNjkkdo8N4EwDx2jfUDWSbH
	Vx6FtDlonIad8fmeNstOCXLqv+poyJ1X79s/+Ou/zrBj0qaRtQdQpR7CGL5pYr7L
	nggt3n6FTbnTQlHUQYWkv0skMIUF0hRtdKY9xtDd8cVs6nMnYZslOfP0pMdjOAyG
	lBR4xCmuAzJHkvKomy8qnQvdeQHlGipa1y6LkXzHrpYT9JReZ8wve0heL0Ax3Gy6
	0lrJthfdKD90gMQ/LrlRAucAQd66fTbN8EKJKncmakBi683Sc9C+S2Ri0dAjDTeA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2j6m25u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 11:45:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LBZPX8009524;
	Tue, 21 Apr 2026 11:45:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmm9q0nup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 11:45:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LBjbSN51249642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 11:45:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCCC32004D;
	Tue, 21 Apr 2026 11:45:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B68F2004B;
	Tue, 21 Apr 2026 11:45:37 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 11:45:37 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 21 Apr 2026 13:31:12 +0200
Subject: [kvm-unit-tests PATCH v3 6/6] s390x: Add test for STFLE
 interpretive execution (format-2)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-vsie-stfle-fac-v3-6-3cee84efefa3@linux.ibm.com>
References: <20260421-vsie-stfle-fac-v3-0-3cee84efefa3@linux.ibm.com>
In-Reply-To: <20260421-vsie-stfle-fac-v3-0-3cee84efefa3@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        kvm@vger.kernel.org, Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5364;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=wamwS79G6m+uNkDP3zeAdFQro0g9XrC4bv3ODNZ6Ek0=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJnPkxM2/TzRm+G3z6BtXdTtHudQI967stkrrX49jeNfw
 y/9em5bRykLgxgXg6yYIku1uHVeVV/r0jkHLa/BzGFlAhnCwMUpABMR9WD47/v8ZeVVY58LK82t
 P0km+TG69d36pu7FsLS0tenW7P/3GxkZmvZ/Z7hps+tEQJKEThkL98ul0hPLFvMY3VGoOHqhXyq
 BBwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDExMiBTYWx0ZWRfXytOkeFh9En/r
 FT+BxJGOWlBPoh/rxXSMzgZqReBtfo+6P1pRBtRZwxZhe8fW1wH+wzXJ4E08qDtDe/gDeH6h8Yw
 0VRSObGnbjA/jeZ6reYlVqHdTWRnkr5Tp/8JoOh3FsMMUe9yPK1kyDi4a39IDMjnEiJd+Yk3NiG
 Fil3cVwPgBuLg42sgdP0aiSBz5aqqM7z+a1TnxfP6qqI65YIIzPbDgCgN8TYae7jCrh93BB0Jf+
 Mp7Emm2S6ydUUgTIh9ApYCavZ9QnFVgad70m9+fDK3c6jcJkwgxrmecIYrxEUEOpca+YcjFkBEk
 OXsxDO1zE+H6lZphoSvONwrJkM9d3KHpC/FGnLERjCT9otv+yeuHRB4t8Q2CJsf0791Tny2KRYF
 fJuNzBD5GkBfLIUe3GJbENC1jzBV6cO0KE10m9DD+cmbc2V4jY+T4r8IHNeGMLfLduhLTBWCL6u
 0Ds/CUuOg1zeQZ8AQow==
X-Proofpoint-GUID: B3TFI_gVuUDix5hdyz_Ha9vcBfZq1uan
X-Authority-Analysis: v=2.4 cv=SOJykuvH c=1 sm=1 tr=0 ts=69e76366 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=XzANROlTOifqWwnuM_MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: B3TFI_gVuUDix5hdyz_Ha9vcBfZq1uan
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210112

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


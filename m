Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8EC43C05E;
	Mon, 24 Aug 2026 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582308; cv=none; b=sbsqEKjNZzWz3XgyM5AIZwUj6PqV8LU2LXBLamF+gft4r5yg5t3mwP4VtCzrg/bV5tWFIdc/mUSOCIXX1M7UOb2FH5lkihjjsaOkmjxF+QgiTTnRY5sILrLz/hc4hvhsPEiPwjBvVWZon6LFDD1zaur258O9SRhmBhuKXC2nDVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582308; c=relaxed/simple;
	bh=FMHFWB8GkXN6dRqP3iHRcP/Pq1sGzAbeJ4jPmDt4Ii0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JB43eqg6HPy2gk+m+8T+KmT/FUxtAKE1B2sEPQYGEP5SlGXM6JUX4lOiihwtMELlrAeivfLYY0a0COn3YoBYJNSzHMikXBotbMk35hZkD1PeMUvwEUxhe7hKlD+QPKyr5InLDAOx0R+ktgKKuo3aM7JXBfp4KectFZlO98/qSJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BY4oTqT3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BY4oTqT3"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1Y5D1935890;
	Mon, 24 Aug 2026 14:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BZVHUYpD3MMuP9+xo
	o3+zI6z4+yhzl9SNwk5OI2LsEk=; b=BY4oTqT3qUvFpE+Qf+DUmgeXQvcvIOGC3
	bLoQW4WIPmGR8KBIQx5Fc2x4TU5yJ8PIxt1y4BIWOul3kn/ljUvvYVC1mwGMYR7i
	TtvSz3IVknQxG8KCyENxUKTtRDsNLyIIV2J/YteOebXLjuFCmvkTFvhNMquuAvme
	x59bvW69igbeBrfEtOiA8br3ztTOYTDHGzVxDTUsE1MFlFxXcgdphW1qWbnCKj7A
	TIU2he4o68oPooEmT8aW17J4ZraVfChANI4yiwpHtRTOXcPmMv/mgTk1SQSIMV4X
	7xBSxMFMI/IGnEYD9USt87XbIDD2uU4Ej2a5gvCovyUZcW6j8ioJA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393t1q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQI7d001403;
	Mon, 24 Aug 2026 14:38:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfvxnqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OEcHVs37683532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 14:38:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F4A32004E;
	Mon, 24 Aug 2026 14:38:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DDB32004D;
	Mon, 24 Aug 2026 14:38:17 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 14:38:17 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, thuth@redhat.com,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [kvm-unit-tests GIT PULL 10/13] s390x: Add test for STFLE interpretive execution (format-2)
Date: Mon, 24 Aug 2026 14:35:42 +0000
Message-ID: <20260824143740.291583-11-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824143740.291583-1-frankja@linux.ibm.com>
References: <20260824143740.291583-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2-G08ZwvXlleweqwit5LrZTM8rhicUCG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX98PTc0xG0iJV
 cPZdNAwZXHxIWr9d2Cc0BX0HysTUfTlaENI0Wi0nrxLxDLD/8Mpgi6X17S9tu1rnFJq3EhgTdv8
 wesbyXcs8LrBuMhoZo+q5Vtr6oK5+FrhXe22MLSBoLbEXn4LhXc7vTbRJjeqnW9WMCixQs35POx
 mFhg0g6iDRuzT3StF5Kh5J2+T6n+Ft+ICZOXfZJ6jpb/i6bVjr0ws39wHPVU0GEQNQlaJfXBKyE
 1DAR54WE/O392epHeMXRTtupv+HXjIvLaX0Ar/iMnAXto9/Lw9D0nMtisnncGEYXJRSHNtrrbk6
 54PX3whHlnqIrMWsFOtDS+WjnJNvbiMrQ4i+WKLaQZacS6iOvZ7cX9it7Om1iwVNpCJhLzRtzPS
 xIBrrt6Ogo5efTEu53NgZwDyz3jDOx9eak8RRYqtoMoZlJ2hHOWaGV75qfHBbLfG/2utVMinvAO
 tlifWkZm8BFNUo87XXQ==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8c5760 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=XzANROlTOifqWwnuM_MA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX1iY2OCuIbtwB
 U51rlJ8PM/Frhwk0iCMSE+F6BR3uDnIsa0uvzs2JGUvl9yIBzTlT0BxvaULSPXdlbKNWlL3zLVr
 SVEhXvI8GGUKIWO3svfaaxckygsFNLU=
X-Proofpoint-ORIG-GUID: 2-G08ZwvXlleweqwit5LrZTM8rhicUCG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122

From: Christoph Schlameuss <schlameuss@linux.ibm.com>

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
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/sie.c   | 11 ++++++++
 lib/s390x/sie.h   |  1 +
 s390x/stfle-sie.c | 72 +++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
index ad1f2ade..99089dc3 100644
--- a/lib/s390x/sie.c
+++ b/lib/s390x/sie.c
@@ -43,6 +43,17 @@ void sie_check_validity(struct vm *vm, uint16_t vir_exp)
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
index 85d691d5..e5970f36 100644
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
index 8df1185c..3697e1ae 100644
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
+
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
 
 	snippet_destroy_guest(&vm);
 out:
-- 
2.53.0


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA69D402BB3;
	Tue, 24 Mar 2026 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366137; cv=none; b=jxhWEjIMFRLdoJZjIAnV2AY+ZW0/SOUoWRMTDNUDvaLMhHPkewQYTrzkbFo8cyktQuf731rMYGeUijembJgtDa5wqamvCk0+0SlG8dWQY4SvWEJhvSkZjarmYO9+nFJ5kPjaut1Di/0utfFgS3bVRz0oKSbXIg8H2WbpzkounTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366137; c=relaxed/simple;
	bh=nj8tyN5K9IV2ruaCXx+MIS+NBoCCUv1lkrW+vmdDF4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HjI/CokSRF+b40JNQGhlpNGLY9HPO9dkJnfdLUkT1jXZiV6amILw0Xw4E/Vj6OhIY6BsprWAlBLkCIOKHBs1Kuxmj9aPanfTNiLzLjrTaGNaUy3KEGtOW+SHMp8PW3nJAamLpByMjdnTAh09BMZ34loBrN2oZO8hwbj4pqCEbZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bCkLITpa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bCkLITpa"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O851rP511489;
	Tue, 24 Mar 2026 15:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CzAhYL
	FzdwACMhGLFHHMS4NEGVOqEHwlaYC4nSqS9Ig=; b=bCkLITpaNW58jAOBE/ekgK
	wPzZ04bJAJtbzQyBFb1pXb+5nFJUkWyjcyQwpMlBtRX88CJMyFc9ZBKMETNJp5qs
	Wtken+880aOXlyiX0Tn64OyfL1uP/2De5JwkxU6j/BV/ymZ2/1K4gNDSVyTJti8H
	FFHvqFZoOqzolcWx4hdJ1RnT/2EPIl2bXjK0Iwr8EUwUYKlCjqMfuDkf3rdCDrED
	/kRJocTw5veshQac2W6bfA/mDKyq89lPjNTdIcayVbonC4EVB19VidCNZ466fFzb
	QY+gGgq8yApmO8GpdG3ggDcgXPWeLBtozTtIPg+ffxkrm2Q74M9oubbVinFZmppQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9v884-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:28:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62ODCnBW004387;
	Tue, 24 Mar 2026 15:28:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c228kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:28:50 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OFSkjY58458558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 15:28:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C117620043;
	Tue, 24 Mar 2026 15:28:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F373A20040;
	Tue, 24 Mar 2026 15:28:45 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.21.79])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 15:28:45 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 24 Mar 2026 16:28:05 +0100
Subject: [kvm-unit-tests PATCH v2 1/5] s390x: snippets: Add reset_guest()
 to lib
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-vsie-stfle-fac-v2-1-5e52be2e4081@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2081;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=oP6TssNs+FdnTGLZDSEzF0I59U9yn+qnYhz6t9OwyRE=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJmH1q6RU+G4k1m7cVqEg5SarlGa9+H6wokB+ptfnpmWt
 G4b49W0jlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACbSaM/IcEu285SecnKYhLTD
 7SrPucbf36R1XAmb6bnZ736+6clDTAz//TOnPbi1fTZTwfw8G8fTS5ptJ01Mlhabu79o/RbudTc
 CeAA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I3kdCOEV0fQCxsrLGQ7wIlY01_YVjfhV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX9PbyLMOBsMf5
 i4BYBUZYOZEqqDl/166RDEVfeCxyXjJ2aXeMAT4Gf600IZThct34aIO8XVtjwHc2i9Zz9pNijp4
 JniOZ9JtT8bFUgIH3XHmTAcUg0Dl4WicH4JFjM6W1Iqo+newXZKYN8s7OsaT8OEOKvVqzPbgPyS
 EG+Hd6Le3bCL1gaAOo0xh3t/zyi7rFdtxMHukrQi9pSwJrTb1jY3VxQiPawP8YzkJMs0g2mV8rV
 5M0gxwKs8kKcZ71VdxEvb6BfHJ7iW54gieYQoZB36VtQ571DaNTvCvQDgqZPdWPhkyaq2TffZz1
 FDASMh7+q30D9O+kvxUuINDRdE1OXgXaZGGuyoQFxPbSagZs9TK3yg1UQ6qV3T96GhVwEyRANpE
 UDN40DQSESMvOSOCJMqe62LS/iICpA5yilthBUQfsD43hPGod/hOPgCEObG4Eo0JUpDzfKGCUH7
 ppYsDjUS0iC6UtQSV0w==
X-Proofpoint-GUID: I3kdCOEV0fQCxsrLGQ7wIlY01_YVjfhV
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c2adb3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=_bFefhojSA62otXczxEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240119

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Extract reset_guest from spec_ex-sie into the lib.
After reset_guest() the snippet can be executed again.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/snippet.h |  6 ++++++
 s390x/spec_ex-sie.c | 10 ++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/s390x/snippet.h b/lib/s390x/snippet.h
index 910849aa186ce2f94c64ac1f40f8d6d7cdc36a1f..6f611de510d832f23384739606da13e71de3d6fd 100644
--- a/lib/s390x/snippet.h
+++ b/lib/s390x/snippet.h
@@ -83,6 +83,12 @@ static inline void snippet_init(struct vm *vm, const char *gbin,
 	vm->sblk->ictl = ICTL_OPEREXC | ICTL_PINT;
 }
 
+static inline void reset_guest(struct vm *vm)
+{
+	vm->sblk->gpsw = snippet_psw;
+	vm->sblk->icptcode = 0;
+}
+
 /*
  * Sets up a snippet UV/PV guest on top of an existing and initialized
  * SIE vm struct.
diff --git a/s390x/spec_ex-sie.c b/s390x/spec_ex-sie.c
index fe2f23ee3d84fa144416808cb4b353627fe87f3d..75625ecffc4a5a09ff7ef6136b7f1120a831a8c5 100644
--- a/s390x/spec_ex-sie.c
+++ b/s390x/spec_ex-sie.c
@@ -31,12 +31,6 @@ static void setup_guest(void)
 		     SNIPPET_LEN(c, spec_ex), SNIPPET_UNPACK_OFF);
 }
 
-static void reset_guest(void)
-{
-	vm.sblk->gpsw = snippet_psw;
-	vm.sblk->icptcode = 0;
-}
-
 static void test_spec_ex_sie(void)
 {
 	const char *msg;
@@ -45,7 +39,7 @@ static void test_spec_ex_sie(void)
 
 	report_prefix_push("SIE spec ex interpretation");
 	report_prefix_push("off");
-	reset_guest();
+	reset_guest(&vm);
 	sie(&vm);
 	/* interpretation off -> initial exception must cause interception */
 	report(vm.sblk->icptcode == ICPT_PROGI
@@ -56,7 +50,7 @@ static void test_spec_ex_sie(void)
 
 	report_prefix_push("on");
 	vm.sblk->ecb |= ECB_SPECI;
-	reset_guest();
+	reset_guest(&vm);
 	sie(&vm);
 	/* interpretation on -> configuration dependent if initial exception causes
 	 * interception, but invalid new program PSW must

-- 
2.53.0


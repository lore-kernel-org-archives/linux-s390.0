Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D450F32D438;
	Thu, 23 Apr 2026 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954443; cv=none; b=CdPuyMhL6TSRoNH1ioSaskdKXEr6hfyV1dKzApSg2ocOKdWghugk3dX/D8TdM0ZZggOWBjPrNmD9kfG26HJfdWh6NsCVS5yygbErl42XD2xYZIothImOwkWEEmH0RiRoN5mA0lHhNvDyhwZ861zydiVnPzUHeR7wWPkhqrXpCwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954443; c=relaxed/simple;
	bh=qkWhJvM2KfaD2CTFFEMvXKFfbm4En97C1tiACn+3Pdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VzO/l2DQZ+1Jr9fLhoOrBbslN3bpXyDTN8q3rcNrVDArLp6SabUns+0buBEwTct1ScuvzE5XG57GI+Dl0u9ld6JInZW8B9X9RLFSd0wW9ddF8yTCySjnzw06C5MIU+jfRVAZX/VFJq4kr3Ea7QXzLu4TaSnpdYelU301hDCQE/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rOJapINP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rOJapINP"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8ek0K3944147;
	Thu, 23 Apr 2026 14:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kh+0oe
	ceshKmn0rO0bKSNpT51u4W1l9P4nryzdCM6Dk=; b=rOJapINPsaAVnrUUjz1BhX
	8r5pP0eSmBW0xTE3mp11Xtbg8S4zMx9nWU2HdqIuTDl8yyF7QXxNH7l0KHUd/OEh
	PoxJnIf5ig33De1bc0z5EdqeDbKXYy3SBSOP5CyoH7ShVJoK6tP8y8+liO6UAJEE
	mo7zdmYo4I3iuTKXUkn7O820RFw12CB0A+G59oYzC2RrsVorkg7FWbDzFYo+c7pI
	X2VBCYcVgRDxRpBfsE7OzI0QTb+8boHPJnTqgMPCJil7+Y+lbnt7hqptVqgbp4fR
	Wp/SxT0pTRkXgKDVjYVLe8m1QebXJZ1K9FtDhQphtxhdL8laucvU9I97zA5knhzQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3rgc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:27:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NE5Vqf001248;
	Thu, 23 Apr 2026 14:27:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyext1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:27:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NER1D931719734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 14:27:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7835A2004E;
	Thu, 23 Apr 2026 14:27:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5269C2004B;
	Thu, 23 Apr 2026 14:27:01 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 14:27:01 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 23 Apr 2026 16:26:45 +0200
Subject: [kvm-unit-tests PATCH v4 1/6] s390x: snippets: Add reset_guest()
 to lib
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-vsie-stfle-fac-v4-1-32943fe43394@linux.ibm.com>
References: <20260423-vsie-stfle-fac-v4-0-32943fe43394@linux.ibm.com>
In-Reply-To: <20260423-vsie-stfle-fac-v4-0-32943fe43394@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2014;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=RH8dfsfCZRN4Cf6V8h4S8Wlq8Oewg0791ynba/ejYPc=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJmvdExW7NVpXHkqc4mN/HUNFvvnzhrXzdJqNX/LNpVan
 hFYsLKuo5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgIkknmX471cTZ1R3nf/UpW/W
 OkLFiWs4thtPYQkJ4bwbO1N80lTZKIb/tYav03ZH7pM9/EVq7Zpv7tYdH4U/i5oomPYYLVt/ffZ
 9RgA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aWkl0hibdzisWuzdf6hdlkUFHRIFnE3F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0MiBTYWx0ZWRfX9ae383xQq8TI
 NxYGCW0oCxfW+CSxleLoW5r9qhPE0akZsQpGnjFhCusWSSdMzDkv3okOHmRZC1XRW6mKUcdj+Tt
 ODLH316vtmG/jAxmB92JlDwtPC9ZQBqEybSpkpQ73r3Nva2Qxf2H5MpSwl3Ow3qtXroZD0Vh+ND
 KYrrLv5rfAR/l//cqXmWzUIIYwRRd4PVEt//hvT2ye8Xi+5q9f4iCd4gUktUj5ZoG3tlPtqlOzk
 U3Tfad2EaAe7JPt+yQLIzRcvbZSVWGStkydu28AIb/Ghp3BxxCHQ1FoNc5vp1BF32UCBGhTLvdA
 QgZTFZh+0ARO/p265Adjg4UQofS7Aik1j07fzvQlNEkAoCuc9mmFL0YdbuPmEDXyecOyYtpQu9O
 em46lWJbBUFncmGRXk9xEGXaRMN2SZF5s2VsLo/uURjP95mCaRHBrIx9xe8drSEDqb4KZXR2LkG
 x0E2t6A2PfpCX40wycw==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69ea2c39 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=Cd5Zmu1nkpE67UhzTUQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: aWkl0hibdzisWuzdf6hdlkUFHRIFnE3F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230142

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Extract reset_guest from spec_ex-sie into the lib.
After reset_guest() the snippet can be executed again.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
---
 lib/s390x/snippet.h |  6 ++++++
 s390x/spec_ex-sie.c | 10 ++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/s390x/snippet.h b/lib/s390x/snippet.h
index 910849aa186c..6f611de510d8 100644
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
index fe2f23ee3d84..75625ecffc4a 100644
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


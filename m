Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7017F43B6D4;
	Mon, 24 Aug 2026 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582308; cv=none; b=AK7WZiCX8/c566x8zoC3uk/RCOiNZ5j+s8kexaf24IdcjvhLxQYihAy/WyMXZDT2l0b8X0dX9IjB5dkahYN0QQLxvrWwtSP7eduMVw2b+CQBsvvb/YvVs7HuB3L5/08SPBluZMLkOEGiHCxULKC6c6Xuyf+NqS8EtClXXMbPkyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582308; c=relaxed/simple;
	bh=bSdRmgPB8ZWEfKhHb2Vx7rPdj1MQ1+WbmT/RoK2Hxxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1PyVpyxlSq1NlwgABrPJ8LACRt9VikigYbtXs3+aloeVEUY/dq3/qXwWAiijGGbnVv7pgtmSHZO0tjy3s/jqi8XXt5QhKEQ6winQnRL6YEg29vBdTe0RybTEpv6OeYYEE6+7l5yo6E2YTCcfM2sMUFfRV3Icmugmt0wNUeRHVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k0QtOF9V; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k0QtOF9V"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1tJm1846243;
	Mon, 24 Aug 2026 14:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SxgUCDDxqryexFFD+
	xrXsKrrQd7b5FbyCQQfr6PTREc=; b=k0QtOF9V1lAwbaSXD5BC4E1rpPAgDnuFS
	T1TyUy7Ur6CVaa+k7rvH2Pk5F6F+KVOeJVsgeP6+9yhJ0nMO0kKrM9yZKrwVIxCy
	2BMEp1+jytsQLn99VHV2hz0vsm+vYvd2qkePJ4EeLyYyYVNUVrVh749zxa5gBvr4
	5+evTcCGuA2wxYvy7NSuqOIYI5ybJbL8GfhzrlZ7LsUSwhZ7a0V3uB4hN2xUhPAj
	gpBGIv59VtwHgQTlBoBxhFpot21c+jgKyRALTlkeoFbJvQybWVHBN1DuPfAj2zq/
	hXFrizzCCzDEEI81jqsvhGXwZkbmJTatDL+EzDnUft+YA9lhDeHdg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hj7be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQGHX029699;
	Mon, 24 Aug 2026 14:38:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jpj54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OEcHfD46661936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 14:38:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5303920040;
	Mon, 24 Aug 2026 14:38:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F8D82004F;
	Mon, 24 Aug 2026 14:38:16 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 14:38:16 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, thuth@redhat.com,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>
Subject: [kvm-unit-tests GIT PULL 05/13] s390x: snippets: Add reset_guest() to lib
Date: Mon, 24 Aug 2026 14:35:37 +0000
Message-ID: <20260824143740.291583-6-frankja@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX1xaLWXSs9Wk5
 SjTTelLLF5wDiZXB09sJZUCyUqsZjoVmrqWJ34t+1sERtWoexFNOYx5EXKPhgsCKJXrrLTAsV4q
 1PKVvSbrCza7Pir+TlQ0lsW6ZAeDx1o=
X-Proofpoint-GUID: SRXzm2E58WCx2YP1V_vAwToTv_jbALjB
X-Proofpoint-ORIG-GUID: SRXzm2E58WCx2YP1V_vAwToTv_jbALjB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX2B2YhRctqHlI
 HYFWM+RBwt/ovj8Z1UxTA8WhtOXm7j1nptgitP5UVmsNg+zLKRq/s6URlqbjkI+mQvsiB8+hsBQ
 e3O6IoxDeNTVfiWOJflhQ6PL6IKSNXNx+4owdYJIm+WZc8OpnYSgbEEH6XZd/XrmH1bKIsjNZQw
 qWLe735+fFa2Mpd0s7phx+6ylb1KAzQ5jiBSL+Fy2rIf0PVJcP3DHJttcvaTO1JE67xUZAXNtUH
 3S6BQZnHjMVbE0ES35nv4NoemAJbebdD/+zT6QVfwP5fyQVOljq3K+/nt9yVm6EG1s3O6RGLU5j
 t/HvcIqPuBvXwM+D8gILXK7yj6PZi7ZHuItAluZn84hpgNa7+1/FvllPWEa36fe+J2I/FCvQF16
 3s8dVIth53sCgRGLWq0ns1oNKbo7Pg7FrSuqxAMRuy11Yh/QPmPDpit0TKOAMYwT+MJrb9/8zb1
 DErA2u0ktHOl/gNIOKg==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8c575f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=_bFefhojSA62otXczxEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Extract reset_guest from spec_ex-sie into the lib.
After reset_guest() the snippet can be executed again.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/snippet.h |  6 ++++++
 s390x/spec_ex-sie.c | 10 ++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/s390x/snippet.h b/lib/s390x/snippet.h
index 05c9a2d4..83d74387 100644
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
index 6ab4144c..dd4ab77e 100644
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


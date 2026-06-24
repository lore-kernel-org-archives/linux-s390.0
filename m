Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327063876D0;
	Wed, 24 Jun 2026 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299982; cv=none; b=gfWRxB/afUlG2JXq4ruq7LxxfB0H/wmGy1KfjN/cVEvIV6qYxQwTvTbvlNAkoDYO9tm6xd/3kc9VlmeFk5XuTbxC3pltwdW5Jw+F1aK5txRFcbLqqOwTRNWvM86ObhHVKRGetWnk5iQ1ILdLwRFYMHpEb+hnFQD5Gy4a7cRiFmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299982; c=relaxed/simple;
	bh=LcyCwOkDIt/8pMSJgNjJliu7zkRB4J9f0lUhrALKB3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8zFXRr3fSs1LlgOnU6zy21FZq+sbEAXInkBZe1lEQ7elFN7+pyCQXYNejfe6GXceleeJXKbynxfM1QnoeDsQaM7rmKzWcA5pBMUWmrQxSP2Xr3dgNoegokDJ3AxycTiMH8glPMoLsclGDgiqh2GBJ0q94iGBrAwnUIugfoAnJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FNmcxEyZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FNmcxEyZ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OAmRg7718050;
	Wed, 24 Jun 2026 11:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=G/YUK+Tg0mCDwXVuk
	J17SLYSea7OiqkD9E/+yx14NRg=; b=FNmcxEyZ2pjp/CxifQwdwFJkm9EjUL1HY
	MgHxcTluaeiUdCuclrtsQzlLhuLf+PaGUsIUTehGDlEsMQS1Wm2+RqOtFg8ZGSzF
	oJvgB8gyhqDfRBbQ0DwokLbCMmJU/xDEtSAA+B64eWrJ+aGVMs0dtk/QTq9V6DOy
	VTQHJMxRy+2NwFbQw/9cwQ6M9sVbTmjdf4Q1lISOUHsROG1kI+Ep5Ro5oKo5rZNo
	l/oG0g/ngbE1RkNGcXdSJ09L7k9L+xvA0EfrWmjOVLtlF4Rre3qaaweWsrhgSLGy
	NSW9JyjjVh3d1ONhQxd35BL8RlIkH3Utn8aA5LwabVxqWssVKyInw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3kv63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OB4gTZ005957;
	Wed, 24 Jun 2026 11:19:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwgc3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OBJVHE26149328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 11:19:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A90420043;
	Wed, 24 Jun 2026 11:19:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 423802004B;
	Wed, 24 Jun 2026 11:19:31 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 11:19:31 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 11/12] KVM: s390: selftests: Fix cmma selftest
Date: Wed, 24 Jun 2026 13:19:27 +0200
Message-ID: <20260624111928.144283-12-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3bbd4a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=DNRWrYgN0gedYPQHzkwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfX/B+X1olqob+l
 6QDggusz/VD0EmNdGjjfs+tjPOUwaTu/3FDBByr029ybk3yiXxJCdBj8H7MBexaHz6NpRxYJNKs
 Y0c+z+j+WD+07vGknVl/Ar2QxjyoFr0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfX+U2tB0o+cMow
 D/nKRGrJ2VFWBMCCqZRIyHW6cQGv89Auc45lZZlePggQZ2DQ9EExo/2kStcCcmypFUnjvoWy5xi
 v2VC3SKmYmVubW10dhbtdHlEv5QI5cJ/wlq2YA01wUXBo3VVJnj6ex1LLVro0yR55iE3JiApcnZ
 lVW+xGd7Uqe12FPf1mk9ksKsY3ubmEq1JN2/zqLF+i/SvYIjQTjM1WjZgNtRMtIpMgDd1FKhPqJ
 h2U5BjhDzObux24rurjnU7jwfeTV6AFmJJ5IjqNAVNLzh+3OrHzDbhbvXhe2xRZxG+mZnEp/B29
 2Ql/Sx4BlQTl5qUjktN2N2ln6eWgvuYYSqtc3wnmG88LDnrtB1W9AjcRNaDjRFii4qSgCYItChF
 W56RFEvWnp+3Dudv1TF5tIoA4PKV3Vonz8JskyFFh5vo0j/h+mccyn/8hb0sf2ppUZUO50pMlut
 RxPfIC6cXkYQ6SeREhw==
X-Proofpoint-ORIG-GUID: Ylhzm83NMbUXtmghJS5GfgYv_QMlkB7p
X-Proofpoint-GUID: Ylhzm83NMbUXtmghJS5GfgYv_QMlkB7p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240094

The existing cmma selftest depended on the host allocating page tables
for all present memslots. Since the gmap rewrite, memory that is not
accessed by the guest might not have page tables allocated yet.

This caused the test to fail due to a mismatch in the assertion.

Fix by having the guest access also the second half of the test
memslot, thus guaranteeing that its page tables are present.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260623153331.233784-9-imbrenda@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390/cmma_test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390/cmma_test.c b/tools/testing/selftests/kvm/s390/cmma_test.c
index e39a724fe860..15d81b2ed7ad 100644
--- a/tools/testing/selftests/kvm/s390/cmma_test.c
+++ b/tools/testing/selftests/kvm/s390/cmma_test.c
@@ -34,16 +34,22 @@ static char cmma_value_buf[MAIN_PAGE_COUNT + TEST_DATA_PAGE_COUNT];
 /**
  * Dirty CMMA attributes of exactly one page in the TEST_DATA memslot,
  * so use_cmma goes on and the CMMA related ioctls do something.
+ * Touch the page at offset 1M inside TEST_DATA to make sure its page
+ * tables are allocated in the host.
  */
 static void guest_do_one_essa(void)
 {
 	asm volatile(
 		/* load TEST_DATA_START_GFN into r1 */
+		"	xgr 1,1\n"
 		"	llilf 1,%[start_gfn]\n"
 		/* calculate the address from the gfn */
 		"	sllg 1,1,12(0)\n"
 		/* set the first page in TEST_DATA memslot to STABLE */
 		"	.insn rrf,0xb9ab0000,2,1,1,0\n"
+		"	agfi 1,0x100000\n"
+		/* also touch the first page of the second MB of TEST_DATA */
+		"	.insn rrf,0xb9ab0000,2,1,1,0\n"
 		/* hypercall */
 		"	diag 0,0,0x501\n"
 		"0:	j 0b"
-- 
2.54.0


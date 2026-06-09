Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F58147DF87;
	Tue,  9 Jun 2026 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017786; cv=none; b=eFNrY5FlpYdxGMxoaTzNdwNh+L26/NqA0Z8+IwVhMaxyBWOcGEuWoDgH6ilHAsrr+zhjG/axGtJtgEXBQvaqEyQA6u1FByLREqLHyPzUXZdt/po+DpXzK8c4OlVY/lIr2ucg/G6fVgY0LX7q0jTXdNe/joJGR1dydk0HPHkJT8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017786; c=relaxed/simple;
	bh=qEMFV2rQ1lLtFNIT3IfQXwjFxZegakxp3UrBdNXeZM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7sVU+DQIBP+lpO92UjfCToRQllg/xwf836DYBv5X/pGrmKfhJDD80nm124VjMe7Ht739EhZvkssVW7iaUatBRzs9EDm0Z7HG5DPXUOeleQAkSh5BTRtvNDO6r1DCxsv+ddOlkxsUe787ODDN+qJMm3L2mb3l0DlPx7HEB5lbUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=czyH7iJo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="czyH7iJo"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659C5DMw3078674;
	Tue, 9 Jun 2026 15:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gOOjuTTIBGHweYQN1
	nSeRcnw2Ci1G418Omwj3yy2jYw=; b=czyH7iJoGpqJdN90HhS+JW2YH3h8aMSa3
	peSOiNXZy7JuL8rvfnXso01sy8xT75lUHo022ehU22PJk0SY0o/8ELEYaREEH87L
	IEBz7lInVJGIlO6t0PDEn6l44ZxzCqIa4fvvMcQpT569aedGyEhB1qoS2p7whhIf
	mC+ydgUxrLrnnF2dAQIcXBE+vFOokbmCsuzA+0bdrUI1Cu6S4InU/gF04rtXjFWb
	qqF/MHAIkWO02w5ieNdYjVqOLVN5nejpNJrPvzpmOr0S6T1S3Xg/Uyfo55UOvZ+C
	xZzR28TBV1EVIbPVdL8ReVQZv764VjjioH++GsfnwnYdG1drLHoFA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23vuv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 15:09:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659F4ZEF022351;
	Tue, 9 Jun 2026 15:09:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq2pn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 15:09:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659F9b2531916528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 15:09:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 159762004D;
	Tue,  9 Jun 2026 15:09:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAF4D20043;
	Tue,  9 Jun 2026 15:09:35 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.28.58])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 15:09:35 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 3/4] KVM: s390: Allow for 2G hugepages
Date: Tue,  9 Jun 2026 17:09:29 +0200
Message-ID: <20260609150930.665370-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609150930.665370-1-imbrenda@linux.ibm.com>
References: <20260609150930.665370-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a282cb7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=jBZgYMDF7q3Z6fg6dRgA:9
X-Proofpoint-ORIG-GUID: Hidc9QAdQMj56rBSFdNKUF4gwbeIleFd
X-Proofpoint-GUID: Hidc9QAdQMj56rBSFdNKUF4gwbeIleFd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0NCBTYWx0ZWRfX3Qs84RZADi8z
 OWa2DimStYGxrLyp8BeWJYTu1s9nQVdxusRarJe34X64zqdQvhfUPWV2UvbGffnTaOmTNt72ezX
 PA2PKUpXuPD+PHN+YGaJuBUFyRQ68QbpOpuoEMu064vXRc4wqTZB+qXuPNacsvmpQnwEmnHu4Tq
 tt7DTF6E2YjB3naT9s5H+VaZy4+b2renGrSJp9uuUe1TDICkLICmh9qvn1/IkJk3svdZECtYSHc
 kuqt2GH8u02fQrabIkA0IPDehNoNOeFha4f5dTxFRFEyFh9VGGM+VUWiiXANTKIvg4kBwturzkK
 8tu/tFGQ9kLMKG48utwqbgjcYEJfXy1CJe8SPIy9uJKPzV5cY9TmRLDqW8UJmq1e2LScHk79QzQ
 jqGgPyZgt92I48o/yJM8pJfv3jcdy8bqQR9obTdbufkgfaz4u/ikhxMlfXGL1BaouFTrgoyXhqh
 /Weeyrf3tkMXbVf/Tqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090144

Change gmap_2g_allowed() to perform the necessary checks to allow for
2G hugepages to be used, instead of returning false. The
GMAP_FLAG_ALLOW_HPAGE_2G gmap flag is now taken into account.

Also add appropriate kerneldoc comments.

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index c9e348149ba1..c5a8132eaa22 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -635,10 +635,27 @@ int gmap_try_fixup_minor(struct gmap *gmap, struct guest_fault *fault)
 	return rc;
 }
 
+/**
+ * gmap_2g_allowed() - Check whether a 2G hugepage is allowed.
+ * @gmap: The gmap of the guest.
+ * @f: Describes the fault that is being resolved.
+ * @slot: The memslot the faulting address belongs to.
+ *
+ * The function checks whether the GMAP_FLAG_ALLOW_HPAGE_2G flag is set for
+ * @gmap, whether the offset of the address in the 2G virtual frame is the
+ * same as the offset in the physical 2G frame, and finally whether the whole
+ * 2G page would fit in the given memslot.
+ *
+ * Return: true if a 2G hugepage is allowed to back the faulting address, false
+ *         otherwise.
+ */
 static inline bool gmap_2g_allowed(struct gmap *gmap, struct guest_fault *f,
 				   struct kvm_memory_slot *slot)
 {
-	return false;
+	return test_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &gmap->flags) &&
+	       !((f->gfn ^ f->pfn) & ~_REGION3_FR_MASK) &&
+	       slot->base_gfn <= ALIGN_DOWN(f->gfn, _PAGES_PER_REGION3) &&
+	       slot->base_gfn + slot->npages >= ALIGN(f->gfn + 1, _PAGES_PER_REGION3);
 }
 
 /**
-- 
2.54.0


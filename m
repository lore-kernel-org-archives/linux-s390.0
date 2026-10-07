Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3413C9895;
	Wed,  7 Oct 2026 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373360; cv=none; b=PlvTE6X2kEohFuTmW10TIxghv2JL2lwmVTDHYYxf3jbJuIxoPHM6+/CG7VTXmfpWcSV8C16NPWyknOAAqvcXBh64K/CwXVjjRZjksLkWVmaiuIA1s9cVP7iHntj5bYI2TNdum8zrp7sf2QDnR57YM3z/Pn8Mrha7jxv9f5lVkRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373360; c=relaxed/simple;
	bh=wuB8M8bw0zf4CHSqUs7Z5JIj1yC3NvDjLh97DRwv/uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyEownTColfgHw8rm2vE/CDWIgfYWqUSooQqViXdAiuBsD1L2e/61knkv0/G9tBImT2vW/pY4qZmTMj8tAya5ioVe2bJ5KsHzddsCQdZ+mJN8B4P6YS1Rp+ZDD2eL2IJXTz/3FmKjSNyWOj1ooYeLCaK6lr8uUBeutafPDD1dK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=suUwdW6L; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="suUwdW6L"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZadU2375692;
	Wed, 7 Oct 2026 11:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sOjhYxQVVVhd75AHe
	j0zMAqKFfEAER1Iy8DbJwVffeM=; b=suUwdW6LFWDcWNcAPSUOe6B8WTKuYlGEG
	etlfYn6owbEXAKfcEY/OqoxvjUqyqF4TfBaO70IHy5ZgJzGjW7dDsPbWtFcUCi9t
	VEqtGj1Ku6QijuAfJgATgLtwlq0eyXbDBFSOwIkiwVdKI95x/uqUYiLAMTcFHYNx
	smp4+5AcJBL5gof6t0M9nherWoOdoXtjKp3OZ/vULCPmJ3nO5wwbv+VUmNkT2OTi
	VMWsX7Knt+EHmNyRxNfSyxjf45hWrOWVwwmu6uqQxkcB0fPG64ayZL2QGdHHPc/y
	GBvThCbI/l5AF/bFrNbXMqHWGgJljMNvIcIlcEPVI+b0F4Y7webOA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5n55d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BWlhY1789970;
	Wed, 7 Oct 2026 11:42:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h58d5jmhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697Bfxec31261128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 11:41:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C6C52004D;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 080ED2004F;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  7 Oct 2026 11:41:58 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 85F2D1609AC; Wed, 07 Oct 2026 13:41:58 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH v8 06/15] mm: add hw_pte_val for HW PTE storage
Date: Wed,  7 Oct 2026 13:41:49 +0200
Message-ID: <ae6e2f07e41059e78c0fd2b265cc63a284b53878.1791365932.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791365932.git.agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfXwIU6ZX9ACNxy
 qOnOzoAqtq+rdXwbDItTft+HAmneTVOKn5EYhnPZGrwkch+1xnw0pVmClpK/GR2Q1FqR71b3F7A
 pI00D6e+NjBrSA01c2MmbhYBsQqjkTg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfXyykIdOjNpvWB
 ENAY6sxOWic5Vt0NVJ3+jMbDxNd2oVB8SfBpLylRVAVcPkIzLJ6jAK7zNaKmN3x76xuBAvtJfX2
 StGggHUS8oD1IOr8dwUcfSkPH3LjRM41tQW5wEWG4i7g6tREsNZVqAXvVz69Jc3KvbQknMEP1Lb
 rnReqGCLoCkTNQkRYUEa8hEPcC/c7vg8th6lyxA8iVm1XkB5C7s94IYpE1NYs6thduJEc9KFYF4
 /GaQC8lLzFiqpx+MWD7zVudhC8BsA0wY/VkddcRoBpI4/ECqT7rItnk9zMlblLsrzd88Ldb9aWa
 pVJloG2iyXAuMhXwpU5wBg5KgNK5fnqgz3pCrF1ZBVlxURPcl3hz3EFxrI7VNIRPbhu3cEvS5Xf
 kkWUzenRsNOW3DgEEeqaRU/1P83XZH+u351JF1p1CCVRN+pOdz3Dx5HfYq/4PivQlA3cd+sa5Ye
 ZuggcTcXy66UeJxye6Q==
X-Proofpoint-GUID: eh49vp02Svw_InNNJnx-FXYVniaKikAV
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac6300c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=7CQSdrXTAAAA:8 a=swDlInB_jXZzu2BtmRUA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: l7J_j9yrTJ2C9RBRbuJKwbQ7c2JbFb5e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070046

From: Muhammad Usama Anjum <usama.anjum@arm.com>

Atomic PTE updates need an lvalue for the bits stored in an HW PTE.
pte_val() only accepts a SW PTE value, so it cannot operate directly on
a distinct hw_pte_t.

Add hw_pte_val() to expose the underlying pte_val() lvalue. Access the
wrapper's __pte member when hw_pte_t is distinct, and use pte_val()
directly when it remains an alias of pte_t.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 include/linux/pgtable_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.=
h
index d6c5a7548550..ee4eace5c3e1 100644
--- a/include/linux/pgtable_types.h
+++ b/include/linux/pgtable_types.h
@@ -9,9 +9,13 @@
 #ifdef CONFIG_ARCH_HAS_HW_PTE_T
 typedef struct __hw_pte_t { pte_t __pte; } hw_pte_t;
 #define __pte_from_hw(pte)	((pte).__pte)
+
+#define hw_pte_val(x)  pte_val((x).__pte)
 #else
 #define hw_pte_t pte_t
 #define __pte_from_hw(pte)	(pte)
+
+#define hw_pte_val(x)  pte_val(x)
 #endif
=20
 #endif /* !__ASSEMBLY__ */
--=20
2.53.0


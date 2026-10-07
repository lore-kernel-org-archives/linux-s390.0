Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6574948E0CB;
	Wed,  7 Oct 2026 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373363; cv=none; b=j0/lLRY4lFro22mg6BTixonwk3759ZuoM9ZI97Z/GT2sBxRy/XrTnjoevC05+JbZCWhD5hqVzwUyk8DaPgzmsi0rGK6EAHEWjS4CTVv48/d2ZYd/2/wHKc5Y8dyJLia5A+j8uip+/TVI6Fbc3UmKWdScat9K108x2LFrGMFf/tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373363; c=relaxed/simple;
	bh=cgYs1m2qiutvh4JJI1tIFUuflgEenCch50+LZbEX63E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2/O2lggBplM8wjlyCjoexUo1TwcRWxHWJicgAiMksVzwq/OmaEJ1O/k80NsXmMa/rYdT6MzlNLkvOglzMwPzuCj+G9jLjYCArh/YhHQrr217g7sbT0PADEuXchqaIULrrclkSBfbfWZ5JKmx8wpa6yiSdHZDz/4GW7ptT5d2hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kVAmyLdG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kVAmyLdG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZM6w2462975;
	Wed, 7 Oct 2026 11:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EBKhH4DjM2gVSO1d+
	cytd22TCiZ2Y2ktqC3xv9BFUuI=; b=kVAmyLdG83Pu1cLLnUxHeSZ28Zd0VHBhV
	Hx+gISUroCN5r1JSK3dTi26uj+o3aAvvedTaMEFaDmzMT/SiM/UJNdMmOa1z/Zca
	EijNbssx/JeEW+Em5dU5/UYuSMoD3oA2ts11LLnFMlbec6KTG5t/2QcjDixRVe9T
	mFjaJ28WWCq5uB2na9fdteqQBHUq2l93792wG/YsBoSSbWVpBhwcpUB8amWEiC02
	pQWMyil94wyWF1Z0Y4R7VnpzzP6aosdK+6r2oQw7l1/7+kqvt0JP+YYMtNxvYXC5
	r+TVwC6aQk4+D01L2fSW4nSRGF8YE7P07CakA4tbE6m0diLlzkc4Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74w8c5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BWftC1841550;
	Wed, 7 Oct 2026 11:42:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6dj8w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697BfxAg48759108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 11:41:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4899B20040;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 061ED2004B;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  7 Oct 2026 11:41:58 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 83FA41609A0; Wed, 07 Oct 2026 13:41:58 +0200 (CEST)
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
Subject: [PATCH v8 05/15] mm: convert PTE table entry to pte
Date: Wed,  7 Oct 2026 13:41:48 +0200
Message-ID: <4151437659f71c16a136c5be941bbb44d46e6dec.1791365932.git.agordeev@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: pD1re0KzzLGd5F_2IemxmUT-8jK_GUOV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX2jmGVpxiSLV9
 QrRp+/srHX64L80HKWDUWzNhG/sji91LO3sAaYX04/DY9T/MBEVCamiv4QcbJKK+lnQ8ikT5EWl
 a92+awAq84dlzBfKkBHq3IgcqjZ5n+g=
X-Proofpoint-GUID: 2y9IoJKPKDxvlevesMlylT9_w6B09v2R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX0KyoLrgdfzK+
 raNDizk6OLCmAO95wzipKommWJqKKeJM2YWQXrIQpgSBZ5585hJ6TOzH2pChNJxp3r/S37gYgDX
 LEQ9QeLCbJo6re+160wPjiBQOnfW3+kzpJpGXlXHztAsd1yEw3DxxammHBgOgeuCECdRX0/sjgc
 i9d2NutWlUD5C7ifcbhlIH6TvcLI/M9ZTQFMr2SvaQzNZy6FXgRc8msJCAzyuwCBY9aK39YWmrY
 VDxfuGvkIEfUYhzpJKbDUQOtKdpxAauq9hNOox04ufIBBrJtm/15RVUs+vmJVVQXHvHIJ7S3fpX
 Kn1LZpI1ZqlPJtlerKWrDdiDN62CR7nenW7C/wOSpPm7F72nWERcDcT4/IgMzlYP96d7zgZOiaX
 8Cbjka6xAZ3Zpx/lSjdePtbu6C74bfh5HE7k8omkv8QxlkEY6vNB5l/WJcfAljDAbRLZrL1gmEB
 9/c89ct37II0RBz1uZw==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac6300d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=7CQSdrXTAAAA:8 a=o7zO94P2ADgDUaN7wBQA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070046

From: Muhammad Usama Anjum <usama.anjum@arm.com>

The non-MMU stub receives hw_pte_t but returns a software PTE value. It
has no attached PTE that requires ptep_get(), so convert only the stored
entry through __pte_from_hw().

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 include/linux/hugetlb.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index bc0b9c65aa1d..be31fcf93654 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1283,7 +1283,8 @@ static inline pte_t huge_ptep_clear_flush(struct vm=
_area_struct *vma,
 #ifdef CONFIG_MMU
 	return ptep_get(ptep);
 #else
-	return *ptep;
+	/* No attached PTE that requires ptep_get(). */
+	return __pte_from_hw(*ptep);
 #endif
 }
=20
--=20
2.53.0


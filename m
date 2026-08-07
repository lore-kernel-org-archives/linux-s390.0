Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843C53F9284;
	Fri,  7 Aug 2026 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096676; cv=none; b=rQXJN8y+0xGhSGJnRklfkVsv615fRnaFO0vEcnSI1ZBS1AFMFVPzjsLoQ8TjNLyyO14ckyAP9N/ap5O3Oic5Ccz/IB81u7r4uwseMu1WKTlrnUSxyNPCSZXd9x3jX8usOX7pH9/WtIAfmpNM+3/SNWixiI74O/pulMdDdZEO3pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096676; c=relaxed/simple;
	bh=sKlnErkID9088BJ/SmOBnF/Ww8gfD+64dwUNflFP0yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oiAvamux+jr218WViSy+TSiB+u2FeGRUAqb6m7TPtRiqnUFbAd+mFsgeAscoj2uMRIS+CMMvvizJEZdwGoJVd7l1BCdVD1LxUGMPqFdc55HTGk724MebMusqfvmq+ufZeiw8mu2FE7WLhTDD/UBUqWT/k20DJu9NasOVRgMh4yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=foZk15jP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="foZk15jP"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770Hx0Y4161915;
	Fri, 7 Aug 2026 09:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=U3nwQd
	pUrUnjwM8WXp7qsYit01wjptiYdWrZaNRqCHU=; b=foZk15jPQvYdc/i+fDKYMK
	k0o4yz4Z4pMX5C4k68d29Fa2CH4pP545EWXixzT8HINgaE8MuNJisp06gbgsRivO
	UT+Fjv+uhLnwxqW8hjwFuhyw6YrSw5YYzczXWNefNtTRr4CxEWU6XKmchPXn7Otk
	QbMYrLO2iy4uMZWq1DbpSd5hLnKFVhYjLZ2YwaPQtjyqoIfzrE/tEGpsDM0LMysP
	taI3bhLSu3emycSrfYZecSVXHiMm9xEYioA3jyxdt4qy3HgLROAtOjSIeUxoGm4V
	Gp8DyQEVLP8J8JTYtjnJvm8hCLOWIHyhdOrfkZwTzbJMz2Ko6qSPeFBkmezbt8ew
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyua71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 09:57:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6779uGjo019133;
	Fri, 7 Aug 2026 09:57:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyxy1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 09:57:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6779vmVP45154728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 09:57:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F5792004B;
	Fri,  7 Aug 2026 09:57:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E68F720040;
	Fri,  7 Aug 2026 09:57:47 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.87.136.120])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 09:57:47 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 07 Aug 2026 11:57:46 +0200
Subject: [PATCH 5/6] KVM: s390: vsie: Assert crycb alignment in vsie_page
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-vsie-cleanup-202607-v1-5-b18659b55e3d@linux.ibm.com>
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
In-Reply-To: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=759;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=sKlnErkID9088BJ/SmOBnF/Ww8gfD+64dwUNflFP0yk=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFmlayQcp21ofap744KN/JcPv1kPPFCtjp909mu8gYOo8
 d99c6UZO0pZGMS4GGTFFFmqxa3zqvpal845aHkNZg4rE8gQBi5OAZjIH0eGfyYJTPYzfm8S7hA1
 VtrIpHQqyEtupiSPNMOusnPCFxgnpzL8j1gQdCQio2T1dA9jEYMfswK2rTpbNVNL/8qeXoUz8iE
 FnAA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a75ac21 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=evwnhwT-7yYniyYUQv8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3NCBTYWx0ZWRfX7HjVKVKztOgb
 tyReBfE9T1O4saxI69YrzLA59JPnrZ9uFwYZri1hYl+sntKfe+fbywOHOuMkIOKrcu//P2nUeOT
 ubHpZkwUjrjw28Oh+m8JGnos0gffUA8=
X-Proofpoint-ORIG-GUID: Xih2-XSW_hqPn06ZMdbn48e_D-OIGRjQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3NCBTYWx0ZWRfX/bOwXypH0pEo
 qROCjqPfokfdItGtlMl3KH4nNxSmzTDRX6MVl5ve/XTBeuKBkNHuX1ETvzaU2pvr9cyfvS3nv63
 HZjyZzWcY8QXQCzfofVBV4FvVmlACeHsD2cWCO16vbl5ahwSfX/IRhsAu0dtz61w145EdgfcPET
 7LPSBnDGx7cvlo8qmgQXKla50zKMQK0cYoIO1t3OFtQjWv+VRPdtJXe9CVPzx9Yy4qzwY02ZdBJ
 lBUm+vUwd7cVlo3TSywn7bxT5/hkncmE+MPUUkOVzePmekNgrH0fi4jhjKqP1gcVXc3PYFJpwf7
 E74XoFMXEHgNAmmjDR5aSsBr7o1IGIxvgM7sHMy7nbZQ6Q07WIsv8lWF1JtCmuv0DcDdFqBVdOX
 JUuk97q01XE1w9jOYC7qLcBssOXAjD0L/dCcnL8WhYGgoL0wIPJsriaaoOyIj0xHcpd5MUQXW9H
 4MSphc2YC0M9ZS4AcqA==
X-Proofpoint-GUID: Xih2-XSW_hqPn06ZMdbn48e_D-OIGRjQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070074

The crypto control block address is required to have double word
alignment.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 7c3b5e11b301..c9392460edca 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -69,6 +69,7 @@ struct vsie_page {
 
 static_assert(sizeof(struct vsie_page) == PAGE_SIZE);
 static_assert(offsetof(struct vsie_page, mcck_info) == offsetof(struct sie_page, mcck_info));
+static_assert(IS_ALIGNED(offsetof(struct vsie_page, crycb), 8));
 
 /* trigger a validity icpt for the given scb */
 static int set_validity_icpt(struct kvm_s390_sie_block *scb,

-- 
2.55.0


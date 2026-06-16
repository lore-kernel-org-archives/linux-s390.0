Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FBE36AB61;
	Tue, 16 Jun 2026 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613662; cv=none; b=Ht2bE+0QL/5beOjnz0+KKHaOm31ES3G+CGfn5n8LiBjgvWVIql3G0Nn87fwc9RpehyUTAFhiVlumw0cj7PzcAgISB7rg7Udp4j78A54Jo82TgUGW7Dt56jipwzwM3JpaVcybIoSGa/wNbgjTVDrK5Snt5d9RbrxljsENmDxSgsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613662; c=relaxed/simple;
	bh=FXoVJL5RP7dogn2sY1OnEAeTr2s6dKRiPSK17Xh1LTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzWWPWIih0sHfKOm4lUlW308x3/wTKQCGF9b3/bXoPqcp8zWgGhQJr9ImVHKrFO8ORD0wN2M6SMdWlN0hqIrjHM7tZDyeAEnW3z6gExXVIsntn4EkM4GHmp1VTgleHa8Xqi9l3hgVeCnKXx2KcPBTpfLQkmtOidhSYR995LR4oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YgD6RFf+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YgD6RFf+"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAInoW1228387;
	Tue, 16 Jun 2026 12:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=okkW9YydW4+ZIdBOS
	h/o61ONWlrOLjyANr74xSO/o7Y=; b=YgD6RFf+PPbkF90vxp33ga98EEW2xorg9
	NUDGP+OFK97R1JpyAAaj8r1xdGGri2bDM9qbuKSaoFx0WZGD/5VNRKjQ/va0UENs
	2ig1QdlQEERgy24aV6oXcZIo5UPeBgaCNnJZT3IINGGrqt/ZAKGR6Zp3tIKdIla4
	LTmLhst0P066sSH9dGWtVEd4KuPVm+gSuLLJMU78UlLemeUU3eZXDwgW03Qvaa3W
	RYfgfDJsqCjr78wSxaft8ppN/ultgKqiqYqpy4xdd2eq+RiCVdqoZ4Ny19q+ETek
	fQuYMda0iTo8qHoIH/z2VMoa+bb9Jb2GZrvN10SD2pTzVMvTIJOKA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wm5m8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:40:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GCYdb7012928;
	Tue, 16 Jun 2026 12:40:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhq3g59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:40:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GCeeI550332122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 12:40:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15CF020040;
	Tue, 16 Jun 2026 12:40:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA9A42004F;
	Tue, 16 Jun 2026 12:40:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 16 Jun 2026 12:40:39 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 8BEC9E0E1E; Tue, 16 Jun 2026 14:40:39 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 5/7] mm/page_vma_mapped_walk: Use ptep_get_lockless() for lockless access
Date: Tue, 16 Jun 2026 14:40:37 +0200
Message-ID: <e84752a1a37bc7ac6285aed8d85341fb95b170e6.1781611976.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1781611976.git.agordeev@linux.ibm.com>
References: <cover.1781611976.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfX/Ypv2WHkF2A3
 sA0oiw0tb6vFWOLpuwo5nZwkAQSvBqFptBbmS2uUTmqVIcIJIfFMGOD5j5e7bOK0ERQPvIZp1hp
 qHfP5AInrBkmKklH57qJKcM1vp4wLEc=
X-Proofpoint-GUID: 6223MHGd5ykmuWhXSeUqz0zY0EG3vuEj
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a31444e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=r6uuodyqXXh6h6eviuwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfX4JH852LYS1Ai
 bcBrYc4FnNNpyn1lp8W06jsryyzncZoO9Uu0krDwPiMWWBs13/gwsNZ60fsaErII0RvlKIx5ftF
 MDAuZDUDWi9l1ADDlN8W/Q89eRis4PaOzYti2kgphA1p1Am9nJ0PtWSkgtw8SBQl0Y8ewG9z5Ed
 RBTCpl2LV6l7+ODvFfUTP7d+4p1RfJ94+aAO2C7zQr0YRywtIFkiYtTEXmEbOnDkGOCcQ2A6v0p
 xyD6D/MD1tVM8M/Izmxbu1vja4nbKFgCQyRSo7jkQl4Z8tgGnATUAsL8bsci/2EHr72o+9r/+vw
 EJjP44zCkZYygh/tEugLP99VBnsDdvopKBK+KrUi6KfVJv70Wqc0GXhfSxv4Mva15QxZi8dBYRq
 enloDDHKWOfw0CTz6TY9y9CrdLahV4GPQGsSWmugm0winYikFACMIU7F8OlucPuLu7/s366e9U9
 NuFKl5Je1MFzQjUHb2Q==
X-Proofpoint-ORIG-GUID: 6223MHGd5ykmuWhXSeUqz0zY0EG3vuEj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160125

Switch from ptep_get() to ptep_get_lockless() accessor for
PTE reads when no lock is taken.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 mm/page_vma_mapped.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index a4d52fdb3056..2ccbabfb2cc1 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -41,7 +41,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, =
pmd_t *pmdvalp,
 	if (!pvmw->pte)
 		return false;
=20
-	ptent =3D ptep_get(pvmw->pte);
+	ptent =3D ptep_get_lockless(pvmw->pte);
=20
 	if (pte_none(ptent)) {
 		return false;
@@ -183,6 +183,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk=
 *pvmw)
 	struct mm_struct *mm =3D vma->vm_mm;
 	unsigned long end;
 	spinlock_t *ptl;
+	pte_t pteval;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
@@ -310,7 +311,11 @@ bool page_vma_mapped_walk(struct page_vma_mapped_wal=
k *pvmw)
 				goto restart;
 			}
 			pvmw->pte++;
-		} while (pte_none(ptep_get(pvmw->pte)));
+			if (!pvmw->ptl)
+				pteval =3D ptep_get_lockless(pvmw->pte);
+			else
+				pteval =3D ptep_get(pvmw->pte);
+		} while (pte_none(pteval));
=20
 		if (!pvmw->ptl) {
 			spin_lock(ptl);
--=20
2.53.0


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AAB411FB9;
	Tue, 18 Aug 2026 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080420; cv=none; b=iG0jaabK8JvcXCwkIaapirLtYM7oWuPDOjCmCrCZei1t7VUGrFTtA3axawuZZB8JE/BW1s4zK3eXiReBhPU7XQAm+m8sRhf2ab5482R5gu5RrHpX4kkDZ5Oi2CaZwSslDjcx/NsNDSoLV06lf4Dqd9/WZQz2z+IoLii8LO8kQ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080420; c=relaxed/simple;
	bh=JE55l+vrDFOgadTE6gCLk3ze3wRzlLPtrkwmtkvsiDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KQ8X5GuLWmx7j/NWGoziO4KIIMqzXcy4dP05KtCb7F6Cht21k23tzFgWLJ/fKAIoo8nKp+YO/B/XzYLWpzlEj61BOkfRCcIt5mZ78G/Su5P6yUtxk51QaFMbj4t+lexCm4DALaMMhMYii7Dmhp1jg7DFZ7aXlGWE0aVI5uNytSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iZloTnJM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iZloTnJM"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IHVovj3307518;
	Tue, 18 Aug 2026 19:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Hs6T45utcQMLFWLOsgbS4j8h7t5B
	OTxaYfXqg8tKi2c=; b=iZloTnJMWBXRs6myAIY0IeoJGrQ+OPtHhPmx7N2vGSVP
	v9M8/B3x/KWti02QYBC7TFAJTRoMFyJZopAnu6MiI2khJ3KYSztg9IFaDx+5jouU
	Urf76cY/SzqcZVCcI78SlXYNff6BNTkWmfzruNQw0DoUcVSJtQSe7UTgm9lSZM04
	Qcc9ShoP5y8Z9h44Yel+Iru+Nv6diTI2TNr1MTbdd5iUdk9yAxKHQZI1l3XFjp1F
	B7S/y2ZlDxyuhB48K5AOAGxSxhw1DJR7drQGZdmD/Wg/S29PCh71mIdYPW3lbQWW
	Kn20sFcSB0YS65BGanEtCmcr9K+a2Vcli2Q9NMYaSg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqtc8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 19:13:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IJBJLc006243;
	Tue, 18 Aug 2026 19:13:25 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq565n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 19:13:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IJDNi437880348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 19:13:23 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BDBD58056;
	Tue, 18 Aug 2026 19:13:23 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C95D358052;
	Tue, 18 Aug 2026 19:13:19 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 19:13:19 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Tue, 18 Aug 2026 21:13:17 +0200
Subject: [PATCH] iommu/s390: Fix NULL dereference in iova_to_phys() with
 ZPCI_TABLE_TYPE_RFX
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-iommu_fix_iova_to_phys-v1-1-1cd76d2a55b8@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6DIBREr2L+uhixRcVV79EYgoj1JwUMKNEY7
 17qBbp8k5k3BwTtUQdoswO8jhjQ2QT0loGapH1rgkNiKIuyKhraEHTGrGLETaCLUixOzNMeCGt
 qXtas50wrSOPZ69S5xK8u8YRhcX6/fiL9pX+VkRJKKvkY7z2XfBjl84N23XLsTa6cge48zy+PH
 q62wAAAAA==
X-Change-ID: 20260818-iommu_fix_iova_to_phys-5879275b95ec
To: Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Omar Elghoul <oelghoul@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=JE55l+vrDFOgadTE6gCLk3ze3wRzlLPtrkwmtkvsiDE=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGLJa1p0X3LCyUbVelN/v+iG26Y7bw39/Co2Pua7FHrXsX
 +DCa58yOkpZGMS4GGTFFFkWdTn7rSuYYronqL8DZg4rE8gQBi5OAZjI9nuMDJtcjNf83v3bcitb
 munhk8uMo690Sl3/ddhZ53uTwqxYr2SG/zGSj+X5wnXmaF16teW32Lk8lsyKP5xRj1p2njIV+n3
 AlQUA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MCBTYWx0ZWRfX2UguaYgLLEcR
 71WB6OimwzNgcBMdE5fftTtOaCI05CoIfg6QK/Zkh5K2tFChBRlHG2H+Tkr7C2fbucVyiNSfcdM
 wIWQNWaC1tT0GQuGrHUMnOrJOZolH6g9dI2DJa49MfNsJhSbmdimg+Ft1H/5A5xR3I83p3sl86f
 43sYqFyN9C/ZS0WzKrAO1QmJctNLI+TPqzecQ4P8VDjtf3ppfSB2h6IvLxloZmBB2zpX5qK7yq0
 wNS1j9+C+R6wa9rTu2a2OI6jswR9JOe/uF7I9srb+mpYdFhMI2NiUPD2l5P6O8PzRhdg16b7eRm
 Ug9i9EMyR+8OgcBva/b92P5dT83o31iIMIoRV00B6v5h1p4NNwq4FEa8ZbHiOgttKj67KXkQ7nF
 KhN93QtAyh1v0OCX8XfWaLAyQezRV7GeJYt8DwaXyF/9JenDTlJxxuw9JVRfMScBVEOJxo6F3vX
 ul5I9LiEBVDM7zHjqAg==
X-Proofpoint-ORIG-GUID: gPj12jMYW1KCcA5JS_pEyTgHPZyoq2Al
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MCBTYWx0ZWRfX3pdeQvkiwS6d
 LLJWZqmDdU8SF9KbVh3Hzq2z5/1tac/rueRVrp9h4bC9l70Gyt6/DrTOIlQp4kJjguEHQSPiHrL
 Adf2TnTN9LUxkO5qww/yV9MLKdzhi1g=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a84aed6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Kbg_dSSXaJ27-8BsMdIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gPj12jMYW1KCcA5JS_pEyTgHPZyoq2Al
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1011 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180140

When using a 5-level translation table via ZPCI_TABLE_TYPE_RFX
get_rso_from_iova() returns NULL when the region-first entry is invalid.
Yet in get_rto_from_iova() the region-second origin rso is not checked
to be non-NULL before accessing rso[rsx] leading to a NULL pointer
dereference instead of a NULL return when iova_to_phys() is called on
a unmapped IOVA. Fix this by adding the missing NULL check.

Cc: stable@vger.kernel.org
Fixes: 81244074b518 ("iommu/s390: allow larger region tables")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index f148f559ac56..58ca7727b7f2 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -974,6 +974,8 @@ static unsigned long *get_rto_from_iova(struct s390_domain *domain,
 	case ZPCI_TABLE_TYPE_RFX:
 	case ZPCI_TABLE_TYPE_RSX:
 		rso = get_rso_from_iova(domain, iova);
+		if (!rso)
+			return NULL;
 		rsx = calc_rsx(iova);
 		rse = READ_ONCE(rso[rsx]);
 		if (!reg_entry_isvalid(rse))

---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260818-iommu_fix_iova_to_phys-5879275b95ec

Best regards,
-- 
Niklas Schnelle


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CD243C05B;
	Wed, 12 Aug 2026 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535526; cv=none; b=tNAE1LAVS8R75tHqZIWkeU5hBO/vdAdjCMV0/MeuK44yKTZp/ubw+ppIBuw66TVHfvWd8a/22T+yJgT8MwwlwUJpedjBbZhaj1SEGE+WN6bVLFGpG/mWCaDcxuIJBC8JATJG+BCJ5vhlEi2wQgAoEHC/B20WVHwknCKxu8SKb7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535526; c=relaxed/simple;
	bh=H/1I/HKhjJFIWaIoh60ijSmNIf0cmQ6fBj3FC9hxLME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3SmX7FecPbvHJhDnlPLfVDLnRxJHxSR5cutUGz5QyVajTJuHVDS4YYEs1U+C9jRHHgunMS+3HB7B/9y/+bfavvAs+20ZwfR4ddzxdI8UheGQOTdgHZNe9vPHN8SDz97HDficCjffedEA7W6CQPn4aOs4ixmaYhOlXM2YTQ5uYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HE8OXiTL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HE8OXiTL"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3cIh3258446;
	Wed, 12 Aug 2026 11:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GHk+KGcXvDSfwtCVf
	3e0pPPjaAAzgDkx/iNdCz//Vdc=; b=HE8OXiTL0vJv/Li9JG1ApPA11fV3eaDy1
	Gr2zqgToRGDK6uk3VK/NbiiwnfI5QTNd0YCJ9NdGnrQV4hyLGg2cWm7igKUn+mXP
	cEg00+jzA0Y67BoF8Lso5yFVWgl7Trc+w7gx4ZcIWj8GNoIP6jT9tbzQL3R4umEs
	0qyKfJAFcRpMEU2xso3fwE47eLYrzma6lI88ScOn1dJbJJigh8RijjUOOJfqguxi
	CJWxkcP6sSkLGmO5GSOuYCNyHopdlpzA0rtDbQM/Yl9ktQqO+NzEltfl2OKUFA2d
	QmGp5+nqr+E4RsiO9yuNEffLp9hnH3e/p1fWlhpseMMFO1PypAK6g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9j63n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:51:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CBfI4J006382;
	Wed, 12 Aug 2026 11:51:57 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy5kxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:51:57 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CBpuOH15532790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:51:56 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15A0D5805D;
	Wed, 12 Aug 2026 11:51:56 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA51158059;
	Wed, 12 Aug 2026 11:51:53 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 11:51:53 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v3 5/9] s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
Date: Wed, 12 Aug 2026 07:51:35 -0400
Message-ID: <20260812115139.576303-6-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812115139.576303-1-akrowiak@linux.ibm.com>
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 51V_c4um9yr2hs-r4wFdpm7PSFA6MCH0
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c5e5e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=fkyveIzhjB74ZASU3MYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX4kbPAU5Uq0E7
 D6RmeYsdCBsEhGBkmt+arz9vo0IYIxjHPOH6tr4H/7UbOKRu+FnJQOqZ1JhVlpW7XwhgwRduspp
 AtzyiX61m376iq+sk6EsDvvNu6YolPuqF1cVWQEUJ+OPDIaMcvqAD1dPeDdM6T3+jFXYB84Wxjh
 D69XSXbV7Rdi1zDQwNW25R60R+SIQf617R+0mHGEe9H5UgkHPmYIquZkxxLbnD4sBjOHilHKkLh
 cf0rCSkMAG5MVGRBONVlW3bo2nMZ3hjWNT5ttIKSaikrSeKbjxE3jkFegJQC/nZe8S11iDNyqPF
 BikvO5Ziy9NP/KzwVKQ8aXzYoxK+VXM7GmraxxV4hu6MLHsQ/R0qplhUf3Jhvik5SjFUFQz95QY
 yoD9fuHMt/VNmoOGue6VbB/mrhA0aHv437aWGAeofKvqp1b5K1UT69paa/kCDLMHne1BQXzroU2
 sxCeRReXF00uzW86fDg==
X-Proofpoint-ORIG-GUID: 51V_c4um9yr2hs-r4wFdpm7PSFA6MCH0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX4YkPZyGoVn3E
 Af7ypMK/q0xlUKHvaSJXMb/ERWnWva99qU4rbwt36K+QXJJaU9HriD+wqRLeUplMg4QJBIjGGrm
 8uYUN6uyuFXAgTAxvKbygzDMbfcNXfU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120093

The vfio_ap_config_remove function uses the bitmap_andnot function to clear
bits from the matrix_mdev->matrix.adm bitmap (specifies the control domains
assigned to the mdev). This prevents the explicitly unplugged control
domains from being removed the KVM guest. The bitmap_and function is used
instead.

Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 8a1ecb891504..b6d0c988cc81 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2625,9 +2625,9 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
 		do_remove |= bitmap_and(aqrem, aq_remove,
 					  matrix_mdev->matrix.aqm,
 					  AP_DOMAINS);
-		do_remove |= bitmap_andnot(cdrem, cd_remove,
-					     matrix_mdev->matrix.adm,
-					     AP_DOMAINS);
+		do_remove |= bitmap_and(cdrem, cd_remove,
+					matrix_mdev->matrix.adm,
+					AP_DOMAINS);
 
 		if (do_remove)
 			vfio_ap_mdev_hot_unplug_cfg(matrix_mdev, aprem, aqrem,
-- 
2.53.0


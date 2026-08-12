Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404EB3914F5;
	Wed, 12 Aug 2026 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564988; cv=none; b=csGZ01FTZyNbJWnOgRR2/lfnVD8MeD/0W17ciTc8hHDkwGHOoW2YgHDsyElSkFmWtHquBt/aFfuf0uT0N26ULDYj0/Dpc5D8IGpd7lv80U6N1TQYkZufRx1UQeEcluOR8YR3/kQAeDT23fgdoS5CgXpvJkHZGG9d92CYL6rednU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564988; c=relaxed/simple;
	bh=EDCwJV+IvNOFK32sSxnYNd78nS1ko9lbivW41h8Ix9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqlix6wss9Cn2DU+SWmljpsid/DtvcEFtmWw4Y4pTxaHETy12z4ATOybLvyOm2GS0nViDe7MHpS8BR+BC0jpovXjB8suU6IdrSHyekNS5x1pTLOZShYrXdJwU8L/GU87XkgM8WqAQ/wJtYP2U8zI+anPd5jPTWEEXFiEnAXgCi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bhRQkzOF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bhRQkzOF"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2qS3197143;
	Wed, 12 Aug 2026 20:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Fp8CEaAw34Vga6mTt
	owRd3t8SDWSYYHYv/RZc9nbQlg=; b=bhRQkzOFsUCG7Zzd+CmlKxomHfXMYZd29
	KecaTdh2MFFYhs+mwaP5YdGrWkcUX0YX20O0kJ2VomuEn09A1opj87JBv5n0PrkA
	27klrq3OQlY+2USYe7MGIy6CxgcyqzKYnKMX3PCuNyiRe65T1govRBzqR6cI1r9/
	0TNlUDvfE+IQi13dZCMmw9A/pT35AMR7Tp8pmwpKaWeCZpk+zgnDx8RaLuu5MLDq
	i4A1FR0T1bRRMTSHf2OCc9EpvcTLEYO3b4xDEDjz8xO1EDB3f/HvrG6QXeBKTf2y
	iE9c9uGhuZbs6IvrwOQTAb7KDL8cFBEpMIFmMAmjn8s9aupGquELA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp33kh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:02:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CJuIHH005088;
	Wed, 12 Aug 2026 20:02:53 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy7ks5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:02:53 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CK2pgZ32244242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 20:02:52 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2C8358052;
	Wed, 12 Aug 2026 20:02:51 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4140658045;
	Wed, 12 Aug 2026 20:02:50 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 20:02:50 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v5 5/9] s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
Date: Wed, 12 Aug 2026 16:02:36 -0400
Message-ID: <20260812200240.818004-6-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812200240.818004-1-akrowiak@linux.ibm.com>
References: <20260812200240.818004-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7cd16e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=fkyveIzhjB74ZASU3MYA:9
X-Proofpoint-GUID: 7BthvVKpILelZtxclD1JgsetkAvI0vdw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE2MSBTYWx0ZWRfX91pkNA7AMTNL
 xo/JWxP4/19PNE9Lyr170yHTTtcm2JdwJnM/6r90sg6/RUmqkH6rQmasVMa5rhcdtj40lBOCuf7
 w0i3UuoSgtOFp0gs8HiC6j/R2fzks8Wk3G2qCyk3X/+bJGxSiJbulsuA9cX7/I3NebHAQAlV8LV
 SqF1HVZlPHM2OR/pZUbS98w6QhZHebY/nKvuB1EIDrJELqx2ptHq/SWDvF2YkxVtL4k51CihHxL
 3EjrtKYmfBQRZr2+shHwP4gyFXN6A0RLhL8lQw6mtlxGB4bWkQwmxGLdCK4PU3iUotWyAtooAkm
 Cjtd9nxwF4QeNd9COfv0FjpOWjIBwhOExRPCwVpOqSHwikWPvZteRa/EMzRx+cNezylficoyI7B
 Zq+8K3hC63y4jr6Gmw4NKma+2jL35dAgKhXkF1m8aEaJbBslNP+uOwicTh9byXifND7P8xYxSdB
 A9eW4XAOgvVcsf2q/mA==
X-Proofpoint-ORIG-GUID: 7BthvVKpILelZtxclD1JgsetkAvI0vdw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE2MSBTYWx0ZWRfX2js0s2xPB/jB
 d6RX8G4DOnipXQodAh4G6mjzwojLEgV8cMmPyF8hdt6MCqJLIN5fKlQoYUlCRLDiagUYjD5Ap82
 qJh0L5bSEeIMfkiXI7btzcMq9v/QJtM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120161

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
index 21c502598f8c..0f3537aadea8 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2636,9 +2636,9 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
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


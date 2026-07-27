Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E7043991C;
	Mon, 27 Jul 2026 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173591; cv=none; b=Djro8uoqHY8CIp2pwocDGHnZtr4JuhDNYkK8KgtyncPYCv+2W8tsetacuYV4jOD2RM1oJbVDjh8btE7SsrVskgv5tXcOyInLc+VT/y5rbH1ZgCRytcT1arrSCcOflS0AQqnUYq2iESVpJYqbo8SWYBGXP/zcmNs9TMVDCBld9e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173591; c=relaxed/simple;
	bh=3LxOtL7IojABlHrJTdu4fAqHEF4ZJH7PvVbT1GEMQo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZhPlzYkx4cj/Hx11hKa0V+wvwmruTvR4dQGcEthWTaDpCQ7TTkr9D2s60nq5xFJoLupNr00K7SWzhYwzoE+4bTcAGcVPg61MKUg606uLASKM/fjtWTzTcjaFmFLtmf4HEOTCUvEuV3IcRcRXbB9f7U/17EjaXj5qmdpqPDNKPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YUU4YgvH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YUU4YgvH"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDnoAe2412938;
	Mon, 27 Jul 2026 17:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tgmrxH4zNd6xyehi5
	11+KSGX6yXXUtlw2b+BiWJr/8w=; b=YUU4YgvHZXEgjA9VA2u4gciXKIHD7rwJu
	pjFw44Bu2zM56WnXNT07ZXBs+n4Y+oXVbl1ZfBkbbTew/+JJOKMY1fHWvBgDJWYM
	l4yVbtI4zFbG5qn12WmXj1uKzN4rFEilJR+agDlqBu2djbyY0Ex61VsUa/XinmJX
	nD57s6W4zfta8+RBbqf4xONcVRw8tmjZi6e/mFuVMV2TwoRw4hAkXcC2tBGgq5CC
	nXLDJrnimkhd/YerzLHX/DA9AzT5lfKAcD0eFp8AaHEeCV9Crn/f4IXwnYvcj0Le
	eceneIBDnpMJ9vSDLO1zimHwS+dR+3GE3mP1n4CxEohyAaE7Njoyg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcrv2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:33:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RHQHXm022977;
	Mon, 27 Jul 2026 17:33:03 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xx2yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:33:03 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RHX2b88979068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 17:33:03 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97A1C58058;
	Mon, 27 Jul 2026 17:33:02 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBE1458059;
	Mon, 27 Jul 2026 17:33:00 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.213])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 17:33:00 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v6 11/15] s390/vfio-ap: Transition device migration state to STOP
Date: Mon, 27 Jul 2026 13:32:35 -0400
Message-ID: <20260727173239.2420754-12-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F10VtEWINmqrhAbg45klvHsIMXCZCY2i
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX07Fkj+IQgeQB
 orVDyNpDuyIfAKctnQ+F8jqqros4XPake+KvZoEyTUT8qXZINKXAUysJbvVOU6ncx3Q4KaSjxWK
 B/0Y4ubmGsB31Oy7XbHv0Ia5yQDEUZs=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a679650 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=LlGlNFsFWGapDO07ubkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX61/HutsLTR/1
 52TdSmmgND2y6EmHQpFCaYxVI+Or31NzPLgm9hhAekHesfrFk1XGjo5678QPi1thinPvFkMIDn+
 vKQyiSeJSRRy7vVST9kDkt2wpAg85V3juGpVkRjIFCldhJXDBb66ZZEblJ1/x1VckwENQ0Q2Nea
 +d1bYSaRB1C1+dPB1fvZKFOrSnRWdaKFJaqneV70UslL85uUSAy209jrE2tnEmWZ0TxIzsTZmCO
 vPJ7HUoIxr2RRCmjsl+bennx+JeT59P55bsqaXXGLtHcwStgHzNwTVJNwz9Y2sfoekSZXY8ESr0
 58J8DXPqMf2noYRJbQon6PzL2JvSAN76xWg/BLYoUcrFKUHVSGAU3ywpWwT0+cRzWA7xBf/xaTb
 6zSgN8eN7U0IKTYtg1OkojMkvK+U2JCjdwQK52X+NvpaKHkDdm+kdyhdgKB/PrKPwThimstLjkn
 /5zE5K1Tw3QK19tZr1w==
X-Proofpoint-GUID: F10VtEWINmqrhAbg45klvHsIMXCZCY2i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270160

Typically at this point, interrupt processing for the device, DMA and other
changes to the device's external state must be prohibited. For VFIO AP,
there is no physical DMA device virtualized by the vfio-ap device . It
merely manages the guest's AP configuration that identifies the devices
passed through to the guest, but does not have access to any of them. Those
AP devices are passed through and controlled exclusively by the SIE program
used to start the guest. There  only thing to do at this point is return
NULL to the caller since the file streams and associated data will get
cleaned up as a result of the VFIO migration framework releasing the files.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index c12ba82ec527..fc4cb893f0f0 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1267,12 +1267,17 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 		return filp;
 	}
 
+	/*
+	 * Terminates the data transfer session of the vfio-ap device state
+	 * between the source and target hosts. Since the vfio-ap device does
+	 * not virtualize a DMA device, there is no internal device state to
+	 * incorporate into the vfio-ap device on the target.
+	 */
 	if ((cur_state == VFIO_DEVICE_STATE_RESUMING &&
 	     new_state == VFIO_DEVICE_STATE_STOP) ||
 	    (cur_state == VFIO_DEVICE_STATE_STOP_COPY &&
 	     new_state == VFIO_DEVICE_STATE_STOP)) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+		return NULL;
 	}
 
 	if ((cur_state == VFIO_DEVICE_STATE_STOP &&
-- 
2.53.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FD03793B3;
	Wed, 12 Aug 2026 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564977; cv=none; b=KuxZk0QORVtOy5lRFKgICvbCoOsV4NsGotDrP5mRwbXHTYMLZ9f5QrtYMds9qJyQk1+oigqkonUuklOHLX/frad59H/IE2e2tyC/GjWdS8j9TerFNCZ5RYWlzHiHGXXazAl+IIzyVoyjBy1/YEQX3AK4HPDOCbZAXKZwTp1kgec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564977; c=relaxed/simple;
	bh=hAk5VFZTgMbDNPLe+AA+zMf0YOhx4PJoLsGEtIiKUxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2zObodfdrz/R+wVRbbnAnGg5vOkbPqVoqaucv1MeesaiWcxq6/qE5KRp+giec3V7u1eqQr2sh8OtdRdScg6ryhY3bkhz5mPxm8E1wggZcEIlJyyKKCpVroeX4KhdU0ghrG283keW+RzUKaDxyQtCzMm7WliJ2LIfyADyVGcJi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HW/fE1EZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HW/fE1EZ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2mdE196976;
	Wed, 12 Aug 2026 20:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+1ReYvhFvHs/C9ZAt
	kBPmRv/N1oXc4R/xDf8I9N/tjo=; b=HW/fE1EZbnS0QK3JVGwUfzxaVwnYpqtpW
	9oCdFQtCTjpRA8no0N0ty1ffg9/XATqoqEMN1pxT3CEe9gIwp7kubQttNbF80Hgs
	w+VlseTjD9GFttRoSWUUubcqEVFlmNJOev/1Prkwsi/9JAwNlnPTt8DAvYTaSbxS
	o0MYsC5TiCStQi0wnJP9Z6X+Y/N+i2YQyrnKobgnzjLZ5QBITFp5sxVOCf6x3405
	DAbAgUX40qq7xLutcknVPAWdgv+cGcSH+Kxf8B8YIXgXJhrqp8r0DLXta9yzq2eN
	lZUQMbLYPV3aZ8VTUpsw2yF5rMMte2JKntwFhdWTWeXmQxTanHVLw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp33kga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:02:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CJuJF3029536;
	Wed, 12 Aug 2026 20:02:46 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h7r3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:02:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CK2ioF23986724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 20:02:45 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFA9C58045;
	Wed, 12 Aug 2026 20:02:44 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AE8958052;
	Wed, 12 Aug 2026 20:02:43 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 20:02:42 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v5 1/9] s390/vfio-ap: Fix stale do_remove flag across iterations in vfio_ap_mdev_cfg_remove
Date: Wed, 12 Aug 2026 16:02:32 -0400
Message-ID: <20260812200240.818004-2-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7cd168 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=dlTjfeu_wqJGreSUTgMA:9
X-Proofpoint-GUID: mLcM70LTmGXiMsyNF6rt1AQUTj3QJ_HF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE2MSBTYWx0ZWRfXyUpsr5whaLPB
 W7MLN8JOr9lPcVL06NC5hAkvRTaJSj6moBTm9OWN9jQc18trnMgw9kZnGN80vrfew1pcMvdkjBK
 kNARC2fRQtRgwVv+HDK3ME/v/SknEQ8s6R2Sr1CItmymT85ZX5L1QeXjOxylsv0z0yNtDHhNgkx
 T9zmQh7xmSWmHSLLm8FY4eIM8IGyC3ugpG27+L2ggd5TAvKB6JARG2GWvr/dJlHs0pY3VkyK2Sf
 0MXqy7MWYDb00lGFAdjbyP34rLu6D8vsqZ221zxxUv7xvf+553xjkPpl054lCbSQNDtdON/tqCG
 gDSUBid5eBC438SUGEVggpvcsERiaHmKwzi+EhkPY9yY9/2XV9qcuaki+R8cu9DsxykV7h8KxPl
 F9/7Mi39V6ikp37LVax305UVRUUcgldzAgLnmK4TporMvDCweBBw3u1LI+X+scoClnWaPjudXof
 BiRw9NVjsZmmU08Yp1g==
X-Proofpoint-ORIG-GUID: mLcM70LTmGXiMsyNF6rt1AQUTj3QJ_HF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE2MSBTYWx0ZWRfX/2GDlNa7lT1M
 3vkWPA/kdLzarsD5kLZzmJgyid1ESGZPReB+3hvyLB9tgH+NIU6M7E4Qs0Ddkj6nij+WSfeVxon
 OnuX9JhFpYz9vDXZrZroIwTA2ziQ4A0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120161

The do_remove flag in vfio_ap_mdev_cfg_remove() is initialised to zero
before the loop that iterates over the list of matrix mdevs, but is
never reset at the start of each iteration. Since do_remove is
OR-accumulated across iterations, a positive result from one mdev
carries over to subsequent mdevs.

The fix is to set the do_remove flag with the first call to bitmap_and;
for example: do_remove = bitmap_an rather than do_remove |= bitmap_and.

Fixes: eeb386aeb5b7 ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 44b3a1dcc1b3..845c86ba8bc3 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2603,15 +2603,15 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
 	DECLARE_BITMAP(aprem, AP_DEVICES);
 	DECLARE_BITMAP(aqrem, AP_DOMAINS);
 	DECLARE_BITMAP(cdrem, AP_DOMAINS);
-	int do_remove = 0;
+	int do_remove;
 
 	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
 		mutex_lock(&matrix_mdev->kvm->lock);
 		mutex_lock(&matrix_dev->mdevs_lock);
 
-		do_remove |= bitmap_and(aprem, ap_remove,
-					  matrix_mdev->matrix.apm,
-					  AP_DEVICES);
+		do_remove = bitmap_and(aprem, ap_remove,
+				       matrix_mdev->matrix.apm,
+				       AP_DEVICES);
 		do_remove |= bitmap_and(aqrem, aq_remove,
 					  matrix_mdev->matrix.aqm,
 					  AP_DOMAINS);
-- 
2.53.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4529434A3D9
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733432; cv=none; b=EBldoDGwPGrhznptqC34ZJU5FQgHv7d25gOXvMrb6cmm8IxEvyqsQhPn/lr92oz47enCVZsHicU2ACbHbi3OYP9oOpPQE5fwPSS0ok7fMoLe0ulTBm9g0AkCkh8GKoCnuuHjreYO2N4m1rFg4FREyxgSsSljKJtrXoh588dqjcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733432; c=relaxed/simple;
	bh=kbk5q+3/NK4PUUWhWBJXB2+/Rq6A2WqNqMzMEl3nVnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ioZtsKoiesPTisC/OiPKpRv+FjEewmLVDuNuDVYyec/d/BfszRBnBTyQ/WJ5EDclGcL77rZB4hBO2mLGOSXRUA3oG8waf8SP5K6vE54HjcszXATPHdKPqgi6asumaEzsK7OHod8eT7zCcZELn0dT7ZaThXJx658t+SB4ai9/H0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UFMdAi2z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UFMdAi2z"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDfoZO4182140
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ba59mp
	0jr47MCV1mfvs5UI0uMq1OCcsqfvu0baPP87w=; b=UFMdAi2z0tiHkCEpqK0lrQ
	CRYvYu9JRc9MQW157hW434II5pp5CO/5p06cCQAgK6SuEGllgYi/eQEx1pOanHJL
	R5o3hfoFchUXEHJ/nEeXCoEcCXjy3s0AHskPZzcDjKdlhBOaIdcoYZ7I6qZh0hGl
	pAKSVkKeicMqNCPIfU+2+umVmgRoSwo+oafesjZNEuatqnoO4vBT5VsaPuuivJho
	IEZ4ZnHmbxWe5ulY/eZDH0wF9PuKau9hwmTgPg+L/uRn5JQdAy1Gt1DLSJjGJiQB
	NCBhNs6oNaIX3Oabyl4eIBHnqbj8Y6hTUkVs6txB+3fgJWdlsPBjsF7S9ts7slDg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gacmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:17:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MF4hOk009650
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:17:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnah7u4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:17:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MFH4Lc45941032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 15:17:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D4A4200FC;
	Wed, 22 Jul 2026 15:17:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D542200FA;
	Wed, 22 Jul 2026 15:17:04 +0000 (GMT)
Received: from li-c11aa8cc-2ecc-11b2-a85c-95df2f347b4c.ibm.com (unknown [9.111.60.227])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 15:16:54 +0000 (GMT)
From: Volkan Unal <vunal@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: oberpar@linux.ibm.com, sth@linux.ibm.com, hoeppner@linux.ibm.com,
        meted@linux.ibm.com
Subject: [PATCH 2/3] s390/dasd: Restrict discard support to virtual DASD devices
Date: Wed, 22 Jul 2026 16:16:50 +0100
Message-ID: <20260722151651.292621-3-vunal@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722151651.292621-1-vunal@linux.ibm.com>
References: <20260722151651.292621-1-vunal@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE0OSBTYWx0ZWRfX4hfXoQkb1m/J
 OVAL4vgxgpaMwHnzBf9pwg4BGvVbicov9yBHEsv+h+6cOzErxMEEWjUpTTQF+/J+Zd5Nw/mK1t6
 RKIECoqttsxJ9pDi5IOniixFRL8zN+FUHPXTqm6g5Oxm9278/fcyR2KNgfqSQnA7IM0eO8w/rXE
 8INDIcJBKfdRgLytJ9o82UAmdAc18Dv84CxzDu22F3PA0sMamygwgi3XYvgQGCdHnGhSO7M0dbp
 pQK/BaCeRhSiGwHCgEOG3YfTxtB/H8DPEvSwlvr4Y8sq8H4oT5wwqaN1znxHRFcn+LxdrM8jDZF
 ctg/EUBRBkg6tIEpxIU4SBEfQT97AqqUoBIb6i+cjx+RzGas68Xk1hKhyEIfN2zzRqN3HWtSDdo
 o7Koj+vz2I1kK6feNZiirqT1vB3XGnAxy7g2PuOqEGjj2+c3qhDbHzOdO4+JBPx73NqhSXvi5oD
 q2vRx2q8qT/Rq0BtIGA==
X-Proofpoint-GUID: DPo9dTQ2oZqOe6JmTS03mi7G4D89q7vN
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a60def5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=akDfLVMwLNQjmflmbuMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE0OSBTYWx0ZWRfX4tQ/Cf/zvbeh
 XGt18RGWigspOwYTG9IZpUsHj1iv7m+hj0vJp7P39haAWEA9ZuiUwmOipIXWrl3fioxLGzPR9jS
 eMwd7qJr85fyQlEw/+mSqpW56QfC5x4=
X-Proofpoint-ORIG-GUID: DPo9dTQ2oZqOe6JmTS03mi7G4D89q7vN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220149

Enable discard operations only for virtual FBA DASD devices with
control unit type 0x6310. This includes:
 - Virtual disks (vdisk): Discard triggers page release in z/VM,
   allowing the hypervisor to reclaim memory pages
 - EDEV devices (SCSI/NVMe): Discard is accepted and results in
   zero-byte writes to the specified data range

Physical FBA DASD devices (CU type 0x3880) do not support discard.

Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Reviewed-by: Mete Durlu <meted@linux.ibm.com>
Signed-off-by: Volkan Unal <vunal@linux.ibm.com>
---
 drivers/s390/block/dasd_fba.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 45a488db897f..2869f93ac0ed 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -115,6 +115,11 @@ locate_record(struct ccw1 * ccw, struct LO_fba_data *data, int rw,
 	data->blk_ct = block_ct;
 }
 
+static bool cdev_is_virtual_or_edev(struct ccw_device *cdev)
+{
+	return cdev->id.cu_type == DASD_FBA_CU_TYPE_VIRTUAL;
+}
+
 static int
 dasd_fba_check_characteristics(struct dasd_device *device)
 {
@@ -167,8 +172,9 @@ dasd_fba_check_characteristics(struct dasd_device *device)
 	if (readonly)
 		set_bit(DASD_FLAG_DEVICE_RO, &device->flags);
 
-	/* FBA supports discard, set the according feature bit */
-	dasd_set_feature(cdev, DASD_FEATURE_DISCARD, 1);
+	/* Virtual and EDEV FBA supports discard, set the according feature bit */
+	if (cdev_is_virtual_or_edev(cdev))
+		dasd_set_feature(cdev, DASD_FEATURE_DISCARD, 1);
 
 	dev_info(&device->cdev->dev,
 		 "New FBA DASD %04X/%02X (CU %04X/%02X) with %d MB "
-- 
2.55.0


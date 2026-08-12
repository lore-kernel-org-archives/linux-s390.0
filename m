Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3273447F780;
	Wed, 12 Aug 2026 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554601; cv=none; b=tQxg1KWxO4cgeg8esZwrQPB8+g2vJLNeDuKlRGfFCRjnJqQ2SssMLKiz0Y3LjMDcZXNm35WzZQu3sGigeA+AS9FOXRl49FuQdtMqfFBxIUkUFIsplo7NHuUDhGUaevP8+p5LMW4QzP2OqOLhYTC+6mMrfahqsoR5UBYGyOJdxWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554601; c=relaxed/simple;
	bh=5yyNdGdxAelRtvmaSTyzi6Ux60obfEZJ1rH6Pw+dKr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTJQaOo2ZQHRhqK4dTdiRfDrj5vA/zUVFkwLB/t7B2pvx7ReJFqtgm5L0IajnknKMSQRk/5JDhvFQwVHihqw8muqFPE+zt5MNVySi8Hx4Um/J9rdMtyG/DsIKrZWdMQZlLoho5NAY9GjdGT7bCUCToo94aRPMpgpPlcOoXN97a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fKPxkwVx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fKPxkwVx"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1W0t4088083;
	Wed, 12 Aug 2026 17:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=m+vJqnk7rifev6aJu
	KE56s9GIpbulLzAG2kXbqJoKd8=; b=fKPxkwVxJIaraIoLmMI0q6mcV1saJMR3c
	9PUij+H7V11vp/Uk2hrShupUcmDViC4CCt9Pf8hb02O7nFGL0zvsw2OvqMWy3s+n
	X8s6X4k5bZ/PGHHNpaUM9RO9EiQC6aj/XdfXTDxkAv3BDyBxRGvMQ/hs/ssh0ubQ
	98VG5mr8Pa1jSGNxH28GCLff4Vg05R/39+s5xZI9A2+cng3/MyZw7WwY95tRKo5u
	B/9dE00FOV2u1moKrlkI0RD09bauWhkw5sna8cbDhMBNidcEwffPdAV6KC+6q6XC
	E6naG9rJ4l8ZpCjg/ptpW7JPDKYCOTPROjokhi+osD7NZr5DzPs2A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9uqtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:09:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CGutmV031270;
	Wed, 12 Aug 2026 17:09:53 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h71fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:09:53 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CH9qFj32637626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 17:09:52 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0895F58043;
	Wed, 12 Aug 2026 17:09:52 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F115C5805F;
	Wed, 12 Aug 2026 17:09:50 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 17:09:50 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v4 4/9] s390/vfio-ap: Fix required lock not held during update of ap_matrix_mdev object
Date: Wed, 12 Aug 2026 13:09:40 -0400
Message-ID: <20260812170945.738351-5-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812170945.738351-1-akrowiak@linux.ibm.com>
References: <20260812170945.738351-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX5IrtyeIkQBLT
 7egHxeIog1Eumdw8e7+2ii/u+p9SR64vozowGPYvUC3j+xsjKVXwYvP/E1j4xGV6h8dNDbC3vtw
 gYEpS0PUSrIoA17maGPhWMUhUJAcRfMEbd4uFzvF5DxUyQBn+lbvDYIaosGiH361huTkpOsWodR
 AArfKjdSabbu3zg5GJpUKOM2O41Z6+Xe/ufw0bLFzgJJc0arDXQSsR9/xIzF6HwWm+4Z4L1ckbg
 BPTNAZzahN/HqhIEuG8RQsf1OlIMAragNdZ2vGowYTVObmkpNaAVM9SM4PHaureadYfS2XAafG1
 UFgXnv73D/lrPUK0sYxcQJIcCfzziUWl2NGrGos82tmpKwEykTLLTdLQkgxjwwqkLuyu7KmM8vu
 z1j5gWzCmNR6yGXpkeIrK3ea2AIj8kcZ6M420p28K98HM0dfr8J1HdC1bic9WOGCtCANT26+HIH
 qNhiLNXIs1DfUYmY1YQ==
X-Proofpoint-ORIG-GUID: ai5aBwHHn1saZEX8vrhA4-sHGL04sbNe
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfXw0QQjtZB3ftG
 8W+KjRJE1DAa/+YYGAZ80zhgzeCQDy6JSb4NtPKuzZ2xpSaqMcffQuFjEj4TpSgDLwOTFwwnCb+
 W2947HmYM2g3iYFTKhM/P2E+zq93vAk=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7ca8e2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=mm-sKQyJWPVlA1vr6AIA:9
X-Proofpoint-GUID: ai5aBwHHn1saZEX8vrhA4-sHGL04sbNe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120138

In the vfio_ap_mdev_cfg_add function, the apm_add, aqm_add and adm_add
fields of an ap_matrix_mdev object fields are modified while not holding
the matrix_dev->mdevs_lock. This lock must be held while making these
to guard against a race condition with another caller that may be
concurrently modifying these fields or any of the fields in the
matrix_mdev->matrix.

Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index f2d662e388bd..21c502598f8c 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2777,12 +2777,20 @@ static void vfio_ap_mdev_cfg_add(unsigned long *apm_add, unsigned long *aqm_add,
 	 * called.
 	 */
 	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		/*
+		 * The mdevs_lock must be held in order to access fields
+		 * within matrix_mdev
+		 */
+		mutex_lock(&matrix_dev->mdevs_lock);
+
 		bitmap_and(matrix_mdev->apm_add,
 			   matrix_mdev->matrix.apm, apm_add, AP_DEVICES);
 		bitmap_and(matrix_mdev->aqm_add,
 			   matrix_mdev->matrix.aqm, aqm_add, AP_DOMAINS);
 		bitmap_and(matrix_mdev->adm_add,
 			   matrix_mdev->matrix.adm, adm_add, AP_DEVICES);
+
+		mutex_unlock(&matrix_dev->mdevs_lock);
 	}
 }
 
-- 
2.53.0


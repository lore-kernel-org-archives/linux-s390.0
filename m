Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319CC286D4D;
	Tue,  7 Apr 2026 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595072; cv=none; b=UsZjbUqFv7yvGzyAMDi4r/EHLBPwCT6gZ2JGz0eEfKNeeftKeEdPJxAy0K0AUhoMV6vBqYZEBhOIt1gJvrc0PlIof5C9dNLnNO5nAG9LAAVvBSlmDG9B6CU1hDMexyckR3EXTqBRoXIdrxbECPsqrFsRK7CvbfB7Jv4UVocW7ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595072; c=relaxed/simple;
	bh=Jbg5tReGP4DqzSflGqDEnwPJOObH5/PLrLZ/LD3W9cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUHZZ83Ec4E7ACdP6oeV74Rxf69LZUrW4OkWByEfk+h+RS0kXr1HU/urFeoHwvusq7h4jmGxh6aINnXJvqeOyTPrC51QeGuU5yW64+yy8wRbxF7KomIoAkw1m3zB9Ml4P0X74jzL0oOrRt1GwbpXxIIRfTdW3y42XSV9yecmp3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oL42aHiE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oL42aHiE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637DmCGk2326574;
	Tue, 7 Apr 2026 20:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=c4OAktMSaRxE9CV3M
	XiOV7sMtw4Du7qGD+4GsaEwCSM=; b=oL42aHiELl873mkMS+25WopBefCUWV1tS
	kuTOtgvQ4Gj+KrQhtIcJwrHyPDDOZZ7amGILMzqvaHQYDxUh8/aGHZmWBTE7UhYV
	iIZ6jTC/Rcamq4IBqfYQLWsF4AjR7QCJM+iHXOznhrgIi4LlDEzLtCvtvPHASIvI
	UnzeGH1YPy3UkZ1yaULpz2cNTiORn/fZVRncGJ+xWyqc5OdfhA9gbsVHE3wWug6x
	llALn1/elDP9wUph0o/LY5KUQeDk9vGBMhEO2QDKnqMDzkgZkaIgrBGItEhwD0+3
	9x0oB15SsQRj8kNRPwQZGNeQrPPokXwBJD6oeTTGO/vQ56pdN5VOg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kcnsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637IcLhg007917;
	Tue, 7 Apr 2026 20:51:06 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2cty4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:06 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637Kp4cH60883204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 20:51:04 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F2A958058;
	Tue,  7 Apr 2026 20:51:04 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F87A58059;
	Tue,  7 Apr 2026 20:51:03 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.101.194])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 20:51:03 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v2 01/16] s390/vfio-ap: Store queue hardware info when probed
Date: Tue,  7 Apr 2026 16:50:17 -0400
Message-ID: <20260407205100.331150-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407205100.331150-1-akrowiak@linux.ibm.com>
References: <20260407205100.331150-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4OSBTYWx0ZWRfX7E35VRlAz+cT
 TdgdwXwu2/jL9dKnYqs3tbFI8IfAKEEGnEEOpfs6bKHrwtxRgF3qSmly3GUayg8wsQFbH8TdUSc
 8MY8zc+OAIbcJXuG3d6muiOuGB/Lcu5JeHt4JEPw+M8Zm/3EiC+qRwJ+9WpYE9MKr9C8Af6RHuF
 1KEf49fsyWKTuKk6uqd4ESP56Z7/v0P6YAfvvarXtMyc0rmLe7eUWP+FqtmoP3FvAYB3laPIyB3
 IGTIL3am51pgRlI9c/Lby16vp2u/NjZNU5EDrSqK0wzWVmcr9VOIAgdZAG2qD79Rqv2l02RaNmz
 YsqYCcFMd/oIoMgkUXW3TjuS0g0OV6/8THWFHcxoD3oS7/Jq1P1hooCWcrajVMhzC45J72ncJyZ
 I3SuAjIuvlhuUSCwTGeoiaB8kIjwmVuKiA8L/lzdZj8qvJKgDBd9ttdn6jWF2OfsK9uxuZcRqZc
 MCum8EfJhLLGlSyN4hA==
X-Proofpoint-ORIG-GUID: pEGsCF-a83kucbgSsJ3I-_NJ0wqmCkL5
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d56e3a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=TnwwbuCvOpPni-GgRwAA:9
X-Proofpoint-GUID: pEGsCF-a83kucbgSsJ3I-_NJ0wqmCkL5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070189

Store the output of the PQAP(TAPQ) command with the struct vfio_ap_queue
object when a queue device is probed. This data can be retrieved from the
object passed to the probe callback.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 5 ++++-
 drivers/s390/crypto/vfio_ap_private.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 44b3a1dcc1b3..ef3101f6865e 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2419,6 +2419,7 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 	struct vfio_ap_queue *q;
 	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	struct ap_matrix_mdev *matrix_mdev;
+	struct ap_queue *ap_queue;
 
 	ret = sysfs_create_group(&apdev->device.kobj, &vfio_queue_attr_group);
 	if (ret)
@@ -2430,8 +2431,10 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 		goto err_remove_group;
 	}
 
-	q->apqn = to_ap_queue(&apdev->device)->qid;
+	ap_queue = to_ap_queue(&apdev->device);
+	q->apqn = ap_queue->qid;
 	q->saved_isc = VFIO_AP_ISC_INVALID;
+	memcpy(&q->hwinfo, &ap_queue->card->hwinfo, sizeof(q->hwinfo));
 	memset(&q->reset_status, 0, sizeof(q->reset_status));
 	INIT_WORK(&q->reset_work, apq_reset_check);
 	matrix_mdev = get_update_locks_by_apqn(q->apqn);
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 9bff666b0b35..39c85bab05c3 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -150,6 +150,7 @@ struct vfio_ap_queue {
 	struct list_head reset_qnode;
 	struct ap_queue_status reset_status;
 	struct work_struct reset_work;
+	struct ap_tapq_hwinfo hwinfo;
 };
 
 int vfio_ap_mdev_register(void);
-- 
2.52.0


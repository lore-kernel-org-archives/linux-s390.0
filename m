Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632578;
	b=NtuhCn3vyhgVxJAdtIjE1feIjoKnLSaLkTua6CVitZ08weRmbKwsnMljEu6AKCGsUbU+
	 j9JzpOxWR7ztTT4dskH8xuQtTq8QnTD1TPaaz+F6AQUS/kYameTLcfe3fKmp9vd50xgfd
	 SGMgF3GKG+O0tljUImdbyZkfQYXQEBSyBTlNKNHf5oNdNAT3TX53GFWdZU2PoxDmBMOE6
	 nj31jTJa1KEYXPtcThkA+bODImtJAKzVwwxjsL+HUArmXkCyzfHuDjpg/LaY1Hy1v1i3Q
	 fEEF/00duhB2M2Ed6HFDHf4U2aGhGed1IPhnPUQOClqOepCKFH2eofeg0xsiE/K4bng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632578;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ujAGP14PuBEDkW3XKpdrVY/LeMaUrdjLAMmlyBgT0tc=;
	b=Y5u4YQD8aHyFMnEDMY+t4mmijwv7odGl6lqjF1E1SwbT0cPq2xwfMaHcX9HLBdOQ5V3Z
	 FO6/TtcABL47W+KDQkUhNtIs9wdTdNyCvpx9S811hm42iOdtz/Kk6qTrBmd1rIIQnBzcP
	 FV5JCnH76XgRKxN9xEqzNLzE9lw1Y6/aAFZ2XR+EsBs9PTJ6S5K5G77rfsY54RZNiuW+Q
	 B2WEnitVo8N8xiCuwcHoMPE9J91QQLW2S0Rn8j7wdxhCXchzCUTmrnZSynVSynZAhUAc2
	 oDvaUjkXtGThK32CelkjzMQJba9gRTpREGqEeWh4/p6vaXoQ2EZRIfwqLpp0WLSJWZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RMxxOuws;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127AC607BD1F;
	Mon,  2 Nov 2026 15:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 127AC607BD1F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RMxxOuws
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2EEJpQ1489569;
	Mon, 2 Nov 2026 15:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ujAGP14PuBEDkW3XK
	pdrVY/LeMaUrdjLAMmlyBgT0tc=; b=RMxxOuws3EsZlGGAFE+OD6wW9MxHuCHeQ
	3Bs+mBi39lh9FEYH2l+sYi1uJFIy1MDz9P0e/emrDQYfFfMqR5wGreYQbZ3QJRoZ
	VSlDHIZZlkacNiCixEgLtujI2dnbCYA79+VV/3e7ZAPop9v5LERpGyQSqiij3tub
	28vNhz/Udgo8wDx7pYxu2LgmYr1Sj/NdvJ5PAEmZcaoT7R5w/uB8Y+9TBTMFpw79
	8fC4kKjqaZCpMmvNl0pVjRVcrwI30Owa6BvY7GT9KBodl6MilO+3/yISNtqexqUt
	FtJaRV/Pq+kdSS3sPUT3ePocRSLQchK4m3BrPtNyiXLQi8jZubSDw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn80sh8ga-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2E617X1034521;
	Mon, 2 Nov 2026 15:16:13 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnu1vej73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2FGCQt32703002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 15:16:12 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0179758054;
	Mon,  2 Nov 2026 15:16:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD0E85805A;
	Mon,  2 Nov 2026 15:16:10 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.57.150])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 15:16:10 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, freude@linux.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com
Subject: [PATCH v11 04/14] s390/vfio-ap: Reset migration state in VFIO_DEVICE_RESET ioctl handler
Date: Mon,  2 Nov 2026 10:14:44 -0500
Message-ID: <20261102151604.2150055-5-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YEr5Xg3fXr3O9p7UtC0yuLuzOA0tL6Bc
X-Proofpoint-ORIG-GUID: YEr5Xg3fXr3O9p7UtC0yuLuzOA0tL6Bc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfX/KzHZ7H1h1VO
 M/7K8Qrwrz4br39QqhJmqc3MpDdag4H6xbGck3sogdvZ4H3RiRcV1bGM5lHK0B6hYkt4tJFCdUf
 M5aO93/vnOQG9G1/4Al02aoD3bNArOUyvmP4rTcT+EF5v896m3/fyomtl3gOgtBlsHZDK/pMOJc
 YCDiigg/VkRmnc041s5BfJOF1amFI7CEVJ4HmuvIVMrctEcIDutAPb4GePc4lpjfk+4HWrGj6kT
 NhfRzNkhRSyNyzEBrQjGtFgpVZpJkdcTwJ0JdGsl2PcTpOPK4AiTe64pv1gwmex2ILZZ1ZsED1j
 mv44Pk3JEeTMMWeChl/6EqjNtJwo1l+GLIchxMpjsvd/05rP2sII6SQLxKYIjgXSrFlgSBdVfB4
 w4hcc/lgdtvDP71eIZZORzqcWs5fTwEkP6x3ELdNU34m5zyITjs/++yCoUqJ/LtV0DWrA+XVnGI
 P3HBidIwC2tSWFDmMDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfX2wX4Bm7SmYAw
 FkX02ACo3NIPH5zh1BfDVnWUcBikJOFMOHm4do4MRnSu0z97xr81/bxbEamoM20ZCddr/GmYzDe
 EQWKAXyRkadlczd0yg3prmdAAi6oqNg=
X-Authority-Analysis: v=2.4 cv=FIqOVOos c=1 sm=1 tr=0 ts=6ae8a93e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=OlMDtWmkmZCoppm_HCYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020060

According to the VFIO migration specifications, userspace must issue a
VFIO_DEVICE_RESET ioctl if a vfio device enters an error state or fails a
state transition to recover the device and return its migration state to
RUNNING. This patch adds a function that is called when a VFIO_DEVICE_RESET
is issued that releases any open migration file buffers and resets the
migration state to RUNNING.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 20 ++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       | 11 +++++++++++
 drivers/s390/crypto/vfio_ap_private.h   |  1 +
 3 files changed, 32 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index d525dec782a1..6bcb910526c9 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -226,3 +226,23 @@ void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
 	kfree(matrix_mdev->mig_data);
 	matrix_mdev->mig_data = NULL;
 }
+
+/**
+ * vfio_ap_reset_migration_state - Reset the vfio-ap migration state
+ *
+ * @matrix_mdev: pointer to the object maintaining the vfio-ap device state
+ *
+ * Called during VFIO_DEVICE_RESET to clean up any active migration
+ * state and reset the device to RUNNING state as required by the VFIO
+ * migration specification.
+ */
+void vfio_ap_reset_migration_state(struct ap_matrix_mdev *matrix_mdev)
+{
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	if (!matrix_mdev->mig_data)
+		return;
+
+	vfio_ap_release_mig_files(matrix_mdev);
+	matrix_mdev->mig_data->mig_state = VFIO_DEVICE_STATE_RUNNING;
+}
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 8464d2e86d3a..79f016a43f56 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2328,6 +2328,17 @@ static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
 		break;
 	case VFIO_DEVICE_RESET:
 		ret = vfio_ap_mdev_reset_queues(matrix_mdev);
+		/*
+		 * Reset the migration state unconditionally, regardless of
+		 * whether the hardware queue reset succeeded. The migration
+		 * state tracks the AP configuration transfer lifecycle and is
+		 * independent of the hardware queue reset outcome. The VFIO
+		 * migration spec designates VFIO_DEVICE_RESET as the mechanism
+		 * to return device_state to RUNNING (e.g. to recover from
+		 * ERROR), so the migration state must be cleaned up even when
+		 * one or more queues fail to reset.
+		 */
+		vfio_ap_reset_migration_state(matrix_mdev);
 		break;
 	case VFIO_DEVICE_GET_IRQ_INFO:
 		ret = vfio_ap_get_irq_info(arg);
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index aa8a22585204..c6e577064e7e 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -174,5 +174,6 @@ void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
 
 int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev);
 void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev);
+void vfio_ap_reset_migration_state(struct ap_matrix_mdev *matrix_mdev);
 
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.53.0


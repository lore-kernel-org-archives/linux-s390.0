Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F549463B96;
	Fri,  7 Aug 2026 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141130; cv=none; b=PmCbcb+MSDs3S5Gq8FMtZ7NTde9KXndBfTbCbdWbuA37C0Bh3AShRwJYcwM7cAqEOeSCfMIV9gQUjHdgI5exv7GnAdzkw6uMDJNjboAQ+xDmHtXqmMws7jX147e0AiXeNbkXC+jCKpwPG2033Ht4f5q52w0zfG2/EHcLG1bfdpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141130; c=relaxed/simple;
	bh=wr1vTqx+6wWE8qrbW4O3+9CkpifiMN2xFbhtsciiTe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nqs17HbYTV84kqcLPICW9DVhaCrWDaRigminSTf2iskPIEfgqFBBBFjIaUtypcw9lAchbOsoqlx4KjeK1FuDzndvjNvzDg5nX+OuQFkAiM0H62C6HXJNdA7JwDfcBtMzKiyv2HVoAFVvpDt2UXDrG7ndhey4N52glnM/aUH3DNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QzgAgdQO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QzgAgdQO"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Llnjo2720608;
	Fri, 7 Aug 2026 22:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=03QifjCT/ltKJtcBu
	xM8sQcIS1p0+vCFIrfZo4cbzZ8=; b=QzgAgdQO+91L3VrBi0FyrEqjW5VkJJHgS
	4TV0SLZRvlWU6dzJA5XnQN/wCn0hvEwbcAeUmFI2HRnfPihjBJJmfGGVn9tIOUEp
	2JGl3Ad33Q9Q7Rc7UHC/LUp4LkqCj5t9P6CdpfSwAAE6Wmmadk+cSyA4eIJx8B+L
	KnwlpBwMvq3juG/U+veSnL3Bv4QqLjHVUwlIdxTC2qGipTu6Bd0w5MYUJNTHo59h
	PVQ9i4O39mSIfdNfdtBOAEOO6IU3bi0ofNq69sK8jgCwJKABFYTrFFx74jwGjM+q
	YkCMcwwXlul1FJp3FL56+rrQU74x8Nnbb6eiiiCEjs0fcDkR0NOjA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy00e0yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677MBIkk016439;
	Fri, 7 Aug 2026 22:18:42 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4r1t44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:42 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677MIeWS5440408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 22:18:40 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55B9A58058;
	Fri,  7 Aug 2026 22:18:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5606258057;
	Fri,  7 Aug 2026 22:18:39 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.52.19])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 22:18:39 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v7 04/15] s390/vfio-ap: Reset migration state in VFIO_DEVICE_RESET ioctl handler
Date: Fri,  7 Aug 2026 18:18:23 -0400
Message-ID: <20260807221834.562851-5-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807221834.562851-1-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX8PnvpABX9HOs
 6KzcS/mN6/xb34felnvlmP5pleKY70CTJbE9P4rQeEdwVeLylDy1UORcJEI/HJTlSR/egP/M9yn
 hjDnndY3KIUkNb0OELGsBOUAykI0GeM=
X-Authority-Analysis: v=2.4 cv=VPTtWdPX c=1 sm=1 tr=0 ts=6a7659c3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=6UAmCRYpaa-dfjEBkfkA:9
X-Proofpoint-ORIG-GUID: zTms3csDSh9otddDf4H54B3wkgFicJpV
X-Proofpoint-GUID: zTms3csDSh9otddDf4H54B3wkgFicJpV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX90OSlJnvY2V1
 DFvP8oVFWeyXrkQpfycOj0ZZwueJaQV6ai2KSP0BUDQkttRW2HvWquedjNZJ20afa8Z25ywEnRQ
 RZQcIxi+dFwqK7k9aXjOqE2C8ROso632+gyaZjEyTrtpMgHVsEX2r13ZfiGptSSajIbDqhMVm5O
 12eKQQko7OMPuK84eNmGacufzc/r1QJCW5sma62dCwhyEvxExiJdJjBmEqpVns2IGK0CNSEujN8
 G7cwCTIenV3GweHo+PbDNVmcvpDB2yVKrhYMihuoNJreaXr4hjPF3fomUB1n9YZ5a0bNhSaUDtV
 Q+7Dzjo6gV+MxCjblOzNQPj8WiBLLL8p7UfCtJnYioBv/TpSwBYLSPqtPYDVXwjSgFH8FokBb+g
 fWctzZr8Ppr9O6iziDf17D7KwsAO5qW2yPm5a7VuHvMDWD52TtHfPPu/zXiOMMfP95my2MaZpRF
 CVpe/wMWmd4YBKFnmNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070175

According to the VFIO migration specifications, userspace must issue a
VFIO_DEVICE_RESET ioctl if a vfio device enters an error state or fails a
state transition to recover the device and return its migration state to
RUNNING. This patch adds a function that is called when a VFIO_DEVICE_RESET
is issued that releases the migration files and frees the storage allocated
for maintaining the migration state.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 20 ++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       |  4 ++++
 drivers/s390/crypto/vfio_ap_private.h   |  1 +
 3 files changed, 25 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index cf303d228a0a..1613813124b6 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -238,3 +238,23 @@ void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
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
index 90b0fce0123b..d05372b50d2f 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2330,6 +2330,10 @@ static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
 		break;
 	case VFIO_DEVICE_RESET:
 		ret = vfio_ap_mdev_reset_queues(matrix_mdev);
+		if (ret == 0) {
+			/* Reset migration state per VFIO migration spec */
+			vfio_ap_reset_migration_state(matrix_mdev);
+		}
 		break;
 	case VFIO_DEVICE_GET_IRQ_INFO:
 		ret = vfio_ap_get_irq_info(arg);
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index a2a713f93674..1fbdfcce5a11 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -175,5 +175,6 @@ void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
 void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev *matrix_mdev);
 int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev);
 void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev);
+void vfio_ap_reset_migration_state(struct ap_matrix_mdev *matrix_mdev);
 
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.53.0


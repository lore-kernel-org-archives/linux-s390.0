Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D224A3CB555;
	Fri, 24 Jul 2026 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909704; cv=none; b=sJTcqYN6TopvdyzkrqFBoB+kPtv/9QisBjcbavVY0xCxi23rqQIulw1RapYdq52juDd6+wHjfQnFQ7L2GIBya6NcCHbD7Q2FsvjXylG0PMnySUySQABTcpjef0JiiMkPRySH1UXGUqiS8IvanPc9b8/Ryp+zLdTp81zEc5+vhw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909704; c=relaxed/simple;
	bh=PYvMsVDT5j5Fd7fs4GG0JdBqUvchh83Nm+RFk7knaBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRkNHeOZgIQN1RweaUrEVqvuY3As0rqG/OXx4oT177eMLYGOV1ZipTNGeqmrJn2SGD/2NIT7zDNXsDb/z6DabCuB4zXoV8GdsgDmlDm5M1ex9VLOKe2H8OwDnbiUkHude6ORUxBjTTPkcDTOJpeRIssdYvSwsHn9zPLa1iLJUZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TUnnATw4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TUnnATw4"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfuOa100791;
	Fri, 24 Jul 2026 16:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MvXu2hCasoSpvnk7j
	M+cM4Hjnh0euR1nL0euL3S06S0=; b=TUnnATw4Een3/6E07HzZk21FxLNaRtvmS
	FA69NpZExr3yaVPeB1km068gb5IHTqJsYQjp652s7QMKeGbHz+wHGdwZLsG6qqHT
	UGDvcEAmWHfxH9kp9W5Mk3mmYM4earXmQGRsHH78iLvRNrN5+3Dhjcj4vW00TN2C
	8NwFy0xX4KDTn+H72nsOFqRTljkCYK8kCtwzS+diw3pnOkhr9omFVJPY1i58gOrr
	U/tf02+j7nLKkTAv58impISEKG6XxGkxruNf0ImywgY+IuHLo1NBdRVuKpGfZUwg
	CgdYpRWcTk2PVGVRGyKETPg6bZM+QvxCVWjRisvlYQf+CqFrnJ6ww==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8gs8u4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:14:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OG4piR026084;
	Fri, 24 Jul 2026 16:14:02 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6whr1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:14:02 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OGDPgK8520320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 16:13:25 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 066F65804E;
	Fri, 24 Jul 2026 16:14:01 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74A985803F;
	Fri, 24 Jul 2026 16:13:59 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.50.28])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 16:13:59 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v5 04/15] s390/vfio-ap: Reset migration state in VFIO_DEVICE_RESET ioctl handler
Date: Fri, 24 Jul 2026 12:13:40 -0400
Message-ID: <20260724161351.1802644-5-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfXyIEhGJ5D2ekq
 lBaPtxr+MPoYRRnfOO85Pv+1wESwxxFL8lXyOK8t9HsgvdRobHHCjEtrsQmj6yUWPTxzH2fZmdY
 Bduj4dgHUFE8kXNPec3uQeqe44MtWvc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfX3/JEIe8+GBcq
 fsq8bU+2B8/3DmmYnJOWSXlj/6TOI/ZOUamj2j23prkxpOto55zgUKRQ9Xh/jh4me29pyRdhfaX
 CZF+7TSxsGf5I6hCbYCHWyR5cT4+yWJPJWH+i0eYk/vywecoDSRK8Lw5Yw42nXlhZjclSbv0Gc3
 gGX/w+8/R73pOB2nF0sKHKkZst+zgBpEZcyvXdGiIATXQDHuIsAwHj9o2+URPQq5mVhB7CAtb1n
 WMX11cwaIqV4qEfwpe4ZOY86YNjc47DgMN6/A+2KfkheXu2JJJvSkzd3dR5LEzY7NITsutJl4J3
 efbeIhzrfuZ1K6eucNvSbODCj1fVVlPbnv/Lj0rHJRRlvPfKgUdcy38IR8qdS9+ALsBMKWBRLfx
 qk15q7VnZOSQZ8Cp/YWVHVoyXQARAIxYSENB4tswXgyDI+SUI5TXtZPxy50+Li3TiQGGjx7QVWj
 feZ8o6ygaeJ1MtEdvEQ==
X-Authority-Analysis: v=2.4 cv=Q9LiJY2a c=1 sm=1 tr=0 ts=6a638f4b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=yK-hndWHgRgZV9HjYSkA:9
X-Proofpoint-ORIG-GUID: b2eZW33DvAJqcJVyCWlnNCQWcA0TB9_J
X-Proofpoint-GUID: b2eZW33DvAJqcJVyCWlnNCQWcA0TB9_J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240145

According to the VFIO migration specifications, userspace must issue a
VFIO_DEVICE_RESET ioctl if a vfio device enters an error state or fails a
state transition to recover the device and return its migration state to
RUNNING. This patch adds a function that is called when a VFIO_DEVICE_RESET
is issued that releases the migration files and frees the storage allocated
for maintaining the migration state.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 54 +++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       |  4 ++
 drivers/s390/crypto/vfio_ap_private.h   |  1 +
 3 files changed, 59 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 9187cfe26da7..45557f433652 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -150,3 +150,57 @@ void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
 	kfree(matrix_mdev->mig_data);
 	matrix_mdev->mig_data = NULL;
 }
+
+static void vfio_ap_release_mig_files(struct ap_matrix_mdev *matrix_mdev)
+{
+	struct vfio_ap_migration_data *mig_data;
+
+	/*
+	 * The fput call does not call .release synchronously while the
+	 * mdevs_lock mutex is held, so there is no problem with incurring a
+	 * deadlock situation if fput is executed in this function.
+	 */
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	mig_data = matrix_mdev->mig_data;
+	if (!mig_data)
+		return;
+
+	if (mig_data->stop_copy_mig_file.filp) {
+		fput(mig_data->stop_copy_mig_file.filp);
+		mig_data->stop_copy_mig_file.filp = NULL;
+	}
+
+	kfree(mig_data->stop_copy_mig_file.ap_config);
+	mig_data->stop_copy_mig_file.ap_config = NULL;
+	mig_data->stop_copy_mig_file.config_sz = 0;
+
+	if (mig_data->resuming_mig_file.filp) {
+		fput(mig_data->resuming_mig_file.filp);
+		mig_data->resuming_mig_file.filp = NULL;
+	}
+
+	kfree(mig_data->resuming_mig_file.ap_config);
+	mig_data->resuming_mig_file.ap_config = NULL;
+	mig_data->resuming_mig_file.config_sz = 0;
+}
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
index 47aca908701d..678bdd4c82e9 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2332,6 +2332,10 @@ static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
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


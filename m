Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AED030675F;
	Tue, 30 Jun 2026 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816108; cv=none; b=ZsPJiCVTog8wpmUAGEufy4PA+LETDK0Nb2TvoEqM8wNSrZ6uqwqsMzb6A6JOxfKf247JTQ9VKlimNPazoiWFxjlax0rs8jo8uPnnlu+t+rpwjijvb59a1wfugeNkUu5TwlXx8SpQM/d2irOzxp5EYyA+o+CZ9EFVWfpSKMzrZ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816108; c=relaxed/simple;
	bh=EiRvIo35q2iFo5ZSA/IM8GZA9HtOqpYK8FczzZuPDQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGGdWVs85dOGs5pJN2x3sUJtxMtYteTbdBs+lfBNr7mjPE79HpL3UHTut+QAlld3boP56xzwDgdtqDKEWGgtvKK7t+kQkzdFEu93fC2Gf5TqrUsh6A4Spyy293nnjX7apblK735ndTKVUFnFzpZzKpCYB2dNpmTGe76zs2judZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BvdBYVMm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BvdBYVMm"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nPmH1700332;
	Tue, 30 Jun 2026 10:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yjNkJCtjWvGzcbsfD
	WoNXCPCaiuYKvW9yMqKCfEqfPk=; b=BvdBYVMmBH77IhOZOLDKqR9NOVHDNQ3o/
	8cMIw+CWKxmaDzl4ZHjbtub+rjSLLAH5J8/S5RAiemV+RdkLxPL0yREQwoiZS4pm
	c6MH0fcrGbha7rAvwJLkqkNmehk5EDNgBddWUZn3asO/eehoR34Bz7zTdQKnBoW6
	YVoisp+acs3U7Y02aLKyeiVmmDcpiGYFH7BhZxNT+ZMaCTccVfOT9RyBdm0GFzmt
	Rb5F+OSIIE6K9PuXcK59ub47MMSpVrTw2zDom8/kvPdgT1E28WkQWojX+CFn1QOJ
	vpo9DbxeKwS0sY8mPSZxtYU0zL6m6flK9qnNUWMJ/YLRX06QmgnQQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pdx71w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UAYfsU007621;
	Tue, 30 Jun 2026 10:41:40 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbh9n2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:40 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UAfcOk18088664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 10:41:39 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC92958056;
	Tue, 30 Jun 2026 10:41:38 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA60158052;
	Tue, 30 Jun 2026 10:41:37 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.135.84])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 10:41:37 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v3 04/15] s390/vfio-ap: Reset migration state in VFIO_DEVICE_RESET ioctl handler
Date: Tue, 30 Jun 2026 06:41:14 -0400
Message-ID: <20260630104132.1598851-5-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nvV5_gaMIU6NXMjVLJHUk4VKfrzjs0Rn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX9j+70lW7JNuZ
 iXc8+G/Q5i7pcBFp2nq7usZ8d2UvFYHc0imgZhhwfEJKb/XwwKJCb1LGSENsQ0pTo+6lfo7tdI0
 1KxQkAJQTRr6QeW5UU+a47h+YNu4yI0=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a439d65 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=6UAmCRYpaa-dfjEBkfkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX1sxucdUF0CZK
 09qTHl9OGgZHw5M7lThy5I2zpsheBt5K+CW4Ozsyuve54aSSOhEaAGVXv+kZv7UBIdsEYr5HbsT
 JnAW28oJd5RHLNUbkRwSvwz/bMuf6O4Ym08DF3kMAZRXRG6ohenfusxMJ/wjaWOqhDt2MRHpR+c
 ZOD+39avrA5buXQTrnoftbkyQ3yj/YS0c8dUPzeMVcRuAjCS/SKaZm7vYGcSjazuspY88+FC3lO
 8BZnerT5EEQ5ShP3jv/s4Kpex+QSjnCojOrY5qqghCyYgRg+0Yv0J877PB9zeFhieBC6rOslPR/
 +azH3MD0k590SV8EjsU7KrD4WYJg522PV3c4zDPoJrSQRU5NEjaq8hjUnhz225n8/ZsWh09fVrI
 9dKmQsu1J94lr9FrTYinESNjEMBveWvfHbSH0KETD9iJ0YIeF63prbrQCVUtOCW7bXvEH/6oFxN
 OXEp3sl53o3B5qUSwGQ==
X-Proofpoint-ORIG-GUID: nvV5_gaMIU6NXMjVLJHUk4VKfrzjs0Rn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300093

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
index 5b6d48ccf332..c7c71980bdbb 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -129,3 +129,23 @@ void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
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
+ * stte and reset the device to RUNNING state as required by the VFIO
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
index 813290214866..8a9e83921f74 100644
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


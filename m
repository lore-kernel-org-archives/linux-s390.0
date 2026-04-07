Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568563603C9;
	Tue,  7 Apr 2026 20:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595079; cv=none; b=WYdjzkSDa4Cb2f0CER0m5finuJhql2d5RO+lVIqq1YA/ldvhYqy26dolLDXCFcv8B5WLcJzigwIoicDljUnrGCn3tOBqcZ1r5smXIATIEHJVBwcZ9CzrCiTCnxZonUl5A5jd6MFS6NUd9jvTcMIr684f/BcUy48OLUzRP0jD2KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595079; c=relaxed/simple;
	bh=pkAb4kha/XCv/AdabPaz526mZHSH2OlD83FP6AOkp3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYu95FVENMWLwYwURvewgl6GRMX6vNZRD9cCJQhxid8oyJV0GDiLjCiO7eJ8aWqqGPxrcsZdnniVq6EKvt9cVF1I06MttNV1EJvZh1OC0Zejj2xO1oxhGJNPdC5kFaLRxGxpJx0sbOkULZ8TTcVqJbyGZgFlfSX4He/pP7bJEQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rda1noyI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rda1noyI"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EnJ3Q2393155;
	Tue, 7 Apr 2026 20:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gUz/5ngVWb+S5iE0K
	lljovLer+Jc18mvsylOIHZDB1Q=; b=rda1noyIira8AvllkurkD9YVAZ40iYFwa
	x81wK1FbSOwSwfQ9SKpLWppfUgWnKvKpmZZR/RiNKkQIkbHaJvQiV0HO2GuTRfMu
	SXctEQu2IA0wmaNJxNRbeqzNSc1GTvQWW/L18G5PiqWGiPRoxk5Gd4QdS094mNn+
	M6ff3CsKp4gznzuoeT1FXhUYRXhUA+JUcGrWzf/M6ZGWszbGR8mtPTgaQ4luVBes
	56M4tefOGnWJgrd8SiuVbnSdclIMsTbrVM/DaYfO4wuevv5yKIEKF/3TmOx3uIdN
	/A17uYzKSo/PkgU4rtJCK5saBrPmD4u4jVlGMNxgj5Efcshqqdv5A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kcnt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637IkcT2018987;
	Tue, 7 Apr 2026 20:51:13 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9cup4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:13 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637KpBIC27918920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 20:51:12 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5A4D58059;
	Tue,  7 Apr 2026 20:51:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E11F58058;
	Tue,  7 Apr 2026 20:51:10 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.101.194])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 20:51:10 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v2 05/16] s390-vfio-ap: Callback to set vfio device mig state during guest migration
Date: Tue,  7 Apr 2026 16:50:21 -0400
Message-ID: <20260407205100.331150-6-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4OSBTYWx0ZWRfX+hq45AKrNQe6
 pbEg+GFRrgc/LtJwvKRTQCD0cfTC/G3YP1y0Ofx80K/SPMPnzbLKp4nNMZwQjnOaCSpXR06FmQy
 GrPZfMMtR1AYRJEZOzuAsogaQBkkXLG8wIVgYBTdBhF6LCUV8YbffE/AfGUu9up0ZrADKAxxXq2
 Jscv5dJmPkpD2yPA/ETx5ACBGdWwj2tg4MfvvyiZh57cGHOZRhHteOvhQNyBOJ7LhklvO9oNoNb
 1B31BjjsF+OzsnA1IbBcLhPkC0xbz/TF3Wau5JMeoHem6ziZUWAYIG8o2sg5Vov2+7peEyF7e02
 umKb4vDgnbSnGSHZ5kP02EcgGO2FNRPYDF/BqL2T2+3L5CNiIq3knjpEQqiObauH9sVByLHTg/y
 SeLGqiw3zGFiPhDkEgOzqiatTvBMBw+s1x06bHvFLg79IqPt7T6Xll3RYqNYdiGRPDxtO2R6yfQ
 0nZOX0zOCehKEEteOWQ==
X-Proofpoint-ORIG-GUID: bIYCi-uCEuT2ocLMZrZFPhOWZjLxIRm0
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d56e42 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=A_qOOsZ8MQ48mD1vPGUA:9
X-Proofpoint-GUID: bIYCi-uCEuT2ocLMZrZFPhOWZjLxIRm0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070189

Implements the callback that sets a new migration state of a vfio device
during live migration of guests with pass-through access to AP devices.
This callback is mandatory for VFIO_DEVICE_FEATURE_MIGRATION
support.

The function pointer for this callback is specified via the
'migration_set_state' field of the 'vfio_migration_ops' structure
which is stored with the VFIO device when the 'vfio_device'
structure representing the mediated device is initialized.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 96 ++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index a1ae4f1a3473..a4daa05822fb 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -7,6 +7,7 @@
 #include <linux/file.h>
 #include "uapi/linux/vfio_ap.h"
 
+#include "ap_bus.h"
 #include "vfio_ap_private.h"
 
 /**
@@ -96,10 +97,103 @@ static void vfio_ap_release_mig_files(struct ap_matrix_mdev *matrix_mdev)
 	}
 }
 
+static struct file *
+vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
+			    enum vfio_device_mig_state new_state)
+{
+	struct vfio_ap_migration_data *mig_data;
+	enum vfio_device_mig_state cur_state;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+	mig_data = matrix_mdev->mig_data;
+	cur_state = mig_data->mig_state;
+	dev_dbg(matrix_mdev->vdev.dev, "%s: %d -> %d\n", __func__, cur_state,
+		new_state);
+
+	if (cur_state == VFIO_DEVICE_STATE_STOP &&
+	    new_state == VFIO_DEVICE_STATE_STOP_COPY) {
+		/* TODO */
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if (cur_state == VFIO_DEVICE_STATE_STOP &&
+	    new_state == VFIO_DEVICE_STATE_RESUMING) {
+		/* TODO */
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if (cur_state == VFIO_DEVICE_STATE_RESUMING &&
+	    new_state == VFIO_DEVICE_STATE_STOP) {
+		/* TODO */
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if (cur_state == VFIO_DEVICE_STATE_STOP_COPY &&
+	    new_state == VFIO_DEVICE_STATE_STOP) {
+		/* TODO */
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if ((cur_state == VFIO_DEVICE_STATE_STOP &&
+	     new_state == VFIO_DEVICE_STATE_RUNNING) ||
+	    (cur_state == VFIO_DEVICE_STATE_RUNNING &&
+	     new_state == VFIO_DEVICE_STATE_STOP)) {
+		/* TODO */
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	/* vfio_mig_get_next_state() does not use arcs other than the above */
+	WARN_ON(true);
+
+	return ERR_PTR(-EINVAL);
+}
+
 static struct file *vfio_ap_set_state(struct vfio_device *vdev,
 				      enum vfio_device_mig_state  new_state)
 {
-	return NULL;
+	int ret;
+	struct file *filp = NULL;
+	struct ap_matrix_mdev *matrix_mdev;
+	enum vfio_device_mig_state next_state;
+	struct vfio_ap_migration_data *mig_data;
+
+	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+	if (ap_is_se_guest()) {
+		dev_err(matrix_mdev->vdev.dev,
+				"Migration not allowed from or to a Secure Execution guest\n");
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		return ERR_PTR(-EPERM);
+	}
+
+	mig_data = matrix_mdev->mig_data;
+	dev_dbg(vdev->dev, "%s -> %d\n", __func__, new_state);
+
+	while (mig_data->mig_state != new_state) {
+		ret = vfio_mig_get_next_state(vdev, mig_data->mig_state,
+					      new_state, &next_state);
+		if (ret) {
+			filp = ERR_PTR(ret);
+			break;
+		}
+
+		filp = vfio_ap_transition_to_state(matrix_mdev, next_state);
+		if (IS_ERR(filp))
+			break;
+
+		mig_data->mig_state = next_state;
+
+		if (WARN_ON(filp && new_state != next_state)) {
+			fput(filp);
+			filp = ERR_PTR(-EINVAL);
+			break;
+		}
+	}
+
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	return filp;
 }
 
 static int vfio_ap_get_state(struct vfio_device *vdev,
-- 
2.52.0


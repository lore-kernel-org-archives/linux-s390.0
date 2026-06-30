Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D593F9F2E;
	Tue, 30 Jun 2026 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816109; cv=none; b=E9bALutVy5Mk+MBHrp5wAzTzWN26TVl7oBarQVTD47HVwnMnVqJ/2iDL003tYWIDQoMAj/aI+n2GsqvDmcHxUU/bDXMCGTF4Uj6681LhCt71L/mkbh/BJMmTP2LSZolhVUq9SjDSg1sPKKKyzKnUQENZAUZyoDuTLkj9iT6OkpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816109; c=relaxed/simple;
	bh=mk2mxIQ2fBvIntvwtqlw/JjYlXfPllb4KJe7+Q40mi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjpL2XZCaadoyeWN0pLEkh/SAswnim7a/1wpkn8feipgMs00RNBCkBOkqEjv+h/qtbxSdgSLL3YWeIBvAlVdn2LRK0hvw8CNyBJczmU5dI/y1jikV0lQz6i+gXFIEtunkvNjhUHYjdJ9iqw+WSoremKmzBzn/2ITMgnXzyKPpwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e8mJT9vB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e8mJT9vB"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n3l91578111;
	Tue, 30 Jun 2026 10:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=riP/eQg8RWcS+FVfK
	FNaUIKMPM/Z5MqBsKyZonMFZaw=; b=e8mJT9vBNDTw8IvyzzZQgf39hmPtc6yxC
	535T8CO/lNy5r8P5/xmGNhO9WpbzT3FO4RDYZNmm0BbzOvektHMIlxeErVPMLiMO
	5VdwfRf9ve+o1zjbbvEYy7QMdlnhfElls5+81euE4+qjiL4+lD51ghRKtJZXzrl5
	ktu378CU6miMZ1HGKso0S9tMpkSlKhUUG5lXpxdyIAvnTC1HPFCO3nQj/avK6NgD
	EXFI8I6DH+V9DnBozdkEtAlGJ/2yCfVu51I6fjsKJ0C+frLZv3muRbECjV52Vvs+
	RcU2avWMNaQ+W2GM/BuBdkKvhmNf0xjiFTbKtg5P2lQjB/8Ibhj+w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rewuqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UAYkJs006232;
	Tue, 30 Jun 2026 10:41:41 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w1tfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:41 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UAfel327394736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 10:41:40 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC6D458056;
	Tue, 30 Jun 2026 10:41:39 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E822558052;
	Tue, 30 Jun 2026 10:41:38 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.135.84])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 10:41:38 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v3 05/15] s390-vfio-ap: Callback to get/set vfio device mig state during guest migration
Date: Tue, 30 Jun 2026 06:41:15 -0400
Message-ID: <20260630104132.1598851-6-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a439d65 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=34fSTTD2jMTnGACibWkA:9
X-Proofpoint-ORIG-GUID: AFQltY_lCMzJlXWw38EX7u31NsEFg393
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX22/hgpxdOZMQ
 PmSe1toJ6258lMRa6Pf3IBtNhj8ZCDdY5wpldczfiXXNC3gZcgnaGf53VeRiqwiyjEZc6V9Fx/4
 TgVAxeIxf0QayPVl5+glJG72lm3+0My4wyHu3EO+Gl8mRa/wU+Epna2VqZpsLEpSf9NLBoKzHEQ
 Jo7RDbzn9jzXN4a/75mN9MgOUKR6pZ29bsd41ft0O954TUgNroTz3+SilkvVG6kHNIjA2pY41CC
 Ayeh1INlk8yf4cQnnr3EfAZeaSzx+JxhGXKk/4UhM4zn/7u12BfnmtjASs518/+IZAX/EY2BWU7
 j8GRZ835IVvmlbYHPTXXRTxhW9lbPAs1qU1KwdzYFcXvGSCXdeuLynw0XGGeZFuBOVk3yonYzJf
 i0y7pDTKIwJ2ZRwnvx42jNGnCYrTHtZ3mrltX+INfFYiNtQ0A2XtNzBj2dLL7Ktn+/KdwtR/96a
 kciXTZw6kdEnCBW3o1Q==
X-Proofpoint-GUID: AFQltY_lCMzJlXWw38EX7u31NsEFg393
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfXzXe8y/8YMQ3X
 vkE90VlMc0bi1UQ4ygVo2fSF+Ygl9WmUSGo3adQG3hPTooVukh3mIdSPQm/syvdCPSIPOueE0QQ
 lk5z+CKoDOoEETVv/BRPZGduZhrdL3Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300093

Implements two callbacks related to the current state of a vfio-ap device:
* The callback that sets a new migration state of a vfio-ap device during
  live migration of guests with pass-through access to AP devices. This
  callback is mandatory for VFIO_DEVICE_FEATURE_MIGRATION support.

  The function pointer for this callback is specified via the
  'migration_set_state' field of the 'vfio_migration_ops' structure
  which is stored with the VFIO device when the 'vfio_device'
  structure representing the mediated device is initialized.

* The callback that returns the current vfio device migration state during
  live migration of guests with pass-through access to AP devices.

  The function pointer for this callback is specified via the
  'migration_get_state' field of the 'vfio_migration_ops' structure
  which is stored with the VFIO device when the 'vfio_device'
  structure representing the mediated device is initialized.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 130 +++++++++++++++++++++++-
 1 file changed, 127 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index c7c71980bdbb..8274e7b65eea 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -5,6 +5,7 @@
  * Copyright IBM Corp. 2025
  */
 #include <linux/file.h>
+#include "ap_bus.h"
 #include "vfio_ap_private.h"
 
 /**
@@ -56,16 +57,140 @@ struct vfio_ap_config {
 	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
 };
 
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
+	if ((cur_state == VFIO_DEVICE_STATE_RESUMING &&
+	     new_state == VFIO_DEVICE_STATE_STOP) ||
+	    (cur_state == VFIO_DEVICE_STATE_STOP_COPY &&
+	     new_state == VFIO_DEVICE_STATE_STOP)) {
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
+			"Migration not allowed from or to a Secure Execution guest\n");
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		return ERR_PTR(-EPERM);
+	}
+
+	mig_data = matrix_mdev->mig_data;
+
+	/*
+	 * The mig_data pointer is set in the vfio_ap_init_migration_data
+	 * function which is called when the vfio-ap device fd is opened.
+	 * Since the implicit pre-open state is RUNNING, a request to set
+	 * RUNNING is a no-op. Any other state transition is invalid before
+	 * open_device.
+	 */
+	if (!mig_data) {
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		if (new_state == VFIO_DEVICE_STATE_RUNNING)
+			return NULL;
+		return ERR_PTR(-ENODEV);
+	}
+
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
 			     enum vfio_device_mig_state  *current_state)
 {
-	return -EOPNOTSUPP;
+	struct ap_matrix_mdev *matrix_mdev;
+	struct vfio_ap_migration_data *mig_data;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+
+	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
+	mig_data =  matrix_mdev->mig_data;
+
+	/*
+	 * The mig_data pointer is set in the vfio_ap_init_migration_data
+	 * function which is called when the vfio-ap device fd is opened.
+	 * If mig_data is NULL, report RUNNING as the implicit pre-open state
+	 * so userspace doesn't need to perform any state transition before the
+	 * device becomes active.
+	 */
+	*current_state = (mig_data) ? mig_data->mig_state :
+				      VFIO_DEVICE_STATE_RUNNING;
+
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	return 0;
 }
 
 static int vfio_ap_get_data_size(struct vfio_device *vdev,
@@ -146,6 +271,5 @@ void vfio_ap_reset_migration_state(struct ap_matrix_mdev *matrix_mdev)
 	if (!matrix_mdev->mig_data)
 		return;
 
-	vfio_ap_release_mig_files(matrix_mdev);
 	matrix_mdev->mig_data->mig_state = VFIO_DEVICE_STATE_RUNNING;
 }
-- 
2.53.0


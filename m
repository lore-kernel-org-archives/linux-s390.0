Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0492424D75;
	Mon, 27 Jul 2026 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173580; cv=none; b=JIDWV+L9KUcR9tFhmVGe4Bhr0rpEA5WS6MLpemojQvyJMRDbBVDdwJrzeCK+l/nwZMXTxN6yGi760dRTMjkS5Vt+tIiOv/qv0v4gJM2gEXkLQf2W5QL7w1ZV+1y6OKEy1WjSiRYQ2GWIkb1Lahn219/CurmXAd15FSsYQIxLXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173580; c=relaxed/simple;
	bh=eQZxd3mQVqVWL6zwhiWEikbX5vZJBZta1k1tYSt5wHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jO9KvuZsGbQEKx5baCsSl2ONGwP9rTDHyKT9kqDpOwcch60zx6Thp4HCp2awkif1wmLxsguVMS+kALYm+H0PK8TN184GavJ5LYmDX2vWo+LE5cpJqJtmrMV0FBAAbAILhJh7yLqKx7o7hI0Yv8hP5FHTzCRv17icP35v3JwAY6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h0UoF1Px; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h0UoF1Px"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDnP3x2298581;
	Mon, 27 Jul 2026 17:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iYAX2t2sJWflrQdjv
	BWGjJaWWaH2jdmkdqqM8iA4p/0=; b=h0UoF1Px8S1SXrAr7DW9GYWp5cMl8mul4
	Ied3MDffauvHBocYeAHPhcI+xmEln77ZNaakD0PVxpo0wGpOPV0uTt1191HSDMMp
	0n4mJMb0TOtpdQsr76a08Aw1bwdC5PErHyw8JDfNbEjIBodA5IhMj54gwoo8GpJ1
	h03yuMmelgLqc91aIFCmp7T5x8xdl5uWQNMT8Vk8ZRwMJhmflocqryXUaLJrmnMY
	IFNaIAr0ZMTnoV+oC3qyRABBTIzbRwivlcuwYrTuWNe75eySYRCAKVp7wJSDymeu
	IcTbiBPzvA2WEW40Q9wQE/WXViiZOpUhJxucT2o36S2rDkgBq3U2A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj0udj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:32:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RHQGmt031793;
	Mon, 27 Jul 2026 17:32:52 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg6518-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:32:52 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RHWpnu26083860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 17:32:51 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5973F58058;
	Mon, 27 Jul 2026 17:32:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98AA958059;
	Mon, 27 Jul 2026 17:32:49 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.213])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 17:32:49 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v6 05/15] s390-vfio-ap: Callback to get/set vfio device mig state during guest migration
Date: Mon, 27 Jul 2026 13:32:29 -0400
Message-ID: <20260727173239.2420754-6-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX1d2B0zhVJwuv
 IGeC06xw0MvDYyIFu8Mq0aMvDUc74zfjSQb7Wir7boVOMIGRzrBU5y9WmoEGQoK46OnsdcB/L7d
 Di7cFZSFgm1CDaw6Hfekd7ncOgRtTO4=
X-Proofpoint-GUID: 1lHbGQGujGotIFEwztw3FOrJrWNCtmN2
X-Proofpoint-ORIG-GUID: 1lHbGQGujGotIFEwztw3FOrJrWNCtmN2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfXxt9cTaKkmprJ
 QCWLXRm6kC2tM/vQqKgSrX7iPP53ijos3zbQBw7JtqCfPYnh8YelSdH6L1UZ4puTGn6fB9vR5Is
 H40yPF8JTZX47uQPwrFadiehup5DTmoWE/3dnI0ohwNrE0fD8X3xZCP/aku1tivIdhanyWsVDb1
 ZLrDLYkOLyNi4rdhUKSEk0KCww81mnmHgbVTM/i2DkSOrebOYf3pdzt6qzj/SMftRpeiWOjf7q8
 9xM7SIANRa2ujOqRvhR2KcrW2CTpB0KMdmEZFJp4yoYwPO1JrV8lZuD+ytiCzBWx2kYQnokJOh8
 lW1KRRyTmPgJkSSVC6Z6ZR1efRrZJdMzfE2xUGo3hFXwEsZ5LWxdyQuHQIycQ8XrEbFtzLWqvjw
 UUZtJo76+oKodV2aMOhJotxZLV3FHtQpeCt6d9lVHzLyO5hfFOvkUwkDUIUqn67pKi+5o161TNp
 sGOAGRwfnMLKIpLmZFQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a679645 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=-jbGNgXFjY_vrUuEAzMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270160

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
 1 file changed, 128 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 093219e6bb9f..77d15c5cc9af 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -72,16 +72,141 @@ struct vfio_ap_config {
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
+		dev_err_once(matrix_mdev->vdev.dev,
+			     "Migration not allowed from or to a Secure Execution guest\n");
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
+	while (mig_data->mig_state != VFIO_DEVICE_STATE_ERROR &&
+	       mig_data->mig_state != new_state) {
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
@@ -103,6 +228,7 @@ static const struct vfio_migration_ops vfio_ap_migration_ops = {
  */
 void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev *matrix_mdev)
 {
+	/* Live guest migration is not supported for SE guests */
 	if (ap_is_se_guest())
 		return;
 
-- 
2.53.0


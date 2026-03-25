Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A3B33DEC0;
	Wed, 25 Mar 2026 21:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472545; cv=none; b=cMXyW48CjEPGQZCcyWZWcjRATM6/5lDYta2XCX6OUFVvI8sU7ua02K5BwoF71BbvLKavcHQ5i8qr9XwFdmmdMj6NLZspdPgBlXFxT0GS7U2z26NxlST1wAqvqiVqR+5YAlVNiFTM2VFmPuO+SCL/PtEE/cB7v+gvTJfARHSkvEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472545; c=relaxed/simple;
	bh=Xz+GB2Ro+pI2ffB+pDRxp9noK47ECyWLDkREbbllQlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0074hB9vijxNL4a1ZxvKAuzT9opVzJzFw7vsm9Q+unaRhGH8HIL6IGnYHxGPTlUUXGHI5j2b96B6da74aJ6sZMj4o6tADJOTzcA6Rj5eJw2VH1XuuP1+bKCPiBtryGGYgZ9ExJViMnN9qdON1baoLSJM3Ahw7uLEoA6+PKW9S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pmrH/Xn1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pmrH/Xn1"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PGeqxt3444471;
	Wed, 25 Mar 2026 21:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BA0N3O8cGMiGIAxpL
	ybHJB0+iDxyZnkAa/sXqJ2Exys=; b=pmrH/Xn11/t11iYhPpxVpBl6OMFtuVOAQ
	/ayXvciFL+uxRIZ2bgPofjVthGr9ePczAX8GEVOj5tkAZ8PSV9nVpb7XAtQo/U2g
	qttOLAhYuC0uuGdKQnS0eu3V36s0Iy7Ax/6UWXQzktRvfUYrVkyJunjy4nQjzsPj
	8bCzVqj9Ui9YYHjtZJmX+rHVz1Sg3VyAoUJXTKAx76G+FrdpVcCSKg5SkA3qbsNY
	8SvB2asKZPVLE5/SbDXPeGQcN+nM1U6w01OXpMUjYTtwP0RIrfJYVKBdIBb1QY6V
	bsFSEsAtP64UdBv41d0x5POD9UQiDA2sri5C++N+QSUFosM0gqFbw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktv1hk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PImIJN006009;
	Wed, 25 Mar 2026 21:02:17 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yrav2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:17 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL2GVW19726990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:02:16 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC79C58052;
	Wed, 25 Mar 2026 21:02:15 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCAF258056;
	Wed, 25 Mar 2026 21:02:14 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:02:14 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 22/24] s390/vfio-ap: Provide API to query whether migration is in progress
Date: Wed, 25 Mar 2026 17:01:09 -0400
Message-ID: <20260325210149.888028-23-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260325210149.888028-1-akrowiak@linux.ibm.com>
References: <20260325210149.888028-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bbdIn4_XmxL1c2X6Rag1N9A6F_PSQkBn
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c44d5a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=KVO1Mmj0cRKhcOrYc_gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfX6cAmv7hWyrgB
 xOeAtSY19P3cm6eiDRvrNdjn2OZWBZ49n6DagbJiv0hwhOt3ZPKDrrp+AT4cHW0vm3yEAo09cNg
 809kpHT0Gy2xT1yA4jlMbop1AOBcbmPAt1JC6ILEuAriwBoAYO9tf7U4gEjvRe+rSLhmQcIJABd
 03+1HEdm49Ryi8sX9rMxr1c9Ghcp6Om0YOBGGf/tXpBPn7mhiea62jgFcj5QN44c0y06+ACYCdC
 nMFuLG5+OAEsvaCDVqhAqtjWaHpm8n1uEz9Ye74YXhoQsjefQQk+obVF+oqt80AV6MK2ROr15vJ
 ZxLCDhqu3UFfL/tKy33IZ94IcsT0z2jyI7ZYbZtbUhkivy0PjADQxzkaHTHyeFXWNRv12DM7JT0
 CgiQ6GFQUcVZgRWsXyfgpu2YswftlD6HDZWeNGpcXwKNykjvOoA46pbVFK6HYkyoqbRYuhcpe/z
 KgkFoTOWiMjvt7AlOnw==
X-Proofpoint-GUID: bbdIn4_XmxL1c2X6Rag1N9A6F_PSQkBn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149

Provides an AP to query whether a live guest migration is in progress. This
can be called to determine whether an action should be allowed during
migration; for example, allowing a system administrator to disable
migration while it is in progress. Other uses may be to prevent changing
a guest's AP configuration while a migration is in progress.

The only means the vfio_ap device driver has to determine that a migration
is in progress is via the callback functions specified in the
'struct vfio_migration_ops' object associated with the vfio device.
The very first callback invoked during migration is the callback specified
in the 'migration_get_data_size' field of the structure. This callback will
set a flag indicating that migration is in progress. The flag will be
cleared when the vfio device migration state transitions from
VFIO_DEVICE_STATE_STOP_COPY to VFIO_DEVICE_STATE_STOP. At this point, the
internal state of the vfio device on the source has been copied and will
be restored on the target.

Note that the 'migration_get_data_size' callback occurs after migration has
been initiated, so there is a short period of time during which the API
will erroneously indicate migration is not in progress. This,
unfortunately, is unavoidable given the only means of determining that a
migration is in progress is via these callbacks.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 40 ++++++++++++++++++++++++-
 drivers/s390/crypto/vfio_ap_private.h   |  1 +
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index fa163b129c66..8a7628fcf285 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -47,11 +47,14 @@
  * @mig_state:		the current migration state
  * @resuming_migf:	the object used to resume the target guest
  * @saving_migf:	the object used to save the state of the source guest
+ * @mig_in_progress	flag indicating whether migration is in progress (true)
+ *			or not (false)
  */
 struct vfio_ap_migration_data {
 	enum vfio_device_mig_state	mig_state;
 	struct vfio_ap_migration_file	*resuming_migf;
 	struct vfio_ap_migration_file	*saving_migf;
+	bool				mig_in_progress;
 };
 
 /**
@@ -971,18 +974,30 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 	return ERR_PTR(-EINVAL);
 }
 
+static void vfio_ap_set_mig_in_progress(struct vfio_ap_migration_data *mig_data,
+					enum vfio_device_mig_state prev_state,
+					enum vfio_device_mig_state new_state)
+{
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+	if (prev_state == VFIO_DEVICE_STATE_STOP_COPY &&
+	    new_state == VFIO_DEVICE_STATE_STOP) {
+		mig_data->mig_in_progress = false;
+	}
+}
+
 static struct file *vfio_ap_set_state(struct vfio_device *vdev,
 				      enum vfio_device_mig_state  new_state)
 {
 	int ret;
 	struct file *filp = NULL;
 	struct ap_matrix_mdev *matrix_mdev;
-	enum vfio_device_mig_state next_state;
+	enum vfio_device_mig_state prev_state, next_state;
 	struct vfio_ap_migration_data *mig_data;
 
 	mutex_lock(&matrix_dev->mdevs_lock);
 	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
 	mig_data = matrix_mdev->mig_data;
+	prev_state = mig_data->mig_state;
 	dev_dbg(vdev->dev, "%s -> %d\n", __func__, new_state);
 
 	while (mig_data->mig_state != new_state) {
@@ -1006,6 +1021,7 @@ static struct file *vfio_ap_set_state(struct vfio_device *vdev,
 		}
 	}
 
+	vfio_ap_set_mig_in_progress(mig_data, prev_state, new_state);
 	mutex_unlock(&matrix_dev->mdevs_lock);
 
 	return filp;
@@ -1031,12 +1047,15 @@ static int vfio_ap_get_state(struct vfio_device *vdev,
 static int vfio_ap_get_data_size(struct vfio_device *vdev,
 				 unsigned long *stop_copy_length)
 {
+	struct vfio_ap_migration_data *mig_data;
 	struct ap_matrix_mdev *matrix_mdev;
 	size_t qinfo_sz;
 	int num_queues;
 
 	mutex_lock(&matrix_dev->mdevs_lock);
 	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
+	mig_data = matrix_mdev->mig_data;
+	mig_data->mig_in_progress = true;
 	num_queues = vfio_ap_mdev_get_num_queues(&matrix_mdev->shadow_apcb);
 	qinfo_sz = num_queues * sizeof(struct vfio_ap_queue_info);
 	*stop_copy_length = qinfo_sz + sizeof(struct vfio_ap_config);
@@ -1051,6 +1070,24 @@ static const struct vfio_migration_ops vfio_ap_migration_ops = {
 	.migration_get_data_size = vfio_ap_get_data_size,
 };
 
+/**
+ * vfio_ap_migration_in_progress: Indicates whether a live guest migration is in
+ *				  progress or not.
+ *
+ * @matrix_mdev: pointer to object maintaining the vfio device state
+ *
+ * Return: returns true if a migration is in progress; otherwise, returns false.
+ */
+bool vfio_ap_migration_in_progress(struct ap_matrix_mdev *matrix_mdev)
+{
+	struct vfio_ap_migration_data *mig_data;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+	mig_data = matrix_mdev->mig_data;
+
+	return mig_data->mig_in_progress;
+}
+
 /**
  * vfio_ap_init_migration_data - initialize migration data and functions
  *
@@ -1069,6 +1106,7 @@ int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev)
 		return -ENOMEM;
 
 	mig_data->mig_state = VFIO_DEVICE_STATE_STOP;
+	mig_data->mig_in_progress = false;
 	matrix_mdev->vdev.migration_flags = VFIO_MIGRATION_STOP_COPY;
 	matrix_mdev->vdev.mig_ops = &vfio_ap_migration_ops;
 	matrix_mdev->mig_data = mig_data;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index cad49b509f7a..e04644c335fe 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -183,5 +183,6 @@ void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
 
 int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev);
 void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev);
+bool vfio_ap_migration_in_progress(struct ap_matrix_mdev *matrix_mdev);
 
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.52.0


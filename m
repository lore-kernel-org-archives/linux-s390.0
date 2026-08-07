Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDFA3B3884;
	Fri,  7 Aug 2026 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141132; cv=none; b=oKFX4pQzQPRexk91MDF0kNoCcgC9FhLnKKrZPeC2d+45SASDaIDR2gi/ZUeJaVM3fp0MiDwoXuaF9FAjsL28+BDteOatPTbkFbjNspPQt6o0b7s/TYDfmsOoWRyXeN9g2LDsBx/b6mDygOXsHQs/f7Vr41sOGlgLPL8nLcSKWKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141132; c=relaxed/simple;
	bh=C1++x4PUDoTzA5lirNZUgPn5jtL4+oOHfdUKEGOvQuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ec2bq6z8O/nn2iD/lGm+2CNh+fRbHQr2TcOkjUeWUxITWdmD/m2/bc2bnJQUBkentAXd6l0o1qr/p/WdFlsOthWpDt1lEgkuLEFlGI5FSqvJLFisa/Bo2qEX+Q7ijFgM0Uyyg4NAyikplMdF21V/uBvjxNxty2gEGOSH5cRL8JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cILDeBDy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cILDeBDy"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677LmMcT2645121;
	Fri, 7 Aug 2026 22:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=D3+zakmKSRzA7wj84
	FrwFhLeL/uuY9vweDmbdLrRFRI=; b=cILDeBDyAtJ991zplYTZUjV8LhQg+UVmh
	1AeT6oMdtJJjasXwvKciKmemoxhOrLmuZiUFITv51WR3bt8TloACZ1FKSx6NMRsl
	Ya/uJyLLEO9f8fw/RAFtoUuI9N6iVc4S25ibTh5XoU/KoWXchfqXWWBG6+3ilPRR
	um1gWTKKNTrLymLMZXUEPbapj0JL1b+8BcCt/UW606OWfiHpfztjOvmoQk77L0Bc
	5d4jzM1fWtxD4rgtekiQCxQru4VIGysKOE3XldgL6ObA5w73j989vN+G4qqsxF+H
	SNoi2+CnbAEzeXOGonue7f1o+qGa5X6ZlXY9g0O5tEWjCb2HmS3NA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy0468dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677MBWPC021891;
	Fri, 7 Aug 2026 22:18:43 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4khpyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677MIf8F29819562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 22:18:41 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 719435805D;
	Fri,  7 Aug 2026 22:18:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FDB158057;
	Fri,  7 Aug 2026 22:18:40 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.52.19])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 22:18:40 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v7 05/15] s390/vfio-ap: Callback to get/set vfio device mig state during guest migration
Date: Fri,  7 Aug 2026 18:18:24 -0400
Message-ID: <20260807221834.562851-6-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfXwj6yhLHtQ5sK
 SL1S33P1xUxAnX6sMUpdFzBYnK9a4LC4sOVzNBFgIDhLqSY60gKmdeNFkJ3kT4d/qj8+ZgTVoUZ
 /w529RS8Ve0PBKv2dxElwAegEAWYW/OoJCj+anIlH+SzmONM/NLXT0RC5og8vMjE8XGGUNJLcjX
 SBBVktGwhtmY0AT4BCZG7MP2PiDkx5SC5w9fsYQB+kVrZbyrvFjw4H3xaob00TJCragKApyONvU
 B9zLPkJYfBhnQ17SVo5FwNb2a9XmuiXX3UilQnae2OlhzEYL1fq2P1fMf4gMT5MHudLDVBN6BGn
 Pc7vNPX2dQe/aDYra9d7ECwCq0nynFm0uK9uFFGmpxRm9IlODVKS5EiUDmilVjlihCxwjmThnYm
 ulMMJGRbxKjlqVQ3UTAdT2TtuYCO9I8TO7i1ln1GSxbPAuar4v+Xh+mxnDuqjarqFlLDIDbXzr8
 8eqI9xRZRzNhS73s7zQ==
X-Proofpoint-ORIG-GUID: u_cf130Iate6H9OjocZ0oUCRKMHffFUK
X-Proofpoint-GUID: u_cf130Iate6H9OjocZ0oUCRKMHffFUK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfXwRLYG9S6duub
 JteHy8ocJ/ggntgRTnMXkibQg25rSDzGeNLfxFkQu4ZObPHWrvr9nf0UtqQaFq7T40zyYR/DpyI
 lE8lZKuMq9e5GYqsKCsIQOsgSqdVzFs=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a7659c4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=-jbGNgXFjY_vrUuEAzMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070175

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
index 1613813124b6..af740b177c97 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -128,16 +128,141 @@ static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_dat
 	 */
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
@@ -159,6 +284,7 @@ static const struct vfio_migration_ops vfio_ap_migration_ops = {
  */
 void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev *matrix_mdev)
 {
+	/* Live guest migration is not supported for SE guests */
 	if (ap_is_se_guest())
 		return;
 
-- 
2.53.0


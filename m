Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E979F52188A;
	Tue, 13 Oct 2026 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905559; cv=none; b=SuzfKzpQg+YTyozURHrT/Bpvt14yGWXpJlz5MVac5U/GG84mL6PHMLnT2v0reBOpwN7UYZYkptUqXQul4QSfBacQuSNbxCvsMcAHwyRPvyq5WhtKTKKS2pREAXzmjPPks/dMwZHG2BVL6wLa12Fv1Fd1fCbsIko/9nC/SzQHVl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905559; c=relaxed/simple;
	bh=v32USYQrj5ol4qOs1gZbSwdI68NTkmots7i66jZcZLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWHE3DVptXM2CNhv2mqNHnCl64l0LfxRUVJ4FK1iqWsh6ReF4ppb71w6gNrWqnAXeAZJ5NQsjVFuUHYoIBsP4OhA5i9wtvStZFKOoo7weRy6EsjMf2lmkYbOTxEobdLS2Uljj0QfLyQ3XOfqoxNZ+MY6Y7ILtEAt4mqO8Suwsmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EmH7ncAS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EmH7ncAS"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDXLgL1934188;
	Tue, 13 Oct 2026 15:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tMcb3Y7alhDmu+aYq
	5nRDw/BRl/e7wrh2fT9qaASycU=; b=EmH7ncAStUS1iISiIbn+BwRGBCX5Khoaz
	MNUB7w/Dkj5lBFN/MUGGCfVGCPfF2B44jC/g+9Ct40LYnnh19TiGQ36W3BBlw5Xm
	J6uLkjuX2rmVXt8ORQ+wUfNPx3geVondRozfEGtcPQyL6mUcdh7xqrGucgAayyUm
	Myz7xoTXvUiL7Z7xGKGGmTKosd6moP9BXF0d0fBLL2Re6GMztaD8SXhmZ1tpY1g9
	JJ9BmHllGeIkvYd2DcVqOMNeFCJldWfQm/x9VS8sPFcPe8oI+UjUoI95GszqA+s4
	e5FNCMqQ8AiVj+peKoNy/yrvwyq6qD55E3kyosAw39Iq0gOWVYw4g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w6m6n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DCV1dw1440297;
	Tue, 13 Oct 2026 15:32:32 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wg2erm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:32 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DFWVvT29950578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 15:32:31 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2E4B58068;
	Tue, 13 Oct 2026 15:32:30 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FBEA5804B;
	Tue, 13 Oct 2026 15:32:29 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.17.246])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 15:32:29 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v9 05/15] s390/vfio-ap: Callback to get/set vfio device mig state during guest migration
Date: Tue, 13 Oct 2026 11:32:09 -0400
Message-ID: <20261013153219.3534306-6-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX2vtAZiD3xYEf
 gBdmXrSL1jCmuSnxZgP4alidHvk5vOYmpu2Gnrkd0lOYqNMzICHc7AzbptUQaYMWAu/RsKU+HF6
 Cxfsp/4+YmPBi23SGkpExiIH/bP6HFc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfXzoFxUgV9i9JI
 XU8H1R06f6PWnUVBcK1Uwjouaxji9A3mQ9jsBiiMH36kTiT8qzA6OAWa4LBpHhi7jl+hrFG6AzT
 7wEzCNoil27Oore7fxkpILyOq8iFLYGg9jzifOoxZO3tafxrWnTy1QV/FWFPAmCG1oXuKphm0Ab
 p1JmzQPIdhEULqFiKQuXgiBuEQzbRw8I8xKdqFXl5eiUJpboHze80Tc+9ZM9I3m9KBxuJxFzT5X
 wU3MOZvQKeGx2YsqobDx83NIHjSY0N4EdnGAs5Mpme9RyYR5Pi3O8ghHDFo+pltQtsnRC8h2rAs
 ++suoRiIbZbDlSG5U8cQkEgRqH5pSvpKchOglng8hR7ohab+TnxjYyo5ft8sFXcMEa5Bgx2n3y1
 PwWFz/VHzltl9oxU/4mqimkXHFqq3nZLApqrejfojHH7Ot0s3eioqhFKOoeT8kbq6pqJA/98FZZ
 UBA5arREaNA6mxd8/0A==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6ace4f10 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=34fSTTD2jMTnGACibWkA:9
X-Proofpoint-ORIG-GUID: RwJCJycbqBgj98G6VtMI7dZ8rnxbXVi_
X-Proofpoint-GUID: RwJCJycbqBgj98G6VtMI7dZ8rnxbXVi_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130060

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
 drivers/s390/crypto/vfio_ap_migration.c | 132 +++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 5b17e3b58a80..95b1f0ccdff5 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -128,16 +128,144 @@ static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_dat
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
+	mutex_lock(&matrix_dev->mdevs_lock);
+
+	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
+
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
+	if (mig_data->mig_state == VFIO_DEVICE_STATE_ERROR)
+		filp = ERR_PTR(-EIO);
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
-- 
2.53.0


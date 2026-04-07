Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8226937E2E1;
	Tue,  7 Apr 2026 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595084; cv=none; b=qbSUJYoRkf+EVNUcJwN3QZaAc9IXReDz+IIlIqtq+e8kOv3AFIT1PGGdyfPIwvTvG5b/TtDb80DhLLmEViWBHF7bQivwnmecSO2z4jrXSepQ6+0URDueHD1Tg/yxNk8HODL4N1WhMCZauBi4JjiqWDUOPq4A65MleBnT4Fletj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595084; c=relaxed/simple;
	bh=23eQxeI7/7LuOBGA2KWzIAzvxs2uwq46pf5WizY5lrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Okg4l5h7Wde07w3iNxbhoatujY4oQqb0TOZRq7fwHs7Q4wi8ln4c+EEUc6rannvKe9Rm5iDs2j3MduVR1B5vZW25RCLW56l5sZZ97dUHVQ3YgaPUYiWt2ie9zg/to98AETiBKW8JpbVV1GlwJMA5avl99ZNtzVDJjJbXzVuAtxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CJEfp6gx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CJEfp6gx"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637DJibK2210122;
	Tue, 7 Apr 2026 20:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AitTr/WRu565yLyxN
	4+HSehPsNdciEMXxf+1kq7LKHU=; b=CJEfp6gxjAURM0tXs/HZvOpIFOmpZATYh
	3SbSvLPUyhiOs6KRXSwRlWQn3H3hIjzSTFHNl1olKzhQi2UQWGTTKJk3F+2fXvnM
	whLpXilsMcohj3c5AuufXDuGaSZXTn2/jTu8bVOeaixormWN5W4jLUzQrPBbEb33
	phwnoLC8Vq7BMGz3GpVN3lF51M30Zhiik+s+QQFrV4FbLr57TYw6I+DbeRKJWlQJ
	hfZ0xIfHJRprJAs8zMWJcycAxUFvPZAHhkx0XRnTo+sL2teiV7A6GO7p/Jurx2vA
	hslksOrRN+KOXXdtqo+TLr+LoZkx1GVxIcj0WZlXmkob+ey0QTaWQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hcnf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637IgMpJ018965;
	Tue, 7 Apr 2026 20:51:17 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9cupc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:17 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637KpFIX25428522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 20:51:15 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 480755805C;
	Tue,  7 Apr 2026 20:51:15 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEF4358058;
	Tue,  7 Apr 2026 20:51:13 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.101.194])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 20:51:13 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v2 07/16] s390/vfio-ap: File ops called to save the vfio device migration state
Date: Tue,  7 Apr 2026 16:50:23 -0400
Message-ID: <20260407205100.331150-8-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4OSBTYWx0ZWRfX4oiRYIFf4lfV
 d5n0BS9wlbOBzkDtUWKqh9zKt6Wn7Eg4HL9HHy2xnNDJAbp8s9Eueqdkc1+cTxSuoi8l6HbvE91
 KVOHWhiatOZH3lr//bsqZkC4s5z+4t9MF1gk2iZnsSbpun5qz5jMdORyQLgMjTJosYZNnTEkIpS
 5+e7+mO/V1QSNEwZf0OhDrvGJeofJNMQ1hsYc6RhJjBRprW3/LbvAyin4e5N0c05XSWKmEwT+ZF
 HlrR6AHqmyWndAnv1G7/NgLxhkAI92V+U59ySWD5V04nm0EjXxN7U3ibI6lJAa8Gz2FjPFOkCsy
 kC5mAieyFm4mpQlyBspHDfr3sLmtYulYXN8THUg5FDZl4c2eIb7y/R/S9EYLa4IYSxt89/LcGLL
 D1fnMYCvK0zoLKC02xZ/nAP4sgAsiqpW1QXim0v9+33b62xd01EURTUDUVPbijq/caAwqhXu6/Q
 GvFO7xZXguIwxYnWMgQ==
X-Proofpoint-GUID: ajNRKD1sIms_6p9xa5iZQJXK-_t0LIpH
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d56e46 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=ziKF1hX67kHMkuPFGWMA:9
X-Proofpoint-ORIG-GUID: ajNRKD1sIms_6p9xa5iZQJXK-_t0LIpH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070189

Implements two callback functions that were added to the 'file_operations'
structure for the file created to save the state of the vfio device
when the migration state transitioned from VFIO_DEVICE_STATE_STOP to
VFIO_DEVICE_STATE_STOP_COPY:

* Read callback

  This function copies the guest's AP configuration information to
  userspace. The information copied is comprised of the APQN of each queue
  device passed through to the guest along with its hardware information.
  This data will be used to verify the source and target guests have
  compatible AP configurations.

* Release callback

  This function deallocates the object used to save the state of the
  vfio device.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 78 +++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 21734d3ed7b7..aadc362edf78 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -98,16 +98,82 @@ static void vfio_ap_release_mig_files(struct ap_matrix_mdev *matrix_mdev)
 	}
 }
 
-static ssize_t vfio_ap_save_read(struct file *, char __user *, size_t, loff_t *)
+static ssize_t validate_save_read_parms(struct vfio_ap_migration_file *migf,
+					loff_t *pos, size_t len)
 {
-	/* TODO */
-	return -EOPNOTSUPP;
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	if (migf->disabled) {
+		dev_err(migf->matrix_mdev->vdev.dev,
+			"%s (%d): migration file is disabled\n",
+			__func__, __LINE__);
+		return -ENODEV;
+	}
+
+	if (*pos > migf->config_sz) {
+		dev_err(migf->matrix_mdev->vdev.dev,
+			"%s (%d): file pos (%llu) exceeds migf->config size (%zu)\n",
+			__func__, __LINE__, *pos, migf->config_sz);
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
-static int vfio_ap_release_migf(struct inode *, struct file *)
+static ssize_t vfio_ap_save_read(struct file *filp, char __user *buf,
+				 size_t len, loff_t *pos)
 {
-	/* TODO */
-	return -EOPNOTSUPP;
+	struct vfio_ap_migration_file *migf;
+	ssize_t ret = 0;
+
+	if (pos)
+		return -ESPIPE;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+
+	pos = &filp->f_pos;
+	migf = filp->private_data;
+
+	ret = validate_save_read_parms(migf, pos, len);
+	if (ret)
+		goto out_unlock;
+
+	len = min_t(size_t, migf->config_sz - *pos, len);
+	if (len) {
+		if (copy_to_user(buf, (void *)migf->ap_config + *pos, len)) {
+			ret = -EFAULT;
+			dev_err(migf->matrix_mdev->vdev.dev,
+				"%s (%d): failed to copy config data to user\n",
+				__func__, __LINE__);
+			goto out_unlock;
+		}
+
+		*pos += len;
+		ret = len;
+	}
+
+	dev_dbg(migf->matrix_mdev->vdev.dev,
+		"%s (%d): copied %zu bytes of AP config data to user\n",
+		__func__, __LINE__, len);
+
+out_unlock:
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	return ret;
+}
+
+static void vfio_ap_deallocate_migf(struct vfio_ap_migration_file *migf);
+
+static int vfio_ap_release_migf(struct inode *inode, struct file *filp)
+{
+	struct vfio_ap_migration_file *migf;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+	migf = filp->private_data;
+	vfio_ap_deallocate_migf(migf);
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	return 0;
 }
 
 static const struct file_operations vfio_ap_save_fops = {
-- 
2.52.0


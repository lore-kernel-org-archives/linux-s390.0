Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6DE3A7826;
	Tue,  7 Jul 2026 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414968; cv=none; b=A2lFJ9O+g0Zh+lfKxpr2T8NECVAXV0o4z6pm8W4IXxcx4lGXmMAZ2FaEmvQz6dEXYUoneTkBmWibd2qvp584ynk1zVXOXzEJ4J3/8ep5D3r0SgxmY/fCKvJRezn3OJyzBeYMuM9L91x2h+v3lIH2g7jUP2OichOqYKUFlpU10YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414968; c=relaxed/simple;
	bh=z0jNupcFEKpT3KdfOxc7UqYl82ojlNG0cSMAYn+ESVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpxLtvmJAOQ+/HvjxrD/6hX153ykd11b5SeC+4Qpo8hJZJLjvNpc6yCgOm/1zg+cL8P3Cy9Qq1DlpCgUE8q6ZQFQ3Ab0wcObFsNDRdy4g37OykDa+hoVI0QLQtpDjxT4XwUDsNx2t+/H4GvHKYsBGC9g0dwMXwNVVCUx3EsriWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oQfFBrSr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oQfFBrSr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678INa82273586;
	Tue, 7 Jul 2026 09:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/08/6h4RLxLYv/K0M
	xYTTLOf2lOuYKUKhYPgeR09y0U=; b=oQfFBrSrqOgxyEyCUgbjVI3WmNd1O2zp/
	ssE7fyjznJEWMjVgO07eMdAgn79Ld/tt0IxvKBycTUnbLSRnMZiOxeKDPH9fAgeF
	JO5IKyqt0CpzKcFNmd1uWfYw55wdxt4F+5cyC9uH1ZkdPi4oN1EmAkY3sl3kuaGo
	XW80tZrB7AqnTtMFh660E7hjdayvybDh/PT8mF2iL9ae54FXgt1SEdBm6kQmvhUP
	JbKIgRx+C/qhR1VWAjJXSLhrGQrUNvh0Lqlsw5V01FjycEXMhokvWe+LAU10lQDI
	amWvY2OrPx72F2iiuuHdRwOwHx6+dUJc2Z4G8DnljbH5ySXDwpdVQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdprst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6678nbd5028908;
	Tue, 7 Jul 2026 09:02:39 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg1q35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:39 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66792c5E57672010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 09:02:38 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 589B55803F;
	Tue,  7 Jul 2026 09:02:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34D1458056;
	Tue,  7 Jul 2026 09:02:37 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.160.85])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 09:02:37 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v4 08/15] s390/vfio-ap: Transition device migration state from STOP to RESUMING
Date: Tue,  7 Jul 2026 05:02:10 -0400
Message-ID: <20260707090226.3206695-9-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
References: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4cc0b0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=tR-Paw13gH0jRigdlV0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX+Zv7YUo2GrTW
 UYAnZhtzgzXQSxhj6ltrJ9EE6w7esxMnLP6mPJxWdUxMHrNn4XxPAu0LrzJab3uZ6rsclqXFiEN
 nYp2DUa3ASyjSLqY/I5Dp0tH5qMPcyxmL5eD5C1NwVl1qMA8SNW6RSX8khi8VVkH4UwMQ825Qy3
 OUq68FukH3YQhBZcnbTKQPp7mI3cjkvoJAeBU03GiScujYNsX2rwO7m26VfhT+6ZUpxnVZ0B69p
 YdUVGoH0aiQnlRC3wJJ2JEyA2DE+2hBB8pznPC+98TtDskGLxWmHRzsF739EQ/jDrbK09vm2xPd
 tylQCscPoDjyTCy1Rc62q68BtWlDAUaNH4NOAvHYYksxTtUPHoadYjfK2SVUHE/6hslRvUsVEaP
 MYdEwtM9SrwKusfilh28dV37+ZKZA/vxw4gY4C3clkDds77xYMJYDNMghwlCJNJsgLMKY9DWLWV
 xFxy1/1Cq/+4KD8D7Eg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX9+zGgEppJ9oA
 fQFfp+ZQDRLqTBg7MIvZggbtpDAeSxLts2HgY3KDLIStWQ2bfzJlm40uxcAy2txDEsBTn6p35Y8
 hA4z5JP01zNizg1BX/vIy6WLsEz8TaE=
X-Proofpoint-GUID: P_9zvJJmdMFhXBwfDDpaPT3Znqt7Q4ns
X-Proofpoint-ORIG-GUID: P_9zvJJmdMFhXBwfDDpaPT3Znqt7Q4ns
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070084

Transitioning from VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_RESUMING
starts a process of restoring the device state of the vfio device on the
target system. To prepare for restoring the device state, open a file
stream to receive the guest's AP configuration saved when the device state
on the source system transitioned from VFIO_DEVICE_STATE_STOP to
VFIO_DEVICE_STATE_STOP_COPY.

Note:
This commit introduces the file operations structure for migration state
files with a stub implementation of the write operation. The complete
implementation is provided in the subsequent commit.

This incremental approach allows for easier review of the migration
infrastructure setup separate from the actual implementation logic.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 54 ++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 5ef7127b697a..e917cc995d35 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -65,6 +65,17 @@ vfio_ap_release_stop_copy_file(struct vfio_ap_migration_data *mig_data)
 		mig_data->stop_copy_mig_file = NULL;
 }
 
+static void
+vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_data)
+{
+	if (mig_data->resuming_mig_state.filp)
+		mig_data->resuming_mig_state.filp = NULL;
+
+	kfree(mig_data->resuming_mig_state.ap_config);
+	mig_data->resuming_mig_state.ap_config = NULL;
+	mig_data->resuming_mig_state.config_sz = 0;
+}
+
 static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
 {
 	struct ap_matrix_mdev *matrix_mdev = filp->private_data;
@@ -74,6 +85,8 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
 
 	if (filp == matrix_mdev->mig_data->stop_copy_mig_file)
 		vfio_ap_release_stop_copy_file(matrix_mdev->mig_data);
+	else if (filp == matrix_mdev->mig_data->resuming_mig_state.filp)
+		vfio_ap_release_resuming_file(matrix_mdev->mig_data);
 	else
 		return -ENOENT;
 
@@ -311,6 +324,32 @@ static struct file *vfio_ap_open_file_stream(struct ap_matrix_mdev *matrix_mdev,
 	return filp;
 }
 
+static ssize_t vfio_ap_resuming_write(struct file *filp, const char __user *buf,
+				      size_t len, loff_t *pos)
+{
+	/* TODO */
+	return -EOPNOTSUPP;
+}
+
+static const struct file_operations vfio_ap_resume_fops = {
+	.owner = THIS_MODULE,
+	.write = vfio_ap_resuming_write,
+	.release = vfio_ap_release_mig_file,
+};
+
+static struct file *vfio_ap_resuming_init(struct ap_matrix_mdev *matrix_mdev)
+{
+	struct vfio_ap_migration_data *mig_data;
+	struct file *filp;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	mig_data = matrix_mdev->mig_data;
+	filp = vfio_ap_open_file_stream(matrix_mdev, &vfio_ap_resume_fops, O_WRONLY);
+
+	return filp;
+}
+
 static struct file *
 vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 			    enum vfio_device_mig_state new_state)
@@ -342,10 +381,21 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 		return filp;
 	}
 
+	/*
+	 * Begins the process of restoring the vfio device state by creating and
+	 * returning a streaming data_fd to be used to read in the internal
+	 * state of the vfio-ap device on the destination host.
+	 */
 	if (cur_state == VFIO_DEVICE_STATE_STOP &&
 	    new_state == VFIO_DEVICE_STATE_RESUMING) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+		struct file *filp = vfio_ap_resuming_init(matrix_mdev);
+
+		if (IS_ERR(filp))
+			return ERR_CAST(filp);
+
+		mig_data->resuming_mig_state.filp = filp;
+
+		return filp;
 	}
 
 	if ((cur_state == VFIO_DEVICE_STATE_RESUMING &&
-- 
2.53.0


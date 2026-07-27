Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D555E43636A;
	Mon, 27 Jul 2026 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173585; cv=none; b=aiLao6+VkoNrUpU0qOAQ+f3uKj7+/IucrX69n1F3JZ0/ZdZKBz7JylAKDJRpy6Q/UajQ8PCwMFw/9qN5kKB1NKdVqFBBHI6nUJdqAN6Fh6XcWL4vn9F0fuM/fhMhXxrQ17Ma0zaOMwyTadntlSxEbJd6EeUoWc94yS29+eY7JW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173585; c=relaxed/simple;
	bh=jIQKV9rfJoIZTvvUhEp7PEgvwzS/6LYglevZ/nmNCvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oa4pLnXrM8L4DCfJDYTQODMO0Xd5H3m3LdahLMxRUmVHdcK1bdT2dB4YBHSl0O6QNhgSHkAK1s4Bag/tzsRoYMoy+Z8JuCSwTU/zb7EMgOM8IThxWtC0H4Idr2xwguEXTkSEsK37zSsgQh9D8aMgn7vg47dAK8aGA5o55Ma0rm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m2M/ZBtP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m2M/ZBtP"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDne7T2299005;
	Mon, 27 Jul 2026 17:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/eY3CMnq66YYqzFyz
	uEAosIp2iAOQwa1gomtSxja8ps=; b=m2M/ZBtPZTTC8Yc6r9qD707/irFzUAhve
	SnXVa7HcXYXTT+w5WtQEeuu8w61o7lrBIDEMkl5q7wnTIMIBbQteeyIoWz6wtsok
	fIsfn5NWkkJwwpKUMetYALzn6nO6AuwQlMy+wkMXZbP8DOvqZWqB9CJzWemRgFgZ
	bq9sm+Byr9cP5tSQMkAjmopbKpe6kwohDZdCn1w/GCcEDiX8yYOgDNPpCHOkQbWz
	yXrNBChcljMUR2dRnsoGeaJSJhYpwA8rpmkpAVlYsntaVnazQIfuq9LN2XrCICud
	WOXDzGfTFMJtuOmM307g4NvomU0Y7uXcEtValifMPJRwpn0eqA1Xw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj0uds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:32:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RHQFkO013231;
	Mon, 27 Jul 2026 17:32:58 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjxbxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:32:58 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RHWv9Z25559478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 17:32:57 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F15CD58058;
	Mon, 27 Jul 2026 17:32:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EDAF5805C;
	Mon, 27 Jul 2026 17:32:55 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.213])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 17:32:55 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v6 08/15] s390/vfio-ap: Transition device migration state from STOP to RESUMING
Date: Mon, 27 Jul 2026 13:32:32 -0400
Message-ID: <20260727173239.2420754-9-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX8c62G9lOsjFs
 8OrxGM+xHBjiUeYyffC9pB8EqDlQPUZJfqMejffvtxj8pZZtATJRsZapV1uX8DRUgT0KyfMc1yV
 uG/roWWmtZezDHMuCe3hJFPzoo+C6Qc=
X-Proofpoint-GUID: b4g7r2cwMkvaNbrK6PElwk80GcbA0eEE
X-Proofpoint-ORIG-GUID: b4g7r2cwMkvaNbrK6PElwk80GcbA0eEE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX/dqHr2jFjgFA
 Relkh4mX4c50dBLKtuCS29zpaasXhfIE/aD+Jzn/u6cHmIj5wJTJairBFJz+G1J0bEjpWRtBeuK
 YFAOn/Ngz6S4w54cN9391PoKfCmPpMZCJQLaQERQrc/H/ruvapTSLKV57mfzoQO7QLYBWm4LYnW
 XV+PnvVtkqF4o0S77LQsKLtgVq6wbuwBj/GTQbVO63MSYEFGo39oLQNO4i52NMnKIBvnOAeEo7l
 JbaKGI6/YOSh1EBcVTr6BDhl9vr4yh5FDTdDugSK9RemaK46bxO7LDLOtBJlYYLtC9URbfKgmvl
 njqaPB7g4Qm3dqkULkpi2c46BkEt7VMA95J8luppcFAEzD9xGXMfEY9B3+W/2hykWgpF+PseBes
 JqPn4XnyhO5OIWHrUyQXds6g75fQgkF1B6FhJRgGHXGWANZtqFvHOJwim8KYzV4xC2ScqC7e1v1
 roh7ouneU9KkDGIW2bQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a67964a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=FUUwv-cybw--5L-2NSUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270160

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
 drivers/s390/crypto/vfio_ap_migration.c | 45 +++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index e4bc67b1eb84..c7fecad0b676 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -82,6 +82,15 @@ vfio_ap_release_stop_copy_file(struct vfio_ap_migration_data *mig_data)
 	mig_data->stop_copy_mig_file.filp = NULL;
 }
 
+static void
+vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_data)
+{
+	kfree(mig_data->resuming_mig_file.ap_config);
+	mig_data->resuming_mig_file.ap_config = NULL;
+	mig_data->resuming_mig_file.config_sz = 0;
+	mig_data->resuming_mig_file.filp = NULL;
+}
+
 static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
 {
 	struct ap_matrix_mdev *matrix_mdev = filp->private_data;
@@ -99,6 +108,8 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
 
 	if (filp == matrix_mdev->mig_data->stop_copy_mig_file.filp)
 		vfio_ap_release_stop_copy_file(matrix_mdev->mig_data);
+	else if (filp == matrix_mdev->mig_data->resuming_mig_file.filp)
+		vfio_ap_release_resuming_file(matrix_mdev->mig_data);
 	else
 		ret = -ENOENT;
 
@@ -400,6 +411,26 @@ static struct file *vfio_ap_open_file_stream(struct ap_matrix_mdev *matrix_mdev,
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
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	return vfio_ap_open_file_stream(matrix_mdev, &vfio_ap_resume_fops, O_WRONLY);
+}
+
 static struct file *
 vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 			    enum vfio_device_mig_state new_state)
@@ -431,10 +462,20 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
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
+		mig_data->resuming_mig_file.filp = filp;
+		return filp;
 	}
 
 	if ((cur_state == VFIO_DEVICE_STATE_RESUMING &&
-- 
2.53.0


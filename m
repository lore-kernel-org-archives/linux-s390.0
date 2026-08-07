Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C0F459AD3;
	Fri,  7 Aug 2026 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141132; cv=none; b=fnO55pCxJykroXhKwqK8+gHciB3hFOTZYXDioMxWIwKuKOoQwX8FU1CnhzIesG72m87eAELABKe/EhuZHaaGttXBzTU8BACzcM+iJX5GIyZq5PBPZPBmoRrw+Vf7MttbiEU3WLCMtJEVUAEeNBUH9JnBAKqzwU3p70swKKXHKLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141132; c=relaxed/simple;
	bh=Q1nvRqGC12zqsmpDfwN+9JP3YGBP9RZmXSnXAI+vi08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqJoC10HTjLucSPm/9JB0mIK/TZqzmychZ3HZ//sAm5FaKkqXRHZLruKIvb11CKZurHtJKEyn/daSkYm6RtyjbZDLzeYfpg/94mo/VLwsM1Spk2A+USM6AclrN/5Qmx4tP0K3Jd52ji5s8v04KjhQ4BOLvr/E6g9D0q6FBIIEM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=asyW8qe9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="asyW8qe9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677LlcCt2675413;
	Fri, 7 Aug 2026 22:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qUpZdkVGrnmUwBrTA
	ofEwR1nd/X7FxqqEJ6rhazOyYU=; b=asyW8qe992BveTBIMdBMkzbtUrvWH91HG
	tfI3NhvKKD0P0CyLtmNtOLmmKfj/8ERLfjHXSFp/0uMqtpSN/H89vxdk9cWOVtdJ
	JeI8iz2r23ZcZazw7u2IyrTESEMmxahfWNnaHCxGfUWU7xrGiP7XP8Q5VAhvvjz2
	yNhmrp16TfbwOte8jGgjolFjR8w8op4Q5KzXAE3ofP3/SCoCWxvfO9ZUCSKxpyoQ
	RIlundXMRCCiZuSrfdZTtijFU+lyfUgStvVS+sQcX7q5dXLncGSUfQZe/61q9bbV
	bwWnf8ZpZ31GSTOccRsm0eihUk1+Hml0/51m/57C7LtThIJxOFjQw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyx8mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677LuKmf030150;
	Fri, 7 Aug 2026 22:18:43 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgsfs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677MIgO442008948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 22:18:42 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C7C758058;
	Fri,  7 Aug 2026 22:18:42 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D14258057;
	Fri,  7 Aug 2026 22:18:41 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.52.19])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 22:18:41 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v7 06/15] s390/vfio-ap: Transition guest migration state from STOP to STOP_COPY
Date: Fri,  7 Aug 2026 18:18:25 -0400
Message-ID: <20260807221834.562851-7-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a7659c4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=_8NKb_9EqzLue2x-dRcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX6UsT9RQTfqYj
 34VtBG0Fs0nKkJVae4e8bjISk5W2QIdI/YeMSXSDjdU9Xrtmd6LWai0XeQSXD10buGTlDD0hLVH
 Qbcy1sG7nThG/0J0nuj0/Ld9vCiVCsI=
X-Proofpoint-ORIG-GUID: JHWL1pgnbOABfCK_YBKlddCYjLjTrFuB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfXzjX7D+1p4c/e
 xB7shmVyRjKknttVEBCvyW2j5tyEjNI/sqUvhp7jXvOH3N1HIEXU5dLLakn4qKaF4E0XI43tp8T
 IeU8fz+HfSVlhZCoxT+nYmbK/Y6MbREJWgX2PMmCCfawPhEYKRPjlx5iE85D0LVGLNYEp5dYrWW
 7OBaFRfMZOsbq9mL0GAWPgrWXfnuooN54Dznjw64HN8WJYCfCHP6l1eCF7wWfRktyaGJVNDhCfW
 Ys2cyamj+aEobouH0u0ylDaUhey/V2gPnhh0V7G+BYC7VAyt6CBG4EH6h/xSMZg2B8+YABhIR71
 WysYybnpiczzpbcgPYqYfDgLZWSS+rsehN88GxNGI41CxhHtnIuP0k4Y+CXsf/UCfY1wcPtDzRO
 tPp/5V4awf/CbtvNrlkQ1YEmj2zs1fJXdRoTjYUDQMlQagXgVHNV8TE8k1ENSU/lzvZAG/WvWco
 dQ7bLeN/X+cx2/Ow32g==
X-Proofpoint-GUID: JHWL1pgnbOABfCK_YBKlddCYjLjTrFuB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070175

The transition of the guest migration state from VFIO_DEVICE_STATE_STOP to
VFIO_DEVICE_STATE_STOP_COPY begins the process of saving the
vfio device state. The vfio device state is comprised of the guest's
AP configuration which specifies the adapters, domains and control
domains to which the guest will be given access.

To begin the process of saving the vfio device state, the VFIO AP device
driver opens a file stream that will be used to read the source guest's
AP configuration.

Note:
This commit introduces the file operations structure for migration state
files with a stub implementation of the read operation. The complete
implementation is provided in the subsequent commit.

This incremental approach allows for easier review of the migration
infrastructure setup separate from the actual implementation logic.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 72 ++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index af740b177c97..de693b308925 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -4,6 +4,7 @@
  *
  * Copyright IBM Corp. 2025
  */
+#include <linux/anon_inodes.h>
 #include <linux/file.h>
 #include "vfio_ap_private.h"
 
@@ -128,6 +129,61 @@ static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_dat
 	 */
 }
 
+static ssize_t
+vfio_ap_stop_copy_read(struct file *, char __user *, size_t, loff_t *)
+{
+	/* TODO */
+	return -EOPNOTSUPP;
+}
+
+static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
+{
+	struct ap_matrix_mdev *matrix_mdev = filp->private_data;
+
+	/*
+	 * The VFIO device lifetime is tied to migration FD lifetime (see
+	 * vfio_ap_open_file_stream() function) to guarantee that the
+	 * matrix_mdev remains valid for every read/write operation. Let's drop
+	 * it here since the migration FD is being released.
+	 */
+	vfio_device_put_registration(&matrix_mdev->vdev);
+	return 0;
+}
+
+static const struct file_operations vfio_ap_stop_copy_fops = {
+	.owner = THIS_MODULE,
+	.read = vfio_ap_stop_copy_read,
+	.compat_ioctl = compat_ptr_ioctl,
+	.release = vfio_ap_release_mig_file,
+};
+
+static struct file *vfio_ap_open_file_stream(struct ap_matrix_mdev *matrix_mdev,
+					     const struct file_operations *fops,
+					     int flags)
+{
+	struct file *filp;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	/*
+	 * Pin the vfio_device registration so that matrix_mdev cannot be freed
+	 * while the migration FD is still open. The matching put is in
+	 * vfio_ap_release_mig_file().
+	 */
+	if (!vfio_device_try_get_registration(&matrix_mdev->vdev))
+		return ERR_PTR(-ENODEV);
+
+	filp = anon_inode_getfile("vfio_ap_mig_file", fops, matrix_mdev, flags);
+	if (IS_ERR(filp)) {
+		vfio_device_put_registration(&matrix_mdev->vdev);
+		return filp;
+	}
+
+	stream_open(filp->f_inode, filp);
+
+	return filp;
+}
+
 static struct file *
 vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 			    enum vfio_device_mig_state new_state)
@@ -141,10 +197,22 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 	dev_dbg(matrix_mdev->vdev.dev, "%s: %d -> %d\n", __func__, cur_state,
 		new_state);
 
+	/*
+	 * Begins the process of saving the vfio device state by creating and
+	 * returning a streaming data_fd to be used to read out the internal
+	 * state of the vfio-ap device on the source host.
+	 */
 	if (cur_state == VFIO_DEVICE_STATE_STOP &&
 	    new_state == VFIO_DEVICE_STATE_STOP_COPY) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+		struct file *filp = vfio_ap_open_file_stream(matrix_mdev,
+							     &vfio_ap_stop_copy_fops,
+							     O_RDONLY);
+		if (IS_ERR(filp))
+			return ERR_CAST(filp);
+
+		mig_data->stop_copy_mig_file.filp = filp;
+
+		return filp;
 	}
 
 	if (cur_state == VFIO_DEVICE_STATE_STOP &&
-- 
2.53.0


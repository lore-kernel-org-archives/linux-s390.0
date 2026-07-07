Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE72397331;
	Tue,  7 Jul 2026 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414965; cv=none; b=AnPapFsburoj62RSTXzaZNFfnt3JzVPvi6O93pkMUy95BynOL4Vh6HKPEdsrG/usy2j+oty4Uxl5Vn0PsPNUg/3hcsaLNDBAbjW7EWzrmrXEYqgKmyVEyJge8XWn/GczNAOzvjV95PvoIjHLfMsbMb1t5P8D46oVxGbCtsxEIDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414965; c=relaxed/simple;
	bh=OdqDQIyJUNyeiQk0YKbLdjkkoSz7lXpRzWnREuRpHYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDyTnHk1ujBjHsQ6thSJSfxLDHjvtPrSybU74wKJ0i2vufUMjH4gBz/g77jzp/aHPHHVtbvJ2h5WR+JLhiSyTuWW4jJG/P8B2RFcCwbcA6lt4SV0nRwb+0xIOMRH5eaVthkwT+DW3sJBOAkRifohlJKzUxkD34STOfGfIBuU3qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=knxgT/I/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="knxgT/I/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678Ib4d2274352;
	Tue, 7 Jul 2026 09:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0iViiVnfvEWz/8TGc
	j71FDMpNsAA5dmqrf9/yAknPoA=; b=knxgT/I/e1s89jKScmdsTvVvCGU/zeNXG
	eZjZ+keN8+FiBCI46YN776Wc7+Fq811uncUb8lCcFhAaWFINOLzv9IkxLlBnCHo8
	ze/Ho02TTdS5KYHwChPR4soNyqhB6OKisnHYblF3lmFl7bwyEY4/h418gYHuc77M
	H1BJhZNQ4lIGEu5T0p+xwjaM8tG7g/pJOPm/Nxokok9TnofUe7O5MowFXgMBbc0N
	pQ0UAAhYOiDmmFyKX2fTWJhdeWEavYPv1QkI0sgPArSmdC/p1DcrAAD9E//mJCuf
	VUbbLZqn39P+PcTIFMqHUTVHo3Mk7heCLbqPO7P5be0iiVvnnVf6A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdprsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6678nZPL004345;
	Tue, 7 Jul 2026 09:02:37 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6y1m5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:37 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66792ZM77602860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 09:02:36 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD38158060;
	Tue,  7 Jul 2026 09:02:35 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86B5A5805A;
	Tue,  7 Jul 2026 09:02:34 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.160.85])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 09:02:34 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v4 06/15] s390/vfio-ap: Transition guest migration state from STOP to STOP_COPY
Date: Tue,  7 Jul 2026 05:02:08 -0400
Message-ID: <20260707090226.3206695-7-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4cc0ae cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=_8NKb_9EqzLue2x-dRcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfXyEpYX+IjkeNq
 VcYlGWZgQv6CDdfBjU5x49aWEUg4FOyYGsT1THvbLBXx0IlgsCxn+b1I4dtZ0/z6mKYlvZ9FYK3
 S1VrXFAsP76UyZvPwYRRn8Yq7YvbZ6+1s+7E8uw3vl8FHivKnaUaG2ADCtXe1yY7Wj2nXsVcUln
 Wjem1UAsKrSt4m3hhZWMl5E73CEZttSrVOBphgTvUVwmwHYCkYOXAzYyxufr14fNfzCMp7hj2YX
 hPZdgSjdMc0VGr/fsgBTOVhIlPsgbPtY4azzCz6kkkKw5Yxt/Yt+mTc2DcHesCajeTc1WY9sccQ
 vN+FPnp/9SZIeioI1mz3W5SQLxelCh1OztXjEyKaDoa+jGzNLlVZbrkU+/hibFM/8UUxhkk4c4V
 Xgomq1NL0Bzvt6w+RSKibKioJ1sDRbGUH9KHii4qzhs9BBcomNSWpjTz/MEYf/H2Wur4RkYb+P7
 62nwdy5JC7Gx/pMIYGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX34ntjRN1jlEl
 fbmk4kc8sSD/S9LXhUsEGtQGRniNyc8z2BIUaXMZXYdu3/25971ENrboGojd5YJvY0B6D3uqDU0
 vjyvx1wh9MmQ9BUfRGo21RMhz90n3e4=
X-Proofpoint-GUID: h5AjV6In5G5LHOVoB8VvrJvQGvS_ntfk
X-Proofpoint-ORIG-GUID: h5AjV6In5G5LHOVoB8VvrJvQGvS_ntfk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070084

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
 drivers/s390/crypto/vfio_ap_migration.c | 68 ++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 8274e7b65eea..76e06abe5a9e 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -4,6 +4,7 @@
  *
  * Copyright IBM Corp. 2025
  */
+#include <linux/anon_inodes.h>
 #include <linux/file.h>
 #include "ap_bus.h"
 #include "vfio_ap_private.h"
@@ -57,6 +58,57 @@ struct vfio_ap_config {
 	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
 };
 
+static void
+vfio_ap_release_stop_copy_file(struct vfio_ap_migration_data *mig_data)
+{
+	if (mig_data->stop_copy_mig_file)
+		mig_data->stop_copy_mig_file = NULL;
+}
+
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
+	if (!matrix_mdev || !matrix_mdev->mig_data)
+		return -ENODEV;
+
+	if (filp == matrix_mdev->mig_data->stop_copy_mig_file)
+		vfio_ap_release_stop_copy_file(matrix_mdev->mig_data);
+	else
+		return -ENOENT;
+
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
+	filp = anon_inode_getfile("vfio_ap_mig_file", fops, matrix_mdev, flags);
+	if (!IS_ERR(filp))
+		stream_open(filp->f_inode, filp);
+
+	return filp;
+}
+
 static struct file *
 vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 			    enum vfio_device_mig_state new_state)
@@ -70,10 +122,22 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
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
+		mig_data->stop_copy_mig_file = filp;
+
+		return filp;
 	}
 
 	if (cur_state == VFIO_DEVICE_STATE_STOP &&
-- 
2.53.0


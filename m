Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9237E3FAE00;
	Tue, 30 Jun 2026 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816110; cv=none; b=fIXWFtJKfrLOq1QQLRVnFKjZJhHB3KZO4gvMV9RzBKzEhzaZr7tuGIDIQzT0xKvH/gOedhS48goKI5NlQfO5mPC9npOuPEGnkh7g4rYsfqzx/VWICxOMKjafid0Jx7jkNMXhXzIDbOj0PYiErnhFKtWad/oGCc4Y0Q+5iXw1O3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816110; c=relaxed/simple;
	bh=OdqDQIyJUNyeiQk0YKbLdjkkoSz7lXpRzWnREuRpHYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4IA0Um6Pn+DzWBwheBoTxpZ6OZMHYN8EBWXdK8ysieAtgbcE1WAWrLLMcWyGyC8kt5mKSIXMGyfMZv35gxZ7iEMQc26MpK1sHG4+BiNeo6Hp3/a0JxtiNQvZoHCkf4gLoneppOCbmh8Rc9tf4/lroc6nMbXYcyEhyXknUKHbtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YPDXyzjb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YPDXyzjb"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nDQw1647884;
	Tue, 30 Jun 2026 10:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0iViiVnfvEWz/8TGc
	j71FDMpNsAA5dmqrf9/yAknPoA=; b=YPDXyzjbNwSAdvCw7NgCbfFbnG9LLmqlm
	royBPMpC4rashx3cwbEGq47KhsPGWjJ6uB0H4Mth0i+GBBA05mNP0NUtCd0LjkHF
	wGl7l0EBwds8gHwaHViJkP4Lu3OyDMC84zYnLtVUQBFubsOnoMeGYc/JQunMQWfV
	yVU7v9NPn25mar12TpcsKDwouWv+tcUfPdq8dVP2UYgHjYLBvE+DOqJHbTA4wnRn
	j27uojS5f/u1Q8irFb+oOR6vyz4kliA6ju+Xi3A+fbBOYFa/hGbJfwWtRhhaMtuU
	rySykCW5C31vDRjRtblaKtgDVayPtQmTph6wzvSgmkskV8QUaotiw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5p6tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UAYhk6024622;
	Tue, 30 Jun 2026 10:41:42 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruq9wd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UAffm325952782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 10:41:41 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14C485805D;
	Tue, 30 Jun 2026 10:41:41 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 133B458052;
	Tue, 30 Jun 2026 10:41:40 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.135.84])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 10:41:39 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v3 06/15] s390/vfio-ap: Transition guest migration state from STOP to STOP_COPY
Date: Tue, 30 Jun 2026 06:41:16 -0400
Message-ID: <20260630104132.1598851-7-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfXyWM1Ik2XTLMn
 QjIn1A8hwYP+VhDtZKVxqWbt7SzGpbykOwZGXi6E5JlWKxpVlgDxWHjxPZcKbwi6GwV53fLVxzE
 VU4toqZcQ8nyZKDO3NxrqifWOgYkTkrLyENx7qgJ7VcK55QpucrgdIW9m8BnIyz4SwcqPDqg1Wn
 O/lffBhJ0ZqWqaiHyjL9cn/2SZlccKVC9g7xpAg93sSrLPR26X0h7B2r8rxO/XossWJjn8oBqyo
 KIwFFYNmQocGf6M4TX/gN7O5EfCDeM7sApfqiK94p58Wsd1mh+ULEPowOQvjPAzwONvhIF9Hvii
 5uVpLrxHc/2nGA4L0GnJnf4JLc1oi2ZJ1WfkWLBjWwbXf0dKBnMqIQyHz9/0YjpQwCGvUIrVyhu
 2d0/OFkpMNAKD2s1EbJm915P9EnhHB21kXYmW361BdPR4LI3BEv0FnFd6hiVuRLE8lzN0wlUinF
 70H1lNHDmgVhezRVzfA==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a439d66 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=_8NKb_9EqzLue2x-dRcA:9
X-Proofpoint-ORIG-GUID: jWO9F2g6AumQt3h57hxdZ-ikQwHEipC6
X-Proofpoint-GUID: jWO9F2g6AumQt3h57hxdZ-ikQwHEipC6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfXx4iKMmmkvNrZ
 c+KdOoZrEdytvzDI8kwtmgUYdKj3Pyrbps/GdlWv2ygcPL9ClmZDAcbRgGCWGVCPIndtQ4FOEx0
 BMhQxAyXg6BfEGVxOGTCuVEOzv3DvzM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300093

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


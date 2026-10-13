Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4A5326CC;
	Tue, 13 Oct 2026 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905562; cv=none; b=bqW8BQf1oLqcmhILN6siwE25CRkFNMUNVwHBaUFq0maoMhN8HIZWs8lNs0+fq5m/Res4/HNUIW39al/rNiWnqUnROewT4UHwwWWamVkZAJ2T3TW/oYLxEh4YV5ETX/z1Ow+sVgyI5SNUG3WlAumv3wiHOjEfXJSza6FiUY47R8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905562; c=relaxed/simple;
	bh=HfVaWaCCRYVzV3yu2SQGURrbMHQv9cLUUnfORCG+m9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5xQPBMq/n3TELh9o6Abzp48rVvljq/aVWMGe0AnFa9AyGnAnHbv/S80t72jUfol4leNaVHqU3TdZZt0qN6z30yDaibWPV+tBNcjyjWioAitKGz71rbFcvvDIKgmCyTauug/TFiIhaHmbQ+uhbCesQ6s7Cs0wruPedGJTcyZPkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r3EjFyAC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r3EjFyAC"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDl65g151539;
	Tue, 13 Oct 2026 15:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=S9j1acRwQJIMtLbnk
	lgGhItafcdOabUOZYRhPNUXGtc=; b=r3EjFyAC7rDf8gx0383onMCkvQ6b+Y2dn
	/2CAypfKcdy1RGOfdF0hxFsX19AR+fSdP57UeMOzdxDSu8qayeySivfZVUV/3QkT
	79g6MdkxhvTrTkzdTpZr54nwAI4pg4phktnIOqP1Yi3jQlLvSm8g9XJVt5MA5TlV
	s2Dj9XWCCTRxGjI7BLycglpxT309mJBaRK41UmqLeMBdkL8B7XimHQQQiyuXOvi9
	AEKy/3CU6gxqBpG0oYwSk5Lve5Xc2OsEkzRT8FpDpzNlgHLaMQvWrW1rZUjr5ef8
	afImBzOHUO1NeSe2thFq1tL3JORPCa3EZ1tuelTAgXtHYP+62uMRg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhf2ub-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DEL2213149863;
	Tue, 13 Oct 2026 15:32:34 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9pb3gbf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DFWWI611600410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 15:32:33 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA49958065;
	Tue, 13 Oct 2026 15:32:32 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 297155804B;
	Tue, 13 Oct 2026 15:32:31 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.17.246])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 15:32:31 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v9 06/15] s390/vfio-ap: Transition guest migration state from STOP to STOP_COPY
Date: Tue, 13 Oct 2026 11:32:10 -0400
Message-ID: <20261013153219.3534306-7-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX4unCtje3hgSo
 Dvlcie//X8acI1jYdcuaD99sv77C8sS7uIMMYJVRdh/tML0O1SHk/wk0B8IbltB+I4m/RSCoRtV
 Jgk6E+OIcSn0gFKwI7fMIL9KHgh49VA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX+TTnScljle1L
 aEKPbz1h2s1ZiT3jaBbl/Lk5E7zdghLr3tD5RqAN6Tpvxek3cHuBsRNl3U6KeO+aZ4/E1Pev0WS
 zaBIARdg3aLf2qa4Dna6mgNqzzjE4sUqMuUDm1qIGX1cpmjpA8LWtiZI7Banct7pCcUxytMIOYD
 bjsOfB5ouqs1U/CBLeSPxYoN1ryD27kdHtwgSqqHqIcakdxakKf6BdMauMY4ALi81J+9bflp9O+
 G6Hrvls3OnBuG7euV8kkfzi7PpWge4LXxe/fdvkWQaYzHBbU6XEPux5RhhwupMSIi6bc0JJNLsS
 81dquY0Bv57ogItOVFBXBZHF+mnflaV2Wp4Cj5E46/B0kcAI7jpFU77uVA79GnTlJtPWssbLBAd
 iB6oe9r4D8Du/6Gwa4bpA5Hnckxdc1EJ4g28JpZ77Xp+UYTBOvMI2tiN1I8vkBr5kLeGhhXBaUY
 oMghPXrfGhJ9pUlKBlQ==
X-Proofpoint-GUID: Q9djTVtzQ-v9SUlrrUsqmDy353QaEu5g
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ace4f12 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=_8NKb_9EqzLue2x-dRcA:9
X-Proofpoint-ORIG-GUID: Q9djTVtzQ-v9SUlrrUsqmDy353QaEu5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130060

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
index 95b1f0ccdff5..bbd007c06a77 100644
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


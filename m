Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425009;
	b=XtXplU55Pd/usU8jVzMkZ9NcnguMy2PfjqF0ipxygJffUPE2YC3644rWLs4bnaxrys6r
	 Q/DcncWUP+fpQV626eC61cDiN2Hupru4W7gDqFPeyTO1MJq1x36VvqwAiataT4RWFnC1f
	 eqCI70jviaZNtw5zxo1Zkmr2SptwP+qS4AjVD01Wu7QojdRk0mMYDDcdI43XvIr1/V4pv
	 k1ZzAz2P48Sf/Ox+bGueCyYpdcpwEec232qnryqwMuAnQMoGwnBea7ryrCTJwz+ggYPSC
	 aBVksHWyipMdkPBwgJRZxWX+CmUIh/d7dc+X+pxisWcwxKXIjpFAiW/OdNRK8AC5jLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425009;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=sr63zLlwpXEgfAJgCIgGNL3xTrn0Yob5NkhYwmpMcVo=;
	b=4FTVabsSLmxSLSXzAgPl5CSpE+revzPMFD5Fm8b2Oes4EP6mNIxsM2opf5Zi27NxHamW
	 IVD6TRfLgieGBWFqncuc8m8cxI5euZu0ONgNKt7zXTNH5NJ/+38ZPItqS1sJc3UXQWhVn
	 Blfjssu8kf/Xf7+GZyHXCPQV9vZlCfCWWWkNHh03gMgS/Hjg7YGUoocSf8aC6iuk25hvd
	 8w5YMjOWTx2S+ykjxn8PxFWfn1hjIUsg3/gwEqOMfh8ua5NbSm3MmD1WDi8J+BRguaVOk
	 /K/oLtoFu45+AeUHOguBPHfW02NpJbGlFbdGP/w+/ZaZhuEtxoZoe4fBgxnHYoaNgPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M0b1a43k;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6855606A324;
	Wed, 11 Nov 2026 19:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6855606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M0b1a43k
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIiPo51829105;
	Wed, 11 Nov 2026 19:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sr63zLlwpXEgfAJgC
	IgGNL3xTrn0Yob5NkhYwmpMcVo=; b=M0b1a43kiLUy26OVkBNpSq7VTuWYAxB9L
	rRelHFmrWhYYHsFn2DUcHa5XQ1EH75fSZHjJUYfmI6OjInR+XW36C6Ef13KYfneO
	4byDGa6qJWOW10lp+Bbf570C4Nz/IPrQeUM9C82e0eER6fO92+oLpLkVMAmhRSbC
	9FRlpXVptRW6jQcLJfnZ18W7goDX9s74+HNUFsl6iqenkaJj4YhSMlozyMRQ5izK
	J3KQL7LEZZr2F6GrJn42HypD4mtPb5ngDElfiP9q/IcQx7iF5LEnm+k1y3nFt6b6
	bjJUG3M6X+n5gUEs8SJmpvAs97xqs02iqJ+GxfHzyybGurM5EqZVA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkuuxj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIZ29K3727801;
	Wed, 11 Nov 2026 19:23:19 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv309nuf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:18 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABJNHBN64291126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 19:23:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2083158052;
	Wed, 11 Nov 2026 19:23:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F04E58056;
	Wed, 11 Nov 2026 19:23:16 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.62])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 19:23:16 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v13 06/14] s390/vfio-ap: Transition guest migration state from STOP to STOP_COPY
Date: Wed, 11 Nov 2026 14:23:00 -0500
Message-ID: <20261111192308.2585984-7-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af4c0a7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=x8ayjDA-IaEv8FOIkm4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfX8GgJrKz7pb9C
 uB6/HFvrleiAeSrmCA7WXmeAhKFzjUKBFPdPF5WbQ0hj6roe1DVWStz/5o9ZDWtPRuoGxyfMcPR
 mAoVypaJ4e0HGHS1BqV9i1zjnzJEhdtl0I5Aw3mVz1v/d+HMwL03YM4sTIjBDk1So6mbFZqUOTZ
 Yefll6yVhkpm/2aAapdeCXrp6USyKf76jRh6XmO/n5lbbb87akBiZX+mn4zisOd4GqKjjOx8v7X
 cepZVoLovjjwS2YzbnEmz9PxbrNLcym4vh3C42HPDxPKxvgpLI55fxngSIjlgOn/JIN6O+Au4mo
 ho0Cavnym8NDaw72OQDKR5/g1dME87MqyAQHKZ4PgHckWGVQK+FSnw2pfet0J6fdLJgVA+w1q4X
 3gws8NQK3FHgtTsD0ThSJDHCC97n+JY2GZHL6YaHrRUf5Vrflf3zGrCCE1UyFnp6XuPIJcIwkXn
 gGSHa2qjjK7NZW8AuZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfXxjgy/NUR4Tk8
 j9Kgb5XEMsPBGMWA9b5zkf+k6C4KKQRj0jWNKTXRpM8I+rgYsFfoyUtb0g8yLoL/bNpJ3+hbjCt
 U17SW15bNXAKJ7r1D+iP7TAIJfKfr2k=
X-Proofpoint-ORIG-GUID: xdlv3WoE0Z2-8ZAitFh3XIiGkLnW4DZx
X-Proofpoint-GUID: xdlv3WoE0Z2-8ZAitFh3XIiGkLnW4DZx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110076

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
 drivers/s390/crypto/vfio_ap_migration.c | 74 ++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index df012f80ed0d..3b5c60c1ece5 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -4,6 +4,7 @@
  *
  * Copyright IBM Corp. 2025
  */
+#include <linux/anon_inodes.h>
 #include <linux/file.h>
 #include "vfio_ap_private.h"
 
@@ -143,6 +144,62 @@ static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_dat
 	mig_data->resuming_mig_data_complete = false;
 }
 
+static ssize_t
+vfio_ap_stop_copy_read(struct file *filp, char __user *buf, size_t len,
+		       loff_t *pos)
+{
+	/* TODO */
+	return -EOPNOTSUPP;
+}
+
+static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
+{
+	struct vfio_ap_migration_file *mig_file = filp->private_data;
+
+	/*
+	 * The mig_file (and by extension mig_file->matrix_mdev) is tied to
+	 * migration FD lifetime (see vfio_ap_open_file_stream() function) to
+	 * guarantee that the matrix_mdev remains valid for every read/write
+	 * operation. Let's drop it here since the migration FD is being
+	 * released.
+	 */
+	vfio_device_put_registration(&mig_file->matrix_mdev->vdev);
+	return 0;
+}
+
+static const struct file_operations vfio_ap_stop_copy_fops = {
+	.owner = THIS_MODULE,
+	.read = vfio_ap_stop_copy_read,
+	.release = vfio_ap_release_mig_file,
+};
+
+static struct file *vfio_ap_open_file_stream(struct vfio_ap_migration_file *mig_file,
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
+	if (!vfio_device_try_get_registration(&mig_file->matrix_mdev->vdev))
+		return ERR_PTR(-ENODEV);
+
+	filp = anon_inode_getfile("vfio_ap_mig_file", fops, mig_file, flags);
+	if (IS_ERR(filp)) {
+		vfio_device_put_registration(&mig_file->matrix_mdev->vdev);
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
@@ -156,10 +213,23 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
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
+		struct vfio_ap_migration_file *mig_file = &mig_data->stop_copy_mig_file;
+		struct file *filp = vfio_ap_open_file_stream(mig_file,
+							     &vfio_ap_stop_copy_fops,
+							     O_RDONLY);
+		if (IS_ERR(filp))
+			return ERR_CAST(filp);
+
+		mig_file->filp = filp;
+
+		return filp;
 	}
 
 	if (cur_state == VFIO_DEVICE_STATE_STOP &&
-- 
2.53.0


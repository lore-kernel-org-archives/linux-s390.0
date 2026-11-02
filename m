Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632581;
	b=HO74bztd4gd77tLiq7iZBZ2zAIz+kp98XZp/CgzmZD/mh346ClEBnDdL5cM0kbCzhriq
	 rz0PnLF1Bggl2WepodgCZfeUuXl3DUN33wySxpGXx5YMx+e2WaRbXcfCQFUsir1Ga7sp3
	 LtueIVgJi86KTyMUpKU5GkbQlJvkFmEVdMFaNyRS105phCbkCch2xcpdR+9Sv8dkmHd8S
	 t0c06HPFuRDh6KGl4VzfS/BQAKTvRd626g+3OOKT6lV3HjGNxoam925PKApIajSvkhpXs
	 lUZOeNSdPypip6+4+ef7f8ict72CnokUfchpGlHG52zIRMvdEOg89iBjUZ97VZ1hYcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632581;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=trDsFF3FqV7EtFmcLlBfwlMrkJnyh/ZQMDB80qK/BMY=;
	b=Ga/gr9WJHEjeHMNARbxTOoEr5erRXLoR0hVx/8iW7aiLET0+sZThyDWIYvVoTKSRDaOH
	 Ji3Sei+vUo3sgJW9S1afa8UPh5IGsOz8zduHqe2DcyPA3SOWITq4n/UfFkYFyhGLfX7kn
	 DMKjESPrFFI3K0vYYDlKYjHuSVGOdMVM6ADBgLA9zKpkWcYvhJEZuVTAkEicFWNPIB8jt
	 j+04rzTBIhHhXC+Xt/cQvlsprWefdt8cC0kBumHPvYljG5aa5V65Ps6T2ylSwQ1orX7W9
	 oSfOK6SW7arGxGR+osPSz5uwnoSOjdc4pyFt7Kk0/bSwEdrbo3D/uE+mhlF8QZYIkxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MWktIrJ9;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1350C606A5BE;
	Mon,  2 Nov 2026 15:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1350C606A5BE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MWktIrJ9
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2EEAHn1949776;
	Mon, 2 Nov 2026 15:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=trDsFF3FqV7EtFmcL
	lBfwlMrkJnyh/ZQMDB80qK/BMY=; b=MWktIrJ9wsifZantKW/w9ELwjAVy6FTNG
	6UILNcKUbhXsy8uw/lSLjqcd8EQX7OSwoYviJ6BmJiJwJtCQ6lPR7eQN+3gErz/o
	Odx9otwlzoQUBDBoy8iaalrowIgAIDqhwXfF4n3XXEtawgfSFExFURLltVepmwH0
	IoA39uQUDn2qSUiu6ejn52vxvfYPViOZdNuYJqy4p3ZnAmF8AmziwjMxTCwX3l0/
	DUy2kIY5Brnh7sZBD28XRUQ22JUu7kKA/lhuNS3db030bBsDtVcipURdy8HQZEb2
	vwR6l9sdGp3fwsrbGblELkCrPaJ+nmZcBXqdUCaTwOaKG989xgkwQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rd19eu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DpOxm4016043;
	Mon, 2 Nov 2026 15:16:16 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnvvfpaq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:16 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2FGEfm7078594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 15:16:15 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB3DC5805D;
	Mon,  2 Nov 2026 15:16:14 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8761B58054;
	Mon,  2 Nov 2026 15:16:13 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.57.150])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 15:16:13 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, freude@linux.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com
Subject: [PATCH v11 06/14] s390/vfio-ap: Transition guest migration state from STOP to STOP_COPY
Date: Mon,  2 Nov 2026 10:14:46 -0500
Message-ID: <20261102151604.2150055-7-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
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
X-Proofpoint-GUID: QQ2CpvK0fHAikVCRwR4HUjtQuB9fvvPa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfX+gi3hTn6Mfiw
 VmWkvmWG42daKpsktvoD6XVba++7AbjYg9aGSqJTY7E5/PX010y4dool/GNLKNQZ7bQ1DhSv831
 8+8pDeMVfG/SpfEsiAon+lgOGpLlpzhyn5dXX/CtQMz8yhGUyC2/lMkAonTePlg/Jj73dm+Duzm
 UU6t1hxSl94k8H6DOOApdtq9LvJtGKafmsZbPZZYztzhi+ORQwJHgrfoE94BwCHLGE9Bjzh9eRb
 s8dvAym6vyBEp1vd+G0t6pO8QGidX6eT+5NdjR9/FerX6KbYB8rEy8qxBb7PCkq6pX4QXbz6qml
 nljQP3+eWBYzyaq7V+SBR+F43rDFHl20xr3Fp/2MTrEDBdqSTQ+ZZOOhc3XseaE6FaqQUp6vQVD
 LyjKAa6ol9Oi+PEDkHUPl+ELrKM7pPu3GJ+FASMo4Pic6R2OTyF0S69B92BaNXL6djNt/OORbzt
 M9yIU/CPWPhOu1YeuPg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfXyvMVJFAsdLgX
 WqnHuz9t/J8mbAm3/zWXOQ7pnz+mOXyBnew8qH7Kxj4zUB/jwxH/5FGoQbkqHBLIDbKaDS4KF9K
 WEghKwG+9PCS1bWw/ZMSSE67RqojvOo=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6ae8a941 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=x8ayjDA-IaEv8FOIkm4A:9
X-Proofpoint-ORIG-GUID: QQ2CpvK0fHAikVCRwR4HUjtQuB9fvvPa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020060

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
index 8e4e04e03965..48028b12b26f 100644
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777453;
	b=PcwLVZ+1tTyaC1GQNuu34Tr9DVfTnmhDiy43V7YbV3UP3bRzSn0vxEBc3JFlPFJzWgAs
	 WXxOKq1e8/CZnR7q/iIunePBOv2B8b+xQmsmGEkH7aAN0gpHbp7+pHJt28KUu1ENh1CsS
	 wyibQ9MIJuYrPB5q1IuKWZhdgY63R34gKPLGu9ThXwRo7vxxUJaiBZ4x+AaRPiVvcoiDw
	 CalPLmj0W6Bda9VzYTvwU/zeR4e10QgnFno2SfRyo4uU/fzTjlmBd42Q8l0kFF748y+xG
	 5mcs+wc/xdZ9qynQlpcl4hv79K80zgHlbi5XqgLD/91eg10CraCABY3dQcsmFzO7MPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777453;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=KEDJhoKRCmio9bwyRb2Sc3/hZndPNDYUKtOYCD1jy9c=;
	b=2ZlT87p1gEiwfFw/tTjXI1h7LKAVoX/ji7T+tW0UlsQQUzq5uFKj9aPL2R90rjBBloc8
	 WuYde/ZQb35GG5nQMs1pWOW9hQD/wgx1AKubb/eX1lIwbQtYxtFEm0he/eG9KIep+AEjy
	 7Gd8GWzCCdG6+/W3i6fjIFzVwqTnIM3EufJYM90f3KKCEln+yRWO6nCERu/KFKK8+Z4pR
	 zm0PiGI8GJ3427y6mLWja7HDvNOIeGVjkCziJTNbMgw/TyLt7hpB77HJec77vo5egNjuO
	 XN1u0BWyTjjPwGXZYNLHA7WSCT0Sc8c+cCQuiJRtomFsPur7p2Ntn0gSo0FgeL0gchQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZY4zmbaC;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90FA606A322;
	Fri, 23 Oct 2026 17:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C90FA606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZY4zmbaC
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NGoYrT3668765;
	Fri, 23 Oct 2026 17:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KEDJhoKRCmio9bwyR
	b2Sc3/hZndPNDYUKtOYCD1jy9c=; b=ZY4zmbaC8/w8XiHCmSLj+qikI9saMwJ6k
	ajFs5KvoC5t61Ay+b8LAnyAuZnQH5Uf/oJL10jJrDyLUNcldvvd4elkfpbtIrrdQ
	9V9yi5NOK1QyCfA30syQvRvVO+4eUTDj7YzA0Urk8du57olnlJeib6I6riUyTRyJ
	lpGYpqwFEuMzOJEbDcYcr98mP6y0mlyncMvhQLg6EZGvi+PjcbU0/hgZQKqTEF+/
	3In/LMk9JfR4tdNrU/gp7tPr3fwre3vQrJl2nIDAVHKK616qI3KxTylBLMv8qZXH
	xNXyZFFEzbYs9zB5lTslm1ZxrOyBglh6RuMrWXiiFxlY3abHJrExA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw596ppj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:44:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE6D6E2221280;
	Fri, 23 Oct 2026 17:44:03 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfj1x6a2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:44:03 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NHi29N30081722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 17:44:02 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 278D65805C;
	Fri, 23 Oct 2026 17:44:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8945D58054;
	Fri, 23 Oct 2026 17:44:00 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.48.60])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 17:44:00 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v10 06/15] s390/vfio-ap: Transition guest migration state from STOP to STOP_COPY
Date: Fri, 23 Oct 2026 13:43:40 -0400
Message-ID: <20261023174349.3545941-7-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
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
X-Proofpoint-GUID: q693BX83GpB4bpiyblY1OrEfZECyoYGj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX5dEJgdg/5J/a
 63btKy+viVQpbf90hDIKgp3xK8jbMJnYKowjblzwPbGmJldP8woOrXp3BUfAP4Q9Ot4euXqRXBd
 ykCOJZj91lxM4B1W7xg4G4jXdQJkbxg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfXzaVdNgDbdxSD
 m76x2jaIe707ICGVXDyA2p9GSaCPFCfd7OG84X2EcIpcSZdeebV8Jnuj9+uVlsCE/ULrLLiujMu
 /TlIXBLSv77RQbEp/l/j8mHNzgMB+dHAUtDHV4+SsQBAL9I9OwJunrrUMheKzKTkQ+9aNgRr85A
 +vBtKS2FVHM/sXA0eQelkM89l0s5fEeC0qnw9jfpuYHDWKbdYvwlNH9H4cbaKnMtWYXHiCWda1E
 fLHXMelSOOom8dlFzKK9jcHFdT/HYNqQLiTwUca/xQwMrNEtk5i6l15UpDgMAlmkUz3tMBfxafh
 Re7QJAZW3nVjMB6idcePliW4DGohN3MpGOcaB6Vt4Pw8xSgeAwBVtDSHAO/MwgrF2INFtl54rjE
 Q2yYfzb2Qnq0qx5rvb6v/UxrOJpmDnOM3v9FH3mtSUbK0lbI/njLqp4GHTFBUr/gj7d6cneh1HS
 9LhiQaGqXdjENfrMbfg==
X-Proofpoint-ORIG-GUID: q693BX83GpB4bpiyblY1OrEfZECyoYGj
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6adb9ce4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=x8ayjDA-IaEv8FOIkm4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230069

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
index 07a4b5c1d6dd..bc216c51a1a7 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -4,6 +4,7 @@
  *
  * Copyright IBM Corp. 2025
  */
+#include <linux/anon_inodes.h>
 #include <linux/file.h>
 #include "vfio_ap_private.h"
 
@@ -139,6 +140,61 @@ static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_dat
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
@@ -152,10 +208,22 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
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


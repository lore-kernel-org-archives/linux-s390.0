Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B883783C7;
	Sun, 26 Jul 2026 04:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785038511; cv=none; b=Urckfd/ZTCswfjw1Xc8UAMVy9aDcftIMABj1yZj2Nm8RkyJDSxar/vU0CXB1+rYc6CX+Cb908iNv/rVcsxc6gf0KBEjQUiB30uaQp6Bg+tThakILm9lJ+/4B6o17SWzEIDiFU+hcb4tuwoNUNcdEtK6kXqqYmsrPkqXV/NPY+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785038511; c=relaxed/simple;
	bh=MhZP+ExapMndEcJ7FnnxrxZxP7LObxdIWgI1TyHjyNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSPe+o7cePDzQQF54wXs0exGDuN8Ih/x34s9NThX9HiBN9tJMolZSIBrWcIeoeIfif21s+8gZpd0CDrJdR2OMJWEAENTTdCkO2slIZmKVjPFRdCiwrhEKaVR9UIEjaHXQI3TsvwPfe9SEhE6yPgwThju5Si9TAvdlSbbvv+FFfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=arcQ7yOh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="arcQ7yOh"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PNHfAo1938390;
	Sun, 26 Jul 2026 04:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=x4lpqNOAqdwmvxg4I
	fxoTPAN8S+mdYoMzkMlHCCSKOA=; b=arcQ7yOhIM4UP0VTiHGFodKNkMIk18D+y
	oPTExBARSm9owOB4vyBjc/qproKrQy52XjZQnMQ55ihzS+f76bDSOcHm0hMThMPC
	UGrGW6dsWv9HZlc/pglBod5VMCC3l1Yiy+LoYubEImEqM33d1AR2DFRV8WvvA37U
	qAm/6Te+WEefnAuV/+silYKzBfMxQmy45NkSD3heWCk507hnLTxeUg2iuY++OU7p
	cjgCxAuXgZjeA3nV76fiusiLwvzpZbiy5ygVsPF39zZOrHk0CoQQvQSPB61pCG8U
	vElS3v7w7R1Z2AjqGiEP2TOwFBt72pFoalP4iK/ru5XmlRh0CKtNg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xabaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 04:01:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66Q3ugNA006085;
	Sun, 26 Jul 2026 04:01:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg054h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 04:01:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66Q41Wfr39846330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 04:01:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99B60200CA;
	Sun, 26 Jul 2026 04:01:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A947200CB;
	Sun, 26 Jul 2026 04:01:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sun, 26 Jul 2026 04:01:32 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 27BF916281A; Sun, 26 Jul 2026 06:01:32 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v5 06/10] s390/vfio_ccw: ensure index for read/write regions are within range
Date: Sun, 26 Jul 2026 06:01:25 +0200
Message-ID: <20260726040129.2946151-7-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726040129.2946151-1-farman@linux.ibm.com>
References: <20260726040129.2946151-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zn8uTKd0k1JZaJM1Y3OByG_YmCW6Uev6
X-Proofpoint-ORIG-GUID: zn8uTKd0k1JZaJM1Y3OByG_YmCW6Uev6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDAzMyBTYWx0ZWRfXyEf+vXkLmVeK
 Zp1RyUddA67QQ9qzcrN5Xk5W7D/j+GkarFkZB+ZGaUCX0UCWhyuoQtGli4+Y1w5TRKeNFEdHHNH
 O2hWVbTjZLDjcxvxmJiV8ctdkeoIv1k=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6586a1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=jUipGm6kB3s0BbMcHoAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDAzMyBTYWx0ZWRfX/I1XOsrmDC+/
 8v54bKtgUmGMWtWx8sXT9qr582Wp7TUTv6nMznonHC1lfJcSfq+aYjMRQTlfYtso6m8SHnnS5Ec
 p/rNxQpIo9Ytf9aa7BfDiOFELvDuTFg9FmTjulCmOMTfWjpjDSL7ZC4+umKYkfQdAWg/dlqnmZd
 aCVCrrvcqPVXJNGCeKai9TbWD4OjsFE/1EoK7LxChDQW3Pl/7iyIu+1umBi56VYDmEjaULq7fd5
 K/yeCzYhozNa+Y6uKLKc3w1HhNCAEsrf0MevUumFe2nh+rIqotLPvw6FKs76EE42bN58tUb27iU
 vAKkFkrdjzGAvgL2fTOLwfWXa47wqcPLz1f921JhHFHHMPGKntLGd3+SeEVYP4nuUVXrlJ1tSW8
 Wq0vNDx53dPqaGlW2z1zZACYhDasLfTQ6a9S45pP/s3Jh0Kzomx/uB7h7MRSKvkdkRpMaFPp30R
 z+yU9/9OGwTWSB9p2yA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_07,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260033

The introduction of the capability chain rightly clamped the
region indexes to the range of the capabilities itself, but
neglected to do so for the existing read/write regions which
should also be enforced.

Fixes: db8e5d17ac03 ("vfio-ccw: add capabilities chain")
Cc: stable@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_async.c | 16 ++++++++++++++++
 drivers/s390/cio/vfio_ccw_chp.c   | 15 +++++++++++++++
 drivers/s390/cio/vfio_ccw_ops.c   |  7 +++----
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_async.c b/drivers/s390/cio/vfio_cc=
w_async.c
index 420d89ba7f83..4aff0b58fa5d 100644
--- a/drivers/s390/cio/vfio_ccw_async.c
+++ b/drivers/s390/cio/vfio_ccw_async.c
@@ -8,6 +8,7 @@
  */
=20
 #include <linux/vfio.h>
+#include <linux/nospec.h>
=20
 #include "vfio_ccw_private.h"
=20
@@ -24,11 +25,20 @@ static ssize_t vfio_ccw_async_region_read(struct vfio=
_ccw_private *private,
 		return -EINVAL;
=20
 	mutex_lock(&private->io_mutex);
+
+	if (i >=3D private->num_regions) {
+		ret =3D -EINVAL;
+		goto out_unlock;
+	}
+
+	i =3D array_index_nospec(i, private->num_regions);
 	region =3D private->region[i].data;
 	if (copy_to_user(buf, (void *)region + pos, count))
 		ret =3D -EFAULT;
 	else
 		ret =3D count;
+
+out_unlock:
 	mutex_unlock(&private->io_mutex);
 	return ret;
 }
@@ -48,6 +58,12 @@ static ssize_t vfio_ccw_async_region_write(struct vfio=
_ccw_private *private,
 	if (!mutex_trylock(&private->io_mutex))
 		return -EAGAIN;
=20
+	if (i >=3D private->num_regions) {
+		ret =3D -EINVAL;
+		goto out_unlock;
+	}
+
+	i =3D array_index_nospec(i, private->num_regions);
 	region =3D private->region[i].data;
 	if (copy_from_user((void *)region + pos, buf, count)) {
 		ret =3D -EFAULT;
diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_=
chp.c
index 38c176cf6295..f3015132d4b5 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -9,6 +9,7 @@
  */
=20
 #include <linux/slab.h>
+#include <linux/nospec.h>
 #include <linux/vfio.h>
 #include "vfio_ccw_private.h"
=20
@@ -26,6 +27,13 @@ static ssize_t vfio_ccw_schib_region_read(struct vfio_=
ccw_private *private,
 		return -EINVAL;
=20
 	mutex_lock(&private->io_mutex);
+
+	if (i >=3D private->num_regions) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	i =3D array_index_nospec(i, private->num_regions);
 	region =3D private->region[i].data;
=20
 	if (cio_update_schib(sch)) {
@@ -97,6 +105,12 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_c=
cw_private *private,
 		list_del(&crw->next);
=20
 	mutex_lock(&private->io_mutex);
+	if (i >=3D private->num_regions) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	i =3D array_index_nospec(i, private->num_regions);
 	region =3D private->region[i].data;
=20
 	if (crw)
@@ -109,6 +123,7 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_c=
cw_private *private,
=20
 	region->crw =3D 0;
=20
+out:
 	mutex_unlock(&private->io_mutex);
=20
 	kfree(crw);
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
index 45ec722d25ea..032a1cdf4df7 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -243,6 +243,7 @@ static ssize_t vfio_ccw_mdev_read(struct vfio_device =
*vdev,
 		return vfio_ccw_mdev_read_io_region(private, buf, count, ppos);
 	default:
 		index -=3D VFIO_CCW_NUM_REGIONS;
+		index =3D array_index_nospec(index, private->num_regions);
 		return private->region[index].ops->read(private, buf, count,
 							ppos);
 	}
@@ -295,6 +296,7 @@ static ssize_t vfio_ccw_mdev_write(struct vfio_device=
 *vdev,
 		return vfio_ccw_mdev_write_io_region(private, buf, count, ppos);
 	default:
 		index -=3D VFIO_CCW_NUM_REGIONS;
+		index =3D array_index_nospec(index, private->num_regions);
 		return private->region[index].ops->write(private, buf, count,
 							 ppos);
 	}
@@ -338,11 +340,8 @@ static int vfio_ccw_mdev_ioctl_get_region_info(struc=
t vfio_device *vdev,
 		    VFIO_CCW_NUM_REGIONS + private->num_regions)
 			return -EINVAL;
=20
-		info->index =3D array_index_nospec(info->index,
-						 VFIO_CCW_NUM_REGIONS +
-						 private->num_regions);
-
 		i =3D info->index - VFIO_CCW_NUM_REGIONS;
+		i =3D array_index_nospec(i, private->num_regions);
=20
 		info->offset =3D VFIO_CCW_INDEX_TO_OFFSET(info->index);
 		info->size =3D private->region[i].size;
--=20
2.53.0


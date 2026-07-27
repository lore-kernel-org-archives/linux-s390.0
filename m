Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFAA3CB918;
	Mon, 27 Jul 2026 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180165; cv=none; b=EQST5poDRcxAk5gSQLnd07pt+jG4w7UU+NCnKt9JDTF1aCSoeQB89tHqczCzaiYilPz/ne7TVjD5FNI/Fg8ae38a+UL9GaORrVGpv4ZgThE8QiM4u1+A0NjoajqzX1k0kKK/V0OLj7H057jwRI8J5ohGW4la55bqbuNS+1m1Hak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180165; c=relaxed/simple;
	bh=MhZP+ExapMndEcJ7FnnxrxZxP7LObxdIWgI1TyHjyNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGpPFWiQsHBN3QRTDmIdmYqK+Q14gZ2bsSSU3sMQf/J7Bd9uI1F2sCZfycXZLCdX3fm5l6z9w6GctwQT9nmWIvSuffC7nggdekgafmg12+U24PH4gVjZ78XXsa+GUYgV2YZAdFxHdFGw8d++rULfDOWBSVeSWPK2zmILUnPwh8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mlgoUtnv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mlgoUtnv"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RIHjwj2876144;
	Mon, 27 Jul 2026 19:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=x4lpqNOAqdwmvxg4I
	fxoTPAN8S+mdYoMzkMlHCCSKOA=; b=mlgoUtnvR6eGTxgjRWFEoz7Lk6/8/rYs2
	amLjQhuljJZhIAlTHe1SH9sg+DUDOWYCGg9lNPWTyCz9afpqcz41qaCg6q68mU1y
	MSIXaUtalsoQRVLhUggvoASZCCZsBbDDzqcRJuhKGBz9KQPzhZYeaM4FPtCIymUJ
	a3LzzDJPDvJJkOgxmTCEBdq9uXECq4DlPPcVKhYR1OMJw9e+CFntzJZHq4KEVsM9
	dBgiHoxvJgeUyebVpkTqHGfW8XbC0KMjlT1CkuuoSy80gYwdDuTCcjK/mWkfwJlO
	ah7NHJRE9QxOH3ZoKGAKP/Nk1YBVCYfRHBgtIui9AqPh6cbDLGsrQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nh84p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 19:22:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RJC79W023727;
	Mon, 27 Jul 2026 19:22:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq6vdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 19:22:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RJMb9q32309946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 19:22:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3840420071;
	Mon, 27 Jul 2026 19:22:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D54F20078;
	Mon, 27 Jul 2026 19:22:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 27 Jul 2026 19:22:36 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id C128F162827; Mon, 27 Jul 2026 21:22:36 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v7 06/10] s390/vfio_ccw: ensure index for read/write regions are within range
Date: Mon, 27 Jul 2026 21:22:26 +0200
Message-ID: <20260727192230.2715207-7-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727192230.2715207-1-farman@linux.ibm.com>
References: <20260727192230.2715207-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE3NyBTYWx0ZWRfXyHcNNcOpk3eZ
 Q6qWg5KHkag3mFIDzPA88UrVj76mf9x9QdErY7TK0bgceyGqPWKLgdXowamTJu5ygSj1ETkwrou
 JTI3Vpvo+sXU969882z7JRx8VHd1Ta8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE3NyBTYWx0ZWRfX3fxmC/SnQ14T
 4v/dHK36pTXBuOpM+0uDfq2QhAViMPwsIg0L1+klTSNwqc5B8OwPXQsctdy8UE0U61itSty77nw
 +OKaWInn01VL47qiS01ZOUoPH+vqzcU2RtRjp04mKrrj3XxM92BR3eZbrshORW+V0ulMc+fKs9O
 nQN2y6wQWccX+EvzSMxMnm6E3UUduu5KwYHjYzaB6p1HXJCuRfYTuV7Zro8N5LjRzlsEIoFzXYE
 GBASziEr54+7X8+ELyVhVbWm7GG6pnFTITu+ggD4xq8sfZFcJF7NxuDZV8Dk4TJv3bCQn9/BN1B
 uI1SpPlIwHrfZ0pNeG999/Am381iw6tngyIUKugT+u9GlK5bxt1nZvcN2s6h55ZI66i3NJHb5A+
 1oKKidH6BDn4M6IYf/8PLSnXsb+EGNbo2p1DHgNTYDhhXkdHelOwNrHf2suLqg8cfCz5rJwY75u
 eAUd1uxK8zKvUSDxS2A==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a67b001 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=jUipGm6kB3s0BbMcHoAA:9
X-Proofpoint-GUID: Ghg3_UUeafdR-oDJkM1KoNNfVAVo7XEj
X-Proofpoint-ORIG-GUID: Ghg3_UUeafdR-oDJkM1KoNNfVAVo7XEj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_05,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270177

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


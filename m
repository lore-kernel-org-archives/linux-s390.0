Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E1735C6B8;
	Sat, 25 Jul 2026 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784993241; cv=none; b=BWsQ2NQymcFfYA64cv7IIFB1f+UlRBtILQQuxvB6imzlSQk0qKjmSjCcE6HAJ8dERadxZWXZzcaWiwcYA6R63pMkP/HcFTqoUWjhwZvfc+CcVwGqWoLy6DNX0fPcSCqkHM0ReX+bbzLlYrx99pnYJLq044XEygOKr9/Dy6M4/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784993241; c=relaxed/simple;
	bh=VJE3ETER3UQdhXEsrcUeepOm+ZXegDKvZFE+vsfZKI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqX6iR75DLNjDrpVpaRIl9GOoa8XMw6dKJIxOASpxSpOVuyftb9xUyorIEQcxzPgj8LHirp2/ZIQxhidYNb/Haj9SQqvyI5Ph/BGZzGCaWdlPW+LtKcIqlsvvVU1GahumGPZM4rBgI/FI1cgRDRk4i8QWEn0gOdgSb8PUkG77DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VY/yQn2y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VY/yQn2y"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PDlXoH792915;
	Sat, 25 Jul 2026 15:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zk/DcfNEEY0QPc9S/
	G2Tvb4Y/VzgS4xcIAJSZytUhfE=; b=VY/yQn2yN4PiBwqw9zEYBvJ0LrPaVJaB7
	XWAGiH2pJmxmlC0GQkKqeSSUAMeUkjeCBWdYbRwcAYlqtEtO3m9OYAeUUh1ih6VY
	IKjawQ3VyQNw3G0pfcQlTgNxTQUJw2BJSwZ3N8KnKV9hYKhBVNa/wVPtiQTvlqsZ
	/3TJR8geXfOpXx1bZsopFCUFINGhfbuSGrkTv5WUlc9qVvgiRCNlpCVbuNoMp5ne
	9/RYZs5NoYiIgMMNS1UvyeeDuTj0ODXl/CNjOLBSn+cheM6jz3UTHJE19OS7ig/l
	2xvnRE4TowRGyxp/1nbpsa8JPcKDCUcZfJPsVH5d+2vAqr7BWAroQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw70kbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 15:27:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PFQEeq032343;
	Sat, 25 Jul 2026 15:27:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn12hp62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 15:27:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PFR91M42860880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 15:27:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D131120101;
	Sat, 25 Jul 2026 15:27:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAA3B20104;
	Sat, 25 Jul 2026 15:27:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sat, 25 Jul 2026 15:27:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 70903162816; Sat, 25 Jul 2026 17:27:09 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v4 6/9] s390/vfio_ccw: ensure index for read/write regions are within range
Date: Sat, 25 Jul 2026 17:27:02 +0200
Message-ID: <20260725152705.3958100-7-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260725152705.3958100-1-farman@linux.ibm.com>
References: <20260725152705.3958100-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ngbrRK6J8S2psMHLYnIAYsrCepLQitpo
X-Proofpoint-ORIG-GUID: ngbrRK6J8S2psMHLYnIAYsrCepLQitpo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE0NCBTYWx0ZWRfX+UP19sdCgj5Y
 ogYk65BIgTsdRRFK/Vpp424d2hkWEvfljEbDpgI8xVSySRDMdYi3e8cxmxRzUvG0NJ8d+FjeG0f
 Dnk2nioZJTC5bTqULTiba92FIwBVdrb+hTxrTlECJ4HDrtF/2fn+7cF08RAKbZdRWgvfBeXLBp1
 7kQK8sjzbUjtSYXi7vemQNIxIN+vzD7xRUYgaX8p5ApHmSq8Gc9bLS8c5K4udNPyELiO2b3ZTes
 +eQWW0snmyvrtnHLuol9u21F7821HRkz8rLHP4VYnAdiWBXrA+TSDnLjJKENNV0IZ/iGVmwtP7C
 pW+vylWIYLqQa6wD81JZENzrvYoJpFGNkMpNW58eqJgxG1MItiztsw/vlGJ7p0L3eLwpupHN3gw
 q89bXt/mpjjjzdJ51jEkF7MYbopk9bTEsAgGF8X8+L/5WfbDk7Zs7oLQtOnI3uOEvSo1/Awfhf/
 3WGtex1Ivi8cO9CYRQA==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a64d5d2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=jUipGm6kB3s0BbMcHoAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE0NCBTYWx0ZWRfX+L6ntvYoI0Z8
 bxCS7wtDYcq6KHfn0NiLEEpOaOHqV6H+Fl2LD7QFCMfybsk8mm3X1iYMpBWh8cxYt0CAcP+e8xs
 QZ0NHmxj7EIg9r2GW7v1CEedTBgXbPQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607250144

The introduction of the capability chain rightly clamped the
region indexes to the range of the capabilities itself, but
neglected to do so for the existing read/write regions which
should also be enforced.

Fixes: db8e5d17ac03 ("vfio-ccw: add capabilities chain")
Cc: stable@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>
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


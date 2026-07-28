Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5566349B0D;
	Tue, 28 Jul 2026 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785209433; cv=none; b=Rgngz0w7mkWPBFCm8CLHf0OWu4tICHO+gfx2MdJ3E+JjNp0NksPali8AP7O79ZP0jQlunN0EjjnEXy/12yPNqsNpXVteR0MfEL1ENtjenMQBb5iHNxNoo1+tlRAQezb2c9InzZal4z9qLMwO2ycyWJV7JXslmevXlNd9Ujnip10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785209433; c=relaxed/simple;
	bh=MhZP+ExapMndEcJ7FnnxrxZxP7LObxdIWgI1TyHjyNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIalTBpDMPWlJbqplJ6LzKefpkWGNX+l05Cn3cojwj2j6M2YzsmWO3pGoPc78Iv31QmRCj6Y/UD6Cu45xLz+EmZav/zi0h9LIqBaFFx09kTwNx6HxPD1ECL7JUWyPhfnwu8X7OYM0oTLigS4t2LB5vuvO8AghKzvmtse0Y5h8u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sIzVtLiJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sIzVtLiJ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0lmh53751806;
	Tue, 28 Jul 2026 03:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=x4lpqNOAqdwmvxg4I
	fxoTPAN8S+mdYoMzkMlHCCSKOA=; b=sIzVtLiJSQYLBhnLHFQfssCyZYk4K6+Qn
	dhRHJ6r7Q9uVkGx0LopTLsIRxzMeeKgC7qMlNysSsqhRAKGpx+whH1XIen1wWJ5x
	xBZxrmFkO11OXEBw/6Ct+cdKEny1KtSYctGUKORGuE5arXLsi6zIN4LdwGv1EKNn
	K/9dC4imyJ0hDPyJIB4HaNMvn4EHtjj+GuntBE5W4IcGSmKWO6j5gQQ4sdzj4UW3
	q5TkPg8UCjtHZWGhi5b1NuzgMlIicssGVNC5mY9MdsYUeLNVhXAipBgcD52LOPpF
	/0ze6Et6wK/hrG8MR4PJp/PH0SlgW+ebV9aCsAr6qF/M1oi2JzrTw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7b8pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 03:30:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S3QIa1005842;
	Tue, 28 Jul 2026 03:30:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xysqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 03:30:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S3UOIZ31589118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 03:30:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A5F12007D;
	Tue, 28 Jul 2026 03:30:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 512402007E;
	Tue, 28 Jul 2026 03:30:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 28 Jul 2026 03:30:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 1D5A1162824; Tue, 28 Jul 2026 05:30:24 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v9 06/10] s390/vfio_ccw: ensure index for read/write regions are within range
Date: Tue, 28 Jul 2026 05:30:18 +0200
Message-ID: <20260728033022.2658232-7-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728033022.2658232-1-farman@linux.ibm.com>
References: <20260728033022.2658232-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ltkEYp_k-JUVHWsAPnW81LZGOrZwJT7F
X-Proofpoint-ORIG-GUID: ltkEYp_k-JUVHWsAPnW81LZGOrZwJT7F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAyOCBTYWx0ZWRfX4PXFwE0tLy+w
 eNC8dBXZ1EQG5PJt6/vomfktHNb/D8a7BCyux9f419UD6wlnEI68VGzecuLQPSOjgkzO/bSnBYE
 puGX38x0wij4cF1coChcQqSd9FlHwNTFOqvJwIRjv4zx3dPkZ9iTfpIsZbCKzRtCUCoE32HdoEP
 Kj2nujUc/z4bXIf8jndKTZwf4TrU0yCiqn0c3UMGT+vZOn2HgwlMAGdCvrwnhOECpb/gVYT3XjD
 3Vhw2vpeDM6fdvOUIzOSgcvmchQbO5ZkbwnF1puWX6hDEcY9h1BJEgvUYkQnMOaFC187I4jKrgv
 sUIV7QV74f2Zxkcbw5inhNEFt8DLh66GsBdWPCkUkKNe35DrjVmdySgV5oBUJXoreXXfVazRcSh
 GKl5exVstCuwCgLInlpKP4w7/MQj2nTX083mUEmfYx09ZYfzUtLnR5M9UAWECexXctxEMhTBWvx
 FxK9fte9WoLau6pU0Ug==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a682255 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=jUipGm6kB3s0BbMcHoAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAyOCBTYWx0ZWRfX3OD9Oig1JMSh
 VLZxVoK2WDdlTprgnyxgG/fraetmCpwbw1Rl6pBnLGEdWC6eCSUNVtUM4JMAoAH3pLqKukR/mRd
 qTcVqU0eWSuSFuBS4x1PLu1c7npq2Nw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_07,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280028

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


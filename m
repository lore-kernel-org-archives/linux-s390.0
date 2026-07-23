Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EFA33F5B3;
	Thu, 23 Jul 2026 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828887; cv=none; b=dbFUoDVc2MC7wHdpvnzJfiVpsdZ3pDTYP9tYbb+RpghgQ7KgTdVXNHLz3izrUlx8WXPGOeUzrxqoJBApsAvTL/0lWq564B/s1lzBgp11G+F/3FaKrbYhyehol0Bp0AAHk9fRbceMkBObvZIvWPdVgRwWn7Tdqn8KhEZeo8ql6DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828887; c=relaxed/simple;
	bh=H8YIdGBw5uFaeE3x06j545JlwLifLUC/A60Bef2Q6kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIyC+xScFeQcbv9VUEuVguBURv88wzxaqpqDTJGGhSYK8VFA0fRb6cQ1qXiYiwmqPbP9CV5T9ek+gkGKkN6Cmtrbg03GM+LXSHTX/EvWOsnLsSk+g/aMExWaA3duE64BIM8MOBTdhm5Stry+YlP/wnjXPoHMKfDyaSQaAtOAxFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Br913p6w; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Br913p6w"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NHgFWf3579741;
	Thu, 23 Jul 2026 17:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fCdCgUJj2u35Em7G5
	34+P/9lVy3TN3dd6FQ6FUa2caM=; b=Br913p6wwnhQmB9YWugxyjV7uAe0WqIHw
	7NSPycBcltq6iD/hDZ989W5b9EOkvbzHABlmUSKzbWpRCxlDGPtqfHoVgRnSlL31
	MihapCyToTMW/7ztEcFU8/cnnaI0T56A85uetAOZ8gQDPwu+m3ioAdth4qreb+6d
	30mrjMOGDN8E9gM+R/0YV7oIFBMw4rOTVhBvthiKcAIGNDv5hRTkTlYfLnXZWLwZ
	RzabkyNk0CUWpS5Qbi0mPkCyheTMqjxS14eLNaC58td/AkhniAiUWoGnJTQRP35A
	B9roDI6Kd/BiUgDECXtVB2If5Pr5uYiWy0gVb0LZkpiGBRUjizxpQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gg8e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 17:47:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NHZ29n009744;
	Thu, 23 Jul 2026 17:47:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gn59r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 17:47:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NHltUl59965704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 17:47:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C76B2004E;
	Thu, 23 Jul 2026 17:47:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8D832004B;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id AA1491627FE; Thu, 23 Jul 2026 19:47:54 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v3 6/8] s390/vfio_ccw: ensure index for read/write regions are within range
Date: Thu, 23 Jul 2026 19:47:49 +0200
Message-ID: <20260723174751.1180334-7-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723174751.1180334-1-farman@linux.ibm.com>
References: <20260723174751.1180334-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3MyBTYWx0ZWRfXwEVc5VTGemmZ
 oxoAx1po24JwDslz04QZ1X2nrOdNrW0t3B8/o/FUadJDxwH9m/SJzFlJzfZDkc3QO3ekRXirRZ0
 Gi63uMASZMqjN1HXlJnqb8OYWJO02AapIsWgNEZJ81unbOmDq20fA6l7my5OLpGVd2p+4Q2e/7y
 pBuXCBw4QYri7bGJn4DEgsIx1I8luhvVOo8R8NMHNSKv8WoXxR5AIv3jtM6FgHRh+UiBmwdeIxT
 XO4olnueknJ/lxujO+KpbmI8bbcDZBcMsOKHuJdmEocywzmx++HiARStIGYic6ASzkKULdH4X2z
 xVtjOO9NgqMOuJ5+/Ny3+2V79o9XJ/dQmda8ZwJH3+Okzg/LZHTyuetCmCOh8DWifA+wYQv60Re
 SX8tJ5HKKX9Swq6LTmFfDp7WXDDqdX0CdXs6z5cAJfzRhA2LkJyynWMUSTeSe5whomdHl6uMojV
 EDMVYZlEGhreLd2wHIQ==
X-Proofpoint-GUID: KvS7wbp4r8kIJV8UczqpWNmUCVWF3Efy
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a6253cf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=bDB7FJViJsEbW-YDbMsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3MyBTYWx0ZWRfXyO2sDG5IcCNM
 0AHNfU0Z5I8Gs/wuN1BO+sjaEL0TLFHZpvXI0TqExynr07fEruaf7YL8gdwHvzQC7MgK4vUmn+4
 ibonDrUamnz8V0aUyAVkVOgQl4HU5+A=
X-Proofpoint-ORIG-GUID: KvS7wbp4r8kIJV8UczqpWNmUCVWF3Efy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230173

The introduction of the capability chain rightly clamped the
region indexes to the range of the capabilities itself, but
neglected to do so for the existing read/write regions which
should also be enforced.

Fixes: db8e5d17ac03 ("vfio-ccw: add capabilities chain")
Cc: stable@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_async.c | 4 ++++
 drivers/s390/cio/vfio_ccw_chp.c   | 4 ++++
 drivers/s390/cio/vfio_ccw_ops.c   | 7 +++----
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_async.c b/drivers/s390/cio/vfio_cc=
w_async.c
index 420d89ba7f83..f213f62f6641 100644
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
@@ -24,6 +25,8 @@ static ssize_t vfio_ccw_async_region_read(struct vfio_c=
cw_private *private,
 		return -EINVAL;
=20
 	mutex_lock(&private->io_mutex);
+
+	i =3D array_index_nospec(i, private->num_regions);
 	region =3D private->region[i].data;
 	if (copy_to_user(buf, (void *)region + pos, count))
 		ret =3D -EFAULT;
@@ -48,6 +51,7 @@ static ssize_t vfio_ccw_async_region_write(struct vfio_=
ccw_private *private,
 	if (!mutex_trylock(&private->io_mutex))
 		return -EAGAIN;
=20
+	i =3D array_index_nospec(i, private->num_regions);
 	region =3D private->region[i].data;
 	if (copy_from_user((void *)region + pos, buf, count)) {
 		ret =3D -EFAULT;
diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_=
chp.c
index 38c176cf6295..bf678270c457 100644
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
@@ -26,6 +27,8 @@ static ssize_t vfio_ccw_schib_region_read(struct vfio_c=
cw_private *private,
 		return -EINVAL;
=20
 	mutex_lock(&private->io_mutex);
+
+	i =3D array_index_nospec(i, private->num_regions);
 	region =3D private->region[i].data;
=20
 	if (cio_update_schib(sch)) {
@@ -97,6 +100,7 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_cc=
w_private *private,
 		list_del(&crw->next);
=20
 	mutex_lock(&private->io_mutex);
+	i =3D array_index_nospec(i, private->num_regions);
 	region =3D private->region[i].data;
=20
 	if (crw)
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


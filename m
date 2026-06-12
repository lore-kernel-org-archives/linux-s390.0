Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1279390239;
	Fri, 12 Jun 2026 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781279655; cv=none; b=ZjiUwaBHcmlFKZb9JK7LyQ/xm7zp3ixaYgJLSA3vLO8Owgf1oN5zvsqrcUDLPlfqo7lr1oV2VJyVAdeGIqaJRyUBQd6AUMDO2wSiH1o2tVE68x9op7iqYJGmQLDw77UqtbMGb2mhRCJXl16qecSvLW2qSHhDymjlT5wphQuzPtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781279655; c=relaxed/simple;
	bh=TYPADI2wSzNZ5rQcatAjxaP2wfMLbqWd4tER1VUC9l8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CIEzOsgJ9q0Bc9yUG6UbqBnr8weF2oEs9y47g1LRD2zoqhFzg5enAXqozTbcdyoqIjjgqiNe16vlbZ6xWDbAJSUzkMCE0gLeVLsYXu3wy9Z6lVafQKWMgtBe8BIdpVzfu4BXh8Ax+tIUA4UBa6PnmBCrXdKDy3eJAior5VL+f6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V3/xZqDg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V3/xZqDg"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CF4euA4146525;
	Fri, 12 Jun 2026 15:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=8cfcrF0M4Zks/sCASUrqWn7SLeFQo6Rv8BTTz6ixj
	GU=; b=V3/xZqDg/m4qulbXQqfYo0JNKsTVurvWSIbk1svZ6etggTbBBSa91girh
	FJYmNfbZd33MGxZIp+ZgfSvLUBNUqdGwCwTrBXLRFCBvT2bMfxZ4w7U3HS9qtnAV
	Wj768DP2UWIRJJUGtCRKq/EDIvzOHykYswlWXLpC9QjLllc2BAeHzR95iexEsNUq
	93US9DGOYHD5ymXgHNXfFWwxHdBaYt0mWeUVZLpvm+/r6V6ZPVBnH2v/ngffi1VF
	P2lJsTcm33PHzyTOfy2Cl+xQJDHO0LUowQ3tFbWebmeTDHbZ88SVLPTEIUGmrCG6
	rVHBuseCIvAQRt0FHUgXDJgABvJHw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8c9t9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 15:54:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CFYjxI010140;
	Fri, 12 Jun 2026 15:54:09 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe0a8h50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 15:54:09 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65CFs83P22807168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 15:54:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AF7A5805A;
	Fri, 12 Jun 2026 15:54:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D08E5803F;
	Fri, 12 Jun 2026 15:54:07 +0000 (GMT)
Received: from 9.60.13.85 (unknown [9.60.13.85])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jun 2026 15:54:07 +0000 (GMT)
From: William Bezenah <wbezenah@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: cohuck@redhat.com, pasic@linux.ibm.com, farman@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, mjrosato@linux.ibm.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com,
        virtualization@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] s390/virtio_ccw: Also suppress -EINVAL on device detach
Date: Fri, 12 Jun 2026 17:54:07 +0200
Message-ID: <20260612155407.199218-1-wbezenah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE0NCBTYWx0ZWRfXylMrBsZ7zizQ
 2u+V8hWLap3Z82z8Xaf9qwIkCf+WktsxMgBTXAzm1Aow8FiCvntHPJO5o/4xSFouYmmWx5wyVJt
 nPsDybAs4qayPjLCELCso0+h99kM0cw=
X-Authority-Analysis: v=2.4 cv=AYCB2XXG c=1 sm=1 tr=0 ts=6a2c2ba2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=uYiYJ5MKk1sDHHHSvssA:9
X-Proofpoint-GUID: RQsPodU4gnULLxzS7kl5j-qxwXuvt2Xm
X-Proofpoint-ORIG-GUID: RQsPodU4gnULLxzS7kl5j-qxwXuvt2Xm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE0NCBTYWx0ZWRfXxot5xToY7tMI
 +pNPctVX6+rT+5r0ewT+t4NMmUT467owfyB3JvzLGcwcYtsxNMIjF5Y9UyQAsV7G3Ta+iLnwLrF
 PbjrUGJ6JKHnMx8f7fof8qFBqZuq9H538lMPa3hMdJ1wZx7rFLMcnXj9ealVfJd2GcB/LDGq8pM
 WB+NBaGZZ76Acs3tqrz6j5aTeAqeManOJGIdv45o8c7rDZ1t+tRAi2CAFe7XS6XyTU+3ZQn9oB4
 BWVG78zeU1fFTj9bsEIHBmAShxyb5yc1Itj8Zzu8wwuawcoVWBXjz/9WFtWy+YOHnl7/jA/9JN4
 B8kLIV+exLCcJjWJM3ndarPEoathUKems5bJ3wK9ZUiSg7uBNq7iwlnjQ1WfOknawxSvGLrtWCT
 v3/B4uaSGtDw9RXwfrTA4GwVI/HW4j3qZrsedSkIlD/KvwxVAazjuss3YO48NxuCJfLXmh/9n/b
 qr0mnXwFiee3Zwxcwug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120144

When detaching virtio devices with multiple queues, spurious and
non-fatal error messages appear in the guest kernel log. While
virtio-net devices have multiple queues by default, this issue can
also be reproduced with other virtio device types (e.g., virtio-blk)
when configured with multiple queues:

[   33.820621] virtio_ccw 0.0.0001: Failed to deregister indicators (-22)
[   33.820628] virtio_net virtio2: Error -22 while deleting queue 0
[   33.820632] virtio_net virtio2: Error -22 while deleting queue 1
[   33.820634] virtio_net virtio2: Error -22 while deleting queue 2

Since commit 8c58a229688c ("s390/cio: Do not unregister the
subchannel based on DNV"), subchannel behavior following a device
detach has been updated and results in -EINVAL being propagated
rather than -ENODEV, originating from ccw_device_start_timeout_key()
in cio/device_ops. In the end, the virtio driver has no ability to
react to the difference between device and subchannel states here,
and during detach, both -ENODEV and -EINVAL indicate the device
cannot be used and should not be treated as errors requiring
attention. Update error handling in virtio_ccw_del_vq() and
virtio_ccw_drop_indicator() to suppress -EINVAL in addition to
-ENODEV.

Fixes: 8c58a229688c ("s390/cio: Do not unregister the subchannel based on DNV")
Signed-off-by: William Bezenah <wbezenah@linux.ibm.com>
---
 drivers/s390/virtio/virtio_ccw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index bab6cad3fd5c..02fd8bf7e469 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -429,7 +429,7 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
 			    vcdev->is_thinint ?
 			    VIRTIO_CCW_DOING_SET_IND_ADAPTER :
 			    VIRTIO_CCW_DOING_SET_IND);
-	if (ret && (ret != -ENODEV))
+	if (ret && (ret != -ENODEV) && (ret != -EINVAL))
 		dev_info(&vcdev->cdev->dev,
 			 "Failed to deregister indicators (%d)\n", ret);
 	else if (vcdev->is_thinint)
@@ -515,10 +515,10 @@ static void virtio_ccw_del_vq(struct virtqueue *vq, struct ccw1 *ccw)
 	ret = ccw_io_helper(vcdev, ccw,
 			    VIRTIO_CCW_DOING_SET_VQ | index);
 	/*
-	 * -ENODEV isn't considered an error: The device is gone anyway.
+	 * -ENODEV and -EINVAL aren't considered errors: The device is gone anyway.
 	 * This may happen on device detach.
 	 */
-	if (ret && (ret != -ENODEV))
+	if (ret && (ret != -ENODEV) && (ret != -EINVAL))
 		dev_warn(&vq->vdev->dev, "Error %d while deleting queue %d\n",
 			 ret, index);
 
-- 
2.54.0


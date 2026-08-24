Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712E5432E88;
	Mon, 24 Aug 2026 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579954; cv=none; b=JVA4s0FmwTkyxFsjUWZLzLzsXEX8l0CKsiAUWSvtKiJGkLUhCb797usJLf2oX27XwA0KcGuOa4bu1GkObOQ7Jlw0XV4qeSJczvdZ657fW8Xti1uVEVgyt+r+P+SvdwMtOTRXenLhx6nfFE5RgwE8gSVCrlvzrFQiAQuEKurLYKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579954; c=relaxed/simple;
	bh=XXtmnDfwYTodPcMZKFOIcacIIohd9GCe22AtPfkThQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mf/jgHszIILCNxeYWGWcttIQe25MBI6UAyeQD8Jp8d5ak4o/wpKGyRyMNLkSNsE4+oaf69ijQ1ZFXKjxX6r7N9sXrELs6rvqEv/mCwLL3WHFjAZfsNlXMq7eY7KaNu3hSVCc7H/G+0KAwfl8HoQDVFVXpoDzJxrTt3VyhPkxxQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TQ/gKgbj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TQ/gKgbj"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1VtN1957870;
	Mon, 24 Aug 2026 13:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qZUeMgb1W4+SPBxla
	h6XajW2IJAVLCcC32aHn5cZhrY=; b=TQ/gKgbjwKOPWK3AzwP0nRcGJOXdE2gRF
	bsHM/75G58PvlmNtat2K0+yC4K/5kFn8M9VduURiXN7kxcVqIqnCWuQnCftrRdPd
	IerWXsuek0YbhqWOfnXVngWY5aBh9nY6wtKfvaWaUDl7NxCflw52kWqVVGxKs+rn
	optdGrLrsCzuTzoTmNUaxuyOM7Sgo68AuNtgj/jWGzdk6IyvvLYHcqHBfeX8+Av4
	CpRu7NhowLsSLP8PjfSWBTPAluqXIFgAdJWBBer6O4X0xPiH9qVqqtZwjtAvtwrf
	mDQS0bAHQK3BQKQtneJPqSBjDLnfWWtIRaVj5bOeQMW3dWSBpJ2lw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4hq62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 13:58:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ODuMSP021047;
	Mon, 24 Aug 2026 13:58:58 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfvxcg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 13:58:58 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ODwv0H61735180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 13:58:57 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A1B358060;
	Mon, 24 Aug 2026 13:58:57 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EA7D5804E;
	Mon, 24 Aug 2026 13:58:55 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.96.163])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 13:58:55 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH 2/4] s390/vfio-ap: Fix failure to release IRQ notification eventfd contexts
Date: Mon, 24 Aug 2026 09:58:48 -0400
Message-ID: <20260824135850.503728-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824135850.503728-1-akrowiak@linux.ibm.com>
References: <20260824135850.503728-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t4EHuisXsMPHO_LB4vUtA5UHP2mBjE28
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExNCBTYWx0ZWRfXxcwXronxS+wc
 pbvWNYfI5MrfwFGEiJXssqzayU/PdUDse2w/12sZXOJcr7i+HukpWdkU0VVsUH3dX+dLX2teg/r
 reA9ObLOBt2SetpplDx1f0pr+YVcKDc=
X-Proofpoint-GUID: t4EHuisXsMPHO_LB4vUtA5UHP2mBjE28
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8c4e23 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=fxeDLeT5AZ2qCvnLJ4gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExNCBTYWx0ZWRfX+fj7riCi2qda
 nTWHSyJmnntyhjHbqXKLz/SBmKDPfInIRFBIl32irwBrcmoSEQZT7w58T0TkcK99trjlmBYagoK
 JZmWLBQOhSBh/Pf7e0lEMzAB24yW0jBzy6fXm3T+thpalNZEy+IeH1VepAm6MFhmOEZXiSaCDI3
 t32L1PwWmYBP9pajxsN9u5bgqbcjsPplKThKqt17wJze9yt2EmLEm076x7JWme/AnFbv0wLuCio
 KZxlV1mJP6Th0QuUjdIdaGltNQK28LcAHjB74FJ5ipMmr8d8jQ1y7bPrJ2YSFYhttrIbQW1sV+V
 zmmThk5uVV9KqyT0qlcG85iKHMb/M4yj6d/YKSpRZi+kZt8XMPFhIB39M9wRWpvDNMPpUmXjEwu
 2mlpZv5qwO005aTucDlNLV69+2dhYFPAdY4zTdhvudbL83aYQW5AGs0pZQk9Ui0CJysoe3Hxxrv
 TXLhE9p6QZ76iMFsKRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240114

When userspace registers IRQ notification eventfds via the
VFIO_DEVICE_SET_IRQS ioctl, vfio_ap_set_request_irq() and
vfio_ap_set_cfg_change_irq() each call eventfd_ctx_fdget(), which
takes a reference on the eventfd_ctx and stores it in
matrix_mdev->req_trigger and matrix_mdev->cfg_chg_trigger
respectively.

These references are dropped only when userspace explicitly replaces
or clears them via a subsequent SET_IRQS call.  If the device is
closed without that explicit teardown - because the guest exits,
the VM process crashes, or the device file is simply closed -
neither vfio_ap_mdev_close_device() nor the remove path releases
these references.  The eventfd_ctx backing objects and their
associated file references therefore leak for the lifetime of the
kernel.

Fix this by introducing vfio_ap_mdev_release_eventfds() and calling
it from vfio_ap_mdev_close_device() after vfio_ap_mdev_unset_kvm().
The VFIO core guarantees that close_device is called before
vfio_unregister_group_dev() returns in the remove path, so fixing
close_device is sufficient to cover both teardown paths.

Note:
~~~~
The matrix_dev->mdevs lock must be held during the call to
vfio_ap_mdev_release_eventfds(). There is a small window between the calls
to vfio_ap_mdev_unset_kvm() which gets and releases the update locks
and the acquisition of the matrix_dev->mdevs_lock mutex during which
it is possible - although highly unlikely during normal operation - whereby
a concurrent SET_IRQS call can get in.

Taking matrix_dev->mdevs_lock around vfio_ap_mdev_release_eventfds()
is sufficient to make this race-free. The SET_IRQS ioctl path writes
req_trigger and cfg_chg_trigger only from vfio_ap_mdev_ioctl(), which
holds mdevs_lock for its entire duration and always calls
eventfd_ctx_put() on the previous value before storing the new one.

Any number of concurrent SET_IRQS calls during the window between
vfio_ap_mdev_unset_kvm() and the acquisition of mdevs_lock are
therefore safe: each ioctl invocation puts the reference it found and
installs a new one, leaving exactly one live reference in the field
when it releases the lock. When release_eventfds subsequently acquires
mdevs_lock it finds that single surviving reference and puts it.
Conversely, a SET_IRQS call that loses the race and blocks on
mdevs_lock will find the field NULL after release_eventfds finishes,
take ownership of the reference it just created, and install it into a
field that will never be read again - a transient leak. To close that
final case, callers must ensure no new SET_IRQS ioctls can be issued
after close_device() is called, which the VFIO core guarantees by
releasing the device file before invoking close_device().

Fixes: bf48961f6f48e ("s390/vfio-ap: realize the VFIO_DEVICE_SET_IRQS ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index a46bf381ab72..6e4569d6b975 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2066,12 +2066,28 @@ static int vfio_ap_mdev_open_device(struct vfio_device *vdev)
 	return vfio_ap_mdev_set_kvm(matrix_mdev, vdev->kvm);
 }
 
+static void vfio_ap_mdev_release_eventfds(struct ap_matrix_mdev *matrix_mdev)
+{
+	if (matrix_mdev->req_trigger) {
+		eventfd_ctx_put(matrix_mdev->req_trigger);
+		matrix_mdev->req_trigger = NULL;
+	}
+	if (matrix_mdev->cfg_chg_trigger) {
+		eventfd_ctx_put(matrix_mdev->cfg_chg_trigger);
+		matrix_mdev->cfg_chg_trigger = NULL;
+	}
+}
+
 static void vfio_ap_mdev_close_device(struct vfio_device *vdev)
 {
 	struct ap_matrix_mdev *matrix_mdev =
 		container_of(vdev, struct ap_matrix_mdev, vdev);
 
 	vfio_ap_mdev_unset_kvm(matrix_mdev);
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+	vfio_ap_mdev_release_eventfds(matrix_mdev);
+	mutex_unlock(&matrix_dev->mdevs_lock);
 }
 
 static void vfio_ap_mdev_request(struct vfio_device *vdev, unsigned int count)
-- 
2.53.0


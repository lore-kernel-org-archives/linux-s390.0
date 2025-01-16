Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DD61E47A5
	for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2025 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737033153; cv=none; b=oTMeXiqVKRhEJ5wfb2Ow+kcxuLE4/TJfy0Yr+pa40iYZ3FniPd0RhHNWRUBdGcbN60FUZV+EtV+YykqQaBuorIoEmbg5vJzFPEewP3wUbMI8Yg6D2QCUf9NL6nYZVFMKum1gXBbHn93+otqmTjii0dEfn78HvGvI2PmeJ5lXc3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737033153; c=relaxed/simple;
	bh=GpUcnEkib3+s4DwQ32Ld7Si8ZkUF7Cd5wFPiA/Gz6zM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t+8oUhE2FQAvqONdiPjpsHC9+2T9DsLxnMa3V2SNFAx7GrSuoEUvy/JHscgcUoXwSU+CYDeBHaaRTXgJwciZC7xz3e59JVCVgArjEKdO3vkrKN+ucVMslnB9MCR/myx4cvknXravNnl8+83CpN79vMQlOV5YZZKtw0oUmPIBQlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tsNXfMwM; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tsNXfMwM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737033139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NU4+WXbDI7Jt4Dt1FidaSNve/Qq2LRFKKcNKC8WFU68=;
	b=tsNXfMwMUESL7DMgD6S6H5TbZHEJcW7WECFD9UdUXQ2xepiX41w4+9va80xC6xpt0+fW/1
	L8zr9+vKgJjyUchqldC4zD888OjxrHt2LuDKDbcnO4FM/Z5HIKrkuqLeLwDLP2KSgz4ifv
	qttwNpx3U2mECXjOa93QpoFR76+0x5E=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Tony Krowiak <akrowiak@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/vfio-ap: Fix indentation in vfio_ap_mdev_ioctl()
Date: Thu, 16 Jan 2025 14:11:47 +0100
Message-ID: <20250116131146.105439-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove any extra indentation to improve the code's readability.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/s390/crypto/vfio_ap_ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index a52c2690933f..155e19aef5df 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2199,8 +2199,8 @@ static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
 		ret = vfio_ap_mdev_reset_queues(matrix_mdev);
 		break;
 	case VFIO_DEVICE_GET_IRQ_INFO:
-			ret = vfio_ap_get_irq_info(arg);
-			break;
+		ret = vfio_ap_get_irq_info(arg);
+		break;
 	case VFIO_DEVICE_SET_IRQS:
 		ret = vfio_ap_set_irqs(matrix_mdev, arg);
 		break;
-- 
2.48.0


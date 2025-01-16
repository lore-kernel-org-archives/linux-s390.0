Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18241DE2AD
	for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2025 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737033599; cv=none; b=jvUoFU23Y5drWxkNB/TrpNxxTNeSMrtRcC4/lMkhiq5+L0skqjUpUa9TXkfncOI5jSXuHo866kD8489V2whpz2byhzuF9j6XDQSKCsNz/fSU81cbDgwyAR5S7f6BMumdbbDVHYpYIMzDV3sCShXGSHnsagMPus4BhBdzO3HV/dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737033599; c=relaxed/simple;
	bh=JLbzrkPHHl4z3OfrMXHdkLR2wYyEFz7nDvkukN04Yns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3WBYAKJemjhl6dezbbFyI2iGPr/ij55H+xdcFVNwKJGR7qmY2Eh706lILfnis40PzMnp1qZhKIe6QaM1xyflqbwynYnbmvVWVqlX43P/G9F5ndVAMrq+wf9CrffukajfKmQ1QfvpGtWvKOcQRrrbJ8o5Q3ovmT1HuE8BGW+/8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MR2RdUZI; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MR2RdUZI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737033589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KCtIlCqqSrO4jJm7cqUf8hZlN4VmB46QY7zufEspPzQ=;
	b=MR2RdUZI0IBjFtTp2atANEKRTb5K+2PvOTA2NZaeYgdNKkhQQYZWxMM6nWeYUFLAhM6Jrt
	4fRWK3SwWQE6PwKtZlf9t18usGoWAIuGL4gZ1iPq5yR89uRLxJQXe2LFd+tyQZc6s1brwf
	SBEM2bbUoxoYNb2qNzI4SQVUodGdFVM=
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
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/vfio-ap: Replace one-element array with flexible array member
Date: Thu, 16 Jan 2025 14:18:59 +0100
Message-ID: <20250116131859.105756-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the deprecated one-element array with a modern flexible array
member in the struct ap_matrix_dev.

Use struct_size() to calculate the number of bytes to allocate for
matrix_dev with a single mdev_type.

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/s390/crypto/vfio_ap_drv.c     | 2 +-
 drivers/s390/crypto/vfio_ap_private.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 67a807e2e75b..ea9ffa37f263 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -96,7 +96,7 @@ static int vfio_ap_matrix_dev_create(void)
 	if (ret)
 		goto bus_register_err;
 
-	matrix_dev = kzalloc(sizeof(*matrix_dev), GFP_KERNEL);
+	matrix_dev = kzalloc(struct_size(matrix_dev, mdev_types, 1), GFP_KERNEL);
 	if (!matrix_dev) {
 		ret = -ENOMEM;
 		goto matrix_alloc_err;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 437a161c8659..9aed8994f567 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -53,7 +53,7 @@ struct ap_matrix_dev {
 	struct mutex guests_lock; /* serializes access to each KVM guest */
 	struct mdev_parent parent;
 	struct mdev_type mdev_type;
-	struct mdev_type *mdev_types[1];
+	struct mdev_type *mdev_types[];
 };
 
 extern struct ap_matrix_dev *matrix_dev;
-- 
2.48.0


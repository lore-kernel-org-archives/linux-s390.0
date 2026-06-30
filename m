Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8EA406822;
	Tue, 30 Jun 2026 10:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816119; cv=none; b=MLldfg/i48i95IZ7pEmyL9PKxWdIH2ud/UXYGOtyKYevWGvBovBeS2WW2wHcqIB5urjqa5YsHbFLrYoJ1xhvnG5K+7qepFX/th8cNXTTBi84CwKDu2R9aGcNBq+nnLEm6MbsAOS9dFdK5p6A9E75tvqlW/aHQilQKlpiPe4o3CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816119; c=relaxed/simple;
	bh=IpqjYC3i9foL5Y514G15yQFtbCOTxrdMn2gx5Py5n+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ety3Lr/ROsmnoKUY2IsVJlVhV+CShl0I2mAt2jUa6Vs3aA9vpirgk/+jfBvwTDP1RxXjsSLVYuW7ktkMvYDXyCV+RLTevDdDbtLvuDDQHxcjX4zk837laekgUJ4PnpDrIgd1p8CABhlWIR25Azs+lAl8gl7N4N6f3C4hpyOLFUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IOXJCMdR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IOXJCMdR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n8wv1843376;
	Tue, 30 Jun 2026 10:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=e00b1fe16bova0NlE
	VKsl+N0iJS/9h8SLn601XEzhrY=; b=IOXJCMdRhERdCcvY2NHCVso3y/tuGdHds
	ngJseX05IVDzpQt7xy4bl7GNDatiyMM4o3NQm+a6WDRTAK9mn/6y2Kw3FjEcJ++k
	vVpcDW1GK2YFf/I6Z+xGynK5vzJhKjkYvtbzKHkJ1CYwYDbx7sv4tXtfiPTU6SB2
	4QHWebGJSk82x7H9pe7p01bdoGTHzkxNqygq+4MoU9topGcIV7joNUyN56p6yLHP
	Ji2UmZl882Wkngqqu6I3lohoDT3FY6SPMIQRMdEYQfIt1GnUjHn18+QOEZkWDxzv
	D9rRNT+TDriaLOBJ9f/ZWxztr64P+WNfImL7xzX8BYC7L0HA/ZO5A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfx5j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UAYeAO005455;
	Tue, 30 Jun 2026 10:41:50 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w1tge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:50 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UAfnQE38011606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 10:41:49 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF46F58056;
	Tue, 30 Jun 2026 10:41:48 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1C395805D;
	Tue, 30 Jun 2026 10:41:47 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.135.84])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 10:41:47 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v3 13/15] s390/vfio-ap: Callback to get the size of data to be migrated during guest migration
Date: Tue, 30 Jun 2026 06:41:23 -0400
Message-ID: <20260630104132.1598851-14-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a439d6f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vZ-Ft76KQvoWVpZ_:21 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=ZNjzJX2u4haZFCbEBTgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfXznikkbm6h3cE
 bkEl6oibe9S0nI75rJKjTpk8v0XzuANAGxw2jQe9ZkWNh3SObLdIyIB3W0e7kydsd7X8pscrGmC
 W4HXSfuZnIsKNZSb9mJEeGIBxc70/Y0=
X-Proofpoint-GUID: 0sjyy22IKCCy2Lxd-SThXqDO7dDkWNP0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX2OtYN+27oW8P
 6FUPmu1F6z8tdic8D+Nm6kWc6tBIDc9NaYwFeHA20+ne0Nmv9w2ZDfU6lmTyJnknF8o/jVwP1Gk
 N9utztXnW47SWJp3QWI0/iimI5LLQwIiBrQwrPR4WDxQasBXTLsmiJXuS99yb78ubF07NtFZChW
 LLZFuctr2zhiHYtBsGCmLSsia1W1Gpw9YQ7NnPFkRFv4hMU1IJ9TZ6mdYQK5sOxU+L/Wj0SDQEL
 2OBDxfUOgvClY9SIgEuCY6g9YGoE0JsCpHQJDWpnf6Sg7WNhO/NjWP+QQ3J4n+XKZCog8AooAuU
 HUSWkB7m8ABeqEWpIlpSQvl0GuFb/mdM5ieQc7xsbwYTkofsu4LmtkkB9+4er0kFGIYSAWHyBXv
 8j0qybipg/ICUn0eHSa2aetOO8Q0xErzP0YT8IGOIeEVij8RMn6nyd6fYl+ik6kBmW95LaPQPhz
 Jk3B3EnkLnzPpiWfUhQ==
X-Proofpoint-ORIG-GUID: 0sjyy22IKCCy2Lxd-SThXqDO7dDkWNP0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300093

Callback to get the estimated data length of the data that will be required
to complete reading of the vfio device's internal state. It's mandatory for
VFIO_DEVICE_FEATURE_MIGRATION migration support.

The function pointer for this callback is specified via the
'migration_get_data_size' field of the 'vfio_migration_ops' structure
which is stored with the VFIO device when the 'vfio_device'
structure representing the mediated device is initialized.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 572db04c4ac1..83e1ce2c40c0 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1283,7 +1283,18 @@ static int vfio_ap_get_state(struct vfio_device *vdev,
 static int vfio_ap_get_data_size(struct vfio_device *vdev,
 				 unsigned long *stop_copy_length)
 {
-	return -EOPNOTSUPP;
+	struct ap_matrix_mdev *matrix_mdev;
+	size_t qinfo_sz;
+	int num_queues;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
+	num_queues = vfio_ap_mdev_get_num_queues(&matrix_mdev->shadow_apcb);
+	qinfo_sz = num_queues * sizeof(struct vfio_ap_queue_info);
+	*stop_copy_length = qinfo_sz + sizeof(struct vfio_ap_config);
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	return 0;
 }
 
 static const struct vfio_migration_ops vfio_ap_migration_ops = {
-- 
2.53.0


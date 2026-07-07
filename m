Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4032BDC2F;
	Tue,  7 Jul 2026 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414973; cv=none; b=cRDe4ov3Ij/hzwUzvuCOxWSqMLUQu/0IbGNIhEXvi1kflkpjsKd67XqLAdI2urYOhaYqdhFcorDQzumUoRCLzcRi0Fj24tEtxq5ycyB1z/emTzrwT+GzLeSHViMuWcRKTZtXuk4ReBIWAc3PimdNcRqnzrn5Q8lDwSebW5BfpxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414973; c=relaxed/simple;
	bh=IpqjYC3i9foL5Y514G15yQFtbCOTxrdMn2gx5Py5n+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2sqlaLXKv43ihm53GqG6ZfqJGovnVbs9NGVSxJXjE+gFNDynbCb/LF3djhic+uXrd1XpIn6nW7fA5dByjscoSHo+fRZFo1dU43UmTG4Hjin55ZpnyWHVvW4SW1vXjAcVC1SYXlb+Ty96uX7NZCooYnWoz0n6KRvQ+zKCZ7uQik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nKSOZ+ke; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nKSOZ+ke"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678IMRc3129996;
	Tue, 7 Jul 2026 09:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=e00b1fe16bova0NlE
	VKsl+N0iJS/9h8SLn601XEzhrY=; b=nKSOZ+keKfT7am4lfB49MW5gFf6jjrMn5
	wGbZqR7lFlU71EQmymxst5UhrT+VHLZr0T9A7kEwBJMTKD5o0POBXKSx+Ijzob73
	+6j36fH8+5mngMB/gJL7Pf6bd5ZV02AdNge27RCeUcWM+dVEyZkxIiP/bAhIUYQ1
	r58J4DxnDWmT2GWjh8KZbkiiU1YK7fmjoeDxOxj59ltI4cb39j39PnFEe57+LCM5
	YDV/ltT614fnWygH9222wi+ZPVQPjv9PTCtvEWoURoMhhwrLroaFpfpCw3fVEGsB
	8FakzXvGTUhOTD7ZLvgU6KKFOJ3aEdL/jIu911ZwZIsUkQQQ/UO7A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkne3g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6678nbs1028791;
	Tue, 7 Jul 2026 09:02:46 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq24xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66792BoZ23528096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 09:02:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C72F65803F;
	Tue,  7 Jul 2026 09:02:44 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A531D58056;
	Tue,  7 Jul 2026 09:02:43 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.160.85])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 09:02:43 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v4 13/15] s390/vfio-ap: Callback to get the size of data to be migrated during guest migration
Date: Tue,  7 Jul 2026 05:02:15 -0400
Message-ID: <20260707090226.3206695-14-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
References: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4cc0b7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vZ-Ft76KQvoWVpZ_:21 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ZNjzJX2u4haZFCbEBTgA:9
X-Proofpoint-GUID: hL0-vJTiXaXFDUBss_HzGUnO15lEcU61
X-Proofpoint-ORIG-GUID: hL0-vJTiXaXFDUBss_HzGUnO15lEcU61
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX/XCEWve7bHjY
 iS3WprTUfW0ZCLnKJhBc56yY+EX3KMmjzRXpyBsONIVLPJpysrryqGynxPGyrv+khi0XEq6S7Ny
 P9iBi+X43PGnd9Q0yxgrh+v1VPwKnnM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX3EaXWVVfhiVf
 PKL6Cy9Vz38Ay20wRIgPlmJqUekbXyprXHrfx3/wPGEU99ruHTGIe+Of/Bjwjfv0E5daSUW0bzc
 sE+ya1PFkbdirpgA3kGawNSvDIWahc6JXniwSRAKqz7TbIuQHNrYU53czY844K9W+CBMJPqLZpj
 fe1j8t8P30/fvizuS5KLY1n6eu1PGa1pGWveFdzJCH6x4AsWP+3cmTf63KIP3v/VLcCOv3p8vAy
 9nnAOIKcfbVMC3J1QPZ2dQno/2sEAcCkOHBj5I9yIubxlH0pB6xMtOiK/FXJw23ijuhjUawQOiQ
 ezi+hRNTBH+WGjcFtycFLfu/BNbtO3zV9qg4kRmbEa3dKw1TMTKdSsfIn5oflyknTy3gW2Cui91
 bi+Lio64PnhY3w8+CcE2lj22DL8ZPfnU4cOp9/zE5GQ8YJqqpLlU2QEtKvJQ4ntF4uBWhKVLj6R
 Inmfot75T5Jb4Vel5rA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070084

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


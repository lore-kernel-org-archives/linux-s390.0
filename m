Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0F3382378;
	Tue,  7 Apr 2026 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595095; cv=none; b=Bgd9lKu60xE0e+WApzdntE403RuqJCLGA62NPdDnb8PqYcnqejlCuxBDhZzZKwQWmoFUUaxwOiJGNnfimmZFgDhG5n1mv2FalDEk0nEGkT+dm/dnWyh+cMFgR2ey3x6rD08pxAXyR2uxltRzPM+HCOVMyDAtiOJkh+yLhyXPXjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595095; c=relaxed/simple;
	bh=q5TOYVvcbyENe2vtmk+ncC1PlpwJ4dAICqi1ejiSciA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkSK0Ha/ZgSDPfzPahIrPEbDM53rN08B6rx1WVIjQkVA22GUrwpa8POGHr3sETRYMDLvYWTVH0+LF46VmHcobSyb02gFweGzIt+GRF8Uid47fuQD61HjmSj6TwACgztAY/WJLutwCMYc1dNGbHf1bb58hmNFwwGxH7owhUB/Ofs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NcwQzfuN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NcwQzfuN"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637Dp4Xc2326073;
	Tue, 7 Apr 2026 20:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vEDthj+aEsHEVTNlB
	FPcESnlXhd/geVJSKTnKpWEIeE=; b=NcwQzfuNYi64US3LJzM8XitycGxQwB3k2
	EGHOvpk6bigGkxfgPiHKwI2YcT3q5YxnAXh7vWPBa08AHgc7hIPI6MpXlVuIfO5Q
	0qV07aGVlzDVd4lHfCXE+byJ6P/9xwYhgGGmKK1h1j1n/MN3/jFAckci1gSvkMrt
	/fVUJLjSOzsz87eX7nUMVhCsgmUq67XdJD3h0xcgsXLP2+Sx91yoQhS2dpf1G3OX
	OhQordShR+7Q22PxnT56OVLxBAwqSmYeapCQuNqpf0p8cQ+y/cwdA486CAvUgsEK
	nwFQZzw5skUTt5pyFYGjvyJUI9FaohnGQUuNCxLWqDqGC0fN1KoCg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kcnu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637JHcg5014378;
	Tue, 7 Apr 2026 20:51:29 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg4mtkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:29 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637KpRTt6161198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 20:51:27 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 466BD58059;
	Tue,  7 Apr 2026 20:51:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD20858058;
	Tue,  7 Apr 2026 20:51:25 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.101.194])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 20:51:25 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v2 14/16] s390/vfio-ap: Callback to get the size of data to be migrated during guest migration
Date: Tue,  7 Apr 2026 16:50:30 -0400
Message-ID: <20260407205100.331150-15-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407205100.331150-1-akrowiak@linux.ibm.com>
References: <20260407205100.331150-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4OSBTYWx0ZWRfX+O2kGFV4h4F5
 NuzNKtX6n7WN6+bVVNF5IgBD/wZN0Y3J8ZRjlxeKe/FwEd43N1OCMxYKKfkLskFzH/8SSEkx1WO
 /IACpAKuY2BfAmwjRv6N71QHYGUFIXsSKSSX0xRuwivdopGyY9D7zJzg98fukIKYRY7/ObsAG9N
 B4oXI1rVRWsvUu4unYPhT+ADAiAH4fJMVL1JDT38u/ZspFrBu+XRV2P5J9PCYqvO3kfQId7u7Xx
 0DoAKQkrGeIIKD8lVlj7FPwf3vg1YFSM132OTfYxypEUmQODNpVd2MP/9q6zzF44B6B5PHFfGuu
 VnH4veXKylPpwOXNL25Nwn+G42JsJhgf5gf1pbi+cNk1GV9DEGoi8jyL77zuh/fapcOapkwi6s6
 r698Y8p5eNP+Nk6BKsAr6pqIjJFGds5IpYQpwaWTqRJberWgV9C8+OnM/o4/+3LzI801RreS94l
 /tMU0sDKQzIgcjEBdKA==
X-Proofpoint-ORIG-GUID: 6jPwEGK_DzP451pBnEuItHEvpGYdkj5k
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d56e52 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vZ-Ft76KQvoWVpZ_:21 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=dNOmgfuV3ZSo10a98CMA:9
X-Proofpoint-GUID: 6jPwEGK_DzP451pBnEuItHEvpGYdkj5k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070189

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
index f9b219083e0f..ad751df33af0 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1033,7 +1033,18 @@ static int vfio_ap_get_state(struct vfio_device *vdev,
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
2.52.0


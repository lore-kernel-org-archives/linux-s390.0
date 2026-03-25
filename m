Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9152B3264D9;
	Wed, 25 Mar 2026 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472521; cv=none; b=ei0tmLlGiLqyC5YNLCrr/4+RlrThzf8HLPJoJO5HWxML8kdWMx4ksWwmsAKPsSp8jqNyo+v+UB4HzKEA3GRCTI+ym7JwzpuQXxcczwIVO7s9y9sGbe8Sve3WHeKaY3PQ0t/8298/0z2d0z/73AbXXx8CM0EnrM9/ohEpZk0ZRgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472521; c=relaxed/simple;
	bh=Jbg5tReGP4DqzSflGqDEnwPJOObH5/PLrLZ/LD3W9cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhRMT1hOjjllVDuIpoQFZ5I6ficuPPfM3AwJVKIU7nD/RSgaKP5KRENsJKjmsuyJ4GDGlT03wZ03xw0GIdhNKZ8vj7vVNuBJy6Wslwx1FS6AVoNpunKYX0GEaTZhTVGyudvbsAyvIWf1zMod8QYoX3gIoDD4Svn2KkcUXUNAzqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BXIUmAjs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BXIUmAjs"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PFG4El2665123;
	Wed, 25 Mar 2026 21:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=c4OAktMSaRxE9CV3M
	XiOV7sMtw4Du7qGD+4GsaEwCSM=; b=BXIUmAjs/sB897cPJ3YGxS5UFceFMG3gV
	6L9cp7hmuUkiucUrg7ACSaYZYGi2JE5qsPtX4XQa5ZcJWNBOLVwA8ivqUnQ5aCP7
	KBr6h2cD7cs+0PahvlU60nyrlht/fx4/InsY1usYLTtPwp1nV4Y05Wq0Z3jG2Lmt
	i2Ast0M686m9cglz3nHsaTx+HzEfNSCWW7nwTUBbbGr+YF/SMxl7mo9mLGnBjrsi
	vsDd+qDWkko9O0fnCd2XXzhWoNQGIzrEbWNHntaTk64BR4/OnBSFNKI8H5WWRCbO
	DykwKSZvq/AhpyN42s/3kvx9vqzByJQlhAWqQQxKzXayqe+pZdYPg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktv1hhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:01:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PJSBq7008749;
	Wed, 25 Mar 2026 21:01:55 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnr7qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:01:55 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL1rjj25232078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:01:54 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA5C958052;
	Wed, 25 Mar 2026 21:01:53 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B251358068;
	Wed, 25 Mar 2026 21:01:52 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:01:52 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 02/24] s390/vfio-ap: Store queue hardware info when probed
Date: Wed, 25 Mar 2026 17:00:49 -0400
Message-ID: <20260325210149.888028-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260325210149.888028-1-akrowiak@linux.ibm.com>
References: <20260325210149.888028-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K0QSp4cxrXHlOQssTz1J4kJOw6Om22h8
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c44d44 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=TnwwbuCvOpPni-GgRwAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfX6DNbOsPXoDBo
 QQDpgpnuPS4NbbFG9IOnWdcsBAQCgOMyxt4J2fmLV9q/YTb/7qy0HRo7VVZ05dVufBML5Xjm7i2
 jCM5UDPNktVRSSSKjW2wdz4SvBvbKUgUqpX3RMNc9/XnTiaVifohRzUuAWKxkho0c7efMaS/7CX
 lvqvzC9stfeRvS4/gP2IbZjOgfiF8WbquIE8AEDbSBZbrm2aEt18K1VlcVgQ8KpN4ai5DIL1YrY
 ArwNk1cT/jYhqe3r7xbO6N0cxGuomGHIKJ1RlN2VHnbMQUAEBF/WXv7UnUUOlURyMal4FVH5mbf
 EnXOx77IJ7I2EoPki7SfHYo04E5ljuYa84J2citKh39/VJmHl5vlZqjShexGvTuuKI3s72k8D+x
 0MjkEBZKb/jF35fUj+ppcq3e4mySSL38EhZ6cZFU7U1B9/nZQVoCAUlwrv1rli5C97+K/RdtA/G
 U7y5ivGP+UPOnCf4Eyw==
X-Proofpoint-GUID: K0QSp4cxrXHlOQssTz1J4kJOw6Om22h8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149

Store the output of the PQAP(TAPQ) command with the struct vfio_ap_queue
object when a queue device is probed. This data can be retrieved from the
object passed to the probe callback.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 5 ++++-
 drivers/s390/crypto/vfio_ap_private.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 44b3a1dcc1b3..ef3101f6865e 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2419,6 +2419,7 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 	struct vfio_ap_queue *q;
 	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	struct ap_matrix_mdev *matrix_mdev;
+	struct ap_queue *ap_queue;
 
 	ret = sysfs_create_group(&apdev->device.kobj, &vfio_queue_attr_group);
 	if (ret)
@@ -2430,8 +2431,10 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 		goto err_remove_group;
 	}
 
-	q->apqn = to_ap_queue(&apdev->device)->qid;
+	ap_queue = to_ap_queue(&apdev->device);
+	q->apqn = ap_queue->qid;
 	q->saved_isc = VFIO_AP_ISC_INVALID;
+	memcpy(&q->hwinfo, &ap_queue->card->hwinfo, sizeof(q->hwinfo));
 	memset(&q->reset_status, 0, sizeof(q->reset_status));
 	INIT_WORK(&q->reset_work, apq_reset_check);
 	matrix_mdev = get_update_locks_by_apqn(q->apqn);
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 9bff666b0b35..39c85bab05c3 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -150,6 +150,7 @@ struct vfio_ap_queue {
 	struct list_head reset_qnode;
 	struct ap_queue_status reset_status;
 	struct work_struct reset_work;
+	struct ap_tapq_hwinfo hwinfo;
 };
 
 int vfio_ap_mdev_register(void);
-- 
2.52.0


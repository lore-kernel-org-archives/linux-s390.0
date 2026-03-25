Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F36F33C51D;
	Wed, 25 Mar 2026 21:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472545; cv=none; b=qbVSRkjcNupujFeB4skbJsE14pU7oz28xZWKKXKFS+i5qVcEA9x19XI47Fnt5ZlOk8wauM9NX64CjRRmqwa4wMDv0N9baEV7Rj12vDbwqtpZJdR9lLhvPSdpIvVf9S3upF0cFagWYsMyl7+qF0AGApULVLh3v4TeFmaq2q2aLYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472545; c=relaxed/simple;
	bh=ZMYVh9y2crFkEKfAj0FsywjfRTFtIUhuX7Zg0+UGYQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJtOSe31RA7cgd0dQA5hDtOhvHaAD8oEBkamowheCzK9RNEliT93RbWmWYWKeJkVgEGfGKG8+IXmB2ajcIpXcMmtqnKxRj4A1phuUEXSqxDnbfmIy5+RWzC+JkQzK9CVI4hqJmq6kaRSgL227v7sGOsz1tm7+hGQQOvL84SS7eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N3P3FwoL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N3P3FwoL"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PEipQ52664877;
	Wed, 25 Mar 2026 21:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7Wy00jRlb5i4CubN2
	2qDRIAndGEJ3vI0vn5+E5znbo8=; b=N3P3FwoLoFlGUO1+sJQB3aomC8MhqoCTQ
	TZo3MBRqbv7NRqZobr1un26DOMnADTqvsVHbOXllt1tpyu5Tv1UteJ/dpTlr1Obx
	rM+uOWevSEuT2tmilZPE/npKBYqR1xzsU9JsmPsi9XQpOLyRPoXDdSCB7Gkyrl4k
	bs0wER1KAIxBqHo/yuMg/nkwfPhia4BQL+/qhOar/iHweMwcse2qiAuoaJVAw6mO
	0/xI2i7rrVpxgaGZaPCsLQG7RTf8Z+UmJqH9fWD6TjAQKB1TYmo737Z+uoNWj4W4
	c/g1Q/5cg1YI3tM9Gqz07Ju9Lvy6fogscg/7y+sCUlAgDcjWcpN/w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktv1hk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PKw5uD004380;
	Wed, 25 Mar 2026 21:02:15 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c27yd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:15 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL2DRV19399342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:02:14 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 999C658068;
	Wed, 25 Mar 2026 21:02:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A16C158056;
	Wed, 25 Mar 2026 21:02:12 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:02:12 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 20/24] s390-vfio-ap: Callback to get the current vfio device migration state
Date: Wed, 25 Mar 2026 17:01:07 -0400
Message-ID: <20260325210149.888028-21-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: XrlngK-rxkO77sRrpwuaYZynZ4xQf7KL
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c44d58 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=3m_Bk1FAMoj1bHXj4eYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfX1a3xCjX0EjGD
 2z8NS8fXwf9HzGn6Y8cihezc/ywBkCESEn+9KsZEa/b5iqOL7Ft2c9hrNZZWWkYsgUGo/cj26pY
 e2K1j6SEvCINziiBqDdM429ZdOP9CHWxwi3q4D4EpS/HipyQ4NOISDl8vhUlBLzLZ5pSZ48yoLU
 vUeS8UolX5yu1vmzNhvdTRXEpLeTtrUiH00B1u+EGNcrm5o6SdfqZchsY4Gk/rMCBnqgWHxlv4e
 KgYJnPhHMUqxi9c5IPGa4AukofDTM3AhjnlSfGUKm+1g44IjPM2K8ty7UPW9AIu4yR9ivonGJmU
 oDmU/NYQHTj/1OWZVLpmzQCacK8koQK1C7W6sfxfS93e0Eqydp3LiMWI4N0REhjtPcaLMhAFZ9j
 JymxU2B2MqgFi3OgJVgOVMcUIeOC6TmspS9qEkOT2EIdXW0VcuXPbjHDaCMYxvEwFoMWxR26jVe
 3dy7cFMWZ+jt0vG3J6w==
X-Proofpoint-GUID: XrlngK-rxkO77sRrpwuaYZynZ4xQf7KL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149

Implements the callback that returns the current vfio device migration
state during live migration of guests with pass-through access to
AP devices.

The function pointer for this callback is specified via the
'migration_get_state' field of the 'vfio_migration_ops' structure
which is stored with the VFIO device when the 'vfio_device'
structure representing the mediated device is initialized.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 750299fb1a84..305fd3221be1 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1014,7 +1014,18 @@ static struct file *vfio_ap_set_state(struct vfio_device *vdev,
 static int vfio_ap_get_state(struct vfio_device *vdev,
 			     enum vfio_device_mig_state  *current_state)
 {
-	return -EOPNOTSUPP;
+	struct ap_matrix_mdev *matrix_mdev;
+	struct vfio_ap_migration_data *mig_data;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+
+	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
+	mig_data =  matrix_mdev->mig_data;
+	*current_state = mig_data->mig_state;
+
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	return 0;
 }
 
 static int vfio_ap_get_data_size(struct vfio_device *vdev,
-- 
2.52.0


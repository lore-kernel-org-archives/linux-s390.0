Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B5137BE73;
	Tue,  7 Apr 2026 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595094; cv=none; b=uUZOQ1iHHmL5iLsTwOKF/+xcMJqALlEBzVTjgapUDjwBH1S19tAkAXv2D1Bffaqp6d6hpGMOXcRJIUd2mQDGXUK/pm6jvaWs9opEepWICbIcJQta2xePbWfkjmcpY45ChTJQhD6BNyWO7g7jF9jSqk0mV7RV0lfynEr2GpUhOaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595094; c=relaxed/simple;
	bh=X/rBcfqT1qU/QCBEbKYX/xG2NFGTE4mJvjdQeaaK8RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AI71l0p/QgiHkj9KO8vMV5CVAM0YIURB4tVYK3+Aq8VkMQLDpMpz//+oEeEtbJcE3+8ksUwWCUTPP5rCdObeP5373FtNF/pGf+7dQDphByj1B+RiwaSH70jYpTSkcr+z1CE/ZKLXNi7pbAhWO7Sc8CC0yxRw36p/v189fPpK3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dZJiEEL2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dZJiEEL2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637Efp9e2303490;
	Tue, 7 Apr 2026 20:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1PVIxfhdpJrfq+4w6
	V49ag2FuZpXOC5DJW/Apz8oQiw=; b=dZJiEEL2hw/YbVkCwS76Muytn3YqD7i7b
	Xnbl2g03GtHe4e+U9AMld4GhImIvZCW8taGH2+EQcz3k89zkuCv4DXRuEVwiddey
	xJNO5eFuOm9G9dyJxCFzg5o4VrvPbm472v1QReZyYpAYAjWXAbRCyk2WEIcL2UR9
	c9RghXhkr/uFlNVujp6M17n+D8n3qXs4yrFcLXXznbJayNLJroiBci1X7T5BB45E
	Y7FxkCey9Ebhd2swHT2u51fydtoIcXhZk057dKvt4P8bT5P0bZlmtCvu9n6yskqg
	rYFfSeobaEVqrh5hG6X6JdFOB1HHK3gANzxEAbsJG6kzOJhi1fZmQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fd2sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637IjPiJ007942;
	Tue, 7 Apr 2026 20:51:27 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2cu13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:27 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637KpPDj13042274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 20:51:26 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 942EC5805C;
	Tue,  7 Apr 2026 20:51:25 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0627C58058;
	Tue,  7 Apr 2026 20:51:24 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.101.194])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 20:51:23 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v2 13/16] s390-vfio-ap: Callback to get the current vfio device migration state
Date: Tue,  7 Apr 2026 16:50:29 -0400
Message-ID: <20260407205100.331150-14-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4OSBTYWx0ZWRfXwIxdg1ZxkAeg
 L5zl6fSo0eakVHI6NzhafIWOPVP1TdieLiwul5X5v6BOP17N+05RliUozIEkXv+BsHGJjbcSWYW
 zOnyZPBpXwajLpWGJwxttSUfmAItLB6U+7hqSdgiP1KhrfVEyIhq1l2aE8OX9dvxHUjc/HQdDu1
 brJlznXx/SqWRwvaP89hXyG+kbf3fu3x6+cn2V9SAJQ/AmIkFxaQnUUU04wBN/8XOE8AWacApcQ
 Zd7LppWlI4niI0MKKcrH6SXxkI0IG3LiaTuVfIK7jK6X2iDxe+Yvap09wmp+kBbndSSFV8OUTYA
 a+B98/CgAFnWIC/qruaX5VEJ3o0QctC2KeIycJ4g0QfRFK4+b5kl11kC2w90j2km+7I0jvy30HD
 0srqQZf3QISbgmiOG7WobnfuQa6Th3nh2wz7j9CWp4BuvbUP5D4Z08keSBt2iqaf6344cd7ujJi
 N3mA3WpVf/hCY4H3Ykg==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d56e50 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=3m_Bk1FAMoj1bHXj4eYA:9
X-Proofpoint-ORIG-GUID: Go319cOfNfnfjOYl0wcwh8h_R5BZPY5t
X-Proofpoint-GUID: Go319cOfNfnfjOYl0wcwh8h_R5BZPY5t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070189

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
index 28209d8476d9..f9b219083e0f 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1016,7 +1016,18 @@ static struct file *vfio_ap_set_state(struct vfio_device *vdev,
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


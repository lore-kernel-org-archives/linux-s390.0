Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3AB37B033;
	Tue,  7 Apr 2026 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595076; cv=none; b=mfj4vXEP64x8J7Nb4+M+DaSnIYFNR/tjgoFel7cee+eyHi2GonLdkHdamEfWYwJkB0xerdd2gmHG4KNpYFSLJUlnzDIhnMyWgo802C0ZFxfvAFYAwpOpkSFLwYQeYcoIN0KPutoPDgzZ367iO6s1l+B3/Twhw37pi/EBP0cORDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595076; c=relaxed/simple;
	bh=woITMfbXQfKGswNRfdlqlBqqZ0U5Rllds2mj7PPz1XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvFZf4CsAuIK+1oEnGDPuNt/WQ8Wi+vFn33c6/RC1ADcKGXhLZSqUpwJK4DteHV5UADa1sl+uXiP0IMG4GZn74SBW4KBbApjx0dPQpM6/CGe01yGpp5G9SnxQaN48mGdAhi588ydIMHtD8YBL5Q7rNGhcJtZngCoGbpLWA8bGiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wzfm9apL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wzfm9apL"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637DSrFg2302379;
	Tue, 7 Apr 2026 20:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PzosAF6DMyyWiGzFJ
	t8R+3Zb+FSwaKqKAhCSCWjVzgw=; b=Wzfm9apLi+l29lLpGTVqeeTSB4NDO0M4O
	dFRZfJu9ZXKFtwm24kwyfoq+Rs+sKs72AZtCyscs7JGFoKCuDr+aZq7PlrKkYbDB
	ys+Rqx0ZSJ2b7CydtSex17V0KHk+8l+R6kOu9T1iOeQ3D6oAZ9Lnevm9MzbnkOjZ
	ztbAED+cKo/b4xHDIdcbiBpozz76PSsCg38dxCocOwFDS7pEmFDECV8CHgc4DF7C
	agcEM5+HH/SC8nkZNzbWlKbVsi+d1hMGLazNlDwejg4I9lo3LUZFMJa9hULnBo/h
	piAJc6ga7obfINZcYiJuwnnyWh6SUSPi4si+1UeUZRgAfpPjcW/VQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fd2rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637ImRlC007881;
	Tue, 7 Apr 2026 20:51:08 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2cty7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:08 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637Kp6qU30409234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 20:51:06 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FCFC58058;
	Tue,  7 Apr 2026 20:51:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6DEA58059;
	Tue,  7 Apr 2026 20:51:04 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.101.194])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 20:51:04 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v2 02/16] s390/vfio-ap: Provide access to queue objects and related info
Date: Tue,  7 Apr 2026 16:50:18 -0400
Message-ID: <20260407205100.331150-3-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4OSBTYWx0ZWRfX0GjwjhU2IohS
 3jL7JgRd/BiS+Pwi7RiETvlQwqRlkjjpopNSI5CBXpWX0wTyHqGxSAh9B7YJVzJGF40b4vOpnbu
 Ai4TXLMeC0FfCEdi5xzA8FkKLVZmsfdGw4wq/8q1hDuDa6/CtTkPRjNugQ7TBZoDQP87PyHDu89
 7mwQVfukPKaINUZBvlZ0jjyzuK4ud0P/WcpKlrqqQKSd6PTuhvxPtQkW8zUta8c81tXAisLd7X3
 rjuswpAV492wYtloKofVSkbksp3JXlXvTdxZv+1ocuNlW4clZ3hGSOaC/l5rSYogI2NhGAIuzVb
 SR22tIAP5ZE1zvArZmzv3vAL6O0hCIzk760IumWRZlAcrAYuSQXHOKqYcwACRLKiH9mV9ZUoRP8
 g8H3okXZH2RhlbCwaEXIajFSMBS8pa1VQ/Fk2rE02L76l9/0Ej7lbwgzjqPPoidYWdBcnuNZyh9
 9w+mSx87tHKC1M2banQ==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d56e3d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=aJOwoqrUralclMrAr6UA:9
X-Proofpoint-ORIG-GUID: WnOF-2kGK3opY9goTc1pd5GgR2Fr1B5G
X-Proofpoint-GUID: WnOF-2kGK3opY9goTc1pd5GgR2Fr1B5G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070189

Provide the following:

1. A function that returns a struct vfio_ap_queue object representing a
   queue that is bound to the vfio_ap device driver and is assigned to an
   mdev

2. A function that returns the number of queues that are or will be passed
   through to a guest when the mdev is attached to a guest.

There is already a function for #1; however, it is a static function in
drivers/s390/crypto/vfio_ap_ops.c. The function will be defined in the
drivers/s390/crypto/vfio_ap_private.h file and made non-static. Note that
it would probably make sense to ensure that the mdevs_lock is held for
this function, so a call to lockdep_assert_held(&matrix_dev->mdevs_lock)
will be added to the function implementation.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 20 +++++++++++++++++---
 drivers/s390/crypto/vfio_ap_private.h |  4 ++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index ef3101f6865e..cd85866b81a0 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -203,12 +203,12 @@ static inline void get_update_locks_for_queue(struct vfio_ap_queue *q)
  * Return: the pointer to the vfio_ap_queue struct representing the queue or
  *	   NULL if the queue is not assigned to @matrix_mdev
  */
-static struct vfio_ap_queue *vfio_ap_mdev_get_queue(
-					struct ap_matrix_mdev *matrix_mdev,
-					int apqn)
+struct vfio_ap_queue *vfio_ap_mdev_get_queue(struct ap_matrix_mdev *matrix_mdev, int apqn)
 {
 	struct vfio_ap_queue *q;
 
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
 	hash_for_each_possible(matrix_mdev->qtable.queues, q, mdev_qnode,
 			       apqn) {
 		if (q && q->apqn == apqn)
@@ -2098,6 +2098,20 @@ static void vfio_ap_mdev_request(struct vfio_device *vdev, unsigned int count)
 	release_update_locks_for_mdev(matrix_mdev);
 }
 
+int vfio_ap_mdev_get_num_queues(struct ap_matrix *ap_matrix)
+{
+	unsigned long apid, apqi;
+	int num_queues = 0;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	for_each_set_bit_inv(apid, ap_matrix->apm, AP_DEVICES)
+		for_each_set_bit_inv(apqi, ap_matrix->aqm, AP_DOMAINS)
+			num_queues++;
+
+	return num_queues;
+}
+
 static int vfio_ap_mdev_get_device_info(unsigned long arg)
 {
 	unsigned long minsz;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 39c85bab05c3..d66586825ef4 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -153,6 +153,10 @@ struct vfio_ap_queue {
 	struct ap_tapq_hwinfo hwinfo;
 };
 
+struct vfio_ap_queue *vfio_ap_mdev_get_queue(struct ap_matrix_mdev *matrix_mdev, int apqn);
+
+int vfio_ap_mdev_get_num_queues(struct ap_matrix *ap_matrix);
+
 int vfio_ap_mdev_register(void);
 void vfio_ap_mdev_unregister(void);
 
-- 
2.52.0


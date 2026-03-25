Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFF3327BFB;
	Wed, 25 Mar 2026 21:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472526; cv=none; b=bwNWy5OzE+hgpSjMNEMkosSenXO7p22dMmZq9JmwbT+naMwEPBR1t2XFJEjO1WrusySp2itgq63hQbVIuqrlK5qGdc5lWkshbqkk6P8v25VUc1vCcKl71gWYEgN0S8NXtqAW6AKnJNQIy5b0ms8xij4jJGUNRqkDUGpNboEilq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472526; c=relaxed/simple;
	bh=woITMfbXQfKGswNRfdlqlBqqZ0U5Rllds2mj7PPz1XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nftaSasmoLEXvPbmwydwJlfSxjLhy18RwNklccHZ2qkFpZesqwhYyZfpRgLJ47Yv6RuBiA8omUWeU8r02Dh68ZD0HB+7OVofFZYDoNfvnFPCLrdbuwNAAydZBG1NKtDWgbumwEvkm34r8WiDCDmIWLLC2sbe8tXH5RdWVIvxvis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NkfGVCKX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NkfGVCKX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PC16bk819878;
	Wed, 25 Mar 2026 21:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PzosAF6DMyyWiGzFJ
	t8R+3Zb+FSwaKqKAhCSCWjVzgw=; b=NkfGVCKXU0pEw2bIR7gqNTxIkcIIAKClN
	8kJkdr5ZAU0gC5SiCaw5z4Endvgbsoznc/UtFmtEaf1AMIgwzjdlp23fjNuohRIC
	uLFHdpLvMD6axH7p7O8jPPvmxGXtDqhjwNiqaJu/Mk6VO+7q2S1BERXknFPXGDpZ
	0od71FkcgXsl8ltj/p9szOfX+VZTiHuhpTqejiqBsNFascC+wTvjTfEO6qhOmDxu
	Zruxtn4EOkw2qMoLPkjSIWTYfamcQBnqkvGw2aF2qjbszv2vlx/pdyM7TSf/g8j0
	06ZXpbaTE6gUmow8Mp74Z0wAPn5OMlHM6pR6VvrPNHlNwqE4oJkrA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumsjr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:01:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PK04Yg009126;
	Wed, 25 Mar 2026 21:01:56 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnr7qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:01:56 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL1VNt26542758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:01:31 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD4A158052;
	Wed, 25 Mar 2026 21:01:54 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C95A058056;
	Wed, 25 Mar 2026 21:01:53 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:01:53 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 03/24] s390/vfio-ap: Provide access to queue objects and related info
Date: Wed, 25 Mar 2026 17:00:50 -0400
Message-ID: <20260325210149.888028-4-akrowiak@linux.ibm.com>
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
X-Proofpoint-GUID: 2vgpeMwLyBN22ESXqbu0ufsXYy6JvTqI
X-Proofpoint-ORIG-GUID: 2vgpeMwLyBN22ESXqbu0ufsXYy6JvTqI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfX3mecj5MxGQ9G
 8TL4ce0M2rn5yeT04+3tMUvNP5FPPOFbz7EnR55jnsqnmOCaJD/p3bHoHvmeRhrO0DwNQrot72j
 Gz3fwUe05W3N3ohTgPbran60x40FoylDdmDFsZ7UX9KgmWkbr5FxcvX5Chypbt0qSkNqshHZzWL
 2/+wxMMhOt7Zm0WtFXw5RKppWV5tsNSroGIVPXfWVuT8KCy6uDGkki3BjqHtts9SgWQD67JOHUz
 DNzDqnP0KvD+DEZlXfH6QxEQjPo23XWZpF8ZM77F2WmGDJRGT3p7ObqkluEoZ9t1J5SJVElI7sO
 dtd1xe3atJUhT750ruKEUWwgU5QUWVRbFpbz9Rfncha1Fi/HHPbzkuGt+yEQMGg0Hs6WgvnNX8Z
 TzvQT+LwiAymQT6S9tLDlJNliJ9otFjknLbixxhgnWb7z5BW2czb08GmoDvQnESrz78H9+EpLd1
 nSlNs3QKeaQKhStx2LA==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c44d45 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=aJOwoqrUralclMrAr6UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149

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


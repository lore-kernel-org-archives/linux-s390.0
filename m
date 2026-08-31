Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3774A5EA4;
	Mon, 31 Aug 2026 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196503; cv=none; b=BI37udWSvO2GvXdCBnNz718uuohwDy/g82b0Tlbwrf8Nxm29RLyNPYmzoA43JJvqIbqfsbfdvySWcXfLe/CHfr+a7RXYFfHlRANUJ5eKpA5PXBP5Zn97tYRhMRJxfyr+2teNVMoQI29iNTrH98t5Lj6E2+yTLVNolLGgyiTt4vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196503; c=relaxed/simple;
	bh=NKBvcvXQkm6OPik4Bkk4UOBR8sbHP9sYXzt8QIPxrtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWCsP7yGZzUIhs1jbsDColKOzjGJyp/aVrUSJLTCuJ2OqHr32RUHv+lrMY8Qe52FfINLleU/itc4DkjK7/2he9zCYJW/tghpZPt0PAZX+CJyBmTcNLINC0u0aIHjngkpKJzqmYAHsBQUsi4yZFEv5WdHsD2cfYbl37Chbm5Wxac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I1RR+Jxz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I1RR+Jxz"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VG1YGn2743498;
	Mon, 31 Aug 2026 17:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4Rk+90ci341HS9i8U
	pd5NPgb04DKhBUD61HAxQjDrsw=; b=I1RR+JxzgWmsPzpSViRcO9Ic7XxyxNtjE
	rTXiCxdbG4I+wb1iIBzXM/ToOqtUSLftoZhaaxspJCJzc4cQqOXKUxNkjNb1rScC
	naulMtf7o0Q0IEEUz8ocSGhtELv7mqa5gyMCGa5uv5Fi0kKf5qaThNtERgnIslHn
	0KbO6678XLyI7hdGJHwwDeERDSLJ5mhb/DIcDHaHuM7Ph6eCr/nA8Q9oVjbYACJU
	jMaBRTp+ctjYfF044IPW3Pz6V9an6t9v2RWpOYGs5WcqabrKioj0yyvUCoHu6pZU
	AahcxrowwrWg42IZA7FF80SIa7OfabkYOEGiEYeAMtC6uYwgEcD2g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54jsdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 17:14:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VHBPP0017293;
	Mon, 31 Aug 2026 17:14:54 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gca4vy73x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 17:14:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VHEqL812714520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 17:14:53 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD12C58054;
	Mon, 31 Aug 2026 17:14:52 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3436C5805D;
	Mon, 31 Aug 2026 17:14:51 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.29.117])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 17:14:51 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v5 4/4] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size in vfio_ap_mdev_cfg_add()
Date: Mon, 31 Aug 2026 13:14:43 -0400
Message-ID: <20260831171443.222225-5-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831171443.222225-1-akrowiak@linux.ibm.com>
References: <20260831171443.222225-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0NyBTYWx0ZWRfX5iFG8mdGb5XO
 SLXMshjmV7vjSQSiJf+5qBRF4Kq02qhoQRX19uPBmo9rj/sQVNT5hetEbIyBHJRkSwE2NBWqqbq
 ccc9RPqoCGL31kIVdcPe/DB3H8ApUpwQvbthbQ94punioaZNiRchE03MWUmQ2HTMMDT+SP4XC+T
 0jFM9n+aNQu1P0exor1sE88xzenUO7Yjg8nN28A0AKuPq09HivTOAgAti/+mcfbbwVRoeLg7PKt
 eQUruXz8YeU3K/oqsv+rqnhA4qkBU3q2+pPKN5ii0DSFJgoriwlvar+24eKxLAHCBgRA2Gc7fRs
 sBw9BKsqpp+nIC7GBgC0+UUyc5pevot+YgPazgKFzUj4zUtfrS/6BnrQDWkMgA/2VyuP7ovTqHP
 B3UipgHgaLF0goy55/46ahhPKHQFq5Yu5U6aT+7ymBWHaDQt4NIiT/Lm2+T1qAanAUU628HpYM6
 D3BpWKG0LQ3bvN1lpDg==
X-Proofpoint-ORIG-GUID: kjA1Cr7d59fGaTd10XswaE4vmV7J8WbC
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a95b68f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=gReD5cTbzgwmqpVxveEA:9
X-Proofpoint-GUID: kjA1Cr7d59fGaTd10XswaE4vmV7J8WbC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0NyBTYWx0ZWRfXyrFdoZQEwNtx
 fsCL6Mw0TYGPW4C8lw2n3/j34OHoI4RN856/gy3kgZiybjwxZMTAiitkL8dTE8qHf7qiDGtenu1
 cPZnHctr5V6f7avBlr8J/Kr1sYb5qZk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310147

Domain and control domain bitmaps are sized by the AP_DOMAINS constant, not
AP_DEVICES. The two constants are both 256 today so there is no functional
impact, but using the wrong constant is inconsistent with every operation
on aqm/adm bitmaps.

Use AP_DOMAINS to keep the code consistent and correct in case
the two constants ever diverge.

Note:
This patch was submitted in response to a sashiko review comment pointing
out there are other functions besides vfio_ap_mdev_cfg_add(), so there are
fixes included here for those also. The subject line was kept the same
since this is in v2 of this patch.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 6c315d7a0a08..70c179e9cb19 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1517,7 +1517,7 @@ static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
 {
 	DECLARE_BITMAP(apqis, AP_DOMAINS);
 
-	bitmap_zero(apqis, AP_DEVICES);
+	bitmap_zero(apqis, AP_DOMAINS);
 	set_bit_inv(apqi, apqis);
 	vfio_ap_mdev_hot_unplug_domains(matrix_mdev, apqis);
 }
@@ -2910,11 +2910,11 @@ static void vfio_ap_mdev_on_cfg_remove(struct ap_config_info *cur_config_info,
 	do_remove |= bitmap_andnot(aqrem,
 				   (unsigned long *)prev_config_info->aqm,
 				   (unsigned long *)cur_config_info->aqm,
-				   AP_DEVICES);
+				   AP_DOMAINS);
 	do_remove |= bitmap_andnot(cdrem,
 				   (unsigned long *)prev_config_info->adm,
 				   (unsigned long *)cur_config_info->adm,
-				   AP_DEVICES);
+				   AP_DOMAINS);
 
 	if (do_remove)
 		vfio_ap_mdev_cfg_remove(aprem, aqrem, cdrem);
@@ -3025,7 +3025,7 @@ static void vfio_ap_mdev_cfg_add(unsigned long *apm_add, unsigned long *aqm_add,
 		bitmap_and(matrix_mdev->aqm_add,
 			   matrix_mdev->matrix.aqm, aqm_add, AP_DOMAINS);
 		bitmap_and(matrix_mdev->adm_add,
-			   matrix_mdev->matrix.adm, adm_add, AP_DEVICES);
+			   matrix_mdev->matrix.adm, adm_add, AP_DOMAINS);
 
 		mutex_unlock(&matrix_dev->mdevs_lock);
 	}
-- 
2.53.0


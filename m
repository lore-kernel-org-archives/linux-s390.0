Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861F3438021;
	Wed, 12 Aug 2026 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535536; cv=none; b=TzL36iFfQ/ZTEZp3NQ8Oe4IyPK9YZ0egQd6OYRV8wOrttTagt5ONosrXVQOcp5rf/dEetxZpIrMH6UsthnEDMtcFctzLO76EmcqFmjEUvVSbj4XzudwZ9lOcDj1FPHu5zvRNl/rYYJb2us26omiFI0BXapNTvp6Sww+snWJKJfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535536; c=relaxed/simple;
	bh=WnWFlvYXDTgJdc/NeRJsJDveLyX9KEUNzwp2BKHumQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDOYrTWrpSr13PzxGIM4r9F/fw+ucIITUGay+vXiBiz3ReVRbVKqIVqVHp+GjZmvtyOKLHWoqCaFYqwFZ6lghlPAZZloHIeO6lNqa8lTa3nZIQ316K5y8sUU1q0jfGx3aiqIcoICb5X+9VOvv11O5krGCSWg9j/0uwB4fYaSzXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i/EKeLHV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i/EKeLHV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3XCk3214191;
	Wed, 12 Aug 2026 11:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zV0f4Op2mPPk8zk/d
	9NiqgXzV/VwkAcO2oRh8X6NjQw=; b=i/EKeLHVZSHPRDJ3smMSVKdB3dJkUGSKn
	hDzi3nt28aMGZkM0wS/IjJRpqzmCPw+p2XSAk0UhR7ZK1xcfPINOpjyC4M5t8Kfg
	TyZ/0mGCRhAzOE0IC8pvELgXyfHkMJVI3DYZL+oooJ9DHz8sb6a0EtbVEYWF4xv2
	/2gvR0h4IUqrhZmHJT2hgkYssBD8My7qI+5vJ59J+V1PtfGS2/Nt3xEs8PXHkXBq
	LDV0T0C6LM88E6JwMrEoJ/+bfIz/qSeBr/pcp1PX0ggm9HPXc1NGdjoXEwVr/xp3
	v1fP6Q5MiXGPOI9M6DqGNTGY49vwzX7DxtI8IAQDWKO3XoTKky8og==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp31e8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:52:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CBns5Q018709;
	Wed, 12 Aug 2026 11:52:08 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gdp7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:52:08 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CBq7lX20185810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:52:07 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F19B658043;
	Wed, 12 Aug 2026 11:52:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BD3558059;
	Wed, 12 Aug 2026 11:52:04 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 11:52:04 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v3 9/9] s390/vfio-ap: Fix memory leak when queue removed from host AP config
Date: Wed, 12 Aug 2026 07:51:39 -0400
Message-ID: <20260812115139.576303-10-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812115139.576303-1-akrowiak@linux.ibm.com>
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c5e69 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=VrB3zfVs-A4ss5GmTxoA:9
X-Proofpoint-GUID: Im-rOFBz3vu8Okc81MOT7B_QiF6wFYND
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX9YFRyhMjSRAe
 czUEz55XQEq4y04QB9TiS98fUSNkkx+JL4fMlWt4y6qleqjn2XWk4Lc1Hd5QWobzqOcnWqnCeeo
 m6bjAAF099jX2PpCyVaRJdj9UG8L0jqLImY8z6eF/heqbEt99GUjK5rLPBSZfvecntaow6rHiCr
 MqmWckDhkmixDGiUUA804gjg57PiJCOglrvBlyKxmmrJRG+/cS++G3Rmy6MUrrvK+8fCVpgOcUo
 25QC/yUuZu7MZABNw6G0/HHm+VS17aaAn4ZA93FeDqEBXDNVRVx9Iboe3GvH5+mCByDtsJGC0Xy
 zeuZCkTn0NjqD6HJe6Jiwve89unRNUQoI2fQFaUZ2PCfwO2avaZ28gjGXjNmMJyh5dpy/sIKikg
 Gp5w88774fZjUrmvYbgh08DvYHomZaGi8JuA8bPjQIvLXcz1LftRqc2G/vsgRB47zt6UzSeOoCf
 wmcwMt46Kwu7iZQ27zA==
X-Proofpoint-ORIG-GUID: Im-rOFBz3vu8Okc81MOT7B_QiF6wFYND
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX86aNJ80iYsHH
 pVn1vRXzJfSTPfXtR5Yd9yg24XXmnm6nILXAiePf9SakJeNx+grCbS4bfJQDl/dKO203u6IUoP8
 lFePjKCL7v7ed5azArQDDwsRv7Ody84=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120093

When an adapter or domain is removed from the host's AP configuration, the
AP bus invokes vfio_ap_on_cfg_changed() to notify the vfio_ap device
driver. For each ap_matrix_mdev object to which the adapter or domain
is assigned, vfio_ap_mdev_hot_unplug_cfg() is called and removes the
adapter or domain from the matrix_mdev->shadow_apcb (i.e., the guest's AP
configuration) and hot unplugs it if a guest is using it. The new host
AP configuration (sans adapter or domain) is then stored in
matrix_dev->info.

When the AP bus subsequently unbinds the physical queue devices associated
with the adapter or domain that has been removed, it invokes
vfio_ap_mdev_remove_queue() for each queue removed. At this point, the
adapter or domain will no longer be assigned to the
matrix_mdev->shadow_apcb or the matrix_dev->info object because they would
have been removed by vfio_ap_on_cfg_changed(). Consequently,
vfio_ap_mdev_reset_queue(q) is bypassed and kfree(q) is called
without executing vfio_ap_free_aqic_resources(). This indefinitely pins
guest memory (q->saved_iova) and leaks KVM GISC resources (q->saved_isc).

Note that resetting the queue would fail with an invalid APQN error due to
the fact the queue is not longer in the host's AP configuration; however,
it is still necessary to free the AQIC resources. The fix here is to call
vfio_ap_free_aqic_resources if the adapter or domain is neither in
matrix_mdev->shadow_apcb or matrix_dev->info.

Fixes: b9bd10c43456d ("s390/vfio-ap: do not reset queue removed from host config")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 3652ba792be7..faab5e9179ff 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2507,12 +2507,15 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 	/*
 	 * If the queue is not in the host's AP configuration, then resetting
 	 * it will fail with response code 01, (APQN not valid); so, let's make
-	 * sure it is in the host's config.
+	 * sure it is in the host's config. If it is not, then free the KVM GISC
+	 * resources.
 	 */
 	if (test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm) &&
 	    test_bit_inv(apqi, (unsigned long *)matrix_dev->info.aqm)) {
 		vfio_ap_mdev_reset_queue(q);
 		flush_work(&q->reset_work);
+	} else {
+		vfio_ap_free_aqic_resources(q);
 	}
 
 done:
-- 
2.53.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84AF44CF4A;
	Fri,  4 Sep 2026 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514492; cv=none; b=eDUjm6qBEIxaukp9y3tgaUXqEQYSpcYtkN3VF+eS0c0WVUjSzqzki6FIYL+EcS+XhsDavZYtCpqHormROGI1ur9nb3/YtwZC1Ye+SN9EtYWN8AB4tmWh1aDSeDFcuqgEwyuQa54b+YIw0XXkWVymS+CO5SafcyBWbTtR5hxfBjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514492; c=relaxed/simple;
	bh=jU0O5D32I3yLGVhiDaDMpOGN8a8d3MxdA6ysTzjp2uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H28B6Odu/myN+kIgHvssVlPWJ88IGaoeWSYZTeFtVTzuqYTrSC7TTRLRUmV1gO8xhXl+mkzE6LWOylQgDaPb9mQqC7gzFiBeEqBLEVcXqVF0GSXjK51Sw0RZ1bGaAErvTTqjtfeKV3fnHgTZ2a5mWNzmNk5av7ivCckiXoiiBIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N1RAnICw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N1RAnICw"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464PFv814547;
	Fri, 4 Sep 2026 09:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=32N6XRHl6UNpI7TjA
	BVcX3+RZU5DPh0fptfuWtPQtTk=; b=N1RAnICwc7K+Dgnk0ZWPkZfF/+ADdw5V5
	eBVpDKk2wh/d2vP38PzTlEMzzF1VGQmSGIToReX7uSEHX4tVFt91YUnoo9aCFHRj
	IlRQg9yHdTH7XPkDKhIHJzS1ujCDS5ozwNr3SHvik6+AJE5SMHBeAwkVVY8ksm30
	gHP6EXyQ179uxqwLl7QXAqqJWSAXLdydQAAV1XnRdPwHPp843VvXWhTjjnjOfSVv
	nDY5mhlJe9f1pHr1Dc+ozFKGQaSWS0ooehpd3hYp1IYEKYRLQ3g7igd04m91Cj+M
	gOqOtdscVnXZaL94nTkhKQKo8NWRRwqyAVBFJKJTkpaOvVwMa80Ig==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuj9jh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 09:34:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6849QINk008893;
	Fri, 4 Sep 2026 09:34:44 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceym33v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 09:34:44 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6849YhGf33555178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 09:34:43 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D87BF58066;
	Fri,  4 Sep 2026 09:34:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C19C45805A;
	Fri,  4 Sep 2026 09:34:41 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.80.215])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 09:34:41 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v6 4/5] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size in vfio_ap_mdev_cfg_add()
Date: Fri,  4 Sep 2026 05:30:53 -0400
Message-ID: <20260904093435.1161402-5-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904093435.1161402-1-akrowiak@linux.ibm.com>
References: <20260904093435.1161402-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iEmWivBAzSkpHYjQ_byU3yhA8AffZVNN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4NiBTYWx0ZWRfXwua2+jWXUeHb
 9Orq5CJ0Nat5mh0cbx5AFOwuHwtp4CfQJC7u9Hg9POw+/XHMI7NTqQE7Q4xpoOp4OOS9zVBNsiM
 sXP6Cyovx8vxrhoJuEAAU9zYG88kSTcoJT2Ha6gnHLfWifQZimrdRnoHhzd+4STSQjmPvFVjCKM
 OQZS9ThsFc/usQZOu8W5Z77YPzUkoWhlGMLlfb4KnPjiPjc3X0H6AoFWuhZl7dd8vaJA4X2m5BI
 1EVWr42N4yYnw9j2QPD1p0UdTnydmywBjP0EedjCEJwbwW5DfPagUsc3uWiBT1UhNfpo6f0xDfJ
 coTAr5Ia5Q+VpnERsEpjI3r+ippw1qKGbcNM8tBNWE1qcDFAqMzQmIzKclORz7tPm9/sK6NY5Sj
 4DCjigVsOfubLkWP5XgscyIsJofjfTKUJiAohyyTUmu56ZQfyroZLOkw6mp/3WND8YmRzU73BUY
 Vwhe29U7w2jrk7VYS1Q==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a9a90b5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=gReD5cTbzgwmqpVxveEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4NiBTYWx0ZWRfX+F1D7qsFgouO
 qooF8p+dQD3I6FfMAyJ6s04AE4lPYO2cDXVDprNZ66w6BnNbHS3n20/F33KxtnsotdE4bnejmeb
 ze78YvAOX9r9OYn+VJl+BiycqNSQ7pM=
X-Proofpoint-ORIG-GUID: iEmWivBAzSkpHYjQ_byU3yhA8AffZVNN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040086

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
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 32b80d91a643..6a964f82c8e8 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1499,7 +1499,7 @@ static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
 {
 	DECLARE_BITMAP(apqis, AP_DOMAINS);
 
-	bitmap_zero(apqis, AP_DEVICES);
+	bitmap_zero(apqis, AP_DOMAINS);
 	set_bit_inv(apqi, apqis);
 	vfio_ap_mdev_hot_unplug_domains(matrix_mdev, apqis);
 }
@@ -2915,11 +2915,11 @@ static void vfio_ap_mdev_on_cfg_remove(struct ap_config_info *cur_config_info,
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
@@ -3030,7 +3030,7 @@ static void vfio_ap_mdev_cfg_add(unsigned long *apm_add, unsigned long *aqm_add,
 		bitmap_and(matrix_mdev->aqm_add,
 			   matrix_mdev->matrix.aqm, aqm_add, AP_DOMAINS);
 		bitmap_and(matrix_mdev->adm_add,
-			   matrix_mdev->matrix.adm, adm_add, AP_DEVICES);
+			   matrix_mdev->matrix.adm, adm_add, AP_DOMAINS);
 
 		mutex_unlock(&matrix_dev->mdevs_lock);
 	}
-- 
2.53.0


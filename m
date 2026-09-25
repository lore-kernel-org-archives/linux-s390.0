Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B9549BD6F;
	Fri, 25 Sep 2026 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340368; cv=none; b=hy4MqNajtcIy+1jLjMBuJl65mEY9KyaCpyOeY+JPR19CrFL8sV5XvByvFUiJQKIgGp8RLN0m7YUMgFNIgKvtsK5LV2tsabuDmDpuo87yJzArBWmz5QyQmUR1fvE4v5jhAizCe4bzAGr5ySUi0+otY2ZVj+KQXXvzcUMUz3/Eabc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340368; c=relaxed/simple;
	bh=C7HhFeZjcRIDVvo6sITTqd90TodF9Mhzc6Lt6c8Rzcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VW48HYSSFVL7LTETON9wTKnDNv/Sk0jzL/lOYNzprwzm5glMYJ6Mh9GBuXvl2BdS1YGDiJsyE0oThbTJDzx6aSLguQWYxzybO6MJr74BIqGytJbRdyYUcVGi3/VReEcCCEMEfxGW5UQ90ot+2TX6WvhY8USqRoWeoZtEiDDSti4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b2SiSogg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b2SiSogg"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4abPd2393903;
	Fri, 25 Sep 2026 12:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uDxrYb9gnE5pqt4yu
	GCe9DFbRDF6vA95mkgEWKGvy5Y=; b=b2SiSogg+ziH/pEYg0h1TDTIocDNNKloj
	iHLPFUiPx+9uzO4DHn8ZLW1nSQez+dEmNFJLZ3220o7VVRCS1nYooFvQcpc4igQu
	dd6XsWkmoHWiYuqHeJzdH1dGiJhJFskPmhsC3szJDs5WXk2VGlJqjgv55r5EV/Xu
	nhlSexj5WXFtGFvpv5CKmELW6TH3lb7ZIkiKxZt4Y0hY1FHnAOY0dlsi4aUhapyr
	cfwivFM+FvNIknO4mJqYzlApY8gRwSFIqouq7gYOyawaW8xVa82pxKN0slydRdk3
	G/39FgGg+tF1Vwx2ve5JqUyfDQF0CWjUJHnmGcqKLbnoFf154TJXQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske2729x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 12:46:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P9v56T3245755;
	Fri, 25 Sep 2026 12:46:00 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu92aga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 12:46:00 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PCjwb933096418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 12:45:59 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D08DE58056;
	Fri, 25 Sep 2026 12:45:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A06C258052;
	Fri, 25 Sep 2026 12:45:57 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.86.59])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 12:45:57 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, freude@linux.ibm.com
Subject: [PATCH v8 4/6] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size in vfio_ap_mdev_cfg_add()
Date: Fri, 25 Sep 2026 08:45:49 -0400
Message-ID: <20260925124551.665448-5-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925124551.665448-1-akrowiak@linux.ibm.com>
References: <20260925124551.665448-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lEAIDMZQ5hM48SiKcp6jxMFZKEokw-4U
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab66d09 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=gReD5cTbzgwmqpVxveEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MCBTYWx0ZWRfX3H9ZE68o5AiD
 OptErhFeMYiOiSvrmsfvVauEfpA2qziGFfDcc5GgNZ/VmsbE/Xr8VvKM7P6YC4bCKfi9+lp20IQ
 j+h0m0NCc7CS/YFCnAqyQqZ/XJS9UCw=
X-Proofpoint-GUID: lEAIDMZQ5hM48SiKcp6jxMFZKEokw-4U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MCBTYWx0ZWRfX9RfUmzPaqJ98
 eemRs36e/xokGTT/LXbYvhT+sTB1pzwTOsHJFzYYtuwQYusFJgG9/4LB+2VC4USIBUdNc/AcBhV
 iZ55g0Q4RvKK/VifnTX3hyQ0VAQdLdOLxRKL4WU5IKFg7xXWoCSd9UTKKgXCeaQyLSuT17FeBtB
 Qlu3Urt7Qp4xvZ55q3U33F2JJoLZ9oq6C3Lll3v1gz6Pakztvp4UbQ62adcUCYOKFPj7odq8g6u
 GmRLQmQPaxAFs8XuEjZ6XWyCVU/upkYntvHWuSaDmztI/YHc1Tqp/Tn7zss3BhPm73wXrUrPJeA
 hsn66aDnz4WGnVQBbgh8uPJX3sZSaC4Nr7q7r9687jEH0pU5DytsyLfa+x7OUh5/LzoxGg/cROg
 hJt0er5SZQ7fRPtJQAOOPGDIFmykzEK647pjF4no/C12eEQbng9KAQlWN/pnH3Ct5JRrfldmxoJ
 XGalo1J0Cb2sdbdyU+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250050

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
index 47d4936fb9d7..ffc2d8715bd9 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1559,7 +1559,7 @@ static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
 {
 	DECLARE_BITMAP(apqis, AP_DOMAINS);
 
-	bitmap_zero(apqis, AP_DEVICES);
+	bitmap_zero(apqis, AP_DOMAINS);
 	set_bit_inv(apqi, apqis);
 	vfio_ap_mdev_hot_unplug_domains(matrix_mdev, apqis);
 }
@@ -3058,11 +3058,11 @@ static void vfio_ap_mdev_on_cfg_remove(struct ap_config_info *cur_config_info,
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
@@ -3173,7 +3173,7 @@ static void vfio_ap_mdev_cfg_add(unsigned long *apm_add, unsigned long *aqm_add,
 		bitmap_and(matrix_mdev->aqm_add,
 			   matrix_mdev->matrix.aqm, aqm_add, AP_DOMAINS);
 		bitmap_and(matrix_mdev->adm_add,
-			   matrix_mdev->matrix.adm, adm_add, AP_DEVICES);
+			   matrix_mdev->matrix.adm, adm_add, AP_DOMAINS);
 
 		mutex_unlock(&matrix_dev->mdevs_lock);
 	}
-- 
2.53.0


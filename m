Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421846C4A9;
	Fri,  7 Aug 2026 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141140; cv=none; b=SgggEsN+lK45Cul+igR1N4vwFe2UT/pVdMUxusdkp0yNcm0yY6Pw62/DhjaZHawwgDNfjMeaxB9/NDas7rsp549zh+//dci7Yvm8HNNOidDJ8RwCZYYTPeGf2yqMYOxeHZCw/RlO8qi5vhUkUQQ3ygZNhzCCleq5IghNS70DsmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141140; c=relaxed/simple;
	bh=RFsmKvq2g7cpQjzp2F1RMNt7F4e7KUpJjueVVe0Ww1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgSiU1yFot4ANCEbbGhWeh5VtiCxdhNFoE3DFmn+DzMqiEBAaW7hnAVM+UMh18yQJs13d/unrPFeQITsZeN/Y0Qg+mqQRm0QPDOHAu55QREPssCXs5vzA5a8ioYPa5uw3SNhG6mG8664/GWUIvyYFoVvmc2ha8jZ/rK6UcY0dr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VQgDoVu1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VQgDoVu1"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Lm7jb2644862;
	Fri, 7 Aug 2026 22:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1EASbGwbJtZmeAebx
	fjwyJ2ChuLOFjJL871ebTZE9lw=; b=VQgDoVu1bPI8gD0Q9HT5rfVKlB1ypEK1C
	Jj9EgwCtB9yTwEFrmDdR1cQXLtY0JZXvk1wZ1n8YUt5zZN9+kuHGwmO/b8PgM/jO
	JQYePs1q8dzdQ/7QGV7xhF6ksZQVLKEIWjkNx7Ewi8AL3N3sXqyM78GkUdhzjzN2
	PBQnSXg5ZKXgcaGkl++S3qTG/5XZbZbTtkmOshM8ky6/JYH47JYAVFYqA+sliw21
	GOizsSFva1QmIrVZvIOfpEh5IgfL9v2A/E5CdTS8U18lNDJjE3AudykCH/vXoX+7
	+pgUpgs1KLBS+qSRWIWYzWlM/NO1txCzCYWjmNP1m5zYIiSIXr1lw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy0468e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677LuNrC030170;
	Fri, 7 Aug 2026 22:18:52 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgsfsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677MIpMY61931842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 22:18:51 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 830F458057;
	Fri,  7 Aug 2026 22:18:51 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8371658059;
	Fri,  7 Aug 2026 22:18:50 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.52.19])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 22:18:50 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v7 14/15] s390/vfio-ap: Add 'migratable' feature to sysfs 'features' attribute
Date: Fri,  7 Aug 2026 18:18:33 -0400
Message-ID: <20260807221834.562851-15-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807221834.562851-1-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX+Q32la1tIHKM
 633SzKwuuFk0DiNo3vqHX3hVND6iKRX6JJMAr2sKiNdpRbvvZhwhOnQ9VU5ucxXUxb5XeFGeWsn
 Hpn9vpxa+FxtBk9qqw1R5kRlMckdkX86JsR3Fq/bPHrbuIV/Ll6THeyA+MHYWmrKTDcgYzOUh+g
 d7ovaal9Sg0SFXIKMAMACGhB/x1yii6iFCtstxUzpoe/aVP4Vag/uVq1UbCc/qfvtMxb7mmpodE
 Iu3m7gmxGiDNd/hDcd2BzC4J1yEEz2K9JGMK4eL8z3zW/eJzXjExABkcqD78e1+ztxp+E68WWB3
 xMrsE7scW/sNiJlwol6n08xmTb28U2p3rOi3A0esIqv1UypR7P7ZnDnnAO3rNO8RtKZDerBcHOH
 58XpS+x8iJIQoOsdSWmyfJ98lb8hRJGQGz7JbsuuyhF0+3xFluUTNQQdXrnUjZN1rwb1TgtRNW1
 rhfQyILEiufe7J5uiwQ==
X-Proofpoint-ORIG-GUID: WGF03m8fZx5VEyqW0RJroKR1ESs_wMA-
X-Proofpoint-GUID: WGF03m8fZx5VEyqW0RJroKR1ESs_wMA-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX6rM+4SjAw9+y
 /NKUlM/YBZ2E+at0ak2N8EO0W2kuwOt1HitvPjzJtKJzHHUaom5jraIOKMttof8XSwFI1xNZfSG
 lKGO4iNb0gcvcNrxVltz7kWgxohS4+o=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a7659cd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ikTKVKcS08R833GyuAIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070175

Add the 'migratable' feature to the features provided by the sysfs
/sys/devices/vfio_ap/matrix/feature attribute to indicate that migration
of vfio devices is supported. Since live guest migration is not supported
for SE guests, the 'migratable' feature will not be included when the
feature attribute is displayed.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 8e69ed286bb9..abfb34421d74 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -26,9 +26,21 @@ MODULE_LICENSE("GPL v2");
 struct ap_matrix_dev *matrix_dev;
 debug_info_t *vfio_ap_dbf_info;
 
+#define VFIO_AP_DRV_FEATURES	"guest_matrix hotplug ap_config migratable"
+#define SE_GUEST_FEATURES	"guest_matrix hotplug ap_config"
+
 static ssize_t features_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "guest_matrix hotplug ap_config\n");
+	/*
+	 * If the system running is an SE guest, it will support a different
+	 * set of features; for example, it will not support live guest
+	 * migration
+	 */
+	if (ap_is_se_guest())
+		return sysfs_emit(buf, "%s\n", SE_GUEST_FEATURES);
+
+	/* Return all features supported by the vfio_ap device driver */
+	return sysfs_emit(buf, "%s\n", VFIO_AP_DRV_FEATURES);
 }
 static DEVICE_ATTR_RO(features);
 
-- 
2.53.0


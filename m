Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4C74DDB2E;
	Fri,  9 Oct 2026 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546219; cv=none; b=NzogzPvZXoaENWbCY2thFrKgTYCnwyitpe4s8XVr/RHXVHQCCZG4a5+3rwwJbUoP667fjPacATRwXUsI38ChtKKC/vyxMv0ruSIXUCf1ryaxa23dLsoCB33WBFRq1TahwYLyKaUXu2eLWZlWct/24emnn0aI6z5KL8BwaIifPNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546219; c=relaxed/simple;
	bh=1MNpwmfcMiZlbww9F5T8qk/Y3A+K5cCykLmyyzbsxII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nv9cPfMBJa0aVQcV4rhX5yG5m/ors7MWhLcIXhdweNXsGpRYexvD70W63PiAqvgYs21YRfHQLn5D0c33iMCmZ2hPG8zhfgTJBp2HJbcBcnTwlt2w9Hac2D0ibu1w9sfBpQb42q1XnBkTGIy49CLV9Xa5Ia24/3JIdxJnbCnc1B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aSJF9paU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aSJF9paU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998ZgiY3666461;
	Fri, 9 Oct 2026 11:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qg4VdgFKzBFMkL6A+
	koKUiGfjurci+RSLcEK9fmi54k=; b=aSJF9paUvTJEEFRwK1gGFo06Pf04n6uNN
	bJnVCSuqhVPzGmPOWEoUZX0znZZqEqAqhIW0yORMdbg9TfLsWhi3zGPPJTKlEqYX
	7hxkoqPjezY5DilZamiCnaWZp5zks3o8qfQlQMrygGWKiANAP4QNyae1Nj4eRq4H
	U3VdNkM8De+9+pzGiveiYQ3/vY4iMM3vZ531xEK69Mnqxi4K4GQyB6Rcuy7y1v4z
	/4XztK4YK5w3kMkKZx7sCvPNWeYWOZQm4vGM/TssHjK8f5vLnHiT8G6kagBRqxTj
	N+OE4NgUCy5YjtiKvgjWxtHrfwQmuQEPAIVrOmsADRvAfJpgsYO8A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw9q15-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:43:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998I2Bg621410;
	Fri, 9 Oct 2026 11:43:14 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnjtpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:43:14 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699BhDAY11535030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 11:43:13 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A12358050;
	Fri,  9 Oct 2026 11:43:13 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F1BE58045;
	Fri,  9 Oct 2026 11:43:11 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.159.45])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 11:43:11 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v8 14/15] s390/vfio-ap: Add 'migratable' feature to sysfs 'features' attribute
Date: Fri,  9 Oct 2026 07:42:43 -0400
Message-ID: <20261009114244.1213173-15-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfX5PpS+7sRmzub
 gVMCHVW8WrdEKilI6vOf6vhS4QN0IPtbYVkj+T4CvlIYH0qyN+MT/jSR4L9e8koMYf9MLPEE7Kl
 jaZnA8XFIjW+LXnwWfUKdyu1qumCTqY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfX9wEOE5y487LR
 B2yMxW9jN9w6gGJ2irnPrfqLHw23Hjyxio4mVO+2ohZabtACNMFr22c+X97y4OkzT0sk1Fh0iKz
 oKSPgDOX4foK5Y+T0BZ1dKiZcqeunEL6uz8m1w97tsbpjFPH/due7CJFiq3dx2ZgaU5ZXjNaW5n
 YS2J1Er+Ao/Yg0OLV3w/leIIpyyxxUjveCx+q/EJwYSEnYxr2GcQTGaJqKMPQalOOHBlF+DHcDd
 LLYnbLdp0Z+HAwsKAv2jPGKTft15peF8UPb/ZF/0xQw+nmfo/oGb1WXq4R8ct/rP0vldROtT5Nl
 7XR5RSK7TbUWg010mm4Msbvev6q45nHHyED6DMHI/sDtaQqejMrO2CiDBVK7jaoV6myKWLgRM4z
 VQuL22HLvIwMXuOj7g7amPG6OAU+7bfWsAObI4D9AMxT62I/Dc+j0mPPChpd9xOvKYow8aOQw0d
 ParRSdtM3QlnN6fp78g==
X-Proofpoint-GUID: c5--CQgqU97NiLfAEBNGnDHzZdPnXES4
X-Proofpoint-ORIG-GUID: c5--CQgqU97NiLfAEBNGnDHzZdPnXES4
X-Authority-Analysis: v=2.4 cv=XcwcX455 c=1 sm=1 tr=0 ts=6ac8d352 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=mmLkksitYsIcdlCVxmsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090046

Add the 'migration' feature to the features provided by the sysfs
/sys/devices/vfio_ap/matrix/feature attribute to indicate that migration
of vfio devices is supported. Since live guest migration is not supported
for SE guests, the 'migration' feature will not be included when the
feature attribute is displayed.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 8e69ed286bb9..c63a050a2356 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -26,9 +26,21 @@ MODULE_LICENSE("GPL v2");
 struct ap_matrix_dev *matrix_dev;
 debug_info_t *vfio_ap_dbf_info;
 
+#define VFIO_AP_BASE_FEATURES	"guest_matrix hotplug ap_config"
+#define VFIO_AP_SE_EXCLUDED_FEATURES "migration"
+
 static ssize_t features_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "guest_matrix hotplug ap_config\n");
+	/*
+	 * SE guests do not support live guest migration; emit only the base
+	 * feature set for them.
+	 */
+	if (ap_is_se_guest())
+		return sysfs_emit(buf, "%s\n", VFIO_AP_BASE_FEATURES);
+
+	/* Non-SE: base features plus those not available on SE guests */
+	return sysfs_emit(buf, "%s %s\n", VFIO_AP_BASE_FEATURES,
+			  VFIO_AP_SE_EXCLUDED_FEATURES);
 }
 static DEVICE_ATTR_RO(features);
 
-- 
2.53.0


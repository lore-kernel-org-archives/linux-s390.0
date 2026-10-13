Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E975372F0;
	Tue, 13 Oct 2026 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905583; cv=none; b=pcssRlVZ4blF5LLK/bhDxX5ihl9EpVmMVpnDnmmX0vwwtSmnfSjA/m67DOz4iQzWdLr6bU65e/I75m8g7lECVtkIjvk0wNTSfIKiS7n6GSUqMQ39PUtlTtgIaH5pepeDNqafnKMHMVoHmMCIzBzcyTUwXZFD3bCO90HTCIfDx9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905583; c=relaxed/simple;
	bh=1MNpwmfcMiZlbww9F5T8qk/Y3A+K5cCykLmyyzbsxII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4ffK4rYcAfYmVFcV35MH/+DqPXJ2fERNWS56QU5h1Am98ebRLFUGbYV2lM1YDini+86agQJaeGC86pJ2xBy+P4LZ4n5WPmNKemzbbHMkRl2E4o8G+EEKH8V9u1BT1p0hhpP2Ig5Eh9hrBp89rrPUmvg6Tw1hRqS2bJuqcDttYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=batOYBlA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="batOYBlA"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DCtlXH2016607;
	Tue, 13 Oct 2026 15:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qg4VdgFKzBFMkL6A+
	koKUiGfjurci+RSLcEK9fmi54k=; b=batOYBlAta4258so7bVLjtaLcPKqW92lS
	cBQPLWvjUy4x+pl3LgjFDh+b7j3U0tKNnmR4ORfIpnLLoOlgDxwMhYYQF0UQMjEt
	DPTZr1TNkLOLgpCObVcRRvbjANAeFySMGUeuzGKL5gu5iN/5yLS5qaXmbgq5pqiu
	/OcQT9uB8nidvlRwGxPc60zwkwA0Id5L+uVMIcEaVrhG9tYEMkGQn6PaX5vWnar7
	aIrRpDbtFQQrNmZVQqGeowwyFYN7/OiJ+53dpknME36CqEYCgqpf56XE7pusMwzT
	fZ+VWFFsso8NPjI+DoRk07eIte+okxsCPav+kiia6Rvtis/FPEblw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dugf2pv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DFWD3r2709367;
	Tue, 13 Oct 2026 15:32:48 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816h2jug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:48 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DFWl4E23528138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 15:32:47 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C4F158055;
	Tue, 13 Oct 2026 15:32:47 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC8585804B;
	Tue, 13 Oct 2026 15:32:45 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.17.246])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 15:32:45 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v9 14/15] s390/vfio-ap: Add 'migratable' feature to sysfs 'features' attribute
Date: Tue, 13 Oct 2026 11:32:18 -0400
Message-ID: <20261013153219.3534306-15-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6ace4f21 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=mmLkksitYsIcdlCVxmsA:9
X-Proofpoint-GUID: mKdguggnKv5vA9ikB1JyaGYnzXGeAixX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX9Nk1UZqQSMVx
 6DONiNntCo61hW5+QUd9Vzbr8s4+2d/t0kLwmda9p6E1ULxNRWSsBIhcZXTpDRKpNw7laAbYE3p
 on+sLr/ZrvB+eR9/iqXYDei6pIisLeyxcLK6u2w0ztkFdzeawgtJVdX4ecFwd8CCbdqpkDJBGH2
 1REy2Sqc02BDWvYsWjxCVHWJYb9oTBYHanrbRYOMz2QEcv2H/vVBW7QWDDRKhRqvug16U04A7Pq
 JirXa4RA/k+w9byt5iXgWo2C/QLgZ7Ts/STIjolmht6r8Va0XLC8rDr1AIZ60rAYqy/S8T1szA8
 plq4CqBqlXdwjA3/5rwqu5vJB80+MFyM3mDtnK+PMCtwspNgzplkPSM9IHRcyqfTumFYxfv+b52
 ZKjcykU2MKBQi8s0JANK/c5lE0VP0L+4Lobqo36sgIPNlg3zyiw3ijbgyPhGG7NcC8HJO15jmz9
 aH2IX7V4assROarNe9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX3g7wB0RzFPEL
 0ZZ/d9Y//roQEz2CGr/lyaPbz3l08e30lf64xgb/AYRnxA33ydUk1Clfz+4tTEodD9bPipA5DYm
 /mrjwB2d2ivSr8VOBHHh91YEEO0XZEE=
X-Proofpoint-ORIG-GUID: mKdguggnKv5vA9ikB1JyaGYnzXGeAixX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130060

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


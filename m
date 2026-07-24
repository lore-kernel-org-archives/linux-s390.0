Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9BA331ED1;
	Fri, 24 Jul 2026 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784910802; cv=none; b=Tj19Fa/EhtWnyCEJ8i5m7snQa2xmBwSNhumpoJlN3zSMGXB1ygCWj0B2WKAZiHNx1f/lWjFXFnULm1r57OUN+U+bgL+DILovOmx0DHgGb+RgPsXMIK0pMtOuKaEAqfpcaUyDvr0ToX5wWzetyPIURplr4BcuqOAjItw49Z+/Zdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784910802; c=relaxed/simple;
	bh=mOk33HJJS7pCPcxC4VL+fAK4OX3+1RGMBfBp9f5uA9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdMjcTLizyMAQEnT08ncsEB5QAPN9CpghYSNfcPzAgA/Qwr1Yt+H0uBH2bkCwOYrHtKhNeuPpqsb6Qlgmc3lI8J72N1+lbiMezShRzOcVJtJYkTCthE45wMh3miis4jAiZAFs/V/1kRczeMWhdU99afbL3xtKHYtOO6B6wW/8Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hLwC/PZO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hLwC/PZO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODg8WR1899385;
	Fri, 24 Jul 2026 16:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qG3IrEHveo+ZMR5w6
	mHcbCXKA3r+HDZPyj36pkkSYWg=; b=hLwC/PZOg5UzIGSLW7sHhE9Z4bANzsZLX
	R5kUdzfAgIi7nV/Qyv+gSVC/Y3Fzw/nfKdZMzbAm61Mm7tYwQfPzuNPYymvN04as
	26r1J8M0u+QvaYnjWkPWIFbCJqyYr6/qRHUHkspgtu+nMenNV/fIi/6A/ItsH4xs
	mbfJR0a5uro/7ge9LXx7dvaRmIsw1g1mJAdXI8UOD9rJcntdHl0VJZUrH1fqKdNH
	fYaJld7cgQNGddDa9D6utzhQESaFHz3AquvhAU21RfIL2jPAtbFacaGuvo/mmRvd
	hrJnma7C8udIwjjSXzX/DnAMI8X5hNQm93k3YB2scdtLDf5wm8C3Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kmy24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:14:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OG4eQe025354;
	Fri, 24 Jul 2026 16:14:17 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahhkpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:14:17 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OGEGao24052362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 16:14:16 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97A7058055;
	Fri, 24 Jul 2026 16:14:16 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B6DF58054;
	Fri, 24 Jul 2026 16:14:15 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.50.28])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 16:14:14 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v5 13/15] s390/vfio-ap: Callback to get the size of data to be migrated during guest migration
Date: Fri, 24 Jul 2026 12:13:49 -0400
Message-ID: <20260724161351.1802644-14-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a638f5a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vZ-Ft76KQvoWVpZ_:21 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=lW0G1kjGILAuz2jbLQAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfX+n17kc+Vus30
 YwF1AJbQ8hFVgux5F/+52DoIVLOC6Ob4yiPK2BgWxq0sIfIRxLwEoTLGFqkrJBAzVbsomqX3nxV
 /OlhjSOVg8SaDmAjZKtFvi+KbVPgIYxA+nnu+34ECOBS7EEX0jygpevjhXSfnq1i44H4Y9eTgAr
 E3nUPzS1Qlk+NbMxg0MHSmrRbI1sM/GBX76Y+Zw08Tyg97Rhz4qk7RZVeJMzO16IkTbN7T71LOp
 EbYMSHLXJ7ZPsXHjIcSr8YLjawWbFyly0e7IXnPLkaDCEd1gxHrmCJxl+Lkc/AJDNhxEf7rGtu8
 mNRO1Nb54eeME51CmXWtmxWAn8FL8kWKZxPoKWdppo8ndGAXhkCCxCO+/ovcYg7+CnMmqSHTY/j
 Tp6aovja0bM/yF8MBfGAOouhLQ8R+T+T+4DpU++ZyolUdwFrtroOox+SRU+gtHXEfAhqseZPCpi
 7EvFg6Pi9QGDChPOrlQ==
X-Proofpoint-ORIG-GUID: LOSlXpvKHcMi9pADCR97esXXcaw6spQW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfX33lZpkAg8eV9
 Tz0cewa4DbnuXmv5CnmBgO26/Hxh8Qvtfp0/JxoAv4ap1W8kt+TxaoN0hkWe5lMin/dJc+w83ke
 /uaV25wM3aXIGT+OmAwyY4JDZJjj00Y=
X-Proofpoint-GUID: LOSlXpvKHcMi9pADCR97esXXcaw6spQW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240145

Callback to get the estimated data length of the data that will be required
to complete reading of the vfio device's internal state. It's mandatory for
VFIO_DEVICE_FEATURE_MIGRATION migration support.

The function pointer for this callback is specified via the
'migration_get_data_size' field of the 'vfio_migration_ops' structure
which is stored with the VFIO device when the 'vfio_device'
structure representing the mediated device is initialized.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 8876338d2898..20b519f0898f 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1429,7 +1429,18 @@ static int vfio_ap_get_state(struct vfio_device *vdev,
 static int vfio_ap_get_data_size(struct vfio_device *vdev,
 				 unsigned long *stop_copy_length)
 {
-	return -EOPNOTSUPP;
+	struct ap_matrix_mdev *matrix_mdev;
+	size_t qinfo_sz;
+	int num_queues;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
+	num_queues = vfio_ap_mdev_get_num_queues(&matrix_mdev->shadow_apcb);
+	qinfo_sz = num_queues * sizeof(struct vfio_ap_queue_info);
+	*stop_copy_length = qinfo_sz + sizeof(struct vfio_ap_config);
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	return 0;
 }
 
 static const struct vfio_migration_ops vfio_ap_migration_ops = {
-- 
2.53.0


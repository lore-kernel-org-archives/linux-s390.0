Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73212517BB4;
	Tue, 13 Oct 2026 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905575; cv=none; b=C/rcnpJkYnfLoCednEywGdaMd23yjcQg8W+tFCBRIPsu7sxrZz37grjztYkFbBZroBburRiclWzhWTOT0hZS78cPwYwbMhDZmaXQMF+lhnuNSSXtoY/SSSNMNUlO6cl1SvdTmsKKpXQtgJvLGhGBvefaMPK+i/7sMV+pOPA5ZYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905575; c=relaxed/simple;
	bh=I9l93aSC4OHNY5Bu59MlYcF9AoG0sqy4/vZs5cVhyts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nq8peoFpQ4VGMKnAr6O9ijLE1dqZO6U752jI6zLmwsfQcnfTV/ju2suq1njWn1sPvoLTxdYV7Ph9JwjgBkD1sqELboHIZO2MyqXYGjICyyiumire3HpIP1knWeGNFBM2I2AEcSL5/yhl828IL4GbEO9rVyhp64zQ9TQ5QXMnOGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ru3W43GQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ru3W43GQ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDdDsX2016202;
	Tue, 13 Oct 2026 15:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NjzyFF3e1SXSipIAQ
	nLXUU1AQGI6cuJRe3jYmLHxYLQ=; b=Ru3W43GQvVs3MOqXXU0DQbKrBnHpZbboh
	fvayMcNesWM4OY0mMC9MsPpL0bCiAaYCaVNxuTpBv8YobgaSVlbOLS3LsxpMgPwf
	t/3QCsnpX1JMIggH0EQVfZ+czzuJ8pBb3TYovH6EiPk5Hdya/4SswBFE91IhR1xf
	oTsWhdk/OZynGpqj7pR2J9xQgWSJB4s8FUeW6+VOoTJa9oCR6wbjEowIp0GM6vPF
	R9Ua+DeGPQrRJrAq+YiqP9ryXxz4x+GI1TmkmXxpDt8KLkKCoWl7Dr66iqFv5F+Z
	OXvap7akpY7g8/Y9+8A7HdkzccRE7HoAtI2p/rp1CIYX0PCDVjnZA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dugf2pk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DEL33k3149895;
	Tue, 13 Oct 2026 15:32:46 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9pb3gbg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DFWjar29491562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 15:32:46 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A200658067;
	Tue, 13 Oct 2026 15:32:45 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EE9958055;
	Tue, 13 Oct 2026 15:32:44 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.17.246])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 15:32:43 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v9 13/15] s390/vfio-ap: Callback to get the size of data to be migrated during guest migration
Date: Tue, 13 Oct 2026 11:32:17 -0400
Message-ID: <20261013153219.3534306-14-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6ace4f1f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vZ-Ft76KQvoWVpZ_:21 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=jJfqtB0EQghymFthzpkA:9
X-Proofpoint-GUID: 7ZFYTlrK-IIG0_8aplF5iTWeODjmc-bD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfXwiRXgyS3mleN
 rEgl5NLlvOyB7iVLw1E5eSBkX0pPUozPBPRb8fXcaodjnaMvZJljtTImoBNbCbljGKEMrmOeXah
 E6uxatz0ph5ZdI2cmFmkF+Ads7QY2LkYH+s2xlxoO4D7OM0TlsfsPDIqkyjze2dxWLW9YEk625m
 TGwuZvKNw0fI+bd99oLbMwHqvXOtDKGwHyq6sh+dMw1z09jQxLxVnhwUWOMYQSoJ50Ra6iWGtv/
 CMfX4IQH0DXdAUKZCOID4eL7tyPev+Y+cbrKRvdk/ZTW42J9qwUPUUH4bC3sY5Y/QonqgXOONSW
 nYLccCqdGxZw21y4TfIEOA4I+gwRqtkl70BdokaC/yM+kGb+oGm0UZlAT5XrnO7AIhvLaZonoky
 wL11cKncXOFnA8IObcV8B4Ve+tIV4Wuf+AOHdD6igJCGUQPCIg7Ev3FE77gWfhTa78WrlhWd9DQ
 bUed91s/DjPTSU5Pdlg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfXzaBoo6tfCTXc
 HFQavZE9XHHT2Ir9/p9FXepViILlRMDssiMVMMOD17jjM6YL8Oo0/rnqLo8vhjeMlaeY1MZ3XNa
 xyY+ELW/rukABkHAPhO6J0o2UUMzJRc=
X-Proofpoint-ORIG-GUID: 7ZFYTlrK-IIG0_8aplF5iTWeODjmc-bD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130060

Callback to get the estimated data length of the data that will be required
to complete reading of the vfio device's internal state. It's mandatory for
VFIO_DEVICE_FEATURE_MIGRATION migration support.

The function pointer for this callback is specified via the
'migration_get_data_size' field of the 'vfio_migration_ops' structure
which is stored with the VFIO device when the 'vfio_device'
structure representing the mediated device is initialized.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index fc6b1ecffc95..ef3b41586df9 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1371,7 +1371,15 @@ static int vfio_ap_get_state(struct vfio_device *vdev,
 static int vfio_ap_get_data_size(struct vfio_device *vdev,
 				 unsigned long *stop_copy_length)
 {
-	return -EOPNOTSUPP;
+	struct ap_matrix_mdev *matrix_mdev;
+	int num_queues;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
+	*stop_copy_length = vfio_ap_config_size(matrix_mdev, &num_queues);
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	return 0;
 }
 
 static const struct vfio_migration_ops vfio_ap_migration_ops = {
-- 
2.53.0


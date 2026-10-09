Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBA34DD3D0;
	Fri,  9 Oct 2026 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546215; cv=none; b=SYVkZX1SIhlcoTIKGfTZarr3uNlcKnNclbK28Zq+Q3z6pvMp3IcypggDz+TZ/3aiLAAjBIH68E0rXtM+/U6t7eVxnE7e6LnOtjLKcO0Uwt3LuBwyxX3Ak1Y2kevZ4wpu+tHHGqtDzpLuwUHFFzW06LdBiyq2zSdinx0s8jnYiWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546215; c=relaxed/simple;
	bh=cTvjs603VsvR0UHhepkWZ4jyHPz8AY/3Tejd68sGfmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRVk9spastSwyGL6ZEDDzdSCq18UCFOvDlzxvwO2GclOQErQJyYWgsULyn3BMDFl3gKnN8nbfsMF/iA/OznW6OjZCW9m+1qf2/XJc0G+AgmHiKZcqsTIwjN30wnQ6wjbSeYoV4nY6avmW8delPGR4RFTFddcWtH/nWt6v7iGDEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XygIh8xf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XygIh8xf"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998ZZrK2007569;
	Fri, 9 Oct 2026 11:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Du/7JWQAsy27T86zE
	8WmLx9mZF195ZzW+eclMNrNtuA=; b=XygIh8xfyynzVYTTpFs7o5zevksL0TGem
	s2Ak/5wLn/argIiidtwyjS8XrhVH9t86QU9TQ8LXxHU7uLfTWwz0rMputusaiFpX
	ph1Luz9/OK4NxhlkgPCUZk1zl0puTEd9va/Hc23PRMVAxx9PSh6S0q3p6LeSNmCZ
	Hxh654EoeAZwx/u1Zy5m8UWssub6AjA5AdTTrNlHJzvZ3JGTmIA4V4lOkaqL7eeo
	smSR0Mx27cum1fmIKtqM14Q1F1rrJrSEsrAlmHrOy1kgxX4gOtAsFyFZvk0hxRQu
	4dLn6E9QK7yqKz8mh3iC3eQb/xpzAMj92az+aEB3cuUUqHiKZkTUQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjwae8j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:43:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998I2Bf621410;
	Fri, 9 Oct 2026 11:43:12 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnjtph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:43:12 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699BgPju6554270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 11:42:25 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52AC958054;
	Fri,  9 Oct 2026 11:43:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A52BA58045;
	Fri,  9 Oct 2026 11:43:09 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.159.45])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 11:43:09 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v8 13/15] s390/vfio-ap: Callback to get the size of data to be migrated during guest migration
Date: Fri,  9 Oct 2026 07:42:42 -0400
Message-ID: <20261009114244.1213173-14-akrowiak@linux.ibm.com>
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
X-Proofpoint-GUID: chI24Tp-NXMPL8HaWxn68NEZK51u0TnS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfXx0qzyGgXcPvX
 Aks2FP0ON4uDC+otrsUZXP+bry5dDGBs53Dzz/OuP2VRPULjhI57DXUjc2JxAQZH3yAWM+hBcJ8
 pCRnAbKjj6zeUPiQz6RMYnz4m0aXx6IGllp6nPRaAgUK/L9ba19eZshpE4yw9QsZ5knPPZKdU39
 9nkjO8BUz82XRbmlWtxRlr1sFQM8L6OPecj487+Qp6ebIFL3nbWswx5Xf0N5O5krv+hIlhG2xwt
 E7ZK5U4TrPPQ0eBISb93WrSBkh8b1DRNSz97MxuzZ1TC3CLPPwbpBABOrPtZwoRgGS3JEBemDX6
 ohEVYaYhGiixCSMs7LOOfVBIHiBlrgNqGVEnWml6NYD8LuVq7KiV78wdkQoEms6IeOY+td8ZQ62
 q5mVE9jlu2Vx6aTTt5dykcyLN3u4soU7NN/1vf8tDvf1Ok7KVHrl8Zxckcw+FUhingZD3kTs3Tu
 AWPC295RDoj5JrOy0dw==
X-Authority-Analysis: v=2.4 cv=cIt1IVeN c=1 sm=1 tr=0 ts=6ac8d351 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vZ-Ft76KQvoWVpZ_:21 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=dNOmgfuV3ZSo10a98CMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfX1tliKbttN4Uc
 zQ0MsOqYKj4jnjvgZjoGzwY0VgnOPIh8hF/M/dK8rZzQSksMeNKJPDn1jdMtCRNt2HR8PfWdwIz
 CuSbPfWOSCKS2fgfg2DeFUs6gkb9KfI=
X-Proofpoint-ORIG-GUID: chI24Tp-NXMPL8HaWxn68NEZK51u0TnS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090046

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
index ed30e6ff0127..7fa58f086812 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1361,7 +1361,15 @@ static int vfio_ap_get_state(struct vfio_device *vdev,
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


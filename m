Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425010;
	b=gCtQxTPKJ6IQSwb+pi4YdlpGDUd1irLhuxk+lFRjCpE0Q81JEb8SjoBxqkRnMAuGAWBo
	 pxO6myocFko4uufEQPCb0bCTBK8CSCHwzss//XLAPI/x76z87yoJPJK6FjpQas8MmoZgR
	 P+J3/lm6MvYVjJoKBkQ25WKV7aXyu+Ol6/LjSSl5D09TB7yFUH98RyeeqBb6gUFToT9M3
	 BmT/vRvAIV3hQsulxd4ZEE2Alw/4pGmuDrdLPI02+HkUe4mS5Kipbwl1RnwVWhC8TUXX/
	 GmhlN3gR/0JjD58sWRzkX+4lXLgwbWxAhGhDR8z2+jCCNNm5OpRw/6bSUqvQyOIXkIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425010;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Y4ozeAh2W3OJzeMdeYAxvRkvOyE+SHLTP8YuJ47lQqQ=;
	b=2649+JZ+xfOxNuzKZ/Wvg+GM00vCOv0gFFt6JyiknmL0RcITct7o10747OFSEwg++o68
	 FRNg3NyCCYKPZMJ7165WxHypDtGQP7AMaVh5VpdGhSBEXvzNro9T9Aw5DJI02meFutJ/0
	 zkTj5tPf5tnPIk9HW9LNQ729ub9HdzpcJ1RIAvQ5OfJAfgowWPu3+J4ROlW2UB4wHelbY
	 9KwAb7DKnuUB+56rQY7FmBiAVKbs531HdXBKjPyJoZG/n5ZaBF3pFwq2m1c8OAqLPqLbl
	 8zK2hM7GQWVhA8raghA8WxpgOILN+6bHZheHkcVVNzVwfzbWvonWzvEDZN3O7JHzOxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o95mmIOH;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1669606A31C;
	Wed, 11 Nov 2026 19:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1669606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o95mmIOH
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIiLsZ1892314;
	Wed, 11 Nov 2026 19:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Y4ozeAh2W3OJzeMde
	YAxvRkvOyE+SHLTP8YuJ47lQqQ=; b=o95mmIOHqxHi3tu8zIWWAP4iyPUH6A5Aw
	wOe0Aw6MOIHSPHtZSfT8PfrtSRN1VlW+fFJwouVT56nz7xe9Ag0KbzZjtTooM135
	ZTfKEZ4FqRnUtzG2xoh1h9prcNhBaXXmzL8ocbtUGzj3eBx+TEa6o6KBlZ+wpS5z
	aJYY7heJGwSvahv5Y8cFGD1yhtsrRiFDgBw63vtYnQtk7/FzY++wmLNAJ3lhnVjE
	Wtp0wTI+e28JCyfhM/HMdxRkj5qXc/x73CqVqXrQID39NstD6dhqzdVULIFEba4+
	dmztff1RL3IS2W9GW3YC4fzcfU2/vFlIXMmuS9HXyVSrddj091q8w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumv32sp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIZ4Bi3822814;
	Wed, 11 Nov 2026 19:23:23 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfthv6se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:23 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABJNM5N28639882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 19:23:22 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81ACC58067;
	Wed, 11 Nov 2026 19:23:22 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D6E258056;
	Wed, 11 Nov 2026 19:23:21 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.62])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 19:23:21 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v13 11/14] s390/vfio-ap: Callback to get the size of data to be migrated during guest migration
Date: Wed, 11 Nov 2026 14:23:05 -0500
Message-ID: <20261111192308.2585984-12-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfXwiGiZ5S2ZYxg
 RBPXXZfqPvu2tvyJA2CrbT8mEI3aara88EHjkuavnFC6O/y4PnDSlb33H7NUZYjKOeUVXmW087O
 mg2LJ7YiUL/PXsDZyqQWd0vaCkhAH+A=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af4c0ac cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vZ-Ft76KQvoWVpZ_:21 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=dNOmgfuV3ZSo10a98CMA:9
X-Proofpoint-GUID: mQt3DXgXULxkwLKVVWFqHOQZqLVKqpYr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfX7PIBDqHuhe7Q
 ObPFta1GVs9ERk/U+z859W2m8CWIvmK7Nx0MpSfopF+PpWSvNwXrQRl8YCMonGQ5/+KtOZzU6FY
 K/ya8i3ioZ8sXhELAPWbDMboxFEqWzaTfeRSAwjsKvepy54Hn0iJ1QJUEWlUQA2KGn2W0mWQPF4
 klfOmr7tDd8J2qELe5Z/NtUrlHNSuD414pTO6qHnZ+pQlpu1LlXEoWVH2X8tpboBK1y631pmg8s
 KUD18n3YpYkjH0Il9jxY3THYaTnGPT1rO5YH63Qe0mqHu90Kec+DYNWO+wNo8yQPQwzPy7J+5O9
 PTpyc0f3K/82HzQjLvTsXSBKBec+cX0uiDjgSU3hduGSkUjPHCl58sagoBrbBxMxHj+yCu+zeN3
 veuzMu2xj3Brk1lRZ/mvLyzfUNWQ5Axz61Yfks6o21sg1kQpbTXCEG+8J7QzI1OA5fsJ2Jrc+yb
 rit7nRbf+JE1JMTErPg==
X-Proofpoint-ORIG-GUID: mQt3DXgXULxkwLKVVWFqHOQZqLVKqpYr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110076

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
index c6d4048b1299..4af734aeee17 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1299,7 +1299,15 @@ static int vfio_ap_get_state(struct vfio_device *vdev,
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


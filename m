Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777462;
	b=V0+Ds35ZdIjhE1RaTa3eFyts2IivS9tut+f616PpgabgluR3R58QFSyBw4tbMYyxRiwG
	 mXXNcMmHH4c9YUhH23he4rIwG0R5WoRu8sJ0IWX5u5dtyWO9pR5cJONgadaJQ3K8hydpZ
	 xMmb7/cZdeoM7ecn4F6lwuzvvqGAH24Yd7k6pvuvJMR933qQoyhCO5v8ogXjZOf4z18bA
	 UDh0gGPjrOPOQQLM15/EKUG6Z62uOt1wGaDdHNOpjjb2jJxlivUXV7yWNmIX0tRSyP98M
	 wdD9NQpAV0pcfv/4p75+73T/XYkIS06S+kt3/Uwus4OqlP85Rak5dkCKFxUSCbmh2FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777462;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=tncIHGEnA+pgZC67CXEEDNym6Drh3YlYZSd1CVki8+Y=;
	b=ZVUiS7weYSe05x3IrPX8Ly/YK7xwQ7OUTAY6UfGScr9w+OiEybf3iu3cKIceg15eKhhY
	 4udM8FhjM0pBj01T5hZjzN+Fy0Tyr1yG1Xgn3NFvpC1SuIBKrPPuMQL8nJ8t2M/gpdV+P
	 hWOnhMkMMY5aD6fGVHRkm2lCakAta+QXsyhIsZozC3fRfUblUZ658knAVvnQ8LrjD2rm8
	 TEAYqJiw5+EplUWLYBm82n1TXTykAOfxSTiQ43tRuUr3zVWIUpD48frXTDRsg12wEkkiq
	 c1Ma2DNGa+AukbcXrTlqEvBVMiGvcoeFXM/Rehjv38rzYwLni0epxHDre9hD5QxsQyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="Q/WDxpeb";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C40A60A2638;
	Fri, 23 Oct 2026 17:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C40A60A2638
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Q/WDxpeb
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NGoTvO1895985;
	Fri, 23 Oct 2026 17:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tncIHGEnA+pgZC67C
	XEEDNym6Drh3YlYZSd1CVki8+Y=; b=Q/WDxpebXbXf4nyEgH8RhaRiRktoJttB1
	t1NBHYTLlni5nbCslpR3q9hFxa5Ng8gwhBhIHw6ZVrfRt5BzEYLJgq1YvL77itHr
	wvzUsQqqE5+RPt3FZKH1JX/9gWDq4Npo0Z9IQ1fJYjxuYEqjQ/gXobOmR841XP6F
	B7GCBFheWBLjMsaiMJlDjro4DGTWzxDE/nO/qNqdsz176UcIm3DSvs3N4eG1lxIz
	40pTNGmisohIWQ1bemboSMzC7kheYc0oxGLLaLt4BheBwCYMbHRUexfVraEh5e1Q
	5XhzWWYSAX1x/dek57L8lIyzyFWcIOVvZn3nYkFlDIUu1+35XW9bw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5bxrsb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:44:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE6Ako2263076;
	Fri, 23 Oct 2026 17:44:14 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfgck6n29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:44:14 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NHiDEa62325184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 17:44:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40B4A5805D;
	Fri, 23 Oct 2026 17:44:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A05DC58054;
	Fri, 23 Oct 2026 17:44:11 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.48.60])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 17:44:11 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v10 12/15] s390/vfio-ap: Callback to get the size of data to be migrated during guest migration
Date: Fri, 23 Oct 2026 13:43:46 -0400
Message-ID: <20261023174349.3545941-13-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
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
X-Proofpoint-GUID: EB_YWR4J3VWjVgOSKVuZ4H27kKArqAmt
X-Proofpoint-ORIG-GUID: EB_YWR4J3VWjVgOSKVuZ4H27kKArqAmt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX/mxL7e/DYpax
 WjmtgRvuLz5Ig9bG+g+hEnOmK4AYB2TFF2c9ARdU+94Qy9/x6Q7mqQZpW6Y2++8wNUbthQsMDHz
 r8GwcO8UF+mB3LxGUvXXE/SHPngLU9I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX2XMXZbEJDzlm
 4fa90FVKtBb8vbhcjtK8X59cetu4b+yMeISRB6UMTBmyDkDAKVANDKQFUI+pxkLA5hzDjS9dvTo
 3aVg3e2m2JiYr7jmdEmnnjsafaHNTR2pJ5aadGI2nDJyNUMA3bp0fq1PkvPnCacnE9jd5zRvLLW
 Xp2VNzJnFm46HGAO5KtZhsnZLZdHLjeUFoOaXg+HmvvP2ey6HXfvT9SKgCbdZEsFZViNhyT37fP
 4rtC8reZXbOx8FBB5fKSAHTcIExAtaE0kd8xLZNtGcB/NtM/6LpNvnHpr7CONY+UgsjBjYy/+ey
 n0nU10kOdOAohoTKflHIL7oh5rjPGdOGN6KvZ+TCmwfxYB2hXDU45C9FocSnxT2q61212kya4il
 kleZagKCbHhAm6ihf5oijwAzY8Lsohh4gnHmUhjcHt1kxW/EXEzKy8O1wFmCI9Qc6JyjxIsgZ0Q
 1g9NDolaNj0fVd9rvPQ==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6adb9cef cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vZ-Ft76KQvoWVpZ_:21 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=dNOmgfuV3ZSo10a98CMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230069

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
index cf38407d1b15..38098968eaa2 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1278,7 +1278,15 @@ static int vfio_ap_get_state(struct vfio_device *vdev,
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


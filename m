Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978610;
	b=5lX+pi6ytaTuxl9aNEF444C7Ageisr2VxHUHM2lDv2lUFANn8TG5VYe6edi1GGNATd7P
	 VIuzpcNnbcmw7xbkRcgTF2UMePxegVBu3IQ62BgBZMJeo15FVAqbN4SXwT61LhJ0mTUrw
	 DC5ApRO95CiDJfFVIQwRR4rzpDd3vXh4mm2FVVUc81EBExislRlpS7VOmqMs7rWHZmpuT
	 4ZTh7VXMbCgmZdXTY/a4IHbfYV9fOP2Ss6czNCjH/bsicvyZQN3s8n84b0Na3ALNeiC/y
	 Zq+Px2v4Na/Kuaw+KSXeaY9gswnbpPlErehxqyq7TNIhEb3sEqWFyV0ynZOuU2gWbwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978610;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Y4ozeAh2W3OJzeMdeYAxvRkvOyE+SHLTP8YuJ47lQqQ=;
	b=SW4IucmKlGMKkrZQ8wDpshz7MXoJrgPy2e3FsagyJdRX1/oThdAdmlypj+QYEguOB8qi
	 4Re+7FZiONWvVohihBOo8dJQXPx0wJuDARRjmG8yX1gvvA5Krcf2+RwX7VO1LgDipUAOc
	 s+Fu1WGTXhVTNnAvS41XUg79KJEVRqkiT4X/Sq6luYU2v3tz6jggagAMiov5x++XZxFRv
	 4o+K/RoQJboNoTDi46/r/0887kzqEQ9PZOgQgOUzHCEbWtEAd+MrS8FuMWwvFjmZCq2g6
	 637AVjVk4ZRTRaDMCLhJ8fZf2qDyNn++0dIQkg0bERd3NbBl1XphXS9vPTyJEl2AyGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="WnKg/X/N";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0C9606D82F;
	Fri,  6 Nov 2026 15:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E0C9606D82F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WnKg/X/N
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FE7RF2935684;
	Fri, 6 Nov 2026 15:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Y4ozeAh2W3OJzeMde
	YAxvRkvOyE+SHLTP8YuJ47lQqQ=; b=WnKg/X/NWYMfApYlEmasVGpL0DAmuRRJA
	V4zcgYPZNH+w/bzBylVlwANad7DfCb7bGFlvkaffdgmuDtJLYqAVpIoExfO7z6tE
	lLYyOgQ+BHBXbFZkLq9elZTkKhwQnIRpahYYYbvBQdbW0GPwFu7XD6j0I5ufSFBA
	n+0Pdlyn7aa+/1pUfhaTn7TDEK37uGxSrxOdO0X2g4f4vqpuEll0m1e03nA3SgdP
	lZwqEwE09JYE/cfqML2nf0+yJr+hPhuDYtLtRF3r5v8Zr1vP7By3BHp9lpCue+X8
	Bsc8s//yeS/3oqHBSSqNADgyZJoo5WvB1GnzddTd+n6ow0tETFykA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rcd72g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FKClc3577994;
	Fri, 6 Nov 2026 15:23:24 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqv1v7wtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:24 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6FNMIC26018404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 15:23:23 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA02F58060;
	Fri,  6 Nov 2026 15:23:22 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2B3958056;
	Fri,  6 Nov 2026 15:23:20 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.114.69])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 15:23:20 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v12 11/14] s390/vfio-ap: Callback to get the size of data to be migrated during guest migration
Date: Fri,  6 Nov 2026 10:22:56 -0500
Message-ID: <20261106152259.1360651-12-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: DIo0wkpYe2o3jN2R9kJj2KdM4Q-MD6e3
X-Authority-Analysis: v=2.4 cv=A635rKWG c=1 sm=1 tr=0 ts=6aedf0ed cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vZ-Ft76KQvoWVpZ_:21 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=dNOmgfuV3ZSo10a98CMA:9
X-Proofpoint-GUID: DIo0wkpYe2o3jN2R9kJj2KdM4Q-MD6e3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX4iIJGrAc6Lfn
 f5wD9emVure9x5ZtP2qfSiQYEjO1gg27e3Zmbl8DPw5DH26uoP6RI2r7Nw2CGpU+gMVa9O53MiB
 CsIMFYyW8p2X9w+JFyJXJ7gRQV44oFGVyLywv3EhTVHLQX9wk06rXvwbCYRIF86U0Xjfum/AAfU
 ATudQD5yvQwqcsggEiA7vCZ5LozOztNuIIoi0eiYHJeUutKFLc7RWVenvgq1NlDdS5CPO8fzmzh
 zf6sF8sc50Qk85i9BUEwM9Mph6a1yeuZR813FBKSAnFPYOvV5lo8ggHU2XqfDhtXsvJwTCnLw1A
 qgTLBZhCyH9toErrPNAgjuRDTKByl+hCSvw9Vm0bjauhH905Odq02I+ex7FaLGGKHWYBts0S5jG
 fl3yQ7o3h+2BJA+cn63F/+2e1jsHAG9T3I1//1C0i62QzaErihIkMzCkH3cA3zrphS/5gxXhDvM
 Ck3aJrZ71ZcFXR3AmYg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX/gnM8QCsdHo7
 EiDvjwxdRo88JVvvlHaQq6UHMY9/g2VfgfXyFIQhO2+9BYb+NGOJI5TPJZ/aOOTIZgGxqaIpMy1
 /qlMSwm0jZBWlgKGzA4mghpPIez8Im0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060060

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


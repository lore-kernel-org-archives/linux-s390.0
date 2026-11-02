Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632590;
	b=0gIW0OdtKo8lzUiznFfBQH8SZKVEVSSGmQ7ntFeKWO/6B9cBMCw4rfp+JhKp9oBr8RpC
	 bkW6MS6A0TB2+wAWFYZe0v6Bn3+0gOBSM4hKS0CoektGgnWWXcJf3V8l3EVTM5M+xWcQv
	 EqNw1vVweGrdjOvDwi2xL4DIlOUkueTzjy6PlKyrezMf9s76SHoflCsLBb/RL5e8AdieO
	 j19/EkmhGv+pnnzRR2oi//Q22FEmAB13smNLYGOu+EQ7F6N6lLs1ei7gQi0VaLIMJ6C5g
	 DdbEV+XU//Z8Ni/A0tutoM54A3qU98w9QcNhnRWapjmF/Cv4/CjkQ4BG7p/Q8KtC1ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632590;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=faMoFAkyez9tsTH3nm4z3LYH710V6RsXShM7y6hT9ik=;
	b=UR++nA0694gA+If7R3tFvWO3EchMfzxF5Jr4xKsmtrflN2fPGuZjheiFhAnx8gI/YvlP
	 iPiNCq+LXcXX9kSFfJ91Eeu6eJwXryquoSsO1OUcCeVslcMvWoISdpjrwd2Cx2kHVZxy3
	 7i0HhiATGeJ809CYhsVGCnJR5Xep/UX+NYuhV54Um9SxXehxbNgKD0Voi/813I+SOxoiU
	 G3hh336veyeuHaF9omP+Zb6BEGLO2tpJQs0IW781ii6xE2sla/2DSFF5Bqqs7r0cA4jzb
	 aYFaW5heUUaHOwk9vf2CLp846/l86PLOLm0U/SPRSBdMCQvL1DBmYWk6ynhWxAuJd3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bm+rWvwV;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35176074A7E;
	Mon,  2 Nov 2026 15:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D35176074A7E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bm+rWvwV
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2EE9cA3103393;
	Mon, 2 Nov 2026 15:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=faMoFAkyez9tsTH3n
	m4z3LYH710V6RsXShM7y6hT9ik=; b=bm+rWvwV7wM/AokLqf4bYLQuyM9eFyWCl
	FJrpK0yOBAZrlWLYhbwtaHyu6abN1Q7HoOUjA52uQ/bzoze6/F/OjYt43+rWitlj
	HafBBXbxPF2+RoEZ3BC8ms3x0LIetqSlnfXqDicyhEADWH/81ydWIXDo9l7qIZbN
	OrOMsvLx95Mmaf8zD+lrAaYxHsIhSFhU9gNKGNeDK+Z+6o8sauehKIOY9F1sEUu9
	6bHGqAjrm+irxxYWeAV55PrQxmgsnpjtEbX626qJPq7xKanlSwZxjoi2V+YuKF6o
	/mJIySnhCdZz/CESwbSCwdPi34eNLfddNQceqy27V4+dyJA5eYBwA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826h8tq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2E5xjb1034511;
	Mon, 2 Nov 2026 15:16:23 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnu1vej7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2FGLr931064664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 15:16:22 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE2945805A;
	Mon,  2 Nov 2026 15:16:21 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98D965805C;
	Mon,  2 Nov 2026 15:16:20 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.57.150])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 15:16:20 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, freude@linux.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com
Subject: [PATCH v11 11/14] s390/vfio-ap: Callback to get the size of data to be migrated during guest migration
Date: Mon,  2 Nov 2026 10:14:51 -0500
Message-ID: <20261102151604.2150055-12-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 7UR6Zf4TLSb35XQ7iEHft1nOOjk-1xXs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfX32ZjAjzhGgiI
 Eq3Z8jY0pkrMEWhHqqX9Z/594fAOxjx2DESJl7d730WrorcpuQBMPt2yTGdIjOMqJvKr3mikrGU
 auPWFQoyiufTxcG6gDOVmRPqV8Z27DsPNIUhWIOhTlLK5bENIRmyko0lxlRLyKB36Sc77w6/gIe
 Gh1yR6CvIiXQlIsYfwdB+8M12f3kPSOBzFH4MtfHGdTkc7v8nXDbmtKuemb7Y0lUN3JZRIuZA0L
 8h7IOG9pqMiOExUIxYXGYv9S2DjnQmlLyqklAoAki2nPD3tCfQI8vv4pODX0kR26VEUazWSRnL+
 wib1AEhQeA/knzDYYMXQD7UT2U7NZbLYPse/GuMLAHfBJs25s4B/ptChg9CsmhvaSot0IvTCCPL
 TdyHa9lNJPISpTB2i9yWh75/3FLv8N5dV11SmTTraHdwLmNUlnbiA2tg0S+mWyhyW8cJc6ymuSH
 h4KweqAsBlTnB30K6OA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfX8DTcTJmUUTwL
 Fe0o58mUgfBkvIHv3Co2sIcuFONriJokYVD1rTdV034gVzai94jWtEiNQAq2Ezmxwcq8LOknCPl
 b1pnBIE7Mb60u55V6NilsS8m+B3y2cY=
X-Proofpoint-GUID: 7UR6Zf4TLSb35XQ7iEHft1nOOjk-1xXs
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6ae8a948 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vZ-Ft76KQvoWVpZ_:21 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=dNOmgfuV3ZSo10a98CMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020060

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
index c5534c6ee3ce..7c282d396f50 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1308,7 +1308,15 @@ static int vfio_ap_get_state(struct vfio_device *vdev,
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


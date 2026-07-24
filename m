Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80FA4457CE;
	Fri, 24 Jul 2026 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911150; cv=none; b=Rqbw17eyDpAxIZ8C9JYp+gAnn6YCfk5lX7tBlxJLRBvCiYf239DFTMyQHzDVN6JgJ1pQy1UEqHaArUKsncbKuAl3wC1YgyQKuZb9U5viFud52LaBLGVFjp0/3k8c25dNxXxhVJ4fyboXayyi6A7m48f30grBjgZQX18vedBO15o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911150; c=relaxed/simple;
	bh=TphgFbBAAzdQNcdeXOt1dvVgb7T89uNXNp/rohtleMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOSweUJEN7v6QlOdp+yrEtr/Sm9dB5sIqAC694xCeiVTVgX7qCNZdzBYTYrec/GYW0woQUJ6t37phyxD+p8BLPCaA7j3NUUbBZhTez2Ts+DMvD1C8tFQZalkPEKcWM0+2ujRVimvBvihYqvDBXjRm58RPGyy7rt7zVsRNI0dMV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=db6FjRWc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="db6FjRWc"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfffG100480;
	Fri, 24 Jul 2026 16:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Cewiy1c02KRJnFsfM
	b1roLRPbtF0Hw4p68nbusKGSwE=; b=db6FjRWczZzvxtVuOH/OYq+b9OCt7zFPE
	hxDHjfmyocSKOUH1ZNf8Qo5P3ki1UvGrNKTuLKXFrEcp12sh2Zbr9SMOQQfzxnIl
	ytbMFwLJWRqPf+7+DPLC5cBa24YvK0MuZTUuDoGMXJHK0pk9aO0qEjAKLUv4qRuv
	PoMECF7txYShyTPO0v5/yYc2kVgBPc7oJdJJtxZl6zz4f7F71ksdlWfnFAQey6ZU
	tDHUQNWTnuOpq+vwRsLa/VeCgXIQlTbCObf9p/UE4Jdf3pbLM7D1zmaTy85Vw5ul
	x/MVkC7XW11iT1FXt8cE3Vzim6RPT25DJue15dDkoGv7vtAU6T8Mg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8gs8u6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:14:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OG4iO8010748;
	Fri, 24 Jul 2026 16:14:14 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gsf8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:14:14 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OGEDWR19858122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 16:14:13 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 290635804E;
	Fri, 24 Jul 2026 16:14:13 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 998755803F;
	Fri, 24 Jul 2026 16:14:11 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.50.28])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 16:14:11 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v5 11/15] s390/vfio-ap: Transition device migration state to STOP
Date: Fri, 24 Jul 2026 12:13:47 -0400
Message-ID: <20260724161351.1802644-12-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfX4cM2PRYoIRlN
 Nn5Yzjp5Pml9j6NP2CuYDZyKwIjWoTEgzqwBfTB/ogz+WbEo+J1DUzKzpxrMSZ6l/05iJneqI6e
 XUY+l7hYU/f8rTiav+4agZsusKokfSU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfX1jVizn/WUp/G
 sgfjwtikk6LbIAbczKgnoL8qbHkn1o5PZWTupGpOi9QsHU9NdTqbJpfuCLonTGttj6tdcvR7Je2
 YiLZpK7EbOsgyAlOT9YgWsbZq7iulb+PCyXPcs7uNhDMYknF8tPBeWDHFWuSWRCgtpmRNFAOchU
 eOsiWM10pYuC1zbTEMENRAPAZ8XixRiCVKAGeJ1/jUUP7bBxwr7kza7fYZLpTrqANcGiP8DuIa3
 SAkt03WZePJ87mF9FWREYpSpzLPKrlx9Uw/gUuPXJ4q/DDojL6pdmX1KwKOt8Odsyo8ZKFQGZ3F
 TxMuyc+GQDTL/c7+BlMDBV8taZ/fcFVmUX9y0eJv8j4xJ6bbo0uGZ2SEwWsnENw7XbQUBmVpMT7
 05w+xgwHMhF/j3smuEGB/8PN3Db2ZX1SXo6zWRGQp3Z9ZxcwTirwPTzKDQjkfrF6q6RD9DAE4Pu
 vEG2/ttzfrFlri8tIBA==
X-Authority-Analysis: v=2.4 cv=Q9LiJY2a c=1 sm=1 tr=0 ts=6a638f57 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=LlGlNFsFWGapDO07ubkA:9
X-Proofpoint-ORIG-GUID: l9ghG5J66PFCOgvTAB-2RYJE_LLAoqM0
X-Proofpoint-GUID: l9ghG5J66PFCOgvTAB-2RYJE_LLAoqM0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240145

Typically at this point, interrupt processing for the device, DMA and other
changes to the device's external state must be prohibited. For VFIO AP,
there is no physical DMA device virtualized by the vfio-ap device . It
merely manages the guest's AP configuration that identifies the devices
passed through to the guest, but does not have access to any of them. Those
AP devices are passed through and controlled exclusively by the SIE program
used to start the guest. There  only thing to do at this point is return
NULL to the caller since the file streams and associated data will get
cleaned up as a result of the VFIO migration framework releasing the files.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 7a9a8f63a76d..21cd9810a18c 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1304,12 +1304,17 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 		return filp;
 	}
 
+	/*
+	 * Terminates the data transfer session of the vfio-ap device state
+	 * between the source and target hosts. Since the vfio-ap device does
+	 * not virtualize a DMA device, there is no internal device state to
+	 * incorporate into the vfio-ap device on the target.
+	 */
 	if ((cur_state == VFIO_DEVICE_STATE_RESUMING &&
 	     new_state == VFIO_DEVICE_STATE_STOP) ||
 	    (cur_state == VFIO_DEVICE_STATE_STOP_COPY &&
 	     new_state == VFIO_DEVICE_STATE_STOP)) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+		return NULL;
 	}
 
 	if ((cur_state == VFIO_DEVICE_STATE_STOP &&
-- 
2.53.0


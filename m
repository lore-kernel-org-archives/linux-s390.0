Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569D61E1A3D;
	Sat,  8 Aug 2026 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208852; cv=none; b=DssSQoWHcFRudEXTtlo8BGNu3ChfxcKEhfbRLopu9XeNdMmftvm4umtzVCRCV2y+LBACC3XptPb3+rMiBYkCnhT8bzl/NkPHNPo6u/DKOPpbvtj3y9XG3RM9FS4sNint+Biz/3IqxUKOdCutsxY2ALtR+qM2RBo0eBUD3l06/uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208852; c=relaxed/simple;
	bh=WotD2MLbxeRHgu/jt/5UwQhdLwGWX0k9HUrbL1gIpxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfJinpa3EAVQNWb0L8czbdHJtAtmSm+mXQMoEA3O+j+TMg8+83stPGSQDAA01nkr2X5xU7Ia42n0cHC4a7p5NDbgkwsSUVgOaydk+1gfwZ0RHVtL3j09zD9O7bQo9cFGrDzklS377f9POtU5ZzwiShhqAYUGZurvVhyYKPE9sbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tFWsYOEk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tFWsYOEk"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 678H1a4i3041381;
	Sat, 8 Aug 2026 17:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wl88axlrYzF3a4bJk
	reen17QLWcHEjfJd08Y3z49IjY=; b=tFWsYOEktIcLIG1UGfnL0hvmb7C9EywPa
	pWQwnzqe0DDaSR1s8CyrfpcToYb5U2z7JpbKr/HhZ7Ynsjep3VXhuR111BM7QmxT
	SkEaCDQgjN0Dg7ad51Ut07TmPKCLOJ0oasCfhTxMM5G4OGlz0aVrvuurt/UHKJCw
	0cxoKMXAG/lI+i2gAAvurf+87ROXz10i2G4dCQZLLRNcOGLGgouqIu4L91jFJT9c
	nySvuvDDBjTVBCVAxGrn8DyAahT62zVX30ppq6/NCwa2B3DiQGSafP3SZO8/6uP7
	F9C0L5PmcxoNS6i/8X6NZxhc7EMYqxPoebRYtyZLiXiQ46xG2+97g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyhs02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 17:07:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 678GuYTs007037;
	Sat, 8 Aug 2026 17:07:23 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4r47q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 17:07:23 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 678H7MWh35258832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Aug 2026 17:07:23 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7CF958050;
	Sat,  8 Aug 2026 17:07:22 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1EB558045;
	Sat,  8 Aug 2026 17:07:20 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.94.189])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  8 Aug 2026 17:07:20 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH 4/5] s390/vfio-ap: Fix required lock not held during update of ap_matrix_mdev object
Date: Sat,  8 Aug 2026 13:07:11 -0400
Message-ID: <20260808170712.839066-5-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808170712.839066-1-akrowiak@linux.ibm.com>
References: <20260808170712.839066-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDE0NiBTYWx0ZWRfX/3fG4AZtWYne
 K+pNgcqTkN0HwZ4+pKH2GwOXjbJNkAu6P77GXM6CtDFrexSCvtGzWOcX72iITaPWRbeZ0Tm5azu
 k9H+yOPAjpt2yv4/PVOyXUtVxLGF41dbZq/B3BEgX68fqIN6bEK1Hd2dAWGyM34a9PMDANoOPUq
 CCEW3Pq2gWjAd+tjd3fgnR14vuFBzk+T60sw4NjxBofHsJb1U3Ueie8WUimj6HWP4pdbD/+T8Jk
 HMaYoNMkP4WZfcbXWHORJSInyCoTffegOqGXXUyBcxoqC9bukv+U0E0jARWCfnWc/lJ+KuAUaQG
 l5HiaL4JkZhS78yItVPDK4gxxgN1a83H4XjqRNUdK+1Lsvz5xZ1yhsFBome1IvYz6TKQQ0VLIz3
 SlP6mWuCR+GRPC7GulLE1/76F4Ryxh5nY3nlnzcL/hS+Q0ctxFPQlYKosWbFaETWqvgfQM9bsfA
 2ayw8i0FcUSRe1ynQdA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDE0NiBTYWx0ZWRfX3tF1XiaEWaeL
 4kAxTIuJLssaDu9va73Qds67G+2onYWWddZpaWA9fsNngEUpoLVbCE8RHFy8XHeHBlicA68PYqs
 KA/BnhWLt8d7G95qZKEp6/od29k2jmM=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a77624c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=mm-sKQyJWPVlA1vr6AIA:9
X-Proofpoint-GUID: AiMZuteYNdAbWYx18w5tB_q6NOh9-Wcs
X-Proofpoint-ORIG-GUID: AiMZuteYNdAbWYx18w5tB_q6NOh9-Wcs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608080146

In the vfio_ap_mdev_cfg_add function, the apm_add, aqm_add and adm_add
fields of an ap_matrix_mdev object fields are modified while not holding
the matrix_dev->mdevs_lock. This lock must be held while making these
to guard against a race condition with another caller that may be
concurrently modifying these fields or any of the fields in the
matrix_mdev->matrix.

Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index a472de00bc14..897518b88c28 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2756,12 +2756,20 @@ static void vfio_ap_mdev_cfg_add(unsigned long *apm_add, unsigned long *aqm_add,
 	vfio_ap_filter_apid_by_qtype(apm_add, aqm_add);
 
 	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		/*
+		 * The mdevs_lock must be held in order to access fields
+		 * within matrix_mdev
+		 */
+		mutex_lock(&matrix_dev->mdevs_lock);
+
 		bitmap_and(matrix_mdev->apm_add,
 			   matrix_mdev->matrix.apm, apm_add, AP_DEVICES);
 		bitmap_and(matrix_mdev->aqm_add,
 			   matrix_mdev->matrix.aqm, aqm_add, AP_DOMAINS);
 		bitmap_and(matrix_mdev->adm_add,
 			   matrix_mdev->matrix.adm, adm_add, AP_DEVICES);
+
+		mutex_unlock(&matrix_dev->mdevs_lock);
 	}
 }
 
-- 
2.53.0


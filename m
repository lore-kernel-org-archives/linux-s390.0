Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F8343440B;
	Mon, 24 Aug 2026 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579954; cv=none; b=Alfbrbhe+6Iy1LLASF5Yn5FPfrwOIlVUBFUNkjfPI25NcDHI9fdT+kyRAVryZJTK3Ks6+6wDOS2XyMguUnJq2Gx4tUpDxaafZIk0h7N/OWjjpLeAGkIawmu6GYE2+qAobF6mRBSkuQEmcWdhBJnW39/LuiDHJxoi6nZ7HFYh7is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579954; c=relaxed/simple;
	bh=u5PcjXXMkyrMbwr9ocAZBcB3+1JFv7Uh1wjohG7yBkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owPyz/7CWN0Q5nhHXk/dlAILnyRdSa5BjoyyfvCdxmlLnoW7xnoBxKQVjPO/Tzesa849Fs1OsoHa+0DD3gOtMReA6NtVFYYFHQrxe1nxbcBXCQv7J13zroYi3/q/1IHlD2lTfQS1VzcNmYGMkmF8xvRqFDaVVmspvPTqdtjK0p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hm+l6Mpf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hm+l6Mpf"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1igo1936424;
	Mon, 24 Aug 2026 13:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=idf93AL5F33fKA9JO
	S4Nfr/QILfiPdquLMsyaOH1PNA=; b=hm+l6MpfCIEDcFQ3QcLmjqrSk0SKvwKLD
	r0k6SfLMGJJkfvLiMWGlXThMaDI9gjY0IF7GWCGSY41ZxsQPbpyJ9/UQ2J+Dz7w1
	gvPejbjHvBF7kXGLvFU583dWf173N3IPeABthNZg/uXVOjzZXfoGz64nGnQgKNUs
	4suzQ81CUHI28+Tz6dkaXRD/Ya63PG47ftxnATXTtdkNZ1250ucVXfAC8VxlxYkp
	fIMcxcxWsXWOP0KdpmksUeA8pFsf1Z+q/b3bAcOfJzQfT8+YIwQp4baEdiYLGtB6
	Ci234YYumJF2SQQv7AstR/YdUODsM6aHs3tB7RO/dW8VGu1dyIrCQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393srkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 13:59:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ODuWcY017298;
	Mon, 24 Aug 2026 13:59:02 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jp8yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 13:59:02 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ODx1KS58196356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 13:59:01 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 377295804E;
	Mon, 24 Aug 2026 13:59:01 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54DEE58055;
	Mon, 24 Aug 2026 13:58:59 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.96.163])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 13:58:59 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH 4/4] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size in vfio_ap_mdev_cfg_add()
Date: Mon, 24 Aug 2026 09:58:50 -0400
Message-ID: <20260824135850.503728-5-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824135850.503728-1-akrowiak@linux.ibm.com>
References: <20260824135850.503728-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BbsvJdAyeqtrO72r2GHyiwLD9ZlKmjBf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExNCBTYWx0ZWRfX0fQSVntsRA4N
 1eisFPA+qWUa84JoNrE6b3oSQpFME6R5LvZnvNGqZ3Qf0JX7PYOTLx6pbKy+JjyfKLr4s+MXFBL
 TjIvVmomUem7ftZBC2D2klNJoWeBt8SbYLfgXDwKLnfOjwGPqFdixEFUvwYbNjSnO+zaM+lH7aG
 jMO4wKcs1gdUhIqti0BW5pqc+PR9x5b3DDUE1yph4S2TW34heUPX9phBAkzxPUU2IfLPKXI3RIy
 GBHm+mJLhQeWyOgqD7/HE+2Nxle3RGcT61jh6nL4UTWMUFeVFOajgMnS7MAbtsCNki0KMxeSXxF
 ScJgiE4CyxXQJ5n3NiOSTbG53far7223guxbsp7KJd3APWZthW01vqthAbiwBslVHx59R6Iw8iT
 tV009XyaBOzS5YXxqtJkfES568+UDkGal22i6N7Xx7QLlizdb74mX1RBri5BTcnu9VC95SAvtu7
 m5aI3o/6HQOkOuaLHkA==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8c4e27 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Bc7Uef-wSWuaPYxFuNwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExNCBTYWx0ZWRfX3yiOUvHGsRAO
 lraBflxWe14RaL5hD6uBBXmrSiNuFHCzsa/GWOfqgS4KcaDko2rXymbNVq95YfmSGYRtkUr1gc6
 XdQ5HstB8yl2H8qyh+kXaxCenH5JSZA=
X-Proofpoint-ORIG-GUID: BbsvJdAyeqtrO72r2GHyiwLD9ZlKmjBf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240114

In vfio_ap_mdev_cfg_add(), the bitmap_and() call that computes
the intersection of newly added control domains with those
assigned to each matrix mdev passes AP_DEVICES as the bitmap
size instead of AP_DOMAINS:

    bitmap_and(matrix_mdev->adm_add,
               matrix_mdev->matrix.adm, adm_add, AP_DEVICES);

Control domains are indexed by AP queue index (APQI) and their
bitmaps are sized by AP_DOMAINS, not AP_DEVICES. The two
constants are both 256 today so there is no functional impact,
but the wrong constant is inconsistent with the two bitmap_and()
calls immediately above it and with every other operation on
adm/aqm bitmaps in the file, all of which correctly use
AP_DOMAINS.

Use AP_DOMAINS to keep the code consistent and correct in case
the two constants ever diverge.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index c7eebbd0ed40..e62e0dfa7282 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2840,7 +2840,7 @@ static void vfio_ap_mdev_cfg_add(unsigned long *apm_add, unsigned long *aqm_add,
 		bitmap_and(matrix_mdev->aqm_add,
 			   matrix_mdev->matrix.aqm, aqm_add, AP_DOMAINS);
 		bitmap_and(matrix_mdev->adm_add,
-			   matrix_mdev->matrix.adm, adm_add, AP_DEVICES);
+			   matrix_mdev->matrix.adm, adm_add, AP_DOMAINS);
 
 		mutex_unlock(&matrix_dev->mdevs_lock);
 	}
-- 
2.53.0


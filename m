Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777443;
	b=Qnj3ppx1R/kOdJv1Fmu0D/ElQYDulOcYCHkprPmHu5NbeQVfeWx1v2bmKP0CS5YFhvCH
	 89rk9CiGmrQNbEUD14n5kMmh97tL2N64+v+GYO3NBaP6jxhdT7N7FW9s4Qlj3x9jbkFPH
	 KNfEHrahDJQ9ZkIqZhH4xlrscQcnC5vsqz7IJL5N5Mf+PYryJ/NuaTp8Lt87Lo7AUyBcn
	 /TjQ5Dk/cJJqszu8oxGYpQr6fMmn3inC048VQWnhF7gNrZkA1qocd9TydqIH1qNIWrS/j
	 LETc4sAP/A4EAw3tv+U4pgEpRd8OELSt2YIcJDgJ/5f2xZqVS/iNLcSDcC3R04Pb5mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777443;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=GvsXguk85R/E8jqlLleNCGdkBhGGMMi8sM2lGJW4Nfg=;
	b=Y9gsPIMGI1W54xaiCLvpcHJANV/lsX47mBXXEjIrnr7c4M4AI727BM1HdswQ/S/yIGSY
	 o6kIg+dviG+sTvX+37s65sPZAYN7GSbGqgn2x2qzEnsUrA3eC7V71tF1IbLKGmzBeqylC
	 eQMnQ66sjt/V+NgSax/JnFWRhvhQwW7uvToBvsCCdyze7uP4tOOFSyoefF/0s/VWDTRDN
	 fzXoBjPmfYrwxaHB5N0XYkjLTMoLib5mYhZy0beekbdHW2p9QKlq3U7pp9mN8Gc0B6mL4
	 1B9rRFf6P3ucnnwaDzk92yRCvE4Qay4z2cm2SkhcMZuCXEBJTvsKKgy0qTnTXmXBdxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ghgja3X9;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB93606A31A;
	Fri, 23 Oct 2026 17:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FB93606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ghgja3X9
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NGoUAR1896005;
	Fri, 23 Oct 2026 17:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GvsXguk85R/E8jqlL
	leNCGdkBhGGMMi8sM2lGJW4Nfg=; b=ghgja3X9eXftQQlQ0d9orqNd4toAwrHPY
	1ut3iOOVa/UQ9jvJA1/3p30qfOtyRgCCMEqnq+cza/XHiJUed1Yl+TbPOPUySqPx
	8RukJ6Rycw+vdZu6jjk28dHpu0Lvv+x5uNHWaybrvQz+kHNiWhSkDAJMJFPei1UV
	L0aGKKi21XzKy1c58Y7gLS8vqJYnb6Xqxu4kn1lHBIou3k0DP1NYz/KldIWG6u6H
	7xJimC8pym8n51b+n+4R0rgFn3O0xheYavPWdOX9clJQtpbbMLlo8u3syMuHIbIe
	vfAIAHUpDeah/9x6PCQti3v49FRDtZSWf1JtGwZM2vQSBIJ1F0D+A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5bxrr7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:43:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NEL4or2203377;
	Fri, 23 Oct 2026 17:43:54 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hekdgn6t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:43:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NHh5Ts10551958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 17:43:05 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3456158054;
	Fri, 23 Oct 2026 17:43:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97C7C5805A;
	Fri, 23 Oct 2026 17:43:51 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.48.60])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 17:43:51 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v10 01/15] s390/vfio-ap: Provide function to get the number of queues assigned to mdev
Date: Fri, 23 Oct 2026 13:43:35 -0400
Message-ID: <20261023174349.3545941-2-akrowiak@linux.ibm.com>
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
X-Proofpoint-GUID: 82vBWjr2jyHB-3zWtvuUnOgGme8krcXy
X-Proofpoint-ORIG-GUID: 82vBWjr2jyHB-3zWtvuUnOgGme8krcXy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfX6I81lsE5Wy7C
 f05yjO8FaCFOnQpr/y19TNsHDnH0DNELbM8bJgMQW1mrEyNTcTVOQ77BE8cdPBH4kc5I5ID41q9
 vo5qijz6FkNpcoDcETvq2/Xr7QZMR8k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfX3tCrKe6vNYQr
 Fb+SyMx12VFVvMBkUyiOFJxf45VfNsD8ecy95MAxfCGIGK9jQnDbYeQCunBXLaTimBzV/IzOuNL
 Hy0ezudGthAz23uiS9SEROnxw4Vh28qbJu5pJrIe9hE7o+xfze6HFQcMeQfKZXIZB9kw1+CBT2A
 Z/hgSaBHVA3Z0Z4WxigJuC5v7qjCQxuudUXzA/eK5E7zJX2o1PaJLpjlCh/tVaKx/UCc5rN88xr
 hR9xbAnOn9AYZ0HK2a93o8DhNatctOLrxwTZOYzWj5hXwAnlazRYHN+2ttRVFbj9fozawGzhwF1
 TV7dykXBGo4jVShCzHLO9gs72fPv4hiAtn4i8/7TDLdCqHdyqYv6VBqnb1HgnK2hzHMPir3Pfea
 uvp/emLsEmGOUsUVazMo0lIUNfDnGT8fid+0rf73WvCXoiMDZbIUzO9lRiYtdsnkoRhy4qaM/fh
 1S7d91OAyob9ejdN5xQ==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6adb9cdb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=yQsB-kB7boqL7geEApIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230067

Provides a function that returns the number of queues that are or will be
passed through to a guest when the mdev is attached to a guest.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 8 ++++++++
 drivers/s390/crypto/vfio_ap_private.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 4db878c18f41..345c52a328ad 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2105,6 +2105,14 @@ static void vfio_ap_mdev_request(struct vfio_device *vdev, unsigned int count)
 	release_update_locks_for_mdev(matrix_mdev);
 }
 
+unsigned int vfio_ap_mdev_get_num_queues(struct ap_matrix *ap_matrix)
+{
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	return bitmap_weight(ap_matrix->apm, AP_DEVICES) *
+	       bitmap_weight(ap_matrix->aqm, AP_DOMAINS);
+}
+
 static int vfio_ap_mdev_get_device_info(unsigned long arg)
 {
 	unsigned long minsz;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 9bff666b0b35..12d7d240addd 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -152,6 +152,8 @@ struct vfio_ap_queue {
 	struct work_struct reset_work;
 };
 
+unsigned int vfio_ap_mdev_get_num_queues(struct ap_matrix *ap_matrix);
+
 int vfio_ap_mdev_register(void);
 void vfio_ap_mdev_unregister(void);
 
-- 
2.53.0


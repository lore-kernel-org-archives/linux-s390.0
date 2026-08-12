Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE8442123A;
	Wed, 12 Aug 2026 11:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535523; cv=none; b=rR6+wKPibzmlFQC/nwili10w0+rBgo0MEai9SnCkoA2T66MZ9l0XjiZ9AkTVOLNHsprCH1mTxXOihfNRJEkOFZyp6ww6lOk/Nt5mfbBxYsYWO7McD1HSEbFt6Qgndfv04qeJ0VphpTzGJ3hN+2xgR5PQg4hS3nUFxwEqA1WOXJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535523; c=relaxed/simple;
	bh=6pIVYxg/Zi9Biw6oG7xoB05YTxSPhOplE9YZxeLj9dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DK/h9KhcDmpwe/ew1NZsSwHqeD2qQiBTJyQW+Zk6d7Dw5kOy69VCuJW3WkkIgmY4yipzPZunUcdvfQ2fRP7QbpiqEmIl/zuf9I7q0SzHW+ew6cQxeYxMUoGbxjxtImxG8tgiFD1YfeR57MzDf98s4X6b5ytOaHpwLQxlGCiJODI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OCeq0HPn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OCeq0HPn"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3s6j2205543;
	Wed, 12 Aug 2026 11:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=q95Q3msVO00Z9Po4T
	hOOjQXOf5Koz/qQvAUzQfas7xw=; b=OCeq0HPn1WboCfXkevtWmvEgQhFA4ykM8
	loM2WPNTW1s3FunKV65A3ZNkG3ctG75332qesQjxXUcHtw89F6I+9VrbZhDqZIPo
	o7QSbQ9FJKaYbxNnmIdKD9+G5uyV7QRCbi6sY3XG6SwjhF0GZG6R0f895VP8MLK3
	0sr6VJZIxZ3uOrp7/KskOoLgIto89yEvyjiTBNAf8WBDQR2Qe3P//qthNHVLAO52
	ce6R3i2Q1yEQi5pGgjGrhSpDcm1sdmCceF7Ftowh71BlAQgB67C9clp4ntTtW+8R
	d+Ht4mL7OP4qJIiCXVndTdKe3Uv5cbm/3VZYF64fd/5EsGXa3u4Mg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23tsnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:51:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CBfO2v029386;
	Wed, 12 Aug 2026 11:51:54 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h5req-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:51:54 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CBprQn7144166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:51:53 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62BD05805D;
	Wed, 12 Aug 2026 11:51:53 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBF775805E;
	Wed, 12 Aug 2026 11:51:50 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 11:51:50 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v3 4/9] s390/vfio-ap: Fix required lock not held during update of ap_matrix_mdev object
Date: Wed, 12 Aug 2026 07:51:34 -0400
Message-ID: <20260812115139.576303-5-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812115139.576303-1-akrowiak@linux.ibm.com>
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7c5e5b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=mm-sKQyJWPVlA1vr6AIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX32+DjrajbGot
 rMNFWIKobVkseK474eH+i4mJDIEiGw1Q2izCxTWq/3xJwxwY1C3g1rlDmpifnWgXzo17C/LS/P6
 F4ndzYG7O2+8ZfqifXjIqpzBqFA0hWdYFCSvYEEzRZMAU540LNCBcmkilsv9gN/JHHpsXxW4sbd
 maawWx7qupv9iU4MC4BfavOPi4sFLo+2kuhzGZruBGSqeHJBhGR+H63lV2XIaDrB3bYMqHgsajS
 NVcy3lgcf/CFBpR+98WaNqyEms1xBKPfFMqfYZwqc/QCmZaDwovSnHmogH5jjn0AN3/1Vn06Jia
 Hj3omLd0J88TZdqGhg2bsLNPSmGJXSNR84EVErIjUz2AyEofJUnXKoEDryUlJV34ohtwI8xvBKb
 KmzHgDVspeZMSgG6hwCW/yC92hlCtkcbeo+ysmYMwDkanzSsr3+bCYMJHfCemUPzugFw9t0M0g7
 m6K9sH4I26/KNkOzE3w==
X-Proofpoint-ORIG-GUID: GjKhEaDZuZap3hq4YL36UwTXNWnsfaZv
X-Proofpoint-GUID: GjKhEaDZuZap3hq4YL36UwTXNWnsfaZv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX2qNgNMB9x/LT
 ioJMHboYdO5oYV2MdWmEzYF/0vVZAikMMYAsZiRKtWfN630LCrVp2SWnAn2ga+pgerLEIuh1G8r
 ljiBdmQ+8xLj3DRaYU6Omzb61i05G0o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120093

In the vfio_ap_mdev_cfg_add function, the apm_add, aqm_add and adm_add
fields of an ap_matrix_mdev object fields are modified while not holding
the matrix_dev->mdevs_lock. This lock must be held while making these
to guard against a race condition with another caller that may be
concurrently modifying these fields or any of the fields in the
matrix_mdev->matrix.

Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 5c14ded4fd8e..8a1ecb891504 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2760,12 +2760,20 @@ static void vfio_ap_mdev_cfg_add(unsigned long *apm_add, unsigned long *aqm_add,
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


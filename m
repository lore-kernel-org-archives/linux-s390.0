Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD2F382286;
	Wed, 12 Aug 2026 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564982; cv=none; b=BGoelEUgtAz9kjGzWObWcgbFTc6/QsM607cTF6IUDHr3WIP2GyIIjPuWuGAGzn+lxlTzEaspOhxfarFhc658ZtHB54rFfFs4rsgqnPjPv7oi5zgYzbzmF5PxGprIE8JtG+K0fSxa+1G9rvq05AXaex+sAdwMBEownEebF6JZyyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564982; c=relaxed/simple;
	bh=5yyNdGdxAelRtvmaSTyzi6Ux60obfEZJ1rH6Pw+dKr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHtvn23IDbwlcE5SwSKLQwD9Qe2QddeEN5nc7RfnqTSgIXAnz7K7Zupo6V4yFGD0i7KXRTCEGXx6Adt5n0W3yAI6kL7THB+fXY/PPiL4UnX/mEMrmRcxfM9/9U1lExILzn06sOiybyPsUNS+fDxcic9mZ4sML+toIMglzU3IcKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A75FbEOg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A75FbEOg"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2sBV323334;
	Wed, 12 Aug 2026 20:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=m+vJqnk7rifev6aJu
	KE56s9GIpbulLzAG2kXbqJoKd8=; b=A75FbEOgzORQTKcWBUnI5Z3owtPRClnz9
	NhRhJd+SsbgOIiRKL2RabC4BAE0pd/6TgWsRjG6ynoe62pq1iYqoy22pPpW9jyDT
	H1vOauac/ZPpysu5NfpT/CFPyFmBp3fW8yhE3c+pXtixpTgdTCYGXkj4aiU1rCmT
	aFPcmJWv3xsfg1wwZ/e2pJSmSb3FTEVrHgHAIfHpfqE4ng4u03mzpamD3TiwMpOo
	ugd0DE/FXRIr5FwCqrPhy7iOCcm+pfJ4AtTXMS0KGRJiPwtAe7gKTNQL99FvVGOQ
	fa89/JLDO70QBnQR7Iq2TiVyfbo2bb1kK2qX0sK5N8izuiUU2vzeA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwbk63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:02:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CJuFkb030845;
	Wed, 12 Aug 2026 20:02:51 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq7y4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:02:51 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CK2oUl50135468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 20:02:50 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1890F58052;
	Wed, 12 Aug 2026 20:02:50 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7778958045;
	Wed, 12 Aug 2026 20:02:48 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 20:02:48 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v5 4/9] s390/vfio-ap: Fix required lock not held during update of ap_matrix_mdev object
Date: Wed, 12 Aug 2026 16:02:35 -0400
Message-ID: <20260812200240.818004-5-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812200240.818004-1-akrowiak@linux.ibm.com>
References: <20260812200240.818004-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7cd16f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=mm-sKQyJWPVlA1vr6AIA:9
X-Proofpoint-GUID: uxSe5x358MCbGEq1Ur-5xR06yDDgGpxn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE2MSBTYWx0ZWRfX/S0c1y+jgYYr
 bPZOmYlFueHTyY3vt0SCfdB4j6o9gbjiUn/sbIiVSvOcC5B6kF/BLM1JglZcSuMK3/44c+k2ZQs
 cvha4ZRe4ZR1kGbgfyxxpDJVbaUt/vqteuA4MKKxOMuZGcMEWd/yzoy9Ew1gaWuQQITnN0imPJ5
 wk5XmPGNHfDXP+Uy3ayzunasCokbeV6EkSxly1tzAEMS2qY6C6VMRiw/4Zkt6z+ftW27CDcdXrL
 hHVnTYRTrmI2EIggD6ac+SbUSyiZk6rzWVd95cu6tWWfvd7EEP15bA38nCM1KwdkjKW0i8eT5jU
 Ue9VWrecU6FlzfQYpLQkYrampN17W6pCXJ2FDZS9PkBni5+Wp1hq2uuWgSA4lXSRUXhKL+q4xOa
 8gsJo6biTERAUD9VmAMFRoq94O5ukPR1UcXKsDV8QQ1QKEQsHuVDWk5tcwgWpmTp4+204ywR9vH
 NPZyd0v0/OboU33yb7Q==
X-Proofpoint-ORIG-GUID: uxSe5x358MCbGEq1Ur-5xR06yDDgGpxn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE2MSBTYWx0ZWRfX9hdq89EBBZJF
 yjdmfz223PasW9PNM5yZUj7pBzYuVfVymD3uMXHax19KTLAhGlPFcDwMbya59Uy+GtSOfQqIhmX
 gYZSZSBzBBfT9yfeI5susp5THnx7CPc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120161

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
index f2d662e388bd..21c502598f8c 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2777,12 +2777,20 @@ static void vfio_ap_mdev_cfg_add(unsigned long *apm_add, unsigned long *aqm_add,
 	 * called.
 	 */
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


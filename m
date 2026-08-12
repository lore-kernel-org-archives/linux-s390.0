Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A2F4854E1;
	Wed, 12 Aug 2026 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554608; cv=none; b=IXl+mwllR/ZNzkU7ZycphtFTwb9W5lx2T4gIv3eNPjthZerWH3JpR2Eq7WVIglDVl5cABhIuqgAwivLk/gHeqNCmQ+H/x5E3Z+adfXG3Xj1WSbtxLsemGJtnPRIY4XBiaEg1Qor80EX0GcpDJdIDJdvoFKXcTuGj8iV1v4EeDrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554608; c=relaxed/simple;
	bh=LvcESi7r4phfMktiGhYDeMseRSCC8mk9Ng5I7F8w3PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1H+aNBXTrEo5YawyK2fUro4c9iHwxlZzeugMbiksxV/QRdBuff8/DGOBMpHcHYbdoKyADl5kSyvmSrudZWDQ2PVJtrs4PUdC13QvLG6HdyG+YwtzwlxbEzHRjv4W78yAj2/OQ+F1HkuNH8PoEpUw2FUtMo5AETSvRZvvx0b2mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QaH8XDSE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QaH8XDSE"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1hws4088626;
	Wed, 12 Aug 2026 17:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sazpVixfHdXirHhEV
	VGeSXrc+jqW3qBXKYpISBO9BHM=; b=QaH8XDSENVrjCBILKxWvVCXbfnLdi6LKn
	pwllABaSkupiogpoS42XB6dAwr6vkTeOLl6RBssAj5tUbSRnxFByybdT5PvtRAgi
	+ua8G+LgJj3NNZ2zTVhD2fHUe801RFnDRveym8SwNRSF9sPljDdS15UDdisMz0RT
	iavg8wp7NB1yelwa2PoT92ffwTNR8vLGnww1ketZXsPInylOCHuflcTMReFwDk66
	/2jDP3A0BEp8GTZtgQAUcqCnPQY9NV0Xo1qaFVSxsKNHrL6N2HFJqNu/Ss3YaGMf
	aEPNerbo0Ad+jHFKbCKDH4+rZj/WKvFkQbb4V0KAODIkqnH6XAoPg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9uqu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:10:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CGulhr009531;
	Wed, 12 Aug 2026 17:09:59 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjy3k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:09:59 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CH9vtv25035312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 17:09:58 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D09A25805D;
	Wed, 12 Aug 2026 17:09:57 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C336E58043;
	Wed, 12 Aug 2026 17:09:56 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 17:09:56 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v4 9/9] s390/vfio-ap: Fix memory leak when queue removed from host AP config
Date: Wed, 12 Aug 2026 13:09:45 -0400
Message-ID: <20260812170945.738351-10-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812170945.738351-1-akrowiak@linux.ibm.com>
References: <20260812170945.738351-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX9FeJsAV30krf
 niOadG5VXbNgm1usQC/zpu2A2c/YMCy09GyHiM2myA3nKk8YKpaBXX+HgKFsKZmBa6szMzWJnx/
 ++5KdO+jBczk+5nPZulGBvTlyvZuuLIAwQeiafKVNuLj5/WV95ueQElJ/UBe8sTios2PXTaS6g+
 fV6PBNNnQIvFJlisEaZT24yIF8sPWEMH6XD3cst5uCDL+GKxWr0lKjgQRWAmsmNJwR/TLEbuNF8
 oGkV/VnxI7RfGF3fq++tFsUAD+AJDWjD7fpXkc0oY35ybMQlvGYqR8zi4qt6N5/UMAOAs4S9U0r
 0OraKmZVOZ2gTucdnMg9ReC2KWQavdmW/3bvbD7ROkwMyghP4Pp0z7yHOofi4wbHG8P+OqWTCEX
 p3AbaxgAET7imuK20kb7tyPhfqBI+/YbsGO++boAsUks7JFxK5lNv1BIwMdpE3GndF+bdn9CD/t
 LO8Fr9f+aCAPv79b/Aw==
X-Proofpoint-ORIG-GUID: 4emw-hh6isvJIsIpsjEBDMcTLd_8ls_p
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX/FI385+EEL3f
 IeTe+rD8SZhNXfkpSYxWua75Xs+zryJxAoOLmzuoV0muqQzdd2DaBmo+8LEtgVL/YSfPbCT/pGi
 iamm4RXMQYqTMSO0DOIUXQgTcDcRUfo=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7ca8e8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=VrB3zfVs-A4ss5GmTxoA:9
X-Proofpoint-GUID: 4emw-hh6isvJIsIpsjEBDMcTLd_8ls_p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120138

When an adapter or domain is removed from the host's AP configuration, the
AP bus invokes vfio_ap_on_cfg_changed() to notify the vfio_ap device
driver. For each ap_matrix_mdev object to which the adapter or domain
is assigned, vfio_ap_mdev_hot_unplug_cfg() is called and removes the
adapter or domain from the matrix_mdev->shadow_apcb (i.e., the guest's AP
configuration) and hot unplugs it if a guest is using it. The new host
AP configuration (sans adapter or domain) is then stored in
matrix_dev->info.

When the AP bus subsequently unbinds the physical queue devices associated
with the adapter or domain that has been removed, it invokes
vfio_ap_mdev_remove_queue() for each queue removed. At this point, the
adapter or domain will no longer be assigned to the
matrix_mdev->shadow_apcb or the matrix_dev->info object because they would
have been removed by vfio_ap_on_cfg_changed(). Consequently,
vfio_ap_mdev_reset_queue(q) is bypassed and kfree(q) is called
without executing vfio_ap_free_aqic_resources(). This indefinitely pins
guest memory (q->saved_iova) and leaks KVM GISC resources (q->saved_isc).

Note that resetting the queue would fail with an invalid APQN error due to
the fact the queue is not longer in the host's AP configuration; however,
it is still necessary to free the AQIC resources. The fix here is to call
vfio_ap_free_aqic_resources if the adapter or domain is neither in
matrix_mdev->shadow_apcb or matrix_dev->info.

Fixes: b9bd10c43456d ("s390/vfio-ap: do not reset queue removed from host config")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index b0454a296c67..a8de98d5e71e 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2515,12 +2515,15 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 	/*
 	 * If the queue is not in the host's AP configuration, then resetting
 	 * it will fail with response code 01, (APQN not valid); so, let's make
-	 * sure it is in the host's config.
+	 * sure it is in the host's config. If it is not, then free the KVM GISC
+	 * resources.
 	 */
 	if (test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm) &&
 	    test_bit_inv(apqi, (unsigned long *)matrix_dev->info.aqm)) {
 		vfio_ap_mdev_reset_queue(q);
 		flush_work(&q->reset_work);
+	} else {
+		vfio_ap_free_aqic_resources(q);
 	}
 
 done:
-- 
2.53.0


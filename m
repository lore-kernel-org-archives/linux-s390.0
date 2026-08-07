Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0AE4746C8;
	Fri,  7 Aug 2026 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141137; cv=none; b=q7Z+ot7hX/+UljR1gv044FwWaYt1Xd2x/ENbxvpGHpFoDq8m8+MQ0l3xep6gSufN2uDiab8Bc8nTRWRTU332Uyglr+6VxAmT2QDDC/GC6SPnts8Nu2HZrgFcOcWeUNb+/iTSBEg9LPqzyjrQIY1vfTbknBMbEkMUYR1vBlIXmkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141137; c=relaxed/simple;
	bh=Lp5hIIH3pXMdTiX8+4eSAZSy6qdpM342/tICXHPmiMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7mS3hU8BJtIRbE4IRvUu5E6dPR/c1Md0MwwS9V7Qs76aWY5Qes+eGB1GH+ZpMnIUOdzlw2r93GrJNMXeyqT1ciyZlhDp93bbZrSIcGBZUvNE7xH1Qep/KXK9H2xl1TyVcRH90VzcUsC6Q802wYagfni7mtQRCWFnxCy2zKRuKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UVbpJDB/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UVbpJDB/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677LluA3800404;
	Fri, 7 Aug 2026 22:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mLPJX7QYxEox3n+9i
	rnl15hTkSY7EqwpDliyGZ2tcFk=; b=UVbpJDB/RNY599k0W2AX6BOQ+4/PmYnXf
	lQpa+6BNRBixfTtgfRSwaM+7JuvQcCpbxiZmPLkU4/q8sPAMsG2L6w+WRoJRxO51
	dH7dtMPexI/DwBg+azfSy1wZwb6pMeZAgodQHN/nHQICOdu6bpE0uYud2RFnuxfX
	LBlPo5QlZIxhAm1UyKxmajb9IFxxnwp+8BS/hAyzZJw1YOolPNVGXhk8gHuGw+n8
	Mdds9o550o32h9kA6Pr1iAeMS4CJiSQf/Jn6Zzo5g8GTbDCVO0rISUhFbG11fI7m
	5BDk61q14xyt4yW3Zpznd6d6n4Yq07KD2CONqXBq7W/BZKQncFCmw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy01p7xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677MBRZB003628;
	Fri, 7 Aug 2026 22:18:49 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhskqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:49 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677MImHs32178840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 22:18:48 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31F5D5805D;
	Fri,  7 Aug 2026 22:18:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3027358058;
	Fri,  7 Aug 2026 22:18:47 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.52.19])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 22:18:47 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v7 11/15] s390/vfio-ap: Transition device migration state to STOP
Date: Fri,  7 Aug 2026 18:18:30 -0400
Message-ID: <20260807221834.562851-12-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807221834.562851-1-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JJOFV9dQzHREfrtROkxQD118BHVAc8WF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX2cgVq09evvaP
 ZnpOiJxgbZFe47bdBfydm/Peut55Xf4aTfIzpzEjMVKMvBHcetfcLEgy1kgJ7UTVteH5LpGQ8wu
 QhSjmNOFJDlHbjbgWzAi4JobPorcLmE=
X-Proofpoint-ORIG-GUID: JJOFV9dQzHREfrtROkxQD118BHVAc8WF
X-Authority-Analysis: v=2.4 cv=afNRWxot c=1 sm=1 tr=0 ts=6a7659ca cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=LlGlNFsFWGapDO07ubkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX3K63JzNNSJ+T
 hyiVXuCLwJIOR2Zb/mo7L81YAWjE0HsUSZlrjCb1DRGDx8emPqmDDsQExNmaUUoU4bw4hu04RsO
 xWJrxDYd99XuP66F3H6WqrbD4L18YYYGuwDFvXuRkG+pvNcQRt5os9kroDmSMFS5BC26yOKXJht
 AiwZIEYqJ1zyizOCaWsvEsu4XEqLMIQsAjCsuN9Gzckt8SRf2fgUDnLgS3iunqCzZfOlKOxGeua
 1afmLCg8xMxaf0Lgrn/gXF+V/iGa8a6xyDVCQYuvOzwbND2MVodb7nppMmRttER54wBxGKolQ9f
 otfCjCqvBlLSLXZRlWmeI2NgGl3tSDEMyDabCw+PpLK05SNtokMPjQ2IzptaxNoUYvZSZVN2eoj
 E4JUAJv+Kk2cnQZ4hhYVFISSDjoZdwF+gzNu3Uh42iodvzgvpndHYI9RZjnn1wsCwpPH23rTdcb
 6qr7f/HZ63MHHzQDmpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070175

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
index 4dd7373c3d9d..30160e3ddded 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1511,12 +1511,17 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
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


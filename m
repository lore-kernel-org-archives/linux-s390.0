Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3CC478869;
	Fri,  7 Aug 2026 22:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141139; cv=none; b=pNN0oKOu+NZyO5mjBRFSS4/9BdP5ptxBLKlJj27GWxkYWnwTQ4l/uEGYQADraj42uiJisp+0n3j8CIiP/f+yAfbOcFqj9jB+KxS8iT6M2VKZeHm9x6YbDuR9z+ifFZOoKgr/frEsjWb9gTrdGE/uHuE/S7v05GgZlNSy+B0BNkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141139; c=relaxed/simple;
	bh=n0JcJnj8KobGRR4BWInGR4lINDczrOtp5SW+JU7eSfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=od1BWRYO1c+yin5BceWExANayjwrQ+4Q2zdQn61qD2f6ONwIQQACNufceht8f4RcsHxQzvy/bIr50TZpPYQbZgNQtFXnEqYGYKs6kEXsfE+KOjsvlyH3RMisvllqfpJIuzPmkLPDBzvOIYOcnSaXa81iQl+wU12HpWVr/mdxl+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k+7ZMBxn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k+7ZMBxn"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Lloaf2675800;
	Fri, 7 Aug 2026 22:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HZY8J13fS5qVVpe4Z
	zyJlk0nrVMJa4Lj9ClkB8FKfmI=; b=k+7ZMBxneMwBFdiIDTYLZZbecP1Jrkopf
	5lj7qrVRsqDCO5VL5JAznR8oMxEcfH/pDErmuOJ892fDtmIlzMDT3OdtZwG9MX8A
	sCBYKhlpCM9ansNUOV0FnrjnM2r0ORfDlSDcl26GURWnItrXeAIhSCL7WswSIqPX
	UPiacfRRR5XqqvE9COku9BzELJCtkqTXuMXxEXrZYF+SKYsBScsTI/AlnggI6Git
	fvfgCF0qVwUn04p2hVfKnDxv6ev5DfaUqBf4aqJAlVviv1uQC+2XWkYlk4m4XniE
	L5Uq1aBCe2N/qOydx+bPQ2g8y++W7yGhkve452OPymW9gRgr0YwIg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyx8n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677MBL3X019966;
	Fri, 7 Aug 2026 22:18:51 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswu01euh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:51 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677MInKZ32965226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 22:18:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C3D658059;
	Fri,  7 Aug 2026 22:18:49 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C1BB58062;
	Fri,  7 Aug 2026 22:18:48 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.52.19])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 22:18:48 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v7 12/15] s390/vfio-ap: Transition device migration state from STOP to RUNNING and vice versa
Date: Fri,  7 Aug 2026 18:18:31 -0400
Message-ID: <20260807221834.562851-13-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a7659cc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=YI3AHy_hWZklpQ5N57sA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfXzU3E0B7AkN/6
 05v8iQaOMoTl1qEvdE8YZBt2oKv03/Wrbh6vO7DcAb2sOhcETrqNr72tHggH3UkjGYSBOduFMHW
 hrk6m2oN4Z/DaSBz0wORE2mSztKbNaE=
X-Proofpoint-ORIG-GUID: Y02zM7qYes1KY_RCFkUQwVEcoeV4Kb8Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX2HI/YBKSqapY
 Sl5PKaHVCnz+oyj7+VqV8hKg2e7kECTu5cFHLtn6/pzNaIvYDuKRgU6ruq/rlAGtSbEjyerwIU8
 s9pNmL2kQ+R1JnF+MnmgF9mWKiiHpQyyBRy4DATbmRY8+R43BPFrC/1FPZwtPitF9P3nYvxP5u7
 usR5ovSfp6v26JRr575SExw9Z9u8vDpwRE6yhMHxPFN02C8XalBX5X4BkDigHSf7Jwz2xNEwYRh
 h1noQ1DjOXcgbF7kT9TJOTnRbmn79M+Cd18TUaleuItfb8x3Z5+qKweEnLdxiq65zr7Fiaxv3Yh
 LvVB8iaK3hVjLkAEqsEL2mIFWoiZ6LU2KKTeoFu8ljeVbiCJ+vLYwwbrVlRqIRxLVu9V52bMf3G
 3NWG5oQZn7A/fP9g4mJ3lr5TY1A6ciKaFCpDlQCBYu2vp4fuOCiAO3H6O9LstZcbNWdNpbQ0Uk1
 dxtyihANWLr/2zLHWtQ==
X-Proofpoint-GUID: Y02zM7qYes1KY_RCFkUQwVEcoeV4Kb8Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070175

The transition from STOP to RUNNING and vice versa indicates that
the vfio device is operating normally and migration is not
currently taking place. In this case, just set the new state.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 30160e3ddded..24955f70e13e 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1524,12 +1524,17 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 		return NULL;
 	}
 
+	/*
+	 * These states indicate migration has either not been initiated or
+	 * has completed and the vfio-ap device is operating normally. Since the
+	 * vfio-ap device does not virtualize a DMA device, there is no internal
+	 * device state to incorporate into the vfio-ap device on the target.
+	 */
 	if ((cur_state == VFIO_DEVICE_STATE_STOP &&
 	     new_state == VFIO_DEVICE_STATE_RUNNING) ||
 	    (cur_state == VFIO_DEVICE_STATE_RUNNING &&
 	     new_state == VFIO_DEVICE_STATE_STOP)) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+		return NULL;
 	}
 
 	/* vfio_mig_get_next_state() does not use arcs other than the above */
-- 
2.53.0


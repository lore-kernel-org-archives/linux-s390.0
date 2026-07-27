Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CD6432BFA;
	Mon, 27 Jul 2026 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173592; cv=none; b=ZKgUdHWeerMgeDtLiYwZVyMGXLnjt82l6gSxL16d+iIByku8QGr+23ti0omRcxTmp+ImF30QItlSbDEoBR6Lt3eUpB6OzappeFyQ/igB8+adVrpANz6IMEOIzYtgmtLfloeEcSewW09+eCXsuOm9oUlMfn/nXkWf5Rjph2td9UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173592; c=relaxed/simple;
	bh=uqIAh2v/UsRbOv3T8wZHU9mSVWs0VqZo5N41YeqL7qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOjgrjRWOr+mvNyn0zx9m99BjbfnYEoO2tiVQ38qTHE1IZkOyq1jlRIx8fky7nSiB49C1WK+8eP2ju3WGcpQKQ1lzEWQFmx+0baSNKsz3i6ylBHkKUI8m6QONlAGUgOjQo0K9hewdx0eprLH1xgCrBHw/PEO9j8a41hDDeeEQvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iJZUemgP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iJZUemgP"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDnaro2298861;
	Mon, 27 Jul 2026 17:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9OyT/dvgk4pMqET0a
	rdh4b4v/DpcUEgt7LCcfYhoTOQ=; b=iJZUemgPFQ/9JC32vAC9NhVU/qUNuK5Wr
	5M/gEP2GgFS/shPQIqTQ1fJl2emih6ehh7+LzCTzmhFf0ybXfyKj7HoeymP2FFQV
	0FM3R541kJzjaakqRLIKj/G4mTFGCfAzfBLmUIXp7vkNGwPtLxY4VAJxD1FcYDez
	1KRo9sgp77ESFjs57MWuRF7AibE3QFqGhULWHybYysRxO35tgdWQR+lGL1AyBTR9
	mUCTQ8Cgryln1XUT/otGkKjIbQ0gDD5m/ytecyVAQw3STLu00IEvtBKUGysuWynr
	G3dg3Zwh67iXKQOgRofB0WnzIxIzpeyXscRVRimrib2fxMlMQDVQg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj0uec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:33:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RHQFLE013222;
	Mon, 27 Jul 2026 17:33:05 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjxbxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:33:05 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RHX4XI32178478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 17:33:04 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EEDE5805B;
	Mon, 27 Jul 2026 17:33:04 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C44D158059;
	Mon, 27 Jul 2026 17:33:02 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.213])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 17:33:02 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v6 12/15] s390/vfio-ap: Transition device migration state from STOP to RUNNING and vice versa
Date: Mon, 27 Jul 2026 13:32:36 -0400
Message-ID: <20260727173239.2420754-13-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX62SydEL4DKhh
 9fa4yT5afKbriYPl5S0VcKUM6vDe7ZvCZPV53yfZ5jsFI95zXRidphwzsnYwROYNb8rkQFh6KUe
 Xr7xMWXT50vOHi07bPcOPBt4EvQQzhE=
X-Proofpoint-GUID: BSukHtlEfl026mV8YBkkb7nujk4nNa6X
X-Proofpoint-ORIG-GUID: BSukHtlEfl026mV8YBkkb7nujk4nNa6X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfXxpdVvZwK6dCa
 M340CXSHUHxgR/xWTwyqBL/+onE3w/Ym0KDW/cqvdaPD1dDkAuScXKDevZKSUnLYZlUK385kpa5
 77r6TCaoSrobp1o7eLmrbkcH0HnX1RqVWlWCtYvABIZ8BMqBamprbjRXLW1FOGCZHCmT0te+yHf
 K1CVbEAOebplpChlrqECMghDQap3COIqIEy7vziDWWc+Eol6Kr+r1Bt3PTDJey4JAJxLRQlcFQK
 eoF7YO5FpOLfZEhnkA9w6sCeJ5WzC9dwDc8eLnmbeKJHGMoGRbwvdJTVQUtf7DErashkM1fkh0p
 25Y7AnIvSK8DLxxhoe4BaCp96vfjo10v3aRf0ER6Pe8Br0LF1xlo2JD6guabgaGVFh9Mr3ZMMan
 Si9MU/Oayx0XXXvODh2Cb96QYew6sCFYqx0C0NyiiX44ZXGgIxmZqwh0AHtYS9DybOMCoDLTI8a
 SeVX343GWDCfsc5Ea3A==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a679652 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=YI3AHy_hWZklpQ5N57sA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270160

The transition from STOP to RUNNING and vice versa indicates that
the vfio device is operating normally and migration is not
currently taking place. In this case, just set the new state.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index fc4cb893f0f0..1c385908fc39 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1280,12 +1280,17 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
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


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB0342DA5A;
	Mon, 10 Aug 2026 19:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389796; cv=none; b=I2EPyG68js3AeQS/AcpcnxItm+dV/fYbNt49J5jlOtuTNDejB8vd+ueImlh1HiWsNm/ZxgrIrgltTHycciZbZPBCPB3xC3XoDeaZAznktmVFBo78dQguRvO2Mc7NdYAqlaQh9AhuEwGXtv9d9TbQKmVD78yppnHExi0mwG8QLvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389796; c=relaxed/simple;
	bh=4tidI23Pm+dYwkNbLIXMMsazONFi/qGjVCp+vtRgBAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJtLDPXH0gCEXbadmBrJheGUlrUOsLeEbfY360CDOec8ES6u70Qcn5/vf0gSFvvzeUpxTGbcxsyJFMA29xZFroHunF9FLK+Roao+qL5uGG3PLseHBTi7VTgfD9OrvhWTwmXDemHQKWMpXmc51IVerWgTOjBn8c4ldekc9POPj3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E1ARI9DF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E1ARI9DF"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AJ2mFG1382850;
	Mon, 10 Aug 2026 19:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qbE/FfN+6bKSEEHXg
	zeGEhHoSj357bjJBkyHRtmLeYs=; b=E1ARI9DFmobY8Q9u72AZ/ANKl36PmW7Xs
	0cb7qBmjC92Rw5TihQRLURv5YNm0oK5UlaEWeRLq8sKrGMdGxI9R8ug9cjrRP/SB
	E+2NCqPwbiowislUtX5SRxozMfRkJmNAG3tYUA7/De6ZOTZqX5abbriW+o8enVXG
	PcuzZeDcNRUfKJpmTit5aJHzTjxw4cDoMt4QS1epfrRPIdFAjmIUGm5TuHZBfqLa
	G7YkC3foiEflvg3ZDtUsJePXz01kUqCbBlnoUe1q7F0T5xxN4ONPDifnndN9ASpV
	X4W20nEAA8YTlLlM1hUbWQJQ7jkKTIEOr6qxI4sEGXUNmIq32zRIg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23jm3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:23:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AJBci5017862;
	Mon, 10 Aug 2026 19:23:04 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g602f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:23:04 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AJN2xY35979940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 19:23:02 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79A2858058;
	Mon, 10 Aug 2026 19:23:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D22058057;
	Mon, 10 Aug 2026 19:23:01 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.71.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 19:23:01 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v2 3/8] s390/vfio-ap: Fix use of wrong lock in mdev probe function
Date: Mon, 10 Aug 2026 15:22:52 -0400
Message-ID: <20260810192257.1208410-4-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7a2519 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=IOhVIQ1U7ISs0PSOFQMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfX89VIYVWL6k9u
 U4DufLH/EYFhprFk1zg06J1Bc13taCG6RnQOI1hVrRjLssZEtqM3z/hNrgrC4c39TbmbiE1r1k/
 Gl9fvTq981jIOW6T/twOEMaN8feDYHERgcdlqA3FcxEQx1DXcUQQvsF0bLwRcsWd7p8Yo0AmhN2
 qLzND5TjP0Z4704yugfN2ma+63AgkcTof34QPXYircqLSnmlEJPKgwci86cGYKsff/ICLxzN6UN
 KcMdCvpTFCUgx5dEBq+5c5bAjJx+aujkKYYszUZSb1aht2u4po5OqNFfbFiq5rk9R+sP1ge3oux
 3KgzVb+S5SdeONPydPs8ycU+c16RSjBTgkv162n3sR8eqWQpC8L0TNKqL7Y6FVZEaM+4vNRKxlf
 AiTLkGONa1tC2GFp/Wlnf4DQMURVSuUgpT0mJj8e5kk/raAgYmsQnQ35BmVP2EeV35u7FqvhzCS
 LpWn18oHCUbMaxXYClA==
X-Proofpoint-ORIG-GUID: 8Cjv-eEuMRiZBTtPUt0UdhH5qf1Q58sW
X-Proofpoint-GUID: 8Cjv-eEuMRiZBTtPUt0UdhH5qf1Q58sW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfXxrjaF6RO2CXX
 1nhqE7GENfl7lmqNP08zDJCOas2lLxaMu2BWicH9wQypudW/e3rjr2hoNFH9wOxGnBYsBldFhlY
 O1ozCmcdpxyCjEpKFJu2U4YLzzmCAU4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100162

The vfio_ap_mdev_probe function uses the matrix_dev->mdevs_lock
mutex to guard the add of a newly created ap_matrix_mdev object to the
matrix_dev->mdev_list. This mutex does not protect against traversal
of the list; its purpose is to guard against concurrent access to fields
contained in an ap_matrix_mdev object. This could lead to kernel memory
corruption or use-after-free if another mdev is created concurrently.

The adding of an ap_matrix_mdev object to matrix_dev->mdev_list
is now guarded by the matrix_dev->guests_lock which is the correct
way to protect against concurrent mdev_list access.

See the vfio-ap-locking.rst in the linux kernel tree.

Fixes: 2c1ee8983aa3 ("s390/vfio-ap: prepare for dynamic update of guest's APCB on queue probe/remove")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index e382e5a1cb99..a472de00bc14 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -803,9 +803,9 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
 	matrix_mdev->req_trigger = NULL;
 	matrix_mdev->cfg_chg_trigger = NULL;
 	dev_set_drvdata(&mdev->dev, matrix_mdev);
-	mutex_lock(&matrix_dev->mdevs_lock);
+	mutex_lock(&matrix_dev->guests_lock);
 	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
-	mutex_unlock(&matrix_dev->mdevs_lock);
+	mutex_unlock(&matrix_dev->guests_lock);
 	return 0;
 
 err_put_vdev:
-- 
2.53.0


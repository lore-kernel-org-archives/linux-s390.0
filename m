Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1961C3815EB;
	Tue,  7 Apr 2026 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595093; cv=none; b=BuSByjvQh6fAfPxWigqC2jqEHOrbk6ZUD1rr1/N8LekH66QZtQFGN4lQcnN9ZrP2K5efV9zklWLUAaj28PevCLRAOlQRv2C99EV5TSZkcJosO6k8ggXhkoQwMtf3JYco3/ErMSX9gGEc5voIuDygEJ1aO1m/GW/8hvE1SWDJXCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595093; c=relaxed/simple;
	bh=QK3y5CZfJRSeMbfhIBj1q65WJT3E2j525TeHYA7gdd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1W07Kt2Zq7e+UKhJBy63IBNPBJiuE5a26DEI5Skv2CPbGAcGauQpKk2nZ5vVAa8rL2QgqDT6jzmnGveWL6nc1MFSqR0kIUX07CL56Q1gWerJtMNgfAHVHaFtijoooguCrnXLO807ovkb5eRxm9JdynE4D9FwfmTEOuiPYC0CEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ky5LuYcR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ky5LuYcR"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637DHgD32325933;
	Tue, 7 Apr 2026 20:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CiJZ51h+O36LQq1m2
	BvVcfa34/GqFSmWtdbC1zdy0/s=; b=ky5LuYcRGMOX1Ly3MpUf5SWaDyguR8Sgh
	ulP4HYCf8fQ8SVSa/ThxyVnwOXTVKyHlIoZ5Nnmsm6IW/xMBr/F08L5u6hzEYB0T
	KWMWV7L+rFz6lYo1k3uxPrWzeyttYFmPFHYa9AX3exFLmqzThCA/3BAGerG63oO6
	z3IcCytbhyDqSpaXr0oLi6TqYCylD06VFwzFkEbNHYHFCqmIBjEXlKPdQGcUU5ia
	LU/BLXohFr9bVf4x05u1IgGk8mngZfil6KRurDiR++dyUvSCrmLXoto44MG/K7+a
	DrZLiGc5NnB8bE0U10WrytS1HLcHrmjNz9EwETf3WR3ivzy7g4++Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kcntu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637IjPiI007942;
	Tue, 7 Apr 2026 20:51:25 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2cu0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:25 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637KpNJS25756190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 20:51:24 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D32DB58059;
	Tue,  7 Apr 2026 20:51:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5286958058;
	Tue,  7 Apr 2026 20:51:22 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.101.194])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 20:51:22 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v2 12/16] s390/vfio-ap: Transition device migration state from STOP to RUNNING and vice versa
Date: Tue,  7 Apr 2026 16:50:28 -0400
Message-ID: <20260407205100.331150-13-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407205100.331150-1-akrowiak@linux.ibm.com>
References: <20260407205100.331150-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4OSBTYWx0ZWRfX52NEoQA5QpAE
 crT6pI94Qiq6MPeneBVdhE1KCRFKy1wJQ8QCa8UgkN2D52YcT7RP4TKXgEiIHGOB3SFDEae9HTV
 u7PfGfn1CUCx0LHO2YBYv9tZdOC0cS8SBDIrU2N5l1B0iXcm3GMockMN4HTJGzViDVC7KJTdU57
 kE4ZnGS6RBsDWbeiqQsxeShfEGcrGgtsU2KRi7I6i4D7q3/CrVSNvKuP9UgfPrNAtHoxwTCiRQl
 EXBR6r3yk9DJitsIwSUtlqFpm8Gd7O7/N804dH2EfPPvex9M9VVYm82CNQEpwK6kHVtbAPLYzu4
 l05bS4QhAgLevzvFxIDw4D9Fe6ijRK2W0pQd10I40Y8lHq9QyPEaapO49vrSSwivHAoOzReZNWs
 TgFbLDNXN2oNTCF7nBMsB3sh+YjSgLFDQtjEyqFgT2qza7X14WOl8bNyHKh4MZrn24md7SedQEy
 bHF9PJkBOMSCuWpGezQ==
X-Proofpoint-ORIG-GUID: fOiEl1_wYOs1weP1KcIukifmx8MImtZZ
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d56e4e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=YI3AHy_hWZklpQ5N57sA:9
X-Proofpoint-GUID: fOiEl1_wYOs1weP1KcIukifmx8MImtZZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070189

The transition from STOP to RUNNING and vice versa indicates that
the vfio device is operating normally and migration is not
currently taking place. In this case, just set the new state and
if there are any migrations files used to help facilitate migration
hanging around, release them.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 6074ccfb9240..28209d8476d9 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -945,12 +945,18 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 		return NULL;
 	}
 
+	/*
+	 * These states indicates migration has either not been initiated or
+	 * has completed and the vfio-ap device is operating normally; so
+	 * just set the new migration state. Just in case, release the
+	 * migration files used to facilitate migration if any are hanging
+	 * around.
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
2.52.0


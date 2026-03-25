Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DE6350D58;
	Wed, 25 Mar 2026 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472539; cv=none; b=rLu6u0HZBUx5dN2odmgRfawLGQ7eqYp5YkJCYH49Eru1HTOYRfeQC3JXHbSx6zom1rrrvQ4b4RasyrWqw1jqQc83Xjie8+L3XugNDBGh/bZrB91WvZSBzM6CAId2xA4z8bomciS6R2HTRISd7TPPvAborbGI5fhNpuVifVo+wgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472539; c=relaxed/simple;
	bh=W27qIR0QTvdMKsjZ5Xi7w4X4egVpwD9N1UyS+yPpRvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGgFNrvMQuMl1Zp2CaHuB/vLxj/+n3dSA0hQHukhrReEfz0UchvdIqSRVyZB8mdqPEMG6VTVVjwmp0jQ3Z9LPefEfHwCisvdJ+/jSfV3mXkUR1BygrxvWpxzxeVVpKndJcMzeY7rZRgdLnA7dwla0GaMx+PWcV7s3YC7cy+R0Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cbxxLs+q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cbxxLs+q"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PHPR4j2886998;
	Wed, 25 Mar 2026 21:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=W1g6VWskXyE5TIscU
	M0SF1SwGst1kHyO5V+AZxyi1EU=; b=cbxxLs+qTfs6j2iXn9f+DIfZ8+SasuYNb
	HbRDyR8kAMDtCu0O4WPCMiIB/t98FnP7ATI/O5iLAq6FWGAzSbSFljlQJuFDFjLs
	pVB01Y52SrjirNsj248qJWIpZMcW9lGBBo37IeC61p2QI4Iku+UNp4XIBJXXOhYP
	V0g8A6WUc2CLcPJtXbIgz/irOZBS+8LeTFLanDwNX53sC1b27OOHW9FPU97Ib+TV
	m9ucvm/m/g0DR/DsmnqpuSBiMrAyOycfgpIxGosyUIh8ZW8CYyKBWxxD8SjBTdkY
	DUN0c1hfDrqe5PVjx8YXMDqKEFmf8pmZFreaX5sBq1COh74qBPcIA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumsjs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PGkfdU011789;
	Wed, 25 Mar 2026 21:02:11 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk817j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:11 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL2AAJ25494128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:02:10 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 515D558052;
	Wed, 25 Mar 2026 21:02:10 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59DE25805D;
	Wed, 25 Mar 2026 21:02:09 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:02:09 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 17/24] s390/vfio-ap: Transition device migration state from RESUMING to STOP
Date: Wed, 25 Mar 2026 17:01:04 -0400
Message-ID: <20260325210149.888028-18-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260325210149.888028-1-akrowiak@linux.ibm.com>
References: <20260325210149.888028-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IVdK_6QGBRdEg7npmw_6ENsjU76tKrhE
X-Proofpoint-ORIG-GUID: IVdK_6QGBRdEg7npmw_6ENsjU76tKrhE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfX6cAybXtBD1Ns
 dZGKT0c7S/hPTP+dEoBtqMkPj97FHgKV4CeM2FkrThO5/km9Wpn7g5lENpCYM4Ah3Whr4ZFnoQ2
 PdPVueSRr3C/z4FEUvQUrrMK3z6pxwMPGETbB3S3vx7xZLfgHbH0riKtxhCVLQODR0iIkSbkJRh
 KYSKwXaac5qMYwv+zm8F5lx7b5iMVfoSzr2Y94l7U19cg1wuqY8kKwUmz+MXTNKjS4BpqmdySkt
 oM09/oBs51ZYNJKf9ArXSBSKaEu7ATxfuF3q6g1fTr+yDGgIX3jO6JBAIXQPBJDtox8HMkTcq9p
 AcUUF3t9p5XNBLjEtm4zCQiOlMnkJvxicUA3MY7snxGjBRkrMD29DLH/M61Dl27OTxp+RNkmDrz
 3L2h3H9VSA7E7IlzkHaWEMG54wmotED1HF7+tQlLnJLbnJG2TDiFdVxxsa/zkQHv/Ch2SIbJH14
 8bkjsd/wRag7FkORuhw==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c44d54 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=15JG798O9DgAUossVzIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149

Leaving the RESUMING state terminates a data transfer of the internal
state of the vfio-ap device on the source host to the vfio-ap device on the
target host. This state transition indicates the vfio_ap driver should
complete the incorporation of data written to the data transfer FD into the
into the vfio-ap device. Since a vfio-ap device does not virtualize a
physical device, there is no internal device state to
incorporate; so, the only thing left to do is release the migration files
used to help facilitate the migration process.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index d9b6dba53181..71cae26eab96 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -921,10 +921,20 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 		return migf->filp;
 	}
 
+	/*
+	 * Terminates the data transfer session of the vfio-ap device state
+	 * between the source and target hosts. Since the vfio-ap device does
+	 * not virtualize a DMA device, there is no internal device state to
+	 * incorporate into the vfio-ap device on the target; so, the only
+	 * thing left to do is release the migration files used to process
+	 * the vfio device migration. Note that this state transition is for
+	 * the vfio-ap device on the target host.
+	 */
 	if (cur_state == VFIO_DEVICE_STATE_RESUMING &&
 	    new_state == VFIO_DEVICE_STATE_STOP) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+		vfio_ap_release_mig_files(matrix_mdev);
+
+		return NULL;
 	}
 
 	if (cur_state == VFIO_DEVICE_STATE_STOP_COPY &&
-- 
2.52.0


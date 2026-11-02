Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632586;
	b=FM7gsDh8qKXQGjL+l/Z6spVIOG6W6j/RCEdznJgH52jn4w9fSfuBXxOL+8hVi9lVtmpA
	 zSuu4yZC0TvWJsSbF1Fj6miGsvnH5bpJYtDaSlQC3M3x4OTp268//aKwk7puoKXqx48Al
	 DFUZWHzjOuk9pRvukl4WAN+P59+KEWGbEHQ4gUgkubX6YQiWNO67bo5I61YGp62UGtkhc
	 8vdb1IK7ziZMt9xPeze9TWH8HevCBd5y6yie2s5VgVpKJHZFVfyIMlIaXOF7ZtXbiIGWW
	 JnfJs7+0lRnhXlLkJWk5bNS4jVOOBaYuM3zA3p8gsW2DjyhGQQzShzMyfwPeFod7QLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632586;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wl+w3T1dNpLqvwydP+IGzkUAgwXc6TBP+broarI0kzQ=;
	b=XcvZpxAtCuKvsqtUXSdz64fXhobNjRg6upF6xgra0ye7CnEoaxGUuUHEqfS3GdwsRHs+
	 iOIrZ/bLKlUAQW2zZBvBVNyXdThQiP5R976LwD+QPSKbRZiOdH7g7bhOGbzsLolKkdYZs
	 7FyunoYgeMgjcAle3/vMXtY9eFjMKnshc5SvPsEu2eUCXc01oh3F8LfDSH4AqlqRxqGFl
	 AuAz7gh+Gz99CYYFM343M3JLPDreaG0mde0Ax96Uv282CrF2N5Ie78Y5w1C5zpEdLPlJY
	 tY4hsCD97WGZUlG3/L6+wHGzMKDd/cWULa+FV3eQx0iI4/LfnsgXMdzxEPXGiKFNy+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NHAPNhuU;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BEC606E035;
	Mon,  2 Nov 2026 15:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80BEC606E035
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NHAPNhuU
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2EEMER1950005;
	Mon, 2 Nov 2026 15:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wl+w3T1dNpLqvwydP
	+IGzkUAgwXc6TBP+broarI0kzQ=; b=NHAPNhuUBLRXkGlfnoQ1Bx7I0jEmnewK2
	3+4L7rDerY5tAhwT//mourXB+bZmcvY/UKex0t8P3RBdEwoaj8kk3E6lxXyE2dJB
	aXBHEvkkQfi7G8Df+0totCVFiStCDPZKMigeaQU0G/b2rnwU1T8b7P6njchRR3xr
	ms4laLyrrQKq5ieKpo7k34kUPOqju4Dt00kNIXDCYzstRIGuMJXnRTqCU8QYlvE5
	Iln2RwxNR/6JcBikJu5/UMYwzAK8Zg0lPabkTCwm4hAku0ePbffK3pdJbd3Pwue0
	fu2KSbmzoN27scQCUiX1d/mDWbseI1+E2+NDSblw+MNEkTjvYuAqQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rd19f9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2Dp73p1068913;
	Mon, 2 Nov 2026 15:16:21 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnv5gpd2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:21 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2FFVdB25625128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 15:15:31 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D8825805C;
	Mon,  2 Nov 2026 15:16:20 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 383985805A;
	Mon,  2 Nov 2026 15:16:19 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.57.150])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 15:16:19 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, freude@linux.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com
Subject: [PATCH v11 10/14] s390/vfio-ap: Transition device migration state to from/to STOP
Date: Mon,  2 Nov 2026 10:14:50 -0500
Message-ID: <20261102151604.2150055-11-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
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
X-Proofpoint-GUID: k45-Go2vlL5l90Ipd-n0KpOixnZLPW0O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfXwLhJ1Sx19lTH
 w+MZMsgj4IRipuLzq5Vdw+IzH/FXOxf9iRaz/rYyzBOZ8kaYbtFLNVH+nZjeLgeRf2CnEen4iWb
 NPHzTbqCpzMAlPvvfiN0jWTdLFe7csXbBdxdtCesSfDaS1pM9Z8FOyutlcPgPgxG4NnV5ogqC76
 NNUCcqxQQG3fJXQcBr2TtriLQ10EMq3LE9yEAMnlff15QczxByK/QyLII05i+IMKCzWViPjBqh1
 55qucaGoyqU4EzpC/ztaUbvAkO6Ec2EjF6oimIF0Qf13eQn5YxpSrPZ0hx7TWNrp1NXRzvlUzC6
 WjlyYY7TlJdKtzVDWWSpR5yXeV/tM1ro48csq8V843pco5GR9h3z+PHQMEShtOPuj8H++ZXoO2l
 5FyDZnwObko8Vce8hX7GFbYtnS73hASgfNn7grKAYkoVq8RL+B5urM10wDaPh9BQr3R8A/kLHwi
 4vJXZDmwlKxxbCgUqGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfXxxoU31Wxm7gZ
 nk3BG7OxSFIu7KfMEXJ9qB9bNcseuYQ8B0nt8m3FLVWOCBIwtvf757VhpNzVP+eS8an7M4ZZS5M
 2JzrPGsA2NcUaGurriReWGdENGSPXBc=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6ae8a946 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=rYYDvlbp4GlxMHAgTQkA:9
X-Proofpoint-ORIG-GUID: k45-Go2vlL5l90Ipd-n0KpOixnZLPW0O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020060

VFIO_DEVICE_STATE_RESUMING to VFIO_DEVICE_STATE_STOP
VFIO_DEVICE_STATE_STOP_COPY to VFIO_DEVICE_STATE_STOP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Terminates the data transfer session of the vfio-ap device state
between the source and target hosts. Release the migration file
state (ap_config buffers and file pointers) so that a subsequent
migration captures a fresh AP configuration rather than serving
stale data. Since the vfio-ap device does not virtualize a DMA
device, there is no internal device state to incorporate into the
vfio-ap device on the target, so return NULL since no file stream
is needed in the STOP state.

VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_RUNNING
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Migration has been cancelled. Release the migration file state so
that a subsequent migration captures a fresh AP configuration
rather than serving stale data.

VFIO_DEVICE_STATE_RUNNING to VFIO_DEVICE_STATE_STOP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Migration has not yet been initiated. No migration file state
exists to release, so just return NULL.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 52 +++++++++++++++++++------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 47f05e43b9e0..c5534c6ee3ce 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -200,6 +200,8 @@ static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_dat
 	mig_data->resuming_mig_data_complete = false;
 }
 
+static void vfio_ap_release_mig_files(struct ap_matrix_mdev *matrix_mdev);
+
 static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
 {
 	struct vfio_ap_migration_file *mig_file = filp->private_data;
@@ -1170,20 +1172,46 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 		return filp;
 	}
 
-	if ((cur_state == VFIO_DEVICE_STATE_RESUMING &&
-	     new_state == VFIO_DEVICE_STATE_STOP) ||
-	    (cur_state == VFIO_DEVICE_STATE_STOP_COPY &&
-	     new_state == VFIO_DEVICE_STATE_STOP)) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+	/*
+	 * Terminates the data transfer session of the vfio-ap device state
+	 * to the destination guest.
+	 */
+	if (cur_state == VFIO_DEVICE_STATE_RESUMING &&
+	    new_state == VFIO_DEVICE_STATE_STOP) {
+		if (!mig_data->resuming_mig_data_complete)
+			return ERR_PTR(-EINVAL);
+
+		/* Set resuming_mig_data_complete to false for clean reuse */
+		matrix_mdev->mig_data->resuming_mig_data_complete = false;
+		vfio_ap_release_resuming_file(matrix_mdev->mig_data);
+		return NULL;
+	}
+
+	/*
+	 * Terminates the transfer session of the vfio-ap device state from
+	 * the source guest.
+	 */
+	if (cur_state == VFIO_DEVICE_STATE_STOP_COPY &&
+	    new_state == VFIO_DEVICE_STATE_STOP) {
+		vfio_ap_release_stop_copy_file(matrix_mdev->mig_data);
+		return NULL;
+	}
+
+	/*
+	 * These states indicate migration has either not been initiated or
+	 * has completed and the vfio-ap device is operating normally. Since the
+	 * vfio-ap device does not virtualize a DMA device, there is no internal
+	 * device state to incorporate into the vfio-ap device on the target.
+	 */
+	if (cur_state == VFIO_DEVICE_STATE_STOP &&
+	    new_state == VFIO_DEVICE_STATE_RUNNING) {
+		vfio_ap_release_mig_files(matrix_mdev);
+		return NULL;
 	}
 
-	if ((cur_state == VFIO_DEVICE_STATE_STOP &&
-	     new_state == VFIO_DEVICE_STATE_RUNNING) ||
-	    (cur_state == VFIO_DEVICE_STATE_RUNNING &&
-	     new_state == VFIO_DEVICE_STATE_STOP)) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+	if (cur_state == VFIO_DEVICE_STATE_RUNNING &&
+	    new_state == VFIO_DEVICE_STATE_STOP) {
+		return NULL;
 	}
 
 	/* vfio_mig_get_next_state() does not use arcs other than the above */
-- 
2.53.0


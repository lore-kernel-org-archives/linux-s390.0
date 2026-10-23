Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777461;
	b=pAqn5/b0jaDgHCQNyvJaINHMmzWtb4kdg8gkosuM2yVUMVwYjVJtz0BHFbiiPBwiMiaC
	 7vzCUZjLNS/jON/pMker/zTBlsD7q7rcW/GwArhWbClyOe4ZXLUg9Amoh6Vuylrvn6faO
	 y2FyP3ANJwFyBmGhCMyqIydgM7EFS9Y0raAYXXV1aQJmqgRw5/mXcrkpHRnGdEPI5PF3Y
	 BillovhhfGGVUsI2ekEpBozFTsPDwWfoXZyldR29b79pl7y0CAV5N1fXQTIFLsM69l6yT
	 eCdQrv5BIF+XDUGN1gz20/gLYd8IK4I3Rl9koi0tkEZ0gCwGQ4q+aV0NeUDATlbjiUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777461;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mCPykHN5RmF5LB6YpSi9EXZn8mtOr5Eot9avRpQtjZ4=;
	b=cH8TyPfU7y3ady0aZiCVsjn88lk2ZZZj3PPgcRym/jukebwrAM4ChkHH884o7k+aLKEX
	 6J5YJZfQauwsiaW+LtgK/CtOwNRC8S5AIMJRHoWA4jcy6brYVj5AvWKbGk2IJzYJtGLh7
	 kLkYCUpPK8a1lY85LdpjI5bgIvSHhMyhDZzmwCehnzrApqwbZ2RYgMku1IqR28nDRZtpW
	 ELjnSTI4Q1V5Xq909ce/spQANZ4bs4w/Rp6bZvdqoyaQbTlKMKTOMkBB58IdVduAYO1cv
	 ajhVdWL+SPOJN/W/WIDoxwRxeEDb/Q+iv7eeIvuusPy6n4nZxopMzr9OafuewRtjiWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DAlAew2t;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF9A60A262C;
	Fri, 23 Oct 2026 17:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABF9A60A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DAlAew2t
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NGoTNg3561697;
	Fri, 23 Oct 2026 17:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mCPykHN5RmF5LB6Yp
	Si9EXZn8mtOr5Eot9avRpQtjZ4=; b=DAlAew2tWzz05mH4wAN2QmLQq9Fa5uofs
	YGlmAsvLJ8hW57aame5R+lVsRaLRWPnZjCey6eOxsL8/CZ3T9TflNQJ+lL7jsY1f
	qrt7LZymXRJAgyRJzyjS/CxevtER4HwtNUKNp+a0pTG4DrfTZ/iwRgKfrjqkynat
	En4opxFVxu7xfZ32TWcssJtRr+SVJl4MqILurwH6IHrKNAPyK1qKlmbevILoKS8N
	zN7Gd3LmdJtfZMkdx2XAeFdORjAI03jF/tTLZdIAiqGeD4ntdV/wuMsgkm19e3oJ
	BJHNkx6grLUi1BxZOZSUTWDKSa9JK/pElqoNY9xqqpZUTsLOEDXHA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5adxa3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:44:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE64kP2220904;
	Fri, 23 Oct 2026 17:44:12 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfj1x6a37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:44:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NHiB3I32047800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 17:44:11 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 768B15805C;
	Fri, 23 Oct 2026 17:44:11 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D978758054;
	Fri, 23 Oct 2026 17:44:09 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.48.60])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 17:44:09 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v10 11/15] s390/vfio-ap: Transition device migration state to from/to STOP
Date: Fri, 23 Oct 2026 13:43:45 -0400
Message-ID: <20261023174349.3545941-12-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX73P94dMhUveD
 A9oqYB3XoZr7G9WxyHImyVf8Jda+gErP4jK5rtKmaKDNDnyox6H6tfr2d5xXhiUY23fa03iBdId
 KaX1hLKvGvBfAxS5Dx2mkOYFXsiK9hULa2g+k2nAQmGGCuBH9xB4U4j9OorJ9dudiGxrIez8TFj
 xDD9aA6kU6u0T7mru5fvtcTp6YjW86+TLKJrT8u5BQfvEjD/SfN02RnRhrH+jj6ilVnhfQKBhYZ
 v3I230n1QF885tzodvXU3qxe2jL6+CWco4gL8hvsdDwg+NuhPFoyFTI6RGd1EDXXEtA5hHC5qNz
 XRFkUHUAZlvWLPH55CDzuyK+0mqpyEKqFvb0WtOXQzKufKzuZdf3+iynasugNxQ/PyXEnqSVnJL
 2VLd7HD97gzxlXltQwhz3F1kkqJXNOS4adOsAK3gSbbX0Ma9MpUVt6MxMfJIBMX1GHM3Wpw3l/q
 1J+nusfAMRig84KVgZA==
X-Proofpoint-ORIG-GUID: USlm0F5Hsj_GGeppDs9Scqf_8QJVcZK5
X-Proofpoint-GUID: USlm0F5Hsj_GGeppDs9Scqf_8QJVcZK5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX330N8Oju/tvL
 +3GDbmVxGvw01rizo3BSPrCMkvM5zlaGC+AcgZGMb29QfEfb3Eqqp+jRT1KvoHWtv4twRqKBCuY
 30in3/JLONVZqSakngAxx4IADzcYmc0=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6adb9ced cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=HiIg-hG13j_GiFxz3uYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230069

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
 drivers/s390/crypto/vfio_ap_migration.c | 66 ++++++++++++++++---------
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 469fa09ec908..cf38407d1b15 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -196,6 +196,8 @@ static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_dat
 	mig_data->resuming_mig_data_complete = false;
 }
 
+static void vfio_ap_release_mig_files(struct ap_matrix_mdev *matrix_mdev);
+
 static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
 {
 	struct ap_matrix_mdev *matrix_mdev = filp->private_data;
@@ -939,6 +941,9 @@ static int do_post_copy_validation(struct ap_matrix_mdev *matrix_mdev,
 {
 	const char *mdev_name = dev_name(matrix_mdev->vdev.dev);
 
+	lockdep_assert_held(&ap_attr_mutex);
+	assert_has_update_locks_for_mdev(matrix_mdev);
+
 	if (source_config->magic != VFIO_AP_MIG_MAGIC ||
 	    source_config->version != VFIO_AP_MIG_VERSION)
 		return -EINVAL;
@@ -950,15 +955,6 @@ static int do_post_copy_validation(struct ap_matrix_mdev *matrix_mdev,
 	return verify_ap_configs_are_compatible(mdev_name, source_config);
 }
 
-static int do_post_copy_processing(struct ap_matrix_mdev *matrix_mdev,
-				   struct vfio_ap_config *ap_config)
-{
-	lockdep_assert_held(&ap_attr_mutex);
-	assert_has_update_locks_for_mdev(matrix_mdev);
-
-	return do_post_copy_validation(matrix_mdev, ap_config);
-}
-
 static ssize_t vfio_ap_resuming_write(struct file *filp, const char __user *buf,
 				      size_t len, loff_t *pos)
 {
@@ -1052,7 +1048,7 @@ static ssize_t vfio_ap_resuming_write(struct file *filp, const char __user *buf,
 		}
 
 		if (*pos == (loff_t)expected_sz) {
-			ret = do_post_copy_processing(matrix_mdev, ap_config);
+			ret = do_post_copy_validation(matrix_mdev, ap_config);
 			matrix_mdev->mig_data->resuming_mig_data_complete = !ret;
 		}
 	}
@@ -1146,20 +1142,46 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
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


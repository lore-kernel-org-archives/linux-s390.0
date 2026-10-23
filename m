Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777448;
	b=z6nFZ1a2uaZGFK0T3i6ztrCVGfw45Klt235f9IF4i47Nepnj7gzitclUuUnMvIMM9jCe
	 jIdNHkYdo4lcQAb0wtSL4pT1ZN6ppixQZrtuQupkOPLJ2ApswNwXw3imhq41bibpQC/wZ
	 Wzpi6Q7exOdMWYa/YKsXEXqiAmqytp7P/SGGg3UqfRG/8phTIGVG0pXS63uljakc7g0tY
	 QlfVLvOV/xuScDTcgvLlmwRiyShCCohy9eWr8g2Kmv8c6tV7QUptJ1pejL1p1J4DWkizO
	 dnh0VMdUHjeDKOqvIO0mmUcBshpnmHoQ0bdM2uyrdsJnQR+OOtiiU0Y0fGrE+1k6SNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777448;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=US1Zf3Q7+SX3f2wUt/dlQmRgPum9++xpzVsZ4yNy/Cw=;
	b=vcMt7WX6E/qDVCTKUxUlSILyOtI1u1zAKfKXniTtgrYtjgYUkjvjiMI0DfkXMdgjlwf3
	 wqCcwpq+R6So8XeVZVA4GqTlOx/oQlmzFDkzoeMouWtWtUbC6GJ8gRpQhbJg09zX1T9yd
	 5cCH7SlW2MHJ35gQTzX2FoYaBgnHey+6GrKJqwmFqTGbY4VUwu7qQY00hZRL8XowRksD2
	 3kbmJ1oXZEI4Gd9+DIVLVDrn9gw38worqo1ZQdlXOcv9otT0+Mf6jv3+ztQ1PZlDCK8MW
	 uhEOjrAU5uxPYlECjvBimD20gYMU7bdwEpuxysUc0ZVKlc0MmkTroZZ8C+PgFLmM3YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fTz672kf;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BF5606A327;
	Fri, 23 Oct 2026 17:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5BF5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fTz672kf
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NGoTQm2413863;
	Fri, 23 Oct 2026 17:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=US1Zf3Q7+SX3f2wUt
	/dlQmRgPum9++xpzVsZ4yNy/Cw=; b=fTz672kfNkNA5lkjTwHhdiZ3Gt7GE5yxl
	mbU7mL0JkEkTWqdrmYyoMqbn1/AzWQ6W4+gtJcWn/jKTKgkjCvtbgB92dtY1vwha
	KkpqkqNuuWVix0o5i/DsHCbptEwlmKxWIfHjI4qSzj7aCa9GeXYBYQYz8DOLZGTY
	C5DEWE1RmVu1iXcjPyw07ibbYqjkymUo09fT3a5H8nWSekQfIx89MAmAI7hxLbPb
	dH6WEArqAa1RBGskRDi4kQLC2cM0tXZPQXzOyqhEo8k2SRtNNSgmRne+BG+naF5b
	Z4A8cyXxVKHJrCAaKqX4XyflMYJYOF6kFOt82R9de8mSBW16vY6xg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58nx41-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:44:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE640T2260505;
	Fri, 23 Oct 2026 17:44:00 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfmpn5nrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:44:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NHhwOv22741672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 17:43:59 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 959235805D;
	Fri, 23 Oct 2026 17:43:58 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0356858054;
	Fri, 23 Oct 2026 17:43:57 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.48.60])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 17:43:56 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v10 04/15] s390/vfio-ap: Reset migration state in VFIO_DEVICE_RESET ioctl handler
Date: Fri, 23 Oct 2026 13:43:38 -0400
Message-ID: <20261023174349.3545941-5-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfX3nOyvUR+T23m
 M6vkbLCEXhQrU8gqdeUV4sk41VR918vtmgeH7OHzMbitP14W8+ROTRsYaOiM/EqkUE3iLg5fRQc
 eXncEbdE+glc7kkE1yys+vhwTN6fArw=
X-Proofpoint-GUID: c0Le2prUzXS0l4K2iDd8Kw46kYkpXVXD
X-Proofpoint-ORIG-GUID: c0Le2prUzXS0l4K2iDd8Kw46kYkpXVXD
X-Authority-Analysis: v=2.4 cv=UOBIjyfy c=1 sm=1 tr=0 ts=6adb9ce0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=OlMDtWmkmZCoppm_HCYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfX12DH5xW5YJ7T
 cpzJISg3MJF9/VXl6fe8YZ0iLooPlVXx+smcl9ELvowjLjxOyTgNo3mPBkmPDbnAtYyL1HLaZP0
 m0+4nop2BmoZBLQLbsZffGIo3TeAyZhIQIENmXvqUDkEG7mCQjzezHslf9bRJXHlZlXl5ipK03l
 Rvd5i3/9PaUNHgnuRupLDieuV3gujJmzKrd8xkSkOkomm6MsnrByEiMFCBDxqQ8eA7SfuaB7CVn
 DneLDUGlfIOq6lM9DdGM0AuYmQ7dH+yTH4okHNGde4CeMDo9pwCFLDQ37r/EyxgU4eYUpvbR+m4
 6BFpyfi0uwC0AG/oq0eBYlLxpnuqkWTyQ7gfOTHW5dllSufPQk52bc9sASsc/j8Lu42rC+/smFH
 Z/LYiyeogtrPDwZbfsqFyNjR6ub2VUJMvAQsJ3bIK8+q8wnSrzVm/G1epgcH/G3xvsF1qqikAdt
 Q0wB/zYfvy4ATqBzT5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230067

According to the VFIO migration specifications, userspace must issue a
VFIO_DEVICE_RESET ioctl if a vfio device enters an error state or fails a
state transition to recover the device and return its migration state to
RUNNING. This patch adds a function that is called when a VFIO_DEVICE_RESET
is issued that releases any open migration file buffers and resets the
migration state to RUNNING.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 20 ++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c       | 11 +++++++++++
 drivers/s390/crypto/vfio_ap_private.h   |  1 +
 3 files changed, 32 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index ba86a1afbb33..5d898be0d058 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -216,3 +216,23 @@ void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
 	kfree(matrix_mdev->mig_data);
 	matrix_mdev->mig_data = NULL;
 }
+
+/**
+ * vfio_ap_reset_migration_state - Reset the vfio-ap migration state
+ *
+ * @matrix_mdev: pointer to the object maintaining the vfio-ap device state
+ *
+ * Called during VFIO_DEVICE_RESET to clean up any active migration
+ * state and reset the device to RUNNING state as required by the VFIO
+ * migration specification.
+ */
+void vfio_ap_reset_migration_state(struct ap_matrix_mdev *matrix_mdev)
+{
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	if (!matrix_mdev->mig_data)
+		return;
+
+	vfio_ap_release_mig_files(matrix_mdev);
+	matrix_mdev->mig_data->mig_state = VFIO_DEVICE_STATE_RUNNING;
+}
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 9cbc5ecb19d5..635c8a20af86 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2320,6 +2320,17 @@ static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
 		break;
 	case VFIO_DEVICE_RESET:
 		ret = vfio_ap_mdev_reset_queues(matrix_mdev);
+		/*
+		 * Reset the migration state unconditionally, regardless of
+		 * whether the hardware queue reset succeeded. The migration
+		 * state tracks the AP configuration transfer lifecycle and is
+		 * independent of the hardware queue reset outcome. The VFIO
+		 * migration spec designates VFIO_DEVICE_RESET as the mechanism
+		 * to return device_state to RUNNING (e.g. to recover from
+		 * ERROR), so the migration state must be cleaned up even when
+		 * one or more queues fail to reset.
+		 */
+		vfio_ap_reset_migration_state(matrix_mdev);
 		break;
 	case VFIO_DEVICE_GET_IRQ_INFO:
 		ret = vfio_ap_get_irq_info(arg);
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index aa8a22585204..c6e577064e7e 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -174,5 +174,6 @@ void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
 
 int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev);
 void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev);
+void vfio_ap_reset_migration_state(struct ap_matrix_mdev *matrix_mdev);
 
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.53.0


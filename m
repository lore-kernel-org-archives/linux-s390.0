Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCE837B03A;
	Tue,  7 Apr 2026 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595089; cv=none; b=nZ9xd/mL40iayc+GAw7NUL4sf4Nx/cbpxN3vmlJW+lKr4+9vBLvUbVkJdk0hj+5rzDceOdinlpcZu9CQ7mS58/fRujWvHSHr+qe7LITBf7ZS9B2E+4TPvJBN1MKwo6RdVL1lE6Q+9yEkErEupICjFMxF42yVd3CGZXWHEzgLJvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595089; c=relaxed/simple;
	bh=ezDMfU6GdQi9/GEV3sLRHgBtfz8lHIf5OqBPE4IVUx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsjcIXd2lpBQxyPyQVm3VM2orTULk9/T49OXuocvY5v3XK+p3LTmqN2RqlTymX+J5Q4KMGJiZ3fJNQbpN4SlxQtpImDtJ+ivpsXhaQuy+p4hXjWLH18LE5+UPWqp6r3bV6wPaMRcxGjLdsXK82Bmel9n9FiVrYj4rI0ZBAbfL/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PYtoebzO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PYtoebzO"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637DtuOM2302957;
	Tue, 7 Apr 2026 20:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gxVz5upnyZnVLRYAB
	J6Sc29C41tRyYnodKjCNtHtS+E=; b=PYtoebzOUNWbQuo6C1FimWFrk5r62o2MJ
	xYE8KGx+ew2IobT0Y7XfP5i2QPpiZzRbbEhNXQ7Qdgb2Hg/piXir9JaC5l+BHmpH
	oHThbEcTygRFV7LhVzLEe1Oz8AyvKkZsNWPg/DbpElxpVV4Ta/U9b9o/vEnlntti
	O+KR6kIM2Jq3Qgj1CnXjhr21c3xBJ6fk6qUXhG7uVVTxLSDUFxKBwJJW6Hk2NCyg
	ry33cN5X0VPhhnI6wwv1vWAll1N47asTrkcL9CFwypyP0rZ6IAYWy1XIEQuREznI
	keL2ueJ8kRxOkYSIWPKMnMtljYiiL+bGNxb+qfctN5nrsaCHMuA2Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fd2s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637It5JK013902;
	Tue, 7 Apr 2026 20:51:20 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf44un7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:20 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637KpIk113369882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 20:51:19 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C38A058058;
	Tue,  7 Apr 2026 20:51:18 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3294C58059;
	Tue,  7 Apr 2026 20:51:17 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.101.194])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 20:51:17 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v2 09/16] s390/vfio-ap: File ops called to resume the vfio device migration
Date: Tue,  7 Apr 2026 16:50:25 -0400
Message-ID: <20260407205100.331150-10-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4OSBTYWx0ZWRfX6MA4Xwdq69p2
 m8Y6yFuzYu0JlnSRSALwI/Wyd7gU+aYCDe8dZwwkbUb3ekZ5UVp4S/um6oC7HzXYbY90jdtw66Q
 hCQuWebMP2JQpd43mOkL/dRTaj0kXhAhf12pt+ABFk6oUe2b2wzhp3QUaeWp6s0B8JjxgWD7ezd
 Vukag/Y2rnNyodd7hBD9b8ZnfMXA3wA5MTXkcN9vLv+n43J+/gq5X2fWdMmFIy2+3orvpn/obpl
 HAJPhXh4jstjww0T+lvvpjHHJANLwsv+Lvyc+/j23ojkScFnUYVwPjdWLsVBbkN6pnGjP/z581S
 KSt3ZhpwG7yyj6Fs2opDwlXT4MPUJFWWE3Q6Itvm6Kmdh8tisXFMY8F7qBPcO1ipFqeQBgSltdq
 1jsYqX5SHKxL+l1FFLHzSyHxHGZOVd2WNM3O9/2FNial2sTAk6oSSRD2XCnyOftfzM7/MZZ4UgI
 XqGsPBsK/1BHd51B6vQ==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d56e49 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=mUIIkNJziSJENXg-bOUA:9
X-Proofpoint-ORIG-GUID: y8JgIE8fSViEGaftBPhrpSDfuTqv4YCE
X-Proofpoint-GUID: y8JgIE8fSViEGaftBPhrpSDfuTqv4YCE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070189

Implements two callback functions that were added to the 'file_operations'
structure for the file created to restore the state of the vfio device
when the migration state transitioned from VFIO_DEVICE_STATE_STOP to
VFIO_DEVICE_STATE_RESUMING:

* Write callback

  The write callback retrieves the vfio device migration state saved to the
  file stream created when the vfio device state was transitioned from
  VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_STOP_COPY. The saved state
  contains the guest's AP configuration information. Since the guest's AP
  configuration on the target system is supplied by the mediated device
  residing thereon, the migration state passed into this callback will not
  be used to restore the vfio device state, but to verify that the source
  and target AP configurations are compatible since the mediated devices on
  the source and target systems may differ.

  The verification rules are:

  o The source and target AP configurations must have the same number of
    APQNs

  o Each APQN in the source guest's AP configuration must also be in the
    target guest's configuration

  o Each APQN in the source and target guests' AP configurations must
    reference a queue device with compatible hardware:

    - The source and target queues must have the same facilities installed
  	- APSC facility
  	- APQKM facility
  	- AP4KC facility

    - The source and target queues must have the same mode
  	- Coprocessor-mode
  	- Accelerator-mode
  	- XCP-mode

    - The source and target queues must have the same APXA facility setting
   	- If the APXA facility is installed on target queue, it must also
   	  be installed on the source queue
   	- If the APXA facility is not installed on target queue, it must
   	  also not be installed on the source queue

    - The source and target queues must have the same classification
   	- Full native card function
   	- Stateless functions

    - The binding and associated state
   	~ At the time of migration, the queue on the target guest will
   	  neither be bound nor associated, so the binding and associated
   	  state for both the source and target must indicate that the
   	  queue is usable for all messages (i.e., BS bits equal to 00).

    - The AP type of the target queue must be the same or newer than the
      source queue

* Release callback

This function deallocates the object used to restore the state of the
vfio device when the file is released.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 518 +++++++++++++++++++++++-
 1 file changed, 516 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index c78e24767d20..ce16028e50a4 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -11,6 +11,36 @@
 #include "ap_bus.h"
 #include "vfio_ap_private.h"
 
+/*
+ * Masks the fields of the queue information returned from the PQAP(TAPQ)
+ * command. In order to migrate a guest, it's AP configuration must be
+ * compatible with AP configuration assigned to the target guest's mdev.
+ * This mask is used to verify that the queue information for each source and
+ * target queue is compatible (i.e., the masked fields are equivalent).
+ *
+ * The relevant fields covered by this mask are:
+ * S bit 0: APSC  facility installed
+ * M bit 1: APQKM facility installed
+ * C bit 2: AP4KC facility installed
+ * Mode bits 3-5:
+ *     D bit 3: CCA-mode facility
+ *     A bit 4: accelerator-mode facility
+ *     X bit 5: XCP-mode facility
+ * N  bit 6: APXA facility installed
+ * SL bit 7: SLCF facility installed
+ * Classification (functional capabilities) bits 8-16
+ *     bit 8: Native card function
+ *     bit 9: Only stateless functions
+ * AP Type bits 32-40:
+ */
+#define QINFO_DATA_MASK		0xffffc000ff000000
+
+/*
+ * Masks the bit that indicates whether full native card function is available
+ * from the 8 bits specifying the functional capabilities of a queue
+ */
+#define CLASSIFICATION_NATIVE_FCN_MASK		0x80
+
 /**
  * vfio_ap_migration_data - the data needed to migrate a guest with pass-through
  *			    access to AP devices
@@ -235,6 +265,53 @@ static void vfio_ap_store_queue_info(struct vfio_ap_migration_file *migf)
 	}
 }
 
+static int validate_resume_write_parms(struct vfio_ap_migration_file *migf,
+				       size_t len, loff_t *pos)
+{
+	loff_t total_len;
+	int ret = -EIO;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	if (!migf->matrix_mdev) {
+		pr_err("migration failed: matrix_mdev object not linked to migration file");
+		goto done;
+	}
+
+	if (*pos < 0) {
+		dev_err(migf->matrix_mdev->vdev.dev,
+			"migration failed: invalid migration file position  (%lli) for write\n",
+			*pos);
+		goto done;
+	}
+
+	if (check_add_overflow((loff_t)len, *pos, &total_len)) {
+		dev_err(migf->matrix_mdev->vdev.dev,
+			"migration failed: pos (%llu) plus len (%zu) operation overflowed loff_t precision\n",
+			*pos, len);
+		goto done;
+	}
+
+	if (total_len > migf->config_sz) {
+		dev_err(migf->matrix_mdev->vdev.dev,
+			"migration failed: source guest's AP config size (%llu) larger than target's (%lu)",
+			total_len, migf->config_sz);
+		goto done;
+	}
+
+	if (migf->disabled) {
+		dev_err(migf->matrix_mdev->vdev.dev,
+			"migration failed: migration file is disabled");
+		goto done;
+	}
+
+	dev_dbg(migf->matrix_mdev->vdev.dev, "resume write parameters validated\n");
+	ret = 0;
+
+done:
+	return ret;
+}
+
 static struct vfio_ap_migration_file
 *vfio_ap_allocate_migf(struct ap_matrix_mdev *matrix_mdev)
 {
@@ -311,11 +388,448 @@ vfio_ap_save_mdev_state(struct ap_matrix_mdev *matrix_mdev)
 	return mig_data->saving_migf;
 }
 
+static void report_facilities_compatibility(struct ap_matrix_mdev *matrix_mdev,
+					    unsigned long apqn,
+					    struct ap_tapq_hwinfo *src_hwinfo,
+					    struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (src_hwinfo->apsc != target_hwinfo->apsc) {
+		if (src_hwinfo->apsc) {
+			dev_err(matrix_mdev->vdev.dev,
+				"APSC facility installed in source queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			dev_err(matrix_mdev->vdev.dev,
+				"APSC facility not installed in target queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			dev_err(matrix_mdev->vdev.dev,
+				"APSC facility not installed in source queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			dev_err(matrix_mdev->vdev.dev,
+				"APSC facility installed in target queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+
+	if (src_hwinfo->mex4k != target_hwinfo->mex4k) {
+		if (src_hwinfo->mex4k) {
+			dev_err(matrix_mdev->vdev.dev,
+				"mex4k facility installed in source queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			dev_err(matrix_mdev->vdev.dev,
+				"mex4k facility not installed in target queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			dev_err(matrix_mdev->vdev.dev,
+				"mex4k facility not installed in source queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			dev_err(matrix_mdev->vdev.dev,
+				"mex4k facility installed in target queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+
+	if (src_hwinfo->crt4k != target_hwinfo->crt4k) {
+		if (src_hwinfo->crt4k) {
+			dev_err(matrix_mdev->vdev.dev,
+				"crt4k facility installed in source queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			dev_err(matrix_mdev->vdev.dev,
+				"crt4k facility not installed in target queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			dev_err(matrix_mdev->vdev.dev,
+				"crt4k facility not installed in source queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			dev_err(matrix_mdev->vdev.dev,
+				"crt4k facility installed in target queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+}
+
+static void report_mode_compatibility(struct ap_matrix_mdev *matrix_mdev,
+				      unsigned long apqn,
+				      struct ap_tapq_hwinfo *src_hwinfo,
+				      struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (src_hwinfo->cca != target_hwinfo->cca) {
+		if (src_hwinfo->cca) {
+			dev_err(matrix_mdev->vdev.dev,
+				"Coprocessor-mode facility installed in source queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			dev_err(matrix_mdev->vdev.dev,
+				"Coprocessor-mode  facility not installed target queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			dev_err(matrix_mdev->vdev.dev,
+				"Coprocessor-mode facility not installed in source queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			dev_err(matrix_mdev->vdev.dev,
+				"Coprocessor-mode  facility installed target queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+
+	if (src_hwinfo->accel != target_hwinfo->accel) {
+		if (src_hwinfo->accel) {
+			dev_err(matrix_mdev->vdev.dev,
+				"Accelerator-mode facility installed source queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			dev_err(matrix_mdev->vdev.dev,
+				"Accelerator-mode facility not installed target queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			dev_err(matrix_mdev->vdev.dev,
+				"Accelerator-mode facility not installed source queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			dev_err(matrix_mdev->vdev.dev,
+				"Accelerator-mode facility installed target queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+
+	if (src_hwinfo->ep11 != target_hwinfo->ep11) {
+		if (src_hwinfo->ep11) {
+			dev_err(matrix_mdev->vdev.dev,
+				"XCP-mode facility installed source queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			dev_err(matrix_mdev->vdev.dev,
+				"XCP-mode facility not installed target queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			dev_err(matrix_mdev->vdev.dev,
+				"XCP-mode facility not installed source queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			dev_err(matrix_mdev->vdev.dev,
+				"XCP-mode facility installed target queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+}
+
+static void report_apxa_compatibility(struct ap_matrix_mdev *matrix_mdev,
+				      unsigned long apqn,
+				      struct ap_tapq_hwinfo *src_hwinfo,
+				      struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (src_hwinfo->apxa != target_hwinfo->apxa) {
+		if (src_hwinfo->apxa) {
+			dev_err(matrix_mdev->vdev.dev,
+				"AP-extended-addressing (APXA) facility installed in source queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			dev_err(matrix_mdev->vdev.dev,
+				"AP-extended-addressing (APXA) facility not installed in target queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			dev_err(matrix_mdev->vdev.dev,
+				"AP-extended-addressing (APXA) facility not installed in source queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			dev_err(matrix_mdev->vdev.dev,
+				"AP-extended-addressing (APXA) facility installed in target queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+}
+
+static void report_slcf_compatibility(struct ap_matrix_mdev *matrix_mdev,
+				      unsigned long apqn,
+				      struct ap_tapq_hwinfo *src_hwinfo,
+				      struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (src_hwinfo->slcf != target_hwinfo->slcf) {
+		if (src_hwinfo->slcf) {
+			dev_err(matrix_mdev->vdev.dev,
+				"Stateless-command-filtering (SLCF) available in source queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			dev_err(matrix_mdev->vdev.dev,
+				"Stateless-command-filtering (SLCF) not available in target queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			dev_err(matrix_mdev->vdev.dev,
+				"Stateless-command-filtering (SLCF) not available in source queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			dev_err(matrix_mdev->vdev.dev,
+				"Stateless-command-filtering (SLCF) available in target queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+}
+
+static void report_class_compatibility(struct ap_matrix_mdev *matrix_mdev,
+				       unsigned long apqn,
+				       struct ap_tapq_hwinfo *src_hwinfo,
+				       struct ap_tapq_hwinfo *target_hwinfo)
+{
+	unsigned long src_native, target_native;
+
+	src_native = src_hwinfo->class & CLASSIFICATION_NATIVE_FCN_MASK;
+	target_native = target_hwinfo->class & CLASSIFICATION_NATIVE_FCN_MASK;
+
+	if (src_native != target_native) {
+		/*
+		 * If the source queue has full native card function and the
+		 * target queue has only stateless functions available, then
+		 * there may be instructions that will not execute on the
+		 * target queue.
+		 *
+		 * If the source queue has only stateless card functions and the
+		 * target queue has full native card function available, then
+		 * we are okay because the target queue can run all card
+		 * functions.
+		 */
+		if (src_native) {
+			dev_err(matrix_mdev->vdev.dev,
+				"Full native card function available on source queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			dev_err(matrix_mdev->vdev.dev,
+				"Only stateless functions available on target queue %02lx.%04lx\n",
+				AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+}
+
+static void report_bs_compatibility(struct ap_matrix_mdev *matrix_mdev,
+				    unsigned long apqn,
+				    struct ap_tapq_hwinfo *src_hwinfo,
+				    struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (src_hwinfo->bs || target_hwinfo->bs) {
+		dev_err(matrix_mdev->vdev.dev,
+			"Bind/associate state for source (%01x) and target (%01x) queue %02lx.%04lx are not compatible\n",
+			src_hwinfo->bs, target_hwinfo->bs,
+			AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+	}
+}
+
+static void report_aptype_compatibility(struct ap_matrix_mdev *matrix_mdev,
+					unsigned long apqn,
+					struct ap_tapq_hwinfo *src_hwinfo,
+					struct ap_tapq_hwinfo *target_hwinfo)
+{
+	dev_err(matrix_mdev->vdev.dev,
+		"AP type of source (%02x) not compatible with target (%02x)\n",
+		src_hwinfo->at, target_hwinfo->at);
+}
+
+/*
+ * Log a device error reporting that migration failed due to queue
+ * incompatibilities followed by a device error for each incompatible feature.
+ */
+static void report_qinfo_incompatibilities(struct ap_matrix_mdev *matrix_mdev,
+					   unsigned long apqn,
+					   struct ap_tapq_hwinfo *src_hwinfo,
+					   struct ap_tapq_hwinfo *target_hwinfo)
+{
+	dev_err(matrix_mdev->vdev.dev,
+		"Migration failed: Source and target queue (%02lx.%04lx) not compatible\n",
+		AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+	report_facilities_compatibility(matrix_mdev, apqn, src_hwinfo, target_hwinfo);
+	report_mode_compatibility(matrix_mdev, apqn, src_hwinfo, target_hwinfo);
+	report_apxa_compatibility(matrix_mdev, apqn, src_hwinfo, target_hwinfo);
+	report_slcf_compatibility(matrix_mdev, apqn, src_hwinfo, target_hwinfo);
+	report_class_compatibility(matrix_mdev, apqn, src_hwinfo, target_hwinfo);
+	report_aptype_compatibility(matrix_mdev, apqn, src_hwinfo, target_hwinfo);
+	report_bs_compatibility(matrix_mdev, apqn, src_hwinfo, target_hwinfo);
+}
+
+static bool qinfo_compatible(struct ap_matrix_mdev *matrix_mdev,
+			     unsigned long apqn,
+			     struct ap_tapq_hwinfo *src_hwinfo,
+			     struct ap_tapq_hwinfo *target_hwinfo)
+{
+	unsigned long src_bits, target_bits;
+
+	src_bits = src_hwinfo->value & QINFO_DATA_MASK;
+	target_bits = target_hwinfo->value & QINFO_DATA_MASK;
+
+	/*
+	 * If all relevant bits are the same, or only the AP type of the source
+	 * and target queue differ but the source type is older than the target
+	 * type, then no incompatibilities will be reported. The AP types are
+	 * considered compatible even if they differ as long as the source type
+	 * is older than the target type since AP devices are backwards
+	 * compatible.
+	 */
+	if (src_bits == target_bits ||
+	    (src_hwinfo->fac == target_hwinfo->fac &&
+	     src_hwinfo->at <= target_hwinfo->at)) {
+		return true;
+	}
+
+	report_qinfo_incompatibilities(matrix_mdev, apqn, src_hwinfo,
+				       target_hwinfo);
+
+	return false;
+}
+
+static int matrixes_compatible(struct vfio_ap_migration_file *migf)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+	struct ap_tapq_hwinfo src_hwinfo;
+	struct vfio_ap_queue *q;
+	unsigned long apqn;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	matrix_mdev = migf->matrix_mdev;
+
+	for (int i = 0; i < migf->ap_config->num_queues; i++) {
+		apqn = migf->ap_config->qinfo[i].apqn;
+		q = vfio_ap_mdev_get_queue(matrix_mdev, apqn);
+		memcpy(&src_hwinfo, &migf->ap_config->qinfo[i].data,
+		       sizeof(src_hwinfo));
+
+		if (!qinfo_compatible(matrix_mdev, apqn, &src_hwinfo, &q->hwinfo))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static bool apqns_match(struct vfio_ap_migration_file *migf)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+	unsigned long apid, apqi, apqn;
+	bool ret = true;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	matrix_mdev = migf->matrix_mdev;
+
+	for (int i = 0; i < migf->ap_config->num_queues; i++) {
+		apqn = migf->ap_config->qinfo[i].apqn;
+		apid = AP_QID_CARD(apqn);
+		apqi = AP_QID_QUEUE(apqn);
+
+		if (!test_bit_inv(apid, matrix_mdev->shadow_apcb.apm) ||
+		    !test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm)) {
+			dev_err(matrix_mdev->vdev.dev,
+				"migration failed: queue %02lx.%04lx not assigned to guest matrix\n",
+				apid, apqi);
+			ret = false;
+		}
+	}
+
+	return ret;
+}
+
+static int vfio_ap_validate_num_queues(struct vfio_ap_migration_file *migf)
+{
+	int num_migf_queues, num_mdev_queues;
+	struct ap_matrix_mdev *matrix_mdev;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+	matrix_mdev = migf->matrix_mdev;
+	num_mdev_queues = vfio_ap_mdev_get_num_queues(&matrix_mdev->shadow_apcb);
+	num_migf_queues = migf->ap_config->num_queues;
+
+	if (num_mdev_queues != num_migf_queues) {
+		dev_err(matrix_mdev->vdev.dev,
+			"migration failed: number of queues on source (%d) and target (%d) guests differ\n",
+			num_migf_queues, num_mdev_queues);
+		return (num_mdev_queues > num_migf_queues) ? -ENODEV : -E2BIG;
+	}
+
+	return 0;
+}
+
+static int do_post_copy_validation(struct vfio_ap_migration_file *migf, loff_t pos)
+{
+	unsigned long nqueues_offset;
+	int ret;
+
+	nqueues_offset = offsetofend(struct vfio_ap_config, num_queues);
+	if (pos >= nqueues_offset) {
+		ret = vfio_ap_validate_num_queues(migf);
+		if (ret)
+			return ret;
+
+		if (pos == migf->config_sz) {
+			if (!apqns_match(migf))
+				return -ENODEV;
+			ret = matrixes_compatible(migf);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * vfio_ap_resume_write - store the AP configuration information sent from the
+ *			  source guest into the migration file.
+ * @filp: the file used to send the AP configuration information from the source
+ *	  guest.
+ * @buf:  buffer containing the AP configuration information sent from the
+ *	  source guest
+ * @len:  the length of the AP configuration information contained in @buf
+ * *pos:  a pointer to store the file position after retrieving the AP config
+ *	  information from @buf
+ */
 static ssize_t vfio_ap_resume_write(struct file *filp, const char __user *buf,
 				    size_t len, loff_t *pos)
 {
-	/* TODO */
-	return -EOPNOTSUPP;
+	struct vfio_ap_migration_data *mig_data;
+	struct vfio_ap_migration_file *migf;
+	ssize_t ret = 0;
+
+	if (pos)
+		return -ESPIPE;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+
+	pos = &filp->f_pos;
+	migf = filp->private_data;
+	mig_data = migf->matrix_mdev->mig_data;
+
+	ret = validate_resume_write_parms(migf, len, pos);
+	if (ret)
+		goto out_unlock;
+
+	if (copy_from_user((void *)migf->ap_config + *pos, buf, len)) {
+		dev_err(migf->matrix_mdev->vdev.dev,
+			"%s (%d): failed to copy queue information from userspace",
+			__func__, __LINE__);
+		ret = -EFAULT;
+		goto out_unlock;
+	}
+
+	*pos += len;
+
+	ret = do_post_copy_validation(migf, *pos);
+	if (ret)
+		goto out_unlock;
+
+	ret = len;
+
+	dev_dbg(migf->matrix_mdev->vdev.dev,
+		"%s (%d): %zu bytes of queue information stored in the migration file",
+		__func__, __LINE__, len);
+
+out_unlock:
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	return ret;
 }
 
 static const struct file_operations vfio_ap_resume_fops = {
-- 
2.52.0


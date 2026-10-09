Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C2B4D4876;
	Fri,  9 Oct 2026 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546207; cv=none; b=IjxPM+wzDP7BY3Hk4mNPr/lBzoKJNuuhbqSbCT05nph0UTZfTavRDHKQPqFc5E4H0CM65BUpzB2bFLTNarg08BrkL7zI3O0bUAT5SbM9vqUXOkh2KSMZufKS0qbuT+I5y4FR6yjhx/37CQEQsnZfXgWFHOhkcsrh7wDy8jl6yg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546207; c=relaxed/simple;
	bh=En1zPXCLcSKVH8hGEOiyuK2oVDala+GPdhgI5SzNiKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqlFa9QEjdoaJzt6mLOvQ15tUHzIHBBTjx9xvLw0YCGf4DaKmpMFpg+AuYyin5NfzbMMfbtIvgFV9oYMgIjnHYkhkW/KJa1ALyG7c6PVAkt79G4T1HFGz75mw9iCk/UMzHrBRjXBdC/Im9mUXfw2phMRmdk/FOL7zr7bHndx6Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gnEYsh/b; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gnEYsh/b"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998ZwbI2596991;
	Fri, 9 Oct 2026 11:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZW/iDnMin2PXn71qJ
	V+2KGNaVvdw5G9nmVhUC0q0nDs=; b=gnEYsh/br9TE4cCYXsITfdYwA1/ESRRdR
	lUvmTQPSTou8zewtwS2ojlcqj0behcLluB/KRE5p6fezsPoMUYZkNjt6HT0XKddj
	svePHhO25HruiYuC4FVVU64N4vr626vhG/VTcYffhEQeTNqNpMVuhGg5NEFHYMIM
	/j6uSPVHqAppbOVSPjjYi3NWAOvO6K+5McFMo5lMx8p/LTfYPVKCeu5xlYnDLtNP
	X3t/1Qai3J6cfY3DeeW5LsOPtfpRpu6XcSjoisGXC9jzZlZXgL4OLPxodMA6+9kS
	vQZ8XLNFu2FGKJt7mCL0GI7z/yGYAnRHPasluP3uOC9vKlegTXHKQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xk1hn65-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:43:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998I4mD621431;
	Fri, 9 Oct 2026 11:43:03 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnjtns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:43:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699Bh1IW28705410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 11:43:01 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA50D58052;
	Fri,  9 Oct 2026 11:43:01 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24B4158045;
	Fri,  9 Oct 2026 11:43:00 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.159.45])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 11:43:00 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v8 08/15] s390/vfio-ap: Transition device migration state from STOP to RESUMING
Date: Fri,  9 Oct 2026 07:42:37 -0400
Message-ID: <20261009114244.1213173-9-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YtCa1IYX c=1 sm=1 tr=0 ts=6ac8d347 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=dFtAHy0WI_kTpcb5h7MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfX/QvwLUgxYa8Y
 M1tpS4fKzZD7NEY0pVb9sCEDBMYtlSdaxcgGbSMAU5ldT7/RdLD1NEpXgMjGqrutERKrS5D3IVi
 nkplYVi+j0b24EZeerVEbki3Z04yTxBGsFLaNgaxK8DuaXLv8MdAIin81Rwpf9bxDsdD4OAHits
 nwYHDw2TLG5K74X+UZXpNM6eGys/uhi95U8K1rC1+gjlCxbgzTcf43d11tvI4RMoaGO2GBv3yLn
 oVDeqGmAWI5VNCr6Yiz71KW+pe9gk5Ao6Ya6SCHxvmebI70nMMhMopFR96x9dh+s9fsa1wL2aZF
 HFV5wa71ESEM72jdwnGNvW5CDXnMAw/pDJTIXEcAwZJYWHM/8UWmRL+7fJ+isNdLWsr+PpSNa6d
 V+ZrD2vvrluvH1TueKLgmhkW22f1XOkOnkF2cd7mUj7cvPv9+hssx69U/1LjAQ9cHlJMoleZQ0z
 S1E7qWUi7ZYTa1bkSrQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfX+d3CEwlDXa7T
 5mcW9dtNl0FkKUmUuCOsl4+5SEqtwQKxUW3oJkx/gvqktn5caaJ2Da3bT0Pb2y/vH+sIh0ftNvK
 w4c0CHN4XihuJa1THCUbeUlU8xwDIZk=
X-Proofpoint-GUID: p2QnaNaZtPNEsbvZ7W3nMu7qF9gEnCil
X-Proofpoint-ORIG-GUID: p2QnaNaZtPNEsbvZ7W3nMu7qF9gEnCil
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090046

Transitioning from VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_RESUMING
starts a process of restoring the device state of the vfio device on the
target system. To prepare for restoring the device state, open a file
stream to receive the guest's AP configuration saved when the device state
on the source system transitioned from VFIO_DEVICE_STATE_STOP to
VFIO_DEVICE_STATE_STOP_COPY.

Note:
This commit introduces the file operations structure for migration state
files with a stub implementation of the write operation. The complete
implementation is provided in the subsequent commit.

This incremental approach allows for easier review of the migration
infrastructure setup separate from the actual implementation logic.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 34 +++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 0c43f25e2d9b..7b9851b79ec5 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -448,6 +448,26 @@ static struct file *vfio_ap_open_file_stream(struct ap_matrix_mdev *matrix_mdev,
 	return filp;
 }
 
+static ssize_t vfio_ap_resuming_write(struct file *filp, const char __user *buf,
+				      size_t len, loff_t *pos)
+{
+	/* TODO */
+	return -EOPNOTSUPP;
+}
+
+static const struct file_operations vfio_ap_resume_fops = {
+	.owner = THIS_MODULE,
+	.write = vfio_ap_resuming_write,
+	.release = vfio_ap_release_mig_file,
+};
+
+static struct file *vfio_ap_resuming_init(struct ap_matrix_mdev *matrix_mdev)
+{
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	return vfio_ap_open_file_stream(matrix_mdev, &vfio_ap_resume_fops, O_WRONLY);
+}
+
 static struct file *
 vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 			    enum vfio_device_mig_state new_state)
@@ -479,10 +499,20 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 		return filp;
 	}
 
+	/*
+	 * Begins the process of restoring the vfio device state by creating and
+	 * returning a streaming data_fd to be used to read in the internal
+	 * state of the vfio-ap device on the destination host.
+	 */
 	if (cur_state == VFIO_DEVICE_STATE_STOP &&
 	    new_state == VFIO_DEVICE_STATE_RESUMING) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+		struct file *filp = vfio_ap_resuming_init(matrix_mdev);
+
+		if (IS_ERR(filp))
+			return ERR_CAST(filp);
+
+		mig_data->resuming_mig_file.filp = filp;
+		return filp;
 	}
 
 	if ((cur_state == VFIO_DEVICE_STATE_RESUMING &&
-- 
2.53.0


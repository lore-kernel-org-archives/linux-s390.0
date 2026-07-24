Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC82B42048;
	Fri, 24 Jul 2026 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784910876; cv=none; b=JDxKjC2iBCAVHfCMgPbRSIXm9O7DPq4WeHe3ZdD05TCJMiRP5t0yV1cdZ+iSJJGBNiOrQLFC76CFqYJoh8p/cWh+a73gsrFPtOVu0hMp3KSthNjHWJKjIk5UgCeiv8FTLkfuzWWazXfyr792LfQCLeSobCIOscy084ikMplCX5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784910876; c=relaxed/simple;
	bh=k+Obqj9iOgucfJURJ9rpqDocwWXy6ezMgS7pfDVZiYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8/2Y9WiPBxzGxRmhFH8FAnjndXr3JHTbcwcRCKZNt5AQ0RZAMDY5sIZNHy1wD+8D5o5br/hxgeTT6c4vAnbkh5CdJv5Za+5gAWzgii8U3xt0BQI6i1FPS9aOm7LPX3PYrCfILZXLTq5imN6sSH2FhaahSMdX3Z8qMpvYkLnOco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fTUUEQ2u; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fTUUEQ2u"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODftnp1994137;
	Fri, 24 Jul 2026 16:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=h5nXIeSx8guEBHDGz
	wyPZyocq4zTuerMD3COLV/IQXc=; b=fTUUEQ2uGqI9np0Y0SgPsy4fcZUqFj/T5
	FJMkdN/wZv2I31dsjgk81xQgTYZJkPGtajt4spdMyxE1BebNjsxWLVWxKjfhEdgo
	a4cUeOLiraitqNhLGZ1bUwQkpu4bMH+1bws60rFx58VvysW4b6gIkGyJhWp4A8MN
	FUXdTrXTPQfI1ahYmkCF5qwqlWSbFkN2+oCBYnsd052a5bJ3jDgxsbDyg+ePfrbO
	BQKaA8fGV/DwweosX4tz9H6HFdJ4lyrwZHw89xUrpWhuX8LrLpE7qxvkp9gYvN8i
	xBBwoaQm2OSWhw/ilrOpJfinCwSNcDJV48dCOIGdJoBzUgCIbp78g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahmwas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:14:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OG4k70022313;
	Fri, 24 Jul 2026 16:14:09 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyscg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:14:09 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OGE8mR30212840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 16:14:08 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB8105804E;
	Fri, 24 Jul 2026 16:14:07 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 523855803F;
	Fri, 24 Jul 2026 16:14:06 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.50.28])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 16:14:06 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v5 08/15] s390/vfio-ap: Transition device migration state from STOP to RESUMING
Date: Fri, 24 Jul 2026 12:13:44 -0400
Message-ID: <20260724161351.1802644-9-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3mPnQELeimcjQRtQbZLICFGNah5evglK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfXwZfPcsTZ4cD6
 ZtywCqC8utBBBNO8WDUoVO0sHhHF71DMDe+HmNqcNSL/qe+Jn+I8i8/hcKpQcgT1s40Hm49gX9Z
 e72styOupCU6N+UkbwXKRwyw7QaNXFtptguUqK3fk85UelHGtNVxU37pSmTrYDT+L3C3T7EeDLp
 7ozaXJCcfug5Vcdpzdyi0zMimnvZ8wx7UasqN9KBAD0jct+C6BAakmmKU1TZcJbr0x2oukX2Qlv
 yZ99PY1C0G+rYikZRe/ZW8/UE8Hvy2uusth2yJDbqbijaDyi9u4+zwesslEhmN8HyzalMWecMkh
 CS4Vf6x2eDxEnD9/VjvgyyYWmKJ6XW+92SVcv//fvlDeek8vuX39kEY+/HagumqhYxj9rlfZr5f
 yY6dgzXlUkJcghE8k/TqEXnGK2ffH5YJBqJ1xJTrUm9YuvuWmp6/kTqGSGFjrmS8Tixd8armq0Y
 KETK7N3UNoDTxstXukw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfX3sylQC/e59xv
 0T2JBgLJgAwv+PooY6CmLwoFqdGMj78oI08McKoPYsgob/5PpF+hdQx3tYaCEKu83zd2SbbNQWr
 vTnQOY953v5w0Xzyoqo1Mo3Bhbl/4hA=
X-Proofpoint-GUID: 3mPnQELeimcjQRtQbZLICFGNah5evglK
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a638f51 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=hRsAbhqWHO6Cr0izqpsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240145

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
---
 drivers/s390/crypto/vfio_ap_migration.c | 51 ++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 0d949ec205de..4a489a7a05ff 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -82,6 +82,15 @@ vfio_ap_release_stop_copy_file(struct vfio_ap_migration_data *mig_data)
 	mig_data->stop_copy_mig_file.filp = NULL;
 }
 
+static void
+vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_data)
+{
+	kfree(mig_data->resuming_mig_file.ap_config);
+	mig_data->resuming_mig_file.ap_config = NULL;
+	mig_data->resuming_mig_file.config_sz = 0;
+	mig_data->resuming_mig_file.filp = NULL;
+}
+
 static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
 {
 	struct ap_matrix_mdev *matrix_mdev;
@@ -97,6 +106,8 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
 
 	if (filp == matrix_mdev->mig_data->stop_copy_mig_file.filp)
 		vfio_ap_release_stop_copy_file(matrix_mdev->mig_data);
+	else if (filp == matrix_mdev->mig_data->resuming_mig_file.filp)
+		vfio_ap_release_resuming_file(matrix_mdev->mig_data);
 	else
 		ret = -ENOENT;
 
@@ -398,6 +409,32 @@ static struct file *vfio_ap_open_file_stream(struct ap_matrix_mdev *matrix_mdev,
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
+	struct vfio_ap_migration_data *mig_data;
+	struct file *filp;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	mig_data = matrix_mdev->mig_data;
+	filp = vfio_ap_open_file_stream(matrix_mdev, &vfio_ap_resume_fops, O_WRONLY);
+
+	return filp;
+}
+
 static struct file *
 vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 			    enum vfio_device_mig_state new_state)
@@ -429,10 +466,20 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
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


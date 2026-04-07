Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663C437EFFD;
	Tue,  7 Apr 2026 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595085; cv=none; b=blI3lTjEMR7nFeNDiblZNWNk9Zrq5l5JmbYiLUzxL1v2nkKBHmQDjHOdAAFEX55L5SVWqR+MMqnQaW9aepnWKnF66ogMuSFWDB4RsZNPxqcegkHiPFlPfF9wlazEYFw25XmBeSOrHpsCdM9WXBled9AsA7n2lDtloSrCGXYZdnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595085; c=relaxed/simple;
	bh=6lECcwRlYJc1VwOaVPSz+3sJVoOUPChLBxtbNKnNYVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDwkVwh27F0Qb8DdHIF/q+U4Oaq+xw1PoE9pfVW3pWBRjCY9dxYVZLT/yg+RoRs0Kw2IwdErPgrThfNnrpT/iliKcFIVUCc0T+hrZ0iCZvoKqYV+OIYID5z4qqccKHtpRUaxYPH6tgXzSRkONYSs5Pl06Mc3lxyEPg+fUhsO1Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ByGcwGn7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ByGcwGn7"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637Dg4ad2326591;
	Tue, 7 Apr 2026 20:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=r4Zy/Cm0jI63M/iCK
	KPArehXAp8olRhJ4Gv59f45+j4=; b=ByGcwGn7RaypS5e9flURIeAtDPdw/VZuz
	SvFJDdeW3F01Qq96GNBhS0+Vh0MCuhJd5B5j78QkgWtq5whm/lsLkIoHv76th9+4
	rRvoyNrJeRZ8bYOeWNfkJzWvXLUFZSq4qkalkzWdtsSMDLZPpYAKq11U3aO+CxxN
	Qmlbr6rD8xJRrl38tapIa59FRWjX5Fg25sdejlMKsh8gkgWBwGLUT0KVeXgwCkvc
	FQJli212WfmFj/8fLglN+aEkA9gXLkbKoXOwlB8U/cARF5CGYlN593MvZKlfubBk
	n3Xibly5Xewe8uSDbUZgblck5Wj50j7pB2jdgrOHIhMK7cykcwSjw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kcntj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637IkcT3018987;
	Tue, 7 Apr 2026 20:51:18 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9cuph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:18 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637KpHU960883220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 20:51:17 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A0B658058;
	Tue,  7 Apr 2026 20:51:17 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 705325805B;
	Tue,  7 Apr 2026 20:51:15 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.101.194])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 20:51:15 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v2 08/16] s390/vfio-ap: Transition device migration state from STOP to RESUMING
Date: Tue,  7 Apr 2026 16:50:24 -0400
Message-ID: <20260407205100.331150-9-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4OSBTYWx0ZWRfXz5aCF9Gl4DOo
 6H4TnKIiiJRkpCRePPJvRh8RNA5XfzSQn8P4RHILU+gtnLU0F0nbIqPPUAk5b5qw9IJgIV0HZ1J
 EgPH/Kg4Jt5IG19vcW8nebvgQFSe096Nz2fc4Nt/87dUUNTCxEorKbc2Iudr0lEhTwdWFvlEIfQ
 1lk7X55OB4mlp8GyVcmNDNOWENwwJdJ7gytOm3pHOlpIsNKh9jz8+cTsZRnmaa4iwcpF5VjwugA
 BPnGdhmKmq9Re9y3t5PJfb3kp0E4qoq/i516WWRbwLzPVZ/V3eDzcYnJ5NoZdwNG6ZvgMaTpSNm
 JN4wxHMMZh2iVY+jUYCByM/LDBZqmyHRzgedQRaMrfwHoj7sm2UX+jowH7Cl7RCvhwo2TQWJF3H
 OXTPLxqyHp81sKt8F0lc1bmrYaRL4Nvx8mNlzeGFCrrjMswfj+dpacjglcr06FGldRGeNCqidd6
 lxamqox4D87oXjDwG8g==
X-Proofpoint-ORIG-GUID: 2lszLMahOiihJabXnccYh4QjWdBFbUuC
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d56e47 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=DHoCqielVpiR_Jvp3-wA:9
X-Proofpoint-GUID: 2lszLMahOiihJabXnccYh4QjWdBFbUuC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070189

Transitioning from VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_RESUMING
starts a process of restoring the device state of the vfio device on the
target system. To prepare for restoring the device state, open a file
stream to receive the guest's AP configuration saved when the device state
on the source system transitioned from VFIO_DEVICE_STATE_STOP to
VFIO_DEVICE_STATE_STOP_COPY.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 55 ++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index aadc362edf78..c78e24767d20 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -311,6 +311,46 @@ vfio_ap_save_mdev_state(struct ap_matrix_mdev *matrix_mdev)
 	return mig_data->saving_migf;
 }
 
+static ssize_t vfio_ap_resume_write(struct file *filp, const char __user *buf,
+				    size_t len, loff_t *pos)
+{
+	/* TODO */
+	return -EOPNOTSUPP;
+}
+
+static const struct file_operations vfio_ap_resume_fops = {
+	.owner = THIS_MODULE,
+	.write = vfio_ap_resume_write,
+	.release = vfio_ap_release_migf,
+};
+
+static struct vfio_ap_migration_file *
+vfio_ap_resume_mdev_state(struct ap_matrix_mdev *matrix_mdev)
+{
+	struct vfio_ap_migration_data *mig_data;
+	struct vfio_ap_migration_file *migf;
+	struct file *filp;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+	mig_data = matrix_mdev->mig_data;
+
+	migf = vfio_ap_allocate_migf(matrix_mdev);
+	if (IS_ERR(migf))
+		return ERR_CAST(migf);
+
+	filp = vfio_ap_open_file_stream(migf, &vfio_ap_resume_fops, O_WRONLY);
+	if (IS_ERR(filp)) {
+		vfio_ap_deallocate_migf(migf);
+		return ERR_CAST(filp);
+	}
+
+	migf->matrix_mdev = matrix_mdev;
+	migf->filp = filp;
+	mig_data->resuming_migf = migf;
+
+	return migf;
+}
+
 static struct file *
 vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 			    enum vfio_device_mig_state new_state)
@@ -344,10 +384,21 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 		return NULL;
 	}
 
+	/*
+	 * Starts the process of restoring the state of the vfio-ap device
+	 * on the target host by creating a filestream to be used to transfer
+	 * the internal state of the vfio-ap device on the source host that
+	 * was saved during the STOP_COPY phase of the migration.
+	 */
 	if (cur_state == VFIO_DEVICE_STATE_STOP &&
 	    new_state == VFIO_DEVICE_STATE_RESUMING) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+		migf = vfio_ap_resume_mdev_state(matrix_mdev);
+		if (IS_ERR(migf))
+			return ERR_CAST(migf);
+
+		get_file(migf->filp);
+
+		return migf->filp;
 	}
 
 	if (cur_state == VFIO_DEVICE_STATE_RESUMING &&
-- 
2.52.0


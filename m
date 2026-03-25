Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6979365A0D;
	Wed, 25 Mar 2026 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472543; cv=none; b=FS2Aq7pvFUEuUSEEC7u04vhkWj9doQrgEsFPyxpOw+e8ulB9kUYIsJkW5vg51Hn3DJYNkHPHnM7VCUeHu3vtwcBfyNL6hRdbuTbqLmiCG4rjIF2mwXQwnU7CNGvR0ImRRCdQBX+NPH+2kxkJb6/1eqGDxXKQbUhCZcDivIppna8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472543; c=relaxed/simple;
	bh=gf3qZz7olvk49MuUu4bQ27Fa08dU/AAhp4flv6uNO9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrHsOqtmdmutRvsvqf6gW/xwrk6Uhap+vOUSKZUQhA7VwSAgxXZN0CvJy3slW3w1gvqoZgeHAB/YGeZ8110WdCHuOGXn20QW6kJPQj7jLrS7T89NyJyPwl6MRr2iLGDclzlJxTwMaWiCahn1LGXZU32sSH6h3al2QpNNANMFr7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qMsuB8vm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qMsuB8vm"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PHuq023105965;
	Wed, 25 Mar 2026 21:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aySYdd3dDt5eKJMgp
	q3U08nb1UZ1Sn9tO2GSTFKQQVY=; b=qMsuB8vmlH9utX/97Ug6YeMp88EcbCmmk
	oK3gaTTzVAqtA4VRB00H4BVt8qxb+W51bCHAymj33U4IXadbIeX20mmbFRwAirMO
	J+ney8wGB9XmmWIuLPXafYdQ8aSfXcr0qG2QkRTrxrK8ARcX0KhPMAn27sjZ8O+y
	t1RKmsTM6K5RVxx9l1HEia7y8QIC09+ON8e3bh30P2WKqAGrYj0jJ7TKNAKs0Q5T
	HQJTorYYhP+qyYXG9AL4lfHnN82KVDUjkIl1hQgcUVenIWz+ga1dtnHVrM9ImlSo
	uoj7bP4XT5JhLWAHnJ4kfOBRRnzMHoG/EowyHPW6Z90hHRgqwF5WQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktv1hjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PKC8F8026900;
	Wed, 25 Mar 2026 21:02:09 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m053u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:09 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL28Pp38928788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:02:08 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 144485805D;
	Wed, 25 Mar 2026 21:02:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BE3958056;
	Wed, 25 Mar 2026 21:02:07 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:02:07 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 15/24] s390/vfio-ap: Transition device migration state from STOP to RESUMING
Date: Wed, 25 Mar 2026 17:01:02 -0400
Message-ID: <20260325210149.888028-16-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: CxI9jjkuhzvmFVBRYJjQAGjZ5bST7LNB
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c44d52 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=DHoCqielVpiR_Jvp3-wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfX5SIprQFtmlkN
 F7TAibLf9K4Xmk33cM8HcrR/Eayw/OFsxfAG8cT8aKb6eqxryS+yQ9XfGvXxaW9J338YqWDk76U
 8pJvIVQRN1VEY7GPtxpo1gWUIbxNDCayWoND0S7GMSmp+xmppP1+S11ZXkQmaNJEBlAo2aUZJ3B
 qvhnSeM0HMvaR0S+klJm22ydmJKL+oSbzvaRDLyhpnLFyoNbeSWStt7LcSH3Cze+efypEac2DfB
 VskzYDP3kD2iClWBcWLVO7O8VWLgilo3JtjbEdAzun2p6YfZKOcGZ+l0RMFRgz9gnhe+HQUz0hh
 Co2U+/CxjZHEAMEehXGrHTrbbnONqDdDzDv80waWfgVerJUnaRgfUndkA2KcDfRXMvuY/wYA6nV
 h2YIaUDmhVjOOqm4KFGK+ctGNTqTlaOjZ0bY9U9+JGeoD90hxN01tSwrrx//jacdgYPAPDagbUg
 00mfFVs/JIfkRRK2pcw==
X-Proofpoint-GUID: CxI9jjkuhzvmFVBRYJjQAGjZ5bST7LNB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149

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
index a340dca1426c..a243ea134794 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -310,6 +310,46 @@ vfio_ap_save_mdev_state(struct ap_matrix_mdev *matrix_mdev)
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
@@ -343,10 +383,21 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
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


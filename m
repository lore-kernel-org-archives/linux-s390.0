Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16BD348879;
	Wed, 25 Mar 2026 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472537; cv=none; b=pMtpMdxymZOvOUZGWysZE7RykrA6h0yLHiHNkN+grzy50kGqIIod63R/fXSqIR41zQXJKnoFtIXKLQ0LGmT9VXSuhUXkAcBaP0XNcehcjEw2+Y/+iDtXtclz8Fotkzs9cwl7zAqQWTrtlOewCtPQLre1t+5B6SBrHF9o9vhUTTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472537; c=relaxed/simple;
	bh=1uwJahfo9ffSwr4Mhrk9Fron3HPbiIv444UxsjB5PTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOM2V+MU4aQdFiXM4edyAFUO5UnNkdHVqqAbYEOZWqhA0N8FbV0UxydIOpw7pFobL+mpOJSnGm2tGcMETZT1iM5H7L0LyHMsRVHut48MXjGKwkJpEA9yUZOxjahP6qq+Afic4a9/uLNcMMydGczwpdeNeM80RT8V49Ay0GHiBMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nAC9hrrt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nAC9hrrt"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PJJQc8265856;
	Wed, 25 Mar 2026 21:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bDWULt6XhlbBcd0q0
	imaFliokdDLLH09ol0T03eBEcM=; b=nAC9hrrtWCLZK5n4+mlT4l8kp+/KasR2O
	nzO5q5wkORyPjVcyyRqgKwWruBIai4OJWEtFfsNcnCFUdlT/ZFyuzOAjyE/zfx3B
	54eTMF0HHfgxgVF4Do+RD+6w4uNKNK+0waYtHPRIdLcXpK2Oy5Zs/v2bYEODdkh6
	Mww8hq1+JigBArfKCIGXhtAuBOhQjxG5FFFYi1Av/+TTSssGGEOoTYWGhxQ+EINQ
	zuDCD9kNjc7DM3Zj2kLvKWIpmxOAFsDvE0oHKYwY+slLF7tKpywwQ4R62gMKW8pQ
	yBYJhg80bA64kB6GAu4j31Dp0I48NYoTtcfa1z2TokDUH9cALDXQQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqjeqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PGmstP012177;
	Wed, 25 Mar 2026 21:02:09 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk8178-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:09 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL1hkI28443374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:01:43 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE87658065;
	Wed, 25 Mar 2026 21:02:06 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 046B35805D;
	Wed, 25 Mar 2026 21:02:06 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:02:05 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 14/24] s390/vfio-ap: File ops called to save the vfio device migration state
Date: Wed, 25 Mar 2026 17:01:01 -0400
Message-ID: <20260325210149.888028-15-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: QR2hNFjdR1_pCaOzvpYxvShWgwGRlTzM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfXxs77U2uBchho
 0S8r41EIgT/sXS8A2qWSDCryIFPqOJcvYT92h3U8dwpXYlsHCWAK2autOdpwsZ2W01L8gRhQTv5
 bRV5AzVYZW31ua6J55s+U71Xyan3kILzEnHVZVox0eMtuhPtMT9K91OV7N//V6TzLJjix+ZuN1B
 IFvURn5oLvWo7dcnkOunK8ZHjFeS8I/Lsp/nCttrQoST66rE4rrCC6ckwDFuKewSf0uW+ThIG4Y
 5DNL1ytY3b7TpvtYwmNHNLPSRjXU53H5NUHbRnKb87lnFruZCj9KjnbInyt/x6kp6aKDTi1LMjq
 oFffW4gYyO0+LTZPTpZ76JmDbzfCXgnkbnf/YnPJkPSuoOHsgBxqo0fxinRiwQx0TeGOuEV6Wkx
 8MvpMAnJcS0EbgB+y90kW1Z02ghm786GB7cZdS9a9kPAK8A0dm3beW/0etuiGTF+5hxrrmw5fc4
 KweNcYfrzhyRFWZ+tWQ==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c44d52 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ziKF1hX67kHMkuPFGWMA:9
X-Proofpoint-GUID: QR2hNFjdR1_pCaOzvpYxvShWgwGRlTzM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250149

Implements two callback functions that were added to the 'file_operations'
structure for the file created to save the state of the vfio device
when the migration state transitioned from VFIO_DEVICE_STATE_STOP to
VFIO_DEVICE_STATE_STOP_COPY:

* Read callback

  This function copies the guest's AP configuration information to
  userspace. The information copied is comprised of the APQN of each queue
  device passed through to the guest along with its hardware information.
  This data will be used to verify the source and target guests have
  compatible AP configurations.

* Release callback

  This function deallocates the object used to save the state of the
  vfio device.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 78 +++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index ecc9f0f6819e..a340dca1426c 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -97,16 +97,82 @@ static void vfio_ap_release_mig_files(struct ap_matrix_mdev *matrix_mdev)
 	}
 }
 
-static ssize_t vfio_ap_save_read(struct file *, char __user *, size_t, loff_t *)
+static ssize_t validate_save_read_parms(struct vfio_ap_migration_file *migf,
+					loff_t *pos, size_t len)
 {
-	/* TODO */
-	return -EOPNOTSUPP;
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	if (migf->disabled) {
+		dev_err(migf->matrix_mdev->vdev.dev,
+			"%s (%d): migration file is disabled\n",
+			__func__, __LINE__);
+		return -ENODEV;
+	}
+
+	if (*pos > migf->config_sz) {
+		dev_err(migf->matrix_mdev->vdev.dev,
+			"%s (%d): file pos (%llu) exceeds migf->config size (%zu)\n",
+			__func__, __LINE__, *pos, migf->config_sz);
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
-static int vfio_ap_release_migf(struct inode *, struct file *)
+static ssize_t vfio_ap_save_read(struct file *filp, char __user *buf,
+				 size_t len, loff_t *pos)
 {
-	/* TODO */
-	return -EOPNOTSUPP;
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
+
+	ret = validate_save_read_parms(migf, pos, len);
+	if (ret)
+		goto out_unlock;
+
+	len = min_t(size_t, migf->config_sz - *pos, len);
+	if (len) {
+		if (copy_to_user(buf, (void *)migf->ap_config + *pos, len)) {
+			ret = -EFAULT;
+			dev_err(migf->matrix_mdev->vdev.dev,
+				"%s (%d): failed to copy config data to user\n",
+				__func__, __LINE__);
+			goto out_unlock;
+		}
+
+		*pos += len;
+		ret = len;
+	}
+
+	dev_dbg(migf->matrix_mdev->vdev.dev,
+		"%s (%d): copied %zu bytes of AP config data to user\n",
+		__func__, __LINE__, len);
+
+out_unlock:
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	return ret;
+}
+
+static void vfio_ap_deallocate_migf(struct vfio_ap_migration_file *migf);
+
+static int vfio_ap_release_migf(struct inode *inode, struct file *filp)
+{
+	struct vfio_ap_migration_file *migf;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+	migf = filp->private_data;
+	vfio_ap_deallocate_migf(migf);
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	return 0;
 }
 
 static const struct file_operations vfio_ap_save_fops = {
-- 
2.52.0


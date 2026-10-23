Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777453;
	b=Ntid31T3FXKH2gV7wItE++SKT7cv4MRuBBJ7zwWi/H48Lz69anMtkjYHexijVApbPABX
	 kJEqb3dwCVpPPA1oaxR4XGajZPXP98KSXphtnOuyHWnViqSjOF1dqrFJlwVkj7f5I8TJY
	 Bf5AO6tSkQ/bPZKTzpHmAgcmO0mvONpI1IQny9P8EwMZsbHLoqDxC8uWXI4D2z5bI6hya
	 kIkCS2gn4vnSU6Revg18tR6M2ooMej8C8PSkKDaRSp8kpvC0AcgUEnYx4Wt3QM1rc7KvC
	 AlIGSWE58Nxsi96A0fEtDUhtbD0i9UOTH+D1+lUrGPWQy2zOvGMcF0UoHrUXL0PV33w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777453;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XCaQUZ+tJnhpKJAC0eQ6UN66qdjvLcxnTkl8iqVn4yI=;
	b=HbjEOg6yrnSLuXO8qPR0UsGkFmlj1DR9CUtPUOn7KL8iycJ9Y2nVyJUkAL9ZSIkRgZKW
	 HkPOJoqLQ3IFIQ4Nr0qF2ciLZ8TIuLMhbFYdChiBasrMbmZHi1VG0oOhyGkhviPf2xnX9
	 GC239RUBR5zh6v/Vzl3I+wl6wFX3pDenicTzIS1capGr3uqHwzKm4LACPCiUbjNaxwJxq
	 9ipOJN+yY1dS6H0+Mjjt/4bmkF7J91qNAH9waZZp3MM4Sj1uOeWnxHRbEUX0LQTCndvB0
	 wNEVZYqbrc/aoy7BWco8nWZ7lyXQxzgEiwJnp/ALDMA5mtZxUPsxUH4oyCCKS0UiZRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="a/oTQx7F";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA44D606A328;
	Fri, 23 Oct 2026 17:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA44D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a/oTQx7F
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NGob4n2414191;
	Fri, 23 Oct 2026 17:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XCaQUZ+tJnhpKJAC0
	eQ6UN66qdjvLcxnTkl8iqVn4yI=; b=a/oTQx7FsTm5/OducYxLjDcEviX+NkVY1
	LkQ/XIkPD6B9GSkEm4b62ICgRBDVYO1cz3P25WOJMFVFs1C1YA+t2T5hIkNwFo+A
	JRMwlgMV36UiH9tjcE5MXuM49Zhybo1DM2V852U/8RxbDlFOORW28t22XpE/0d9R
	/YH9fT2I/BBua55djPdQPLunm37q1R6GGQnaC9UGbq+fJ2ztrjkcmf6rOckgK8lK
	dS/ecsmMO6nRa4fpWbvNIubC0gYMfh+w0S9kXGs6uJKnR8zExikXc4ogDoawTu3D
	RUXJiC3kUWY53bl1k4fLfIJCy+AgUfTAC0gCmlg3isWlc4iQEh+KQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58nx4g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:44:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NEL7uN2203391;
	Fri, 23 Oct 2026 17:44:07 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hekdgn6u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:44:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NHhIj519530300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 17:43:18 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10C2358054;
	Fri, 23 Oct 2026 17:44:06 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22F295805C;
	Fri, 23 Oct 2026 17:44:04 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.48.60])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 17:44:04 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v10 08/15] s390/vfio-ap: Transition device migration state from STOP to RESUMING
Date: Fri, 23 Oct 2026 13:43:42 -0400
Message-ID: <20261023174349.3545941-9-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX/q/ywoR1Q1nD
 jCE29dYk7vIP97n/khACh0jARil7j06YwbEhb1rKH6XSjRQZB5I5YO0b1HTz8xg5EhhibZb1Jyv
 VYf3Du1no9uMW8sSqtB5fPrm9C4b/aM=
X-Proofpoint-GUID: bE5rCYETtCxUxeKKX_PGY5QuVnW8JQRJ
X-Proofpoint-ORIG-GUID: bE5rCYETtCxUxeKKX_PGY5QuVnW8JQRJ
X-Authority-Analysis: v=2.4 cv=UOBIjyfy c=1 sm=1 tr=0 ts=6adb9ce8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=dFtAHy0WI_kTpcb5h7MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX3WuA5IqRooKt
 /cXZRV8KIqPQ4Zf+7XT383OC5NoT99dAiH7ieHXprHUh59tPLk83l6E+9MdHsQesYRypNZCM4nc
 CYMZqB5hj11O6wNtwHnoIy/j0+TmbnJCAX58hWnZuyg1f84vVpjhQGjTcqkW1+v37k+hFuh+gFO
 rgM6KaWWcUQpw8dNHUVWAAvvQVuS+AUgjiBckrLV+NFANZFyKYvXR/jEjDR4i73pdRCz2+/sgKN
 iYI3sj1wHPFTK/yiTHdN/d+72YfD6wIcSoZtG5m3S/AABCqDy1wAycocnvxOB7r7y+B5WBKO9MF
 IpWqURMNZR2IKaVcxZNzRgBCSYnd311t3JyjB8cQ6xuE54TC6fZY4Jl8IgYKCL6MFeXGp9lPCXF
 vYjSaKspAFe/AAecQh8TaCKzwZZpvoxRgsg8lBVQDAFo/nMIhO+06+vsSK1YZ/pXeFWA6zPMrbq
 izT9jO8Ff30rfBi2VEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230069

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
index f9b00fb89410..9ed657c7302e 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -451,6 +451,26 @@ static struct file *vfio_ap_open_file_stream(struct ap_matrix_mdev *matrix_mdev,
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
@@ -482,10 +502,20 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
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


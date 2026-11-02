Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632585;
	b=0O5JUXwd6twA5/Jwn+Fnoenq3AF7BlNbFHvDSHl3F74TyYTiGksifotzGtBEWIeoj+AJ
	 1kmpKFjwC6KNLKknagHmfXlmJVVgaHjPBj2UBggAe2NtVDlQBXqeCKA5H0FUcdUPJ9A/E
	 c95ndDKN5tldtado2u3F1kwGPGOe2uQgPoWMjXm8OBigX8vJkF2MiFfetK4S+6FTYNvzK
	 VSeSMN5YyPxd3KIfP4ffCABdadiKjqk2Ggy64arSQO4gtlgXIeSnEz9xwxZN9tAAM2tO2
	 e9cpTllkSwLwxEzJ7HtuvgXJQMxR2Ah9G6nicMWVoSBetEIA5uNN8+um3iMSBATi1og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632585;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=EmVEoz9N/npEa1HliBcxHtifKSvOtLmblV7rQBdf1Ik=;
	b=Gc3B+VDNLFZfurrcnSOpalpcHyIXXOZxLgU5+4XwupMAkMKFpzOHp/nvIZsy/p2nVD1K
	 kiIHEoyRCoxLlf8AOmYAFcrDP31alGBYehn0/UXWcFdVjGNh0Q61r4yPdFRYweEAaNH98
	 OtUeYtBucuasrlSxMJopQb3ST3la45IuSsBHSFEc1om371eGOGSn8TRh9wwl+NQ4pyweM
	 7cK/b+mymV8H5srLX2KiSTmsXY972FAoS5gY/HfIdk1bkmu9lsDCcKiz1ftrT9cunU3+W
	 Nf9b51+GZ3vCNlsQ9mPHGj7wFqCpJ9q6Gz4GfuHU4B5Tw/H+v4o7nsW9/HUdi7skP4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rzF7BBKk;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C2C60B7A67;
	Mon,  2 Nov 2026 15:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4C2C60B7A67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rzF7BBKk
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2EEEeO3103434;
	Mon, 2 Nov 2026 15:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EmVEoz9N/npEa1Hli
	BcxHtifKSvOtLmblV7rQBdf1Ik=; b=rzF7BBKk7fyuCtTRJaqHYPV5/IXQG3c/2
	4+hXncquKb1JkB/ZbbzqMxDJ3Tvqvzx7x0adIfrv2y2ia3EFXfjc4SdU4CH1zPqU
	NBCmj75u/X9F6bkQaw1Od9VzcTnu/J7KKinUGCFR5uJwUK7s8OBb2IIncmoE1IZ7
	aq0K6BBZkYZGVdSZtLiMWFYqzX0/7co4eUeqP1XF5HQsePmAJhpQ5KgHxGFh8Du0
	rLdVOnCXlGonM1LtxoJIFMbSuo34HVuCzZmXWGIgit3zNgZnxEunpw5ZW5nHurUl
	dwdnwrRoij4DYVm61yAxr2fDC7+k+jBtA1znOFw83ggWobg/hyMXg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826h8t8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DpO8v4016045;
	Mon, 2 Nov 2026 15:16:19 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnvvfpaqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:19 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2FGH5Z13828818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 15:16:17 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 853015805C;
	Mon,  2 Nov 2026 15:16:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F3B858064;
	Mon,  2 Nov 2026 15:16:16 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.57.150])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 15:16:16 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, freude@linux.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com
Subject: [PATCH v11 08/14] s390/vfio-ap: Transition device migration state from STOP to RESUMING
Date: Mon,  2 Nov 2026 10:14:48 -0500
Message-ID: <20261102151604.2150055-9-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: W3Bo7U4bqIO60cVwoMNUgKW5pxm9Ev1z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfX6MbMBhAJHMU7
 aoR82lBPnAbliNG3Ch12BPaUMxJHyMLPi8S7x/52odCG1FpTVZO3UkYyKA89ZbdyRayu4uup9gP
 xvIKgBjNReGoHQqSXfjcFzuBsiycvTyd/L45/hcHVKZTqvezMGFfH+9VSeWrc/bMHf/KOHwxW2p
 uR/ghEmqHhzkw1QwtUW3Or7PYXYXXS5fv3iCug0GtTGl/NM8iAIstTur4HVTQA2CHiigY+K9Jfv
 /ZBeP1X/u0wN9drmxvA4DvLWstDGrs4/qwtmxCFS9/oBoybDHsvS7Q3VZlIjnzK8SNe/kd85Y7h
 5sjWDiT0HWn3xfgbvEla9x8LYeUC+Px4JYn1AUXD1feUVvHEJ2QpOU4eRga6i7uHa1LEALsUDn4
 pOTln2SW0noaqrLPLWwWMdOKxyw8Jk1yykKG8yktgwIllpPz/S2zRvHbqVneI8kZwtDd93bkBLN
 OLLlgFsslr5/SGa4+bQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfX8bnxZywul5JY
 lOhyQNX8JCyN1rnMw+0vgkmSmXjZ++SdJ146lLhQAiMehdSmCFwLytJAGXZ7QBWb+z2jXz7HJBI
 LKTSD6zu/ozdg7Ex+6SzBOamy7H6hGY=
X-Proofpoint-GUID: W3Bo7U4bqIO60cVwoMNUgKW5pxm9Ev1z
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6ae8a944 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=ZzkvHX01JtsPVOcVQ-8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020060

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
 drivers/s390/crypto/vfio_ap_migration.c | 84 ++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index b64ce092a41b..526d83e8590d 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -13,6 +13,16 @@
 #define VFIO_AP_MIG_MAGIC			0x76666170U  /* "vfap" */
 #define VFIO_AP_MIG_VERSION			1U
 
+/* The maximum number of queues that can be installed in an s390 system */
+#define MAX_AP_QUEUES				(AP_DEVICES * AP_DOMAINS)
+
+/* The maximum size of a vfio_ap_config blob, used to pre-allocate the receive
+ * buffer on the destination host during the RESUMING phase of migration.
+ */
+#define VFIO_AP_CONFIG_MAX_SIZE \
+	(sizeof(struct vfio_ap_config) + \
+	 MAX_AP_QUEUES * sizeof(struct vfio_ap_queue_info))
+
 /**
  * struct vfio_ap_migration_file:
  *
@@ -456,6 +466,67 @@ static struct file *vfio_ap_open_file_stream(struct vfio_ap_migration_file *mig_
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
+/**
+ * vfio_ap_resuming_init
+ *
+ * Initializes the ap_config, config_sz and filp fields of a
+ * struct vfio_ap_migration_file instance:
+ *
+ * 1. Pre-allocates the maximum possible receive buffer using kvzalloc so that
+ *    vfio_ap_resuming_write() can copy directly into it without needing
+ *    to know num_queues up front.  kvzalloc falls back to vmalloc for
+ *    large allocations rather than failing a high-order kmalloc.
+ * 2. Sets num_queues to MAX_AP_QUEUES immediately after allocation so
+ *    that the __counted_by(num_queues) annotation on qinfo[] covers
+ *    the full pre-allocated buffer. Without this, fortified memcpy()
+ *    computes object size from num_queues == 0 and will fortify_panic()
+ *    on the first write chunk that reaches into qinfo[].  num_queues
+ *    will be overwritten with the correct value when the source guest's
+ *    AP configuration data is received via vfio_ap_resuming_write().
+ *
+ * @mig_file:	pointer to object that maintains the state of the migration
+ *		data stream.
+ */
+static struct file *vfio_ap_resuming_init(struct vfio_ap_migration_file *mig_file)
+{
+	struct vfio_ap_config *ap_config;
+	struct file *filp;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	ap_config = kvzalloc(VFIO_AP_CONFIG_MAX_SIZE, GFP_KERNEL_ACCOUNT);
+	if (!ap_config)
+		return ERR_PTR(-ENOMEM);
+
+	ap_config->num_queues = MAX_AP_QUEUES;
+
+	filp = vfio_ap_open_file_stream(mig_file, &vfio_ap_resume_fops, O_WRONLY);
+
+	if (IS_ERR(filp)) {
+		kvfree(ap_config);
+		return filp;
+	}
+
+	mig_file->ap_config = ap_config;
+	mig_file->config_sz = VFIO_AP_CONFIG_MAX_SIZE;
+	mig_file->filp = filp;
+
+	return filp;
+}
+
 static struct file *
 vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 			    enum vfio_device_mig_state new_state)
@@ -488,10 +559,19 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
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
+		struct file *filp = vfio_ap_resuming_init(&mig_data->resuming_mig_file);
+
+		if (IS_ERR(filp))
+			return ERR_CAST(filp);
+
+		return filp;
 	}
 
 	if ((cur_state == VFIO_DEVICE_STATE_RESUMING &&
-- 
2.53.0


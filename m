Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425009;
	b=PwidFEvhFwqU4MijJIpotYLuJ/61Gp+0nIi9nf0IEegMI6E9QK9oPG0fYkv+EmPrEJ5a
	 Fvax4bqhvZY/ahAsvR9RmuMPoovAruQyMUNdC/La5uDgFuNNXkpFtdSJrNZ3DiggmIrBl
	 SALDIFLjcpEanO2kPTciviYFkcTQx+o/uvBT9C0cLYC8IYoXGZHKPidBVIAwceYQMrT8z
	 TcTdPKzRYYG/fgpDPfC1w6lJnF6YWYpyzKj3PlcGW3FC41OFtFs1ENJxZF45PI5EuTRO3
	 6fPz6POphiZ1gQwlIR49c4gMgjsgdarGm/E11/WXtSv6fqc8jXwTmE5aE5SNMg3gAXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425009;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=eLpNFQCUc7D121Te6ac7Uy2XjtzUiLQvFrnf/uPMwjU=;
	b=wyMnl58URICUD3BI5gDcx2Az35+uZSARmdY5VdtWutfW5hYe2rmoJSBjBLQip8pXGNgl
	 8VV9G1JOOtTo4hV++31wR6WU2fGP3pPLG0Px9SFqQgfsff5z59YLs8m1jcab2Ad3AKVLB
	 RGiJdrUuuXDQRWSrQSlVZ81nc7dbpXvwbDCYGSB2bMVUq5uf/jNgEZV5thgp0IAeBioDp
	 jX0Qe7Cc+m1kPbnKo99SUtmrNkOKRI+csOdlUwfaS3V3b4iZ9boqo5e1Crg5t1fEHDMVo
	 jwtsxdZn/vRYXhna2DEtge0yXVXM1hjZgKY8NVxuvURBBRAk6vSFChbaQh0rIeKfF5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="EmefP/pQ";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF0B60A3828;
	Wed, 11 Nov 2026 19:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DF0B60A3828
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EmefP/pQ
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIiOOS1892522;
	Wed, 11 Nov 2026 19:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eLpNFQCUc7D121Te6
	ac7Uy2XjtzUiLQvFrnf/uPMwjU=; b=EmefP/pQ8v2m/gCbGmPHCmn3FZ/DjDNJ2
	6aqzoYqyH8njWxTxV4rEwwuodgsHsVEAIQCWA8y8zgEVsxD5BoGgrsFXYS8jMnUR
	HrawCEwdO9DqXpJzIBO0WT3xOp9faNpx2magLP4LiHQ068tEk3hyZmmeSt3tOPi7
	E6KuUUIiDUoDykTXsrKJtHz5BY5XORE5iBuIFP434tnEssrHq0X0f3tq5aaFb58c
	gQJSjJSsRXXXN1NWXIFP1BDWP54gy1r9m1Iu6/3fEv3BaNXtttZ4VRYuscgfT7a1
	wFNoDr59CDxSyjFQ+VeoWU91eT2uqMx0IsLeyGZSKUiLbmfcb2cCQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumv32sk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIZ7aV2621325;
	Wed, 11 Nov 2026 19:23:21 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hvd51ugx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:21 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABJNJ538979010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 19:23:19 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41FAE58068;
	Wed, 11 Nov 2026 19:23:19 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4549858056;
	Wed, 11 Nov 2026 19:23:18 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.62])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 19:23:18 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v13 08/14] s390/vfio-ap: Transition device migration state from STOP to RESUMING
Date: Wed, 11 Nov 2026 14:23:02 -0500
Message-ID: <20261111192308.2585984-9-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfXyZpaRtHcg1I/
 LZC7ciQhYXK1dajfBOuE7Uta7WzKS5ouuKKXrgz8XTEz+m939SVcc3oIvmx9BjotCA3F/6TO2Pu
 3ot4PMx4eg2VsJEBHy2WJFktgRzozJg=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af4c0a9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=ZzkvHX01JtsPVOcVQ-8A:9
X-Proofpoint-GUID: u6ydKSpH6g23K3wqJ3kZVfHwxsRpyYyi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfX/GEM9jN/9dza
 XpDqwRE+Tk/cMKIE0fJs6K34o4fJj2vb/+XRvIqpNTNTgnjqW1d7vGsP4ldMjxfqVkyHAA1HtEW
 6I8WnDYeV/B/r8QzsatuJrtApYM9y/XWrJ8vBccdndKiryD5W9kddPnXWoJ3X7tGQOS0hzHlmjV
 SZxC5+ULuGRggPdMHtEkm+5sGtj9DzKk4o9Ep3ROriW08Ug46clDe/dgSW/W7HPNubP7pgePRkw
 hFzSjKMdviqeiO3B4yYUjIE0LksGay9UpqY+EcfhMNVAWH7YULPJF455KxyJ8FMawWvA8c7/YKD
 80tvc4xYBB6UmsNBLFHNfW6l/2BcWwLGHTqkEkj2I7TxN8w5UBtNt9D6wxkfVFFc24P1aqcnHX2
 oTuYOEVaDce+CCVvGqay+gxKpWLe3+yBVmUtA1qCr2funk0Wo2JTg/FueTdVEv+Dvalm2cjs+3C
 zdO8KjAHTwjaV55vlDA==
X-Proofpoint-ORIG-GUID: u6ydKSpH6g23K3wqJ3kZVfHwxsRpyYyi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110076

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
 drivers/s390/crypto/vfio_ap_migration.c | 74 ++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index dc1d951a8479..99062dcee01e 100644
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
@@ -456,6 +466,57 @@ static struct file *vfio_ap_open_file_stream(struct vfio_ap_migration_file *mig_
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
+ * struct vfio_ap_migration_file instance. Pre-allocates the maximum possible
+ * receive buffer using kvzalloc so that vfio_ap_resuming_write() can copy
+ * directly into it without needing to know num_queues up front. kvzalloc falls
+ * back to vmalloc for large allocations rather than failing a high-order
+ * kmalloc.
+ *
+ * @mig_file:	pointer to object that maintains the state of the migration
+ *		data stream.
+ */
+static struct file *vfio_ap_resuming_init(struct vfio_ap_migration_file *mig_file)
+{
+	void *ap_config;
+	struct file *filp;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	ap_config = kvzalloc(VFIO_AP_CONFIG_MAX_SIZE, GFP_KERNEL_ACCOUNT);
+	if (!ap_config)
+		return ERR_PTR(-ENOMEM);
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
@@ -488,10 +549,19 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
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


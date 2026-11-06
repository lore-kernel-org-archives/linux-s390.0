Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978607;
	b=4oSX/5jLbvurcANala/9GOrFAJ/1Z7AQo4zgouFb5L3PjaJB1KbAaFQqRTnh2P78xUAH
	 sYTHS8RuH15IAAz8Fr0GUs2NriHZ7UEilr8snYixHcMWR9lXM8TzBmjeBYgot/GoHYf3p
	 Mw6MTXYxZLg+eHKTMZMqXl15arZUnf3VWtGM9BC2MISNfQw7JFXrMw+toXL4gdQq/+aZ3
	 dtwhi6rsJlrkBtnEbZTIBR5ioxmBnErvnLrioUaf/gWFTQthZ/p5HZ2JOaWT6C2VdC/Y5
	 roT+CsfOZuDUw+AF3EHBsg61EhlPMrYTBcQflBz6j1UwkDAd/G5RoOh1Qrgr6GNMocA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978607;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=eLpNFQCUc7D121Te6ac7Uy2XjtzUiLQvFrnf/uPMwjU=;
	b=bUsB89zh0Mdnloh48ebtkJsu7GgzLPATFm4k6rxvU/KirdgPI7PnX/UEs6jo4wBJ+gpz
	 mZGF5uzW9yXEYR/5obdEOp4IBn4AK5suI4owAE30SBfmj5eu2Xg8+gdJAuZnBcSxwu8yL
	 e3ck33ClrJHIKvx8kJGRkWmeBWfGkWRxI02YJc4bCuST/yTFVrxCDOlX9H8q2aDVp4WLR
	 bShd0qqKo/JhSomkt/buw02nMMHOM6JtPcuMy4BfuqC5gk7HCACBLEolQlSrMjkoZwijZ
	 +C9PQoZq+MyfDbNvewYmkVBorDk0ihrpaHain/gwBncP2nFkwFR53oE+4AddM0ndPIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aumiapeu;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F6606D81C;
	Fri,  6 Nov 2026 15:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA1F6606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aumiapeu
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FE7Oa2935694;
	Fri, 6 Nov 2026 15:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eLpNFQCUc7D121Te6
	ac7Uy2XjtzUiLQvFrnf/uPMwjU=; b=aumiapeutajkkMUA8CwEYk2TSqq0iX5wL
	/v3QeFAG2EAAufIrhfcqhekdylkHh6sKncpmcwMR213bUbS3STzewWZNGnl+e0dS
	OdGa6HI/KatW6qLqfAhYThWkRBMf2S7rjeyYHhkoeowIh1iV7A1NVC8TAZ8tx8O0
	wqI8iyQ8c0aYSqTpQqUaL+6rwLXGfSeP0Tj4LRo5pJtErG9oiHw0KO5UFbSF5DI+
	dnSFBXSDe+CJt9UgnmpL0Mhz5iLufLKy2sqCeTXv4ZL+LhqbmBmYVbK9bTcpjaKf
	0W5wshqpTUnrp7Z+IBTVyWKnIESBMJR68lacpFIG5fRJMKBsWLdQQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rcd721-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4xxc3617252;
	Fri, 6 Nov 2026 15:23:18 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrdd7ua1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:18 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6FNHGp40370858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 15:23:17 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21F5158060;
	Fri,  6 Nov 2026 15:23:17 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F17C58055;
	Fri,  6 Nov 2026 15:23:15 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.114.69])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 15:23:15 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v12 08/14] s390/vfio-ap: Transition device migration state from STOP to RESUMING
Date: Fri,  6 Nov 2026 10:22:53 -0500
Message-ID: <20261106152259.1360651-9-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: wcGRv7MjEJ9yrKLljMa_bX91uE7YWX9I
X-Authority-Analysis: v=2.4 cv=A635rKWG c=1 sm=1 tr=0 ts=6aedf0e7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ZzkvHX01JtsPVOcVQ-8A:9
X-Proofpoint-GUID: wcGRv7MjEJ9yrKLljMa_bX91uE7YWX9I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfXxMo0roowkC5o
 BCzOLVrnMDQ5JVSRv/ix7L7UriNFEpgyufZb0SI8o3j0M7oqVA4oNVyCK/Jidne53Yq3IsWnsLO
 v8ChERVontqkQSWnU6sEbpIqsuFSIWG1Qd1XcUz5ImrENfSYJj0lV1LSof/aytoM8Attg6oUn3B
 vnu4E8bSoVMlKPYNMiL5nQzta0Z0kB3Xb+zrxf3BGD3EoBv5caG/LA/TcGimhxTbn2dk+eFNNc2
 qnHSKTcCGdbJInuDphE3sc81K5lZ574Dev3wsmVIZcp+AEAVvdMJ7lPnOMQbxYcLK0zITPP/K5l
 1O4jbEOpHkDetw70H94yk1ciF37wOtq6RB4ctB1No4pWeTSyEAWcBj2+gM3ih7IjYLcdqkFS6bR
 ENMHb6UnqToY8hrIwRpkIqM+FTPgAUIin7bRbHId1KTuVW/twFYYbW248lXkSNi/+CBnJGSETvm
 kkkna47zC4h4ZhGQNZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfXydbPq/09ff+D
 seUXQW2Iigz6B5hH3T6zyiaaO48QfjXbItPK5Gv+8cmir86n0VetoXFjWb57zUDW0kgHYOn1J3X
 FiYYhJ495b+YJ9HhCxrFOO+XLNDT/cU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060060

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


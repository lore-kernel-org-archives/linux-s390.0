Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978600;
	b=n3QVLQ1J2/7ec6G/TfbrL3bnggvZXuppAZMAfcQ7PcOTEggBr7cl3aC9XEG8pPm7di11
	 hUAEeUdGZjcJC31eJHHRPSuUrrvqHib2HAj9AuPDMgIKm3MLCRvxM6i20+0LnWMBioYII
	 WVqiZVailx1QUb9fOcupAzWFcy2w+RqBde9Qv4X6afynaTyjafa1El6htJ95yY3HeEGGM
	 qA8tf1u502VKv7h6wX0yUjdr4X8Pt93MnDlwzxOfHwv/936XN5L8tDAtNCVBC0xl4eNOs
	 9B7qtpNmTRJfqpQ+gOC+hgBQD7IkPEncOEwHlKDu5RKHCnpn3bQHyY76nMFq/JwVj/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978600;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sr63zLlwpXEgfAJgCIgGNL3xTrn0Yob5NkhYwmpMcVo=;
	b=W4ChF2KoOst1AFy1Ff/CUIE8fdEszTXQAgVn2dzBxep/Rw2C4i+uTI3ayUTeUsNCI74n
	 q1Rt2Qg5LMTqxWtCX3acsR3za87dnOvke2zRCf2chR9g4UgvLXiuZ3SILZcxc14IcPWgD
	 9PaUAX9S9NXeT6C8/t0ebnmORA3RdxZRO6F9qanWwg6xYVfK9BvPJeVzsIHyMlXTfqEtC
	 3r6CmD6TKAfPl1jH4peUPHGGh6GEDLQYZLCbkPqwibCCVyOAuztAq8whGv/xTECcfkqEO
	 NJhkYLD2PYuPXgm8x47y7T/Of4ON3g0T97fJODpeVdwF80OtiRDDnEBkhD/BVViwYTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o0j2kL2I;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E34606EE93;
	Fri,  6 Nov 2026 15:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9E34606EE93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o0j2kL2I
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEABo2656338;
	Fri, 6 Nov 2026 15:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sr63zLlwpXEgfAJgC
	IgGNL3xTrn0Yob5NkhYwmpMcVo=; b=o0j2kL2ILKfTsCnhDF3uw0HvKvljof82j
	cyoEe0BkpRbfaDO7ZEjs7z6y586LU3CnQ1MjlSsZJYVquGufVM7cM1GKDfBzJosU
	GcHr7cIp9DdwZzdmGfb4Ah5iaJ8LKsTTNqVS7dfVQbkHws/GmO6lrBDHex8Bhd5q
	dL/ctst9K6+RV+Sp03L/SFez2WZg3vsjM2Fzr8Y4SBEJwdudY/z05x2L4n4Bu/XQ
	9zEtvbFSov5VyA+qBfQASkjVI6Me+bWXsvpeVeVsIuG6QsVTI6ZwTtdKUG8KINO6
	Ov15PSEb4yTrpIpctIC1fFSLPkYxkxvnUM8tc5K3K/+6Jefa98Ndg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rc54cs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FK91k3577944;
	Fri, 6 Nov 2026 15:23:15 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqv1v7wsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:15 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6FNDp910158700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 15:23:14 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73D3E5806D;
	Fri,  6 Nov 2026 15:23:13 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9F8158066;
	Fri,  6 Nov 2026 15:23:11 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.114.69])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 15:23:11 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v12 06/14] s390/vfio-ap: Transition guest migration state from STOP to STOP_COPY
Date: Fri,  6 Nov 2026 10:22:51 -0500
Message-ID: <20261106152259.1360651-7-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfXyWuHbYtIWvgd
 O9SYgrkrNAU8vn02PEgtTjRtlR8ZhuPWWvP4TqTKuEWebzia5AfYCBdCV4McCZ3eSmVDM4RNcwU
 uGnuB8cVLxE8h+LloDESoAvhmnNqa4M=
X-Proofpoint-GUID: ja5hT6hiC1tPENY4ogq-NItYLobJ1bHM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX2XjBVHEQqS5h
 0uBIprvA+fvW1gvJMpafSKflaTaoyEGjbYxbORhhB+1EobreQYVfXqlsUWESRxXNFNT4ek4Cga0
 YntH1Xr2DtBbGAIdVW5KcWsZ+zPeCkUD39T+wk0L/BpQHwcPW1H9O78iVM6NyZZQ8FNueS2MX6b
 fwNHTogpB72AJ/gxyhop6DdUQQAOR4CBaSbSos2jfy8zR5H9nDRYTMtlmbwgM1t4pdVmSJBWbmu
 gTOVMKL8TnsgWK+cbFYtFqTZlHk3SCJNSd7Bx61wttpRWgd0vso5krp612eTotM/lvF4z+Rx6J5
 FFcJE5wgMOzLGKTnUluIWnlfpY65Jk33/E+8RRQLF+Ruv/SAe1y8m126Mf9Y6DoJ3at3iWnuncS
 ym6+42mQ1kQEU4dICUcuj+pOWxES5rGNBwvEc389rR7YfT8vk3NXzPCCq0zc+71mUUD9GWdTROU
 j6enETgHLdmCnqEQACw==
X-Proofpoint-ORIG-GUID: ja5hT6hiC1tPENY4ogq-NItYLobJ1bHM
X-Authority-Analysis: v=2.4 cv=CY+dd7rl c=1 sm=1 tr=0 ts=6aedf0e3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=x8ayjDA-IaEv8FOIkm4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060060

The transition of the guest migration state from VFIO_DEVICE_STATE_STOP to
VFIO_DEVICE_STATE_STOP_COPY begins the process of saving the
vfio device state. The vfio device state is comprised of the guest's
AP configuration which specifies the adapters, domains and control
domains to which the guest will be given access.

To begin the process of saving the vfio device state, the VFIO AP device
driver opens a file stream that will be used to read the source guest's
AP configuration.

Note:
This commit introduces the file operations structure for migration state
files with a stub implementation of the read operation. The complete
implementation is provided in the subsequent commit.

This incremental approach allows for easier review of the migration
infrastructure setup separate from the actual implementation logic.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 74 ++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index df012f80ed0d..3b5c60c1ece5 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -4,6 +4,7 @@
  *
  * Copyright IBM Corp. 2025
  */
+#include <linux/anon_inodes.h>
 #include <linux/file.h>
 #include "vfio_ap_private.h"
 
@@ -143,6 +144,62 @@ static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_dat
 	mig_data->resuming_mig_data_complete = false;
 }
 
+static ssize_t
+vfio_ap_stop_copy_read(struct file *filp, char __user *buf, size_t len,
+		       loff_t *pos)
+{
+	/* TODO */
+	return -EOPNOTSUPP;
+}
+
+static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
+{
+	struct vfio_ap_migration_file *mig_file = filp->private_data;
+
+	/*
+	 * The mig_file (and by extension mig_file->matrix_mdev) is tied to
+	 * migration FD lifetime (see vfio_ap_open_file_stream() function) to
+	 * guarantee that the matrix_mdev remains valid for every read/write
+	 * operation. Let's drop it here since the migration FD is being
+	 * released.
+	 */
+	vfio_device_put_registration(&mig_file->matrix_mdev->vdev);
+	return 0;
+}
+
+static const struct file_operations vfio_ap_stop_copy_fops = {
+	.owner = THIS_MODULE,
+	.read = vfio_ap_stop_copy_read,
+	.release = vfio_ap_release_mig_file,
+};
+
+static struct file *vfio_ap_open_file_stream(struct vfio_ap_migration_file *mig_file,
+					     const struct file_operations *fops,
+					     int flags)
+{
+	struct file *filp;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	/*
+	 * Pin the vfio_device registration so that matrix_mdev cannot be freed
+	 * while the migration FD is still open. The matching put is in
+	 * vfio_ap_release_mig_file().
+	 */
+	if (!vfio_device_try_get_registration(&mig_file->matrix_mdev->vdev))
+		return ERR_PTR(-ENODEV);
+
+	filp = anon_inode_getfile("vfio_ap_mig_file", fops, mig_file, flags);
+	if (IS_ERR(filp)) {
+		vfio_device_put_registration(&mig_file->matrix_mdev->vdev);
+		return filp;
+	}
+
+	stream_open(filp->f_inode, filp);
+
+	return filp;
+}
+
 static struct file *
 vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 			    enum vfio_device_mig_state new_state)
@@ -156,10 +213,23 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 	dev_dbg(matrix_mdev->vdev.dev, "%s: %d -> %d\n", __func__, cur_state,
 		new_state);
 
+	/*
+	 * Begins the process of saving the vfio device state by creating and
+	 * returning a streaming data_fd to be used to read out the internal
+	 * state of the vfio-ap device on the source host.
+	 */
 	if (cur_state == VFIO_DEVICE_STATE_STOP &&
 	    new_state == VFIO_DEVICE_STATE_STOP_COPY) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+		struct vfio_ap_migration_file *mig_file = &mig_data->stop_copy_mig_file;
+		struct file *filp = vfio_ap_open_file_stream(mig_file,
+							     &vfio_ap_stop_copy_fops,
+							     O_RDONLY);
+		if (IS_ERR(filp))
+			return ERR_CAST(filp);
+
+		mig_file->filp = filp;
+
+		return filp;
 	}
 
 	if (cur_state == VFIO_DEVICE_STATE_STOP &&
-- 
2.53.0


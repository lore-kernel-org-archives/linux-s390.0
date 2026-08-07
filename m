Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA2647799B;
	Fri,  7 Aug 2026 22:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141139; cv=none; b=Rvx5I5c+1xewf8w42KZX9h4bjSUMrY4QcYMmWu+ieQwLT3KV/1qWNbxD+k1ktWjZoA4mmKywaMZDUvoSQiXheQUF/TZNGzKnGfn4/+zIHxrBl4gQO3GVsUkCawHXD9gWrpOS7e6u9CpqAzb/G38d08O1l0sBodcsbtf87D6QWAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141139; c=relaxed/simple;
	bh=eWCOMoj0SrDRCyuDdBlmbEpos1juS72Wf7rwrGkG6MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvWn9YH5cB8Uy6p/WrY1l5TYakPv8kXB9P8gzYJKh1Ci6f3/aw06QVFlzSnthQcn/hI8pZ3c6vo9VH3XslnKalxw/MNgO/gaanq7nTPBg2t3EwMqb3LJWAGefOnxb/DBBLXU1ObHU8Bz4qEgnZBpF5AbVTPSf2mAppPyNpHO2Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qzLsaECF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qzLsaECF"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Lloom800348;
	Fri, 7 Aug 2026 22:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Y0ENUZr0/YF/ysfHC
	dPpgD2XIhzHYfO4JYKqgVw/ts0=; b=qzLsaECFyWeJ8XqlKzyHnNcfx6YdYhe24
	taUdwEEBBDf9AEBUqW+lS/sbuxAKFIxVBeLeqpR1w0XaNNIC+Dvwoin+2mZFrBuE
	GOtp2dWo4Ccl9k6w+BTTCiU9XcfGxG3b5oussLQKr498pSjY9YduUtKpmXgBGGQz
	BZxn4dq3AY16IlAzKqAxAVXjMeyq/pVelPeOlElPjO7IMMju0nFVUSJXXyvT0hjt
	RlcRsKsqm3yyfcBsWeALDpH/hLfa+R41osgiSoyIOveQpkhI+X9Rc9QQmvaLCZlI
	Tx6vdYyYAM+1SFoDz4baOP++93MNh0ni3eo7wEATmi+DN8GBpL/ag==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy01p7xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677LuKmg030150;
	Fri, 7 Aug 2026 22:18:45 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgsfs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677MIiIq32965312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 22:18:44 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C39CF58058;
	Fri,  7 Aug 2026 22:18:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C36CF58059;
	Fri,  7 Aug 2026 22:18:43 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.52.19])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 22:18:43 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v7 08/15] s390/vfio-ap: Transition device migration state from STOP to RESUMING
Date: Fri,  7 Aug 2026 18:18:27 -0400
Message-ID: <20260807221834.562851-9-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807221834.562851-1-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IeCr27jsg9u399zJFnGuMiLVahaWIood
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfXwOHMe0QG3MWG
 6FpD2IctqNvjFDMbdOx2ffdW5MPlTfu6jaxgTDdjqeynuUF2SfLFuOG6RxlwKJYU66P3xFfgzW2
 8uBWCzAJThUEZp/Z0i2BO8vAHxJwPvU=
X-Proofpoint-ORIG-GUID: IeCr27jsg9u399zJFnGuMiLVahaWIood
X-Authority-Analysis: v=2.4 cv=afNRWxot c=1 sm=1 tr=0 ts=6a7659c6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=dFtAHy0WI_kTpcb5h7MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX+p/czb9BwPDp
 V6kbVbhsJTh735BhImOFi2bd/xKK2oKKF6iA23qE0Sel6ZYm3omlNP+iiBzgYMr36x5buOju1Hh
 5Ii8EsRzM/ETZtyc95ZBjavkxTZPGh9UkyrS5/ejukhIwbzEzGWffTzMatnHVEB8m7XyMFOA2wK
 3B43hqUF/0tSYq6WEsK/Tjg9lCBgVHc61GV0xG5hzjEINqxcX4e5tfU4T3zWsbzjOjoDBwnsb1H
 cjV2qgehUIJ0EVWcpuX6NoeRrzdiN7lxFUXO/hxWclP930BqtwQK+8tNO3mMTPYBJtxi/gNMSHG
 pKuygwm6Mv8o8q54wluWPLqVZBw32Kc1Oju0zjfWETT8lEFPVdcYtxMPE7HBMYbFYLBWRNcalQ4
 9/INnMXHrjSJxxbaygPdFK2DEkO/Kz8a1qC7Y6AWckzZOnSzXt+rEHTbjL3Vhr1AX98tRHqqxFe
 m1yKwaFCTlGeWVB7Crw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070175

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
 drivers/s390/crypto/vfio_ap_migration.c | 34 +++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 50781b61f7f1..e2e7ae8515e5 100644
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


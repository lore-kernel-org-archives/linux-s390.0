Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AAE400E0B;
	Tue, 30 Jun 2026 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816114; cv=none; b=OluzOnoXAtvzItfD0K5A2meAryCbKq68x0ZbIMKtSqQglpBKy/5zy2aIUgtRwoCwhjQdyVjlcRfOdIj2umMmvOtEvmjFajlpiTGBDeHAPtxAzG8+dDNa9JyvjjGqk+5yBbq1f4W+9GEEYod/x71jeG0CdO5HkxlcnqURENcbONQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816114; c=relaxed/simple;
	bh=z0jNupcFEKpT3KdfOxc7UqYl82ojlNG0cSMAYn+ESVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGHtUwuQ3Wzgj5bHWlm7TSvTpgN9Q4DijgSUO2VAC4T+FSdduxN6pTlmAsISNDEfcszCFt28XMUxhso8rfceDeuF86k0JQ9UE4UI9xaUhBdtWo4rkXFMyjsi9rU4HyNVy9iaKsx8fl+gbggWPp1SyNRrwmtCNO73qdBTCRX4adQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VU+qw1YN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VU+qw1YN"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n4rl1647794;
	Tue, 30 Jun 2026 10:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/08/6h4RLxLYv/K0M
	xYTTLOf2lOuYKUKhYPgeR09y0U=; b=VU+qw1YNaw8MZc85h8McFg6QbGJCe5FEo
	uoxoSffTdBd1TVPwohA5zQTInh0Jmm1IXa9L9JuA8d6ba+WGLcdGauzD80sAjbVk
	vvGAQIaKR4oGwyv2ozA9niLjuUQd7OcwJ/+dVI7h4sphmWaHGzi065kqyvU0IxBZ
	12UXFlFrk144cE3E7xAamPeB2LDL56VniDkT9v1opTWMmhmV/2hNvkmsLz1r7PCS
	o/fnCn3Atl+7dVSM5rT4zna6vXrrwbMX9F7cTwBZdlMZ13mWKZDSovFhzCIydq1R
	TliH011Eoi5nGAJzBW1LgZX4GPxFl1WesL+DftRsTzd6LHMrmzAcw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5p6tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UAYpCs031991;
	Tue, 30 Jun 2026 10:41:44 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2suk1qe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UAfhvC31457798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 10:41:43 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53C215805D;
	Tue, 30 Jun 2026 10:41:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 519A258052;
	Tue, 30 Jun 2026 10:41:42 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.135.84])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 10:41:42 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v3 08/15] s390/vfio-ap: Transition device migration state from STOP to RESUMING
Date: Tue, 30 Jun 2026 06:41:18 -0400
Message-ID: <20260630104132.1598851-9-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfXy/XkoYcjEu/Q
 MpCjRQAwFBygK9cvkIiD37v0lr0YcTR3ZbREEyHItIn/7+2pFATfiqF2SXTSw5QcOvLrXXxVDb0
 p9VETWVUZId+BLLaB5+mWmZrw/eWn+YlXsnGxYm3dL6hgVeC2Vtsw00BN6B7JKjecRApODXi6G6
 PfEzyLHiFn7EEC12EOKPGddvP598CYTFv6pEM9NBC4Setw8AB3eR3NuDWlMmt6sZYRc1d/2+fPS
 xzoylQmn08m5INhp60P2/F+QNMzMW1EAzsLMEa7hot+rYat4ymn+2fwDT8WFllEioH1/pMcj5va
 39gbTUTQUZlswQR8ymbgjAmbOZ0KPxe595sDBa8M5IMoPouR3wBbBS2squhdSPhrVv3x5ZCKBJa
 zEPrS6aJ5xNstsW5RecIFsYUPDu+NfKaITdo6qjlNeFNgG3LQuiakYck1/idCB1DXgZqYXK48FQ
 DcWp4/UrIi31kgIpxBg==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a439d69 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=tR-Paw13gH0jRigdlV0A:9
X-Proofpoint-ORIG-GUID: 9WEZqluCCNsWJ2RzedO8qXy1qFGinx2D
X-Proofpoint-GUID: 9WEZqluCCNsWJ2RzedO8qXy1qFGinx2D
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfXw9HHdz1uegdS
 ImeVYz71rj578tZTIm8fHdNdpGaUS+HHvocRD5BRArIZHn/pkr7dBVaWgHDgDlCg59Ki8BU0C+X
 swykUBb3b+P1LBadenIe6RS9T75Xj9c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300093

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
 drivers/s390/crypto/vfio_ap_migration.c | 54 ++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 5ef7127b697a..e917cc995d35 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -65,6 +65,17 @@ vfio_ap_release_stop_copy_file(struct vfio_ap_migration_data *mig_data)
 		mig_data->stop_copy_mig_file = NULL;
 }
 
+static void
+vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_data)
+{
+	if (mig_data->resuming_mig_state.filp)
+		mig_data->resuming_mig_state.filp = NULL;
+
+	kfree(mig_data->resuming_mig_state.ap_config);
+	mig_data->resuming_mig_state.ap_config = NULL;
+	mig_data->resuming_mig_state.config_sz = 0;
+}
+
 static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
 {
 	struct ap_matrix_mdev *matrix_mdev = filp->private_data;
@@ -74,6 +85,8 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
 
 	if (filp == matrix_mdev->mig_data->stop_copy_mig_file)
 		vfio_ap_release_stop_copy_file(matrix_mdev->mig_data);
+	else if (filp == matrix_mdev->mig_data->resuming_mig_state.filp)
+		vfio_ap_release_resuming_file(matrix_mdev->mig_data);
 	else
 		return -ENOENT;
 
@@ -311,6 +324,32 @@ static struct file *vfio_ap_open_file_stream(struct ap_matrix_mdev *matrix_mdev,
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
@@ -342,10 +381,21 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
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
+		mig_data->resuming_mig_state.filp = filp;
+
+		return filp;
 	}
 
 	if ((cur_state == VFIO_DEVICE_STATE_RESUMING &&
-- 
2.53.0


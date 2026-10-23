Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777448;
	b=poRg21G9GnokpH0caRomy5LTUxAhkWh2r2Lb8y1HY9PL86yl6E3EEdeanb969L1P8NpZ
	 6M8syhjuVE6Vc03tSCsfIldBHQMNSNNril2gPiHb1QUbFY4Nv7w/YTipefLqtRHyOkPty
	 UlKD9jInO2r3QFD0QaOo0ocN/1dwp1PCY7pXtkCpd5jizlgsTOaUpARUN74Bj59FirI8D
	 85BrumR1npjBaW4QuRNHlTg44WEvfxpYtwb0qpe5FEESp7imkhb2nx6Jp+HQ0RbuY3/Hp
	 WHd6Vf8HOK8W4DSufB8Nq67B5NImYCN2NpL/gQDt2YObUypX4dR9intKe6b6rf07/eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777448;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/ToWBIZfmzR4GXaVwU76viyXyle+CL9eITfkrYOaQSQ=;
	b=CH34I9g3yZQCGe7qD7KqrlFUB2QrBH9VoJzmEFha0aQLr5ohWi2jiaKgv5Xu3I7H9Pl9
	 p7ReeHi7KngQF9JX1XeJbE1EHpHwADMlPedgr5mbrdlpNgJvvuNj4sYN3iUXrRHDlKoqS
	 EEXHRKtaPVLmfpz9fZEbbQtdphA8QjsObEd42xWOFRXUi33AlfTILlpFy6slSS1GjVAgP
	 Z0FsQwEWlRlSQB1IxNUGfY+ijLW5bsDJqX4Be0kd1vu2G5AR5UFyrkw+fIl+IxQl9TvNl
	 PodalEpmwdrsm2/n2E4dqn95fGGbFBFecpkZluDmvROXncRxhI4Bj3o1sCvhDoFe5XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a2elVJsz;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFC6606A337;
	Fri, 23 Oct 2026 17:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFFC6606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a2elVJsz
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NGob4m2414191;
	Fri, 23 Oct 2026 17:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/ToWBIZfmzR4GXaVw
	U76viyXyle+CL9eITfkrYOaQSQ=; b=a2elVJszwaSyK3Ony2ulry5HDfMnOQ5FC
	E4b+HmpcvNzVwJ8Kb78xbsWEBNxeYugThPouxABbXOkRpGqTDgcPohGWIbTGp0M4
	0hddkRyy8pHVT+LmiJTrHqtxdasuW3LfjX9pgXqMcKWzGeC4yEeGojrQ/R2kn6mm
	BLlJIDmuyir+yJIyWJHgKfMjkBlcPV96yxcDMxh0mVfZMFlS4kWGUfOmZAYK2cSd
	XGgHwvFB3K0fZx3yozi0FR/hFs3aENsNbeDmEZFMN1Zb3kIQaD9gNgfe6iB5WGGT
	Hth74K+UAr7np4jYzm1N0LuhVvekVMrZRY3N7M9gYUEZVL/MdHDww==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58nx45-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:44:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE66K12220968;
	Fri, 23 Oct 2026 17:44:02 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfj1x6a2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:44:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NHi0sA62325172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 17:44:00 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E94258054;
	Fri, 23 Oct 2026 17:44:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C075F5805C;
	Fri, 23 Oct 2026 17:43:58 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.48.60])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 17:43:58 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v10 05/15] s390/vfio-ap: Callback to get/set vfio device mig state during guest migration
Date: Fri, 23 Oct 2026 13:43:39 -0400
Message-ID: <20261023174349.3545941-6-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX/rl1sWAP8NMU
 GsM6vKiyBTHMC13wv7mNGKSNEMo2U3XI18Gd5DxFKrLWv/3KCLMiapfnhiOi1U6bdNNLKkLwNJz
 1r8PBI/7F4ucCi9RJpXHXGHNPSwDf0U=
X-Proofpoint-GUID: B3AImsPI783hPNB-evZql_6lQ4NRv89E
X-Proofpoint-ORIG-GUID: B3AImsPI783hPNB-evZql_6lQ4NRv89E
X-Authority-Analysis: v=2.4 cv=UOBIjyfy c=1 sm=1 tr=0 ts=6adb9ce2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=34fSTTD2jMTnGACibWkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX/DkaKWDCzjay
 fWQK+u4FWxlQiEuwGPhhM2EbBzxPJh6o/Sm+02GxnJ+Jtl+6jBoBHdx0cTpDtp2d98QVtcJnnRF
 JEshmJ5+Ba/U4AMskuzYLjOxHcYZtR9YxXzz1fOb4MytodSwqIf7QjziTFtmyxw+Fg65y7aXvrV
 wfbxhynrjsqupQaHWWbKn2R9fN4DjQkH9ltdAoo6/neu1/IejyOQ81dQ9mkwa5TQXxGA+1X4XRE
 IwVwm6ya9H1fXlvWDlyY7X4bZZ5PeXBSkzanxTTh4EbThUlCFBqhkiHaJg2cRnNzH817pQK/4yC
 oav1kQp0NUaAIDFAfCc74YflBJM+x3Vke42wPrTnCc6LYn+6Y6tGG5X5XD3TkhBr8egcZdg5geW
 N9raFlAn9Yr5yvJwhdSTeQ0yh5lJr4Vv3vPzidhHGUSN1fw/SttQDcc2OFEYSuQSSQDUnEb9iHR
 f4UIzOFvOXVENS3PF/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230069

Implements two callbacks related to the current state of a vfio-ap device:
* The callback that sets a new migration state of a vfio-ap device during
  live migration of guests with pass-through access to AP devices. This
  callback is mandatory for VFIO_DEVICE_FEATURE_MIGRATION support.

  The function pointer for this callback is specified via the
  'migration_set_state' field of the 'vfio_migration_ops' structure
  which is stored with the VFIO device when the 'vfio_device'
  structure representing the mediated device is initialized.

* The callback that returns the current vfio device migration state during
  live migration of guests with pass-through access to AP devices.

  The function pointer for this callback is specified via the
  'migration_get_state' field of the 'vfio_migration_ops' structure
  which is stored with the VFIO device when the 'vfio_device'
  structure representing the mediated device is initialized.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 144 ++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 5d898be0d058..07a4b5c1d6dd 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -139,6 +139,150 @@ static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_dat
 	mig_data->resuming_mig_data_complete = false;
 }
 
+static struct file *
+vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
+			    enum vfio_device_mig_state new_state)
+{
+	struct vfio_ap_migration_data *mig_data;
+	enum vfio_device_mig_state cur_state;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+	mig_data = matrix_mdev->mig_data;
+	cur_state = mig_data->mig_state;
+	dev_dbg(matrix_mdev->vdev.dev, "%s: %d -> %d\n", __func__, cur_state,
+		new_state);
+
+	if (cur_state == VFIO_DEVICE_STATE_STOP &&
+	    new_state == VFIO_DEVICE_STATE_STOP_COPY) {
+		/* TODO */
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if (cur_state == VFIO_DEVICE_STATE_STOP &&
+	    new_state == VFIO_DEVICE_STATE_RESUMING) {
+		/* TODO */
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if ((cur_state == VFIO_DEVICE_STATE_RESUMING &&
+	     new_state == VFIO_DEVICE_STATE_STOP) ||
+	    (cur_state == VFIO_DEVICE_STATE_STOP_COPY &&
+	     new_state == VFIO_DEVICE_STATE_STOP)) {
+		/* TODO */
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if ((cur_state == VFIO_DEVICE_STATE_STOP &&
+	     new_state == VFIO_DEVICE_STATE_RUNNING) ||
+	    (cur_state == VFIO_DEVICE_STATE_RUNNING &&
+	     new_state == VFIO_DEVICE_STATE_STOP)) {
+		/* TODO */
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	/* vfio_mig_get_next_state() does not use arcs other than the above */
+	WARN_ON(true);
+
+	return ERR_PTR(-EINVAL);
+}
+
+static struct file *vfio_ap_set_state(struct vfio_device *vdev,
+				      enum vfio_device_mig_state  new_state)
+{
+	int ret;
+	struct file *filp = NULL;
+	struct ap_matrix_mdev *matrix_mdev;
+	enum vfio_device_mig_state next_state;
+	struct vfio_ap_migration_data *mig_data;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+
+	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
+	mig_data = matrix_mdev->mig_data;
+
+	/*
+	 * The mig_data pointer is set in the vfio_ap_init_migration_data
+	 * function which is called when the vfio-ap device fd is opened.
+	 * Since the implicit pre-open state is RUNNING, a request to set
+	 * RUNNING is a no-op. Any other state transition is invalid before
+	 * open_device.
+	 */
+	if (!mig_data) {
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		if (new_state == VFIO_DEVICE_STATE_RUNNING)
+			return NULL;
+		return ERR_PTR(-ENODEV);
+	}
+
+	dev_dbg(vdev->dev, "%s -> %d\n", __func__, new_state);
+
+	while (mig_data->mig_state != new_state) {
+		ret = vfio_mig_get_next_state(vdev, mig_data->mig_state,
+					      new_state, &next_state);
+		if (ret) {
+			filp = ERR_PTR(ret);
+			break;
+		}
+
+		filp = vfio_ap_transition_to_state(matrix_mdev, next_state);
+		if (IS_ERR(filp))
+			break;
+
+		mig_data->mig_state = next_state;
+
+		if (WARN_ON(filp && new_state != next_state)) {
+			fput(filp);
+			filp = ERR_PTR(-EINVAL);
+			break;
+		}
+	}
+
+	if (mig_data->mig_state == VFIO_DEVICE_STATE_ERROR)
+		filp = ERR_PTR(-EIO);
+
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	return filp;
+}
+
+static int vfio_ap_get_state(struct vfio_device *vdev,
+			     enum vfio_device_mig_state  *current_state)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+	struct vfio_ap_migration_data *mig_data;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+
+	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
+	mig_data =  matrix_mdev->mig_data;
+
+	/*
+	 * The mig_data pointer is set in the vfio_ap_init_migration_data
+	 * function which is called when the vfio-ap device fd is opened.
+	 * If mig_data is NULL, report RUNNING as the implicit pre-open state
+	 * so userspace doesn't need to perform any state transition before the
+	 * device becomes active.
+	 */
+	*current_state = (mig_data) ? mig_data->mig_state :
+				      VFIO_DEVICE_STATE_RUNNING;
+
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	return 0;
+}
+
+static int vfio_ap_get_data_size(struct vfio_device *vdev,
+				 unsigned long *stop_copy_length)
+{
+	return -EOPNOTSUPP;
+}
+
+static const struct vfio_migration_ops vfio_ap_migration_ops = {
+	.migration_set_state = vfio_ap_set_state,
+	.migration_get_state = vfio_ap_get_state,
+	.migration_get_data_size = vfio_ap_get_data_size,
+};
+
 /**
  * vfio_ap_init_migration_data - initialize migration data and functions
  *
-- 
2.53.0


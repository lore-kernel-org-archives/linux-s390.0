Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6D851EE17;
	Tue, 29 Sep 2026 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684334; cv=none; b=saASDhEtzRGHDU2GF8gdrZT88dGYJhjKtcNs6pSlqmHusVXo4Iil5BSJFIsAP/lm3PSLMzTBpFoPbYge/6ZY2wd7Cu9xVAIhhs9bIQb4/1JloqRgsIe6ZleeUKg3SY4dyL/onz4eFTCMOQ6uWTEiFbHsmLNgzNYFrSc5fZ3oTVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684334; c=relaxed/simple;
	bh=lqfka2eK2Tt83UbVyLG5Aa/H7Uj8rNCI1rwrULl+tfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGBBpOZTsrzXY4Kd4+HaLCOqsBX8T/u6v8gV4V2D+lQIPuuUGgd7YZNE6OPC7Hdt3EF2EEWqaD7AthIjrv+wcT2QP6Pe109TbW5/5YoljvixXrXRvrHASyKYRd+iH33jC042L+luQnGjHH54SILLVHTHsnJzgrfL2gffaOEu3wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mRjHtjnL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mRjHtjnL"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5YoX4060120;
	Tue, 29 Sep 2026 12:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hPeXGT9JUJG/Rgrzq
	MRVuq0iSW8u2RzU7AL4HK2w7lY=; b=mRjHtjnL9VbKyZV4V7tJ2iv8WhHwEGDuM
	4WzhSlyX4t5vAkyQ/42NNylpePOgzBrEQqp9xp+kDq3iD4PD3bSMkxq+5e5lgabY
	U7p7AojcE+Pjm6HlL3Cjt5EelbUJo8or6gdJQptascHSO4G0ZGh4dXbek9TaUeyf
	H6KJj1mpiMDn8Uk1JhzFt7N6hXfAlmwwgGCnX7hlzrmXwgWMkCXhUVOPaqrjz16l
	EsIWkRiXz7l0TSB2KyL05mHAq2MxgGntAFPJ6vsga30owPkHuMB0d2+xq/z8eaxJ
	VZxxA/4UHI1C0eELGsyq1Sny9ha/uxHB29A0TpXAR9/9E811j74Tw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j570d2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 12:18:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAlZFJ1617033;
	Tue, 29 Sep 2026 12:18:43 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrw9raa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 12:18:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TCIge112911332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 12:18:42 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 809F058065;
	Tue, 29 Sep 2026 12:18:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 414E358052;
	Tue, 29 Sep 2026 12:18:41 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.24.130])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 12:18:41 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, freude@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v9 2/6] s390/vfio-ap: Fix failure to release IRQ notification eventfd contexts
Date: Tue, 29 Sep 2026 08:18:33 -0400
Message-ID: <20260929121837.2715710-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929121837.2715710-1-akrowiak@linux.ibm.com>
References: <20260929121837.2715710-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfXx6RhBjHizUmG
 gnl9xhs02lDK8ySR9F16kgbx2h5RjM0jDK8QH/fUYItpsGO2dAGZ1H5Kag2Dhxc0V0howhJIfL+
 eey77HiOnkVF7FMVFNDmBsg/+bLbvWM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfXzUUyLreY0l5H
 0CQ6bMpGGwQrS1i59DjnU8MPe8sVuGooP7Be4WKjTcascV9ei8br76LuVZjM5VdRyGEA31xmgi4
 K0WEKTkbSAGsEkvDp1V2ox8bK8PPI6YcFD8IdJIlY7ROV2hEa82JhvNFs6XuDCQu02T9A8bb6o1
 4uilJnJQGH3vQxtj97JdzFIB8rX34em28Ite8/gp1Cne7TYfiNLeomqRZXw3i8dvhWmkgy6qmtE
 T3Wl5GMlVg5W3/5lvrBsvXVANPupytGdPw7/Rb1fplX9Xo9Y/htRcinPs//T9/BFyfb9nNq0flA
 SasBPl/i5NULv84mt4YdH/FGJ0LXRWkunXxVz0lhkUC3IxrEgclCZpnqG1AmW0pv0n02J3XEtRj
 DPe0YNg1eIEzrUfLIrPAFdAnQWboHbJoR8/02dc6YRnovKyYDqNVbNF/p7EAMBbafQ3nooWAOSG
 EuLeEPRUrUKrABzgYTQ==
X-Proofpoint-GUID: cOS3DUb4NLfkdrnhOB-lEQEvsgJWGrfV
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abbaca4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=fxeDLeT5AZ2qCvnLJ4gA:9
X-Proofpoint-ORIG-GUID: cOS3DUb4NLfkdrnhOB-lEQEvsgJWGrfV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290048

When userspace registers IRQ notification eventfds via the
VFIO_DEVICE_SET_IRQS ioctl, vfio_ap_set_request_irq() and
vfio_ap_set_cfg_change_irq() each call eventfd_ctx_fdget(), which
takes a reference on the eventfd_ctx and stores it in
matrix_mdev->req_trigger and matrix_mdev->cfg_chg_trigger
respectively.

These references are dropped only when userspace explicitly replaces
or clears them via a subsequent SET_IRQS call.  If the device is
closed without that explicit teardown - because the guest exits,
the VM process crashes, or the device file is simply closed -
neither vfio_ap_mdev_close_device() nor the remove path releases
these references.  The eventfd_ctx backing objects and their
associated file references therefore leak for the lifetime of the
kernel.

Fix this by introducing vfio_ap_mdev_release_eventfds() and calling
it from vfio_ap_mdev_close_device() after vfio_ap_mdev_unset_kvm().
The VFIO core guarantees that close_device is called before
vfio_unregister_group_dev() returns in the remove path, so fixing
close_device is sufficient to cover both teardown paths.

Note:
~~~~
The matrix_dev->mdevs lock must be held during the call to
vfio_ap_mdev_release_eventfds(). There is a small window between the calls
to vfio_ap_mdev_unset_kvm() which gets and releases the update locks
and the acquisition of the matrix_dev->mdevs_lock mutex during which
it is possible - although highly unlikely during normal operation - whereby
a concurrent SET_IRQS call can get in.

Taking matrix_dev->mdevs_lock around vfio_ap_mdev_release_eventfds()
is sufficient to make this race-free. The SET_IRQS ioctl path writes
req_trigger and cfg_chg_trigger only from vfio_ap_mdev_ioctl(), which
holds mdevs_lock for its entire duration and always calls
eventfd_ctx_put() on the previous value before storing the new one.

Any number of concurrent SET_IRQS calls during the window between
vfio_ap_mdev_unset_kvm() and the acquisition of mdevs_lock are
therefore safe: each ioctl invocation puts the reference it found and
installs a new one, leaving exactly one live reference in the field
when it releases the lock. When release_eventfds subsequently acquires
mdevs_lock it finds that single surviving reference and puts it.
Conversely, a SET_IRQS call that loses the race and blocks on
mdevs_lock will find the field NULL after release_eventfds finishes,
take ownership of the reference it just created, and install it into a
field that will never be read again - a transient leak. To close that
final case, callers must ensure no new SET_IRQS ioctls can be issued
after close_device() is called, which the VFIO core guarantees by
releasing the device file before invoking close_device().

Fixes: bf48961f6f48e ("s390/vfio-ap: realize the VFIO_DEVICE_SET_IRQS ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index e178b657faa8..087e8474a34a 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2337,12 +2337,28 @@ static int vfio_ap_mdev_open_device(struct vfio_device *vdev)
 	return vfio_ap_mdev_set_kvm(matrix_mdev, vdev->kvm);
 }
 
+static void vfio_ap_mdev_release_eventfds(struct ap_matrix_mdev *matrix_mdev)
+{
+	if (matrix_mdev->req_trigger) {
+		eventfd_ctx_put(matrix_mdev->req_trigger);
+		matrix_mdev->req_trigger = NULL;
+	}
+	if (matrix_mdev->cfg_chg_trigger) {
+		eventfd_ctx_put(matrix_mdev->cfg_chg_trigger);
+		matrix_mdev->cfg_chg_trigger = NULL;
+	}
+}
+
 static void vfio_ap_mdev_close_device(struct vfio_device *vdev)
 {
 	struct ap_matrix_mdev *matrix_mdev =
 		container_of(vdev, struct ap_matrix_mdev, vdev);
 
 	vfio_ap_mdev_unset_kvm(matrix_mdev);
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+	vfio_ap_mdev_release_eventfds(matrix_mdev);
+	mutex_unlock(&matrix_dev->mdevs_lock);
 }
 
 static void vfio_ap_mdev_request(struct vfio_device *vdev, unsigned int count)
-- 
2.53.0


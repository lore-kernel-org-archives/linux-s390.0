Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3B94A5C34;
	Mon, 31 Aug 2026 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196500; cv=none; b=qPhOmSUrEHShmDr8RIpxZTdF6VoMmdCamJKmGdezTsT+RyF75glrQ76HuX0YbMO8yHQzTd3/LFa31w2Rz8ZcpIkrdz4sCri8qRjIJH3nZdNXUFWgt+XuNeFRx91lcersie58fcMPOgN0WpXzMhCK+4+uFYQLVXAPnkAtLO+cBFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196500; c=relaxed/simple;
	bh=CiHUV6znCSVFxtuAf32UAWE35DZ8YBHWUWVeFklCWL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTfwmKd8IB1huBgb/YLmLyHpu746k8VTBgeRnjc+pFW/egr1sKhv/tQphanVZQ5I1UBSTmGmKPSLgbZ+5xuumrw5KuOflcA2NsCrL7AfV/lJqQN5BtfzE1sFqvcDGKbMtwt6sm3Jl42hyCE1oC/x2gSWyZKaqg/MBErTQv4nmVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PZ4hCJkA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PZ4hCJkA"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VG1VA42743470;
	Mon, 31 Aug 2026 17:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=x2j/kVZpHF39/YVj4
	EMWXSGYZDF1LuuVNeNL23Xg+dc=; b=PZ4hCJkAGSmXws6X1ITJyEnTf/wBnNA0W
	+u3dZBg3/xpgjcf1tuBLkOki4YnxNS2lduQJDh0zFJqY98VTf2TFjmXRILkWbzu+
	D8HRcR78G6nq+q6jHd8DrVxQfHUzkevgxnUW8B+NQiDeiqIUkOL9qaNX2904mW9k
	GghXHeyzddjBrai9ayiFZxfEjglflMoVbmeyTK3/VjzGRmYz04DhlEEqejmWJMTt
	68FYfrAIJ8eGsWkwMUuUQJl8eV8aQIgP+3EB2EyPhyp3ypGuIHRgFxZPSClNoTY/
	coP853f6AvHImoRFFKjJaRWvjJN/STcQo9/ylXui85vRLh4WcoDfA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54jsdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 17:14:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VHBL14017267;
	Mon, 31 Aug 2026 17:14:50 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gca4vy73q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 17:14:50 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VHEn4e19137140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 17:14:49 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32AB158054;
	Mon, 31 Aug 2026 17:14:49 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 725D55805F;
	Mon, 31 Aug 2026 17:14:47 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.29.117])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 17:14:47 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v5 2/4] s390/vfio-ap: Fix failure to release IRQ notification eventfd contexts
Date: Mon, 31 Aug 2026 13:14:41 -0400
Message-ID: <20260831171443.222225-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831171443.222225-1-akrowiak@linux.ibm.com>
References: <20260831171443.222225-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0NyBTYWx0ZWRfX0uE6PEA86K//
 /CdbIqO972ODhYIPsvDUfIqEETvc/9EnncYeHX+bH6n4QQLf/NcQqVuI5NGakQV40W6Dp6CIz34
 SYWYucXbM0FVHukgq1J1y1SVxbmOduzDEZ/sxSh0oAljmsGXqxDnxu9mjbvkk9zf5gZte99q0v9
 vKDZvAwkopOw/FeERecyguj2PIjQs2IPwvu2tha21VO66oKAFy+W2WX/yecmFYVzqULmpUHW8VI
 eW+w0Pt8axBRTnr9Aj0//5UuZJLixoRuIyTEdaWf6dMm6+xi/9BOYgWOIRWv09R96L3snPUmN8o
 QP/SPQxeGWyPY+ICPn+vmXERCO4UXMniXsZhSTouh50vHExAD2jHpa2zACvgkkY7YEDVGzVaaPM
 VPJ4yZb5y34cxSIZJ7sg5Qf8rXdkLSQzSg+jDf9doypC/70dP7qSFj8Cu0BEs9YiCaOhV67qISr
 viiG1fsxtcnzSW3Q5tA==
X-Proofpoint-ORIG-GUID: HfRZvZuv49WdR9tN1LmmUdLnMMSfk81g
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a95b68b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=fxeDLeT5AZ2qCvnLJ4gA:9
X-Proofpoint-GUID: HfRZvZuv49WdR9tN1LmmUdLnMMSfk81g
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0NyBTYWx0ZWRfX7ZAsMfI4N0y7
 r+n9FtwX2MphpdNS+wG6oLFux7rafgju6h/JfcfcTEo0nDJMqAEX1VwgkDv23ISMKrgBIeUcMxF
 EZ2IKMai0hrXJil2SYHa39Q5qSs+c0E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310147

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
index 8fb0476e3d39..a4980d993b68 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2167,12 +2167,28 @@ static int vfio_ap_mdev_open_device(struct vfio_device *vdev)
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


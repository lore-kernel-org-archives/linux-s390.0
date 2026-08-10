Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B41D44103A;
	Mon, 10 Aug 2026 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389809; cv=none; b=TfdEJYP6gWvS7yC8H9zj1A9MCx05PTvHvkmhVWQK0TGLBpcQe+cTeBSf7gR/ybK6rggDXuZEcKc8/k4IFRU7F5ikpKfmQvGuIYL822ahIEfp+Pm7qC8VmqypqgY8ZMuYvzfkMlM33lOJamR+7gnwzn9Nf6+RF2R+uBFpSuOSN+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389809; c=relaxed/simple;
	bh=imYGgSUs4id0nDvfXxI/LaxrXyfCCqi5Ste57YvTn6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPKKTo4TQh1cq5ciiFkTbeUn8O1i5jsbRujgBW9lD6cE/kNb2ZTqcBCLRf1rsG0N5c/RVzaL6FsYqjYCHxjB+qK8hMg7/SwOaR2jFA+Ndy+Hccb6JXYdZ6OZTVpSmS9qg82shmmdaZ3sbs0osmON5oobJkfubC1VtB0gT9pf9N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MwZz4MbA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MwZz4MbA"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AJ2WKH2433130;
	Mon, 10 Aug 2026 19:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=w2YLaPTpS70OxnwPJ
	/s1uFYb5UUIoitae0C3qdL2X7Q=; b=MwZz4MbANVIU0qtYOcfD1LpYkgJupzYbO
	MaQ97d8j5lnmWyzJL/QIHkxOQ6umhWeY59lAS1YUy1aWLHImqfpHnDSKjOjFN1EK
	hBARbHH5rLnP/4kRfL0fxPN59pKgX7e5ZUhX7deBgFgPTyMbkONihIhlmQJmq/59
	e2uXsYulmPCP1yNucVhxtOaUeC1ELacO0UhSX3tzhQ+pS16QKT0EKwFTfzWAUzZZ
	peXQr8R7boFiqrj9fwedjWEoQNdZ/tj99Jz338FR72TwMQ+oAElzJvxoqwf1vP2Y
	PnrE3kjZ56HEb8udwm5cVeo1CY3+lqU8awUxuFelHX/JLv3KS/8bQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq99q8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:23:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AJC1Ej006166;
	Mon, 10 Aug 2026 19:23:02 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vx869-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:23:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AJMNtk24707716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 19:22:23 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 523A558058;
	Mon, 10 Aug 2026 19:23:01 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BED758057;
	Mon, 10 Aug 2026 19:23:00 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.71.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 19:23:00 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v2 2/8] s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL
Date: Mon, 10 Aug 2026 15:22:51 -0400
Message-ID: <20260810192257.1208410-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gyo82APbNKJXlxie2q4c_x3BfyfUbhLF
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7a2518 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=7-PX2TBNVYp1iSTFOFgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfX+huM75OztS2V
 VwnFxmt5OqoNLcxHLbsed7D5OwjwfRfzIe6fnO4iYxDTZz9X9kKy6JL5zQxuSL61HMWXq9peGS3
 OII09QXHHJkX0/InKMBCl3454IfmyqK8PVjwjyZeq+6Y2GqwKdDSH7wisfbXJ/ox3HKimT2VQuo
 GWL82Ffx+O5P36+0K7APpG4+DTPAxD5tWNGiJbB5MuygM0VajylbnEoBuI4ZufgxPBu7js9RXkK
 76gGpukm2JzpabFZ+5RYtC+U98IG604rfLE8jNZbs/Is8huU6QoEkjzx4NIySQIoaDeaGObjp0B
 kjTPbSbpWU7ifz9uXdgqNFczd6I2mGdh6fy5h/7BU9JcL2fOyxaDUj1zLrxZfqU+ivQkUXK/QTo
 rJ752t18n98UVin4mWf19y4mAPFML+ndr8zy78RwI0YsmrKKv/NQxfeVq+P0j6367XIIFRJQF98
 2em8+UYP8TZ9tn/j3sQ==
X-Proofpoint-ORIG-GUID: gyo82APbNKJXlxie2q4c_x3BfyfUbhLF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfX7aBLhcL8Xu1x
 LpxrUlkIu1l8zKzK6SCT8fqVF0vQkjcpdpTk+lH77ARv34VPqKX76xmHFM7eeEbFGReyrmo87Rs
 gtM/xx5/OS/YFUfltFAScdzmaeaHZKU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100162

The ap_driver structure has two fields which are function pointers to
callbacks:

* .on_config_changed: called at the start of the AP bus scan function to
                      notify the device driver that the host AP
                      configuration has changed and the associated AP
                      devices will be added or removed accordingly. This
                      gives the implementor a chance to evaluate the
                      configuration changes and respond to them before
                      the associated devices are added or removed.

* .on_scan_complete:  Called at the end of the AP bus scan function to
                      notify the device driver that the host AP
                      configuration has changed and the AP devices have
                      been added or removed accordingly. This gives the
                      implementor the opportunity to respond to the
                      changes after the associated devices are added or
                      removed.

These two callbacks are implemented in the vfio_ap device driver via the
vfio_ap_on_cfg_changed and vfio_ap_on_scan_complete functions respectively.

Within the call stack of these two callback functions the
matrix_mdev->kvm->lock mutex is taken without checking whether
matrix_mdev->kvm is NULL or not. If matrix_mdev->kvm has never been set,
trying to take the lock will trigger a NULL pointer dereference. This patch
adds checks for matrix_mdev->kvm == NULL before taking the
matrix_mdev->kvm->lock mutex.

Note that the matrix_mdev->kvm->lock mutex taken in the
vfio_ap_mdev_hot_plug_config function is moved to the calling function
along with the matrix_dev->mdevs_lock which is needed there to access
the fields of the matrix_mdev. It makes little sense to make the change
the check for matrix_mdev->kvm there before taking the kvm->lock
mutex only to have to move it out via another patch, so it is done in
this patch.

It is important to make note of the following:
1. The matrix_dev->guests_lock is acquired at the start of both callback
   functions. This ensures that matrix_mdev will not be removed via the
   vfio_ap_mdev_remove function because it too takes matrix_dev_guests_lock
   before removing the object; so, matrix_mdev will be available for the
   duration of the callback functions.

2. The matrix_dev->mdevs_lock mutex must be taken in order to access
   fields within the matrix_mdev structure

3. matrix_mdev->kvm->lock mutex must be taken before the
   matrix_dev->mdevs_lock to prevent a lockdep splat.

4: The kvm->lock must be held while plugging the guest's AP configuration
   into its SIE state description via the vfio_ap_mdev_update_guest_apcb
   function.

5. The vfio_ap_mdev_update_guest_apcb checks matrix_mdev->kvm to verify it
   is not NULL before doing the hot plug of the guest's AP configuration.

Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 33 ++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 845c86ba8bc3..e382e5a1cb99 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2606,7 +2606,13 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
 	int do_remove;
 
 	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
-		mutex_lock(&matrix_mdev->kvm->lock);
+		/*
+		 * The mdevs_lock must be held to access fields within matrix_mdev,
+		 * and kvm->lock must be taken before mdevs_lock to satisfy the lock
+		 * ordering requirement and prevent a lockdep splat.
+		 */
+		if (matrix_mdev->kvm)
+			mutex_lock(&matrix_mdev->kvm->lock);
 		mutex_lock(&matrix_dev->mdevs_lock);
 
 		do_remove = bitmap_and(aprem, ap_remove,
@@ -2624,7 +2630,8 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
 						    cdrem);
 
 		mutex_unlock(&matrix_dev->mdevs_lock);
-		mutex_unlock(&matrix_mdev->kvm->lock);
+		if (matrix_mdev->kvm)
+			mutex_unlock(&matrix_mdev->kvm->lock);
 	}
 }
 
@@ -2821,9 +2828,6 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug = false;
 
-	mutex_lock(&matrix_mdev->kvm->lock);
-	mutex_lock(&matrix_dev->mdevs_lock);
-
 	filter_adapters = bitmap_intersects(matrix_mdev->matrix.apm,
 					    matrix_mdev->apm_add, AP_DEVICES);
 	filter_domains = bitmap_intersects(matrix_mdev->matrix.aqm,
@@ -2841,9 +2845,6 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 
 	reset_queues_for_apids(matrix_mdev, apm_filtered);
-
-	mutex_unlock(&matrix_dev->mdevs_lock);
-	mutex_unlock(&matrix_mdev->kvm->lock);
 }
 
 void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
@@ -2854,15 +2855,29 @@ void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
 	mutex_lock(&matrix_dev->guests_lock);
 
 	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		/*
+		 * The mdevs_lock must be held to access fields within matrix_mdev,
+		 * and kvm->lock must be taken before mdevs_lock to satisfy the lock
+		 * ordering requirement and prevent a lockdep splat.
+		 */
+		if (matrix_mdev->kvm)
+			mutex_lock(&matrix_mdev->kvm->lock);
+		mutex_lock(&matrix_dev->mdevs_lock);
+
 		if (bitmap_empty(matrix_mdev->apm_add, AP_DEVICES) &&
 		    bitmap_empty(matrix_mdev->aqm_add, AP_DOMAINS) &&
 		    bitmap_empty(matrix_mdev->adm_add, AP_DOMAINS))
-			continue;
+			goto do_unlock;
 
 		vfio_ap_mdev_hot_plug_cfg(matrix_mdev);
 		bitmap_clear(matrix_mdev->apm_add, 0, AP_DEVICES);
 		bitmap_clear(matrix_mdev->aqm_add, 0, AP_DOMAINS);
 		bitmap_clear(matrix_mdev->adm_add, 0, AP_DOMAINS);
+
+do_unlock:
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		if (matrix_mdev->kvm)
+			mutex_unlock(&matrix_mdev->kvm->lock);
 	}
 
 	mutex_unlock(&matrix_dev->guests_lock);
-- 
2.53.0


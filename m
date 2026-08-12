Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80EC43747C;
	Wed, 12 Aug 2026 11:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535518; cv=none; b=KXNTu1j1rhAfZmxLcmxRBl0g3oihn/M2YKxXakBcMmNLoTmDgBogWrBR+pY3JD0gt1WVTflo/4eYAh84eeCSJpDCsV54h8ni3Pw3Kkd0wEiLc321XZrBMlDqyCkno2EmCvG3UvbO8iQHzCxqbDWL9QPSHgKDCp/QB/CbIsQNpmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535518; c=relaxed/simple;
	bh=CTJmbt1Hm9qKIkgof5Goy8p/ON4bw5Ig8no4fCdx1Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HH4YQc4TLTy7TTTPgrQttHnAYwqgCw2VR9+z2gh7+lCqNZgbWrzGYHS4gC50Z4I+q1Z9DEAGlBUekSAPWBC7W0Cx+/wpx3c+NtWVYxPIgkqsHbe3yQTbJu6bCZD4+REhGKfrAsm6JboDZR1jl+bMyz/b8E/GGR38XFWM8odTDz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B0Sq4ojM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B0Sq4ojM"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3XCj3214191;
	Wed, 12 Aug 2026 11:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qJaVMk+sul4rMvzBc
	/DXWNfa1ETKQ+5UxcebhCbYaQU=; b=B0Sq4ojMLmLFfvjH5kJ4l3jhyd7ErSy3T
	rZkC4Zn6Td6P7IIuLiruAwesl/molR4qCIO3Naq/ookGXNhgEcgia3AzbSGDguE4
	R12UbE92FLAIe8lCfh0f3/K+NS4Gh2N3Gw8HyDQ8zRHrRK9zIsZWNpxBATld36kG
	pfS6c8KZC3YKvmp+bpzabTgMHtwW+Vz6HNk3XvHKOnar/oIPwIVwcHLAccvhziOD
	/opkltqz/rlNzAHXwVMxlzu/8y0IceXQItMralC0IJ/oZfwgVWZ/kx1oqPplGsDM
	xzhBznu2R6nWtpi0jHj+H3sMdL+HtPqAIcCR5796Y4vmbvD72QemQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp31e80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:51:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CBfHt5026282;
	Wed, 12 Aug 2026 11:51:49 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq5ytb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:51:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CBpmWB48759286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:51:48 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B1B75805F;
	Wed, 12 Aug 2026 11:51:48 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 970D15805E;
	Wed, 12 Aug 2026 11:51:45 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 11:51:45 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v3 2/9] s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL
Date: Wed, 12 Aug 2026 07:51:32 -0400
Message-ID: <20260812115139.576303-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812115139.576303-1-akrowiak@linux.ibm.com>
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c5e56 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=7-PX2TBNVYp1iSTFOFgA:9
X-Proofpoint-GUID: 3XZRV6i80eKFc-fKhi-rBlXtuT0sxII6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX41/l8pTr3fXw
 7ft3aPVdFDQRIvU+7V/dySi9nJOkR2it7XEgXWzGZQ4XZM8P1j8uW/ZFyPpCUoQRCUcOTE1rjKJ
 RU+Mmehg5vxWOBs6DgUxHtPbHtqwluvncEICEvd2oS1+bPS5KcDCrZ/Ts29jPY4+r8ShrsUqjVr
 np3Zx6o530ekvKCE0BNMRjkpvlkl0NtaLCTxGIjOEu4etPOj7FdysSYU8AxLndjb3g7Q0e2emsd
 52xaB5YTxfxK+eZhtuZOydxqNQ+9Os3RMZyOq6g9SkhMXxYUr1zClVtFwY+mW1mgHe8oLtOzSiU
 uESNVjkilyEhiU0mJ5hu0EN025A5kH4ofO/bunu40UVyHG0B620O7VU0011LqiT9x1jy82E8g0n
 8XBMqewoJ1jvIa51zNRnAscF1v6V5rI3G7E0z5mrxoWCw1zXinNlo7k9z4kpH96Tj2QE31+NLAg
 yR9UaozhwGv5OLNqbeA==
X-Proofpoint-ORIG-GUID: 3XZRV6i80eKFc-fKhi-rBlXtuT0sxII6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX2c60l+dBY+kX
 gIU72TtaghJlQ2MI1eu4rIsLNWu6OFSOfs3EvYb+JLUG82PUkqF8Ff+cgwQqPK9DISJJOc3sjY8
 A3j9UA/v3bhj6/kPQya/Mj+VbWtNpaI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120093

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
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
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


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0AD29D27A;
	Fri,  7 Aug 2026 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114472; cv=none; b=IEtaXEq67sqfcgs6D/98Ox333dA38O/+OSd2duI8LZRNZE6sbMFOeOxVbgU8ztl8yRH7mkTkISH+zZBoCxNBYlxGtNwONTh1DIG2tbL6RXR06j2/ymS5zgHLlL9GL+2ikt3Kv7rE03MCZIxhwCkxwtvCTXhLBRtJITwnmjY7MEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114472; c=relaxed/simple;
	bh=NViB+Xf/KxxpiRQ016xOzrNeoGRbkfgfnqFl7bB+2Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jOgnQzGfy4njWarYcCuX/w2/xxyAGX7FQ3gEuBfUDDy72qNs/jLT9FlYdPmCuCzbCHtvS7hsJqABxSANZ2s7MhmCZgdPGOkp/H5jO+nLDg32DRk2r9+O1hRUpxb3FmqkVyuZBg9/gPYT0Vs73ggbAdtGDB4kMjROsljKIL1usyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iSo08dDE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iSo08dDE"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Clh5m3829277;
	Fri, 7 Aug 2026 14:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=X2l8Ti6vIQv+KTQZF19VgCYrX2zol3jyxFA3gEqW0
	K8=; b=iSo08dDEH76stfaHTB9mXi6uPwXt25QmOrzd+JLzLuspck+2kn8e11Nzc
	V1kl6zyR0jafwU+xtN8c+F9GyiPxVRIjRFkNKqbjtyJGdmrfJ3T40VbX9137fiTT
	ahbY+L8aSla9V67UUFVXhzfAHNExR9FRGy4JhVSMrmEvIZ1SHCRGzhFSqdsBNaCJ
	5l5evs6b0pfW2se9JRBGObkU2XOJqTeukDFO90BFA6mr0qiL81S0AiNw3D5QrEI7
	p5BDz5WTfgZ44wSpNotcYvRpjWhbnicLL6pYbh3XrhJseUh/0Sf9c1wj39tzJl+4
	P+ErAOC/DpQj/74hfPjyR40sdar3w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy01md2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:54:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677EfHVP010701;
	Fri, 7 Aug 2026 14:54:19 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhr140-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:54:19 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677EsIFu25559560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 14:54:18 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42FAB5805D;
	Fri,  7 Aug 2026 14:54:18 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0DDB58043;
	Fri,  7 Aug 2026 14:54:16 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.52.19])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 14:54:16 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH] s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL
Date: Fri,  7 Aug 2026 10:54:15 -0400
Message-ID: <20260807145416.322916-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 61_rwG6uLRCjBKFgQtNg7OY6Ay0wCaIs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExNiBTYWx0ZWRfX9CRPg0AVbF/e
 7/ZAOPQCvAo8FruT3lQPQYZaEViRdkaiwKrQn6ps1u3f+L+bVm2acHuo+0NEJwypCfnMpL/cJqe
 zNcdcvphob+ikz0PedP8olw6z3Pp+nQ=
X-Proofpoint-ORIG-GUID: 61_rwG6uLRCjBKFgQtNg7OY6Ay0wCaIs
X-Authority-Analysis: v=2.4 cv=afNRWxot c=1 sm=1 tr=0 ts=6a75f19c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=7-PX2TBNVYp1iSTFOFgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExNiBTYWx0ZWRfXwjquQ+spsadP
 n+t0+328xOj/Qo7JA2jBdWNxE0Q/gSxI/I99Z/N2/HTfLfRjhoDg/LkOkpkWg8q0D7EAeNOPtg3
 5iXhp1n+nBpYtZjTzeJ9lBwgneRz/e+mf9YcODXr6bAW+Q6gDvf2uGtk5GPTAmkIdKKAJxklUaW
 bpQ3yWdp90m6Sg4x8rt4MArIN+TSjQn98wmq6aVJ3rVZxSs9OAHBOSEewxDYiE/9P5J2IVRBzmA
 kApupp9vbNo92nRhuqD7Slol9uJNZ07CoTwHkbZJaltaotwibg3Ku4sfZxA9KPyyZ9dJYVCHX1e
 DfiJZRFlUNCCI8IrDBphEK0OuhUqxdzW5or2BxxgiFmR5akk4vFhdbjg/C9+/JcU0pC7qixx2QD
 IpGJw6dSvhVBiyN1DBaNrANxPj+1N/UgNfOQ0kp/gKLNDS8Aq2vJgXAGBdXIuINv1GZ3I24vEWT
 DpugPzOwdmsFsU28t2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070116

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
index 44b3a1dcc1b3..a0b7c37fee28 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2606,7 +2606,15 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
 	int do_remove = 0;
 
 	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
-		mutex_lock(&matrix_mdev->kvm->lock);
+		/*
+		 * If the mdev is attached to a KVM guest, we will need to
+		 * hold the KVM lock in order to update the guest's AP
+		 * configuration if any adapters, domains or control domains
+		 * have been removed.
+		 */
+		if (matrix_mdev->kvm)
+			mutex_lock(&matrix_mdev->kvm->lock);
+
 		mutex_lock(&matrix_dev->mdevs_lock);
 
 		do_remove |= bitmap_and(aprem, ap_remove,
@@ -2624,7 +2632,8 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
 						    cdrem);
 
 		mutex_unlock(&matrix_dev->mdevs_lock);
-		mutex_unlock(&matrix_mdev->kvm->lock);
+		if (matrix_mdev->kvm)
+			mutex_unlock(&matrix_mdev->kvm->lock);
 	}
 }
 
@@ -2748,6 +2757,7 @@ static void vfio_ap_mdev_cfg_add(unsigned long *apm_add, unsigned long *aqm_add,
 
 	vfio_ap_filter_apid_by_qtype(apm_add, aqm_add);
 
+	mutex_lock(&matrix_dev->mdevs_lock);
 	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
 		bitmap_and(matrix_mdev->apm_add,
 			   matrix_mdev->matrix.apm, apm_add, AP_DEVICES);
@@ -2756,6 +2766,7 @@ static void vfio_ap_mdev_cfg_add(unsigned long *apm_add, unsigned long *aqm_add,
 		bitmap_and(matrix_mdev->adm_add,
 			   matrix_mdev->matrix.adm, adm_add, AP_DEVICES);
 	}
+	mutex_unlock(&matrix_dev->mdevs_lock);
 }
 
 /**
@@ -2821,9 +2832,6 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug = false;
 
-	mutex_lock(&matrix_mdev->kvm->lock);
-	mutex_lock(&matrix_dev->mdevs_lock);
-
 	filter_adapters = bitmap_intersects(matrix_mdev->matrix.apm,
 					    matrix_mdev->apm_add, AP_DEVICES);
 	filter_domains = bitmap_intersects(matrix_mdev->matrix.aqm,
@@ -2841,9 +2849,6 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 
 	reset_queues_for_apids(matrix_mdev, apm_filtered);
-
-	mutex_unlock(&matrix_dev->mdevs_lock);
-	mutex_unlock(&matrix_mdev->kvm->lock);
 }
 
 void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
@@ -2854,15 +2859,25 @@ void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
 	mutex_lock(&matrix_dev->guests_lock);
 
 	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		if (matrix_mdev->kvm)
+			mutex_lock(&matrix_mdev->kvm->lock);
+
+		mutex_lock(&matrix_dev->mdevs_lock);
+
 		if (bitmap_empty(matrix_mdev->apm_add, AP_DEVICES) &&
 		    bitmap_empty(matrix_mdev->aqm_add, AP_DOMAINS) &&
 		    bitmap_empty(matrix_mdev->adm_add, AP_DOMAINS))
-			continue;
+			goto unlock;
 
 		vfio_ap_mdev_hot_plug_cfg(matrix_mdev);
 		bitmap_clear(matrix_mdev->apm_add, 0, AP_DEVICES);
 		bitmap_clear(matrix_mdev->aqm_add, 0, AP_DOMAINS);
 		bitmap_clear(matrix_mdev->adm_add, 0, AP_DOMAINS);
+
+unlock:
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		if (matrix_mdev->kvm)
+			mutex_unlock(&matrix_mdev->kvm->lock);
 	}
 
 	mutex_unlock(&matrix_dev->guests_lock);
-- 
2.53.0


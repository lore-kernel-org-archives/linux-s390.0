Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D727364EBF;
	Wed, 12 Aug 2026 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564987; cv=none; b=f98nVbrI2Kxoqaacki1SBleuYb0wiM7cbf/dIpWy7uwn5wGW4naStvnFb2VvkisLmLlN2y7HY47qa1zxKrWkekSltXw1sske7fC5RV9JGdf4fSQRC2ra/dI2l9O/wymmm8ZC9gT0aED8KjS29TG7ZSAK7bWl2I+6zHbforiJG9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564987; c=relaxed/simple;
	bh=unPH0ftrwS/7HITiOcWhYpqJf1M5a1XSPmtX60f2Fe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2+3TEurXI7zjdiD4sHm/xf/WbhbA9SgVF09xe9JKg4W8O7jtcquRfKtsOsRgKbwR2qsYiBPmRXULUSNxnmxVhv1C3xcV2fswU13Uu/m9orxkMDDGSc/RalKcyMAYidCcIFl7//ZPZZOjI0mtr2JPtQz1xJ1ooOhHwDiIEBf1Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ojuQ/nmw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ojuQ/nmw"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2eZe291763;
	Wed, 12 Aug 2026 20:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xd4tuIPEUtcZR3kxf
	Vor1dQGByJCCqoSk+q/LP6t7V0=; b=ojuQ/nmwhF2xUFbMT26BvAW+naImmjlnX
	0ECBLiXPDNNHikqgnhPQWQFOWLU9hzEA+PAeOxvXSJCYQOUnKdFNj0wrSY9AMlia
	gsZZfZHfwwX9h8siiXHv/9/fUGJSUWT/01gtTOaQz5uAsq26ayEKZBhOUzzkkB6z
	ElTNOj+zazsBUdaquY4TSt9kcs2n4vdkj2NuAMr5G/hnSF8rAlMLBIXTOJYBk00Y
	1T4Hcuqqi4qwe6rXcZfSZwG9IR7hUt2vaPaLHWJhzGY1GTWOnG1PBbMXTvfljw4S
	ieH0Wi+WBMKSmWDAGJE43nyQmqLiylg7bwU46Na/LrQ9nuHNpK7bA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9vh4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:02:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CJuF0Y030839;
	Wed, 12 Aug 2026 20:02:48 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq7y4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:02:48 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CK2kmf51577174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 20:02:46 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D2C058050;
	Wed, 12 Aug 2026 20:02:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8A8F58056;
	Wed, 12 Aug 2026 20:02:44 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 20:02:44 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v5 2/9] s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL
Date: Wed, 12 Aug 2026 16:02:33 -0400
Message-ID: <20260812200240.818004-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812200240.818004-1-akrowiak@linux.ibm.com>
References: <20260812200240.818004-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE2MSBTYWx0ZWRfXxGN1ul0wIKLc
 hRc3W30gzgcod1eWeu6jBp3FrWJz4/jAMI9mRAYtiOo3eNNyos/hVtpCKx4VFXVUdNyAalPObOr
 fu7V6N/S6YLIMkaTB626A1DH7VcsWtigS+p5/e7msVqBY53EiCuGNSNCh68KB+MLyqhtmCFQvoF
 xQny/+SwcW0SCCiPRdYYvDCzTSCeXC5WmcUl0vxYVgncSVERJRWk1zD6Z+Wn0PhzHnVtHbYtHhG
 U/jmPkFuvuI0IsDSNiEtMSutxCYmTi+6fPXK794f2SYq+cje16rxTHeEl+B5zdrC081SLzqtIse
 4YhzE1otTlSZ2ab7tIGUmTPjp8YTs9ZcYz8Dsmf03t1Az0rsxO6u0OS40RXzSrDIwNg369R4dII
 UK6uf8LnAhlLkLSs3lQ2xr+C4/rVvV5p1OIU0/kj5Y4WlFI4zjQznQ/KsCWBLF3eOrN1D+IhyBr
 3r0Bk8yPx+TrdFctHNA==
X-Proofpoint-ORIG-GUID: e3Jo--IVfD4c9n9aCAXi4R998WMRvohV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE2MSBTYWx0ZWRfX5iyGiyEeOSra
 WsG+iwOscLzSBvWXZoRgm+x3c4fjYDT9Nh2E/xp04ZuBOBNFOc2nKtEEWQDxCLiyZVvsxXgaSAj
 vA67AD/I6ubrvY3h7v2Ij/9f4PgJjxs=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7cd169 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=7-PX2TBNVYp1iSTFOFgA:9
X-Proofpoint-GUID: e3Jo--IVfD4c9n9aCAXi4R998WMRvohV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120161

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
 drivers/s390/crypto/vfio_ap_ops.c | 39 ++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 845c86ba8bc3..c6bee69cc22f 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2605,8 +2605,20 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
 	DECLARE_BITMAP(cdrem, AP_DOMAINS);
 	int do_remove;
 
+	/*
+	 * It is safe to traverse this list here because the
+	 * required guard - matrix_dev->guests_lock - is taken in the
+	 * vfio_ap_on_cfg_changed function prior to this function getting
+	 * called.
+	 */
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
@@ -2624,7 +2636,8 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
 						    cdrem);
 
 		mutex_unlock(&matrix_dev->mdevs_lock);
-		mutex_unlock(&matrix_mdev->kvm->lock);
+		if (matrix_mdev->kvm)
+			mutex_unlock(&matrix_mdev->kvm->lock);
 	}
 }
 
@@ -2821,9 +2834,6 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug = false;
 
-	mutex_lock(&matrix_mdev->kvm->lock);
-	mutex_lock(&matrix_dev->mdevs_lock);
-
 	filter_adapters = bitmap_intersects(matrix_mdev->matrix.apm,
 					    matrix_mdev->apm_add, AP_DEVICES);
 	filter_domains = bitmap_intersects(matrix_mdev->matrix.aqm,
@@ -2841,9 +2851,6 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 
 	reset_queues_for_apids(matrix_mdev, apm_filtered);
-
-	mutex_unlock(&matrix_dev->mdevs_lock);
-	mutex_unlock(&matrix_mdev->kvm->lock);
 }
 
 void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
@@ -2854,15 +2861,29 @@ void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
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


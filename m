Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED8447813;
	Fri,  4 Sep 2026 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514494; cv=none; b=O3GzVTsk8OhhIOz2ZdixWVytgkXZVVRnnHfmRulFPhztPXt25gyURSzklh9omhTrPQAzIAmVFd+cxNqrUfdlmfioiwRj6P8811SP5HM3yCrQyPKuTVKvNanELXCQr9F90BQRcYoWCdv6fQ3YXcN5PnQNJbmFoCFA2sa2VDS9yrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514494; c=relaxed/simple;
	bh=zyhhUAFNc/vzusjTTLgUP+9cEBqhCuGNN9v5bv7+yoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLqmi/1s/hUkdeybsZrz59T0DxUNSOBXHKJTobH3pjTgu+dHq51D7SulGQAz4vWoPqH9CXiVJV3g9muRhJ39lYyhHVPMRoTbnZAZyEvUw4d8+zBSVjOVicIRGbzkHsCjk9qp5558wtftMBhg7E96QaBojHwK9wNGscQVIGLDjEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ioOB4nhd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ioOB4nhd"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464M0P3254191;
	Fri, 4 Sep 2026 09:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=smXW4awEptwzkLAj4
	OinQ6H5qTuoobC8jQjMS7QOw6k=; b=ioOB4nhd4Ucy0+Jrzs7drr0T9RcIEpZM7
	uydFeI2/6JnDQ30HbQFYFc434Ki5UFaq9weO3oSABZykEmR8660tuSsCKKY73sMO
	PiXJqfgxILGmyaYTILWIUImaUgoCWzYPVvNyEodzazdfdXLM6ixHRU/q/TuoIpYJ
	Xm1t4VMq4WHX3oGglnRleRCvOvZoCXQWJE34MNxxR0JfP4OGKZOahTIEXKvzhxA9
	oG3OkIv3KWdnW31szH9wwGKAhdzXYMhPM41fJV3LQFWgMeo2JCNGbZIJAimhAc59
	/E52nxSV4rrnrHJRp2pqj74MtB0A9xrJLPyoTzSTYT3qSq8BbSIcQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rswby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 09:34:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6849V4kY008461;
	Fri, 4 Sep 2026 09:34:45 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkm9df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 09:34:45 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6849Yi6r25231974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 09:34:44 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4763258062;
	Fri,  4 Sep 2026 09:34:44 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D18858052;
	Fri,  4 Sep 2026 09:34:43 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.80.215])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 09:34:42 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v6 5/5] s390/vfio-ap: fix queue state leakage to guest and host
Date: Fri,  4 Sep 2026 05:30:54 -0400
Message-ID: <20260904093435.1161402-6-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904093435.1161402-1-akrowiak@linux.ibm.com>
References: <20260904093435.1161402-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9a90b7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=FOWIriepaZn-AuB_pjkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4NiBTYWx0ZWRfXx9HIcZX7IvaL
 8MahHCGgwWzM9uo4kfHWBx97GFfAmwUxD01rNGjyXRk/i+2neK4mewZK0gS/aSs7Y4KSFL8tYbf
 mvygb2B/pj5BnypHKUOKnVs8Ehh4dWWMtem5oZWNjFaSxM6VEIU3tMYvW2oe3fSG4Xmtfifp/7c
 3ZSsi3TzrydEtIDVstvwUgkR+3jo30bC8+esq+lJ3lo/QK+PVA+2OpZYJxX1CfxSEVem29X3/eN
 Cn2yMlQwpIvWgfJNc3JG8DWn1DV+FFQs0WN7J7eCTwlK2EsJFixLx6EiC6To4Qk/WNsIZCoRMsY
 g583igoHFNa+4j0x22EWbTYtzwIoq61JQLRNHldlYAWe53YIL462KZeA/gR+txQnl9g6Bojoz9K
 MaP55mECiPxOShI5GKqkd6py/xlpkNc4ia93vrZs9YyCwqAQapPSkTqYt0qVL+KbvQykrHynXjQ
 7Frb/iyxRShhLn6aU7A==
X-Proofpoint-GUID: jnxOOWubDf8Le6twVJxoUWr-D2Qy6hdS
X-Proofpoint-ORIG-GUID: jnxOOWubDf8Le6twVJxoUWr-D2Qy6hdS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4NiBTYWx0ZWRfX8t55vmdykaDD
 4xNQONbJFTujpGdiz+178iLvBAq0jpYf09OVxD2P7SlbPZDuEXlfyI/Ad3rFO6IBhlYBaBInoPH
 NjwOzxhr0h9WUl1iUmsOAeqkpwrf4pU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040086

Commit dd174833e44e ("s390/vfio-ap: remove upper limit on wait for queue
reset to complete") removed the upper bound on the wait for a queue reset
to complete in apq_reset_check(), thus allowing the function to loop
indefinitely. The reason given was to ensure both the security requirements
and prevent resource leakage and corruption in the hypervisor.

That is a legitimate concern; however, functions initiating the reset all
hold the matrix_dev->mdevs_lock which guards access to all of the mdevs
under the control of the vfio_ap device driver. Blocking of access prevents
a system administrator from configuring the mdevs (i.e.,
assigning/unassigning adapters, domains and control domains via the mdev's
sysfs interfaces) and may hang any guest that is started using one of
the mdevs to supply its AP configuration.

This patch addresses two issues:
1. Limits the potential hang condition to a single mdev/guest.

2. Prevents leakage of the internal state of a queue to the host or
   any guest started using an mdev to supply its AP configuration.

The key code changes made to address these issues:

1. _queue_passable() accepted reset status response codes
   AP_RESPONSE_DECONFIGURED and AP_RESPONSE_CHECKSTOPPED as passable
   states in addition to AP_RESPONSE_NORMAL. Neither DECONFIGURED nor
   CHECKSTOPPED confirms that the queue was zeroized; only
   AP_RESPONSE_NORMAL (0) - set by apq_reset_check() after TAPQ status bit
   verification - does. To fix this, the passable condition will be limited
   to AP_RESPONSE_NORMAL only.

2. Added a reset_max_wait field to struct vfio_ap_queue. This value
   specifies the maximum length of time to wait for reset completion. A
   value of zero indicates wait until the reset completes.

3. apq_reset_check() used the compile-time constant AP_RESET_MAX_WAIT
   as a hard timeout, causing the reset polling loop to give up and
   mark the queue non-normal even when the caller required confirmed
   zeroization. Replace the constant with the reset_max_wait field from
   the vfio_ap_queue object. When set to AP_RESET_MAX_WAIT, the behaviour
   is unchanged; when set to 0 (new unbind path) the loop runs until
   zeroization is confirmed regardless of elapsed time.

4. Introducing a reset_max_wait value of zero to mean "wait indefinitely"
   required changes to apq_reset_check() beyond simply replacing the
   AP_RESET_MAX_WAIT constant. When the max wait block is bypassed, the
   function must still exit the loop when apq_status_check() returns 0
   (zeroization confirmed) or -ENODEV (device gone), so an explicit
   goto done is added for those two cases. Additionally, the -EBUSY/-EAGAIN
   re-ZAPQ branch used continue followed by an unconditional goto done,
   which caused the loop to exit immediately after a ZAPQ retry rather
   than continuing to poll; both are removed so polling continues
   correctly when the max wait block is bypassed.

5. vfio_ap_mdev_probe_queue() only zeroed the reset_status field at
   probe time; it did not reset the queue itself, so a queue inherited
   whatever state the firmware left it in. Call vfio_ap_mdev_reset_queue()
   and flush_work() at probe to guarantee a clean queue before it can
   be assigned to a guest. Symmetrically, vfio_ap_mdev_remove_queue()
   freed the queue structure immediately after unlinking it even if the
   queue had not been confirmed zeroized. Delay kfree() until after a
   blocking reset (reset_max_wait = 0) when the queue is not already
   confirmed clean, preventing host exposure to stale queue state.
   This, of course, will block the unbinding of the queue until zeroization
   is confirmed, but that is preferable to blocking access to all of the
   mdevs under the vfio_ap device driver's control.

Fixes: dd174833e44e ("s390/vfio-ap: remove upper limit on wait for queue reset to complete")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 39 ++++++++++++++++++---------
 drivers/s390/crypto/vfio_ap_private.h |  3 +++
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 6a964f82c8e8..e054fd4a9497 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -781,14 +781,14 @@ static bool _queue_passable(struct vfio_ap_queue *q)
 	if (!q)
 		return false;
 
-	switch (q->reset_status.response_code) {
-	case AP_RESPONSE_NORMAL:
-	case AP_RESPONSE_DECONFIGURED:
-	case AP_RESPONSE_CHECKSTOPPED:
-		return true;
-	default:
-		return false;
-	}
+	/*
+	 * A queue is only passable if zeroization was confirmed by
+	 * apq_reset_check() via TAPQ status bit verification. This is
+	 * indicated by reset_status.response_code == AP_RESPONSE_NORMAL (0).
+	 * This is to protect against leaking the internal state of the queue
+	 * to the guest.
+	 */
+	return q->reset_status.response_code == AP_RESPONSE_NORMAL;
 }
 
 /*
@@ -2113,7 +2113,7 @@ static void apq_reset_check(struct work_struct *reset_work)
 		ret = apq_status_check(q->apqn, &status);
 		if (ret == -EIO)
 			return;
-		if (elapsed >= AP_RESET_MAX_WAIT) {
+		if (q->reset_max_wait && elapsed >= q->reset_max_wait) {
 			/*
 			 * Zeroization confirmed (ret == 0): the TAPQ status bits
 			 * indicate the async portion of the ZAPQ completed
@@ -2161,6 +2161,8 @@ static void apq_reset_check(struct work_struct *reset_work)
 
 			return;
 		}
+		if (!ret || ret == -ENODEV)
+			goto done;
 		if (ret == -EBUSY) {
 			pr_notice_ratelimited(WAIT_MSG, elapsed,
 					      AP_QID_CARD(q->apqn),
@@ -2175,9 +2177,7 @@ static void apq_reset_check(struct work_struct *reset_work)
 			    ret == -EAGAIN) {
 				status = ap_zapq(q->apqn, 0);
 				memcpy(&q->reset_status, &status, sizeof(status));
-				continue;
 			}
-			goto done;
 		}
 	}
 
@@ -2675,8 +2675,10 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 
 	q->apqn = apqn;
 	q->saved_isc = VFIO_AP_ISC_INVALID;
-	memset(&q->reset_status, 0, sizeof(q->reset_status));
+	q->reset_max_wait = AP_RESET_MAX_WAIT;
 	INIT_WORK(&q->reset_work, apq_reset_check);
+	vfio_ap_mdev_reset_queue(q);
+	flush_work(&q->reset_work);
 
 	if (matrix_mdev) {
 		vfio_ap_mdev_link_queue(matrix_mdev, q);
@@ -2759,8 +2761,19 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 		vfio_ap_unlink_queue_fr_mdev(q);
 
 	dev_set_drvdata(&apdev->device, NULL);
-	kfree(q);
 	release_update_locks_for_mdev(matrix_mdev);
+
+	if (q->reset_status.response_code != AP_RESPONSE_NORMAL) {
+		/*
+		 * Loop until zeroization of queue is verified so we don't leak
+		 * the internal state of the queue to the caller.
+		 */
+		q->reset_max_wait = 0;
+		vfio_ap_mdev_reset_queue(q);
+		flush_work(&q->reset_work);
+	}
+
+	kfree(q);
 }
 
 /**
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 9bff666b0b35..914ea5d41d33 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -139,6 +139,8 @@ struct ap_matrix_mdev {
  *		 that need to be reset
  * @reset_status: the status from the last reset of the queue
  * @reset_work: work to wait for queue reset to complete
+ * @reset_max_wait: the max amount of time to wait for a reset to complete;
+ *		    specifying 0 means wait as long as it takes.
  */
 struct vfio_ap_queue {
 	struct ap_matrix_mdev *matrix_mdev;
@@ -150,6 +152,7 @@ struct vfio_ap_queue {
 	struct list_head reset_qnode;
 	struct ap_queue_status reset_status;
 	struct work_struct reset_work;
+	unsigned int reset_max_wait;
 };
 
 int vfio_ap_mdev_register(void);
-- 
2.53.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE2651E421;
	Tue, 29 Sep 2026 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684336; cv=none; b=DC7rwiLV3MW5pV3pG+/plT9TuABj0jNSAtBWBTPvozgLkPrH/e+fxZLa79OR4FUUdt/pI8TAguZcuzERo+Gx2AqYFyQbRq+Sd4mbLqgbP8CsClCbyBQUhVZ/OGscuE2sQMXkAhWvC8BjKa8BoMGFDGi7VuDSx6jDXEZmaiRx45k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684336; c=relaxed/simple;
	bh=371NFlx6hX3KxjHPx7/Y3EwLN/kSaQQEooBg0gSsnAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rw5n8klyNaJDMZJ1FFobfoX80wj46KkKCQi2B0xljCYSg11Ng5e5+0FfxkIDRUXu/cRnfn0AFQ577f/PiCF8iSNoNHi0Ah/i7Wypz5tfoVl9giNVcQCwDjeKheizyEZlAFaJPjQcSAcpKZosF/f3sfPcZH8oqg7UKShjmWkQtlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LutyKK+K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LutyKK+K"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5YGF4017586;
	Tue, 29 Sep 2026 12:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=glqmumxcvYHLDKGKC
	P2QD7cDDwWyz4l3NOL5a0D4cN8=; b=LutyKK+KC+jlHsHKRDTmtdTKwM0Tdo+pV
	H2BTN/PxM2bFB7SdaSBl83f7YRRDwttNkXcUtNszx9UdpKDUsbcOW5uMVmXqjOWx
	EhTCPWSTiMo8VWqBA7KiKZUlYCd2j9deeXAdgwuaWMo6etiX51ai/aIbxgj5lMED
	5JtZ4MNE1O/rRL9Owp8sYNU7HqX08bjwPSECksUjzsM3wQc9ypTbneG64L29Z8Ok
	l+2UFr3S+NOuhcXExtb4EMO7p+rvXpvfaUEX2CDT/pfZF78iHx1F18vTM2lN9lok
	/O1Gz7tgRk19troc9/vwPTCS3fvenIk8nURc575pQkaCGu991Rm3g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt65s8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 12:18:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAlZN11617030;
	Tue, 29 Sep 2026 12:18:48 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrw9raj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 12:18:48 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TCIkCJ27919032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 12:18:47 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96F9158052;
	Tue, 29 Sep 2026 12:18:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E7CB58068;
	Tue, 29 Sep 2026 12:18:45 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.24.130])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 12:18:45 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, freude@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v9 5/6] s390/vfio-ap: fix queue state leakage to guest and host
Date: Tue, 29 Sep 2026 08:18:36 -0400
Message-ID: <20260929121837.2715710-6-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: H2gRKdjZ0r1h83VUsFBgfaqOEPReTluk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfXxYWNos4RbNQN
 iwYwcCml6FhCkRTqTAeW2aVVYkEz0izECpPHAymCoII/zMC9VW7+D4k+0nkwei5Q82hVT0cJDo8
 ex3ku/PyRb/KF36MVnyS9ltHELEBMgcbwrCtKYzSgWr1QYwt6FKNijhdlrPShSJM7IYppi31Kor
 bisX6BaB72oNBirfC14Ohm1aEmq4rA+WjkS16QV+bTjd94Qak87SUllZUISThuNAzzc2E0hK3yi
 1iuFWsm/JG6bM28LA3h/kgEo4TPLcs05pAhDQ67WyBuCoNLD1fC/udRKIEhbUSjCkF1J72yah8m
 nk3Byw/1lkXZm0bvd0Bdx7pGw6jNStzvfF38g0up3IJvaittP05IdaCdaauIOO22ThpiUQtLp2c
 yvKR+KVarSzsWmbOYs/4UzvSJ7xRY2KCnpGRKFBUXvxdBwP40NTRokcNZ4Nzx4VHw23nm1K8sJa
 mMBt0GmAjq9w0/W/y8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX0JNhdHulvama
 /YcO86vAl7hFaIH2EQdOsStayCG2+HAV078Vt3XnAGzYN1ldJh+ybNoOuiIpvO7lTMo6gmzp2fJ
 nmkCRRjhfcqn2pwWHXo7CSJ4SvCfNXc=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abbaca8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=5Zu0Fc028Ib9rp9nduwA:9
X-Proofpoint-GUID: H2gRKdjZ0r1h83VUsFBgfaqOEPReTluk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290048

Commit dd174833e44e ("s390/vfio-ap: remove upper limit on wait
for queue reset to complete") removed the upper bound on the
wait for a queue reset to complete in apq_reset_check(), thus
allowing the function to loop indefinitely. The reason given
was to ensure security requirements and prevent resource
leakage and corruption in the hypervisor.

That is a legitimate concern; however, functions initiating
the reset all hold matrix_dev->mdevs_lock, which guards access
to all mdevs under the control of the vfio_ap device driver.
Blocking that lock prevents a system administrator from
configuring mdevs (assigning/unassigning adapters, domains,
and control domains via the mdev sysfs interfaces) and may
hang any guest started using one of those mdevs to supply
its AP configuration.

This patch limits the potential hang to the AP_RESET_MAX_WAIT
(2000ms) timeout introduced in the preceding commit and
prevents leakage of queue state to a guest.

_queue_passable() accepted AP_RESPONSE_DECONFIGURED and
AP_RESPONSE_CHECKSTOPPED as passable states in addition to
AP_RESPONSE_NORMAL. Neither DECONFIGURED nor CHECKSTOPPED
confirms that the queue was zeroized; only AP_RESPONSE_NORMAL
(0) does. A queue not confirmed zeroized must not be passed
through to a guest, as it may contain key material from a
previous guest or host operation.

_queue_passable() is therefore changed to return true only
when reset_status.response_code == AP_RESPONSE_NORMAL. A new
helper, apq_reset_finalize(), is introduced to ensure that
q->reset_status correctly reflects the confirmed end state.
It copies the full TAPQ status word into q->reset_status and
overrides the response code with AP_RESPONSE_NORMAL only when
apq_status_check() returns 0, confirming zeroization via TAPQ
status bit verification. For -ENODEV (DECONFIGURED or
CHECKSTOPPED), the non-zero response code is preserved so
_queue_passable() correctly returns false.

Since _queue_passable() now rejects deconfigured and
checkstopped queues, a queue bound to the vfio_ap driver
cannot be passed through to a guest even after it returns
to an operational state. To resolve this, a new callback,
on_qstate_transition, is added to struct ap_driver and
invoked by the AP bus scan when a queue transitions between
operational and non-operational states. The vfio_ap driver
implements this callback in vfio_ap_on_qstate_transition(),
which dispatches to two helpers:

vfio_ap_on_queue_operational() handles CONFIG_ON and
CHKSTOP_OFF. If the queue is already live in a guest's
shadow APCB, the guest owns it and is responsible for
handling the transition. Otherwise the queue is reset to
clear the stale non-zero response code left by the prior
failed reset, so that filter_matrix will correctly re-admit
it. If the queue is assigned to an mdev, filter_matrix is
called to update the shadow APCB; if the shadow changed and
the mdev is attached to a running guest, the guest APCB is
updated so the queue becomes available to the guest. Any
other adapters newly filtered out are also reset.

vfio_ap_on_queue_non_operational() handles CONFIG_OFF and
CHKSTOP_ON. If the queue is already live in a guest's shadow
APCB, the guest owns it and is responsible for handling the
transition. Otherwise, q->reset_status is zeroed and its
response code is set to AP_RESPONSE_DECONFIGURED or
AP_RESPONSE_CHECKSTOPPED as appropriate, ensuring
_queue_passable() returns false and filter_matrix will not
admit the non-operational queue to a guest. If the queue is
assigned to an mdev, filter_matrix is called to remove it
from the shadow APCB; if the shadow changed and the mdev is
attached to a running guest, the guest APCB is updated. Any
adapters filtered out are reset.

Note: reset_queues_for_apids() will issue a ZAPQ for the
non-operational queue itself (since its APID was filtered).
That ZAPQ will fail with DECONFIGURED or CHECKSTOPPED, which
apq_reset_finalize() handles gracefully. Avoiding this extra
ZAPQ would require modifying reset_queues_for_apids() or
collect_queues_to_reset() to skip queues with a non-zero
reset_status.response_code, adding complexity not justified
by the benefit on this infrequent path.

Additionally, vfio_ap_mdev_probe_queue() calls
vfio_ap_mdev_reset_queue() and flush_work() while holding
the update locks to guarantee a clean queue before it can
be assigned to a guest. This adds at least AP_RESET_INTERVAL
(20 ms) of lock-hold time per probed queue, since
apq_reset_check() sleeps before its first TAPQ. In theory
this is O(N) serialized under the global mdevs_lock; in
practice, AP hardware constraints and typical deployment
sizes bound the number of queues allocated for guest use in
a single LPAR to a modest number, so the total probe cost
is not necessarily a real-world concern.

Deferring the reset outside the lock-held section is not
safe: apq_reset_check() accesses q->reset_status and
q->aqic_resources without holding any lock, and
vfio_ap_mdev_remove_queue() can run concurrently and call
kfree(q) after releasing the locks, leaving the worker with
a dangling pointer. flush_work() inside the lock-held
section serializes against remove_queue and prevents this.

The fundamental remedy would be to replace the global
mdevs_lock with a per-mdev lock, scoping the blocking to
the single mdev whose queue is being probed and allowing
resets across different mdevs to proceed in parallel. That
is a non-trivial redesign of the locking architecture and
is deferred to a separate effort.

Fixes: dd174833e44e ("s390/vfio-ap: remove upper limit on wait for queue reset to complete")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c          |  51 ++++++++++++
 drivers/s390/crypto/ap_bus.h          |  33 ++++++++
 drivers/s390/crypto/vfio_ap_drv.c     |   1 +
 drivers/s390/crypto/vfio_ap_ops.c     | 115 ++++++++++++++++++++++++--
 drivers/s390/crypto/vfio_ap_private.h |   2 +
 5 files changed, 193 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index d82df5b4e2db..27b67bd04646 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1979,6 +1979,28 @@ static inline void notify_scan_complete(void)
 			 __drv_notify_scan_complete);
 }
 
+/* Helper function for notify_on_qstate_transition */
+static int __drv_notify_qstate_transitioned(struct device_driver *drv, void *data)
+{
+	struct ap_driver *ap_drv = to_ap_drv(drv);
+	struct ap_qstate_transition *qstate_trans = data;
+
+	if (try_module_get(drv->owner)) {
+		if (ap_drv->on_qstate_transition)
+			ap_drv->on_qstate_transition(qstate_trans);
+		module_put(drv->owner);
+	}
+
+	return 0;
+}
+
+/* Notify all drivers about a queue state transition */
+static inline void notify_qstate_transitioned(struct ap_qstate_transition *qstate_trans)
+{
+	bus_for_each_drv(&ap_bus_type, NULL, qstate_trans,
+			 __drv_notify_qstate_transitioned);
+}
+
 /*
  * Helper function for ap_scan_bus().
  * Remove card device and associated queue devices.
@@ -1998,6 +2020,7 @@ static inline void ap_scan_rm_card_dev_and_queue_devs(struct ap_card *ac)
  */
 static inline void ap_scan_domains(struct ap_card *ac)
 {
+	struct ap_qstate_transition qstate_trans;
 	struct ap_tapq_hwinfo hwinfo;
 	bool decfg, chkstop;
 	struct ap_queue *aq;
@@ -2093,6 +2116,13 @@ static inline void ap_scan_domains(struct ap_card *ac)
 			spin_unlock_bh(&aq->lock);
 			pr_debug("(%d,%d) queue dev checkstop on\n",
 				 ac->id, dom);
+			/*
+			 * Notify drivers that the queue state has transitioned
+			 * to checkstopped.
+			 */
+			qstate_trans.queue = aq;
+			qstate_trans.new_state = AP_QUEUE_CHKSTOP_ON;
+			notify_qstate_transitioned(&qstate_trans);
 			/* 'receive' pending messages with -EAGAIN */
 			ap_flush_queue(aq);
 			goto put_dev_and_continue;
@@ -2104,6 +2134,13 @@ static inline void ap_scan_domains(struct ap_card *ac)
 			spin_unlock_bh(&aq->lock);
 			pr_debug("(%d,%d) queue dev checkstop off\n",
 				 ac->id, dom);
+			/*
+			 * Notify drivers that the queue state has transitioned
+			 * to not checkstopped.
+			 */
+			qstate_trans.queue = aq;
+			qstate_trans.new_state = AP_QUEUE_CHKSTOP_OFF;
+			notify_qstate_transitioned(&qstate_trans);
 			goto put_dev_and_continue;
 		}
 		/* config state change */
@@ -2117,6 +2154,13 @@ static inline void ap_scan_domains(struct ap_card *ac)
 			spin_unlock_bh(&aq->lock);
 			pr_debug("(%d,%d) queue dev config off\n",
 				 ac->id, dom);
+			/*
+			 * Notify drivers that the queue state has transitioned
+			 * to deconfigured.
+			 */
+			qstate_trans.queue = aq;
+			qstate_trans.new_state = AP_QUEUE_CONFIG_OFF;
+			notify_qstate_transitioned(&qstate_trans);
 			ap_send_config_uevent(&aq->ap_dev, aq->config);
 			/* 'receive' pending messages with -EAGAIN */
 			ap_flush_queue(aq);
@@ -2129,6 +2173,13 @@ static inline void ap_scan_domains(struct ap_card *ac)
 			spin_unlock_bh(&aq->lock);
 			pr_debug("(%d,%d) queue dev config on\n",
 				 ac->id, dom);
+			/*
+			 * Notify drivers that the queue state has transitioned
+			 * to configured.
+			 */
+			qstate_trans.queue = aq;
+			qstate_trans.new_state = AP_QUEUE_CONFIG_ON;
+			notify_qstate_transitioned(&qstate_trans);
 			ap_send_config_uevent(&aq->ap_dev, aq->config);
 			goto put_dev_and_continue;
 		}
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index fb4d678336e4..bbbd9aa4820e 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -132,6 +132,33 @@ struct ap_message;
  */
 #define AP_DRIVER_FLAG_DEFAULT 0x0001
 
+/**
+ * ap_queue_transition_state -	enumerates the new states to which a
+ *				queue can transition.
+ * @AP_QUEUE_CONFIG_ON:		from deconfigured to configured
+ * @AP_QUEUE_CONFIG_OFF:	from configured to deconfigured
+ * @AP_QUEUE_CHKSTOP_ON:	from not checkstopped to checkstopped
+ * @AP_QUEUE_CHKSTOP_OFF:	from checkstopped to not checkstopped
+ */
+enum ap_queue_transition_state {
+	AP_QUEUE_CONFIG_ON,
+	AP_QUEUE_CONFIG_OFF,
+	AP_QUEUE_CHKSTOP_ON,
+	AP_QUEUE_CHKSTOP_OFF,
+};
+
+/**
+ * struct ap_qstate_transition - used to notify a device driver that a
+ *				 queue state transition has occurred.
+ *
+ * @queue:	the queue device whose state transitioned
+ * @new_state:  identifies the new state to which the queue transitioned
+ */
+struct ap_qstate_transition {
+	struct ap_queue			*queue;
+	enum ap_queue_transition_state	new_state;
+};
+
 struct ap_driver {
 	struct device_driver driver;
 
@@ -155,6 +182,12 @@ struct ap_driver {
 	void (*on_scan_complete)(struct ap_config_info *new_config_info,
 				 struct ap_config_info *old_config_info);
 
+	/*
+	 * Called during the ap bus scan when a queue state transition is
+	 * detected.
+	 */
+	void (*on_qstate_transition)(struct ap_qstate_transition *qstate_trans);
+
 	struct ap_device_id *ids;
 	unsigned int flags;
 };
diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 8e69ed286bb9..6a5d97fa9200 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -61,6 +61,7 @@ static struct ap_driver vfio_ap_drv = {
 	.in_use = vfio_ap_mdev_resource_in_use,
 	.on_config_changed = vfio_ap_on_cfg_changed,
 	.on_scan_complete = vfio_ap_on_scan_complete,
+	.on_qstate_transition = vfio_ap_on_qstate_transition,
 	.ids = ap_queue_ids,
 };
 
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index ad19d44a67bc..89efb73d7035 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -881,14 +881,14 @@ static bool _queue_passable(struct vfio_ap_queue *q)
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
@@ -2855,6 +2855,8 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 
 	if (matrix_mdev) {
 		vfio_ap_mdev_link_queue(matrix_mdev, q);
+		vfio_ap_mdev_reset_queue(q);
+		flush_work(&q->reset_work);
 
 		/*
 		 * If we're in the process of handling the adding of adapters or
@@ -2944,8 +2946,8 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 		vfio_ap_unlink_queue_fr_mdev(q);
 
 	dev_set_drvdata(&apdev->device, NULL);
-	kfree(q);
 	release_update_locks_for_mdev(matrix_mdev);
+	kfree(q);
 }
 
 /**
@@ -3351,3 +3353,98 @@ void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
 
 	mutex_unlock(&matrix_dev->guests_lock);
 }
+
+/**
+ * vfio_ap_on_qstate_transition:
+ *
+ * AP bus callback notifying the vfio_ap device driver that the state of a
+ * queue has transitioned.
+ *
+ * @qstate_trans: the object containing a reference to the queue device and the
+ *		  state to which it transitioned.
+ */
+void vfio_ap_on_qstate_transition(struct ap_qstate_transition *qstate_trans)
+{
+	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
+	int apqn = qstate_trans->queue->qid;
+	struct ap_matrix_mdev *matrix_mdev;
+	struct vfio_ap_queue *q;
+	/*
+	 * Take all three locks in order and look up the queue under them.
+	 * This is the same pattern used by vfio_ap_mdev_probe_queue() and
+	 * avoids two races present if vfio_ap_find_queue() is called first:
+	 *
+	 * 1. vfio_ap_mdev_remove_queue() can kfree(q) between the find and
+	 *    the lock acquisition, producing a use-after-free on q->matrix_mdev.
+	 *
+	 * 2. q->matrix_mdev can change (assign/unassign under guests_lock +
+	 *    mdevs_lock) between the find and get_update_locks_for_mdev(),
+	 *    causing kvm->lock to be taken without being released, or released
+	 *    without having been taken.
+	 */
+	matrix_mdev = get_update_locks_by_apqn(apqn);
+	if (!matrix_mdev)
+		goto out_unlock;
+
+	q = vfio_ap_mdev_get_queue(matrix_mdev, apqn);
+	if (!q)
+		goto out_unlock;
+
+	switch (qstate_trans->new_state) {
+	case AP_QUEUE_CONFIG_ON:
+	case AP_QUEUE_CHKSTOP_OFF:
+		/*
+		 * The queue has returned to operational state. Reset it to a
+		 * known-clean state before re-admitting it to the guest's APCB.
+		 * A queue returning from deconfigured or checkstopped state may
+		 * have stale association state, undelivered replies, or a residual
+		 * NIB address register; ZAPQ returns it to a known-clean baseline.
+		 * The guest AP bus handles re-initialisation (including
+		 * re-enabling interrupts) after a queue reappears; the brief stall
+		 * on any pending guest AQIC is an expected consequence of the
+		 * hardware event, not a driver bug.
+		 *
+		 * matrix_mdev is guaranteed non-NULL here: get_update_locks_by_apqn()
+		 * returns NULL (and we branch to out_unlock) when the queue is not
+		 * assigned to any mdev, so the check is unnecessary.
+		 */
+		vfio_ap_mdev_reset_queue(q);
+		flush_work(&q->reset_work);
+
+		if (vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered)) {
+			vfio_ap_mdev_update_guest_apcb(matrix_mdev);
+			reset_queues_for_apids(matrix_mdev, apm_filtered);
+		}
+		break;
+	case AP_QUEUE_CONFIG_OFF:
+	case AP_QUEUE_CHKSTOP_ON:
+		/*
+		 * The queue has become non-operational. Hot-unplug its adapter
+		 * from the guest's shadow APCB so the guest stops issuing
+		 * operations to a queue it can no longer reach. Since queues are
+		 * addressed via a card/domain matrix it is not possible to remove
+		 * a single queue; the whole adapter must be unplugged.
+		 *
+		 * The queue remains bound to the driver and stays in
+		 * matrix_dev->info; vfio_ap_mdev_filter_matrix() will
+		 * re-admit it automatically when the queue returns to an
+		 * operational state (CONFIG_ON or CHKSTOP_OFF).
+		 */
+		if (test_bit_inv(AP_QID_CARD(q->apqn),
+				 matrix_mdev->shadow_apcb.apm) &&
+		    test_bit_inv(AP_QID_QUEUE(q->apqn),
+				 matrix_mdev->shadow_apcb.aqm)) {
+			clear_bit_inv(AP_QID_CARD(q->apqn),
+				      matrix_mdev->shadow_apcb.apm);
+			vfio_ap_mdev_update_guest_apcb(matrix_mdev);
+			reset_queues_for_apid(matrix_mdev,
+					      AP_QID_CARD(q->apqn));
+		}
+		break;
+	default:
+		break;
+	}
+
+out_unlock:
+	release_update_locks_for_mdev(matrix_mdev);
+}
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 5eb0936d9183..6abf2cc1fd86 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -186,4 +186,6 @@ void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
 void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
 			      struct ap_config_info *old_config_info);
 
+void vfio_ap_on_qstate_transition(struct ap_qstate_transition *qstate_trans);
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.53.0


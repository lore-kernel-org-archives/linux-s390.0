Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BB249E128;
	Fri, 25 Sep 2026 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340386; cv=none; b=pvh2YL8ZgYfAN4AW/42j2qAu0n55N9iftrE+1vMJz4SfqJlV4fGkA36MKH/UnCzKjbXSixaJom6XvdvvQP7jOAL7lEmhVeQTDjzNMyA1XiYLD9FlmsZceNYDOH6qSBiRc9I4hK3mqd/cpXQS3H43JOnhNsXspF73PTj26a1z1Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340386; c=relaxed/simple;
	bh=Je3ghUx5pd1RFGPL3NYEPLi0Hmp6ygvFQYm/tbRVR3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPSocLM2AvtfuQ8LWDUiMehiwRgnJt8c7T56ddgWAZzVzUqr5jerClxTp6mzadvEaIAmkeaV//FOpoNrOPdZjl8zecu9k7qrbeBMpn8quNa3g6ofC5WfzO/DZ8lYnyEOTNyzc5jWoR/8mab9Q6k5VF7Q/fWwgecdNEAcgctoZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KozZIiBw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KozZIiBw"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4bGTE104300;
	Fri, 25 Sep 2026 12:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=q56NBarmd4MJcFXru
	O9PJfKc49PqBdL1Q7o8tn7iz5I=; b=KozZIiBwq+dbwLVaEv09uWhoprl1Wq9vg
	N1JoK9A7NJb3hh8Hgdh/yKcoto/TzE6QFg1h1D5qbM+2a4uTlnu2JJxBKzp/MXOr
	zgZz4asCUNr6xSz2yNfrBtB9shk8bIZYBOL2f7hXYh8wkFtG3oakqYU7cNGTxO2G
	xsQe+Cu8Vo/OwAx6bg/s0+YDTP2P2cWw+i67XvmiFvTTpwDOlBJ3Kwf+VdknGKdZ
	/2xSqLf+ZRp7UkiG5ywoEObXx9vpozAqyoLQ/depe1mBv9gSx0va7GPO0qPeEHXc
	8avAjMbSR7z8HPXZUDBT4IQORqSeFE0ooIJszVcto+BAwXXCDtjfA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvp2sk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 12:46:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PA02Bh3298365;
	Fri, 25 Sep 2026 12:46:01 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8k2e8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 12:46:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PCk04414680762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 12:46:00 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A1FE58063;
	Fri, 25 Sep 2026 12:46:00 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEEC85805A;
	Fri, 25 Sep 2026 12:45:58 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.86.59])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 12:45:58 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, freude@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v8 5/6] s390/vfio-ap: fix queue state leakage to guest and host
Date: Fri, 25 Sep 2026 08:45:50 -0400
Message-ID: <20260925124551.665448-6-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925124551.665448-1-akrowiak@linux.ibm.com>
References: <20260925124551.665448-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vAC5mkCk9kG-K6wauqZkiQHj7LH_ij7D
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MCBTYWx0ZWRfXxQOuitKeDCaC
 Y1MVn5hIW8Z84gmCGi3b8zdGtV4Ez23aO2UPuoUGTYpejrbGQGU1hdOZDDDyQn+7h42hoSwy3L2
 mUbbfX7MKZM5xk8rqT9qrD1G2SSnSqg=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab66d0a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=tMcIf9aicxS5gytnuLwA:9
X-Proofpoint-GUID: vAC5mkCk9kG-K6wauqZkiQHj7LH_ij7D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MCBTYWx0ZWRfX/JEhjYfQ43gg
 WOuuRZt0WqvsKNV1mnKSuosjl76ylk+xyuLEXOIs6KXnOighIPxf7g9C87FLxHsQeUGLUtCxpeo
 HsCQIEFS+RzcSwEsn0MigQSgBYg+zhQoOodwY0SUlit39gtZcJ9LBnxvVWiwTBHSvA6Tv6V3fUc
 2MDUSLEC8zS3iN14y+XWVQuFASQc3gDQzm1meTtrepJL2z0Jh+hokxLjkkJAsENsSBqibtpKYx/
 f3K2J9SZKD8za621/LSXfeJj4v63Jnk9C4zKxezCk9PPPmBdVVdP8t27+3lpYqtrGYbBJVDjDdx
 RkqVARo2RbQvFl5pnPE+7PT0c+dpS0RIhsjEmV0JdxmPheCOTZI5T5qftXbKfZk1EArXS7zF1f7
 UiV61oN9p7C7HbzBA8YZZqAa9jyUgH7swYXopDS9dlfuTu5/MTVvM4hTwlE3qJ1o8g5AMSi/tXW
 IJjV7tsWg2tYsFA4V/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250050

Commit dd174833e44e ("s390/vfio-ap: remove upper limit on wait
for queue reset to complete") removed the upper bound on the
wait for a queue reset to complete in apq_reset_check(), thus
allowing the function to loop indefinitely. The reason given
was to ensure both the security requirements and prevent
resource leakage and corruption in the hypervisor.

That is a legitimate concern; however, functions initiating the
reset all hold the matrix_dev->mdevs_lock which guards access
to all of the mdevs under the control of the vfio_ap device
driver. Blocking of access prevents a system administrator from
configuring the mdevs (i.e., assigning/unassigning adapters,
domains and control domains via the mdev's sysfs interfaces)
and may hang any guest that is started using one of the mdevs
to supply its AP configuration.

This patch limits the potential hang to the AP_RESET_MAX_WAIT
(2000ms) timeout introduced in the preceding commit, and
prevents leakage of queue state to a guest.

_queue_passable() accepted AP_RESPONSE_DECONFIGURED and
AP_RESPONSE_CHECKSTOPPED as passable states in addition to
AP_RESPONSE_NORMAL. Neither DECONFIGURED nor CHECKSTOPPED
confirms that the queue was zeroized; only AP_RESPONSE_NORMAL
(0) does. A queue that is not confirmed zeroized must not be
passed through to a guest, as it may contain key material from
a previous guest or host operation.

Since _queue_passable() now rejects queues that are check stopped
or deconfigured, there is no way for a queue bound to the
vfio_ap device driver to pass those through to a guest even
if they are added back to the configuration or the reason they
have check stopped has been fixed. To resolve this issue,
a new on_queue_state_transition callback function is added to
struct ap_driver which is invoked during the AP bus device scan
when a queue device transitions from deconfigured to configured or
check stopped to not check stopped and vice versa. The vfio_ap device
driver provides an implementation that resets and zeroizes the queue when
it transitions to configured or not check stopped and plugs it into the
guest's AP configuration if the reset succeeds.

To fix this, _queue_passable() is limited to returning true
only when reset_status.response_code == AP_RESPONSE_NORMAL.
A new helper, apq_reset_finalize(), is introduced to ensure
q->reset_status correctly reflects the confirmed end state
of the queue. It copies the full TAPQ status word to
q->reset_status and sets q->reset_status.response_code to
AP_RESPONSE_NORMAL only when apq_status_check() returns 0,
confirming zeroization via TAPQ status bit verification.
For -ENODEV (DECONFIGURED or CHECKSTOPPED), the non-zero
response code is left intact, ensuring _queue_passable()
correctly returns false.

Additionally, vfio_ap_mdev_probe_queue() now calls
vfio_ap_mdev_reset_queue() and flush_work() at probe time
to guarantee a clean queue before it can be assigned to
a guest.

Fixes: dd174833e44e ("s390/vfio-ap: remove upper limit on wait for queue reset to complete")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c          | 51 +++++++++++++++++++++
 drivers/s390/crypto/ap_bus.h          | 29 ++++++++++++
 drivers/s390/crypto/vfio_ap_drv.c     |  1 +
 drivers/s390/crypto/vfio_ap_ops.c     | 64 ++++++++++++++++++++++-----
 drivers/s390/crypto/vfio_ap_private.h |  2 +
 5 files changed, 137 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index d82df5b4e2db..a53cfad3543e 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1979,6 +1979,28 @@ static inline void notify_scan_complete(void)
 			 __drv_notify_scan_complete);
 }
 
+/* Helper function for notify_config_changed */
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
index fb4d678336e4..fd2c7be683e3 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -132,6 +132,29 @@ struct ap_message;
  */
 #define AP_DRIVER_FLAG_DEFAULT 0x0001
 
+/**
+ * ap_queue_state_transition:
+ *
+ * Used to notify a device driver that a queue state transition has occurred.
+ *
+ * @queue:	the queue device whose state transitioned
+ * @new_state:  identifies the new state to which the queue transitioned:
+ *	AP_QUEUE_CONFIG_ON:		from deconfigured to configured
+ *	AP_QUEUE_CONFIG_OFF:		from configured to deconfigured
+ *	AP_QUEUE_CHKSTOPPED_ON:		from not checkstopped to checkstopped
+ *	AP_QUEUE_CHKSTOPPED_OFF:	from checkstopped to not checkstopped
+ */
+struct ap_qstate_transition {
+	struct ap_queue *queue;
+
+	enum {
+		AP_QUEUE_CONFIG_ON,
+		AP_QUEUE_CONFIG_OFF,
+		AP_QUEUE_CHKSTOP_ON,
+		AP_QUEUE_CHKSTOP_OFF,
+	} new_state;
+};
+
 struct ap_driver {
 	struct device_driver driver;
 
@@ -155,6 +178,12 @@ struct ap_driver {
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
index ffc2d8715bd9..cd4a436c4319 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -841,14 +841,14 @@ static bool _queue_passable(struct vfio_ap_queue *q)
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
@@ -2809,8 +2809,9 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 
 	q->apqn = apqn;
 	q->saved_isc = VFIO_AP_ISC_INVALID;
-	memset(&q->reset_status, 0, sizeof(q->reset_status));
 	INIT_WORK(&q->reset_work, apq_reset_check);
+	vfio_ap_mdev_reset_queue(q);
+	flush_work(&q->reset_work);
 
 	if (matrix_mdev) {
 		vfio_ap_mdev_link_queue(matrix_mdev, q);
@@ -2902,8 +2903,8 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 		vfio_ap_unlink_queue_fr_mdev(q);
 
 	dev_set_drvdata(&apdev->device, NULL);
-	kfree(q);
 	release_update_locks_for_mdev(matrix_mdev);
+	kfree(q);
 }
 
 /**
@@ -3309,3 +3310,46 @@ void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
 
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
+	struct vfio_ap_queue *q = vfio_ap_find_queue(qstate_trans->queue->qid);
+	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
+
+	/*
+	 * If the queue is not bound to the vfio_ap device driver, then it won't
+	 * be passed through to a guest; so, no need to continue.
+	 */
+	if (!q)
+		return;
+
+	get_update_locks_for_mdev(q->matrix_mdev);
+
+	switch (qstate_trans->new_state) {
+	case AP_QUEUE_CONFIG_ON:
+	case AP_QUEUE_CHKSTOP_OFF:
+		vfio_ap_mdev_reset_queue(q);
+		flush_work(&q->reset_work);
+
+		if (q->matrix_mdev) {
+			if (vfio_ap_mdev_filter_matrix(q->matrix_mdev, apm_filtered)) {
+				vfio_ap_mdev_update_guest_apcb(q->matrix_mdev);
+				reset_queues_for_apids(q->matrix_mdev, apm_filtered);
+			}
+		}
+		break;
+	default:
+		break;
+	}
+
+	release_update_locks_for_mdev(q->matrix_mdev);
+}
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 9bff666b0b35..c8b00465d258 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -165,4 +165,6 @@ void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
 void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
 			      struct ap_config_info *old_config_info);
 
+void vfio_ap_on_qstate_transition(struct ap_qstate_transition *qstate_trans);
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.53.0


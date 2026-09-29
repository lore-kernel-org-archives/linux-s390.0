Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CFB51FCB8;
	Tue, 29 Sep 2026 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684336; cv=none; b=p/lD8r5P/6H7WPD9E7Y7NFdgzjN4I+TH7/kaW5ISfpUvGKqUyZMKtNuY2eV2CYsbE1AYWG6H5OuhGFzXi/Yvim4I1CHmCs0SZ1YH/tWK7W+dvRRDASksAh/fVfi0K7h4BLFJg5IgpBgw4Ji7EJfp2E7UMFMQp/9dbW56LbXZeGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684336; c=relaxed/simple;
	bh=piwzpVdrkx8RliL5dGlNzTEKPWrSAgY1w8kgrRQwcNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+zYqqC8IuFMd3HFr6V97s1xSGS7U4S0diLmPn1SlACKW5pXcLWOqaWDZxCeLKDOq+UVG58ti0KRqpjx25/RLg35kK/c/ZHzholhijOOl0LJLAiXQPaGqumnfXqU41nhHJxQPA3u7AsRLbfaXcgsny8PWUkP0qFqDgxjudl6H4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WQgbkgfA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WQgbkgfA"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5NHq2187809;
	Tue, 29 Sep 2026 12:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=owSwyL
	Lu+0tZvAM6MsSQd1RTRF3T63Dgh1lZZ+BrM1s=; b=WQgbkgfA5I0kPYsrpAlBmF
	PCEMWtTXER857YS5o4Y08wmUT4lz/P7mUuhQdoO8PAB34Fw5AqrI2ONng7wZ2Dew
	e+r2sVwCrH2P30d6L93MbTCBZrYqyWdmOjU8NONI8UZ+ENIL2gB+tmaa9OfHMkqX
	DzFw9rUi/QiINLMsLXwxRdshZZwk7DOxMa1obWQRiqgsOCGZkHq+K3TrW9pVjK92
	gA9JvoiHMrKGESkSNPPP5odBPCIjLCqb5y3eold45UrTuSxGW5I2dcAy6Fb7nvj4
	4Q99W4JHNfSDehOn34uhUCaeChqQfqLpzH/XB+X3H/18A2dCrNbmsWnTlHjUZa1g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr6vd2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 12:18:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAldIj1607817;
	Tue, 29 Sep 2026 12:18:42 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsck9m74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 12:18:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TCIfam24183464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 12:18:41 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 240575805D;
	Tue, 29 Sep 2026 12:18:41 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B70F458052;
	Tue, 29 Sep 2026 12:18:39 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.24.130])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 12:18:39 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, freude@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v9 1/6] s390/vfio-ap: Fix leaks of pinned NIB and registered GISC
Date: Tue, 29 Sep 2026 08:18:32 -0400
Message-ID: <20260929121837.2715710-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929121837.2715710-1-akrowiak@linux.ibm.com>
References: <20260929121837.2715710-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX6QWi7Zd9oFp9
 BHn20qkPQjIAykb6cCQ8cyMHiTTcKGMvWjB+9GbqBzRM16OFWxEZAJktLiZ+eZBCufs/hzmdAna
 rPOkmQM2V6L+Av/5CXj53ZNPtWSWqmbg42TQwqyipMpTf5ESVj6lGf7zdnJ6EzNKbDRGsTNFRvA
 t8cavU+oh1IlaftewddTEq78LTU5rwt6EGcDCe8olvISw90c/DF1rIgRxgBYJ5wIr0/Cx0hAsRr
 d0SN/DImEsiSghLV/q7oF+HE+w7Xk5cXx6xrXogjO+T+yWSppvEybEVQy/IO9rkV1u1JlNTaYZg
 YJNTThohJZ2gyAA+T4nrxiMo5TG41YTMiIOtWnE6aNQLm1gqPd7xkcKQfRPY46ea2+pdt04erjj
 QSWTbTinYsNFjAscbXsLsGJax9LnCeIY+feA80S22Cl92UNiVYSr84NqK5xz6cD5aa6DwI7ef6y
 wGNdybthkRRqVMjx37Q==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abbaca3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=tmfMLdCx9Q8aWL4X1S4A:9 a=4Oj6uY-DZbEbJdpd:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Q8suzgtDBL1bBwMNhBi1Ozj9eMG13aDS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfXzGBOMl4uNdgz
 +lzr99+3ELF2NLy7gjEcvgOKt6wpn8SBCQeRC24N7E1QWw0t3qJyWxLUZiiO84rNzV/XCncw0Iy
 qOQ9HqUmZhXWRuZRSLx9gcuOBzRsqvs=
X-Proofpoint-GUID: Q8suzgtDBL1bBwMNhBi1Ozj9eMG13aDS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290048

Several code paths in the vfio_ap driver failed to free the AQIC
resources — the pinned guest NIB page and the registered guest ISC
used to enable interrupts for a queue — when a queue became
unavailable or when unexpected response codes were returned. This
could cause memory exhaustion and depletion of KVM interrupt
subclass registrations over time with repeated dynamic AP
reconfiguration. On the other hand, there are situations whereby
these resources must be intentionally leaked. If the page were
unpinned and returned to the allocator, a subsequent wild DMA-write
to that physical address would corrupt memory belonging to the new
owner and could crash or compromise the host kernel.

vfio_ap_mdev_reset_queue()
~~~~~~~~~~~~~~~~~~~~~~~~~~
AP_RESPONSE_Q_NOT_AVAIL (0x01) was not handled, causing it to fall
through to the default case which only fired a WARN without calling
vfio_ap_free_aqic_resources(). When ap_zapq() returns this response
code the queue is physically unavailable and can no longer generate
AP interrupts or DMA-write to the NIB. Add AP_RESPONSE_Q_NOT_AVAIL
alongside AP_RESPONSE_DECONFIGURED and AP_RESPONSE_CHECKSTOPPED so
that AQIC resources are freed immediately for all three
non-operational cases.

AP_RESPONSE_BUSY is not a valid response code for a PQAP(ZAPQ)
instruction, so it is removed. This contradicts what is stated in
the following:

commit 411b0109daa52 ("s390/vfio-ap: wait for response code 05 to clear on queue reset")

The latest verion of the AP architecture limits response codes for
PQAP_ZAPQ to response codes 01, 02, 03, 04 and 0x0A; 05 is not valid. So in
apq_status_check() - which examines the response codes returned
from PQAP-TAPQ - if the response code is AP_RESPONSE_BUSY (05) - which
is valid for PQAP-TAPQ - it will return -EAGAIN which instructs the caller
(apq_reset_check()) to re-issue the PQAP-ZAPQ instruction.

vfio_ap_mdev_remove_queue()
~~~~~~~~~~~~~~~~~~~~~~~~~~~
When the AP bus scan detects a queue is no longer in the host AP
configuration, vfio_ap_mdev_remove_queue() skips the ZAPQ since
issuing it would return AP_RESPONSE_Q_NOT_AVAIL anyway. However,
vfio_ap_free_aqic_resources() was also never called, leaking the
pinned NIB page and registered guest ISC. Since the hardware is
gone and can no longer DMA-write to the NIB, it is safe to call
vfio_ap_free_aqic_resources() directly. Add an else branch to the
host-config test_bit_inv guard to free AQIC resources when the
queue is not in the host AP configuration. If the queue is not
assigned to an mdev, vfio_ap_free_aqic_resources() is a no-op.

apq_reset_check()
~~~~~~~~~~~~~~~~~
When apq_reset_check() returns from the -EIO path (TAPQ returned
an invalid response code), the TAPQ status is now copied to
q->reset_status. This ensures the queue is marked not-passable —
_queue_passable() checks for AP_RESPONSE_NORMAL — so the queue is
not passed through to a guest.

vfio_ap_irq_disable()
~~~~~~~~~~~~~~~~~~~~~
The valid response codes for PQAP(AQIC) include
AP_RESPONSE_STATE_CHANGE_IN_PROGRESS (0x0a),
AP_RESPONSE_INVALID_GISA (0x08),
AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE (0x35), and
AP_RESPONSE_ASSOC_FAILED (0x36), none of which were explicitly
handled. All four fell through to the default case which freed the
AQIC resources. These each should be handled differently:

* AP_RESPONSE_STATE_CHANGE_IN_PROGRESS indicates a transient
  condition, analogous to AP_RESPONSE_RESET_IN_PROGRESS and
  AP_RESPONSE_BUSY. It is added to the same case as
  RESET_IN_PROGRESS and RESPONSE_BUSY whereby the process sleeps
  for 20ms and the AQIC gets re-executed.

* AP_RESPONSE_INVALID_GISA indicates the AQIC instruction was
  rejected due to an invalid GISA address. The disable did not
  take effect and the hardware still holds the NIB page address.
  If the NIB page were unpinned and returned to the allocator, a
  subsequent wild DMA-write to that physical address would corrupt
  memory belonging to the new owner and could crash or compromise
  the host kernel; so the AQIC resources must be intentionally
  leaked.

* AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE and AP_RESPONSE_ASSOC_FAILED
  are asynchronous response codes from a previously executed
  association instruction. All subsequent AQIC calls will end with
  the asynchronous response code until the queue is reset;
  therefore the AQIC disable was not executed and the hardware
  still holds the NIB address. If the NIB page were unpinned and
  returned to the allocator, a subsequent wild DMA-write to that
  physical address would corrupt memory belonging to the new owner
  and could crash or compromise the host kernel; so the AQIC
  resources must be intentionally leaked.

After a return from vfio_ap_wait_for_irqclear(),
vfio_ap_irq_disable() frees the AQIC resources; however,
vfio_ap_wait_for_irqclear() can return for a number of reasons
which each require a different response:

* Timed out waiting for the IR bit to be cleared (indicates
  interrupts are disabled). In this case, the hardware still holds
  the NIB address. If the NIB page were unpinned and returned to
  the allocator, a subsequent wild DMA-write to that physical
  address would corrupt memory belonging to the new owner and
  could crash or compromise the host kernel; so the AQIC resources
  must be intentionally leaked.

* The response code from TAPQ indicates the queue is disabled,
  not in the host's AP configuration, or not functional. In any
  case, it is safe to free the AQIC resources.

* An invalid response code was returned from TAPQ. In this case,
  the hardware may still hold the NIB address; so the AQIC
  resources must be intentionally leaked.

The solution here is to change vfio_ap_wait_for_irqclear() to
return a code indicating the result, allowing vfio_ap_irq_disable()
to respond accordingly:
 * 0:         interrupt disablement is verified
 * -ENODEV:   the queue is not functional
 * -ETIMEDOUT: timed out without verifying interrupts disabled
 * -EIO:      an invalid response code was returned from TAPQ

vfio_ap_free_aqic_resources()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The function used q->matrix_mdev->kvm and &q->matrix_mdev->vdev
when releasing the registered guest ISC and pinned NIB page
respectively. This is correct on the normal teardown path, but
becomes wrong when a queue reset times out and AQIC resources are
intentionally retained across a guest lifecycle. If the mdev is
subsequently opened by a new guest (new KVM, new IOMMU container),
a later call to vfio_ap_free_aqic_resources() — for example from
vfio_ap_irq_enable() when the new guest enables interrupts — would
release the old resources against the new guest's KVM and
vfio_device. This produces two bugs:

* kvm_s390_gisc_unregister(new_kvm, old_isc) drops a reference
  the new KVM never took. If the new guest uses the same ISC
  (Linux guests always use ISC 0), the refcount reaches zero and
  the alert mask bit is cleared while the queue is live, silently
  stopping AP interrupt delivery to the new guest.

* vfio_unpin_pages(new_vdev, old_iova) unpins from the wrong IOMMU
  container. The iommufd backend hits WARN_ON(!access); the type1
  backend hits WARN_ON(i != npage). The original pin in the old
  container is never dropped, causing vfio to warn about a
  non-empty pfn_list when that container is torn down.

Fix this by introducing struct vfio_ap_aqic_resources, which groups
the ISC, NIB IOVA, and the owning vfio_device and KVM together.
The struct replaces the standalone saved_isc and saved_iova fields
in struct vfio_ap_queue. vfio_ap_irq_enable() snapshots the owning
vdev and kvm at acquire time alongside the iova and isc.
vfio_ap_free_aqic_resources() then always releases each resource
against its original owner.

For the NIB page, aqic_resources.vdev (the vfio_device whose IOMMU
container holds the pin) is used unconditionally.

For the ISC, aqic_resources.kvm is compared against
q->matrix_mdev->kvm before calling kvm_s390_gisc_unregister(). If
they match, the same guest that registered the ISC is still running
and the unregister call proceeds normally. If they differ or the
current KVM is NULL, the original guest has already been shut down;
kvm_s390_gisa_destroy() will have zeroed the alert mask as part of
that guest's teardown, so calling unregister is unnecessary. A
warning is emitted to record that the ISC registration was not
explicitly released by this driver.

unmap_iova()
~~~~~~~~~~~~
Calls vfio_ap_irq_disable() to disable interrupts for the queue,
but does not check the result. If the IRQ disable failed or could
not be confirmed, then vfio_ap_irq_disable() leaks the NIB to
prevent a wild DMA-write; however, the vfio core requires that the
NIB page be unpinned before dma_unmap returns, or it will BUG_ON
after 10 re-notification rounds.

The fix is to fall back to a bounded queue reset via ZAPQ, which
zeroizes the NIB pointer in the hardware, eliminating the DMA risk
that justified the leak. If the reset completes, the worker frees
the AQIC resources. If the reset times out or fails, the resources
are kept leaked to guard against wild DMA writes.

Fixes: ec89b55e3bce7 ("s390: ap: implement PAPQ AQIC interception in kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 433 +++++++++++++++++++++-----
 drivers/s390/crypto/vfio_ap_private.h |  49 ++-
 2 files changed, 390 insertions(+), 92 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 4db878c18f41..e178b657faa8 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -31,6 +31,7 @@
 #define AP_QUEUE_IN_USE "in use"
 
 #define AP_RESET_INTERVAL		20	/* Reset sleep interval (20ms)		*/
+#define AP_RESET_MAX_WAIT		2000	/* Maximum wait for reset (2000ms)	*/
 
 static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
 static int vfio_ap_mdev_reset_qlist(struct list_head *qlist);
@@ -226,27 +227,48 @@ static struct vfio_ap_queue *vfio_ap_mdev_get_queue(
 }
 
 /**
- * vfio_ap_wait_for_irqclear - clears the IR bit or gives up after 5 tries
- * @apqn: The AP Queue number
- *
- * Checks the IRQ bit for the status of this APQN using ap_tapq.
- * Returns if the ap_tapq function succeeded and the bit is clear.
- * Returns if ap_tapq function failed with invalid, deconfigured or
- * checkstopped AP.
- * Otherwise retries up to 5 times after waiting 20ms.
+ * vfio_ap_wait_for_irqclear - wait for the IR bit to clear after a disable
+ *
+ * @apqn:		the APQN of the queue
+ * @tapq_status:	used to return the TAPQ status to the caller
+ *
+ * Repeatedly polls the AP queue status via PQAP(TAPQ) every 20ms until the IR
+ * bit is clear, the queue becomes non-operational, or 5 retries are exhausted.
+ *
+ * Because PQAP(AQIC) disable initiates an asynchronous process, a
+ * condition-code 0 completion does not guarantee the IR bit has been cleared.
+ * The host must confirm IR=0 before unpinning the NIB page to avoid a wild
+ * DMA write to a freed page.
+ *
+ * Return:
+ * 0		if the IR bit is clear (i.e., interrupts are disabled).
+ *
+ * -ENODEV	if the PQAP-TAPQ response code indicates the queue is not available,
+ *		is deconfigured, or is checkstopped (i.e., not operational).
+ *
+ * -ETIMEDOUT	the function timed out before the IR bit was cleared, or TAPQ
+ *		returned AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE or
+ *		AP_RESPONSE_ASSOC_FAILED, which mean the instruction was not
+ *		executed and will continue to be returned for all subsequent
+ *		instructions except ZAPQ until the queue is reset. Since IR=0
+ *		cannot be confirmed, the NIB must be treated as a potential DMA
+ *		target and leaked rather than freed.
+ *
+ * -EIO		PQAP-TAPQ returned an invalid response code
  */
-static void vfio_ap_wait_for_irqclear(int apqn)
+static int vfio_ap_wait_for_irqclear(int apqn, struct ap_queue_status *tapq_status)
 {
 	struct ap_queue_status status;
 	int retry = 5;
 
 	do {
 		status = ap_tapq(apqn, NULL);
+		memcpy(tapq_status, &status, sizeof(status));
 		switch (status.response_code) {
 		case AP_RESPONSE_NORMAL:
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 			if (!status.irq_enabled)
-				return;
+				return 0;
 			fallthrough;
 		case AP_RESPONSE_BUSY:
 			msleep(20);
@@ -254,90 +276,231 @@ static void vfio_ap_wait_for_irqclear(int apqn)
 		case AP_RESPONSE_Q_NOT_AVAIL:
 		case AP_RESPONSE_DECONFIGURED:
 		case AP_RESPONSE_CHECKSTOPPED:
+			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
+				  status.response_code, apqn);
+			return -ENODEV;
+		case AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE:
+		case AP_RESPONSE_ASSOC_FAILED:
+			/*
+			 * The TAPQ instruction was not executed. Executing TAPQ
+			 * again will result in the same error until the queue
+			 * is reset. We should't, however, reset the queue in
+			 * this context, so log a warning and return -ETIMEDOUT
+			 * since that would happen anyway if we continued to
+			 * execute the TAPQ.
+			 */
+			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
+				  status.response_code, apqn);
+			return -ETIMEDOUT;
 		default:
 			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
 				  status.response_code, apqn);
-			return;
+			return -EIO;
 		}
 	} while (--retry);
 
-	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
-		  __func__, status.response_code, apqn);
+	WARN_ONCE(1, "%s: tapq rc %02x: timed out waiting for interrupts disabled for %02x.%04x\n",
+		  __func__, status.response_code,
+		  AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+	return -ETIMEDOUT;
+}
+
+static void report_gisc_unregister_failure(struct vfio_ap_queue *q)
+{
+	if (q->matrix_mdev) {
+		dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+				     "APQN %02x.%04x: Failed to unregister guest ISC %d\n",
+				     AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
+				     q->aqic_resources.isc);
+	} else {
+		pr_warn_ratelimited("APQN %02x.%04x: Failed to unregister guest ISC %d\n",
+				    AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
+				    q->aqic_resources.isc);
+	}
 }
 
 /**
- * vfio_ap_free_aqic_resources - free vfio_ap_queue resources
+ * vfio_ap_free_aqic_resources - free vfio_ap_queue AQIC resources
  * @q: The vfio_ap_queue
  *
- * Unregisters the ISC in the GIB when the saved ISC not invalid.
- * Unpins the guest's page holding the NIB when it exists.
- * Resets the saved_iova and saved_isc to invalid values.
+ * Unregisters the ISC from the GIB and unpins the NIB page, using the KVM
+ * instance and vfio_device snapshotted at enable time in q->aqic_res.
+ *
+ * For the ISC: if the KVM that registered it (q->aqic_res.kvm) is still the
+ * current guest (q->matrix_mdev->kvm), call kvm_s390_gisc_unregister() to
+ * drop the registration cleanly. If the KVM has changed or is gone, the
+ * original guest's kvm_s390_gisa_destroy() will have already zeroed the alert
+ * mask on shutdown, so there is nothing to unregister and the stale pointer
+ * set to NULL so it will not be subsequently dereferenced.
+ *
+ * For the NIB: always use q->aqic_res.vdev — the vfio_device that owns the
+ * IOMMU container in which the page was pinned — regardless of what
+ * q->matrix_mdev currently points to.
  */
 static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
 {
 	if (!q)
 		return;
-	if (q->saved_isc != VFIO_AP_ISC_INVALID) {
-		if (!WARN_ON(!q->matrix_mdev) && q->matrix_mdev->kvm)
-			kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->saved_isc);
-		q->saved_isc = VFIO_AP_ISC_INVALID;
+
+	if (q->aqic_resources.isc != VFIO_AP_ISC_INVALID) {
+		if (q->aqic_resources.kvm &&
+		    q->matrix_mdev && q->aqic_resources.kvm == q->matrix_mdev->kvm) {
+			kvm_s390_gisc_unregister(q->aqic_resources.kvm, q->aqic_resources.isc);
+		} else {
+			report_gisc_unregister_failure(q);
+		}
+		q->aqic_resources.isc = VFIO_AP_ISC_INVALID;
+		q->aqic_resources.kvm = NULL;
 	}
-	if (q->saved_iova && !WARN_ON(!q->matrix_mdev)) {
-		vfio_unpin_pages(&q->matrix_mdev->vdev, q->saved_iova, 1);
-		q->saved_iova = 0;
+
+	if (q->aqic_resources.iova) {
+		if (q->aqic_resources.vdev)
+			vfio_unpin_pages(q->aqic_resources.vdev, q->aqic_resources.iova, 1);
+		else
+			pr_warn_ratelimited("APQN %02x.%04x: Failed to unpin NIB page at %pad\n",
+					    AP_QID_CARD(q->apqn),
+					    AP_QID_QUEUE(q->apqn),
+					    &q->aqic_resources.iova);
+		q->aqic_resources.iova = 0;
+		q->aqic_resources.vdev = NULL;
 	}
 }
 
 /**
- * vfio_ap_irq_disable - disables and clears an ap_queue interrupt
- * @q: The vfio_ap_queue
+ * vfio_ap_irq_disable - disable interrupts for an AP queue
+ * @q: the vfio_ap_queue
  *
- * Uses ap_aqic to disable the interruption and in case of success, reset
- * in progress or IRQ disable command already proceeded: calls
- * vfio_ap_wait_for_irqclear() to check for the IRQ bit to be clear
- * and calls vfio_ap_free_aqic_resources() to free the resources associated
- * with the AP interrupt handling.
+ * Issues PQAP(AQIC) to disable interrupts for the AP queue. On success
+ * (AP_RESPONSE_NORMAL or AP_RESPONSE_OTHERWISE_CHANGED), polls via
+ * vfio_ap_wait_for_irqclear() until the IR bit is confirmed clear before
+ * freeing the pinned NIB page and unregistering the guest ISC. This wait is
+ * necessary because AQIC disable is asynchronous: freeing the NIB before IR=0
+ * is confirmed risks a wild DMA write to a freed host page.
  *
- * In the case the AP is busy, or a reset is in progress,
- * retries after 20ms, up to 5 times.
+ * Retries up to 5 times (with 20ms sleep) if the queue is busy or a reset is
+ * in progress.
  *
- * Returns if ap_aqic function failed with invalid, deconfigured or
- * checkstopped AP.
+ * If the IR bit cannot be confirmed clear (timeout), the NIB page and guest
+ * ISC are intentionally leaked. If the page were unpinned and returned to the
+ * allocator, a subsequent hardware DMA write to that physical address would
+ * corrupt memory belonging to a new owner — a wild DMA write that could crash
+ * or compromise the host kernel.
+ *
+ * If the queue is non-operational (deconfigured, checkstopped, not available),
+ * resources are freed immediately since the hardware can no longer write to
+ * the NIB.
  *
  * Return: &struct ap_queue_status
  */
 static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 {
 	union ap_qirq_ctrl aqic_gisa = { .value = 0 };
-	struct ap_queue_status status;
-	int retries = 5;
+	struct ap_queue_status status, tapq_status;
+	int retries = 5, ret;
 
 	do {
 		status = ap_aqic(q->apqn, aqic_gisa, 0);
 		switch (status.response_code) {
 		case AP_RESPONSE_OTHERWISE_CHANGED:
 		case AP_RESPONSE_NORMAL:
-			vfio_ap_wait_for_irqclear(q->apqn);
-			goto end_free;
+			/*
+			 * AQIC disable was accepted (NORMAL), or the queue was
+			 * already disabled or a prior async request is still
+			 * completing (OTHERWISE_CHANGED).  In both cases, we must
+			 * wait until interrupt processing has been disabled
+			 * before proceeding.
+			 */
+			ret = vfio_ap_wait_for_irqclear(q->apqn, &tapq_status);
+			if (ret == 0 || ret == -ENODEV)
+				goto end_free;
+
+			if (ret == -EIO) {
+				/*
+				 * An unknown TAPQ response code was returned which
+				 * indicates a bug or some type of hardware I/O issue.
+				 * Since we don't know whether queue interrupts were
+				 * disabled or not, the AQIC resources must be leaked.
+				 */
+				memcpy(&status, &tapq_status, sizeof(status));
+				goto end_fail;
+			}
+
+			/* Timed out waiting to confirm interrupts are disabled */
+			if (tapq_status.response_code == AP_RESPONSE_NORMAL ||
+			    tapq_status.response_code == AP_RESPONSE_BUSY) {
+				/*
+				 * If AQIC returned NORMAL, the guest would incorrectly
+				 * interpret that as a successful disable and may free or
+				 * reuse the NIB while hardware can still write to it.
+				 * AP_RESPONSE_BUSY is not valid for PQAP-AQIC.
+				 *
+				 * Return OTHERWISE_CHANGED to signal to the guest that
+				 * the disable interrupts operation did not complete.
+				 */
+				memset(&status, 0, sizeof(status));
+				status.response_code = AP_RESPONSE_OTHERWISE_CHANGED;
+			} else {
+				/*
+				 * For all other TAPQ response codes,
+				 * return the TAPQ status directly since those
+				 * codes are also valid for AQIC.
+				 */
+				memcpy(&status, &tapq_status, sizeof(status));
+			}
+			goto end_fail;
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 		case AP_RESPONSE_BUSY:
+		case AP_RESPONSE_STATE_CHANGE_IN_PROGRESS:
 			msleep(20);
 			break;
 		case AP_RESPONSE_Q_NOT_AVAIL:
 		case AP_RESPONSE_DECONFIGURED:
 		case AP_RESPONSE_CHECKSTOPPED:
+			/* AP not operational; no further interrupts possible */
+			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
+				  status.response_code);
+			goto end_free;
 		case AP_RESPONSE_INVALID_ADDRESS:
+		case AP_RESPONSE_INVALID_GISA:
+		case AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE:
+		case AP_RESPONSE_ASSOC_FAILED:
 		default:
-			/* All cases in default means AP not operational */
+			/*
+			 * The AQIC disable was rejected; IRQ is still enabled
+			 * and the hardware still holds the NIB address. Do not
+			 * free resources.
+			 */
 			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
 				  status.response_code);
-			goto end_free;
+			goto end_fail;
 		}
 	} while (retries--);
 
 	WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
 		  status.response_code);
+
+end_fail:
+	/*
+	 * We are here either because the AQIC instruction failed to disable
+	 * interrupts, or because IR=0 could not be confirmed. In either case
+	 * the NIB page and guest ISC cannot be freed: hardware may still write
+	 * to the NIB, and unpinning the page would allow it to be reallocated
+	 * to a new owner. A subsequent hardware DMA write to that physical
+	 * address would corrupt the new owner's memory — a wild DMA write that
+	 * could crash or compromise the host kernel. The resources are
+	 * therefore intentionally leaked.
+	 */
+	return status;
+
 end_free:
+	/*
+	 * This label is reached because the queue was successfully disabled,
+	 * or because the queue is not operational or not available, in which case
+	 * interrupts can not be processed, so free the AQIC resources - the pinned NIB
+	 * page and the registered guest ISC - used to enable interrupts so they will
+	 * not be leaked.
+	 */
 	vfio_ap_free_aqic_resources(q);
 	return status;
 }
@@ -401,22 +564,29 @@ static int ensure_nib_shared(unsigned long addr)
 }
 
 /**
- * vfio_ap_irq_enable - Enable Interruption for a APQN
+ * vfio_ap_irq_enable - enable interrupts for an AP queue on behalf of a guest
  *
- * @q:	 the vfio_ap_queue holding AQIC parameters
+ * @q:	 the vfio_ap_queue for which interrupts are to be enabled
  * @isc: the guest ISC to register with the GIB interface
- * @vcpu: the vcpu object containing the registers specifying the parameters
- *	  passed to the PQAP(AQIC) instruction.
+ * @vcpu: the vcpu whose registers contain the PQAP(AQIC) parameters
  *
- * Pin the NIB saved in *q
- * Register the guest ISC to GIB interface and retrieve the
- * host ISC to issue the host side PQAP/AQIC
+ * Pins the guest NIB page, registers the guest ISC with the GIB to obtain a
+ * host ISC, and reissues PQAP(AQIC) with the translated host-absolute NIB
+ * address and host ISC on behalf of the guest.
  *
- * status.response_code may be set to AP_RESPONSE_INVALID_ADDRESS in case the
- * vfio_pin_pages or kvm_s390_gisc_register failed.
+ * The condition code and AP-queue status word returned by PQAP(AQIC) are
+ * reflected back to the guest as-is. IRQ state verification (polling until
+ * IR=1) is the responsibility of the guest AP bus, not the host.
  *
- * Otherwise return the ap_queue_status returned by the ap_aqic(),
- * all retry handling will be done by the guest.
+ * Resource management is based solely on whether hardware accepted the new NIB:
+ * - AP_RESPONSE_NORMAL (CC=0): hardware accepted the new NIB; the old pinned
+ *   NIB page and registered guest ISC are freed and the new ones saved.
+ * - All other responses: hardware did not accept the new NIB; the newly pinned
+ *   page and registered ISC are freed and the previously saved resources are
+ *   left intact.
+ *
+ * AP_RESPONSE_INVALID_ADDRESS is returned if vfio_pin_pages() or
+ * kvm_s390_gisc_register() fails before the AQIC instruction is issued.
  *
  * Return: &struct ap_queue_status
  */
@@ -428,11 +598,10 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 	struct ap_queue_status status = {};
 	struct kvm_s390_gisa *gisa;
 	struct page *h_page;
-	int nisc;
+	int nisc, ret;
 	struct kvm *kvm;
 	phys_addr_t h_nib;
 	dma_addr_t nib;
-	int ret;
 
 	/* Verify that the notification indicator byte address is valid */
 	if (vfio_ap_validate_nib(vcpu, &nib)) {
@@ -489,27 +658,48 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 	status = ap_aqic(q->apqn, aqic_gisa, h_nib);
 	switch (status.response_code) {
 	case AP_RESPONSE_NORMAL:
-		/* See if we did clear older IRQ configuration */
+		/*
+		 * Hardware accepted the new NIB address (CC=0). The old NIB and
+		 * guest ISC are no longer used by hardware and can be freed.
+		 * The new resources are saved for tracking and future teardown.
+		 *
+		 * IRQ state verification (polling until IR=1) is the
+		 * responsibility of the guest AP bus, not the host. The
+		 * condition code and status word are reflected back to the
+		 * guest to respond to the PQAP-AQIC instruction.
+		 */
 		vfio_ap_free_aqic_resources(q);
-		q->saved_iova = nib;
-		q->saved_isc = isc;
+		q->aqic_resources.iova = nib;
+		q->aqic_resources.isc  = isc;
+		q->aqic_resources.vdev = &q->matrix_mdev->vdev;
+		q->aqic_resources.kvm  = q->matrix_mdev->kvm;
 		break;
 	case AP_RESPONSE_OTHERWISE_CHANGED:
-		/* We could not modify IRQ settings: clear new configuration */
+		/*
+		 * Interrupts are already enabled or a prior async request is still
+		 * completing. Either way, the hardware's current NIB is the one
+		 * saved in q->aqic_res — not the newly prepared resources.
+		 * Release the newly pinned page and registered ISC;
+		 * leave aqic_res intact.
+		 */
+		fallthrough;
+	default:
+		/*
+		 * Hardware did not accept the new NIB (CC=3 or error). The
+		 * previously saved NIB and guest ISC remain active and must
+		 * not be freed. Release the newly pinned page and registered
+		 * ISC that were prepared for this (rejected) request.
+		 */
 		ret = kvm_s390_gisc_unregister(kvm, isc);
 		if (ret)
 			VFIO_AP_DBF_WARN("%s: kvm_s390_gisc_unregister: rc=%d isc=%d, apqn=%#04x\n",
 					 __func__, ret, isc, q->apqn);
 		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
 		break;
-	default:
-		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
-			status.response_code);
-		vfio_ap_irq_disable(q);
-		break;
 	}
 
-	if (status.response_code != AP_RESPONSE_NORMAL) {
+	if (status.response_code != AP_RESPONSE_NORMAL &&
+	    status.response_code != AP_RESPONSE_OTHERWISE_CHANGED) {
 		VFIO_AP_DBF_WARN("%s: PQAP(AQIC) failed with status=%#02x: "
 				 "zone=%#x, ir=%#x, gisc=%#x, f=%#x,"
 				 "gisa=%#x, isc=%#x, apqn=%#04x\n",
@@ -635,7 +825,6 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	}
 
 	status = vcpu->run->s.regs.gprs[1];
-
 	/* If IR bit(16) is set we enable the interrupt */
 	if ((status >> (63 - 16)) & 0x01)
 		qstatus = vfio_ap_irq_enable(q, status & 0x07, vcpu);
@@ -1857,8 +2046,29 @@ static void unmap_iova(struct ap_matrix_mdev *matrix_mdev, u64 iova, u64 length)
 	int loop_cursor;
 
 	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
-		if (q->saved_iova >= iova && q->saved_iova < iova + length)
+		if (q->aqic_resources.iova >= iova && q->aqic_resources.iova < iova + length) {
 			vfio_ap_irq_disable(q);
+			/*
+			 * If AQIC disable was unable to confirm that interrupts were
+			 * disabled (IR=0), q->aqic_res.iova remains non-zero. VFIO
+			 * core requires the mapped pages to be unpinned during DMA
+			 * unmap notifications (or type1 IOMMU will BUG_ON after 10
+			 * retries).
+			 *
+			 * To satisfy VFIO core safely, fall back to a queue reset via
+			 * ZAPQ. ZAPQ wipes the queue state and clears the hardware's
+			 * internal NIB address register, neutralizing pending DMA.
+			 *
+			 * Flush the reset worker. If the reset completes, the worker
+			 * frees the AQIC resources (unpinning the NIB). If the reset
+			 * times out or fails with an error, the resources are kept
+			 * leaked to guard against wild DMA writes.
+			 */
+			if (q->aqic_resources.iova) {
+				vfio_ap_mdev_reset_queue(q);
+				flush_work(&q->reset_work);
+			}
+		}
 	}
 }
 
@@ -1919,20 +2129,54 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
 {
 	switch (status->response_code) {
 	case AP_RESPONSE_NORMAL:
+		/*
+		 * This response code only indicates that the PQAP(ZAPQ) has
+		 * been initiated. The following bit settings in the status
+		 * returned from TAPQ must be verified to confirm that the
+		 * asynchronous portion of the queue zeroization has completed.
+		 */
+		if (status->queue_empty && !status->replies_waiting &&
+		    !status->irq_enabled && !status->async)
+			return 0;
+
+		/* Async zeroization still in progress; keep waiting */
+		return -EBUSY;
+
 	case AP_RESPONSE_DECONFIGURED:
 	case AP_RESPONSE_CHECKSTOPPED:
-		return 0;
+		/*
+		 * The queue is non-operational: interrupts are not possible so
+		 * AQIC resources can be safely freed. However, zeroization
+		 * cannot be confirmed because all status bits are zeroed when
+		 * these response codes are returned — there is no way to
+		 * distinguish a zeroized queue from one that has not been
+		 * zeroized. Return -ENODEV to signal that AQIC resources should
+		 * be freed but that zeroization has not been confirmed.
+		 */
+		return -ENODEV;
+
 	case AP_RESPONSE_RESET_IN_PROGRESS:
-	case AP_RESPONSE_BUSY:
+		/*
+		 * A reset is in progress. It may be the reset we issued or one
+		 * issued prior to ours; either way, once it completes the queue
+		 * will be zeroized, so keep waiting.
+		 */
 		return -EBUSY;
+
+	case AP_RESPONSE_BUSY:
 	case AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE:
 	case AP_RESPONSE_ASSOC_FAILED:
 		/*
+		 * AP_RESPONSE_BUSY:
+		 * The queue is busy with something unrelated to a reset and our
+		 * ZAPQ was rejected outright. Re-issue the ZAPQ.
+		 *
+		 * AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE
+		 * AP_RESPONSE_ASSOC_FAILED:
 		 * These asynchronous response codes indicate a PQAP(AAPQ)
 		 * instruction to associate a secret with the guest failed. All
 		 * subsequent AP instructions will end with the asynchronous
-		 * response code until the AP queue is reset; so, let's return
-		 * a value indicating a reset needs to be performed again.
+		 * response code until the AP queue is reset. Re-issue the ZAPQ.
 		 */
 		return -EAGAIN;
 	case AP_RESPONSE_Q_NOT_AVAIL:
@@ -1961,10 +2205,23 @@ static void apq_reset_check(struct work_struct *reset_work)
 		elapsed += AP_RESET_INTERVAL;
 		status = ap_tapq(q->apqn, NULL);
 		ret = apq_status_check(q->apqn, &status);
-		if (ret == -EIO)
-			return;
-		if (ret == -ENODEV) {
-			vfio_ap_free_aqic_resources(q);
+		if (ret == -EIO) {
+			/*
+			 * TAPQ returned an invalid response code indicating a
+			 * hardware or firmware bug. Since we cannot determine
+			 * whether the queue can still DMA-write to the NIB, the
+			 * AQIC resources are intentionally leaked lest the NIB
+			 * page is reallocated to a new owner. A subsequent
+			 * wild DMA-write to that physical address would corrupt
+			 * the new owner's memory which could crash or compromise
+			 * the host kernel.
+			 *
+			 * Record the TAPQ status so the queue is marked
+			 * not-passable - _queue_passable() checks
+			 * reset_status.response_code == AP_RESPONSE_NORMAL -
+			 * and the queue is not passed through to a guest.
+			 */
+			memcpy(&q->reset_status, &status, sizeof(status));
 			return;
 		}
 		if (ret == -EBUSY) {
@@ -1983,8 +2240,12 @@ static void apq_reset_check(struct work_struct *reset_work)
 				memcpy(&q->reset_status, &status, sizeof(status));
 				continue;
 			}
-			if (q->saved_isc != VFIO_AP_ISC_INVALID)
-				vfio_ap_free_aqic_resources(q);
+			/*
+			 * We end up here when the ZAPQ has completed. ZAPQ
+			 * disables interrupts, so the AQIC resources must be
+			 * freed; otherwise they will be leaked.
+			 */
+			vfio_ap_free_aqic_resources(q);
 			break;
 		}
 	}
@@ -2001,7 +2262,6 @@ static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
 	switch (status.response_code) {
 	case AP_RESPONSE_NORMAL:
 	case AP_RESPONSE_RESET_IN_PROGRESS:
-	case AP_RESPONSE_BUSY:
 	case AP_RESPONSE_STATE_CHANGE_IN_PROGRESS:
 		/*
 		 * Let's verify whether the ZAPQ completed successfully on a work queue.
@@ -2014,6 +2274,15 @@ static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
 		vfio_ap_free_aqic_resources(q);
 		break;
 	default:
+		/*
+		 * An invalid response code indicates a hardware or firmware bug.
+		 * Since we cannot determine whether the queue can still
+		 * DMA-write to the NIB, the AQIC resources are intentionally
+		 * leaked lest the NIB page is reallocated to a new owner. A
+		 * subsequent hardware wild DMA-write to that physical address
+		 * would corrupt the new owner's memory which could crash or
+		 * compromise the host kernel.
+		 */
 		WARN(true,
 		     "PQAP/ZAPQ for %02x.%04x failed with invalid rc=%u\n",
 		     AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
@@ -2463,7 +2732,8 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 	}
 
 	q->apqn = apqn;
-	q->saved_isc = VFIO_AP_ISC_INVALID;
+	q->aqic_resources.isc = VFIO_AP_ISC_INVALID;
+	/* aqic_res.iova, .vdev, .kvm all zero-initialised by kzalloc_obj */
 	memset(&q->reset_status, 0, sizeof(q->reset_status));
 	INIT_WORK(&q->reset_work, apq_reset_check);
 
@@ -2543,6 +2813,13 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 		vfio_ap_mdev_reset_queue(q);
 		flush_work(&q->reset_work);
 	} else {
+		/*
+		 * The queue is no longer in the host's AP configuration.
+		 * The hardware cannot DMA-write to the NIB, so it is safe
+		 * to free the AQIC resources directly without issuing a
+		 * ZAPQ. If the queue is not assigned to an mdev,
+		 * vfio_ap_free_aqic_resources() is a no-op.
+		 */
 		vfio_ap_free_aqic_resources(q);
 	}
 
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 9bff666b0b35..5eb0936d9183 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -127,29 +127,50 @@ struct ap_matrix_mdev {
 	DECLARE_BITMAP(adm_add, AP_DOMAINS);
 };
 
+/**
+ * struct vfio_ap_aqic_resources - Free the AQIC resources acquired when a guest
+ *				   enables interrupts for an AP queue.
+ *
+ * @iova: the guest DMA address of the notification indicator byte (NIB) page,
+ *	  pinned via @vdev at enable time.
+ * @isc:  the guest interruption sub-class registered with the GIB via @kvm at
+ *	  enable time.
+ * @vdev: the vfio_device whose IOMMU container owns the pin on @iova. Must be
+ *	  used for vfio_unpin_pages() to ensure the correct container is used,
+ *	  even if the queue is later re-assigned or the mdev is reopened.
+ * @kvm:  the KVM instance that owns the GISC registration for @isc. Must be
+ *	  used for kvm_s390_gisc_unregister() to ensure the correct guest's
+ *	  alert mask is updated, even if the queue is later re-assigned or the
+ *	  mdev is reopened with a different guest.
+ */
+struct vfio_ap_aqic_resources {
+	dma_addr_t			iova;
+#define VFIO_AP_ISC_INVALID	0xff
+	unsigned char			isc;
+	struct vfio_device		*vdev;
+	struct kvm			*kvm;
+};
+
 /**
  * struct vfio_ap_queue - contains the data associated with a queue bound to the
  *			  vfio_ap device driver
  * @matrix_mdev: the matrix mediated device
- * @saved_iova: the notification indicator byte (nib) address
- * @apqn: the APQN of the AP queue device
- * @saved_isc: the guest ISC registered with the GIB interface
- * @mdev_qnode: allows the vfio_ap_queue struct to be added to a hashtable
+ * @aqic_res:    the AQIC resources acquired when a guest enables AP interrupts
+ * @apqn:        the APQN of the AP queue device
+ * @mdev_qnode:  allows the vfio_ap_queue struct to be added to a hashtable
  * @reset_qnode: allows the vfio_ap_queue struct to be added to a list of queues
  *		 that need to be reset
  * @reset_status: the status from the last reset of the queue
- * @reset_work: work to wait for queue reset to complete
+ * @reset_work:  work to wait for queue reset to complete
  */
 struct vfio_ap_queue {
-	struct ap_matrix_mdev *matrix_mdev;
-	dma_addr_t saved_iova;
-	int	apqn;
-#define VFIO_AP_ISC_INVALID 0xff
-	unsigned char saved_isc;
-	struct hlist_node mdev_qnode;
-	struct list_head reset_qnode;
-	struct ap_queue_status reset_status;
-	struct work_struct reset_work;
+	struct ap_matrix_mdev		*matrix_mdev;
+	struct vfio_ap_aqic_resources	aqic_resources;
+	int				apqn;
+	struct hlist_node		mdev_qnode;
+	struct list_head		reset_qnode;
+	struct ap_queue_status		reset_status;
+	struct work_struct		reset_work;
 };
 
 int vfio_ap_mdev_register(void);
-- 
2.53.0


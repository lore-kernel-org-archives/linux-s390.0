Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4539041CB31;
	Fri, 25 Sep 2026 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340366; cv=none; b=PopO0i9aRHPbe8KVVz98t9uCeTPYPE42Sk+sqgGTI/liMhDFYYlbNTuaemox+KuLk2msmUP9CwnxMidwXkUJuwuyRfdkBHONj/MJGt5uX9wLQDTahr7bwZ3Aef9f0+AdVICcLsT+zDmb0m0dE1i1s+YaNmPas8j6/ntaCOLxYA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340366; c=relaxed/simple;
	bh=C9V4Mi152XiHiIxCKWaO4EDg00My7jHKZe8Z0Knn9Go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EUiZXQ0eWStxvtykreXO8a5SFWdNjIQ70eLYGg0vAq0M0FIa6np9MoZr3GGGb2uzQ+pMxcg2cVW95x1m3qiG0v71ATihAjyLiyG6ELtCCk8ABnI2PdP2x4cFMIX+W9Txr2uZcCAWAiPTFzvCmd13zFDXFNJs1q7KCl/tw5rZM88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ThQpFdW1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ThQpFdW1"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4ZppK074220;
	Fri, 25 Sep 2026 12:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=8gigDMLqkUy0wGDEXbeqsvvZmKgo
	NsKJVo1ZXirwG+s=; b=ThQpFdW1UFzhg7a/Bo3e5LXBa900+FkWDB42RejW3SEN
	2NfOSRmykUL8HJD03qyZdlqrepGBaKHDn2LB7/HYuwp1Wyi3RMMY1cbYAkFwIzOB
	L04vUy9e4TzJEb4lx6tNVmam6TZJuAj6xZckTRpZcnGc/MfjpuafGVudUyD9u9CK
	Z4lXXMQZ5R9hEDIAt0aTJ1UEJ4rv266llMKGu37pUQFKTh4HZrC5Dklxe5To4CWD
	XrWJmzGjMctWk0TOW+/xMp2GVFDhS58v/jGWbBLCeUVXKUOYqq66IeO2aV+LLP13
	pgQtDTYiANq8fF+29IbSWDfwtdk9edl/CGvtCdRlcg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2y5gx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 12:45:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PA0KgU1959522;
	Fri, 25 Sep 2026 12:45:55 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7eemk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 12:45:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PCjrLV49545570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 12:45:53 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42A0958052;
	Fri, 25 Sep 2026 12:45:53 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2F7358056;
	Fri, 25 Sep 2026 12:45:51 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.86.59])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 12:45:51 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, freude@linux.ibm.com
Subject: [PATCH v8 0/6] s390/vfio-ap: Fix pre-existing bugs in vfio_ap device driver
Date: Fri, 25 Sep 2026 08:45:45 -0400
Message-ID: <20260925124551.665448-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IuiBxXH1j2QJuzewYwkVl8xjAdraTdiy
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab66d03 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=3YgNAnaCMFvVXDaFfzcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MCBTYWx0ZWRfXwqM/0o6fqM4m
 jjgQ5peZTEoPLUhMx/BwIhLCH/jqr567YEdTlbtReqwf8VrGE0FV1/RxYh8Z2cIEHCINghm3E81
 2V2IgjMJrh46M3PS9324LgypHkARQUCUqZ5lnSwHZvdkW0ZSDjMxBCg7Os9iHfgbV73EbAFWAsi
 4Ljf9sO5UmO0OODvTaYwPjdkkAQCQ3Sz+43j4o92eBfFZR1Lg408G35rSPyhe4fFD9/8pu9c51y
 7s23gbratfcrpcczYEyspoyuOSUzRXLh2FQc408965C77cLzPrtwAB7UvI7AH5YySIYVsH5k3YW
 bVgdTpzHhuYWRnDD7OdXrfCAV92dBU4CZdpeCoP3ZdtLpNpkc66hKMuXJL57iaFcPUfDTPcuCNN
 lphgI7uyJqFaxlcu88rp4plHu00Dak+ZUKtN1fckT3iEFX3KPJzyDD38EBrxl2VpCvdQo+sG9x9
 kfHBaBwjnxUutdbe2dQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MCBTYWx0ZWRfX+H4HDUnahW0C
 J6RwPidQRLjkcpP8KOWhhWNnMJJa07TA5XyPhCW94zTTs/lZzPArxt0c863kF7pdXf7SKMZ6WS2
 McjtNnogrJphlmqqJZtOTz2R7yHbB8A=
X-Proofpoint-GUID: IuiBxXH1j2QJuzewYwkVl8xjAdraTdiy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250050

The sashiko AI reported several pre-existing bugs in the vfio_ap device
driver code while reviewing unrelated patches. This series fixes four
such bugs.

Change log v7 => v8:
~~~~~~~~~~~~~~~~~~~
Patch 1/6: Fix leaks of pinned NIB and registered GISC
* Added return codes to vfio_ap_wait_for_irqclear()
  ~ Returns 0 when the IR bit is clear confirming interrupts
    are disabled
  ~ Returns -ENODEV for response codes AP_RESPONSE_Q_NOT_AVAIL,
    AP_RESPONSE_DECONFIGURED, and AP_RESPONSE_CHECKSTOPPED to
    indicate the queue is not operational
  ~ Returns -ETIMEDOUT if retries are exhausted or TAPQ returns
    AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE or
    AP_RESPONSE_ASSOC_FAILED indicating the IR bit cannot be
    confirmed clear
  ~ Returns -EIO if TAPQ returns an invalid response code
* Updated vfio_ap_irq_disable() to handle the return code from
  vfio_ap_wait_for_irqclear()
  ~ Frees AQIC resources on return code 0 or -ENODEV
  ~ Intentionally leaks AQIC resources on -ETIMEDOUT or -EIO
    to prevent a wild DMA write that could corrupt host memory
  ~ Returns AP_RESPONSE_OTHERWISE_CHANGED to the guest on
    -ETIMEDOUT if the TAPQ response code is AP_RESPONSE_NORMAL
    or AP_RESPONSE_BUSY, to signal the disable did not complete
* Added handling for previously unhandled AQIC response codes
  ~ AP_RESPONSE_STATE_CHANGE_IN_PROGRESS: retries after 20ms,
    same as RESET_IN_PROGRESS and BUSY
  ~ AP_RESPONSE_INVALID_GISA, AP_RESPONSE_ASSOC_SECRET_NOT_
    UNIQUE, AP_RESPONSE_ASSOC_FAILED: AQIC resources are
    intentionally leaked since the disable was rejected and
    hardware still holds the NIB address
* Updated apq_status_check() to correctly interpret TAPQ status
  ~ AP_RESPONSE_NORMAL: verifies queue_empty, replies_waiting,
    irq_enabled, and async bits before returning 0; returns
    -EBUSY if async zeroization is still in progress
  ~ AP_RESPONSE_DECONFIGURED, AP_RESPONSE_CHECKSTOPPED: returns
    -ENODEV (AQIC resources freed but zeroization unconfirmed)
  ~ AP_RESPONSE_BUSY: returns -EAGAIN to re-issue ZAPQ, no
    longer falls through to ASSOC_SECRET_NOT_UNIQUE case
* Updated apq_reset_check() to handle -ENODEV from
  apq_status_check()
  ~ On -ENODEV, frees AQIC resources and records TAPQ status
    in q->reset_status to mark the queue as non-passable
  ~ On -EIO, intentionally leaks AQIC resources and records
    TAPQ status to mark the queue as non-passable
* Updated vfio_ap_mdev_reset_queue() to handle response codes
  ~ Added AP_RESPONSE_Q_NOT_AVAIL alongside DECONFIGURED and
    CHECKSTOPPED to free AQIC resources for all non-operational
    queue states
  ~ Removed AP_RESPONSE_BUSY (not a valid ZAPQ response code)
* Updated vfio_ap_mdev_remove_queue() to free AQIC resources
  when the queue is not in the host AP configuration via an
  else branch to the test_bit_inv host-config guard
* Updated unmap_iova() to fall back to a bounded queue reset
  (ZAPQ) when vfio_ap_irq_disable() leaks the NIB page, since
  the vfio core requires the page be unpinned before dma_unmap
  returns; after the reset the NIB is unconditionally freed

Patch 3/6: Fix unbounded loop in apq_reset_check()
* apq_reset_check()
  ~ On timeout, q->reset_status.response_code is set to
    AP_RESPONSE_RESET_IN_PROGRESS to signal incomplete reset
    and trigger ZAPQ re-issue on next reset attempt
  ~ AQIC resources (pinned NIB page and GISC registration)
    are intentionally leaked on timeout to prevent a wild
    DMA write that could corrupt or crash the host kernel
  ~ report_aqic_resource_leak() added to emit a ratelimited
    warning when resources are leaked
* Introduced apq_reset_finalize() to update q->reset_status
  with the confirmed TAPQ end-state and free AQIC resources
  ~ Sets response_code to AP_RESPONSE_NORMAL only when
    apq_status_check() returns 0 (zeroization confirmed)
  ~ Leaves non-zero response code intact for -ENODEV so
    _queue_passable() correctly returns false
* Fixed incorrect treatment of AP_RESPONSE_NORMAL from
  PQAP(ZAPQ) as zeroization confirmation; AP_RESPONSE_NORMAL
  only means the ZAPQ was accepted — completion requires
  all four TAPQ status bits to be verified
* Fixed AP_RESPONSE_BUSY handling in apq_status_check()
  ~ Was falling through to ASSOC_SECRET_NOT_UNIQUE; now
    returns -EAGAIN to re-issue the ZAPQ independently
* Elapsed time counter is reset to 0 when ZAPQ is re-issued
  due to -EAGAIN or RESET_IN_PROGRESS or
  STATE_CHANGE_IN_PROGRESS

Patch 5/6: Fix queue state leakage to guest and host
* Restricted _queue_passable() to return true only when
  reset_status.response_code == AP_RESPONSE_NORMAL (0)
  ~ Removed AP_RESPONSE_DECONFIGURED and
    AP_RESPONSE_CHECKSTOPPED as passable states; neither
    confirms zeroization and passing such a queue could
    leak key material from a prior guest or host operation
* Added on_qstate_transition callback to struct ap_driver
  and implemented vfio_ap_on_qstate_transition()
  ~ AP bus invokes the callback during scan when a queue
    transitions between configured/deconfigured or
    checkstopped/not-checkstopped states
  ~ On AP_QUEUE_CONFIG_ON or AP_QUEUE_CHKSTOP_OFF the queue
    is reset and zeroized; if reset succeeds the guest APCB
    is updated to plug the queue into the guest configuration
* Added ap_qstate_transition struct to ap_bus.h carrying the
  queue pointer and new_state enum
* vfio_ap_mdev_probe_queue() now calls
  vfio_ap_mdev_reset_queue() and flush_work() at probe time
  to guarantee a clean queue before assignment to a guest
* Fixed ordering of kfree(q) vs release_update_locks_for_mdev()
  in vfio_ap_mdev_remove_queue() to avoid use-after-free

Patch 6/6: replace guest-reachable WARNs with ratelimited warnings
* Replaced all WARN/WARN_ONCE calls in guest-reachable paths
  with ratelimited warning functions to prevent log flooding
  by a malicious or misbehaving guest
* Introduced five reporting helper functions:
  ~ report_tapq_rc() - invalid/unexpected PQAP(TAPQ) rc;
    used in vfio_ap_wait_for_irqclear() and
    apq_status_check()
  ~ report_irqclear_timeout() - timeout waiting for IR bit
    to clear after PQAP(AQIC) disable
  ~ report_aqic_disable_error() - failed PQAP(AQIC) disable;
    replaces three WARN_ONCE calls for non-operational queue,
    rejected disable, and retry exhaustion cases
  ~ report_zapq_rc() - invalid PQAP(ZAPQ) rc in
    vfio_ap_mdev_reset_queue()
  ~ report_gisc_unregister_failure() - failure to unregister
    guest ISC when matrix_mdev or kvm context is NULL
* Changed signatures of vfio_ap_wait_for_irqclear() and
  apq_status_check() to accept struct vfio_ap_queue * instead
  of apqn so mdev context is available for reporting
* Augmented VFIO_AP_DBF_WARN() sites in vfio_ap_irq_enable()
  and handle_pqap() with companion dev_warn_ratelimited() or
  pr_warn_ratelimited() calls for dmesg visibility 

Anthony Krowiak (6):
  s390/vfio-ap: Fix leaks of pinned NIB and registered GISC
  s390/vfio-ap: Fix failure to release IRQ notification eventfd contexts
  s390/vfio-ap: Fix unbounded loop in apq_reset_check()
  s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size in
    vfio_ap_mdev_cfg_add()
  s390/vfio-ap: fix queue state leakage to guest and host
  s390/vfio-ap: replace guest-reachable WARNs with ratelimited warnings

 drivers/s390/crypto/ap_bus.c          |  51 ++
 drivers/s390/crypto/ap_bus.h          |  29 +
 drivers/s390/crypto/vfio_ap_drv.c     |   1 +
 drivers/s390/crypto/vfio_ap_ops.c     | 739 ++++++++++++++++++++++----
 drivers/s390/crypto/vfio_ap_private.h |   2 +
 5 files changed, 704 insertions(+), 118 deletions(-)

-- 
2.53.0


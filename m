Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3604530E0E9;
	Tue, 19 May 2026 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779230565; cv=none; b=JlL6tDDuv6DWG3H8o1LLlWj6COOFmeJBn/Jg4h+RomHE1cVp3RyHhr7HEhDHJyrT0G3xwnZ4rPj5Xf8PDWZFkH344DfHL9mFN+Y45W5mXBMInmfwEpzwoxXph7c8Rb02csjYwfkEOPRDhaZmybsUggwp7jDNwkiA6vKqgR24jQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779230565; c=relaxed/simple;
	bh=SsloaZK5hQFedsFdk6QR9Fyi8f1RjsbMnlbVSM0uJvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jhc61plz9EgJXhB6UgnaOj+zeYu9t5FWOYwuxVoKfftA8Em7EzYENVitERoKhDeqGQGLGdCrxKlA/jaLMDV9H7CFpksBTS7NHpHHTteYp0JZGDT1lyvDQePCboiKAuaAFBD2KsdHRKV1SaZ9S/Lvh5peM2Mv9SexLqiW46ekpVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f/PMfUMk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f/PMfUMk"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JCLbhj610903;
	Tue, 19 May 2026 22:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=7L4AwjERY5hyuONCpud94aHwA2F58UwxcLdioOIZ5
	Ic=; b=f/PMfUMkI6f8d9S42Y+KyB4gU0TeMzpx9io5tqY+SUE4M7rGDnAsTWt2r
	+SQMLrosNKqOdCXuQfPuyRsxYgVq5ckanseotyvmRFVDEmM18Nx+ea0tgHfMKFoe
	cJxRweFz4Ubf3Xlz1WUKp9wH7Zh/HdsftZ5l/WyW0Bx3HNsNyL16k75zzUP83XRr
	PBpTnf4n4jnY+wzTinW+gx5QiwfQw8SwN+s+xpE1qi77IhVzzLW7QZTNNXtIv/KP
	rL5tQc3eZBc5Qr9TIdDvhMk9dSlX8Yh5PBU6xisRUOvMjYSCGaJCgdeec7EJFYO1
	/QbSPMYh8H3oeVbDpqXSKAl2TwOGA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8ej8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 22:42:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JMdBbn030003;
	Tue, 19 May 2026 22:42:41 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhmr34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 22:42:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JMgcOf33817338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 22:42:38 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DEEB58045;
	Tue, 19 May 2026 22:42:38 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C58658052;
	Tue, 19 May 2026 22:42:36 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.253.120])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 22:42:36 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: [PATCH v2 0/3] vfio-pci/zdev: Improved zPCI Function Measurement Support
Date: Tue, 19 May 2026 18:42:01 -0400
Message-ID: <20260519224204.19154-1-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDIyNyBTYWx0ZWRfX8ygsPU+LlpPl
 mazs9m2zDYL8UwbURBUAoDWCp6yFPvVEsH0cTF79Kw6Oz+PHuNB/CDa3MqSOFOKZDFJxnBz+5YQ
 sBxOfU0DR9frvWJQjXaFUSNTVjxPAWGv3MoxvME7KTW9AO8KqK0QMkBS0iy9Fa8Eg2V4RE6cgKe
 SJltE6sC4E1Vj9L2MXHSz/XGNhNvMlHuyoknZKVbGb8sGyvWkxHrBQRpayi7AWNr3gnZiTj9A8h
 VDoeT4A7wRSqvhyj6hFPY4vcDdOzVz/8Nw93UCxMzNSgn+upvAjs9EMTB07bZV6fAHJmP2XzWi2
 A52eHOgjGejILRwzX+Sso69swfogG+0RzhJfVNeBz6EqnH/R4UxdX/RmIYslx0FR6+W2JKE9ob0
 yRZRU/amE/wrRfqEhj+W3PzII9zX9tnmMXwtNkBQ5fxe27ZsC4+ILaHEha7KljrqjK50HRJEQUH
 +AhImXBkBjwnms3Bykg==
X-Proofpoint-GUID: rF_8Ka3bmnSbBGHMP9t3BGHrb34jbJHl
X-Proofpoint-ORIG-GUID: rF_8Ka3bmnSbBGHMP9t3BGHrb34jbJHl
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0ce761 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=gup9bYBh-5yKvDTis8UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190227

Hi,

This patch series improves support for function measurement for zPCI
passthrough devices on s390x.

Changelog
=========
v1 -> v2:
* Patch 1/3:
  - Address a possible race condition in zpci_reenable_device() caused by
    calling zpci_fmb_reenable_device() without holding fmb_lock
  - Assert that fmb_lock is held within zpci_fmb_reenable_device()

* Patch 3/3:
  - Address a possible race condition in pci_perf_seq_write() caused by
    consuming zdev->kzdev without holding kzdev_lock

Motivation
==========
The firmware on s390x machines allows for tracking a variety of statistics
relating to zPCI devices in a function measurement block (FMB). However,
the kernel currently lacks a structured mechanism of sharing this
information with userspace, beyond /sys/kernel/debug/pci/ID/statistics.
This can lead to shortcomings when running a guest on KVM with PCI
passthrough devices, as QEMU is unable to provide an accurate FMB snapshot
to the guest.

Proposal
========
We propose adding a new VFIO device feature to zPCI passthrough devices,
allowing userspace programs to read the latest FMB snapshot as it is
written by the firmware. We ensure that function measurement enablement is
preserved across device resets on the host. Furthermore, we guard against
host tampering with the FMB via sysfs when the zPCI device is in
passthrough to protect the VM's state.

I'd appreciate some feedback on these patches.

Thanks in advance.

Omar Elghoul (3):
  s390/pci: Preserve FMB state in device re-enablement
  vfio-pci/zdev: Add VFIO FMB device feature
  s390/pci: Fence FMB enable/disable via sysfs for passthrough devices

 arch/s390/include/asm/pci.h      |  1 +
 arch/s390/pci/pci.c              | 75 ++++++++++++++++++++++++-------
 arch/s390/pci/pci_debug.c        | 11 ++++-
 drivers/vfio/pci/vfio_pci_core.c |  2 +
 drivers/vfio/pci/vfio_pci_priv.h |  9 ++++
 drivers/vfio/pci/vfio_pci_zdev.c | 77 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 43 ++++++++++++++++++
 7 files changed, 202 insertions(+), 16 deletions(-)

-- 
2.52.0


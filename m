Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAC5314D21;
	Mon,  8 Jun 2026 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939211; cv=none; b=l2aKXQ6w25Xjz9wiOtvPTCCCjUmyh+idCGPz8JN0Fr9NT4PQ8LXulDCGzUyJqm52qv+FqRMpXU+Oa/UcWB4Cjlpl81Ekwfi+o8SuBOaG4ZT/5O5d4ZHMlC05rNJ1MvB1yjXnXtKDjCHwATQ2DEkD2Jri5IG5DfBTWV3u4M6QW5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939211; c=relaxed/simple;
	bh=6P7Nc8c6MGO5S3ySzPWPr/UUPxfRubtgmkQxASDIJgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jwEnK21YczWHPwv7MgmVbHhTWiNsdoKkUHEd+izy+QIWOQ+ETqxwDpaXUiNFHK9u9hFcpykqiQy42Q410pres7fIjVvuGuLFmdjHkj9tmD/wpRlrbJqEmQRwuFtMdPkV9ORNhmKjNYlsLiuf7FUrS5/tNiALWUpIPMUUf3myDeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E+mo8w28; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E+mo8w28"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DRdP73075680;
	Mon, 8 Jun 2026 17:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=J3ZFC3v+aDnSUPikkJp/8hTX6fmz/e95YaBi5A2NS
	/E=; b=E+mo8w28AZ3TbiLLfm68V3ZC3GbxzKDoz8/hZ3jfE0fpO7OGtWIxEUslK
	HHAkaVTt43jX2T9gG989520lEo8itnhXqz5BJEzZAuHFpsY1EafpepLo/X36Fvwm
	cVmetx6KB4eBVMXF4IqSMM/PnDtqwXz2iPHGa8Tdj9ZSz59Xn3xeOcukruRrqDou
	y57ZF+ObB8wcn3EaCjeLI9sP70suR68n8cFL5g2O0kLiIAY2TDhKkuPY9yJUXA3d
	mqda0qEXh+9wgUIP9nn8k7/1dcLHFOhhr5A/cL1x4yUuL7S96/YXeQ9LHKvbS2Fg
	6HD3NZPkc+iOaHWqTxxihJE2VXwOA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qgerc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 17:20:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658HJbEo023817;
	Mon, 8 Jun 2026 17:20:05 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvpxgwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 17:20:05 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658HK2vo27591314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 17:20:03 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B49D05803F;
	Mon,  8 Jun 2026 17:20:02 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 685EA58054;
	Mon,  8 Jun 2026 17:20:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.12.78.81])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 17:20:01 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: [PATCH v3 0/4] vfio-pci/zdev: Improved zPCI Function Measurement Support
Date: Mon,  8 Jun 2026 13:18:46 -0400
Message-ID: <20260608171850.62829-1-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a26f9c6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=Apgw4fthafaJZSGxNE0A:9
X-Proofpoint-GUID: 2kADVZHwI8miwNIp2tcImNSm_bYRsHgd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2MiBTYWx0ZWRfX+Z7cSw9rA3++
 u1qe6v0rR3gADjhEOxg4LaZVbo4+T7uCB8SoczQGdeidLB3J11UhTl/laNWIL2gYOG7nNj6kNqp
 bGx4a9Q9a8fjG5dLcQXDKG4W46rQ582iAV8GOk2nU93HBBGJigsMe28gOSHqeX5dh0vL1YkkKfW
 8ZQ3DLeAn/erjjuYMnCLmoY8rbUPrHIBXNW0LlKkKCkhW9kYF4+uz6jVpXicLJ7C5Vje5vYr7NU
 AUlggPebiajESj72xlWomeDAmEDfyq7GHTf/r9fGD3B/t3wtuV8r+Kyzuh8IME3Q/ckh1Wz/Def
 FTL53LoRnc0lVuiQRM7MiZouufb1JUSDUXKP4aLfOZuDmgPSLP2IOvEvtWXwQYgDy11uchkcax3
 NlXhYvSON364gExcYgJYGZ44EY/iOygB6bUfBQLUvlhtVxZ7aCSpZdsgapcO2l7LIjE2avJESbM
 0PmxD/BCAA9iWh8L6zQ==
X-Proofpoint-ORIG-GUID: 2kADVZHwI8miwNIp2tcImNSm_bYRsHgd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080162

Hi,

This patch series improves support for function measurement for zPCI
passthrough devices on s390x.

Changelog
=========
v2 -> v3:
* Patch 1/4 (new patch):
  - Fix race conditions in pcibios_enable/disable_device() with regard to
    the FMB enable/disable
  - Assert that fmb_lock is held within zpci_fmb_enable_device() and
    zpci_fmb_disable_device()

* Patch 2/4 (previously 1/3):
  - Move the FMB enable logic into a static function zpci_fmb_do_enable()
    to reduce code duplication between zpci_fmb_enable_device() and
    zpci_fmb_reenable_device()
  - Reword commit message to use the imperative voice more consistently

* Patch 3/4 (previously 2/3):
  - Split the previous VFIO feature into a SET-only and a GET-only feature
    for enabling/disabling and reading the FMB respectively
  - Remove FMB definitions from the VFIO uAPI and instead treat it as an
    opaque structure

* Patch 4/4 (previously 3/3):
  - Clarify goto label name to reduce misunderstandings

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

Omar Elghoul (4):
  s390/pci: Hold fmb_lock when enabling or disabling PCI devices
  s390/pci: Preserve FMB state in device re-enablement
  vfio-pci/zdev: Add VFIO FMB device features
  s390/pci: Fence FMB enable/disable via sysfs for passthrough devices

 arch/s390/include/asm/pci.h      |   1 +
 arch/s390/pci/pci.c              | 100 +++++++++++++++++++++++++------
 arch/s390/pci/pci_debug.c        |  11 +++-
 drivers/vfio/pci/vfio_pci_core.c |   4 ++
 drivers/vfio/pci/vfio_pci_priv.h |  18 ++++++
 drivers/vfio/pci/vfio_pci_zdev.c |  57 ++++++++++++++++++
 include/uapi/linux/vfio.h        |  29 +++++++++
 7 files changed, 202 insertions(+), 18 deletions(-)

-- 
2.54.0


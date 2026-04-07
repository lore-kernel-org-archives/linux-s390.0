Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D1739D6F9;
	Tue,  7 Apr 2026 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558891; cv=none; b=s0au/STxh0x4Qogu4IUgntQBZucTuEZRZ7tFqq9xnDQiFnLx1BV619t8AeFmk1vPVuf1sktdgFZwvUwqlIbAeNCrSzVVZaALEtNYFckLKWEwBBP85jLbykK8nkHjvC12uiNWvb0KvJLTcSweZL5Do1kNdsDHqAwTRqIDEGDCJuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558891; c=relaxed/simple;
	bh=gVhTUKcV2HyCwzuwdCv7ovFUANZVS2PUTsAzv9DxF2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r1MP/D3Cip5J+UmKUU73QJGAWg6d+hBNTVKKhlZwgXbVVfXDczOQ4bq2HSbLavN/9aXEZOBxZwIp10hJAshrrUnESiao/hId4XNFoorQ4p5BhDKQXq2s9F9YNRuoousOma1DtS/pLBHU1SYXhbj34PNMWnAYeU+ULa/h1BE5//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RgqdcjwJ; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RgqdcjwJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775558885; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=kG9JEWxldphoXtIw2ELvbQq3BEYOe+NSKsmq+c/NWB4=;
	b=RgqdcjwJ6wUBdeqSISRMOwiCaWLzxC7KlyhR86ITw/dfqobSnmztm74x8m5Q3dS/i0QhvJh+0qDxJUwlLMZ4Q1iZZX+nsVckiqoiGQFt0QstaAXOFAIOKsPbGHGrjGNWcy9dZUXWBvlbyiYr9pzckqCznb+3XqU4Eb3JpBr40OE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X0bZhWU_1775558882;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0X0bZhWU_1775558882 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Apr 2026 18:48:04 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: tglx@kernel.org,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	jstultz@google.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	daniel.lezcano@kernel.org,
	sboyd@kernel.org,
	dwmw2@infradead.org
Cc: vladimir.oltean@nxp.com,
	wei.fang@nxp.com,
	xiaoning.wang@nxp.com,
	jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev,
	yangbo.lu@nxp.com,
	svens@linux.ibm.com,
	nick.shi@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-fpga@vger.kernel.org,
	imx@lists.linux.dev,
	linux-s390@vger.kernel.org,
	dust.li@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com,
	mani@kernel.org,
	imran.shaik@oss.qualcomm.com,
	taniya.das@oss.qualcomm.com
Subject: [PATCH v2 0/2] ptp: split non-NIC PHC drivers into the clock/timekeeping maintenance domain
Date: Tue,  7 Apr 2026 18:48:00 +0800
Message-Id: <20260407104802.34429-1-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series follows the discussion in RFC [1-2] and v1 [3].


# Background

The PTP Hardware Clock (PHC) interface (/dev/ptpX and the standard PTP_*
ioctls) was originally introduced for IEEE 1588 / network oriented clock
drivers. Over time, it has also become a userspace API for many non-NIC
high-precision clock implementations (virtualization/platform/architecture
provided clocks) [4-8], and more are expected to appear [9-10].

During the review of these incoming non IEEE 1588 based PHC drivers, concerns
were raised that such "non-NIC" clocks may not be a good fit for the netdev
maintainership model [11], where PTP/PHC drivers are currently maintained.
This leaves an unclear upstream home and maintainership model for this class
of drivers.


# Proposal

This series proposes moving PHC drivers that expose a high-precision clock to
userspace via the existing PTP interface but are not tied to the traditional
NIC/IEEE 1588 packet timestamping pipeline, out of the netdev maintenance
domain and into the clock/timekeeping maintenance domain.

As discussed in [3], this series makes the separation explicit by reorganizing
the drivers/ptp/ layout into the following groups. This provides clearer
ownership and long-term maintenance boundaries:

  - drivers/ptp/          : PTP core infrastructure and
                            network / IEEE 1588 oriented PTP drivers.

  - drivers/ptp/emulated/ : emulated/virtual PTP drivers. They are typically
                            platform/architecture/virtualization/special
                            hardware provided high-precision time sources.

Patch 1 performs the refactor: move drivers and split Kconfig/Makefiles
accordingly, without intended functional changes.

Patch 2 updates MAINTAINERS to match the new layout and adds a dedicated entry
for drivers/ptp/emulated/, moving review and ownership routing for this class
of drivers away from the netdev maintainership.

No userspace ABI changes are intended; this is a refactor and maintenance
metadata update only.


# Changes since Patch v1:

- List David Woodhouse as the maintainer of emulated PTP drivers.

- Adjust the directory layout: instead of creating both ieee1588/ and
  emulated/ subdirectories, keep the network-oriented drivers in the
  main drivers/ptp/ directory and only split out the emulated drivers.


# Changes since RFC v2:

- Keep ptp_ocp under the IEEE1588/network-oriented PTP drivers as suggested
  by Jakub.

- Following the model used by NTP related code, this series lists tip.git
  (timers/core) as the integration tree for emulated PTP clocks in the
  MAINTAINERS entry. Guidance from clock/timekeeping maintainers
  (Thomas Gleixner, John Stultz, Anna-Maria Behnsen, Frederic Weisbecker,
  Daniel Lezcano, Stephen Boyd) on whether this is the appropriate workflow
  for this class of drivers would be appreciated.

- Continue listing ourselves as maintainers for now as a fallback contact
  point. In the long term it would be preferable for this area to be
  maintained by clock/timekeeping experts, and suggestions are welcome.


Thanks for any input.

Regards.

[1] https://lore.kernel.org/all/0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com/
[2] https://lore.kernel.org/all/20260227081934.96865-1-guwen@linux.alibaba.com/
[3] https://lore.kernel.org/all/20260318073330.115808-1-guwen@linux.alibaba.com/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a0e136d436ded817c0aade72efdefa56a00b4e5e
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7d10001e20e46ad6ad95622164686bc2cbfc9802
[6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2d7de7a3010d713fb89b7ba99e6fdc14475ad106
[7] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3716a49a81ba19dda7202633a68b28564ba95eb5
[8] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a17125a18f9ae1e1233a8e2d919059445b9d6fd
[9] https://lore.kernel.org/netdev/20251030121314.56729-1-guwen@linux.alibaba.com/
[10] https://lore.kernel.org/mhi/20250818-tsc_time_sync-v1-0-2747710693ba@oss.qualcomm.com/
[11] https://lore.kernel.org/netdev/20251127083610.6b66a728@kernel.org/

Wen Gu (2):
  ptp: move emulated/virtual clock drivers into a dedicated subdirectory
  MAINTAINERS: update PTP maintainer entries after directory split

 MAINTAINERS                                 | 21 +++++--
 drivers/ptp/Kconfig                         | 68 ++++-----------------
 drivers/ptp/Makefile                        | 11 ++--
 drivers/ptp/emulated/Kconfig                | 61 ++++++++++++++++++
 drivers/ptp/emulated/Makefile               | 11 ++++
 drivers/ptp/{ => emulated}/ptp_kvm_arm.c    |  0
 drivers/ptp/{ => emulated}/ptp_kvm_common.c |  0
 drivers/ptp/{ => emulated}/ptp_kvm_x86.c    |  0
 drivers/ptp/{ => emulated}/ptp_s390.c       |  0
 drivers/ptp/{ => emulated}/ptp_vmclock.c    |  0
 drivers/ptp/{ => emulated}/ptp_vmw.c        |  0
 11 files changed, 103 insertions(+), 69 deletions(-)
 create mode 100644 drivers/ptp/emulated/Kconfig
 create mode 100644 drivers/ptp/emulated/Makefile
 rename drivers/ptp/{ => emulated}/ptp_kvm_arm.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_kvm_common.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_kvm_x86.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_s390.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_vmclock.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_vmw.c (100%)

-- 
2.43.5


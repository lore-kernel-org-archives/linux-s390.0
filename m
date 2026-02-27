Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F737BE8F;
	Fri, 27 Feb 2026 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180389; cv=none; b=NpsxLjLUOPZP89J2B23Iw/P+m6vX5pXKcHrncexmSy8liS9Zlm5sgwXeNaNyZ//Ge8jNpmUfTuOEHVWBiwRDzZp4vipnXCL+ruo2hC++D+Z91jNDo57jBR5FzMai3QmVbyTi1Z5Iw5e5rhIpxG2RxHv8nsK4uZMeKCyd8/PVvPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180389; c=relaxed/simple;
	bh=BZkKJ60dM1sCJoV/yPXvzNVQmdyrllYqT3tsVenPo7I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sbd61sEJAKSev6xMj1gkC7kbuXIeaps5FCZMrw4c9MnCmAOZduB6zBBV7hkbBHu7lIuygt40+VFwUNRAL8w5u1kFV9QtzS/jWKr2BduGP3I2J7z/hD7ilZMHR6oBA79iVd+rjD9/uhVXICIAu3lM97+rwXRUgz2uOVUY+R9jjZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YesEvtDd; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YesEvtDd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772180377; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=weHy5upVfL/CTdyKtRtnXdAw6Ax8FQqZLwgVe9u7JuU=;
	b=YesEvtDdyLVDZLOYaGrtowNWvjLC1RirUyaaKxz7uNPFwXzC1VLPezLpHD2IcyZfBO5EOrPeEVO9PH+xCY3+IuNMqDPAO2gtN5NOnCx2ETDSyaq0kW24g/MqJ2OU2d47wB4hAuclf9orK9yFfzt1VuuYIhVQ9fte+bq7JZOZTpk=
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WztidQ5_1772180374 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Feb 2026 16:19:36 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: tglx@kernel.org,
	tglx@linutronix.de,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	mani@kernel.org,
	imran.shaik@oss.qualcomm.com
Cc: vladimir.oltean@nxp.com,
	wei.fang@nxp.com,
	xiaoning.wang@nxp.com,
	jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev,
	yangbo.lu@nxp.com,
	svens@linux.ibm.com,
	dwmw2@infradead.org,
	nick.shi@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-fpga@vger.kernel.org,
	imx@lists.linux.dev,
	linux-s390@vger.kernel.org,
	dust.li@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com,
	taniya.das@oss.qualcomm.com
Subject: [RFC v2 0/2] ptp: Move non-NIC PHC drivers from netdev to clock/timekeeping maintainership
Date: Fri, 27 Feb 2026 16:19:32 +0800
Message-Id: <20260227081934.96865-1-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This RFC v2 is a follow-up to [1].


# Background

The PTP Hardware Clock (PHC) interface (/dev/ptpX and the standard PTP_*
ioctls) was originally introduced for IEEE 1588 / network oriented clock
drivers. Over time, it has also become a common userspace API for many non-NIC
high-precision clock implementations (virtualization/platform/architecture
provided clocks) [2-6], and more are expected to appear [7-8].

During the review of these incoming non IEEE 1588 based PHC drivers, concerns
were raised that such "non-NIC" clocks may not be a good fit for the netdev
maintainership model [9], where PTP/PHC drivers are currently maintained. This
leaves an unclear upstream home and maintainership model for this class of
drivers.


# Proposal

This RFC proposes moving PHC drivers that expose a high-precision clock to
userspace via the existing PTP interface (/dev/ptpX + standard PTP_* ioctls),
but are not tied to the traditional NIC/IEEE 1588 packet timestamping
pipeline, out of the netdev maintainership scope and into a clock/timekeeping
maintainership scope.

As discussed in [1], this series makes the separation explicit by splitting
drivers/ptp/ into the following groups, to prepare for clearer ownership and
future maintenance:

  - drivers/ptp/          : PTP core infrastructure and userspace ABI
                            (ptp_clock.c, ptp_chardev.c, ptp_sysfs.c,
                             ptp_vclock.c, etc.) remain here.

  - drivers/ptp/ieee1588/ : network / IEEE 1588 oriented PTP drivers.

  - drivers/ptp/emulated/ : non IEEE 1588 PTP drivers. they are typically
                            platform/architecture/virtualization/speical
                            hardware provided high precision time sources.

Patch 1 performs the refactor: move drivers and split Kconfig/Makefiles
accordingly, without intended functional changes.

Patch 2 updates MAINTAINERS to match the new layout and adds a dedicated entry
for drivers/ptp/emulated/, moving review and ownership routing for this class
of drivers away from the netdev maintainership.

No userspace ABI changes are intended, this is a refactor and maintenance
metadata update only.


# Request for comments

1. Following the clocksource/timekeeping and POSIX timer areas, this RFC routes
changes for drivers/ptp/emulated/ to linux-kernel@vger.kernel.org (rather than
netdev). However, the preferred integration path is still unclear (e.g. which
tree should take such changes, and who should collect/pull them for merging). We
would really appreciate guidance from the time/clock maintainers, especially any
input from Thomas Gleixner, on the preferred tree/workflow for these changes.

2. This RFC currently lists us as the maintainers for drivers/ptp/emulated/ as a
fallback contact point. Ideally, we would prefer this area to be maintained by
clock/time experts in the long run. Suggestions on more suitable maintainers are
very welcome.


Thanks for any input.

Regards.

[1] https://lore.kernel.org/all/0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a0e136d436ded817c0aade72efdefa56a00b4e5e
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7d10001e20e46ad6ad95622164686bc2cbfc9802
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2d7de7a3010d713fb89b7ba99e6fdc14475ad106
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3716a49a81ba19dda7202633a68b28564ba95eb5
[6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a17125a18f9ae1e1233a8e2d919059445b9d6fd
[7] https://lore.kernel.org/netdev/20251030121314.56729-1-guwen@linux.alibaba.com/
[8] https://lore.kernel.org/mhi/20250818-tsc_time_sync-v1-0-2747710693ba@oss.qualcomm.com/
[9] https://lore.kernel.org/netdev/20251127083610.6b66a728@kernel.org/

Wen Gu (2):
  ptp: split clock drivers into two subdirectories
  MAINTAINERS: update PTP maintainer entries after directory split

 MAINTAINERS                                  |  39 ++-
 drivers/ptp/Kconfig                          | 255 ++-----------------
 drivers/ptp/Makefile                         |  27 +-
 drivers/ptp/emulated/Kconfig                 |  81 ++++++
 drivers/ptp/emulated/Makefile                |  12 +
 drivers/ptp/{ => emulated}/ptp_kvm_arm.c     |   0
 drivers/ptp/{ => emulated}/ptp_kvm_common.c  |   0
 drivers/ptp/{ => emulated}/ptp_kvm_x86.c     |   0
 drivers/ptp/{ => emulated}/ptp_ocp.c         |   0
 drivers/ptp/{ => emulated}/ptp_s390.c        |   0
 drivers/ptp/{ => emulated}/ptp_vmclock.c     |   0
 drivers/ptp/{ => emulated}/ptp_vmw.c         |   0
 drivers/ptp/ieee1588/Kconfig                 | 159 ++++++++++++
 drivers/ptp/ieee1588/Makefile                |  15 ++
 drivers/ptp/{ => ieee1588}/ptp_clockmatrix.c |   0
 drivers/ptp/{ => ieee1588}/ptp_clockmatrix.h |   0
 drivers/ptp/{ => ieee1588}/ptp_dfl_tod.c     |   0
 drivers/ptp/{ => ieee1588}/ptp_dte.c         |   0
 drivers/ptp/{ => ieee1588}/ptp_fc3.c         |   0
 drivers/ptp/{ => ieee1588}/ptp_fc3.h         |   0
 drivers/ptp/{ => ieee1588}/ptp_idt82p33.c    |   0
 drivers/ptp/{ => ieee1588}/ptp_idt82p33.h    |   0
 drivers/ptp/{ => ieee1588}/ptp_ines.c        |   0
 drivers/ptp/{ => ieee1588}/ptp_mock.c        |   0
 drivers/ptp/{ => ieee1588}/ptp_netc.c        |   0
 drivers/ptp/{ => ieee1588}/ptp_pch.c         |   0
 drivers/ptp/{ => ieee1588}/ptp_qoriq.c       |   0
 27 files changed, 322 insertions(+), 266 deletions(-)
 create mode 100644 drivers/ptp/emulated/Kconfig
 create mode 100644 drivers/ptp/emulated/Makefile
 rename drivers/ptp/{ => emulated}/ptp_kvm_arm.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_kvm_common.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_kvm_x86.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_ocp.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_s390.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_vmclock.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_vmw.c (100%)
 create mode 100644 drivers/ptp/ieee1588/Kconfig
 create mode 100644 drivers/ptp/ieee1588/Makefile
 rename drivers/ptp/{ => ieee1588}/ptp_clockmatrix.c (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_clockmatrix.h (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_dfl_tod.c (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_dte.c (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_fc3.c (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_fc3.h (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_idt82p33.c (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_idt82p33.h (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_ines.c (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_mock.c (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_netc.c (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_pch.c (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_qoriq.c (100%)

-- 
2.43.5


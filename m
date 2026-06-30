Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5902690D5;
	Tue, 30 Jun 2026 03:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789335; cv=none; b=VlzmhgSo+kf2TC9xYi+vj8UaYtXYtxKc99+4AqrEfYIWxvIb09Kc/MqXPMTQk7BFFvkyt8cczau7rxHygBZqK/v83QBxFiF0WsVs3ayRkw0G2MNbrbLB4iWfchAxASL9a7Iho0srvhrzR1QGnMcaX9Cb/BRAOjU+0DWXKFEFlsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789335; c=relaxed/simple;
	bh=rlPcbuDju8eHLm7pwmya3VnZKoG1GXFDKuiyvAZppxw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rmVq0GGxoCaCH/Ge7YSlJAsjTtjpVcZvcRfrhdxTBXjMBHkHYuB3k0RkWoK/ZzGTo0X5ILPjtDvJBPSQ7tZghkGkVe91L2p+VFgB9MwrlQxLh7ANVn3d5TC5WfkGBaIawurl8vx6s28mO5fZmdJgv8QOF8g80PE7l4XArnH/23A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Uy0OPvjc; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Uy0OPvjc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782789330; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1vNycxCuhzcuJXMoTNLp2cYo3/8A9ikPwob8Yjq0Vq0=;
	b=Uy0OPvjc/0HNeJz669SBQGOEbwhQeZqxEXjOyzxVvCG+UR824Dv8aTC6wYLbmkUG0wxm2tQAK6veu+96iqgS03pNuPHfLma6dvtN7rogBKToNMyLUpvLu0H/1gXruKsxEq6rkZ8aFLStKR6JmP8na81O97CV1jP/d11SZlyDi8k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X5zdNCi_1782789320;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0X5zdNCi_1782789320 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Jun 2026 11:15:29 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: richardcochran@gmail.com,
	dwmw2@infradead.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: svens@linux.ibm.com,
	nick.shi@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-s390@vger.kernel.org,
	xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	mani@kernel.org,
	imran.shaik@oss.qualcomm.com
Subject: [PATCH v3 0/2] ptp: split non-host-disciplined PHC drivers into a dedicated subdirectory
Date: Tue, 30 Jun 2026 11:15:17 +0800
Message-Id: <20260630031519.23072-1-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series follows the discussion in RFC [1-2], v1 [3] and v2 [4].


# Background

The PTP Hardware Clock (PHC) interface (/dev/ptpX and the standard PTP_*
ioctls) is used by two distinct classes of drivers in drivers/ptp/:
host-disciplined PHC drivers whose frequency and phase are adjusted by
the host's time synchronization stack, and non-host-disciplined PHC
drivers that expose an external precision time reference and are
read-only. Several non-host-disciplined PHC drivers already exist in
the kernel [5-9], and more are expected to appear [10-11].

During review of incoming non-host-disciplined PHC drivers, concerns
were raised that they may not be a good fit for the netdev maintainership
model [12], where all PTP/PHC drivers are currently maintained. This
leaves an unclear upstream home and maintainership model for this class
of drivers.


# Proposal

This series makes the separation explicit by reorganizing the drivers/ptp/
layout into the following groups:

  - drivers/ptp/          : PTP core infrastructure and host-disciplined
                            PHC drivers.

  - drivers/ptp/emulated/ : non-host-disciplined PHC drivers that expose
                            precision time from hypervisors, platforms,
                            or firmware. These clocks are read-only and
                            not adjusted by the host.

Patch 1 performs the directory reorganization: move drivers and split
Kconfig/Makefiles accordingly, without intended functional changes.

Patch 2 updates MAINTAINERS to match the new layout and adds a
dedicated entry for drivers/ptp/emulated/.

No userspace ABI changes are intended; this is a refactor and maintenance
metadata update only.


# Changes since v2:

- List David Woodhouse as the sole maintainer (M:) of emulated PTP
  drivers as suggested by Jakub. Wen Gu and Xuan Zhuo are listed as
  reviewers (R:).

- Updated the T: field to use David's tree:
  git://git.infradead.org/linux-ptp.git

- Reworded commit messages to clarify the distinction between the two
  groups as host-disciplined vs. read-only (devices that purport to know
  real time better than the host).


# Changes since v1:

- List David Woodhouse as the maintainer of emulated PTP drivers.

- Adjust the directory layout: instead of creating both ieee1588/ and
  emulated/ subdirectories, keep the network-oriented drivers in the
  main drivers/ptp/ directory and only split out the emulated drivers.


# Changes since RFC v2:

- Keep ptp_ocp under the network-oriented PTP drivers as suggested
  by Jakub.


Thanks for any input.

Regards.

[1] https://lore.kernel.org/all/0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com/
[2] https://lore.kernel.org/all/20260227081934.96865-1-guwen@linux.alibaba.com/
[3] https://lore.kernel.org/all/20260318073330.115808-1-guwen@linux.alibaba.com/
[4] https://lore.kernel.org/all/20260407104802.34429-1-guwen@linux.alibaba.com/
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a0e136d436ded817c0aade72efdefa56a00b4e5e
[6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7d10001e20e46ad6ad95622164686bc2cbfc9802
[7] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2d7de7a3010d713fb89b7ba99e6fdc14475ad106
[8] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3716a49a81ba19dda7202633a68b28564ba95eb5
[9] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a17125a18f9ae1e1233a8e2d919059445b9d6fd
[10] https://lore.kernel.org/netdev/20251030121314.56729-1-guwen@linux.alibaba.com/
[11] https://lore.kernel.org/mhi/20250818-tsc_time_sync-v1-0-2747710693ba@oss.qualcomm.com/
[12] https://lore.kernel.org/netdev/20251127083610.6b66a728@kernel.org/

Wen Gu (2):
  ptp: move non-host-disciplined clock drivers into a dedicated
    subdirectory
  MAINTAINERS: update PTP maintainer entries after directory split

 MAINTAINERS                                 | 21 +++++--
 drivers/ptp/Kconfig                         | 55 +------------------
 drivers/ptp/Makefile                        | 11 ++--
 drivers/ptp/emulated/Kconfig                | 61 +++++++++++++++++++++
 drivers/ptp/emulated/Makefile               | 11 ++++
 drivers/ptp/{ => emulated}/ptp_kvm_arm.c    |  0
 drivers/ptp/{ => emulated}/ptp_kvm_common.c |  0
 drivers/ptp/{ => emulated}/ptp_kvm_x86.c    |  0
 drivers/ptp/{ => emulated}/ptp_s390.c       |  0
 drivers/ptp/{ => emulated}/ptp_vmclock.c    |  0
 drivers/ptp/{ => emulated}/ptp_vmw.c        |  0
 11 files changed, 94 insertions(+), 65 deletions(-)
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


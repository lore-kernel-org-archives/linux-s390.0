Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163020;
	b=IDcQ/k9EkAAgmd2TCMyPQyoHuGkdwluihWBoDbDwxX32hO20CKy4WeQoJFeFQSBQ5koB
	 1yKhGjH/KkIIapwGGINTrUCbAVG0TqhDEtNoNpzg8XMOtCwGP3KPM2ml+ozLY5d5RKJ+g
	 Z3DWrB+H+PKYvmd4zSmA95cbAIAi56svDO14XI/7WGqxzSCOr5tBGGMaMNF3gUSdk5k9d
	 m+rzMiEw4OLobSjkbvV8e0X2RCT4cxb54Vnt3hrIFGTO/7lqWd51V1sFt1oKIQRsPhjlI
	 wM8Lri45yIezpBQj/iO7ztuvjo0A+An74Xx9miExKhAbZAmarPyDWZm1g5+89VH+/Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163020;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=5eX6ZERtxMma6IIiwk4zjHSJGCnTW5TdkQ89tZL/8dM=;
	b=GmxtOGfyUj5pCCr4aqR0JioNiimFurOzK9YRtRlglGWJpfIKgJ987Fj/+EPj6frdd9VP
	 OZi/sW3bgP5+u7xP42PaGohspt/uhERJLLeUnmU1uCOl/iF/OncY2YOXrpolVUiLlUQNX
	 sdCCAsSxP59wd1Oijbf1kLiQCoaWfiXQG4qBJSJLiXFuQeDbYIPebH8EEJCDaOnQddyK0
	 BNkZWC2k1pO4PBlyfYn8Ehs4n6td59E9NlJznKUNJzsd4kuZxhZ2ZKXVnVbw8+NhiaAKc
	 /pfL8u6VwErNkSObK6xg+cXK4YUkG0C/5WC6ErYXtsjiNjocnfvZDc8ozUKTQQr4oYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="Pmoe/AMv";
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD134606A31A;
	Wed, 28 Oct 2026 04:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD134606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Pmoe/AMv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5e
	X6ZERtxMma6IIiwk4zjHSJGCnTW5TdkQ89tZL/8dM=; b=Pmoe/AMv61DOoUS7hw
	fJtrZ1OMVnBesqPe6v4a8+oGDtdeJ3Kmtf4tf4a4NHv6eHPXLarg1WgKZ5yBzh2D
	sCKfYqy6c0tdGZ0XZrY36teHjocwbfTitnmOp/cu5Kq9/4MNwk/sKJvQ7YHsj4rp
	O2kCYpKzGX/5HwlY9DZzq6lCs=
Received: from pc.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXXyGcfuFqI22BCQ--.35298S2;
	Wed, 28 Oct 2026 12:48:30 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Justin Sanders <justin@coraid.com>,
	Jens Axboe <axboe@kernel.dk>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Brad Warrum <bwarrum@linux.ibm.com>,
	Ritu Agarwal <rituagar@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Muminul Islam <muislam@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Steven Royer <seroyer@linux.vnet.ibm.com>,
	Adam Reznechek <adreznec@linux.vnet.ibm.com>,
	"Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Florian Fainelli <florian.fainelli@telecomint.eu>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-hyperv@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 0/6] Initialize device state before userspace registration
Date: Wed, 28 Oct 2026 12:48:20 +0800
Message-Id: <20261028044828.96177-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDXXyGcfuFqI22BCQ--.35298S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7XFWfGw4fZr1kWFy5Xry5Jwb_yoW8Jry3pa
	1Sg3sYy392krW7Xr43Zay7Ga4Fga48uayUCF90kw1FgFs5CFyvqFW0qay8tFWDJFWxA3W0
	qF10vrWxGFWUCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpE_NUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7x7ZFGrhfp6IQwAA3c

Several drivers register character devices or sysfs attributes before
initializing synchronization objects and related state used by their
userspace entry points. Registration makes those entry points immediately
available, so a concurrent access can reach partially initialized state.

Move each initialization ahead of the corresponding registration. The
patches are independent and cover AoE, fsl-mc, MSHV, IBM VMC, DCSSBLK,
and the RDC321x watchdog.

Jiale Yao (6):
  aoe: initialize error message synchronization before registration
  bus: fsl-mc: initialize UAPI state before device registration
  Drivers: hv: initialize partition table before device registration
  misc: ibmvmc: initialize HMC state before device registration
  s390/dcssblk: initialize device semaphore before sysfs registration
  watchdog: rdc321x: initialize device state before registration

 drivers/block/aoe/aoechr.c       |  6 +++---
 drivers/bus/fsl-mc/fsl-mc-uapi.c |  6 ++----
 drivers/hv/mshv_root_main.c      |  6 +++---
 drivers/misc/ibmvmc.c            | 16 ++++++++--------
 drivers/s390/block/dcssblk.c     |  3 ++-
 drivers/watchdog/rdc321x_wdt.c   | 12 ++++++------
 6 files changed, 24 insertions(+), 25 deletions(-)

-- 
2.34.1


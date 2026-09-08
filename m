Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F87937A845
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 05:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788845984; cv=none; b=JXqZdoYQXizSrE0x68kL07KyEqzBTEVViARf8dIbiGyPYI0egmczwwcKhyksKUw90BYHof/JoJ/WtkPc2SNShwnBawq0UaiglcaAccc5LwB8KBalVwGSdnAC764GvwUPnEF0j/UeKtlv3V1M9AsE9tRGpKeLqokagPWyHK+RPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788845984; c=relaxed/simple;
	bh=TCgPEL0DIPtoJrnu9N8c+v3mKdDbypOHTaZzZn4UrHw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aCWQR5TODiSjhjbzQyPMPitiDlZQ2PTGrwK22gbFnsa/c8fG4+hI3qkekOo/iRVHrRBJTRpQf3vxdv0xSmLgccRBoYsl18QGb3rbBCRXfyek5ZgsBq6me5RtWBG38LUmnsltYCXiKzaNydbTGkKL5wTyTOgWBLERU6c2Xx74FKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ohgUi+Bi; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohgUi+Bi"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48436216a98so2859983f8f.0
        for <linux-s390@vger.kernel.org>; Mon, 07 Sep 2026 22:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845977; x=1789450777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=69M0Zjk6fuHd53vao9gFafQcNB6wevMJ2l/Q6J8x1Ec=;
        b=ohgUi+BiQmHpomizhYpg/IL8m5w9FmnfjscMHO+przxJ8Qe1B6b5bg3eb65wG17s+g
         se4F04vsyZ8HCCX5a9+kqNJ4vaM/yDuchrC7DVphRwPzLcreEOqHSZYC8adxZPk4MNnS
         0auC1PCfRwDgEhxS6/1pxXch5ZDufyg9jS8fNBeVAusDBEN45heVHfMfxDE9A8kzGyRr
         eS0OkdH6QEqnXJNK1Dr47c+kG3JGlT+WPBvVY/+ohMuEz2tXlJncc522FT2BDXvfupV9
         F+2weaBwqSdE/Zrjl9bwvBxPCLxWoohT+ks7s7+N4K0mVNd9gxQUocb/8VTXNvO+9xpy
         yGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845977; x=1789450777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=69M0Zjk6fuHd53vao9gFafQcNB6wevMJ2l/Q6J8x1Ec=;
        b=X8z+HgjbIqJIWyydoS2ZmG2v+dC71n5AvXgROb5S8Mwkv1/46b/mU2oL6LdBxIJfwf
         +qB1HOFISYOtlxhDLFKuRZnTQ2zrcUzCG3NR3hhFtjTTt8fHaJdrxIfYeY1VvX4AVm2a
         +U04pS21QwgmDdRxW/Yu5RUwAM4sV/AWFkDMKyrN6h5kT4cMR5iN3Xqy6OYhum2XrLen
         8x8xV6kTCMVd3qOdKIlE14VzOs/dxe8GWb94cJfJ6DfckbjlXEfgsLtuhuqoQr5TfWNl
         Rpm+UjijsjbQGuzHPnekOhrm71FHbzGdpmOxFg43qEf02Brsd+aDv1G7eMSmulvPX1iJ
         ypaQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2/vbpmW50EDhJoYXoR29BZzDlKoFLSmB6DMEa+LLuODn9P3VkDnZad06uWGom5AU3B42RyZs2zeBh@vger.kernel.org
X-Gm-Message-State: AFuF++msYELw4ClWeuVgSZPbzbsJfM9p3i//eXSy3lN9dKPTwDEcTiJb
	YTUwhp/r46Wu+buS1m3Y5/pW01LpCtF06YbXq/4YPHjNvSVNfDW0m8rD
X-Gm-Gg: AYBFou25eWy1SmcVGTEj73rUMeRU+C50aeKAoSQI/10fOJhq9OC/jk19Px7Gj1pQARR
	j5qitxCT8uSAHfq/HBQwKuI2m6O4ueMESavzw0+35kRBFUbQIf9vKyaF+oBJDTERhmQ+eJujKk0
	gwLQE7jrPYvyti+y3yDYh8CZI5b/pby7NEwW7hA2vZUgnskJ3QqB+LFb/9vo74NoyI5Oy/U15Td
	HlZyyECY5quu0yD+cHfCjbOLAsg7bwJU3i9zD10J/YyOtCFOMD+csc3oHxUfPYuMnxmQPwuMua9
	pGtuapnZ8s8CXQom5l0qd6R63cmsrYE/WI+Vx1LXlKKbpzDmSMIaG591I0YGjqHczbg+vnoCGrl
	gYsWXYSlztnSAk2XTrzcWB0OoKJCImDCHDKcdiZpgyGsJ8NBWxi9w+YYlLPRmb8SFnam51fBGe6
	Jmfrq2/JL/TKwjBFYQOaHTvp2HUMFUw2k0eblHTuHezOIrUJbkigvDYK2zLWCJcXvpLxUr/SbYX
	MHVF2Qgh4AKsHj/A+2glf9hIQVtokTActUste5Umjd48c/ywWKdjCCA4VEt6LN235yVqf9XSrrj
	YVzgmG765qYgVPXDwlC8PGou3RCeQ3nq73bDC/GmUg==
X-Received: by 2002:a05:600c:4e46:b0:49b:910c:7703 with SMTP id 5b1f17b1804b1-49cf823f160mr260148885e9.9.1788845977155;
        Mon, 07 Sep 2026 22:39:37 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm523841335e9.13.2026.09.07.22.39.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 22:39:36 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3 0/6] virtio: fix and add callback synchronization hooks
Date: Tue,  8 Sep 2026 07:38:11 +0200
Message-Id: <20260908053817.26065-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v3 of the callback synchronization series. It is based on
Michael S. Tsirkin's linux-next branch at f49e6cf91942 ("virtio:
synchronize callbacks after device reset"), which already contains the
core change and the virtio_input teardown reorder from v2.

Patches 1 and 2 fix two bugs in virtio-ccw's existing
synchronize_cbs() hook. After a fallback from adapter to classic
interrupts it selects the wrong lock, and the classic interrupt handler
only takes the matching lock when notification hardening is enabled.
Patch 3 adds SRCU tracking for remoteproc callbacks, which can sleep.
Patches 4 and 5 replace the RCU fallback with synchronization against
the UML IRQ and the TmFIFO callback locks. The fallback already covers
these IRQ handlers and spinlock sections. Patch 6 adds SRCU tracking
in virtio_vdpa so callback synchronization does not depend on the
context in which the vDPA driver invokes the callback.

The UML, TmFIFO and remoteproc reset paths do not themselves prevent
new virtqueue callbacks. UML and TmFIFO only clear a status field, and
remoteproc does not wait for the remote side to acknowledge the reset.
Without notification hardening or driver-specific teardown protection,
callbacks can still start after reset. The new synchronization hooks
do not fix that. The TmFIFO hook also does not synchronize with the
rest of the FIFO work item outside the callback locks.

The virtio_input loop change from v2 (continue instead of break, so
events the device already completed are still delivered) and the
event buffer leak are sent separately.

Changes in v3:
- Rebased on Michael's linux-next branch. Dropped the core change and
  the virtio_input patch, which are there already.
- Split the virtio-ccw fixes out of the core patch, one per bug, and
  the transport patch into one patch per transport. The CCW and TmFIFO
  changes are functionally unchanged from v2.
- Patch 2: added a Fixes tag and described the existing shutdown
  case. Removed the dependency note on the core reset change.
- remoteproc: read the queue pointer once in rproc_vq_interrupt(), and
  synchronize with callbacks in __rproc_virtio_del_vqs() before
  freeing the queues (Sashiko). Place vq_srcu next to rvdevs so the
  hunk also applies to mainline, which added attach_work after index.
- virtio_uml: compare against UM_IRQ_ALLOC instead of a bare negative
  check.
- virtio_vdpa: use SRCU instead of a per-device rwlock, so the
  callback tracking uses per-CPU counters, and cover the config
  callback (Sashiko).
- Rewrote the commit messages. Corrected the RCU fallback description
  for UML, TmFIFO and the vDPA simulators. Dropped the claimed simulator
  reset race: the simulators disable bottom halves around virtqueue
  callbacks and serialize reset with the worker's mutex.

Changes in v2:
- Moved callback synchronization from virtio-pci into the core, as
  Michael suggested, and added the missing synchronize_cbs() hooks.

Testing: the changed objects build with W=1 without warnings, with
clang on arm64, x86-64 and s390 and with gcc on SMP UML, and the
patches also apply to current mainline and linux-next. The runtime
tests from v2 were not repeated on this version: the input, rebind and
shutdown checks on arm64 MMIO and x86 PCI covered code that is
unchanged here, and the remoteproc and virtio_vdpa hooks have only
been build-tested. No remoteproc, TmFIFO or s390 hardware was
available.

v2: https://lore.kernel.org/r/20260905152059.89560-1-kmehltretter@gmail.com
v1: https://lore.kernel.org/r/20260818040433.66986-1-kmehltretter@gmail.com

Karl Mehltretter (6):
  virtio_ccw: fix synchronize_cbs() after interrupt fallback
  virtio_ccw: always take irq_lock in the classic interrupt handler
  remoteproc: implement synchronize_cbs() for virtio devices
  um: virtio_uml: implement synchronize_cbs()
  platform/mellanox: mlxbf-tmfifo: implement synchronize_cbs()
  virtio_vdpa: implement synchronize_cbs()

 arch/um/drivers/virtio_uml.c             | 10 +++++++
 drivers/platform/mellanox/mlxbf-tmfifo.c | 15 ++++++++++
 drivers/remoteproc/remoteproc_core.c     | 12 ++++++++
 drivers/remoteproc/remoteproc_virtio.c   | 37 +++++++++++++++++++-----
 drivers/s390/virtio/virtio_ccw.c         |  6 +---
 drivers/virtio/virtio_vdpa.c             | 34 ++++++++++++++++++++--
 include/linux/remoteproc.h               |  3 ++
 7 files changed, 102 insertions(+), 15 deletions(-)


base-commit: f49e6cf919425cc55f10fd7cda7e0fc895df4cc0
-- 
2.39.5 (Apple Git-154)

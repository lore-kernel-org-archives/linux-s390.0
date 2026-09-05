Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC56388377
	for <linux-s390@vger.kernel.org>; Sat,  5 Sep 2026 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788621682; cv=none; b=d4K9w/kdrKhoCGO9Moq0P/KzkHpEtkqV+4PffuJCesNnpXVeLvSL09gSwz3AtX/0Bust3v9IbQkdlhZ8SNtiG3VnSGufSHeMEleNvZTmkF6Jsm/a5G5B78ZM8Qa0IIA2rkrBfHXFFlHZsIlF5JvwezYXCvbkom7PtLH+Gmwk2ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788621682; c=relaxed/simple;
	bh=8uVPDx/td51aPS2alcJ1aZOS4zzVv+wny8A2GZu+Kcc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IjT22D4ZJDTkgHIVaRvOBFixn4JuuNwOEoI/HfpGVhucTTnZjPc+2We0biGI4PIU1AsskBd7PYPh8oSlifP1NwUTdrd5tAKYPUB+dyLsM4mqHiktVnfe6boEikb1ZTV2zsDDTmLjjhovChefy/TnWAYSbhLmF+mPOveZ+U/jYcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkAv5ibx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkAv5ibx"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so19197925e9.2
        for <linux-s390@vger.kernel.org>; Sat, 05 Sep 2026 08:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788621676; x=1789226476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mje6MYnRuPoV/Y41DYCjMHdpBcGzemV8rMOix0c43HA=;
        b=SkAv5ibxItcgoih+oVUDj0FFrIVxzD6xxZ3tO5tO74YHrsSsip6Vmf/smEJ4IO004z
         HQCxhfoNKrXu8ANgYHizNFKiEer3+7/7Sfjf5+X/215ngdkS0Fjqrou/0jfvoBASAfOq
         j7RFHc4P7UrXaWbEMsZ8V5kidC5fwRyb5nJ3SWv+ZNPnmuy0wHJVIpaNFOf/Jil01ZT6
         +pHfVWoE5TcfuC02bFbcL68k+uWJWpB/OQQuxEvPQVBmWwow/DhI93iFyxii7dKlwabI
         hjVaQMV6QONpChvUSrtxtlUw9lIEGKQGHCqquEPKxFrEMY4b2evcpUsHh3qkLMG7Vsio
         Aghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788621676; x=1789226476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mje6MYnRuPoV/Y41DYCjMHdpBcGzemV8rMOix0c43HA=;
        b=Q8UILEaTyqG9kamdQfS5676Y+PeTuFu95NNzy2XZh+qHT1NowU9mn54nLpArLie76U
         dq53SvxXL5x7bYzTtJBVgy+YrdkSKD5pPcQx4p3Y3SdufM8vb9oqMIrsuWqqghwQ0vnp
         DkQWKOfrnPPPHDJidLQIklbhGX0G/W1us2lmGQTxTe0FxnxBcQpLafV2ZD5Lxb8Mpnf6
         z33yRJ6ZUPDAO2iEP0FT5dbIeep2fIHpeS0w/iW7+UBqoRCnzgz3al7E1TNMg0kh8l2V
         Il3MAQcGsQRrq2iShL2cy+ltBrwZcZnudz7kWYyGNRVlFSl5qZqHZQpZxHcMMJupo7Mn
         dGag==
X-Forwarded-Encrypted: i=1; AKwUvBxCrAClXm3T9dsbUoxHyEbhaHcHicGTXf8pxe6iaIM59HPrY4Hl8ef5Povgb4hM+O9wLrVGuaK08JXv@vger.kernel.org
X-Gm-Message-State: AFuF++k8CwVro5fllMXaMCgA1l123yMegL+ZrPMZlbkl94/d1hRi+QTZ
	R1mg5OI4AeubBaC4ou99SsxCuKT0c8MZ8HFdlEcapWPtZR16MAbxmaXO
X-Gm-Gg: AYBFou3YlTj99FOXEkplgr2mFSudNhiupEK/DQ+Cde7X2Uc5wM4jZFLs2SSFLvazGmY
	3ZEqSJPxOTQmhgU6IMgnHcxvyFthpco44nlaD6M+oOApGUQj8WiAlcv8XGieVLWA4sSKlCVEXNZ
	OP1oXrdSbFyxMcK1TEnT/BfpzAxYkharkZ47VpjzTF90oDbt+ytNmPXObjNR4WTXxO7ZACVwXEO
	LKZnVC8eq6l6lQ30QOwxVU31CWVAWT1XF3F6BmmxNCNNHrlf/OwzlkN6JUv91LwBNeTx+RS5lpK
	HtGThzL3sYGHBL9zB/C7/MrZs/PtLvLIW/qdqYCMj7MrP6DkAlHDgUXFJkRLzi/dHbeWynx3Rj2
	yZaVLBFB/oGDohaEmpWVIf1OWvL+IATf/dkS5cR7YdXn69bF1ucamSf+oitEV6S8iUqmJFPBVXM
	SttaL0+nXI67bc/CEfUXch6RAncW7/rQlDXZvvFNkV1018bhOKAtwtQXjHtN7snqctbDeu7ME5c
	zIgPCI/otxNyIUZWmDpq5kDSRVpX+Jdf3YkXmZm8sJQaCqaODt1ilGMXYDx757t2q3RyHhJs1w+
	goiUyQ3Wp3sGo5WamCaMXGzck9n+pHcYDq8jJMQyOei/RFZuSv1sQ9pt2P2D8/ZicW0=
X-Received: by 2002:a05:600c:5493:b0:49b:8f18:714a with SMTP id 5b1f17b1804b1-49cf824a6c5mr137927365e9.12.1788621675623;
        Sat, 05 Sep 2026 08:21:15 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75ce49esm267779515e9.1.2026.09.05.08.21.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 08:21:14 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] virtio: synchronize callbacks during device reset
Date: Sat,  5 Sep 2026 17:20:56 +0200
Message-Id: <20260905152059.89560-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A virtqueue callback can outlive virtio_reset_device() and race with a
driver freeing the state it uses. The reset helper documents that no
callbacks remain in progress, but that depends on the transport:
virtio-pci waits in vp_reset(), while virtio-mmio does not.

virtio_input has a related ordering problem: it unregisters the input
device before resetting the virtio device, while an event callback may
still be using the input device.

Patch 1 moves the callback wait into the core, using the existing
virtio_synchronize_cbs() operation. Patch 2 fixes the virtio_input teardown
order. Patch 3 adds the missing synchronize_cbs hooks for UML, TmFIFO,
remoteproc and virtio-vdpa. Remoteproc uses one SRCU domain per processor.

The new hooks wait for callbacks already running. UML, TmFIFO and
remoteproc still allow new callbacks after reset; fixing that is separate
work. The event-virtqueue DMA mapping issue is also separate.

Changes in v2:
- Patch 1: move the wait into the core instead of fixing only MMIO, as
  Michael suggested. Remove the duplicate PCI wait, preserve its shutdown
  wait, and fix CCW callback locking. Drop the MMIO polling: reset polling
  for v3 and newer is already in fa8833c085b6 ("virtio-mmio: add support
  for transport version 3").
- Patch 2: keep draining completed events when ready becomes false,
  instead of breaking out, so teardown does not truncate an input packet.
- Patch 3 is new, at Michael's request.

I reran the 120-cycle unbind/rebind test in an arm64 KASAN guest with four
vCPUs and a 5 ms busy delay per event. With patch 2 alone over virtio-mmio,
reset returned with the callback still running in all 84 overlapping
cycles. With the series, it waited in all 103. Over PCI with per-queue
MSI-X, it waited in all 66, including runs with threadirqs. No KASAN or
lockdep reports. These runs predate the per-rproc change, which leaves
the tested MMIO and PCI paths unchanged. They confirmed the missing wait,
but did not reproduce a use-after-free: with evdev attached,
input_unregister_device() waits for an RCU grace period that the IRQ
callback blocks.

That version also passed QEMU input, rebind and shutdown checks on arm64
MMIO and x86-64 PCI, including arm64 RT, KASAN and KCSAN builds, and x86
UP/Tiny SRCU. A legacy INTx NIC was present for an additional x86
shutdown check. The changed objects built with W=1 without warnings on
arm64, x86-64, s390 and SMP UML. The per-rproc version built with W=1
on arm64 KASAN and x86 Tiny SRCU, and passed six remoteproc callback and
lifetime KUnit tests on each, using mock remoteproc devices.

Link: https://lore.kernel.org/r/20260818040433.66986-1-kmehltretter@gmail.com

Karl Mehltretter (3):
  virtio: synchronize callbacks during device reset
  virtio_input: stop callbacks before unregistering input device
  virtio: implement synchronize_cbs for remaining transports

 arch/um/drivers/virtio_uml.c             | 10 ++++++++++
 drivers/platform/mellanox/mlxbf-tmfifo.c | 14 ++++++++++++++
 drivers/remoteproc/remoteproc_core.c     | 10 ++++++++++
 drivers/remoteproc/remoteproc_virtio.c   | 20 +++++++++++++++++---
 drivers/s390/virtio/virtio_ccw.c         |  6 +-----
 drivers/virtio/virtio.c                  |  2 ++
 drivers/virtio/virtio_input.c            |  8 ++++++--
 drivers/virtio/virtio_pci_legacy.c       |  2 --
 drivers/virtio/virtio_pci_modern.c       |  3 ---
 drivers/virtio/virtio_vdpa.c             | 21 ++++++++++++++++++++-
 include/linux/remoteproc.h               |  3 +++
 include/linux/virtio_config.h            |  6 +++---
 12 files changed, 86 insertions(+), 19 deletions(-)

base-commit: a500db7819c50db59e55f1b4fa1c3baa5a2616f3
-- 
2.39.5 (Apple Git-154)

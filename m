Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 24 Nov 2017 18:24:03 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 1/2] s390/virtio: remove the old KVM virtio headers
Message-ID: <1511540578-3818-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

commit 7fb2b2d51 ("s390/virtio: remove the old KVM virtio transport")
dropped the transport support. We don't need to keep the header around.

Cc: Thomas Huth <thuth@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

No changes from v2

 arch/s390/include/uapi/asm/kvm_virtio.h | 65 ---------------------------------
 1 file changed, 65 deletions(-)
 delete mode 100644 arch/s390/include/uapi/asm/kvm_virtio.h

diff --git a/arch/s390/include/uapi/asm/kvm_virtio.h b/arch/s390/include/uapi/asm/kvm_virtio.h
deleted file mode 100644
index 7328367..0000000
--- a/arch/s390/include/uapi/asm/kvm_virtio.h
+++ /dev/null
@@ -1,65 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * definition for virtio for kvm on s390
- *
- * Copyright IBM Corp. 2008
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
- *    Author(s): Christian Borntraeger <borntraeger@de.ibm.com>
- */
-
-#ifndef __KVM_S390_VIRTIO_H
-#define __KVM_S390_VIRTIO_H
-
-#include <linux/types.h>
-
-struct kvm_device_desc {
-	/* The device type: console, network, disk etc.  Type 0 terminates. */
-	__u8 type;
-	/* The number of virtqueues (first in config array) */
-	__u8 num_vq;
-	/*
-	 * The number of bytes of feature bits.  Multiply by 2: one for host
-	 * features and one for guest acknowledgements.
-	 */
-	__u8 feature_len;
-	/* The number of bytes of the config array after virtqueues. */
-	__u8 config_len;
-	/* A status byte, written by the Guest. */
-	__u8 status;
-	__u8 config[0];
-};
-
-/*
- * This is how we expect the device configuration field for a virtqueue
- * to be laid out in config space.
- */
-struct kvm_vqconfig {
-	/* The token returned with an interrupt. Set by the guest */
-	__u64 token;
-	/* The address of the virtio ring */
-	__u64 address;
-	/* The number of entries in the virtio_ring */
-	__u16 num;
-
-};
-
-#define KVM_S390_VIRTIO_NOTIFY		0
-#define KVM_S390_VIRTIO_RESET		1
-#define KVM_S390_VIRTIO_SET_STATUS	2
-
-/* The alignment to use between consumer and producer parts of vring.
- * This is pagesize for historical reasons. */
-#define KVM_S390_VIRTIO_RING_ALIGN	4096
-
-
-/* These values are supposed to be in ext_params on an interrupt */
-#define VIRTIO_PARAM_MASK		0xff
-#define VIRTIO_PARAM_VRING_INTERRUPT	0x0
-#define VIRTIO_PARAM_CONFIG_CHANGED	0x1
-#define VIRTIO_PARAM_DEV_ADD		0x2
-
-#endif
-- 
MST

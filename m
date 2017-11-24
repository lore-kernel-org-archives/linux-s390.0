Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 24 Nov 2017 07:21:09 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 2/2] s390/virtio: add BSD license to virtio-ccw
Message-ID: <1511500846-24696-2-git-send-email-mst@redhat.com>
References: <1511500846-24696-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1511500846-24696-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The original intent of the virtio header relicensing
from 2008 was to make sure anyone can implement compatible
devices/drivers. The virtio-ccw was omitted by mistake.

We have an ack from the only contributor as well as the
maintainer from IBM, so it's not too late to fix that.

Make it dual-licensed with GPLv2, as the whole kernel is GPL2.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/s390/include/uapi/asm/virtio-ccw.h | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/uapi/asm/virtio-ccw.h b/arch/s390/include/uapi/asm/virtio-ccw.h
index 967aad3..41c267e 100644
--- a/arch/s390/include/uapi/asm/virtio-ccw.h
+++ b/arch/s390/include/uapi/asm/virtio-ccw.h
@@ -1,14 +1,36 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note or BSD-3-Clause */
 /*
  * Definitions for virtio-ccw devices.
  *
  * Copyright IBM Corp. 2013
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *  Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
+ *
+ * This header is BSD licensed so anyone can use the definitions to implement
+ * compatible drivers/servers.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of IBM nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
  */
 #ifndef __KVM_VIRTIO_CCW_H
 #define __KVM_VIRTIO_CCW_H
-- 
MST

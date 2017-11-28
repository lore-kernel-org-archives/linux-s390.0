Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 28 Nov 2017 14:51:19 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3] s390/virtio: add BSD license to virtio-ccw
Message-ID: <20171128145119.2866d7a7.cohuck@redhat.com>
In-Reply-To: <1511874948-27609-1-git-send-email-mst@redhat.com>
References: <1511874948-27609-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 28 Nov 2017 15:17:52 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> The original intent of the virtio header relicensing
> from 2008 was to make sure anyone can implement compatible
> devices/drivers. The virtio-ccw was omitted by mistake.
> 
> We have an ack from the only contributor as well as the
> maintainer from IBM, so it's not too late to fix that.
> 
> Make it dual-licensed with GPLv2, as the whole kernel is GPL2.
> 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/s390/include/uapi/asm/virtio-ccw.h | 6 +-----
>  arch/s390/kernel/setup.c                | 1 -
>  2 files changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/s390/include/uapi/asm/virtio-ccw.h b/arch/s390/include/uapi/asm/virtio-ccw.h
> index 967aad3..2b605f7 100644
> --- a/arch/s390/include/uapi/asm/virtio-ccw.h
> +++ b/arch/s390/include/uapi/asm/virtio-ccw.h
> @@ -1,13 +1,9 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
>  /*
>   * Definitions for virtio-ccw devices.
>   *
>   * Copyright IBM Corp. 2013
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License (version 2 only)
> - * as published by the Free Software Foundation.
> - *
>   *  Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
>   */
>  #ifndef __KVM_VIRTIO_CCW_H
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 164a1e1..c022007 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -60,7 +60,6 @@
>  #include <asm/ptrace.h>
>  #include <asm/sections.h>
>  #include <asm/ebcdic.h>
> -#include <asm/kvm_virtio.h>
>  #include <asm/diag.h>
>  #include <asm/os_info.h>
>  #include <asm/sclp.h>

Shouldn't the second hunk already be in master?

Still ack otherwise.

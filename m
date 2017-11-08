Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 8 Nov 2017 18:02:39 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] s390/virtio: mark headers as BSD licensed
Message-ID: <20171108180239.213ee93b.cohuck@redhat.com>
In-Reply-To: <1510160307-13235-1-git-send-email-mst@redhat.com>
References: <1510160307-13235-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 8 Nov 2017 18:59:21 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Virtio UAPI headers aren't just for UAPI, it's for guests/hypervisors as
> well.  The s390 ones need to be BSD as well.
> 
> Fixes: e2be04c7f995 ("License cleanup: add SPDX license identifier to uapi header files with a license")
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Cornelia Huck <cohuck@redhat.com>

...but this should also get an ack by some IBMers.

> ---
> 
> since v1:
> 	drop an extra comment chunk, reported by Cornelia
> 
>  arch/s390/include/uapi/asm/kvm_virtio.h | 26 +++++++++++++++++++++++++-
>  arch/s390/include/uapi/asm/virtio-ccw.h | 26 +++++++++++++++++++++++++-
>  2 files changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/uapi/asm/kvm_virtio.h b/arch/s390/include/uapi/asm/kvm_virtio.h
> index 7328367..1773693 100644
> --- a/arch/s390/include/uapi/asm/kvm_virtio.h
> +++ b/arch/s390/include/uapi/asm/kvm_virtio.h
> @@ -1,4 +1,28 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* This header is BSD licensed so anyone can use the definitions to implement
> + * compatible drivers/servers.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in the
> + *    documentation and/or other materials provided with the distribution.
> + * 3. Neither the name of IBM nor the names of its contributors
> + *    may be used to endorse or promote products derived from this software
> + *    without specific prior written permission.
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS'' AND
> + * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR CONTRIBUTORS BE LIABLE
> + * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
> + * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
> + * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
> + * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
> + * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> + * SUCH DAMAGE. */
>  /*
>   * definition for virtio for kvm on s390
>   *
> diff --git a/arch/s390/include/uapi/asm/virtio-ccw.h b/arch/s390/include/uapi/asm/virtio-ccw.h
> index 967aad3..ae7a6eb 100644
> --- a/arch/s390/include/uapi/asm/virtio-ccw.h
> +++ b/arch/s390/include/uapi/asm/virtio-ccw.h
> @@ -1,4 +1,28 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* This header is BSD licensed so anyone can use the definitions to implement
> + * compatible drivers/servers.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in the
> + *    documentation and/or other materials provided with the distribution.
> + * 3. Neither the name of IBM nor the names of its contributors
> + *    may be used to endorse or promote products derived from this software
> + *    without specific prior written permission.
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS'' AND
> + * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR CONTRIBUTORS BE LIABLE
> + * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
> + * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
> + * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
> + * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
> + * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> + * SUCH DAMAGE. */
>  /*
>   * Definitions for virtio-ccw devices.
>   *

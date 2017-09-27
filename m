From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] drivers/s390/virtio: Remove the old KVM virtio
 transport
Date: Wed, 27 Sep 2017 15:03:34 +0200
Message-ID: <20170927150334.636e0b1f.cohuck@redhat.com>
References: <1506512521-2244-1-git-send-email-thuth@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1506512521-2244-1-git-send-email-thuth@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 27 Sep 2017 13:42:01 +0200
Thomas Huth <thuth@redhat.com> wrote:

> There is no recent user space application available anymore which still
> supports this old virtio transport. Additionally, commit 3b2fbb3f06ef
> ("virtio/s390: deprecate old transport") introduced a deprecation message
> in the driver, and apparently nobody complained so far that it is still
> required. So let's simply remove it.

It has done its job of uncovering problems in QEMU's tcg code, so I
guess we can remove it :)

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/s390/Kconfig                |  13 -
>  drivers/s390/virtio/Makefile     |   3 -
>  drivers/s390/virtio/kvm_virtio.c | 515 ---------------------------------------
>  3 files changed, 531 deletions(-)
>  delete mode 100644 drivers/s390/virtio/kvm_virtio.c
> 

> diff --git a/drivers/s390/virtio/Makefile b/drivers/s390/virtio/Makefile
> index df40692..d9942e0 100644
> --- a/drivers/s390/virtio/Makefile
> +++ b/drivers/s390/virtio/Makefile
> @@ -7,7 +7,4 @@
>  # as published by the Free Software Foundation.
>  
>  s390-virtio-objs := virtio_ccw.o
> -ifdef CONFIG_S390_GUEST_OLD_TRANSPORT
> -s390-virtio-objs += kvm_virtio.o
> -endif
>  obj-$(CONFIG_S390_GUEST) += $(s390-virtio-objs)

We could simplify this? Does not really matter, though.

This seems to be all of it (other than the uapi stuff).

I can apply this and submit it through virtio, but as I don't have
anything else queued, I would be fine with it going through the s390
architecture tree. In that case,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

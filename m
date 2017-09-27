From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] drivers/s390/virtio: Remove the old KVM virtio transport
Date: Wed, 27 Sep 2017 14:55:30 +0200
Message-ID: <20170927125530.GE4032@osiris>
References: <1506512521-2244-1-git-send-email-thuth@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1506512521-2244-1-git-send-email-thuth@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Sep 27, 2017 at 01:42:01PM +0200, Thomas Huth wrote:
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

Would you mind to simplify the Makefile to just the single line

obj-$(CONFIG_S390_GUEST) += virtio_ccw.o

while you are touching it anyway?

From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/2] virtio/s390 patches for 4.8
Date: Thu, 7 Jul 2016 19:42:52 +0300
Message-ID: <20160707194246-mutt-send-email-mst@redhat.com>
References: <1467904077-1887-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467904077-1887-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: borntraeger@de.ibm.com, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jul 07, 2016 at 05:07:55PM +0200, Cornelia Huck wrote:
> Michael,
> 
> here are two virtio/s390 patches for 4.8.
> 
> First, Jing Liu noticed that she could trigger panics while playing
> around with hvc0 as preferred console but no virtio console: This
> can be fixed by not discarding our early_put_chars after init (as
> the minimal fix).
> 
> This made us wonder why we still have that code around when no current
> host code supports the old transport: We have no idea whether this
> still works, and it's probably a good idea to put a deprecation
> message in there to check whether anyone screams.
> 
> Patches are against your vhost branch.

thanks!

> Christian Borntraeger (1):
>   virtio/s390: keep early_put_chars
> 
> Cornelia Huck (1):
>   virtio/s390: deprecate old transport
> 
>  arch/s390/Kconfig                | 13 +++++++++++++
>  drivers/s390/virtio/Makefile     |  6 +++++-
>  drivers/s390/virtio/kvm_virtio.c |  4 +++-
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 
> -- 
> 2.6.6

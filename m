From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v8 13/13] MAINTAINERS: Add vfio-ccw maintainer
Date: Thu, 18 May 2017 15:09:46 +0200
Message-ID: <20170518150946.3c747ffb.cornelia.huck@de.ibm.com>
References: <20170517004813.58227-1-bjsdjshi@linux.vnet.ibm.com>
        <20170517004813.58227-14-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170517004813.58227-14-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, eric.auger@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 17 May 2017 02:48:13 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Add Cornelia Huck as the vfio-ccw maintainer.
> 
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index efdec47319..a4ae36b411 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -997,6 +997,13 @@ S: Supported
>  F: hw/vfio/*
>  F: include/hw/vfio/
> 
> +vfio-ccw
> +M: Cornelia Huck <cornelia.huck@de.ibm.com>
> +S: Supported
> +F: hw/vfio/ccw.c
> +F: hw/s390x/s390-ccw.c
> +F: include/hw/s390x/s390-ccw.h
> +
>  vhost
>  M: Michael S. Tsirkin <mst@redhat.com>
>  S: Supported

I'll take vfio-ccw patches via the normal s390-next tree, I guess.
Added a T: section.

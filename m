From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v7 13/13] MAINTAINERS: Add vfio-ccw maintainer
Date: Fri, 5 May 2017 14:20:14 +0200
Message-ID: <20170505142014.28c849b8.cornelia.huck@de.ibm.com>
References: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
        <20170505020352.8984-14-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170505020352.8984-14-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, eric.auger@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Fri,  5 May 2017 04:03:52 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Add Cornelia Huck as the vfio-ccw maintainer.
> 
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cae3b09..c1f9917 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -999,6 +999,11 @@ S: Supported
>  F: hw/vfio/*
>  F: include/hw/vfio/
> 
> +vfio-ccw
> +M: Cornelia Huck <cornelia.huck@de.ibm.com>
> +S: Supported
> +F: hw/vfio/ccw.c

The other code related to vfio-ccw is entangled with the other virtual
css code, so this is probably really the only file that needs to be
listed separately.

I will likely take any vfio-ccw changes together with the other code I
take through s390-next. I'll add the respective line when I apply.

> +
>  vhost
>  M: Michael S. Tsirkin <mst@redhat.com>
>  S: Supported

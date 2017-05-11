From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v7 13/13] MAINTAINERS: Add vfio-ccw maintainer
Date: Thu, 11 May 2017 15:49:23 -0600
Message-ID: <20170511154923.1ed1c6fe@w520.home>
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
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, eric.auger@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Fri,  5 May 2017 04:03:52 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Add Cornelia Huck as the vfio-ccw maintainer.
> 
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---


Acked-by: Alex Williamson <alex.williamson@redhat.com>


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
> +
>  vhost
>  M: Michael S. Tsirkin <mst@redhat.com>
>  S: Supported

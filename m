From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] MAINTAINERS/vfio-ccw: add Farhan and Eric, make Halil
 Reviewer
Date: Wed, 12 Dec 2018 16:50:29 +0100
Message-ID: <20181212165029.1e8404bd.cohuck@redhat.com>
References: <20181212145929.136522-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212145929.136522-1-borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 12 Dec 2018 15:59:29 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Eric and Farhan will help with maintaining vfio-ccw.
> 
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Farhan Ali <alifm@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8119141a926f..879594b93385 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13026,7 +13026,9 @@ F:	drivers/pci/hotplug/s390_pci_hpc.c
>  
>  S390 VFIO-CCW DRIVER
>  M:	Cornelia Huck <cohuck@redhat.com>
> -M:	Halil Pasic <pasic@linux.ibm.com>
> +M:	Farhan Ali <alifm@linux.ibm.com>
> +M:	Eric Farman <farman@linux.ibm.com>
> +R:	Halil Pasic <pasic@linux.ibm.com>
>  L:	linux-s390@vger.kernel.org
>  L:	kvm@vger.kernel.org
>  S:	Supported

Thanks, applied.

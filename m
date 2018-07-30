From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 30 Jul 2018 12:46:23 +0000
Subject: Re: [PATCH v7 06/22] s390/zcrypt: Support for apmask and aqmask change on live system
Message-Id: <20180730144623.254a076e.cohuck@redhat.com>
In-Reply-To: <20180726195429.31960-7-borntraeger@de.ibm.com>
References: <20180726195429.31960-7-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 26 Jul 2018 21:54:13 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Harald Freudenberger <freude@linux.ibm.com>
> 
> This patch enables modifications of the apmask and aqmask on a live
> system. Until now these both masks are read-only on a live system. The
> only way to change these masks was via kernel command line parameter.
> 
> This patch makes the sysfs attributes /sys/bus/ap/apmask and
> /sys/bus/ap/aqmask writeable by root. With changing the mask(s) a
> revision of the existing queue to driver bindings is done. So all
> APQNs which are bound to the 'wrong' driver are reprobed via kernel
> function device_reprobe() and thus the new correct driver will be
> assigned with respect of the changed apmask and aqmask bits.

The expected input for those attributes needs to be documented.

IIRC the vfio-ap driver does not support device removal in the first
shot. So, what happens if an APQN is added to the reserved set? BUG()?

> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/s390/crypto/ap_bus.c | 153 ++++++++++++++++++++++++++++++++---
>  1 file changed, 143 insertions(+), 10 deletions(-)

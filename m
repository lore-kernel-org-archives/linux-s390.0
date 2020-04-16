Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 16 Apr 2020 11:33:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v7 03/15] s390/zcrypt: driver callback to indicate
 resource in use
Message-ID: <20200416113356.28fcef8c.cohuck@redhat.com>
In-Reply-To: <82675d5c-4901-cbd8-9287-79133aa3ee68@linux.ibm.com>
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
        <20200407192015.19887-4-akrowiak@linux.ibm.com>
        <20200414145851.562867ae.cohuck@redhat.com>
        <82675d5c-4901-cbd8-9287-79133aa3ee68@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com

On Wed, 15 Apr 2020 08:08:24 +0200
Harald Freudenberger <freude@linux.ibm.com> wrote:

> On 14.04.20 14:58, Cornelia Huck wrote:
> > On Tue,  7 Apr 2020 15:20:03 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> >> +	/* The non-default driver's module must be loaded */
> >> +	if (!try_module_get(drv->owner))
> >> +		return 0;  
> > Is that really needed? I would have thought that the driver core's
> > klist usage would make sure that the callback would not be invoked for
> > drivers that are not registered anymore. Or am I missing a window?  
> The try_module_get() and module_put() is a result of review feedback from
> my side. The ap bus core is static in the kernel whereas the
> vfio dd is a kernel module. So there may be a race condition between
> calling the callback function and removal of the vfio dd module.
> There is similar code in zcrypt_api which does the same for the zcrypt
> device drivers before using some variables or functions from the modules.
> Help me, it this is outdated code and there is no need to adjust the
> module reference counter any more, then I would be happy to remove
> this code :-)

I think the driver core already should keep us safe. A built-in bus
calling a driver in a module is a very common pattern, and I think
->owner was introduced exactly for that case.

Unless I'm really missing something obvious?

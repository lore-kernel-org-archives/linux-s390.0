Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 24 Apr 2020 05:33:38 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v7 03/15] s390/zcrypt: driver callback to indicate
 resource in use
In-Reply-To: <20200416113721.124f9843.cohuck@redhat.com>
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
        <20200407192015.19887-4-akrowiak@linux.ibm.com>
        <20200414145851.562867ae.cohuck@redhat.com>
        <35d8c3cb-78bb-8f84-41d8-c6e59d201ba0@linux.ibm.com>
        <20200416113721.124f9843.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20200424053338.658b2a05.pasic@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com

On Thu, 16 Apr 2020 11:37:21 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 15 Apr 2020 13:10:10 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
> > On 4/14/20 8:58 AM, Cornelia Huck wrote:
> > > On Tue,  7 Apr 2020 15:20:03 -0400
> > > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
> > >> +
> > >> +	if (ap_drv->in_use)
> > >> +		if (ap_drv->in_use(newapm, ap_perms.aqm))  
> > > Can we log the offending apm somewhere, preferably with additional info
> > > that allows the admin to figure out why an error was returned?  
> > 
> > One of the things on my TODO list is to add logging to the vfio_ap
> > module which will track all significant activity within the device
> > driver. I plan to do that with a patch or set of patches specifically
> > put together for that purpose. Having said that, the best place to
> > log this would be in the in_use callback in the vfio_ap device driver
> > (see next patch) where the APQNs that are in use can be identified.
> > For now, I will log a message to the dmesg log indicating which
> > APQNs are in use by the matrix mdev.
> 
> Sounds reasonable. My main issue was what an admin was supposed to do
> until logging was in place :)

Logging may not be the right answer here. Imagine somebody wants to build
a nice web-tool for managing this stuff at scale -- e.g. something HMC. I
don't think the solution is to let this tool parse the kernel messages
and try to relate that to its own transactions.

But I do agree, having a way to report why "won't do" to the end user is
important for usability.

Regards,
Halil

> 
> > 
> > >  
> > >> +			rc = -EADDRINUSE;
> > >> +
> > >> +	module_put(drv->owner);
> > >> +
> > >> +	return rc;
> > >> +}  
> 

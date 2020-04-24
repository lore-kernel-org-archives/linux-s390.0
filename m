Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 24 Apr 2020 20:23:48 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v7 03/15] s390/zcrypt: driver callback to indicate
 resource in use
Message-ID: <20200424202348.39bb2eaf.pasic@linux.ibm.com>
In-Reply-To: <195d237d-c668-48ca-1125-08eafc0011db@linux.ibm.com>
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
        <20200407192015.19887-4-akrowiak@linux.ibm.com>
        <20200414145851.562867ae.cohuck@redhat.com>
        <35d8c3cb-78bb-8f84-41d8-c6e59d201ba0@linux.ibm.com>
        <20200416113721.124f9843.cohuck@redhat.com>
        <20200424053338.658b2a05.pasic@linux.ibm.com>
        <195d237d-c668-48ca-1125-08eafc0011db@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com

On Fri, 24 Apr 2020 13:07:38 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> 
> 
> On 4/23/20 11:33 PM, Halil Pasic wrote:
> > On Thu, 16 Apr 2020 11:37:21 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >
> >> On Wed, 15 Apr 2020 13:10:10 -0400
> >> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >>
> >>> On 4/14/20 8:58 AM, Cornelia Huck wrote:
> >>>> On Tue,  7 Apr 2020 15:20:03 -0400
> >>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >>>>> +
> >>>>> +	if (ap_drv->in_use)
> >>>>> +		if (ap_drv->in_use(newapm, ap_perms.aqm))
> >>>> Can we log the offending apm somewhere, preferably with additional info
> >>>> that allows the admin to figure out why an error was returned?
> >>> One of the things on my TODO list is to add logging to the vfio_ap
> >>> module which will track all significant activity within the device
> >>> driver. I plan to do that with a patch or set of patches specifically
> >>> put together for that purpose. Having said that, the best place to
> >>> log this would be in the in_use callback in the vfio_ap device driver
> >>> (see next patch) where the APQNs that are in use can be identified.
> >>> For now, I will log a message to the dmesg log indicating which
> >>> APQNs are in use by the matrix mdev.
> >> Sounds reasonable. My main issue was what an admin was supposed to do
> >> until logging was in place :)
> > Logging may not be the right answer here. Imagine somebody wants to build
> > a nice web-tool for managing this stuff at scale -- e.g. something HMC. I
> > don't think the solution is to let this tool parse the kernel messages
> > and try to relate that to its own transactions.
> 
> I don't believe there is no right or wrong answer here; I simply don't
> see the relevance of discussing a tool in this context. We are talking
> about a sysfs attribute interface here, so - correct me if I'm
> mistaken - our options for notifying the user that a queue is in use are
> limited to the return code from the sysfs interface and logging. I would
> expect that a tool would have to do something similar to the callback
> implemented in the vfio_ap device driver and check the APQNs
> removed against the APQNs assigned to the mdevs to determine which
> is in use.
> 

We are talking interface design. The relevance of discussing a tool is
that any userspace tool must come by with whatever interface we come up
now. IMHO thinking about the usage (and the client code) is very helpful
in avoiding broken interface designs. AFAIK this is one of the basic
ideas behind test driven development.

Regards,
Halil

From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 1/9] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
Date: Mon, 18 Feb 2019 13:01:47 +0100
Message-ID: <20190218130147.5ed3edbe.cohuck@redhat.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
        <1550152269-6317-2-git-send-email-pmorel@linux.ibm.com>
        <20190214155441.087d2a68.cohuck@redhat.com>
        <9403117a-04a6-8f69-2a61-f96d35a59555@linux.ibm.com>
        <20190214175730.4ab609ae.cohuck@redhat.com>
        <9200b1f8-874f-ffa7-bef0-19ca570d7ac1@linux.ibm.com>
        <eac03540-a499-fa0f-1a4a-b5cc99030775@linux.ibm.com>
        <20190215101118.5417d725.cohuck@redhat.com>
        <f38c99e6-bb25-9179-e4cd-20ba8482111f@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f38c99e6-bb25-9179-e4cd-20ba8482111f@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: pmorel@linux.ibm.com, borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 15 Feb 2019 16:59:33 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 2/15/19 4:11 AM, Cornelia Huck wrote:
> > On Thu, 14 Feb 2019 13:30:59 -0500
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >   
> >> On 2/14/19 12:36 PM, Pierre Morel wrote:  
> >>> On 14/02/2019 17:57, Cornelia Huck wrote:  

> >>>> (And reading further in the current code, it seems we clear that
> >>>> structure _after_ the matrix device had been setup, so how can that
> >>>> even work? Where am I confused?)  
> >>>
> >>> On device_register there were no bus, so the core just do not look for a
> >>> driver and this field was nor tested nor overwritten.  
> > 
> > Hm... so has the callback in driver_for_each_device() in
> > vfio_ap_verify_queue_reserved() ever been invoked at all? It seems this
> > patch fixes more than just libudev issues...  
> 
> It is this patch that rendered the driver_for_each_device() in
> vfio_ap_verify_queue_reserved() erroneous. That function gets called
> every time an adapter or domain is assigned to the mdev. This patch
> introduced the problem with driver_for_each_device().

So, does this function need to be removed or called from another place,
then? (It looks like it was dead code before.)

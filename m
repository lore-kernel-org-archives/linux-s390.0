From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9 12/22] s390: vfio-ap: sysfs interfaces to configure
 control domains
Date: Mon, 27 Aug 2018 15:51:26 +0200
Message-ID: <20180827155126.440f2170.cohuck@redhat.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-13-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180820162317.08bd7d23.cohuck@redhat.com>
        <660de00a-c403-28c1-4df4-82a973ab3ad5@linux.ibm.com>
        <20180821172548.57a6c758.cohuck@redhat.com>
        <82a391ee-85b1-cdc7-0f9b-d37fd8ba8e47@linux.ibm.com>
        <a43ef10f-aa91-cb4c-a8aa-cd3ce9cfebf2@linux.ibm.com>
        <20180822114250.59a250aa.cohuck@redhat.com>
        <8bc5f207-f913-825c-f9fc-0a2c7fd280aa@linux.ibm.com>
        <e36abc22-9daf-e0f4-c6b3-7adbb28db4c3@de.ibm.com>
        <f84dbcc0-f627-be02-9933-3baa953adc09@linux.ibm.com>
        <219b352b-d5a2-189c-e205-82e7f9ae3d64@de.ibm.com>
        <dbb74c9c-93ab-ed05-fad4-ea2aa5f2b71e@linux.ibm.com>
        <9ef5fcb9-02e0-88e3-007c-eedb14e6db80@linux.ibm.com>
        <20180823122525.02fc4af3.cohuck@redhat.com>
        <decfe307-4449-2c85-0b7e-6f2fcdb1164f@linux.ibm.com>
        <20180827103316.4e7fbc10.cohuck@redhat.com>
        <65cb82b5-85ce-1831-5b2a-719d2cf27be8@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <65cb82b5-85ce-1831-5b2a-719d2cf27be8@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, pmorel@linux.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, 27 Aug 2018 09:47:58 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 08/27/2018 04:33 AM, Cornelia Huck wrote:
> > On Thu, 23 Aug 2018 10:16:59 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >  
> >> On 08/23/2018 06:25 AM, Cornelia Huck wrote:  
> >>> On Wed, 22 Aug 2018 15:16:19 -0400
> >>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >>>     
> >>>> One of the things I suggested in a private conversation with Christian
> >>>> earlier
> >>>> today was to provide an additional rw sysfs attribute - a boolean - that
> >>>> indicates
> >>>> whether all usage domains should also be control domains. The default
> >>>> could be
> >>>> true. This would allow one to configure guests with usage-only domains
> >>>> as well
> >>>> as satisfy the convention.  
> >>> Would this additional attribute then control "add usage domains to the
> >>> list of control domains automatically", or "don't allow to add a usage
> >>> domain if it has not already been added as a control domain"?  
> >> It was just a proposal that wasn't really discussed at all, but this
> >> attribute would add usage domains to the list of control domains
> >> automatically if set to one. That would be the default behavior which
> >> would be turned off by manually setting it to zero.  
> > If we want to do something like that, having it add the usage domains
> > automatically sounds like the more workable alternative. What I like
> > about this is that we make it explicit that we change the masks beyond
> > what the admin explicitly configured, and provide a knob to turn off
> > that behaviour.  
> 
> So, are you saying I should go ahead and implement this?

I'm just saying that it does not sound like a bad idea :)

If you agree that it's a good idea and if others also like it... I'd
certainly not mind you going ahead :)

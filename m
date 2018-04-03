From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 05/14] s390: vfio-ap: base implementation of VFIO AP
 device driver
Date: Tue, 3 Apr 2018 11:56:08 +0200
Message-ID: <20180403115608.34eabb46.cohuck@redhat.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1521051954-25715-6-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1d5a5e18-1886-dd73-a17e-9bec617507ba@linux.vnet.ibm.com>
        <e4d7621c-a09c-bdfd-ffe2-35c5ea3acdc7@linux.vnet.ibm.com>
        <20180327131705.46fded40.cohuck@redhat.com>
        <29443c81-19b4-5811-798c-e324b34c083a@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <29443c81-19b4-5811-798c-e324b34c083a@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 27 Mar 2018 16:45:02 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 27/03/2018 13:17, Cornelia Huck wrote:
> > On Thu, 15 Mar 2018 13:25:25 -0400
> > Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> >  
> >> On 03/15/2018 09:25 AM, Pierre Morel wrote:  
> >>> On 14/03/2018 19:25, Tony Krowiak wrote:  
> >>>> +config VFIO_AP
> >>>> +    def_tristate m  
> >>> not sure it must be module by default.
> >>> I would not set it by default.  
> >> Connie also asked about this in the last review, so I will go ahead
> >> and change it.  
> >>>     
> >>>> +    prompt "VFIO support for AP devices"
> >>>> +    depends on ZCRYPT && VFIO_MDEV_DEVICE  
> >>> VFIO_MDEV_DEVICE is a general feature *needed* by VFIO_AP
> >>> and has no use case by its own. If it is set it is obviously because some
> >>> mediated device drivers needs it.
> >>> while ZCRYPT is a Z feature which may be set without VFIO_AP.
> >>>
> >>> So you need:
> >>>
> >>> config VFIO_AP
> >>>      def_tristate n
> >>>      prompt "VFIO support for AP devices"
> >>>      depends on ZCRYPT
> >>>      select VFIO_MDEV
> >>>      select VFIO_MDEV_DEVICE
> >>> ...  
> >> I was thinking the same just yesterday and I agree, this makes sense.  
> > OTOH, nobody else seems to do a select on these symbols so far.
> >
> > If you decide to go that route, you'll also need to depend on VFIO  
> 
> I think a select is better (again).
> 
> > (otherwise you could end up selecting symbols with unmet dependencies).
> > All in all, I prefer the 'depends' approach.
> >  
> Why do you prefer this approach?

Hm, I thought I had already written a mail, but apparently I didn't....
 
> I can tell you why I prefer a mixed approach:
> 
> We have two tools, depends and select.
> 
> It seems to me that depends should be used for things we can not choose 
> to be there or not, but things that just are there, like hardware 
> dependencies. For example MMU, CPU type, CRYPTO hardware...
> 
> Select on the other hand is useful to choose things that we need like 
> libraries, VFIO, VIRTIO, crypto libraries etc.
> 
> Using this policy is clear and makes easy to choose functionalities and 
> get the utilities automatically.
> 
> On the other hand, only using depends makes things to hide the 
> functionalities behind the utilities.

My view is the following:
- select is useful for library functionality or for enabling
  architecture-specific optimizations (the HAVE_xxx symbols),
  especially things you don't want the user to deal with. If you select
  something, you need to take care of any dependencies yourself.
- depends is useful for more complex dependencies, and especially
  things you don't want automagically enabled. [In modern menuconfig,
  it is easy to figure out any missing dependencies for a config option
  anyway.]

The mdev infrastructure is too complex to be considered a simple
library IMO (cf. the missing VFIO dependency).

From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9 10/22] s390: vfio-ap: sysfs interfaces to configure
 adapters
Date: Thu, 16 Aug 2018 09:30:15 +0200
Message-ID: <20180816093015.19e54936.cohuck@redhat.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-11-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180815115242.35a2a1ce.cohuck@redhat.com>
        <4bf27c7a-34c6-9160-cdc6-19022b86202b@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4bf27c7a-34c6-9160-cdc6-19022b86202b@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 15 Aug 2018 12:59:35 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 08/15/2018 05:52 AM, Cornelia Huck wrote:
> > On Mon, 13 Aug 2018 17:48:07 -0400
> > Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> >> +/**
> >> + * unassign_adapter_store
> >> + *
> >> + * @dev: the matrix device
> >> + * @attr: a mediated matrix device attribute
> >> + * @buf: a buffer containing the adapter ID (APID) to be assigned
> >> + * @count: the number of bytes in @buf
> >> + *
> >> + * Parses the APID from @buf and unassigns it from the mediated matrix device.
> >> + * The APID must be a valid value  
> > A valid value, but not necessarily assigned, right?  
> 
> You are correct, if the APID is not assigned, then the corresponding bit 
> will be
> cleared regardless. In a previous version, the functions failed if the 
> APID is
> not assigned, but a colleague removed that check. I guess it makes sense 
> given
> it really does not hurt anything to ask to unassign an APID that isn't 
> assigned
> to begin with. Would you prefer I update the comment, or do you feel the 
> user
> should be made aware of an attempt to unassign an APID that is not assigned?

I think the code is fine; updating the comment would be good.

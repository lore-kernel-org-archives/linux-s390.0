Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 27 Apr 2020 17:17:39 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v7 01/15] s390/vfio-ap: store queue struct in hash table
 for quick access
Message-ID: <20200427171739.76291a74.pasic@linux.ibm.com>
In-Reply-To: <d15b4a8e-66eb-e4ce-c8ac-6885519940aa@linux.ibm.com>
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
        <20200407192015.19887-2-akrowiak@linux.ibm.com>
        <20200424055732.7663896d.pasic@linux.ibm.com>
        <d15b4a8e-66eb-e4ce-c8ac-6885519940aa@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com

On Mon, 27 Apr 2020 15:05:23 +0200
Harald Freudenberger <freude@linux.ibm.com> wrote:

> On 24.04.20 05:57, Halil Pasic wrote:
> > On Tue,  7 Apr 2020 15:20:01 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >  
> >> Rather than looping over potentially 65535 objects, let's store the
> >> structures for caching information about queue devices bound to the
> >> vfio_ap device driver in a hash table keyed by APQN.  
> > @Harald:
> > Would it make sense to make the efficient lookup of an apqueue base
> > on its APQN core AP functionality instead of each driver figuring it out
> > on it's own?
> >
> > If I'm not wrong the zcrypt device/driver(s) must the problem of
> > looking up a queue based on its APQN as well.
> >
> > For instance struct ep11_cprb has a target_id filed
> > (arch/s390/include/uapi/asm/zcrypt.h).
> >
> > Regards,
> > Halil  
> 
> Hi Halil
> 
> no, the zcrypt drivers don't have this problem. They build up their own device object which
> includes a pointer to the base ap device.

I'm a bit confused. Doesn't your code loop first trough the ap_card
objects to find the APID portion of the APQN, and then loop the queue
list of the matching card to find the right ap_queue object? Or did I
miss something? Isn't that what _zcrypt_send_ep11_cprb() does? Can you
point me to the code that avoids the lookup (by apqn) for zcrypt?


If you look at the new function of vfio_ap_get_queue(unsigned long apqn)
it basically about finding the queue based on the apqn, with the
difference that it is vfio specific.

Regards,
Halil

> 
> However, this is not a big issue, as the ap_bus holds a list of ap_card objects and within each
> ap_card object there exists a list of ap_queues.

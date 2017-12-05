From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [RFC 19/19] s390/facilities: enable AP facilities needed by guest
Date: Tue, 5 Dec 2017 10:01:31 -0500
Message-ID: <7557ad65-48dd-9a82-2988-8a124d765939@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1507916344-3896-20-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20171016112510.39e9c330@mschwideX1>
 <3e836f59-3ef1-57d8-d6df-b66011c173c4@de.ibm.com>
 <af1bb867-f9a0-458b-b7b2-c0bb9456eb7f@linux.vnet.ibm.com>
 <6d9ae0c1-6f64-1562-bf10-864cf66e3a08@de.ibm.com>
 <40cdab64-9eeb-02bd-f260-80e9da8c9034@linux.vnet.ibm.com>
 <35f17b01-49e0-eafb-ad05-c642c579dd3a@de.ibm.com>
 <8c8c7a0e-2ae4-443b-9444-e2022436c3ee@linux.vnet.ibm.com>
 <c0d076cb-7a22-c5fd-224d-96aff7d40bac@linux.vnet.ibm.com>
 <20171205150421.01ec1ed8.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171205150421.01ec1ed8.cohuck@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Harald Freudenberger <freude@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, freude@de.ibm.com, pmorel@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, heiko.carstens@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 12/05/2017 09:04 AM, Cornelia Huck wrote:
> On Tue, 5 Dec 2017 08:52:57 +0100
> Harald Freudenberger <freude@linux.vnet.ibm.com> wrote:
>
>> On 12/02/2017 02:30 AM, Tony Krowiak wrote:
>>> I agree with your suggestion that defining a new CPU model feature is probably
>>> the best way to resolve this issue. The question is, should we define a single
>>> feature indicating whether AP instructions are installed and set features bits
>>> for the guest based on whether or not they are set in the linux host, or should
>>> we define additional CPU model features for turning features bits on and off?
>>> I guess it boils down to what behavior is expected for the AP bus running on
>>> the linux guest. Here is a rundown of the facilities bits associated with AP
>>> and how they affect the behavior of the AP bus:
>>>
>>> * STFLE.12 indicates whether the AP query function is available. If this bit
>>>    is not set, then the AP bus scan will only test domains 0-15. For example,
>>>    if adapters 4, 5, and 6 and domains 12 and 71 (0x47) are installed, then AP
>>>    queues 04.0047, 05.0047 and 06.0047 will not be made available.
>> STFLE 12 is the indication for Query AP Configuration Information (QCI) available.
>>> * STFLE.15 indicates whether the AP facilities test function is available. If
>>>    this bit is not set, then the CEX4, CEX5 and CEX6 device drivers discovered
>>>    by the AP bus scan will not get bound to any AP device drivers. Since the
>>>    AP matrix model supports only CEX4 and greater, no devices will be bound
>>>    to any driver for a guest.
>> This T-Bit extension to the TAPQ subfunction is a must have. When kvm only
>> supports CEX4 and upper then this bit could also act as the indicator for
>> AP instructions available. Of course if you want to implement pure virtual
>> full simulated AP without any real AP hardware on the host this bit can't
>> be the indicator.
> It would probably make sense to group these two together. Or is there
> any advantage in supporting only a part of it?
After thinking about this a little more, I've come to the conclusion that
all of this might be moot for the following reasons:

* If STFLE.12 is not set for the linux host, then AP bus scan running on
   the host will not detect any domains with a domain number higher than 15,
   so no AP queues with a queue index higher than 15 will be available to
   bind to the vfio_ap_matrix driver. Consequently, no domain higher than
   15 can be assigned to any guest. In this case, the AP bus scan 
running on
   the guest will never detect a domain higher than 15, regardless of the
   setting of STFLE.12 for the guest.

* If STFLE.15 is not set for the linux host, then then there will be no
   CEX4, CEX5 or CEX6 queues available to bind to the vfio_ap_matrix
   driver, so no AP adapters or domains can be assigned to any KVM guest.

The bottom line is the STFLE bit settings for the linux host will control
what APs are available to the KVM guest. Since STFLE.15 controls whether
any CEX4,5 or 6 devices are even available, I think this bit can be
combined into the feature that indicates whether AP is available. As long
as AP instructions are available on the linux host, I'm not sure whether
STFLE.12 needs a feature at all.
>
>>> * STFLE.65 indicates whether AP interrupts are available. If this bit is not
>>>    set, then the AP bus will use polling instead of using interrupt handlers
>>>    to process AP events.
> So, does this indicate "adapter interrupts for AP" only? If so, we
> should keep this separate and only enable it when we have the gisa etc.
> ready.
Yes, this indicates AP interrupts only. The plan is to enable this when
GISA is available and we can implement interrupt processing.
>

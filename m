From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v4 3/7] s390: ap: associate a ap_vfio_queue and a matrix
 mdev
Date: Wed, 27 Feb 2019 11:21:32 +0100
Message-ID: <d1d19f9e-40c1-e648-fcfb-4f05c75961e9@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-4-git-send-email-pmorel@linux.ibm.com>
 <20190227103211.5e4d63b2.cohuck@redhat.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190227103211.5e4d63b2.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 27/02/2019 10:32, Cornelia Huck wrote:
> On Fri, 22 Feb 2019 16:29:56 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> We need to associate the ap_vfio_queue, which will hold the
>> per queue information for interrupt with a matrix mediated device
>> which hold the configuration and the way to the CRYCB.
>>
>> Let's do this when assigning a APID or a APQI to the mediated device
>> and clear the relation when unassigning.
>>
>> Queuing the devices on a list of free devices and testing the
>> matrix_mdev pointer to the associated matrix allow us to know
>> if the queue is associated to the matrix device and associated
>> or not to a mediated device.
>>
>> When resetting an AP queue we must wait until there are no more
>> messages in the message queue before considering the queue is really
>> in a clean state.
>>
>> Let's do it and wait until the status response code indicate the
>> queue is empty after issuing a PAPQ/ZAPQ instruction.
> 
> I'm a bit confused about the context where that list moving etc. is
> supposed to take place.
> 
> When are we assigning/deassigning? Is there even supposed to be any
> activity that we need to zap on the queues?
> 
> Do we need any serialization/locking on the lists?

Did I really forget this!?

Yes, thanks.

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

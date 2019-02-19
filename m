From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v3 8/9] s390: ap: Cleanup on removing the AP device
Date: Tue, 19 Feb 2019 20:41:32 +0100
Message-ID: <263d3aa9-700e-ad6e-0dfa-69190611d9c0@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-9-git-send-email-pmorel@linux.ibm.com>
 <e5c18c62-97bd-95d7-1fa4-8b149bd62e6d@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e5c18c62-97bd-95d7-1fa4-8b149bd62e6d@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 16/02/2019 00:36, Tony Krowiak wrote:
> On 2/14/19 8:51 AM, Pierre Morel wrote:
>> When the device is remove, we must make sure to
>> clear the interruption and reset the AP device.
>>
...snip...

>> @@ -74,6 +159,13 @@ static void vfio_ap_queue_dev_remove(struct 
>> ap_device *apdev)
>>       struct vfio_ap_queue *q;
>>       q = dev_get_drvdata(&apdev->device);
>> +    if (!q)
>> +        return;
>> +
>> +    vfio_ap_update_crycb(q);
> 
> The root user is warned in the Limitations section of the vfio-ap.txt
> doc delivered with the AP pass-through support warns that the
> administrator (i.e., root user) should ensure that AP devices are not
> removed without taking proper care to ensure they are not in use by a
> guest. I am currently working on a patch set to handle this, so this
> may simply get ripped out when those patches are integrated. That may
> very well be simultaneously with this patch series as I plan on posting
> those soon.
> 
> If this call is to remain, then you ought to update the vfio-ap.txt
> document to let users know that when queues are unbound, the guests
> will lose access to them unbeknown to the admin of the guest.

I do not see where is the problem, the admin should still take care the 
APQN are not in use by the guest when he does an unbind.

This just makes sure it is not used anymore by the guest when the admin 
rebound it to the host or another guest.

> 
>> +    vfio_ap_zapq(q);
> 
> One last thing. I've explained before that prior to the AP bus
> invoking this remove callback, it flushes and zeroizes the
> queue. Why do you insist it needs to be done again in the remove
> callback?

The problem is that the AP_BUS is not aware from the CRYCB and let the 
guest play with the queue.

The sequence an be like:

-> AP_BUS remove RESET the queue and zeroes with ZAPQ
-> AP_BUS call remove from driver
	- the APQN still belong to the guest !
		-> the guest issue a NQAP
===> We need to take the queue away from the guest
===> and we need to RESET the queue with ZAPQ and wait
      until no more message is in the queue
-> driver remove ends


Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

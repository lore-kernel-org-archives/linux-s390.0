From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v6 21/21] s390: doc: detailed specifications for AP
 virtualization
Date: Mon, 9 Jul 2018 11:02:48 +0200
Message-ID: <9e84e47e-1022-0b87-7567-24b562086abb@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <f3bba295-f854-fc9e-c4eb-47846178df12@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f3bba295-f854-fc9e-c4eb-47846178df12@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 03/07/2018 10:10, Harald Freudenberger wrote:
> On 29.06.2018 23:11, Tony Krowiak wrote:
...snip...
> +The process for reserving an AP queue for use by a KVM guest is:
> +
> +* The vfio-ap driver during its initialization will perform the following:
> +  * Create the 'vfio_ap' root device - /sys/devices/vfio_ap
> +  * Create the 'matrix' device in the 'vfio_ap' root
> +  * Register the matrix device with the device core
> +* Register with the ap_bus for AP queue devices of type 10 devices (CEX4 and
> +  newer) and to provide the vfio_ap driver's probe and remove callback
> +  interfaces. The reason why older devices are not supported is because there
> +  are no systems available on which to test.
> This is simple not true. The reason is this is a design decision. The older
> cards are simple somewhat more complicated and we don't want to
> add even more complexity to the ap virtualization implementation.
> We also said several times that APXA is a requirement not a feature.

I understand your point of view as maintainer of the cryptographic driver
but I do not see the point concerning virtualization.
The SIE allows to work fine without APXA.
Is there any reason to add a restrictions here?

If there is a good reason then  the problem should be treated when 
detecting the presence
of APXA. AFAIR we do not do this.

>> +* The admin unbinds queue cc.qqqq from the cex4queue device driver. This results
>> +  in the ap_bus calling the the device driver's remove interface which
>> +  unbinds the cc.qqqq queue device from the driver.
>> +* The admin binds the cc.qqqq queue to the vfio_ap device driver. This results
>> +  in the ap_bus calling the device vfio_ap driver's probe interface to bind
>> +  queue cc.qqqq to the driver. The vfio_ap device driver will store the APQN for
>> +  the queue in the matrix device
...snip...
>> +
>> +Guest2
>> +------
>> +CARD.DOMAIN TYPE  MODE
>> +------------------------------
>> +05          CEX5A Accelerator
>> +05.0047     CEX5A Accelerator
>> +05.00ff     CEX5A Accelerator
> Btw: this is an excellent example about thinking beyond the current design.
> We don't want to dedicate Accelerators to guests. Accelerators should be
> shared, CCA and EP11 Coprocessors should be dedicated. So maybe
> change the example to use EP11 and CCA Coprocessors .... and think
> about how shared Accelerators could be handled.

Shouldn't this problematic be let to the administrator?
Using the SIE for virtualization is independent of the kind of
card.
Why, again, see above, should we take the type of card into account
at this level?

>> +
>> +These are the steps:
...snip...

>> +   echo 1 > remove
>> +
>> +   This will remove all of the mdev matrix device's sysfs structures. To
>> +   recreate and reconfigure the mdev matrix device, all of the steps starting
>> +   with step 4 will have to be performed again.
>> +
>> +   It is not necessary to remove an mdev matrix device, but one may want to
>> +   remove it if no guest will use it during the lifetime of the linux host. If
>> +   the mdev matrix device is removed, one may want to unbind the AP queues the
>> +   guest was using from the vfio_ap device driver and bind them back to the
>> +   default driver. Alternatively, the AP queues can be configured for another
> Please note: you can't just 'bind them back to the default driver'. You need
> to unbind and then call dev_reprobe() which triggers the default way of
> assigning a driver to a device and give the ap bus a chance to handle this.

Are you saying that the administrator can not unbind a AP device
and bind it to another AP driver?
I am surprised. can you explain?

Best regards,

Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

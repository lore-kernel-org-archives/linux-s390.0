From: Harald Freudenberger <freude@linux.ibm.com>
Subject: Re: [PATCH v6 21/21] s390: doc: detailed specifications for AP
 virtualization
Date: Wed, 4 Jul 2018 10:31:50 +0200
Message-ID: <9e0c70b5-b8bf-e64b-19bc-c08765ccf397@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <49b11ac2-2230-ad74-1583-c6a57f8b31e3@linux.ibm.com>
 <6a330cae-2fe2-54df-edce-c3360117cf3c@linux.ibm.com>
 <89df60be-63d6-3ed9-4724-321e5b55d50d@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <89df60be-63d6-3ed9-4724-321e5b55d50d@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 03.07.2018 16:56, Tony Krowiak wrote:
> On 07/03/2018 03:46 AM, Harald Freudenberger wrote:
>> On 02.07.2018 18:28, Halil Pasic wrote:
>>>
>>> On 06/29/2018 11:11 PM, Tony Krowiak wrote:
>>>> This patch provides documentation describing the AP architecture and
>>>> design concepts behind the virtualization of AP devices. It also
>>>> includes an example of how to configure AP devices for exclusive
>>>> use of KVM guests.
>>>>
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>> ---
>>> [..]
>>>> +
>>>> +Reserve APQNs for exclusive use of KVM guests
>>>> +---------------------------------------------
>>>> +The following block diagram illustrates the mechanism by which APQNs are
>>>> +reserved:
>>>> +
>>>> +                              +------------------+
>>>> +                 remove       |                  |   unbind
>>>> +         +------------------->+ cex4queue driver +<-----------+
>>>> +         |                    |                  |            |
>>>> +         |                    +------------------+            |
>>>> +         |                                                    |
>>>> +         |                                                    |
>>>> +         |                                                    |
>>>> ++--------+---------+ register +------------------+      +-----+------+
>>>> +|                  +<---------+                  | bind |            |
>>>> +|      ap_bus      |          |  vfio_ap driver  +<-----+    admin   |
>>>> +|                  +--------->+                  |      |            |
>>>> ++------------------+  probe   +---+--------+-----+      +------------+
>>>> +                                  |        |
>>>> +                           create |        | store APQN
>>>> +                                  |        |
>>>> +                                  v        v
>>>> +                              +---+--------+-----+
>>>> +                              |                  |
>>>> +                              |  matrix device   |
>>>> +                              |                  |
>>>> +                              +------------------+
>>>> +
>>>> +The process for reserving an AP queue for use by a KVM guest is:
>>>> +
>>>> +* The vfio-ap driver during its initialization will perform the following:
>>>> +  * Create the 'vfio_ap' root device - /sys/devices/vfio_ap
>>>> +  * Create the 'matrix' device in the 'vfio_ap' root
>>>> +  * Register the matrix device with the device core
>>>> +* Register with the ap_bus for AP queue devices of type 10 devices (CEX4 and
>>>> +  newer) and to provide the vfio_ap driver's probe and remove callback
>>>> +  interfaces. The reason why older devices are not supported is because there
>>>> +  are no systems available on which to test.
>>>> +* The admin unbinds queue cc.qqqq from the cex4queue device driver. This results
>>>> +  in the ap_bus calling the the device driver's remove interface which
>>>> +  unbinds the cc.qqqq queue device from the driver.
>>> What if the queue cc.qqqq is already in use? AFAIU unbind is almost as radical as
>>> pulling a cable. What is the proper procedure an admin should follow before doing
>>> the unbind?
>> What do you mean on this level with 'in use'? A unbind destroys the association
>> between device and driver. There is no awareness of 'in use' or 'not in use' on this
>> level. This is a hard unbind.
>
> According to my reading of the code, the remove callback for the AP queue drivers
> flushes the queue before it is disconnected from the driver. Do you concur Harald?
Yes, you are right. I checked this. The unbind triggers a zcrypt_cex4_queue_remove()
which calls ap_queue_remove() which calls ap_flush_queue().
The ap_flush_queue() function does:
- for all requests which are queued these are 'received' with -EAGAIN and thus
  the zcrypt api tries to re-schedule these requests on another apqn.
- for all requests which have been sent to the ap but there is no answer yet
  these are 'reveived' with -EAGAIN and the zcrypt_api tries to re-schedule these
  requests. [Well, this may in the end lead to some requests sent double...]
Looks like the unbind is handled in a smooth way :-)
>
>>>> +* The admin binds the cc.qqqq queue to the vfio_ap device driver. This results
>>>> +  in the ap_bus calling the device vfio_ap driver's probe interface to bind
>>>> +  queue cc.qqqq to the driver. The vfio_ap device driver will store the APQN for
>>>> +  the queue in the matrix device
>>>> +
>>> [..]
>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe linux-s390" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>

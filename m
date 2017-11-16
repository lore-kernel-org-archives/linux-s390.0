From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: Re: [RFC 00/19] KVM: s390/crypto/vfio: guest dedicated crypto
 adapters
Date: Thu, 16 Nov 2017 17:06:58 +0100
Message-ID: <8a492b07-3d3b-f4cf-e139-7de345ea8188@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <5baf5f90-6cac-3c09-7b66-1bc8b30b8093@linux.vnet.ibm.com>
 <20171114145722.4ab850a5.cohuck@redhat.com>
 <fcfd6a27-662b-9a30-8bad-adaac4cf0ce1@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fcfd6a27-662b-9a30-8bad-adaac4cf0ce1@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 16/11/2017 16:23, Tony Krowiak wrote:
> On 11/14/2017 08:57 AM, Cornelia Huck wrote:
>> On Tue, 31 Oct 2017 15:39:09 -0400
>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>
>>> On 10/13/2017 01:38 PM, Tony Krowiak wrote:
>>> Ping
>>>> Tony Krowiak (19):
>>>>     KVM: s390: SIE considerations for AP Queue virtualization
>>>>     KVM: s390: refactor crypto initialization
>>>>     s390/zcrypt: new AP matrix bus
>>>>     s390/zcrypt: create an AP matrix device on the AP matrix bus
>>>>     s390/zcrypt: base implementation of AP matrix device driver
>>>>     s390/zcrypt: register matrix device with VFIO mediated device
>>>>       framework
>>>>     KVM: s390: introduce AP matrix configuration interface
>>>>     s390/zcrypt: support for assigning adapters to matrix mdev
>>>>     s390/zcrypt: validate adapter assignment
>>>>     s390/zcrypt: sysfs interfaces supporting AP domain assignment
>>>>     s390/zcrypt: validate domain assignment
>>>>     s390/zcrypt: sysfs support for control domain assignment
>>>>     s390/zcrypt: validate control domain assignment
>>>>     KVM: s390: Connect the AP mediated matrix device to KVM
>>>>     s390/zcrypt: introduce ioctl access to VFIO AP Matrix driver
>>>>     KVM: s390: interface to configure KVM guest's AP matrix
>>>>     KVM: s390: validate input to AP matrix config interface
>>>>     KVM: s390: New ioctl to configure KVM guest's AP matrix
>>>>     s390/facilities: enable AP facilities needed by guest
>> I think the approach is fine, and the code also looks fine for the most
>> part. Some comments:
>>
>> - various patches can be squashed together to give a better
>>    understanding at a glance
> Which patches would you squash?
>> - this needs documentation (as I already said)
> My plan is to take the cover letter patch and incorporate that into 
> documentation,
> then replace the cover letter patch with a more concise summary.
>> - some of the driver/device modelling feels a bit awkward (commented in
>>    patches) -- I'm not sure that my proposal is better, but I think we
>>    should make sure the interdependencies are modeled correctly
> I am responding to each patch review individually.

I think that instead of responding to each patch individually we should 
have a discussion on the design because I think a lot could change and 
discussing about each patch as they may be completely redesigned for the 
next version may not be very useful.

So I totally agree with Conny on that we should stabilize the 
bus/device/driver modeling.

I think it would be here a good place to start the discussion on things 
like we started to discuss, Harald and I, off-line:
- why a matrix bus, in which case we can avoid it
- which kind of devices we need
- how to handle the repartition of queues on boot, reset and hotplug
- interaction with the host drivers
- validation of the matrix for guests and host views

or even features we need to add like
- interruptions
- PAPQ/TAPQ-t and APQI interception
- virtualization of the AP
- CPU model and KVM capabilities

In my understanding these points must be cleared before we really start 
to discuss the details of the implementation.

Best regards,

Pierre

>> - some minor stuff
>>
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC 00/19] KVM: s390/crypto/vfio: guest dedicated crypto
 adapters
Date: Mon, 16 Oct 2017 12:06:18 +0200
Message-ID: <a079c437-f2e1-9774-416d-c22f3ad3f60a@de.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20171016112755.4d6b3ea1@mschwideX1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171016112755.4d6b3ea1@mschwideX1>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, heiko.carstens@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 10/16/2017 11:27 AM, Martin Schwidefsky wrote:
> On Fri, 13 Oct 2017 13:38:45 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> 
>> Tony Krowiak (19):
>>   KVM: s390: SIE considerations for AP Queue virtualization
>>   KVM: s390: refactor crypto initialization
>>   s390/zcrypt: new AP matrix bus
>>   s390/zcrypt: create an AP matrix device on the AP matrix bus
>>   s390/zcrypt: base implementation of AP matrix device driver
>>   s390/zcrypt: register matrix device with VFIO mediated device
>>     framework
>>   KVM: s390: introduce AP matrix configuration interface
>>   s390/zcrypt: support for assigning adapters to matrix mdev
>>   s390/zcrypt: validate adapter assignment
>>   s390/zcrypt: sysfs interfaces supporting AP domain assignment
>>   s390/zcrypt: validate domain assignment
>>   s390/zcrypt: sysfs support for control domain assignment
>>   s390/zcrypt: validate control domain assignment
>>   KVM: s390: Connect the AP mediated matrix device to KVM
>>   s390/zcrypt: introduce ioctl access to VFIO AP Matrix driver
>>   KVM: s390: interface to configure KVM guest's AP matrix
>>   KVM: s390: validate input to AP matrix config interface
>>   KVM: s390: New ioctl to configure KVM guest's AP matrix
>>   s390/facilities: enable AP facilities needed by guest
> 
> Overall I am quite happy with the patches, only minor things I would
> like to see improved. We have to agree how we want to approach the
> upstream process between my s390/linux tree and the s390/kvm tree.
> Probably a tip branch again for the both tress to pull from.

Thanks a lot for the review of the zcrypt patches. Its very good to know
that these base changes are ok with you.

Regarding merging: yes, this should be a tip branch then. Before that, we
have to finalize the interface and design to make sure that the changes
will work throughout the whole stack (kvm/vfio/qemu/libvirt).

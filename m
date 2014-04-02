From: Alexander Graf <agraf@suse.com>
Subject: Re: [PATCH/RFC] s390: Provide a configuration and
	control device
Date: Wed, 02 Apr 2014 10:39:48 +0200
Message-ID: <533BCCD4.3060601@suse.com>
References: <1396363663-50450-1-git-send-email-borntraeger@de.ibm.com>
	<533BCAE7.4000000@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <533BCAE7.4000000@de.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 02.04.14 10:31, Christian Borntraeger wrote:
> On 01/04/14 16:47, Christian Borntraeger wrote:
>> We want to configure several things in KVM that go beyond what
>> ENABLE_CAP (we need payload) or ONE_REG (we need it for the VM
>> and we need to do more complex actions) can provide. Instead of
>> adding several s390 specific ioctls, lets provide a configuration
>> and control device that encapsulates different commands into
>> groups of the same area (MEMORY, CPU, ..)
>>
>> We also provide an initial nameless base group, with a simple first
>> user to set the guest name. We need that name in the kernel for
>> the emulation of STSI (which provides the guest name to the guest)
>> but we need to implement the emulation in supervisor mode, as it
>> also provides the underlying levels of hipervisors.
>>
>> Currently we have the following GROUPS and ATTRs pending, which
>> configure some memory management related function or allow to set
>> the guest facilities, cpuids etc:
>>
>> #define KVM_DEV_CONFIG_GROUP            0
>> #define KVM_DEV_CONFIG_NAME             0
>>
>> #define KVM_DEV_CONFIG_GROUP_MEM        1
>> #define KVM_DEV_CONFIG_MEM_ENABLE_CMMA  0
>> #define KVM_DEV_CONFIG_MEM_CLR_CMMA     1
>> #define KVM_DEV_CONFIG_MEM_CLR_PAGES    2
>>
>> #define KVM_DEV_CONFIG_GROUP_CPU        2
>> #define KVM_DEV_CONFIG_CPU_TYPE         0
>> #define KVM_DEV_CONFIG_CPU_FAC          1
>> #define KVM_DEV_CONFIG_CPU_FAC_MASK     2
>> #define KVM_DEV_CONFIG_CPU_IBC          3
>> #define KVM_DEV_CONFIG_CPU_IBC_RANGE    4
>>
>>
>>
>> In addition other groups like
>> #define KVM_DEV_CONFIG_GROUP_CRYPTO
>> are under consideration to configure crypto acceleration.
>>
>> Unless there is a major concern, I will add this to the next
>> s390 PULL requests for KVM.
>>
>> Christian
>>
> @Alex,
>
> regarding STSI, what about the following:
>
> The kernel will fill in every part of STSI as of now, but we will provide a CAP that qemu can enable which then tells the kernel to pass control to QEMU after it has filled in the data. QEMU can then do nothing (e.g. for stsi 111) or change
> the information (e.g. for 322) and return to kernel. That would
> a: cover the name aspect
> b: will work with future enhancements for levels 1 and 2 since the kernel will still pass that through to the HW or LPAR
> c: allows QEMU to override everything if necessary

I like that one, yes. Does the STSI payload fit into our exit payload union?

> @Paolo, Alex,
>
> I have several changes pending that will require new ioctls. I planned to use the config device to avoid creating new ioctls. Some option:
> a: define new ioctls for these things (might end up with ~10 new ioctls)
> b: allow GET_ATTR/SET_ATTR on the vm fd. We would define those as architecture specific attributes of the VM.
> c: use a config device an anchor for GET_ATTR/SET_ATTR
> d: any better idea
>
> This question is really a bike shed color discussion (which interface for specific thing between qemu/kvm is considered best), but it will be ABI. Paolo, do you have any preference?
> I dont care about which solution we choose, but I obviously need a decision to rework pending patches.

I think it semantically makes a lot of sense to treat the VM fd as an 
"implements device" class :). So allowing GET_ATTR/SET_ATTR on the VM fd 
makes most sense to me.

As for all the individual bits you need to set, I'd like to make sure we 
talk about them on a case-by-case basis. As you've seen with STSI, other 
solutions might be a better fit.


Alex

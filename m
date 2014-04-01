From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC] KVM: s390: Add S390 configuration and control kvm
 device
Date: Tue, 01 Apr 2014 22:08:20 +0200
Message-ID: <533B1CB4.6020600@de.ibm.com>
References: <1396363663-50450-1-git-send-email-borntraeger@de.ibm.com> <1396363663-50450-2-git-send-email-borntraeger@de.ibm.com> <533AD42D.8060504@suse.de> <533AD593.5020804@de.ibm.com> <533AD752.5010605@suse.de> <533B1130.9030207@de.ibm.com> <EBA350B1-9771-48B7-963F-16A00B27FD29@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <EBA350B1-9771-48B7-963F-16A00B27FD29@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 01/04/14 21:36, Alexander Graf wrote:
[...]
>>> Speaking of which, why don't we just forward STSI to user space with an ENABLE_CAP and handle all of this there? It's not performance critical at all, right?
>>
>> No, performance is not critical.
>> The thing is, that we definitely need the kernel to handle parts of STSI, as we have to provide information from the upper hipervisor (LPAR or zVM). This information is only available in kernel space. So in essence we could only forward a small subset of STSI, namely stsi3_2_2. But we still have to call stsi_3_2_2 in the kernel,
>> as 3_2_2 does contain the list of hipervisors underneath us (KVM under z/VM). 
>>
>> So then only thing that we could do is to forward STSI_3_2_2 to qemu when a capability is set and after the kernel has filled in the upper layers. 
>> QEMU then has to modify the page that the kernel touched and go back. Would work, but needs a capability and preferably an own exit. An new ioctl or
>> a subcode of an ioctl (attr/group whatever) seems easier.
> 
> I would consider these 2 orthogonal bits of information. User space wants to get information about its underlying hypervisors regardless of KVM, no? So we should have some interface to bubble STSI information of the current system to user space either way.

There is /proc/sysinfo and it provides most (but not all) of the STSI information. But we dont want to go that path, really. Providing STSI as
binary blob is also complex and error-prone.
Think about it again: Instead of having a small qemu->kernel interface for specific subsets of stsi, you suggest a kernel->qemu interface
for the complete set of STSI, so that qemu can then emulate it? (We talk about 20 pages in the principles of operation). T
 
> QEMU could use that and add a few bits of its own. That way we could handle all of STSI in QEMU and get out of the business of defining complicated interfaces.

This also misses my main point: The name is just the first user. I want to have some interface that allows me to do other things:
enable CMMA, reset the CMMA memory usage state on reset, zap the page tables on clear reset, set the cpu facilities (some parts need to be in kernel so that we can block specific operations), enable s390 specific settings, whatever. 

The usual approach was create new KVM ioctls, each for one feature + capability. This sounded like overkill.
So please dont focus on stsi, I need some interface that I can use for other pending patches. And if that interface is generic enough, we might also use that for name (or not depending on the stsi discussion). I am not married to the device idea, anything that works out fine is ok with me.

>>>>> I think VM configuration is common enough to just make this a separate interface.
>>>> So you propose to define a new base ioctl (e.g. VM_REG) on the vm fd, instead?
>>>> Seems like an easy enough change. Would you reuse the kvm_attr structure for that?
>>>
>>> Yeah, reuse whatever we can. Basically just remove the device boilerplate - I don't think it's impressively useful for a non-device.
>>
>> See above, name is just a simple first user.  
>> The thing is, that we have to have the ioctl either define a proper namespace (unique groups attrs) or to make it s390 specific. The device approach does help us here. 
> 
> If you like the device approach, make sure to create it on VM creation and only implement a specific ioctl to fetch its fd. We don't create the configuration information pseudo device after VM creation - it's always there :).
> 
>> I personally dont mind which way to go, as long as Paolo is fine with the approach, and nobody complains about the functions being non-QOM.
> 
> I think the most obvious and straight forward way would be to deal with all of STSI in user space. Make it a separate exit type similar to hypercalls and don't worry about QOM'ification of anything. This thing is on the same level as CPUID really - just VM wide :).

For 3_2_2 this might be possible solution, but not for the other codes. But as I said, the name is not my main problem here.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] s390/vfio-ap: Clean up vfio_ap resources when KVM pointer
 invalidated
References: <20201202234101.32169-1-akrowiak@linux.ibm.com>
 <20201203185514.54060568.pasic@linux.ibm.com>
 <a8a90aed-97df-6f10-85c2-8e18dba8f085@linux.ibm.com>
 <20201204200502.1c34ae58.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <cf2c6632-bcdc-fb93-471b-bfd834d87902@linux.ibm.com>
Date: Fri, 4 Dec 2020 14:46:30 -0500
MIME-Version: 1.0
In-Reply-To: <20201204200502.1c34ae58.pasic@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com, alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com, Janosch Frank <frankja@linux.ibm.com>



On 12/4/20 2:05 PM, Halil Pasic wrote:
> On Fri, 4 Dec 2020 09:43:59 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>>>> +{
>>>> +	if (matrix_mdev->kvm) {
>>>> +		(matrix_mdev->kvm);
>>>> +		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
>>> Is a plain assignment to arch.crypto.pqap_hook apropriate, or do we need
>>> to take more care?
>>>
>>> For instance kvm_arch_crypto_set_masks() takes kvm->lock before poking
>>> kvm->arch.crypto.crycb.
>> I do not think so. The CRYCB is used by KVM to provide crypto resources
>> to the guest so it makes sense to protect it from changes to it while
>> passing
>> the AP devices through to the guest. The hook is used only when an AQIC
>> executed on the guest is intercepted by KVM. If the notifier
>> is being invoked to notify vfio_ap that KVM has been set to NULL, this means
>> the guest is gone in which case there will be no AP instructions to
>> intercept.
> If the update to pqap_hook isn't observed as atomic we still have a
> problem. With torn writes or reads we would try to use a corrupt function
> pointer. While the compiler probably ain't likely to generate silly code
> for the above assignment (multiple write instructions less then
> quadword wide), I know of nothing that would prohibit the compiler to do
> so.

I see that in the handle_pqap() function in arch/s390/kvm/priv.c
that gets called when the AQIC instruction is intercepted,
the pqap_hook is protected by locking the owner of the hook:

         if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
             return -EOPNOTSUPP;
         ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);

Maybe that is what we should do when the kvm->arch.crypto.pqap_hook
is set to NULL?

>
> I'm not certain about the scope of the kvm->lock (if it's supposed to
> protect the whole sub-tree of objects). Maybe Janosch can help us out.
> @Janosch: what do you think?
>
> Regards,
> Halil

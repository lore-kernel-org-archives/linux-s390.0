From: Halil Pasic <pasic@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 04/14] KVM: s390: device attribute to set AP
 interpretive execution
Date: Tue, 20 Mar 2018 23:48:32 +0100
Message-ID: <6c42b3e2-0f32-b84b-ea73-4e99157720d3@linux.vnet.ibm.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1521051954-25715-5-git-send-email-akrowiak@linux.vnet.ibm.com>
 <d86ad01e-1c79-c14c-b4da-09d9a31572bd@linux.vnet.ibm.com>
 <21bd029b-3500-3461-ce98-68ad3ae9b647@linux.vnet.ibm.com>
 <46a7e838-2be2-9587-6eb2-3bba95485609@linux.vnet.ibm.com>
 <5ed8017b-0168-9a50-234b-cfe9258eab72@linux.vnet.ibm.com>
 <17683324-f6e4-4328-54c1-1fce572faecd@linux.vnet.ibm.com>
 <8e10f1cb-3722-d231-2603-b7867420ac0a@linux.vnet.ibm.com>
 <5dd1bcd3-5d17-37c1-1184-7f75a1fd32bc@linux.vnet.ibm.com>
 <68e9e3ea-f99a-da88-5e56-21e38b438b4f@linux.vnet.ibm.com>
 <1347ed2e-7bdb-e455-971a-cf60899e3c19@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347ed2e-7bdb-e455-971a-cf60899e3c19@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 03/20/2018 06:58 PM, Tony Krowiak wrote:
> I spoke with Christian this morning and he made a suggestion which I think would provide the best solution here.
> This is my proposal:
> 1. Get rid of the KVM_S390_VM_CRYPTO_INTERPRET_AP device attribute and return to setting ECA.28 from the
>    mdev device open callback.
> 2. Since there may be vcpus online at the time the mdev device open is called, we must first take all running vcpus out of
>    SIE and block them. Christian suggested the kvm_s390_vcpu_block_all(struct kvm *kvm) function will do the trick. So I
>    propose introducing a function like the following to be called during mdev open:

There is one thing you missed, otherwise I'm *very* satisfied with this
proposal.

What you have missed IMHO is vcpu hottplug. So IMHO you should keep
kvm->arch.crypto.apie, and update it accordingly ...


> 
>     int kvm_ap_set_interpretive_exec(struct kvm *kvm, bool enable)
>     {
>         int i;
>         struct kvm_vcpu *vcpu;
> 
>         if (!test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_AP))
>             return -EOPNOTSUPP;
> 
>         mutex_lock(&kvm->lock);
> 
>         kvm_s390_vcpu_block_all(kvm);

... let's say here.

> 
>         kvm_for_each_vcpu(i, vcpu, kvm) {

And here you can call kvm_s390_vcpu_crypto_setup(vcpu) (the changes to
this function will be required for hotplug) if you like

>             if (enable)
>                 vcpu->arch.sie_block->eca |= ECA_APIE;
>             else
>                 vcpu->arch.sie_block->eca &= ~ECA_APIE;

or keep this stuff, it does not really matter to me.

>         }
> 
>         kvm_s390_vcpu_unblock_all(kvm);
> 
>         mutex_unlock(&kvm->lock);
> 
>         return 0;
>     }
> 
>    This interface allows us to set ECA.28 even if vcpus are running

I tend to agree. I will give it a proper review when this gets more
formal (e.g. v4 (preferably) or patches to be fixed up to this series).

Please don't forget to revisit the discussion on kvm_s390_vm_set_crypto:
if the mechanism there isn't right for ECA.28 I think you should tell
us why it's OK for the other attributes if it's OK. If it is not then
I guess you will want to do a stand alone patch for that.

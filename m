Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53414 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730622AbfJXQt3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 12:49:29 -0400
Subject: Re: [RFC 07/37] KVM: s390: protvirt: Secure memory is not mergeable
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-8-frankja@linux.ibm.com>
 <f80519a0-a8da-1a98-c450-b81dfcf2e897@redhat.com>
 <20191024183306.4c2bd289@p-imbrenda.boeblingen.de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2f166dc7-3419-4980-2b0e-9e7a1e7c475b@redhat.com>
Date: Thu, 24 Oct 2019 18:49:19 +0200
MIME-Version: 1.0
In-Reply-To: <20191024183306.4c2bd289@p-imbrenda.boeblingen.de.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24.10.19 18:33, Claudio Imbrenda wrote:
> On Thu, 24 Oct 2019 18:07:14 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 24.10.19 13:40, Janosch Frank wrote:
>>> KSM will not work on secure pages, because when the kernel reads a
>>> secure page, it will be encrypted and hence no two pages will look
>>> the same.
>>>
>>> Let's mark the guest pages as unmergeable when we transition to
>>> secure mode.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>    arch/s390/include/asm/gmap.h |  1 +
>>>    arch/s390/kvm/kvm-s390.c     |  6 ++++++
>>>    arch/s390/mm/gmap.c          | 28 ++++++++++++++++++----------
>>>    3 files changed, 25 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/arch/s390/include/asm/gmap.h
>>> b/arch/s390/include/asm/gmap.h index 6efc0b501227..eab6a2ec3599
>>> 100644 --- a/arch/s390/include/asm/gmap.h
>>> +++ b/arch/s390/include/asm/gmap.h
>>> @@ -145,4 +145,5 @@ int gmap_mprotect_notify(struct gmap *,
>>> unsigned long start,
>>>    void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long
>>> dirty_bitmap[4], unsigned long gaddr, unsigned long vmaddr);
>>> +int gmap_mark_unmergeable(void);
>>>    #endif /* _ASM_S390_GMAP_H */
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index 924132d92782..d1ba12f857e7 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -2176,6 +2176,12 @@ static int kvm_s390_handle_pv(struct kvm
>>> *kvm, struct kvm_pv_cmd *cmd) if (r)
>>>    =09=09=09break;
>>>   =20
>>> +=09=09down_write(&current->mm->mmap_sem);
>>> +=09=09r =3D gmap_mark_unmergeable();
>>> +=09=09up_write(&current->mm->mmap_sem);
>>> +=09=09if (r)
>>> +=09=09=09break;
>>> +
>>>    =09=09mutex_lock(&kvm->lock);
>>>    =09=09kvm_s390_vcpu_block_all(kvm);
>>>    =09=09/* FMT 4 SIE needs esca */
>>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>>> index edcdca97e85e..bf365a09f900 100644
>>> --- a/arch/s390/mm/gmap.c
>>> +++ b/arch/s390/mm/gmap.c
>>> @@ -2548,6 +2548,23 @@ int s390_enable_sie(void)
>>>    }
>>>    EXPORT_SYMBOL_GPL(s390_enable_sie);
>>>   =20
>>> +int gmap_mark_unmergeable(void)
>>> +{
>>> +=09struct mm_struct *mm =3D current->mm;
>>> +=09struct vm_area_struct *vma;
>>> +
>>> +=09for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
>>> +=09=09if (ksm_madvise(vma, vma->vm_start, vma->vm_end,
>>> +=09=09=09=09MADV_UNMERGEABLE, &vma->vm_flags))
>>> {
>>> +=09=09=09mm->context.uses_skeys =3D 0;
>>
>> That skey setting does not make too much sense when coming via
>> kvm_s390_handle_pv(). handle that in the caller?
>=20
> protected guests run keyless; any attempt to use keys in the guest will
> result in an exception in the guest.

still, this is the recovery path for the "mm->context.uses_skeys =3D 1;"=20
in enable_skey_walk_ops() and confuses reader (like me).


--=20

Thanks,

David / dhildenb

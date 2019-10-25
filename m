Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405567AbfJYIUK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Oct 2019 04:20:10 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9P89EJl011830
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 04:20:08 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vuvsp99fj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 04:20:08 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 25 Oct 2019 09:20:06 +0100
Subject: Re: [RFC 07/37] KVM: s390: protvirt: Secure memory is not mergeable
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-8-frankja@linux.ibm.com>
 <f80519a0-a8da-1a98-c450-b81dfcf2e897@redhat.com>
 <3f7cc352-56d8-f0c7-3cb2-7278b8262035@linux.ibm.com>
 <af9b9d01-4837-a48f-c9ce-2b20d9e8cb96@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 25 Oct 2019 10:20:00 +0200
MIME-Version: 1.0
In-Reply-To: <af9b9d01-4837-a48f-c9ce-2b20d9e8cb96@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xKwOmXc5K3nk3GsGyDXduJKsFyFeUlPHy"
Message-Id: <1552c0d9-8ef5-8afa-2936-6851a205e340@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xKwOmXc5K3nk3GsGyDXduJKsFyFeUlPHy
Content-Type: multipart/mixed; boundary="dFQWTvqFpCjh1X7wtjolDityqBt4rVP5x"

--dFQWTvqFpCjh1X7wtjolDityqBt4rVP5x
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/25/19 10:04 AM, David Hildenbrand wrote:
> On 25.10.19 09:18, Janosch Frank wrote:
>> On 10/24/19 6:07 PM, David Hildenbrand wrote:
>>> On 24.10.19 13:40, Janosch Frank wrote:
>>>> KSM will not work on secure pages, because when the kernel reads a
>>>> secure page, it will be encrypted and hence no two pages will look t=
he
>>>> same.
>>>>
>>>> Let's mark the guest pages as unmergeable when we transition to secu=
re
>>>> mode.
>>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> ---
>>>>    arch/s390/include/asm/gmap.h |  1 +
>>>>    arch/s390/kvm/kvm-s390.c     |  6 ++++++
>>>>    arch/s390/mm/gmap.c          | 28 ++++++++++++++++++----------
>>>>    3 files changed, 25 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gm=
ap.h
>>>> index 6efc0b501227..eab6a2ec3599 100644
>>>> --- a/arch/s390/include/asm/gmap.h
>>>> +++ b/arch/s390/include/asm/gmap.h
>>>> @@ -145,4 +145,5 @@ int gmap_mprotect_notify(struct gmap *, unsigned=
 long start,
>>>>   =20
>>>>    void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long dir=
ty_bitmap[4],
>>>>    			     unsigned long gaddr, unsigned long vmaddr);
>>>> +int gmap_mark_unmergeable(void);
>>>>    #endif /* _ASM_S390_GMAP_H */
>>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>>> index 924132d92782..d1ba12f857e7 100644
>>>> --- a/arch/s390/kvm/kvm-s390.c
>>>> +++ b/arch/s390/kvm/kvm-s390.c
>>>> @@ -2176,6 +2176,12 @@ static int kvm_s390_handle_pv(struct kvm *kvm=
, struct kvm_pv_cmd *cmd)
>>>>    		if (r)
>>>>    			break;
>>>>   =20
>>>> +		down_write(&current->mm->mmap_sem);
>>>> +		r =3D gmap_mark_unmergeable();
>>>> +		up_write(&current->mm->mmap_sem);
>>>> +		if (r)
>>>> +			break;
>>>> +
>>>>    		mutex_lock(&kvm->lock);
>>>>    		kvm_s390_vcpu_block_all(kvm);
>>>>    		/* FMT 4 SIE needs esca */
>>>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>>>> index edcdca97e85e..bf365a09f900 100644
>>>> --- a/arch/s390/mm/gmap.c
>>>> +++ b/arch/s390/mm/gmap.c
>>>> @@ -2548,6 +2548,23 @@ int s390_enable_sie(void)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(s390_enable_sie);
>>>>   =20
>>>> +int gmap_mark_unmergeable(void)
>>>> +{
>>>> +	struct mm_struct *mm =3D current->mm;
>>>> +	struct vm_area_struct *vma;
>>>> +
>>>> +	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
>>>> +		if (ksm_madvise(vma, vma->vm_start, vma->vm_end,
>>>> +				MADV_UNMERGEABLE, &vma->vm_flags)) {
>>>> +			mm->context.uses_skeys =3D 0;
>>>
>>> That skey setting does not make too much sense when coming via
>>> kvm_s390_handle_pv(). handle that in the caller?
>>
>> Hmm, I think the name of that variable is just plain wrong.
>> It should be "can_use_skeys" or "uses_unmergeable" (which would fit
>> better into the mm context anyway) and then we could add a
>> kvm->arch.uses_skeys to tell that we actually used them for migration
>> checks, etc..
>>
>> I had long discussions with Martin over these variable names a long ti=
me
>> ago..
>=20
> uses_skeys is set during s390_enable_skey(). that is used when we
>=20
> a) Call an skey instruction
> b) Migrate skeys
>=20
> So it should match "uses" or what am I missing?
>=20
> If you look at the users of "mm_uses_skeys(mm)" I think=20
> "uses_unmergeable" would actually be misleading. (e.g.,=20
> pgste_set_key()). it really means "somebody used skeys". The unmergable=
=20
> is just a required side effect.

Hmm, we couldn't check struct kvm from pgtable.c anyway.
Oh well, I still don't like it very much but your arguments are better
:-) Let's fix this.


--dFQWTvqFpCjh1X7wtjolDityqBt4rVP5x--

--xKwOmXc5K3nk3GsGyDXduJKsFyFeUlPHy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl2ysDAACgkQ41TmuOI4
ufgZOBAAs35/ljwhfxczO5mochYkquwPXsE457YhJw6b2PM5DItI2YeBJ0TZ+9wj
tr14D37xkAViLAOlqZkPzy2XoupRbA6dRADM5ILF6qgmPQS5nnkOZu4Xp9wIWoXW
T/MIRQnJrVdkuSGe0FGLPOcmzzykJzJ/tPlf0awksiB3U8ECj3vXVTqQqA+ekMJv
Ltg22XP8UljbFzHJ/IiNRqR0bBZ8u35DeLeEe5Fkn/QtXgQ+J5IhHatdyJQFEv14
tvVrXvwOOVT9z+sp0vso/S78O+G7NG0O16Hs+yZZ30NkmA0zJTw/jWPX1z8e6BaK
TIsInY2DRPg6bRt3c3HSlyP6uTZVscIqK+mrFNEbBeJoEFTuEAm84AlPRSutz2f9
Obz6zwtg1dJihIEN4MWADQKxeLJ0a1MzUmklbqJ7gpDoyvQpEVPw+Efc3aTPdCkl
/FXfmmNpaJ1zNhr1Qa+GtPOehg7BYsF5JsGXNozCksBYy8VMXm5VMgRvxLp12wr+
aWIkRukuKxx3CnrMumm6JOVI2/Ee3BB2ZWZVJ1NvkHxn1jWIBee2pBrjqu80lRAw
9G1kYWedDpkFR4mf/ojb9qV8j53SYFUl21Q3X8Gidm+jROygB5lfvE2jw8LPqGiA
wxYBB7lKLqNiGWUDCSf7bjg92Jyu+YuU344CR/UqiphEkWsFjww=
=vvWZ
-----END PGP SIGNATURE-----

--xKwOmXc5K3nk3GsGyDXduJKsFyFeUlPHy--

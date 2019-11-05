Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27066 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388269AbfKEMjj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Nov 2019 07:39:39 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA5CX11P112004
        for <linux-s390@vger.kernel.org>; Tue, 5 Nov 2019 07:39:38 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w396789sr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 05 Nov 2019 07:39:37 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 5 Nov 2019 12:39:36 -0000
Subject: Re: [RFC 19/37] KVM: s390: protvirt: Add new gprs location handling
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-20-frankja@linux.ibm.com>
 <2eba24a5-063d-1e93-acf0-1153963facfe@redhat.com>
 <8f7a9da4-2a49-9e3f-573e-199cd71fc99c@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 5 Nov 2019 13:39:30 +0100
MIME-Version: 1.0
In-Reply-To: <8f7a9da4-2a49-9e3f-573e-199cd71fc99c@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hcmLWLw0OJ1SOHZ7zAIRX9v51q3HszbfR"
Message-Id: <1588a5e9-9bd9-428d-5b05-114a9307ceee@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hcmLWLw0OJ1SOHZ7zAIRX9v51q3HszbfR
Content-Type: multipart/mixed; boundary="3bT7PFHHHEOBxLYESU9ZvcDOwd6HY0uqo"

--3bT7PFHHHEOBxLYESU9ZvcDOwd6HY0uqo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/5/19 1:01 PM, Christian Borntraeger wrote:
>=20
>=20
> On 04.11.19 12:25, David Hildenbrand wrote:
>> On 24.10.19 13:40, Janosch Frank wrote:
>>> Guest registers for protected guests are stored at offset 0x380.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>> =C2=A0 arch/s390/include/asm/kvm_host.h |=C2=A0 4 +++-
>>> =C2=A0 arch/s390/kvm/kvm-s390.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 11 +++++++++++
>>> =C2=A0 2 files changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm=
/kvm_host.h
>>> index 0ab309b7bf4c..5deabf9734d9 100644
>>> --- a/arch/s390/include/asm/kvm_host.h
>>> +++ b/arch/s390/include/asm/kvm_host.h
>>> @@ -336,7 +336,9 @@ struct kvm_s390_itdb {
>>> =C2=A0 struct sie_page {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_s390_sie_block sie_block;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mcck_volatile_info mcck_info;=C2=
=A0=C2=A0=C2=A0 /* 0x0200 */
>>> -=C2=A0=C2=A0=C2=A0 __u8 reserved218[1000];=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* 0x0218 */
>>> +=C2=A0=C2=A0=C2=A0 __u8 reserved218[360];=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* 0x0218 */
>>> +=C2=A0=C2=A0=C2=A0 __u64 pv_grregs[16];=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* 0x380 */
>>> +=C2=A0=C2=A0=C2=A0 __u8 reserved400[512];
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_s390_itdb itdb;=C2=A0=C2=A0=
=C2=A0 /* 0x0600 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 reserved700[2304];=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x0700 */
>>> =C2=A0 };
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index 490fde080107..97d3a81e5074 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -3965,6 +3965,7 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu,=
 int exit_reason)
>>> =C2=A0 static int __vcpu_run(struct kvm_vcpu *vcpu)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int rc, exit_reason;
>>> +=C2=A0=C2=A0=C2=A0 struct sie_page *sie_page =3D (struct sie_page *)=
vcpu->arch.sie_block;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We try to hold kvm->srcu durin=
g most of vcpu_run (except when run-
>>> @@ -3986,8 +3987,18 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guest_enter_ir=
qoff();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __disable_cpu_=
timer_accounting(vcpu);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local_irq_enab=
le();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kvm_s390_pv_is_protec=
ted(vcpu->kvm)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m=
emcpy(sie_page->pv_grregs,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vcpu->run->s.regs.gprs,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(sie_page->pv_grregs));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit_reason =3D=
 sie64a(vcpu->arch.sie_block,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vcpu->run=
->s.regs.gprs);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kvm_s390_pv_is_protec=
ted(vcpu->kvm)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m=
emcpy(vcpu->run->s.regs.gprs,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sie_page->pv_grregs,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(sie_page->pv_grregs));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> sie64a will load/save gprs 0-13 from to vcpu->run->s.regs.gprs.
>>
>> I would have assume that this is not required for prot virt, because t=
he HW has direct access via the sie block?
>=20
> Yes, that is correct. The load/save in sie64a is not necessary for pv g=
uests.
>=20
>>
>>
>> 1. Would it make sense to have a specialized sie64a() (or a parameter,=
 e.g., if you pass in NULL in r3), that optimizes this loading/saving? Ev=
entually we can also optimize which host registers to save/restore then.
>=20
> Having 2 kinds of sie64a seems not very nice for just saving a small nu=
mber of cycles.
>=20
>>
>> 2. Avoid this copying here. We have to store the state to vcpu->run->s=
=2Eregs.gprs when returning to user space and restore the state when comi=
ng from user space.
>=20
> I like this proposal better than the first one and
>>
>> Also, we access the GPRS from interception handlers, there we might us=
e wrappers like
>>
>> kvm_s390_set_gprs()
>> kvm_s390_get_gprs()
>=20
> having register accessors might be useful anyway.
> But I would like to defer that to a later point in time to keep the cha=
nges in here
> minimal?
>=20
> We can add a "TODO" comment in here so that we do not forget about this=

> for a future patch. Makes sense?

I second all of that :-)




--3bT7PFHHHEOBxLYESU9ZvcDOwd6HY0uqo--

--hcmLWLw0OJ1SOHZ7zAIRX9v51q3HszbfR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3BbYIACgkQ41TmuOI4
ufiHVA/+LdE0ixT4za+SZ+2ZZXfllNTRr4+sMTvLFpWwQtnZcte/C4aG5gzIxGD6
X82XojVo6PFecGLtYM4HnLXSX221kIg9amEqo3ObZCqtJP/kf/u+rCEBUx19wOmo
z/TC9RajgyFw/B2Sso3ZLxfop0qLGZXYtqpI8s6zWFDAAr00VBLarwu2IkCtTgvH
uqIFkP+S5wO8gEkVLVDiLFZ+Mm1IeA/J4waMBKX++O0E3cwsaV40inqwvKgXtedw
yf+IF+JGQlcsGdWpOHknbAstYxmsdxRzLvASFAwbYCUT/5/GnbvEspUFwUKfOLpm
Sns75NsmtvHR4oshzLSQAVjmvyMxcDapzd3gBXh+fKjMKxO4rYo0f8dSRC99pth3
+qkfYWAFecLmmDEpSW4MIyp1MCQNkBO3K+NJmlm6FGqRMmh8YTg/yc/fwy+v6IDn
Xcyzn56XgZu/TLnbLs3js6cs0kanPjbKAY+E7Z+xWwIWo7E5uSNTr2sFxvB9qOFr
Y0IPGyZS2pwvoVpBkubzNvCYFqx6TieE32QeOIo4RNjwAnafr7DZUPkBIaQtbnDG
FJT7rnfoIFlOqcNKoyeRXo2Q86QkS1UGE955VblIUX7fslw4zARn3FSenYYs6MIG
AlZxbtAoG6G9It5URzRK/Yz7e8ic91rMoLzAcnA5tNyyeMm+Stk=
=IOR7
-----END PGP SIGNATURE-----

--hcmLWLw0OJ1SOHZ7zAIRX9v51q3HszbfR--

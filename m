Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389484AbfKEOLP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Nov 2019 09:11:15 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA5EAnIe094818
        for <linux-s390@vger.kernel.org>; Tue, 5 Nov 2019 09:11:14 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w382vqmwj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 05 Nov 2019 09:11:12 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 5 Nov 2019 14:11:10 -0000
Subject: Re: [RFC 19/37] KVM: s390: protvirt: Add new gprs location handling
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-20-frankja@linux.ibm.com>
 <2eba24a5-063d-1e93-acf0-1153963facfe@redhat.com>
 <8f7a9da4-2a49-9e3f-573e-199cd71fc99c@de.ibm.com>
 <1588a5e9-9bd9-428d-5b05-114a9307ceee@linux.ibm.com>
 <658457c3-398b-7dde-2c6d-073e4d3feac8@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 5 Nov 2019 15:11:04 +0100
MIME-Version: 1.0
In-Reply-To: <658457c3-398b-7dde-2c6d-073e4d3feac8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="j5z2E7ASSGUk6j80Smahq6WOTCS1yBPRR"
Message-Id: <6a013d0c-e056-05e4-f9e4-276a0d57b51c@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j5z2E7ASSGUk6j80Smahq6WOTCS1yBPRR
Content-Type: multipart/mixed; boundary="1mtzXQVWn4YynBMtNCDAZCukWPcXJmVVT"

--1mtzXQVWn4YynBMtNCDAZCukWPcXJmVVT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/5/19 2:55 PM, David Hildenbrand wrote:
> On 05.11.19 13:39, Janosch Frank wrote:
>> On 11/5/19 1:01 PM, Christian Borntraeger wrote:
>>>
>>>
>>> On 04.11.19 12:25, David Hildenbrand wrote:
>>>> On 24.10.19 13:40, Janosch Frank wrote:
>>>>> Guest registers for protected guests are stored at offset 0x380.
>>>>>
>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>> ---
>>>>>  =C2=A0 arch/s390/include/asm/kvm_host.h |=C2=A0 4 +++-
>>>>>  =C2=A0 arch/s390/kvm/kvm-s390.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 11 +++++++++++
>>>>>  =C2=A0 2 files changed, 14 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/a=
sm/kvm_host.h
>>>>> index 0ab309b7bf4c..5deabf9734d9 100644
>>>>> --- a/arch/s390/include/asm/kvm_host.h
>>>>> +++ b/arch/s390/include/asm/kvm_host.h
>>>>> @@ -336,7 +336,9 @@ struct kvm_s390_itdb {
>>>>>  =C2=A0 struct sie_page {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_s390_sie_block sie_block=
;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mcck_volatile_info mcck_info=
;=C2=A0=C2=A0=C2=A0 /* 0x0200 */
>>>>> -=C2=A0=C2=A0=C2=A0 __u8 reserved218[1000];=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* 0x0218 */
>>>>> +=C2=A0=C2=A0=C2=A0 __u8 reserved218[360];=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* 0x0218 */
>>>>> +=C2=A0=C2=A0=C2=A0 __u64 pv_grregs[16];=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* 0x380 */
>>>>> +=C2=A0=C2=A0=C2=A0 __u8 reserved400[512];
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_s390_itdb itdb;=C2=A0=C2=
=A0=C2=A0 /* 0x0600 */
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 reserved700[2304];=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x0700 */
>>>>>  =C2=A0 };
>>>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>>>> index 490fde080107..97d3a81e5074 100644
>>>>> --- a/arch/s390/kvm/kvm-s390.c
>>>>> +++ b/arch/s390/kvm/kvm-s390.c
>>>>> @@ -3965,6 +3965,7 @@ static int vcpu_post_run(struct kvm_vcpu *vcp=
u, int exit_reason)
>>>>>  =C2=A0 static int __vcpu_run(struct kvm_vcpu *vcpu)
>>>>>  =C2=A0 {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int rc, exit_reason;
>>>>> +=C2=A0=C2=A0=C2=A0 struct sie_page *sie_page =3D (struct sie_page =
*)vcpu->arch.sie_block;
>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We try to hold kvm->srcu du=
ring most of vcpu_run (except when run-
>>>>> @@ -3986,8 +3987,18 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)=

>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guest_enter=
_irqoff();
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __disable_c=
pu_timer_accounting(vcpu);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local_irq_e=
nable();
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kvm_s390_pv_is_prot=
ected(vcpu->kvm)) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 memcpy(sie_page->pv_grregs,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vcpu->run->s.regs.gprs,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(sie_page->pv_grregs));
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit_reason=
 =3D sie64a(vcpu->arch.sie_block,
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vcpu->=
run->s.regs.gprs);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kvm_s390_pv_is_prot=
ected(vcpu->kvm)) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 memcpy(vcpu->run->s.regs.gprs,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sie_page->pv_grregs,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(sie_page->pv_grregs));
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> sie64a will load/save gprs 0-13 from to vcpu->run->s.regs.gprs.
>>>>
>>>> I would have assume that this is not required for prot virt, because=
 the HW has direct access via the sie block?
>>>
>>> Yes, that is correct. The load/save in sie64a is not necessary for pv=
 guests.
>>>
>>>>
>>>>
>>>> 1. Would it make sense to have a specialized sie64a() (or a paramete=
r, e.g., if you pass in NULL in r3), that optimizes this loading/saving? =
Eventually we can also optimize which host registers to save/restore then=
=2E
>>>
>>> Having 2 kinds of sie64a seems not very nice for just saving a small =
number of cycles.
>>>
>>>>
>>>> 2. Avoid this copying here. We have to store the state to vcpu->run-=
>s.regs.gprs when returning to user space and restore the state when comi=
ng from user space.
>>>
>>> I like this proposal better than the first one and
>=20
> It was actually an additional proposal :)
>=20
> 1. avoids unnecessary saving/loading/saving/restoring
> 2. avoids the two memcpy
>=20
>>>>
>>>> Also, we access the GPRS from interception handlers, there we might =
use wrappers like
>>>>
>>>> kvm_s390_set_gprs()
>>>> kvm_s390_get_gprs()
>>>
>>> having register accessors might be useful anyway.
>>> But I would like to defer that to a later point in time to keep the c=
hanges in here
>>> minimal?
>>>
>>> We can add a "TODO" comment in here so that we do not forget about th=
is
>>> for a future patch. Makes sense?
>=20
> While it makes sense, I guess one could come up with a patch for 2. in =

> less than 30 minutes ... but yeah, whatever you prefer. ;)
>=20

Just to get it fully right we'd need to:
a. Synchronize registers into/from vcpu run in sync_regs/store_regs
b. Sprinkle get/set_gpr(int nr) over most of the files in arch/s390/kvm

That's your proposal?



--1mtzXQVWn4YynBMtNCDAZCukWPcXJmVVT--

--j5z2E7ASSGUk6j80Smahq6WOTCS1yBPRR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3BgvgACgkQ41TmuOI4
ufiToxAAup3uQ7MINQh2WP27IOjjt5Sey5H6hcpTU9Olm5732hmYRIlYy1jovD/T
N99PkxRo4OypLB5dd8CbmxQ+w/2VKATxR3DNIlr6m00zp8rbanttzy21T51uO6ts
pUUDOOwFlz77Arq+wiT7nZpLbtvCmVljr4dcnwx/R5BYi2Ir13pbtO4drqr0JhfY
oIAt56VTltuI49QnpbjvRAMKMDx8t4VsgHH9UqOl9NFZupM/8Er5i70ot8Rsl3PK
dMbL5gm5jS5Gv4EF4eV4pgsJ1mH6dOnY2ZOEVtj2Rxz889si40bhjgMY6ZBjRgQI
leLxgYj0bqYkGwFpw4WE9ufWKoPsD0OBwmTXNnne1Z1MUM8KgVirP6eBRXWEKc4E
7RtO5q+fgAdqg7dfSybXQjzGmQMlUopTsfG5KB7YNyUGbqiWSVfq6dgVnPXtefdg
1Z8KrDly3SoJEDLlqz3Lc+DSTKUc2MxRqab9OBugyW4JVlSUym9dmdNtHk+397U3
0BAAbSkQegZDn7OJkiUY9aPzTftApIS21jeEB9e6a3+C41vyQTvPiRDynvzEN6fR
yki6gykeV6pAcIzyWJ0Vnjvm8j4BpiyFa650sRXkcGn1ewgth5VEVqh2G/AdpQuB
zOdR71YprPfAH39XX0M67erx2nUSURqTMU6D4326FEJVpM/whEI=
=OaOc
-----END PGP SIGNATURE-----

--j5z2E7ASSGUk6j80Smahq6WOTCS1yBPRR--

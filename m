Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727190AbgA3O7H (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jan 2020 09:59:07 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UEpHCJ180168
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 09:59:07 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrj74wqa7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 09:59:06 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 30 Jan 2020 14:58:50 -0000
Subject: Re: [PATCH v8 2/4] selftests: KVM: Add fpu and one reg set/get
 library functions
References: <20200129200312.3200-1-frankja@linux.ibm.com>
 <20200129200312.3200-3-frankja@linux.ibm.com>
 <72ff36e1-9170-dfb0-4050-f398f9a467eb@redhat.com>
 <20200130135512.diyyu3wvwqlwpqlx@kamzik.brq.redhat.com>
 <9d9e0e7a-b006-98b1-6bf0-8c46006835bc@linux.ibm.com>
 <20200130143008.xy6lrnrrwer6xkdp@kamzik.brq.redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 30 Jan 2020 15:58:46 +0100
MIME-Version: 1.0
In-Reply-To: <20200130143008.xy6lrnrrwer6xkdp@kamzik.brq.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DFFeZVNJbOFSMeSfgn2mZqzUmgjMjFylz"
Message-Id: <8095f321-0d31-1285-7fa5-a751aeb6e56f@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Jones <drjones@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DFFeZVNJbOFSMeSfgn2mZqzUmgjMjFylz
Content-Type: multipart/mixed; boundary="d3X8xQHbW6SgQZrVZcGVnUpQYQrABFSHE"

--d3X8xQHbW6SgQZrVZcGVnUpQYQrABFSHE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/30/20 3:30 PM, Andrew Jones wrote:
> On Thu, Jan 30, 2020 at 03:10:55PM +0100, Janosch Frank wrote:
>> On 1/30/20 2:55 PM, Andrew Jones wrote:
>>> On Thu, Jan 30, 2020 at 11:36:21AM +0100, Thomas Huth wrote:
>>>> On 29/01/2020 21.03, Janosch Frank wrote:
>>>>> Add library access to more registers.
>>>>>
>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>> ---
>>>>>  .../testing/selftests/kvm/include/kvm_util.h  |  6 +++
>>>>>  tools/testing/selftests/kvm/lib/kvm_util.c    | 48 +++++++++++++++=
++++
>>>>>  2 files changed, 54 insertions(+)
>>>>>
>>>>> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools=
/testing/selftests/kvm/include/kvm_util.h
>>>>> index 29cccaf96baf..ae0d14c2540a 100644
>>>>> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>>>>> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
>>>>> @@ -125,6 +125,12 @@ void vcpu_sregs_set(struct kvm_vm *vm, uint32_=
t vcpuid,
>>>>>  		    struct kvm_sregs *sregs);
>>>>>  int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
>>>>>  		    struct kvm_sregs *sregs);
>>>>> +void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid,
>>>>> +		  struct kvm_fpu *fpu);
>>>>> +void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid,
>>>>> +		  struct kvm_fpu *fpu);
>=20
> nit: no need for the above line breaks. We don't even get to 80 char.
>=20
>>>>> +void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_o=
ne_reg *reg);
>>>>> +void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_o=
ne_reg *reg);
>>>>>  #ifdef __KVM_HAVE_VCPU_EVENTS
>>>>>  void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
>>>>>  		     struct kvm_vcpu_events *events);
>>>>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/tes=
ting/selftests/kvm/lib/kvm_util.c
>>>>> index 41cf45416060..dae117728ec6 100644
>>>>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>>>>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>>>>> @@ -1373,6 +1373,54 @@ int _vcpu_sregs_set(struct kvm_vm *vm, uint3=
2_t vcpuid, struct kvm_sregs *sregs)
>>>>>  	return ioctl(vcpu->fd, KVM_SET_SREGS, sregs);
>>>>>  }
>>>>> =20
>>>>> +void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_f=
pu *fpu)
>>>>> +{
>>>>> +	struct vcpu *vcpu =3D vcpu_find(vm, vcpuid);
>>>>> +	int ret;
>>>>> +
>>>>> +	TEST_ASSERT(vcpu !=3D NULL, "vcpu not found, vcpuid: %u", vcpuid)=
;
>>>>> +
>>>>> +	ret =3D ioctl(vcpu->fd, KVM_GET_FPU, fpu);
>>>>> +	TEST_ASSERT(ret =3D=3D 0, "KVM_GET_FPU failed, rc: %i errno: %i",=

>>>>> +		    ret, errno);
>>>>> +}
>>>>> +
>>>>> +void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_f=
pu *fpu)
>>>>> +{
>>>>> +	struct vcpu *vcpu =3D vcpu_find(vm, vcpuid);
>>>>> +	int ret;
>>>>> +
>>>>> +	TEST_ASSERT(vcpu !=3D NULL, "vcpu not found, vcpuid: %u", vcpuid)=
;
>>>>> +
>>>>> +	ret =3D ioctl(vcpu->fd, KVM_SET_FPU, fpu);
>>>>> +	TEST_ASSERT(ret =3D=3D 0, "KVM_SET_FPU failed, rc: %i errno: %i",=

>>>>> +		    ret, errno);
>>>>> +}
>>>>> +
>>>>> +void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_o=
ne_reg *reg)
>>>>> +{
>>>>> +	struct vcpu *vcpu =3D vcpu_find(vm, vcpuid);
>>>>> +	int ret;
>>>>> +
>>>>> +	TEST_ASSERT(vcpu !=3D NULL, "vcpu not found, vcpuid: %u", vcpuid)=
;
>>>>> +
>>>>> +	ret =3D ioctl(vcpu->fd, KVM_GET_ONE_REG, reg);
>>>>> +	TEST_ASSERT(ret =3D=3D 0, "KVM_GET_ONE_REG failed, rc: %i errno: =
%i",
>>>>> +		    ret, errno);
>>>>> +}
>>>>> +
>>>>> +void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_o=
ne_reg *reg)
>>>>> +{
>>>>> +	struct vcpu *vcpu =3D vcpu_find(vm, vcpuid);
>>>>> +	int ret;
>>>>> +
>>>>> +	TEST_ASSERT(vcpu !=3D NULL, "vcpu not found, vcpuid: %u", vcpuid)=
;
>>>>> +
>>>>> +	ret =3D ioctl(vcpu->fd, KVM_SET_ONE_REG, reg);
>>>>> +	TEST_ASSERT(ret =3D=3D 0, "KVM_SET_ONE_REG failed, rc: %i errno: =
%i",
>>>>> +		    ret, errno);
>>>>> +}
>>>>> +
>>>>>  /*
>>>>>   * VCPU Ioctl
>>>>>   *
>>>>>
>>>>
>>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>>
>>>
>>> How about what's below instead. It should be equivalent.
>>
>> With your proposed changes we loose a bit verbosity in the error
>> messages. I need to think about which I like more.
>=20
> Looks like both error messages are missing something. The ones above ar=
e
> missing the string version of errno. The ones below are missing the str=
ing
> version of cmd. It's easy to add the string version of errno, which is
> an argument for keeping the functions above (but we could at least use
> _vcpu_ioctl to avoid duplicating the vcpu_find and vcpu!=3DNULL assert)=
=2E

Will do

> Or, we could consider adding a kvm_ioctl_cmd_to_string() function,
> which might be nice for other ioctl wrappers now and in the future.
> It shouldn't be too bad to generate a string table from kvm.h, but of
> course we'd have to keep it maintained.

I'm currently occupied with managing a lot of patches, so something like
that is not very high on my todo list.

>=20
> Thanks,
> drew
>=20
>>
>>>
>>> Thanks,
>>> drew
>>>
>>> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/t=
esting/selftests/kvm/include/kvm_util.h
>>> index 29cccaf96baf..d96a072e69bf 100644
>>> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>>> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
>>> @@ -125,6 +125,31 @@ void vcpu_sregs_set(struct kvm_vm *vm, uint32_t =
vcpuid,
>>>  		    struct kvm_sregs *sregs);
>>>  int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
>>>  		    struct kvm_sregs *sregs);
>>> +
>>> +static inline void
>>> +vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu=
)
>>> +{
>>> +	vcpu_ioctl(vm, vcpuid, KVM_GET_FPU, fpu);
>>> +}
>>> +
>>> +static inline void
>>> +vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu=
)
>>> +{
>>> +	vcpu_ioctl(vm, vcpuid, KVM_SET_FPU, fpu);
>>> +}
>>> +
>>> +static inline void
>>> +vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg =
*reg)
>>> +{
>>> +	vcpu_ioctl(vm, vcpuid, KVM_GET_ONE_REG, reg);
>>> +}
>>> +
>>> +static inline void
>>> +vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg =
*reg)
>>> +{
>>> +	vcpu_ioctl(vm, vcpuid, KVM_SET_ONE_REG, reg);
>>> +}
>>> +
>>>  #ifdef __KVM_HAVE_VCPU_EVENTS
>>>  void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
>>>  		     struct kvm_vcpu_events *events);
>>>
>>
>>
>=20
>=20
>=20



--d3X8xQHbW6SgQZrVZcGVnUpQYQrABFSHE--

--DFFeZVNJbOFSMeSfgn2mZqzUmgjMjFylz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4y7yYACgkQ41TmuOI4
ufjhkBAAvd2ToMIzb0TeOgOoW6N1GnI3RXbF1eQ7GSqkHf65rU4teZJScMyJ1YXR
3HI/u9ihamU4SDOiVJsu341/eKsB4LHaVikSlQJCOdSz+LJHBiX4ZL+aPDWpwSDe
aSvATURKF3GFctI4EVk+wjPO5Dqs6qcm6lLYqUftm3Ck98AhivggjjsKXzxBmBcy
habv5Boc531O0vLcdjqKFy843Lf04WUtP9nZvPvh2jSpLxETE3imrSrYxF92z1c0
JW83GfeuQ0DA+GhIuDv22VyyDnD9sTnsXXlDiR7w87vdOldsxivZCHQHqUn2xz2O
QuqfhhC2ISkmD3y2WW8zD4VcC509dP9FALWFUAhGxdDvbN6W2AO/TK50w6iOp6VQ
VyK1fDDNVUgsYZ+83qs8qaM+puJaJY0QZMKSJDgE7NEOi5g6EFg065gOWupx9YF5
GJHSRVqKQ1vgrpKz/LI9VR/LUSZvUKcx5xhg5iuv46ks9om3/9q5mzvxNcgLOn6E
jnF9MsRrW7+qwsAbqzYZ1997/Qt66UykHgr2qlAeP1IPg8b2Nas+QV+M8IKQ/Pgm
ETOmZSyx71nuqEUQTZrdP56ntOnZU2BXWR9BEvEt0fyZr8ik2BsiIwYQrnQ4rWqI
Oe1SYQEdpr93WHLHUIQqHKKRJXvAd6MINQVet9UT/WeGqGebFf0=
=4l8F
-----END PGP SIGNATURE-----

--DFFeZVNJbOFSMeSfgn2mZqzUmgjMjFylz--

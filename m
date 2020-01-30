Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65272 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726902AbgA3OLE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jan 2020 09:11:04 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UE9oGT113481
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 09:11:02 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xu5q6c2n3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 09:11:02 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 30 Jan 2020 14:11:00 -0000
Subject: Re: [PATCH v8 2/4] selftests: KVM: Add fpu and one reg set/get
 library functions
References: <20200129200312.3200-1-frankja@linux.ibm.com>
 <20200129200312.3200-3-frankja@linux.ibm.com>
 <72ff36e1-9170-dfb0-4050-f398f9a467eb@redhat.com>
 <20200130135512.diyyu3wvwqlwpqlx@kamzik.brq.redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 30 Jan 2020 15:10:55 +0100
MIME-Version: 1.0
In-Reply-To: <20200130135512.diyyu3wvwqlwpqlx@kamzik.brq.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="F90N2UgJRM9jKCWTGktKxesdld9lYnfGG"
Message-Id: <9d9e0e7a-b006-98b1-6bf0-8c46006835bc@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Jones <drjones@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: kvm@vger.kernel.org, borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F90N2UgJRM9jKCWTGktKxesdld9lYnfGG
Content-Type: multipart/mixed; boundary="3qn7yA9kyZYG3nohlLHuHJgXuVItI9ozd"

--3qn7yA9kyZYG3nohlLHuHJgXuVItI9ozd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/30/20 2:55 PM, Andrew Jones wrote:
> On Thu, Jan 30, 2020 at 11:36:21AM +0100, Thomas Huth wrote:
>> On 29/01/2020 21.03, Janosch Frank wrote:
>>> Add library access to more registers.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>  .../testing/selftests/kvm/include/kvm_util.h  |  6 +++
>>>  tools/testing/selftests/kvm/lib/kvm_util.c    | 48 +++++++++++++++++=
++
>>>  2 files changed, 54 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/t=
esting/selftests/kvm/include/kvm_util.h
>>> index 29cccaf96baf..ae0d14c2540a 100644
>>> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>>> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
>>> @@ -125,6 +125,12 @@ void vcpu_sregs_set(struct kvm_vm *vm, uint32_t =
vcpuid,
>>>  		    struct kvm_sregs *sregs);
>>>  int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
>>>  		    struct kvm_sregs *sregs);
>>> +void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid,
>>> +		  struct kvm_fpu *fpu);
>>> +void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid,
>>> +		  struct kvm_fpu *fpu);
>>> +void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one=
_reg *reg);
>>> +void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one=
_reg *reg);
>>>  #ifdef __KVM_HAVE_VCPU_EVENTS
>>>  void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
>>>  		     struct kvm_vcpu_events *events);
>>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testi=
ng/selftests/kvm/lib/kvm_util.c
>>> index 41cf45416060..dae117728ec6 100644
>>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>>> @@ -1373,6 +1373,54 @@ int _vcpu_sregs_set(struct kvm_vm *vm, uint32_=
t vcpuid, struct kvm_sregs *sregs)
>>>  	return ioctl(vcpu->fd, KVM_SET_SREGS, sregs);
>>>  }
>>> =20
>>> +void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu=
 *fpu)
>>> +{
>>> +	struct vcpu *vcpu =3D vcpu_find(vm, vcpuid);
>>> +	int ret;
>>> +
>>> +	TEST_ASSERT(vcpu !=3D NULL, "vcpu not found, vcpuid: %u", vcpuid);
>>> +
>>> +	ret =3D ioctl(vcpu->fd, KVM_GET_FPU, fpu);
>>> +	TEST_ASSERT(ret =3D=3D 0, "KVM_GET_FPU failed, rc: %i errno: %i",
>>> +		    ret, errno);
>>> +}
>>> +
>>> +void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu=
 *fpu)
>>> +{
>>> +	struct vcpu *vcpu =3D vcpu_find(vm, vcpuid);
>>> +	int ret;
>>> +
>>> +	TEST_ASSERT(vcpu !=3D NULL, "vcpu not found, vcpuid: %u", vcpuid);
>>> +
>>> +	ret =3D ioctl(vcpu->fd, KVM_SET_FPU, fpu);
>>> +	TEST_ASSERT(ret =3D=3D 0, "KVM_SET_FPU failed, rc: %i errno: %i",
>>> +		    ret, errno);
>>> +}
>>> +
>>> +void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one=
_reg *reg)
>>> +{
>>> +	struct vcpu *vcpu =3D vcpu_find(vm, vcpuid);
>>> +	int ret;
>>> +
>>> +	TEST_ASSERT(vcpu !=3D NULL, "vcpu not found, vcpuid: %u", vcpuid);
>>> +
>>> +	ret =3D ioctl(vcpu->fd, KVM_GET_ONE_REG, reg);
>>> +	TEST_ASSERT(ret =3D=3D 0, "KVM_GET_ONE_REG failed, rc: %i errno: %i=
",
>>> +		    ret, errno);
>>> +}
>>> +
>>> +void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one=
_reg *reg)
>>> +{
>>> +	struct vcpu *vcpu =3D vcpu_find(vm, vcpuid);
>>> +	int ret;
>>> +
>>> +	TEST_ASSERT(vcpu !=3D NULL, "vcpu not found, vcpuid: %u", vcpuid);
>>> +
>>> +	ret =3D ioctl(vcpu->fd, KVM_SET_ONE_REG, reg);
>>> +	TEST_ASSERT(ret =3D=3D 0, "KVM_SET_ONE_REG failed, rc: %i errno: %i=
",
>>> +		    ret, errno);
>>> +}
>>> +
>>>  /*
>>>   * VCPU Ioctl
>>>   *
>>>
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>
>=20
> How about what's below instead. It should be equivalent.

With your proposed changes we loose a bit verbosity in the error
messages. I need to think about which I like more.

>=20
> Thanks,
> drew
>=20
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/tes=
ting/selftests/kvm/include/kvm_util.h
> index 29cccaf96baf..d96a072e69bf 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -125,6 +125,31 @@ void vcpu_sregs_set(struct kvm_vm *vm, uint32_t vc=
puid,
>  		    struct kvm_sregs *sregs);
>  int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
>  		    struct kvm_sregs *sregs);
> +
> +static inline void
> +vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
> +{
> +	vcpu_ioctl(vm, vcpuid, KVM_GET_FPU, fpu);
> +}
> +
> +static inline void
> +vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
> +{
> +	vcpu_ioctl(vm, vcpuid, KVM_SET_FPU, fpu);
> +}
> +
> +static inline void
> +vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *r=
eg)
> +{
> +	vcpu_ioctl(vm, vcpuid, KVM_GET_ONE_REG, reg);
> +}
> +
> +static inline void
> +vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *r=
eg)
> +{
> +	vcpu_ioctl(vm, vcpuid, KVM_SET_ONE_REG, reg);
> +}
> +
>  #ifdef __KVM_HAVE_VCPU_EVENTS
>  void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
>  		     struct kvm_vcpu_events *events);
>=20



--3qn7yA9kyZYG3nohlLHuHJgXuVItI9ozd--

--F90N2UgJRM9jKCWTGktKxesdld9lYnfGG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4y4/AACgkQ41TmuOI4
ufhTBBAAgQuSqyT9u3OkxSaggV8NMVmd7uNO0C4sbFFM0bC1wmXPtLwir82e1QDA
Q9zQKsLzLhIKbuSV3GFXWYnunRk9yk5brGzKMpPijSIhpsjZdaModGklCMTord8y
av518MqVsI8SZKLk5fwGqzRvjH4zOu4kEalDV5ZZ8hAYjdMpgg/OgyFpFrYpH5xp
eAHyVo7JclKZF3DBff/vLddD/4dj/qBJRW8ls6AeibCz1FKSX20ROn7u6ElOEchz
htJSnx84ikg5cLD64hWeU4QTv8ekFenyL3mN/agdoJ97BnqiT7lutHKHO84fxYI9
sJ+YK+Wv5zas3x62W/Swg8qEB6TegciR5gwTqKXyR8ddlsFjjv2mJrJzCQGWYRcr
c+OAAAvZVk//xn8UzMLzEoOrYAwUZUb2ie49tt9OI394gPjksojy0uOI+j2/5+AQ
EpWjPGY4uV4hTpaXO8g67e2Bbfuxj4mZglU/rg7djgkNW+PpWxClQzByjMijhVP8
U8+4VVSwRVyPMV9hdVFlU68YeFIVubPNgHkqrMptMJzzk3c+8iutPjLNImfzG29O
QRav8LxCplpcqdhTVt7am4G5/r8O4y75ov9aYFWP69q1RU87lY3Bb6QMGGpavTv0
tgVBH1siRq1HllNkfe5veB+hzPqXbdlhICz+ykrNaCfWAWvqcsg=
=jcZ2
-----END PGP SIGNATURE-----

--F90N2UgJRM9jKCWTGktKxesdld9lYnfGG--

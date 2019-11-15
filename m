Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47810 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727442AbfKONox (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 08:44:53 -0500
Subject: Re: [RFC 33/37] KVM: s390: Introduce VCPU reset IOCTL
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-34-frankja@linux.ibm.com>
 <e7a62927-7e0e-1309-d5ad-b4a59149bb6a@redhat.com>
 <fde8cd83-035e-5ef6-6b34-455857b3c579@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9ba7930d-1a95-bc36-9a1f-1a095e5a59fb@redhat.com>
Date: Fri, 15 Nov 2019 14:18:40 +0100
MIME-Version: 1.0
In-Reply-To: <fde8cd83-035e-5ef6-6b34-455857b3c579@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ddptErXd9qsUlaaXGCLFsflRZUWgKMSyS"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ddptErXd9qsUlaaXGCLFsflRZUWgKMSyS
Content-Type: multipart/mixed; boundary="7jVYc2MxHJm2jr1cDd4mPwuSbNVpSs1WC"

--7jVYc2MxHJm2jr1cDd4mPwuSbNVpSs1WC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15/11/2019 14.06, Janosch Frank wrote:
> On 11/15/19 11:47 AM, Thomas Huth wrote:
>> On 24/10/2019 13.40, Janosch Frank wrote:
>>> With PV we need to do things for all reset types, not only initial...
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>  arch/s390/kvm/kvm-s390.c | 53 ++++++++++++++++++++++++++++++++++++++++
>>>  include/uapi/linux/kvm.h |  6 +++++
>>>  2 files changed, 59 insertions(+)
>>>
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index d3fd3ad1d09b..d8ee3a98e961 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -3472,6 +3472,53 @@ static int kvm_arch_vcpu_ioctl_initial_reset(str=
uct kvm_vcpu *vcpu)
>>>  =09return 0;
>>>  }
>>> =20
>>> +static int kvm_arch_vcpu_ioctl_reset(struct kvm_vcpu *vcpu,
>>> +=09=09=09=09     unsigned long type)
>>> +{
>>> +=09int rc;
>>> +=09u32 ret;
>>> +
>>> +=09switch (type) {
>>> +=09case KVM_S390_VCPU_RESET_NORMAL:
>>> +=09=09/*
>>> +=09=09 * Only very little is reset, userspace handles the
>>> +=09=09 * non-protected case.
>>> +=09=09 */
>>> +=09=09rc =3D 0;
>>> +=09=09if (kvm_s390_pv_handle_cpu(vcpu)) {
>>> +=09=09=09rc =3D uv_cmd_nodata(kvm_s390_pv_handle_cpu(vcpu),
>>> +=09=09=09=09=09   UVC_CMD_CPU_RESET, &ret);
>>> +=09=09=09VCPU_EVENT(vcpu, 3, "PROTVIRT RESET NORMAL VCPU: cpu %d rc %x=
 rrc %x",
>>> +=09=09=09=09   vcpu->vcpu_id, ret >> 16, ret & 0x0000ffff);
>>> +=09=09}
>>> +=09=09break;
>>> +=09case KVM_S390_VCPU_RESET_INITIAL:
>>> +=09=09rc =3D kvm_arch_vcpu_ioctl_initial_reset(vcpu);
>>> +=09=09if (kvm_s390_pv_handle_cpu(vcpu)) {
>>> +=09=09=09uv_cmd_nodata(kvm_s390_pv_handle_cpu(vcpu),
>>> +=09=09=09=09      UVC_CMD_CPU_RESET_INITIAL,
>>> +=09=09=09=09      &ret);
>>> +=09=09=09VCPU_EVENT(vcpu, 3, "PROTVIRT RESET INITIAL VCPU: cpu %d rc %=
x rrc %x",
>>> +=09=09=09=09   vcpu->vcpu_id, ret >> 16, ret & 0x0000ffff);
>>> +=09=09}
>>> +=09=09break;
>>> +=09case KVM_S390_VCPU_RESET_CLEAR:
>>> +=09=09rc =3D kvm_arch_vcpu_ioctl_initial_reset(vcpu);
>>> +=09=09if (kvm_s390_pv_handle_cpu(vcpu)) {
>>> +=09=09=09rc =3D uv_cmd_nodata(kvm_s390_pv_handle_cpu(vcpu),
>>> +=09=09=09=09=09   UVC_CMD_CPU_RESET_CLEAR, &ret);
>>> +=09=09=09VCPU_EVENT(vcpu, 3, "PROTVIRT RESET CLEAR VCPU: cpu %d rc %x =
rrc %x",
>>> +=09=09=09=09   vcpu->vcpu_id, ret >> 16, ret & 0x0000ffff);
>>> +=09=09}
>>> +=09=09break;
>>> +=09default:
>>> +=09=09rc =3D -EINVAL;
>>> +=09=09break;
>>
>> (nit: you could drop the "break;" here)
>>
>>> +=09}
>>> +=09return rc;
>>> +}
>>> +
>>> +
>>>  int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_reg=
s *regs)
>>>  {
>>>  =09vcpu_load(vcpu);
>>> @@ -4633,8 +4680,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>>>  =09=09break;
>>>  =09}
>>>  =09case KVM_S390_INITIAL_RESET:
>>> +=09=09r =3D -EINVAL;
>>> +=09=09if (kvm_s390_pv_is_protected(vcpu->kvm))
>>> +=09=09=09break;
>>
>> Wouldn't it be nicer to call
>>
>>   kvm_arch_vcpu_ioctl_reset(vcpu, KVM_S390_VCPU_RESET_INITIAL)
>>
>> in this case instead?
>=20
> How about:
>         case KVM_S390_INITIAL_RESET:
>=20
>=20
>                 arg =3D KVM_S390_VCPU_RESET_INITIAL;
>=20

Add a "/* fallthrough */" comment here...

>         case KVM_S390_VCPU_RESET:
>=20
>=20
>                 r =3D kvm_arch_vcpu_ioctl_reset(vcpu, arg);
>=20
>=20
>                 break;

... then this looks good, yes!

 Thomas


--7jVYc2MxHJm2jr1cDd4mPwuSbNVpSs1WC--

--ddptErXd9qsUlaaXGCLFsflRZUWgKMSyS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl3OpbwACgkQLtnXdP5w
LbUFFA//XgnJZcgvYpUMvdaTT3HOwu/ZcJE5Nq4kGGj0ZXYDrfjNVbgYVUPSRV5U
E+Eepl54g3ZmgSH3u+u58v2Q4OQIsTCfEoRUECxOAhM3IxxxnEQrf99vGODEieCE
/J8kiHhfOQI+m8gsyiHFfCGRA3N0VchuvxMiwRwvU00XQJcRd3Xm3RDMfbcWqdtn
7y7vfMaolB9sC/uyWeLHtpkHJhqW/m6IntiM0UH2KjRhekkW6ZkRWleAF22aVtk+
B8aJ7VM5f7OW4TaO+/F2mF/Vq6lDVjz3CTjpbJ52qEILSkfMIJd+db7NeFsp/vQh
HzmZN3/ARtqjzVEDlOZNQk9OXxxdliAAfwWIJujYIKWq5WZo2XaipiiT9LhlFQsB
5sVfJDntZx2JaZScgnvgp3EX4PXeSqgfi6kFzvAYrt+sepRjjUJLLVBe6YOUXxbS
L3bHWSbWye8BqFtJHBoQANBAyq8/0wF6D/bD+/2ac8KNmq7YVYTJx4TjUrmRSXrJ
uFI3nnvRksubhg3VjM5TacrvujDN5FqDyTSeQJ7si6XYFZBs4EdlNGSV2UixSXT8
NvXZl1z0vXsMtPpgv1yRepAd27DRLp/1sm5DN2VBjYw2YzJH3jnNinFVedxDi6L0
69Gqc3+oPYYliNbSWKkEM6kpLDiMc1ZhEeVS6xVCIVLCP4gHsoI=
=c7do
-----END PGP SIGNATURE-----

--ddptErXd9qsUlaaXGCLFsflRZUWgKMSyS--

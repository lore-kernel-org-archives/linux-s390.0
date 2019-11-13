Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25242 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726107AbfKMKGL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Nov 2019 05:06:11 -0500
Subject: Re: [RFC 04/37] KVM: s390: protvirt: Add initial lifecycle handling
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-5-frankja@linux.ibm.com>
 <20191107172956.4f4d8a90.cohuck@redhat.com>
 <8989f705-ce14-7b85-e5b6-6d87803db491@linux.ibm.com>
 <20191111172558.731a0d8b.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b28ae9ba-e085-08ef-9b1b-eede5e0457af@redhat.com>
Date: Wed, 13 Nov 2019 11:05:49 +0100
MIME-Version: 1.0
In-Reply-To: <20191111172558.731a0d8b.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hljtreHj6wc9C4jdFxZK1WbE8eRgFJtB0"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hljtreHj6wc9C4jdFxZK1WbE8eRgFJtB0
Content-Type: multipart/mixed; boundary="9IIrUE8asiG4qWC2ZZ8GVxERneEBnU0YK"

--9IIrUE8asiG4qWC2ZZ8GVxERneEBnU0YK
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/11/2019 17.25, Cornelia Huck wrote:
> On Fri, 8 Nov 2019 08:36:35 +0100
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> On 11/7/19 5:29 PM, Cornelia Huck wrote:
[...]
>>>  =20
>>>> +int kvm_s390_pv_create_cpu(struct kvm_vcpu *vcpu)
>>>> +{
>>>> +=09int rc;
>>>> +=09struct uv_cb_csc uvcb =3D {
>>>> +=09=09.header.cmd =3D UVC_CMD_CREATE_SEC_CPU,
>>>> +=09=09.header.len =3D sizeof(uvcb),
>>>> +=09};
>>>> +
>>>> +=09/* EEXIST and ENOENT? */ =20
>>>
>>> ? =20
>>
>> I was asking myself if EEXIST or ENOENT would be better error values
>> than EINVAL.
>=20
> EEXIST might be better, but I don't really like ENOENT.
>=20
>>>  =20
>>>> +=09if (kvm_s390_pv_handle_cpu(vcpu))
>>>> +=09=09return -EINVAL;

FWIW, I'd also vote for EEXIST here.

 Thomas


--9IIrUE8asiG4qWC2ZZ8GVxERneEBnU0YK--

--hljtreHj6wc9C4jdFxZK1WbE8eRgFJtB0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl3L1YUACgkQLtnXdP5w
LbW7SQ//RExUXZOruu0BZ0+TgRSjROGyJ3AfBJvDYZDOcA1w0bp2k9tTDhq39a0o
/qP05FxW0zmBRUn/yMRX6njAk0aFn/ArHyH5z1B5fum9m53ldjq3mir09CqECfaG
8mfSt+YLm3aY9p3lDxygRCoT7eBu1owxarOfetTet1Fe8QutsftHFoW52so7yYvG
amCG3YPxqxqTZ315Ef5jzGl6RllF2UHbi4Apn3u9XJ9tPzxFWKUX/U7Ug+E8aw1e
QBHq84b+MFbZxz+0TVKWuKhNdLArRPxzpRc7dUUxJCSb+cG/3MKgSLdwrvLqOPGm
vfvtNb0iaDyoSJa0tMQfo1zFur0YTrneflBzzMvJ8CstLVeCH0N2NjwwpGBoDICO
CdYBbPoXU7cBnaTAVbCpY9WjAmsHaLYbfNNYzu80VPBVJ26Zz8JucrfnJRUjzBGP
b2V6JnpPCMiTf1nNfW27LE2ViDxguwfqnnYhF3yY89Po3uYt6YWz5JI6mrBpP4d4
WRQ58RhSHirbA7kAej047hkQDi+hn8gDzaZh388S8S3pGarWPXAa2k7/5GhNjZx9
qLXDq8rcjr10A6vwTf1az4FIgUmECpAccIzjmHl8rkYpZGyIY60nelQ7MDjQvTK2
6n/kU89j6RpMppC0RC1ZyrYusfS2JTxhUDuQfmcjgWrn4Ta2O0g=
=cYoY
-----END PGP SIGNATURE-----

--hljtreHj6wc9C4jdFxZK1WbE8eRgFJtB0--

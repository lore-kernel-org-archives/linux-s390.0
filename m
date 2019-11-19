Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727584AbfKSKJZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Nov 2019 05:09:25 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJA9KHo083457
        for <linux-s390@vger.kernel.org>; Tue, 19 Nov 2019 05:09:23 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2way6avtcm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 19 Nov 2019 05:09:22 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 19 Nov 2019 10:08:40 -0000
Subject: Re: [RFC 23/37] KVM: s390: protvirt: Make sure prefix is always
 protected
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-24-frankja@linux.ibm.com>
 <20191118173942.0252b731.cohuck@redhat.com>
 <db54630b-8959-feba-168e-0afecc30d4b9@linux.ibm.com>
 <20191119104528.3f3c2620.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 19 Nov 2019 11:08:36 +0100
MIME-Version: 1.0
In-Reply-To: <20191119104528.3f3c2620.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iw8GvkYJ1VK8Sh1gF4dFKK03mUZa2LDZd"
Message-Id: <f19ce1fe-2761-d8ed-15b6-fa7e06117475@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iw8GvkYJ1VK8Sh1gF4dFKK03mUZa2LDZd
Content-Type: multipart/mixed; boundary="hUTNCY5HXLYf7wRdxkG0joeKNNVWmRRf4"

--hUTNCY5HXLYf7wRdxkG0joeKNNVWmRRf4
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/19/19 10:45 AM, Cornelia Huck wrote:
> On Tue, 19 Nov 2019 09:11:11 +0100
[...]
>>>
>>> So, what happens if we have an error other than -EEXIST (which
>>> presumably means that we already protected it) here? The page is not
>>> protected, and further accesses will get an error? (Another question:=

>>> what can actually go wrong here?) =20
>>
>> If KVM or QEMU write into a lowcore, we will fail the integrity check =
on
>> import and this cpu will never run again.
>=20
> From the guest's POV, is that similar to a cpu going into xstop?

Not really, I'm wondering what happens, if we try to send a restart to
such a cpu.

> =20
>> In retrospect a warn_on_once might be the wrong error handling here.
>>
>>>  =20
>>>> +		}
>>>>  		if (rc) {
>>>>  			kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
>>>>  			return rc; =20
>>>  =20
>>
>>
>=20



--hUTNCY5HXLYf7wRdxkG0joeKNNVWmRRf4--

--iw8GvkYJ1VK8Sh1gF4dFKK03mUZa2LDZd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3TvyQACgkQ41TmuOI4
ufhHjw/7BaXIre2ND8lvliazh0c4CiNaTTdBI2DHm75ayM4Nsen03uqp4J54yHMn
sRyax174VJpGJeK8ds0f8azzdSZdxhJC+k5lDDK5vVbwskyCS5F9cynsiRVY/lKn
z/SVHRvjfz0nRFgZAdDsBtOBSTJtIhL3h6fqFZEfaoQX6eYjYdC9HhJ2+jN+IUWx
NxgebOmya6Tej7M6NCpUiEwVg1L1dluvzq4wi1523YJ9qaTNoo29SJ/YfFP6z8/l
ov52EnofMwyTO726D59GaLhPItDme347IeZWL81eSW4EbCCb3fG/crkkjew/HlsZ
02B29rEfQFybQDhKi1cu1zI+Wx9LpVfknVgA4ZsOmohzGL5pl81HTa8/dB51WBW/
IjKeAyPY3z9u23IbgHgS8ecxlER7n14NdcaQ75GLv/9Gq1g7hUHA4yAmb+HH7e8Z
fzRgxWfCuXpHtFefvOmhA7FuVxC8zMVjdeCXixzpRlWhvRDgP50zI9ImX8U7wr8x
VnQLn6aTSIxf9Kp1+9zPsZFmaYRFa5fUeMpZxheIL4yKB3vqrsqI+/DlMuLZcVe8
IAFDMIHT8JVu144acLeeQSWtXNJqOOo2C9hPeAXS2cDq5JimPAw9l5oUd2a4Rv4R
rURVuaIQKiEBLHXSIOQF89DX69cEZ4Iae1xVzRtDfra14BkvNGA=
=UVRR
-----END PGP SIGNATURE-----

--iw8GvkYJ1VK8Sh1gF4dFKK03mUZa2LDZd--

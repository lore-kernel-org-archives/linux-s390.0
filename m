Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54352 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729659AbgIDLjB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Sep 2020 07:39:01 -0400
Subject: Re: [PATCH 1/2] s390x: uv: Add destroy page call
References: <20200903131435.2535-1-frankja@linux.ibm.com>
 <20200903131435.2535-2-frankja@linux.ibm.com> <20200904103939.GE6075@osiris>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <98237148-bbb4-c6d7-aba2-6fa11fb788b1@linux.ibm.com>
Date: Fri, 4 Sep 2020 13:38:53 +0200
MIME-Version: 1.0
In-Reply-To: <20200904103939.GE6075@osiris>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ty87bI7MgMKm6fXe49RqHo8ycbhLLhy96"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ty87bI7MgMKm6fXe49RqHo8ycbhLLhy96
Content-Type: multipart/mixed; boundary="5gYus1bgkJ2xCtNJM2WNdNZpXxcjIOGZ1"

--5gYus1bgkJ2xCtNJM2WNdNZpXxcjIOGZ1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/4/20 12:39 PM, Heiko Carstens wrote:
> On Thu, Sep 03, 2020 at 09:14:34AM -0400, Janosch Frank wrote:
>> +int uv_destroy_page(unsigned long paddr)
>> +{
>> +	struct uv_cb_cfs uvcb =3D {
>> +		.header.cmd =3D UVC_CMD_DESTR_SEC_STOR,
>> +		.header.len =3D sizeof(uvcb),
>> +		.paddr =3D paddr
>> +	};
>> +
>> +	if (uv_call(0, (u64)&uvcb))
>> +		return -EINVAL;
>> +	return 0;
>> +}
>> +
>> +

I need to remove one of those \n

>>  /*
>>   * Requests the Ultravisor to encrypt a guest page and make it
>>   * accessible to the host for paging (export).
>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>> index 373542ca1113..cfb0017f33a7 100644
>> --- a/arch/s390/mm/gmap.c
>> +++ b/arch/s390/mm/gmap.c
>> @@ -2679,7 +2679,7 @@ static int __s390_reset_acc(pte_t *ptep, unsigne=
d long addr,
>>  	pte_t pte =3D READ_ONCE(*ptep);
>> =20
>>  	if (pte_present(pte))
>> -		WARN_ON_ONCE(uv_convert_from_secure(pte_val(pte) & PAGE_MASK));
>> +		WARN_ON_ONCE(uv_destroy_page(pte_val(pte) & PAGE_MASK));
>=20
> Why not put the WARN_ON_ONCE() into uv_destroy_page() and make that
> function return void?
>=20
If you prefer that, I'll change the patch.

I think we'd need a proper print of the return codes of the UVC anyway,
the warn isn't very helpful if you want to debug after the fact.


--5gYus1bgkJ2xCtNJM2WNdNZpXxcjIOGZ1--

--Ty87bI7MgMKm6fXe49RqHo8ycbhLLhy96
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl9SJ00ACgkQ41TmuOI4
ufgwCA/+IwTFYXBSyrr4KJtIPoXgxNzI2KFUQwJBCuOl/dOCYBLQCz4NGfj6Ijh1
cnXOhIni65ZgFsQ8Year5Pw9k47yO4CPznu/txjwvtEy2ACR6Fav7kUv2RaARzMr
hLT2UynecUZAic1I+3P4zeBk9rPE7uf6VSTRhdlyIpUViL6VasuwpMN7kihG5YbO
erhpxkiNWYrXVmaNRQ4GxbQ5rs07+8I+7s+K8V9arU2LyUxMVnM3FeAE8D37FXEc
ZWq00ghAs2FbmdNG6RbpkOS4VEYR7j8MxNv7k3gaLJIj3p9sYXUK5BsASesrE5JD
6rLNPoTO6w2AlHg2STwxVHI84ubo2kjovaJTj4bCJX/FgZIzmlmlckIBYXT9U/Fe
j7EoyqY4mEvYaXvkwyf1m6L5tWR3hIPRpmhP0F+FingHO4lOLlpccCmgpIaUdiol
b2KPMkH32uH+Lcri9LD2TUAYEE5Px7Fodjs5wlvLJ+SXPonWocsDPrxXQY+LQmDw
W+DZPloFCen3fe2wgkrxR8eVjbjgLSJD4Dyfzafc79SiaKSO6dEx5bKNdFP5rTzU
lMNKS7NsgmW4O+maZiwuDJEB7atKkQv9movF2PXCoeOU44hZ0KL660jEgO9JQ06x
dxoF+s8uftOHQvsgWm596UP2AcIwrexLuk2v5s9//8cvK0ryTLI=
=enNr
-----END PGP SIGNATURE-----

--Ty87bI7MgMKm6fXe49RqHo8ycbhLLhy96--

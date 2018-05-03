From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 03 May 2018 06:41:22 +0000
Subject: Re: [PATCH v1 3/3] KVM: s390: generalize kvm_s390_get_tod_clock_ext()
Message-Id: <abbc7391-f1c6-2813-16c8-78fe13ff44aa@linux.ibm.com>
In-Reply-To: <aebf485c-3e8b-0941-7361-df2f7a9927d1@redhat.com>
References: <aebf485c-3e8b-0941-7361-df2f7a9927d1@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--HF6t0t7mSSQwLH9GugPohkxAUDdS8dz4y"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HF6t0t7mSSQwLH9GugPohkxAUDdS8dz4y
Content-Type: multipart/mixed; boundary="FkodZd6ORR3OPso0NU7vNUfjN6Ig3vKdJ";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>,@vger.kernel.org, kvm@vger.kernel.org
 Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>
Message-ID: <abbc7391-f1c6-2813-16c8-78fe13ff44aa@linux.ibm.com>
Subject: Re: [PATCH v1 3/3] KVM: s390: generalize kvm_s390_get_tod_clock_ext()
References: <20180427123613.20624-1-david@redhat.com>
 <20180427123613.20624-4-david@redhat.com>
 <0e93ce34-bc62-eb2f-abb7-deb500d28026@de.ibm.com>
 <aebf485c-3e8b-0941-7361-df2f7a9927d1@redhat.com>
In-Reply-To: <aebf485c-3e8b-0941-7361-df2f7a9927d1@redhat.com>

--FkodZd6ORR3OPso0NU7vNUfjN6Ig3vKdJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.05.2018 21:40, David Hildenbrand wrote:
> On 02.05.2018 21:36, Christian Borntraeger wrote:
>>
>>
>> On 04/27/2018 02:36 PM, David Hildenbrand wrote:
>>> Move the Multiple-epoch facility handling into it and rename it to
>> [..]
>>
>>
>>> @@ -1055,13 +1057,7 @@ static int kvm_s390_get_tod_ext(struct kvm *kv=
m, struct kvm_device_attr *attr)
>>>  {
>>>  	struct kvm_s390_vm_tod_clock gtod;
>>> =20
>>> -	memset(&gtod, 0, sizeof(gtod));
>>
>> We should keep the memset, otherwise the padding might leak kernel inf=
o as we copy .
>> (found by smatch)
>=20
> Thanks for the info and running the checker.
>=20
> @Janosch please tell me if I should resend!

I'll fix that, no need to resend.

>=20
>>
>>
>>     arch/s390/kvm/kvm-s390.c:1068 kvm_s390_get_tod_ext() warn: check t=
hat 'gtod' doesn't leak information (struct has a hole after 'epoch_idx')=

>>
>>
>>> -
>>> -	if (test_kvm_facility(kvm, 139))
>>> -		kvm_s390_get_tod_clock_ext(kvm, &gtod);
>>> -	else
>>> -		gtod.tod =3D kvm_s390_get_tod_clock_fast(kvm);
>>> -
>>> +	kvm_s390_get_tod_clock(kvm, &gtod);
>>>  	if (copy_to_user((void __user *)attr->addr, &gtod, sizeof(gtod)))
>>>  		return -EFAULT;
>>> =20
>>>
>>
>=20
>=20



--FkodZd6ORR3OPso0NU7vNUfjN6Ig3vKdJ--

--HF6t0t7mSSQwLH9GugPohkxAUDdS8dz4y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJa6q8ZAAoJEBcO/8Q8ZEV5VtkQAIlhBGrYJ2ZBviFsboU4zCcx
EbzRHkF4xgMfvljSDBd2L5v0EgjgJSL4tzZdu6vbiRUNWLewVbNr5gJ29xfZf++e
16VzxFvzOh/nCCQDfdc1A5v9bI4lKLSS+5J1NqCWKzfmvX8N6V2QFmXOwik994s3
qBu0PorMK7WeCWJNNotYGkmoszyKTS7tJJP8HPBvydF1sddYEKrMi7qebZXYYPzD
S5jhjcRgoTtquuNtmby8uVZseXQb6j6iHKQHMbeXCCuvKWOTxE30AdWE5zqSUotK
D0ALWmfL4TtKnuHCNTQqoM8BTI7D/L86lejTENnd79VfV5Xo5ZU5gOt3Lo91gDY9
INE/Dxfzl5J9fHVrAaqT6IR9vTHOkaTMU5s83YsoKiLevfaF3P9oBbDD9cJKUmwd
LQVpn9KfeHE7LEoNUfX5Qr46s/+cmF0atD8+dIxRkhR2krXlzdNHupcxuAPoQvwV
ry77uEY0zzlG0lfb5eYwCGUR1NzQ8Qk3SDqwT/Ip5xMbuT6h1HkQmvsuFDpd4KLr
EYEStF/GY8vLw/HUsVLKt00g8mIGCzcMOew5vKsKnmwfzVrh/2tf3CgJZDYCSnRi
NE85PyI5qm53k99TYCdEiY5Nh28eqy1v+Rg/GYDkLlfh+lcwN4lBv5b+aOOb5hDZ
zF+9U7HIzB9t32nabOX7
=GkcY
-----END PGP SIGNATURE-----

--HF6t0t7mSSQwLH9GugPohkxAUDdS8dz4y--

From: Janosch Frank <frankja@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2018 12:47:35 +0000
Subject: Re: [PATCH 2/2] KVM: s390: Add storage key facility interpretation control
Message-Id: <52697ed8-f1d0-b7e1-3e56-00d89c28f633@linux.vnet.ibm.com>
In-Reply-To: <36e734a6-77ce-2e91-f15b-00772aaa04cc@redhat.com>
References: <36e734a6-77ce-2e91-f15b-00772aaa04cc@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--9WGouaep2QQHsnPkuBQDAmTxCm8JKiD0m"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9WGouaep2QQHsnPkuBQDAmTxCm8JKiD0m
Content-Type: multipart/mixed; boundary="YcUYSQ8r0698rGTYZOOtwsyBKf6Ov4Kkj";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, alifm@linux.vnet.ibm.com,
 imbrenda@linux.vnet.ibm.com, linux-s390@vger.kernel.org
Message-ID: <52697ed8-f1d0-b7e1-3e56-00d89c28f633@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] KVM: s390: Add storage key facility interpretation
 control
References: <1518779775-256056-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518779775-256056-3-git-send-email-frankja@linux.vnet.ibm.com>
 <36e734a6-77ce-2e91-f15b-00772aaa04cc@redhat.com>
In-Reply-To: <36e734a6-77ce-2e91-f15b-00772aaa04cc@redhat.com>

--YcUYSQ8r0698rGTYZOOtwsyBKf6Ov4Kkj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.02.2018 10:40, David Hildenbrand wrote:
>=20
>>  	spin_lock_init(&kvm->arch.start_stop_lock);
>> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
>> index 76a2380..d9bd147 100644
>> --- a/arch/s390/kvm/priv.c
>> +++ b/arch/s390/kvm/priv.c
>> @@ -208,19 +208,23 @@ int kvm_s390_skey_check_enable(struct kvm_vcpu *=
vcpu)
>>  	struct kvm_s390_sie_block *sie_block =3D vcpu->arch.sie_block;
>> =20
>>  	trace_kvm_s390_skey_related_inst(vcpu);
>> -	if (!(sie_block->ictl & (ICTL_ISKE | ICTL_SSKE | ICTL_RRBE)) &&
>> +	/* Already enabled? */
>> +	if (vcpu->kvm->arch.use_skf &&
>> +	    !(sie_block->ictl & (ICTL_ISKE | ICTL_SSKE | ICTL_RRBE)) &&
>>  	    !kvm_s390_test_cpuflags(vcpu, CPUSTAT_KSS))
>>  		return rc;
>=20
> Wonder if it is nicer to simply remember for each CPU if this function
> has already been called. This way we can avoid calling
> s390_enable_skey() in all configurations.
>=20

With the benefit being, that on a per cpu storage we wouldn't have to
lock the call indication, as we are the thread of this vcpu and only we
can alter it? Which would speed up hpage and VSIE cases a tad, as the
down_write is quite heavy. We could also do a down_read, store
enablement status, up_read, if !enabled -> 390_enable_skey().

I'm also wondering, if we have a clean way after migrating a skey using
guest to disable interception right away when we get the skeys from
QEMU. I don't think we do that yet.


--YcUYSQ8r0698rGTYZOOtwsyBKf6Ov4Kkj--

--9WGouaep2QQHsnPkuBQDAmTxCm8JKiD0m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJalVN4AAoJEBcO/8Q8ZEV5HkQQALmhUssaNJ/mwJilQA8ArIRg
0xiYhOmTzYQcVPYQa2sRZfgbBnuhM//5JPvkXM4aMrucywqgEj1O1arGhZiH3dH7
8EGN7+evOyVLB125CjG5N9tmSkROe3ilRbBa3aTPeK9ZwGp/EkzcbF834rDV8dMl
dLjH7kgD9NgQIZ2SUP45TEPOzhk3VXahlTsJ44SsXBb1G5bNjW+fN7gWEmni4Kas
dwWcnnbSY4sFuGZFzcc/ls0h3oPo2eGln/ssvct8qjEeL31rljzoXuYYeboLT2hr
MTowGcaRQvjCZk9t8XtoKoRPmL2os6HCvNbAucjzDqLJetSoBR2PlCsv7gnEVJFC
X9FcCbYj3G18mxpGgy40tVZbdoY0mGc9NipKdkDvGm8DZPzQnBL3VQOtyo7WI1AI
90VG/H86zg3VstgbyhZiN/RMzP/e1j+Cv9UlHOxugSPaqgID49gmKhCy+HB0b7Oi
VU5ImaiSXvH7OFcZ5JKytbpJrFRX90+E3qIS9GPDSQzj4WAstZDDn7pp2G9xy/MF
u7UuxwfMa0iWAJWnHR8lOu/+B8c2tFAeZMivfsombPbundZzEmDTq0kwVt7jsn4S
kUWH2eYrl/tAJcOmfiiSUcmWC0jsLcohusS0TWgbvzDILFT0k2aGDTO2Gfv5nX49
hdtsHtgvNq6GEi3RDKQD
=RlCV
-----END PGP SIGNATURE-----

--9WGouaep2QQHsnPkuBQDAmTxCm8JKiD0m--

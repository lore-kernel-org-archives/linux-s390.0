Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728104AbgBQOhN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 09:37:13 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HEXsEU029107
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 09:37:11 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6cu1syay-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 09:37:11 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 17 Feb 2020 14:37:09 -0000
Subject: Re: [PATCH v2 19/42] KVM: s390: protvirt: Add new gprs location
 handling
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-20-borntraeger@de.ibm.com>
 <38b60f61-db18-ee7a-6b8e-192a7bb9d259@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 17 Feb 2020 15:37:01 +0100
MIME-Version: 1.0
In-Reply-To: <38b60f61-db18-ee7a-6b8e-192a7bb9d259@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="15epwzkLUo7Bcf3A4CIC1Q3fDF0gFmu1D"
Message-Id: <760a6ec5-d511-a2a8-815f-1cfc02049f40@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--15epwzkLUo7Bcf3A4CIC1Q3fDF0gFmu1D
Content-Type: multipart/mixed; boundary="4m7YKRRG5SpGtrVj472zUnFa1T4cWa8iX"

--4m7YKRRG5SpGtrVj472zUnFa1T4cWa8iX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/17/20 12:01 PM, David Hildenbrand wrote:
> On 14.02.20 23:26, Christian Borntraeger wrote:
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> Guest registers for protected guests are stored at offset 0x380.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h |  4 +++-
>>  arch/s390/kvm/kvm-s390.c         | 11 +++++++++++
>>  2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/=
kvm_host.h
>> index ba3364b37159..4fcbb055a565 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -343,7 +343,9 @@ struct kvm_s390_itdb {
>>  struct sie_page {
>>  	struct kvm_s390_sie_block sie_block;
>>  	struct mcck_volatile_info mcck_info;	/* 0x0200 */
>> -	__u8 reserved218[1000];		/* 0x0218 */
>> +	__u8 reserved218[360];		/* 0x0218 */
>> +	__u64 pv_grregs[16];		/* 0x0380 */
>> +	__u8 reserved400[512];		/* 0x0400 */
>>  	struct kvm_s390_itdb itdb;	/* 0x0600 */
>>  	__u8 reserved700[2304];		/* 0x0700 */
>>  };
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index a85e50075d99..6ebb0dae5a2e 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -3999,6 +3999,7 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, =
int exit_reason)
>>  static int __vcpu_run(struct kvm_vcpu *vcpu)
>>  {
>>  	int rc, exit_reason;
>> +	struct sie_page *sie_page =3D (struct sie_page *)vcpu->arch.sie_bloc=
k;
>> =20
>>  	/*
>>  	 * We try to hold kvm->srcu during most of vcpu_run (except when run=
-
>> @@ -4020,8 +4021,18 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
>>  		guest_enter_irqoff();
>>  		__disable_cpu_timer_accounting(vcpu);
>>  		local_irq_enable();
>> +		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>> +			memcpy(sie_page->pv_grregs,
>> +			       vcpu->run->s.regs.gprs,
>> +			       sizeof(sie_page->pv_grregs));
>> +		}
>>  		exit_reason =3D sie64a(vcpu->arch.sie_block,
>>  				     vcpu->run->s.regs.gprs);
>> +		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>> +			memcpy(vcpu->run->s.regs.gprs,
>> +			       sie_page->pv_grregs,
>> +			       sizeof(sie_page->pv_grregs));
>> +		}
>>  		local_irq_disable();
>>  		__enable_cpu_timer_accounting(vcpu);
>>  		guest_exit_irqoff();
>>
>=20
> As discussed, I think there is room for improvement in the future (whic=
h
> we could have documented in the patch description), because this is
> obviously sub-optimal.

I added it to my KVM TODO list.

>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks for reviewing this patch and all the others :-)



--4m7YKRRG5SpGtrVj472zUnFa1T4cWa8iX--

--15epwzkLUo7Bcf3A4CIC1Q3fDF0gFmu1D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5KpQ0ACgkQ41TmuOI4
ufhujw/9FAZckI4DRKLJlKaQ/lIvvHWsDvqR64Uq0H+XiMovsFaK/TQlrg9sNjt+
gTJvmtk9eqKUnCepyyF09PWBOfdcHku9aOvzY2Fe/y9JJ83lBWMlB0VFvYlxhYT1
OaN/7baX2vF7G6VRm041Lmo9+kbTqN7gpnQGtBDhmyOcYhCwqlWj9E9MHIOge8Cm
SwDevAOS4HkrFi2U0G2HvkqKxztC6myvfQu31CCb9jpw1aq2Ue3ZgyFHqVUfXL96
YkH0W8zDeybv0JnrQPsJLCcEUayRsJQAdZOEykYdKQxmEAhjWS1Y93xTGGKxwonU
w+wfa5+KxU6Md71z3IcDexRIV6COV+bcuH+JvrRJ0nvAxh4q2mzExBO5ZGQuncud
pihVZgHPA77lpu5+T9u42F219frQ6/BBVgD3qFAQZYNl2zICJHeeIIZZZAqyPQYR
2aZWELQqH1fh0igEBO/yHVS/f3ah8XiouaLAJAH9HMyVQqanER8KA4IjiXwcGg4+
eRopeZp2cfFsYcCoMdHVSLp7IxLg75o1PmQ8qTeYwRR7njffgUCpM6xivQXzhMhY
nUCvW3st8L5ulUGRR9SN/gFAlFGPg7Tn96sE1MzQXkHKo69NVsLVnYyDHhB+muC5
ItYVpIhSm96q+uTtUHrcfyxsM7EvhEHyNQ0kfkk3p/xOnguFSZY=
=dP/w
-----END PGP SIGNATURE-----

--15epwzkLUo7Bcf3A4CIC1Q3fDF0gFmu1D--

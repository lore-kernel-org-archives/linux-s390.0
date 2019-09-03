Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20650 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728075AbfICIKs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Sep 2019 04:10:48 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8387QdJ003722
        for <linux-s390@vger.kernel.org>; Tue, 3 Sep 2019 04:10:47 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usjjsurw6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 03 Sep 2019 04:10:46 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 3 Sep 2019 09:10:44 +0100
Subject: Re: [kvm-unit-tests PATCH 4/6] s390x: Add initial smp code
References: <20190829121459.1708-1-frankja@linux.ibm.com>
 <20190829121459.1708-5-frankja@linux.ibm.com>
 <af43e842-9aee-9407-2a97-354efe2b81e1@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 3 Sep 2019 10:10:39 +0200
MIME-Version: 1.0
In-Reply-To: <af43e842-9aee-9407-2a97-354efe2b81e1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uXlTdIJjsz4xcJw1Z8OyWKRgzahkPyoP4"
Message-Id: <997a7035-d6a4-de37-f9fa-2b929632854f@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uXlTdIJjsz4xcJw1Z8OyWKRgzahkPyoP4
Content-Type: multipart/mixed; boundary="VXR9Vdg4gZU8fCCKMGebk29w9c9tXxKju";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <997a7035-d6a4-de37-f9fa-2b929632854f@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH 4/6] s390x: Add initial smp code
References: <20190829121459.1708-1-frankja@linux.ibm.com>
 <20190829121459.1708-5-frankja@linux.ibm.com>
 <af43e842-9aee-9407-2a97-354efe2b81e1@redhat.com>
In-Reply-To: <af43e842-9aee-9407-2a97-354efe2b81e1@redhat.com>

--VXR9Vdg4gZU8fCCKMGebk29w9c9tXxKju
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/2/19 3:21 PM, Thomas Huth wrote:
> On 29/08/2019 14.14, Janosch Frank wrote:
>> Let's add a rudimentary SMP library, which will scan for cpus and has
>> helper functions that manage the cpu state.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  lib/s390x/asm/arch_def.h |   8 ++
>>  lib/s390x/asm/sigp.h     |  29 ++++-
>>  lib/s390x/io.c           |   5 +-
>>  lib/s390x/sclp.h         |   1 +
>>  lib/s390x/smp.c          | 272 ++++++++++++++++++++++++++++++++++++++=
+
>>  lib/s390x/smp.h          |  51 ++++++++
>>  s390x/Makefile           |   1 +
>>  s390x/cstart64.S         |   7 +
>>  8 files changed, 368 insertions(+), 6 deletions(-)
>>  create mode 100644 lib/s390x/smp.c
>>  create mode 100644 lib/s390x/smp.h
>>
>> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
>> index 5f8f45e..d5a7f51 100644
>> --- a/lib/s390x/asm/arch_def.h
>> +++ b/lib/s390x/asm/arch_def.h
>> @@ -157,6 +157,14 @@ struct cpuid {
>>  	uint64_t reserved : 15;
>>  };
>> =20
>> +static inline unsigned short stap(void)
>> +{
>> +	unsigned short cpu_address;
>> +
>> +	asm volatile("stap %0" : "=3DQ" (cpu_address));
>> +	return cpu_address;
>> +}
>> +
>>  static inline int tprot(unsigned long addr)
>>  {
>>  	int cc;
>> diff --git a/lib/s390x/asm/sigp.h b/lib/s390x/asm/sigp.h
>> index fbd94fc..ce85eb7 100644
>> --- a/lib/s390x/asm/sigp.h
>> +++ b/lib/s390x/asm/sigp.h
>> @@ -46,14 +46,33 @@
>> =20
>>  #ifndef __ASSEMBLER__
>> =20
>> -static inline void sigp_stop(void)
>> +
>> +static inline int sigp(uint16_t addr, uint8_t order, unsigned long pa=
rm,
>> +		       uint32_t *status)
>>  {
>> -	register unsigned long status asm ("1") =3D 0;
>> -	register unsigned long cpu asm ("2") =3D 0;
>> +	register unsigned long reg1 asm ("1") =3D parm;
>> +	int cc;
>> =20
>>  	asm volatile(
>> -		"	sigp %0,%1,0(%2)\n"
>> -		: "+d" (status)  : "d" (cpu), "d" (SIGP_STOP) : "cc");
>> +		"	sigp	%1,%2,0(%3)\n"
>> +		"	ipm	%0\n"
>> +		"	srl	%0,28\n"
>> +		: "=3Dd" (cc), "+d" (reg1) : "d" (addr), "a" (order) : "cc");
>> +	if (status)
>> +		*status =3D reg1;
>> +	return cc;
>> +}
>> +
>> +static inline int sigp_retry(uint16_t addr, uint8_t order, unsigned l=
ong parm,
>> +			     uint32_t *status)
>> +{
>> +	int cc;
>> +
>> +retry:
>> +	cc =3D sigp(addr, order, parm, status);
>> +	if (cc =3D=3D 2)
>> +		goto retry;
>=20
> Please change to:
>=20
> 	do {
> 		cc =3D sigp(addr, order, parm, status);
> 	} while (cc =3D=3D 2);

Seems like I've been writing too much assembly lately to write proper
loops :)

>=20
>> +	return cc;
>>  }
>> =20
>>  #endif /* __ASSEMBLER__ */
> [...]
>> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
>> new file mode 100644
>> index 0000000..b1b636a
>> --- /dev/null
>> +++ b/lib/s390x/smp.c
> [...]
>> +int smp_cpu_restart(uint16_t addr)
>> +{
>> +	int rc =3D 0;
>> +	struct cpu *cpu;
>> +
>> +	spin_lock(&lock);
>> +	cpu =3D smp_cpu_from_addr(addr);
>> +	if (!cpu) {
>> +		rc =3D -ENOENT;
>> +		goto out;
>> +	}
>> +
>> +	rc =3D sigp(cpu->addr, SIGP_RESTART, 0, NULL);
>=20
> I think you could use "addr" instead of "cpu->addr" here.

Yes, if it bothers you that much :)

[...]
>> +
>> +int smp_cpu_destroy(uint16_t addr)
>> +{
>> +	struct cpu *cpu;
>> +	int rc =3D 0;
>> +
>> +	spin_lock(&lock);
>> +	rc =3D smp_cpu_stop_nolock(addr, false);
>> +	if (rc)
>> +		goto out;
>> +
>> +	cpu =3D smp_cpu_from_addr(addr);
>> +	free_pages(cpu->lowcore, 2 * PAGE_SIZE);
>> +	free_pages(cpu->stack, 4 * PAGE_SIZE);
>=20
> Maybe do this afterwards to make sure that nobody uses a dangling point=
er:
>=20
> 	cpu->lowcore =3D cpu->stack =3D -1UL;
>=20
> ?

Great idea

>=20
>> +out:
>> +	spin_unlock(&lock);
>> +	return rc;
>> +}
>> +
>> +int smp_cpu_setup(uint16_t addr, struct psw psw)
>> +{
>> +	struct lowcore *lc;
>> +	struct cpu *cpu;
>> +	int rc =3D 0;
>> +
>> +	spin_lock(&lock);
>> +
>> +	if (!cpus) {
>> +		rc =3D -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	cpu =3D smp_cpu_from_addr(addr);
>> +
>> +	if (!cpu) {
>> +		rc =3D -ENOENT;
>> +		goto out;
>> +	}
>> +
>> +	if (cpu->active) {
>> +		rc =3D -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	sigp_retry(cpu->addr, SIGP_INITIAL_CPU_RESET, 0, NULL);
>> +
>> +	lc =3D alloc_pages(1);
>> +	cpu->lowcore =3D lc;
>> +	memset(lc, 0, PAGE_SIZE * 2);
>> +	sigp_retry(cpu->addr, SIGP_SET_PREFIX, (unsigned long )lc, NULL);
>> +
>> +	/* Copy all exception psws. */
>> +	memcpy(lc, cpu0->lowcore, 512);
>> +
>> +	/* Setup stack */
>> +	cpu->stack =3D (uint64_t *)alloc_pages(2);
>> +
>> +	/* Start without DAT and any other mask bits. */
>> +	cpu->lowcore->sw_int_grs[14] =3D psw.addr;
>> +	cpu->lowcore->sw_int_grs[15] =3D (uint64_t)cpu->stack + (PAGE_SIZE *=
 4) / sizeof(cpu->stack);
>=20
> The end-of-stack calculation looks wrong to me. I think you either mean=
t:
>=20
>  ... =3D (uint64_t)(cpu->stack + (PAGE_SIZE * 4) / sizeof(*cpu->stack))=
;
>=20
> or:
>=20
>  ... =3D (uint64_t)cpu->stack + (PAGE_SIZE * 4);

That one

>=20
> ?
>=20
>> +	lc->restart_new_psw.mask =3D 0x0000000180000000UL;
>> +	lc->restart_new_psw.addr =3D (unsigned long)smp_cpu_setup_state;
>=20
> Maybe use "(uint64_t)" instead of "(unsigned long)"?

Sure

>=20
>> +	lc->sw_int_cr0 =3D 0x0000000000040000UL;
>> +
>> +	/* Start processing */
>> +	cpu->active =3D true;
>> +	rc =3D sigp_retry(cpu->addr, SIGP_RESTART, 0, NULL);
>=20
> Should cpu->active only be set to true if rc =3D=3D 0 ?

Yes

>=20
>> +out:
>> +	spin_unlock(&lock);
>> +	return rc;
>> +}
>> +
>> +/*
>> + * Disregarding state, stop all cpus that once were online except for=

>> + * calling cpu.
>> + */
>> +void smp_teardown(void)
>> +{
>> +	int i =3D 0;
>> +	uint16_t this_cpu =3D stap();
>> +	struct ReadCpuInfo *info =3D (void *)cpu_info_buffer;
>> +
>> +	spin_lock(&lock);
>> +	for (; i < info->nr_configured; i++) {
>> +		if (cpus[i].active &&
>> +		    cpus[i].addr !=3D this_cpu) {
>> +			sigp_retry(cpus[i].addr, SIGP_STOP, 0, NULL);
>=20
> Maybe set cpus[i].active =3D false afterwards ?

calloc does a 0 memset
But to mirror the boot cpu case, I added it.

>=20
>> +		}
>> +	}
>> +	spin_unlock(&lock);
>> +}
>=20
>  Thomas
>=20



--VXR9Vdg4gZU8fCCKMGebk29w9c9tXxKju--

--uXlTdIJjsz4xcJw1Z8OyWKRgzahkPyoP4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl1uH/8ACgkQ41TmuOI4
ufhGsg//VfIOJbQGk6PerCMxOtZnMfO34NiggvxwRqjfIOoD619EZGdQ7SPEAwed
cmMe3qE+vzhcgUetgIBUO7o7md8Jh1F4ufeVvYAEg8qguX0h38LBJp4QIJzWFxXg
W2+QfLjXomaBC4Pg6JW69u9q84MMvr+zT+d3MG5Gx2+nLnwCG9OBBovjA9SbXZfc
WSfsx7sI5Q/vA9i+UzZNR5uvvS1TXcBuYXvh/jVQ72SuFGeKz7GXLiIVJJVgGxB2
yhq4BudcDS1bAKSfqDVIiUXS9ajLUGJYHJiMN5fT7+gUw6pDhvwq1Kv5C6pskWCO
nt1Gh49aJkn2GD/LShBD7dMj7uUNP38ILLBaCyGq19CL3+IjUMBXDreK38P2whmL
1WQATCY4UJd/bOXYmsqzttsK8nh6+FmtzekbDk2+od+gSmrg/6qvGbGAe+8qHMyS
Uv/Rv+ifQXRi1SKuEVLxkrqNVvp57E+7bMaxlEhFCf8yIzRzq1rSmLrgghePdjFp
UzDjBVoSDOpvNr0HpovEz4OXM+vTPBL4HGFqc0fpM+0hS6DZvCzq9kd08ufTuMJ9
+c2XzW0vSrd527lYFONyH547Up9A02FJckOViabpEnFb1uf4r1oLYbeXhLSu/92N
frq8CNWyJ6GczuGa6h9/1Ql0g2DLUy4w0r6Houg0ZeqSg0Uf8R0=
=eU5i
-----END PGP SIGNATURE-----

--uXlTdIJjsz4xcJw1Z8OyWKRgzahkPyoP4--

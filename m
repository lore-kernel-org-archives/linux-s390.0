Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19866 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726902AbgA3LSk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jan 2020 06:18:40 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UBEG1g103403
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 06:18:38 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xubct9n8h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 06:18:38 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 30 Jan 2020 11:18:36 -0000
Subject: Re: [PATCH v8 4/4] selftests: KVM: testing the local IRQs resets
References: <20200129200312.3200-1-frankja@linux.ibm.com>
 <20200129200312.3200-5-frankja@linux.ibm.com>
 <20200130115543.1f06a840.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 30 Jan 2020 12:18:31 +0100
MIME-Version: 1.0
In-Reply-To: <20200130115543.1f06a840.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZGNTOLMI7yxLUd8xEEIRDSYw9ufgUN7VD"
Message-Id: <bd7dc770-4613-5af5-e695-aabc70f84c16@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZGNTOLMI7yxLUd8xEEIRDSYw9ufgUN7VD
Content-Type: multipart/mixed; boundary="oVvsTwUOEzZIK0M6YJ8gwPb6HhQluhAtY"

--oVvsTwUOEzZIK0M6YJ8gwPb6HhQluhAtY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/30/20 11:55 AM, Cornelia Huck wrote:
> On Wed, 29 Jan 2020 15:03:12 -0500
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> From: Pierre Morel <pmorel@linux.ibm.com>
>>
>> Local IRQs are reset by a normal cpu reset.  The initial cpu reset and=

>> the clear cpu reset, as superset of the normal reset, both clear the
>> IRQs too.
>>
>> Let's inject an interrupt to a vCPU before calling a reset and see if
>> it is gone after the reset.
>>
>> We choose to inject only an emergency interrupt at this point and can
>> extend the test to other types of IRQs later.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>=20
> You probably should add your s-o-b here as well.
>=20
>> ---
>>  tools/testing/selftests/kvm/s390x/resets.c | 57 +++++++++++++++++++++=
+
>>  1 file changed, 57 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testin=
g/selftests/kvm/s390x/resets.c
>> index 2b2378cc9e80..299c1686f98c 100644
>> --- a/tools/testing/selftests/kvm/s390x/resets.c
>> +++ b/tools/testing/selftests/kvm/s390x/resets.c
>> @@ -14,6 +14,9 @@
>>  #include "kvm_util.h"
>> =20
>>  #define VCPU_ID 3
>> +#define LOCAL_IRQS 32
>=20
> Why 32?
>=20
>> +
>> +struct kvm_s390_irq buf[VCPU_ID + LOCAL_IRQS];
>> =20
>>  struct kvm_vm *vm;
>>  struct kvm_run *run;
>> @@ -52,6 +55,29 @@ static void test_one_reg(uint64_t id, uint64_t valu=
e)
>>  	TEST_ASSERT(eval_reg =3D=3D value, "value =3D=3D %s", value);
>>  }
>> =20
>> +static void assert_noirq(void)
>> +{
>> +	struct kvm_s390_irq_state irq_state;
>> +	int irqs;
>> +
>> +	if (!(kvm_check_cap(KVM_CAP_S390_INJECT_IRQ) &&
>> +	    kvm_check_cap(KVM_CAP_S390_IRQ_STATE)))
>> +		return;
>=20
> Might want to do a
>=20
> irq_introspection_supported =3D (check stuff);
>=20
> once for this test? Works fine as is, of course.
>=20
>> +
>> +	irq_state.len =3D sizeof(buf);
>> +	irq_state.buf =3D (unsigned long)buf;
>> +	irqs =3D _vcpu_ioctl(vm, VCPU_ID, KVM_S390_GET_IRQ_STATE, &irq_state=
);
>> +	/*
>> +	 * irqs contains the number of retrieved interrupts, apart from the
>> +	 * emergency call that should be cleared by the resets, there should=
 be
>> +	 * none.
>=20
> Even if there were any, they should have been cleared by the reset,
> right?

Yes, that's what "there should be none" should actually express.
I added the comment before sending out.

>=20
>> +	 */
>> +	if (irqs < 0)
>> +		printf("Error by getting IRQ: errno %d\n", errno);
>=20
> "Error getting pending IRQs" ?

"Could not fetch IRQs: errno %d\n" ?

>=20
>> +
>> +	TEST_ASSERT(!irqs, "IRQ pending");
>> +}
>> +
>>  static void assert_clear(void)
>>  {
>>  	struct kvm_sregs sregs;
>> @@ -93,6 +119,31 @@ static void assert_initial(void)
>>  static void assert_normal(void)
>>  {
>>  	test_one_reg(KVM_REG_S390_PFTOKEN, KVM_S390_PFAULT_TOKEN_INVALID);
>> +	assert_noirq();
>> +}
>> +
>> +static int inject_irq(int cpu_id)
>=20
> You never seem to check the return code.
>=20
>> +{
>> +	struct kvm_s390_irq_state irq_state;
>> +	struct kvm_s390_irq *irq =3D &buf[0];
>> +	int irqs;
>> +
>> +	if (!(kvm_check_cap(KVM_CAP_S390_INJECT_IRQ) &&
>> +	    kvm_check_cap(KVM_CAP_S390_IRQ_STATE)))
>> +		return 0;
>> +
>> +	/* Inject IRQ */
>> +	irq_state.len =3D sizeof(struct kvm_s390_irq);
>> +	irq_state.buf =3D (unsigned long)buf;
>> +	irq->type =3D KVM_S390_INT_EMERGENCY;
>> +	irq->u.emerg.code =3D cpu_id;
>> +	irqs =3D _vcpu_ioctl(vm, cpu_id, KVM_S390_SET_IRQ_STATE, &irq_state)=
;
>> +	if (irqs < 0) {
>> +		printf("Error by injecting INT_EMERGENCY: errno %d\n", errno);
>=20
> "Error injecting EMERGENCY IRQ" ?

Sounds good

>=20
>> +		return errno;
>> +	}
>> +
>> +	return 0;
>>  }
>> =20
>>  static void test_normal(void)
>> @@ -105,6 +156,8 @@ static void test_normal(void)
>> =20
>>  	_vcpu_run(vm, VCPU_ID);
>> =20
>> +	inject_irq(VCPU_ID);
>> +
>>  	vcpu_ioctl(vm, VCPU_ID, KVM_S390_NORMAL_RESET, 0);
>>  	assert_normal();
>>  	kvm_vm_free(vm);
>> @@ -122,6 +175,8 @@ static int test_initial(void)
>> =20
>>  	rv =3D _vcpu_run(vm, VCPU_ID);
>> =20
>> +	inject_irq(VCPU_ID);
>> +
>>  	vcpu_ioctl(vm, VCPU_ID, KVM_S390_INITIAL_RESET, 0);
>>  	assert_normal();
>>  	assert_initial();
>> @@ -141,6 +196,8 @@ static int test_clear(void)
>> =20
>>  	rv =3D _vcpu_run(vm, VCPU_ID);
>> =20
>> +	inject_irq(VCPU_ID);
>> +
>>  	vcpu_ioctl(vm, VCPU_ID, KVM_S390_CLEAR_RESET, 0);
>>  	assert_normal();
>>  	assert_initial();
>=20
> On the whole, looks good to me.
>=20



--oVvsTwUOEzZIK0M6YJ8gwPb6HhQluhAtY--

--ZGNTOLMI7yxLUd8xEEIRDSYw9ufgUN7VD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4yu4gACgkQ41TmuOI4
ufjRRA/9EkqOS9xDYfbsJCh/Ijpj0T9uj/ZB4uHUv3KlVp7nr8qBmeweOvmD10RB
PcHR8q5Vej/Kf78sZWXE9e57oSkab7/p00dtQPAOfjV/odmODD72Pltbo6aaPAzT
3P+q30ygkOVr/yAOUQs5bCCOI1O3cXF8+PKIWmn8L1BwlLelayxoVxSWvPqtUPEN
OA/Pg3wn5L1K6Ov/4y4y7F3E3XsySoq16cRh1mZ3+ArYfmgv3N+9lFe/jSweKgHD
42xSrTAWy7pWYcQ1dYGLLHwxDCYU7eddN9jOzAfwT21leXfGj1ad/G/YmIJR5Idx
DGgtKNzbPhqj73bwcpWImBqC+vvuBJIaNPrr+McLpn9IglW3DfTY6aPi/XgGvlWp
4+b75UFFZRosCOgVBONjZoAk5Ahuqo3g/cRPkxlisZSSjrGYoO4CbO2MTpFfCrjO
zQjtxpfGWPhP2FIwT87+Jo5DjnOF6cesm/9e3pRhxgxuLtt/NVyg6FHvmdQ+T8Pk
cQOaPPMSCd5H++9Apor/v/zgNkvjEBQonwyGl7uOI61vuK2g4E8YDn/+iG3LMAuC
K6d0QD4IQ5sW/s9SerueLKHHTXdxfFCyaRnatRBJaoXrqwtlLIRyqMNwzE+mD7Bz
i5dudrJrIKh6jTnjkuDhZtpuiWeDMR4Cp/2SV/oP/iiq2He6rQA=
=RFu9
-----END PGP SIGNATURE-----

--ZGNTOLMI7yxLUd8xEEIRDSYw9ufgUN7VD--

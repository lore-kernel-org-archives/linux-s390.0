Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28708 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727036AbgA3LdJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jan 2020 06:33:09 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UBNnvO024734
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 06:33:08 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xu5q66tg7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 06:33:08 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 30 Jan 2020 11:33:06 -0000
Subject: Re: [PATCH v8 4/4] selftests: KVM: testing the local IRQs resets
References: <20200129200312.3200-1-frankja@linux.ibm.com>
 <20200129200312.3200-5-frankja@linux.ibm.com>
 <a9fd8939-503e-bf11-7f5e-bb83a79a1bf9@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 30 Jan 2020 12:33:00 +0100
MIME-Version: 1.0
In-Reply-To: <a9fd8939-503e-bf11-7f5e-bb83a79a1bf9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DGrWTHLfQc3psSj5x8Y8XRQnJsi3gXgi4"
Message-Id: <cf61103b-86b0-5bc2-51a2-46ff6485c632@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DGrWTHLfQc3psSj5x8Y8XRQnJsi3gXgi4
Content-Type: multipart/mixed; boundary="kVu9UrRZ7yB5bsQzRiige4JyIPQv9Levn"

--kVu9UrRZ7yB5bsQzRiige4JyIPQv9Levn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/30/20 12:10 PM, Thomas Huth wrote:
> On 29/01/2020 21.03, Janosch Frank wrote:
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
>> +	 */
>> +	if (irqs < 0)
>> +		printf("Error by getting IRQ: errno %d\n", errno);
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
>> +		return errno;
>> +	}
>=20
> Can you turn this into a TEST_ASSERT() instead? Otherwise the printf()
> error might go unnoticed.

I've converted both error checks into asserts (set/get irq) and made the
function void.


>=20
> Apart from that (and the nits that Cornelia already mentioned), the
> patch looks fine to me.
>=20
>  Thomas
>=20



--kVu9UrRZ7yB5bsQzRiige4JyIPQv9Levn--

--DGrWTHLfQc3psSj5x8Y8XRQnJsi3gXgi4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4yvuwACgkQ41TmuOI4
ufgszA/+Jcbj2JR9uFmPxNi7uBD83MYOr1fJXmEMpOeMchd0vfpPIkb5Hbh9WbYD
N4Qrw6tqZZEQU8IYdMra9RAzUgMyZWLkrDMp/BQzGwSX/GcwYzdlmUrXxISo2a4g
A+m9ua07x0PxxEm8b9TztcY8B30rQutKQZMgVXGBpeLtkRgF25qggx8GXW6CWAy6
BZTinrczp7ZQICtKWxrEtur3z59azZOdduaII3xa9tlvYKf26b870I7n5kXUUNxk
GKxWQBdTFgshXgbszfn4iqf+loVTRbDb2JW8E8r7S6J4Dpw3C8gMKYqqzm9cfRz+
hKwIIvFhy7iqts03oZTgUFTuEc6zrijIH2L9f9YNVlHqfHCjCtpy1NtROqTCImjL
raCmvr9U2h8DTPPtJZhdBAhCYtI8YL4a+G3Zjnq/MNQmrC0tI+oZN8FermTfyGM5
Kxr1jChgNptPp4EDOnzPRkcHfQRw8Ql6JvZlj94SkDWU2cqRU4Ml4B01jkTuYGeW
4P6ZEHxIO2UrRP/FIKiP0ysdnpydT9NoGUAhIL29MhyXyXKCmpo0U0/wMuNpG+7o
01sQ3iV8BBuKrW85rgtfhgg+afg3XqaIqc2jHNMUIUgJwgpjOmikWqwIV293fSIK
fmnFOKf2lLH3f7MOvjSQacfJQOJDCsEN9UCAiQpOWuTgWBfNHcA=
=MHpG
-----END PGP SIGNATURE-----

--DGrWTHLfQc3psSj5x8Y8XRQnJsi3gXgi4--

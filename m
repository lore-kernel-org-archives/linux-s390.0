Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20300 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726873AbgA3KwI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jan 2020 05:52:08 -0500
Subject: Re: [PATCH v8 3/4] selftests: KVM: s390x: Add reset tests
References: <20200129200312.3200-1-frankja@linux.ibm.com>
 <20200129200312.3200-4-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e0f72503-d292-edc4-67e1-abe1cbab3f96@redhat.com>
Date: Thu, 30 Jan 2020 11:51:42 +0100
MIME-Version: 1.0
In-Reply-To: <20200129200312.3200-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 29/01/2020 21.03, Janosch Frank wrote:
> Test if the registers end up having the correct values after a normal,
> initial and clear reset.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  tools/testing/selftests/kvm/Makefile       |   1 +
>  tools/testing/selftests/kvm/s390x/resets.c | 165 +++++++++++++++++++++
>  2 files changed, 166 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/s390x/resets.c
>=20
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selft=
ests/kvm/Makefile
> index 3138a916574a..fe1ea294730c 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -36,6 +36,7 @@ TEST_GEN_PROGS_aarch64 +=3D kvm_create_max_vcpus
> =20
>  TEST_GEN_PROGS_s390x =3D s390x/memop
>  TEST_GEN_PROGS_s390x +=3D s390x/sync_regs_test
> +TEST_GEN_PROGS_s390x +=3D s390x/resets
>  TEST_GEN_PROGS_s390x +=3D dirty_log_test
>  TEST_GEN_PROGS_s390x +=3D kvm_create_max_vcpus
> =20
> diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testing=
/selftests/kvm/s390x/resets.c
> new file mode 100644
> index 000000000000..2b2378cc9e80
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/s390x/resets.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Test for s390x CPU resets
> + *
> + * Copyright (C) 2020, IBM
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +
> +#define VCPU_ID 3
> +
> +struct kvm_vm *vm;
> +struct kvm_run *run;
> +struct kvm_sync_regs *regs;
> +static uint64_t regs_null[16];
> +
> +static uint64_t crs[16] =3D { 0x40000ULL,
> +			    0x42000ULL,
> +			    0, 0, 0, 0, 0,
> +			    0x43000ULL,
> +			    0, 0, 0, 0, 0,
> +			    0x44000ULL,
> +			    0, 0
> +};
> +
> +static void guest_code_initial(void)
> +{
> +	/* Round toward 0 */
> +	uint32_t fpc =3D 0x11;
> +
> +	/* Dirty registers */
> +	asm volatile (
> +		"	lctlg	0,15,%0\n"
> +		"	sfpc	%1\n"
> +		: : "Q" (crs), "d" (fpc));

I'd recommend to add a GUEST_SYNC(0) here ... otherwise the guest code
tries to return from this function and will cause a crash - which will
also finish execution of the guest, but might have unexpected side effect=
s.

> +}
> +
> +static void test_one_reg(uint64_t id, uint64_t value)
> +{
> +	struct kvm_one_reg reg;
> +	uint64_t eval_reg;
> +
> +	reg.addr =3D (uintptr_t)&eval_reg;
> +	reg.id =3D id;
> +	vcpu_get_reg(vm, VCPU_ID, &reg);
> +	TEST_ASSERT(eval_reg =3D=3D value, "value =3D=3D %s", value);
> +}
> +
> +static void assert_clear(void)
> +{
> +	struct kvm_sregs sregs;
> +	struct kvm_regs regs;
> +	struct kvm_fpu fpu;
> +
> +	vcpu_regs_get(vm, VCPU_ID, &regs);
> +	TEST_ASSERT(!memcmp(&regs.gprs, regs_null, sizeof(regs.gprs)), "grs =3D=
=3D 0");
> +
> +	vcpu_sregs_get(vm, VCPU_ID, &sregs);
> +	TEST_ASSERT(!memcmp(&sregs.acrs, regs_null, sizeof(sregs.acrs)), "acr=
s =3D=3D 0");
> +
> +	vcpu_fpu_get(vm, VCPU_ID, &fpu);
> +	TEST_ASSERT(!memcmp(&fpu.fprs, regs_null, sizeof(fpu.fprs)), "fprs =3D=
=3D 0");
> +}
> +
> +static void assert_initial(void)
> +{
> +	struct kvm_sregs sregs;
> +	struct kvm_fpu fpu;
> +
> +	vcpu_sregs_get(vm, VCPU_ID, &sregs);
> +	TEST_ASSERT(sregs.crs[0] =3D=3D 0xE0UL, "cr0 =3D=3D 0xE0");
> +	TEST_ASSERT(sregs.crs[14] =3D=3D 0xC2000000UL, "cr14 =3D=3D 0xC200000=
0");
> +	TEST_ASSERT(!memcmp(&sregs.crs[1], regs_null, sizeof(sregs.crs[1]) * =
12),
> +		    "cr1-13 =3D=3D 0");
> +	TEST_ASSERT(sregs.crs[15] =3D=3D 0, "cr15 =3D=3D 0");
> +
> +	vcpu_fpu_get(vm, VCPU_ID, &fpu);
> +	TEST_ASSERT(!fpu.fpc, "fpc =3D=3D 0");
> +
> +	test_one_reg(KVM_REG_S390_GBEA, 1);
> +	test_one_reg(KVM_REG_S390_PP, 0);
> +	test_one_reg(KVM_REG_S390_TODPR, 0);
> +	test_one_reg(KVM_REG_S390_CPU_TIMER, 0);
> +	test_one_reg(KVM_REG_S390_CLOCK_COMP, 0);
> +}
> +
> +static void assert_normal(void)
> +{
> +	test_one_reg(KVM_REG_S390_PFTOKEN, KVM_S390_PFAULT_TOKEN_INVALID);
> +}
> +
> +static void test_normal(void)
> +{
> +	printf("Testing notmal reset\n");
> +	/* Create VM */
> +	vm =3D vm_create_default(VCPU_ID, 0, guest_code_initial);
> +	run =3D vcpu_state(vm, VCPU_ID);
> +	regs =3D &run->s.regs;
> +
> +	_vcpu_run(vm, VCPU_ID);

Could you use vcpu_run() instead of _vcpu_run() ?

> +	vcpu_ioctl(vm, VCPU_ID, KVM_S390_NORMAL_RESET, 0);
> +	assert_normal();
> +	kvm_vm_free(vm);
> +}
> +
> +static int test_initial(void)
> +{
> +	int rv;
> +
> +	printf("Testing initial reset\n");
> +	/* Create VM */
> +	vm =3D vm_create_default(VCPU_ID, 0, guest_code_initial);
> +	run =3D vcpu_state(vm, VCPU_ID);
> +	regs =3D &run->s.regs;
> +
> +	rv =3D _vcpu_run(vm, VCPU_ID);

Extra bonus points if you check here that the registers contain the
values that have been set by the guest ;-)

> +	vcpu_ioctl(vm, VCPU_ID, KVM_S390_INITIAL_RESET, 0);
> +	assert_normal();
> +	assert_initial();
> +	kvm_vm_free(vm);
> +	return rv;
> +}
> +
> +static int test_clear(void)
> +{
> +	int rv;
> +
> +	printf("Testing clear reset\n");
> +	/* Create VM */
> +	vm =3D vm_create_default(VCPU_ID, 0, guest_code_initial);
> +	run =3D vcpu_state(vm, VCPU_ID);
> +	regs =3D &run->s.regs;
> +
> +	rv =3D _vcpu_run(vm, VCPU_ID);
> +
> +	vcpu_ioctl(vm, VCPU_ID, KVM_S390_CLEAR_RESET, 0);
> +	assert_normal();
> +	assert_initial();
> +	assert_clear();
> +	kvm_vm_free(vm);
> +	return rv;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int addl_resets;
> +
> +	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
> +	addl_resets =3D kvm_check_cap(KVM_CAP_S390_VCPU_RESETS);
> +
> +	test_initial();
> +	if (addl_resets) {

I think you could still fit this into one line, without the need to
declare the addl_resets variable:

	if (kvm_check_cap(KVM_CAP_S390_VCPU_RESETS)) {

> +		test_normal();
> +		test_clear();
> +	}
> +	return 0;
> +}

Apart from the nits, this looks pretty good already, thanks for putting
it together!

 Thomas

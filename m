Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48744 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725843AbgAXIiO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Jan 2020 03:38:14 -0500
Subject: Re: [kvm-unit-tests PATCH v4 2/9] s390x: smp: Only use smp_cpu_setup
 once
From: David Hildenbrand <david@redhat.com>
References: <20200121134254.4570-1-frankja@linux.ibm.com>
 <20200121134254.4570-3-frankja@linux.ibm.com>
 <ef7894ff-4179-6730-ce28-c48e7730eff8@redhat.com>
 <e09c42a7-279a-7e8b-8241-26c69940cdd0@linux.ibm.com>
 <9a17ce2d-bfce-0a1f-dfa7-3d798af4d5ab@redhat.com>
 <b16cbc73-20b2-4955-52a7-1b133aa33cc4@redhat.com>
Message-ID: <8deec98c-d384-bc2e-2790-7b47fcfd2d62@redhat.com>
Date: Fri, 24 Jan 2020 09:38:06 +0100
MIME-Version: 1.0
In-Reply-To: <b16cbc73-20b2-4955-52a7-1b133aa33cc4@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

On 24.01.20 09:28, David Hildenbrand wrote:
> On 23.01.20 14:56, David Hildenbrand wrote:
>> On 23.01.20 14:54, Janosch Frank wrote:
>>> On 1/23/20 2:45 PM, David Hildenbrand wrote:
>>>> On 21.01.20 14:42, Janosch Frank wrote:
>>>>> Let's stop and start instead of using setup to run a function on a
>>>>> cpu.
>>>>>
>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>>> ---
>>>>>  s390x/smp.c | 21 ++++++++++++++-------
>>>>>  1 file changed, 14 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/s390x/smp.c b/s390x/smp.c
>>>>> index e37eb56..3e8cf3e 100644
>>>>> --- a/s390x/smp.c
>>>>> +++ b/s390x/smp.c
>>>>> @@ -53,7 +53,7 @@ static void test_start(void)
>>>>>  	psw.addr =3D (unsigned long)test_func;
>>>>> =20
>>>>>  	set_flag(0);
>>>>> -	smp_cpu_setup(1, psw);
>>>>> +	smp_cpu_start(1, psw);
>>>>>  	wait_for_flag();
>>>>>  	report(1, "start");
>>>>>  }
>>>>> @@ -109,6 +109,7 @@ static void test_store_status(void)
>>>>>  	report(1, "status written");
>>>>>  	free_pages(status, PAGE_SIZE * 2);
>>>>>  	report_prefix_pop();
>>>>> +	smp_cpu_stop(1);
>>>>> =20
>>>>>  	report_prefix_pop();
>>>>>  }
>>>>> @@ -137,9 +138,8 @@ static void test_ecall(void)
>>>>> =20
>>>>>  	report_prefix_push("ecall");
>>>>>  	set_flag(0);
>>>>> -	smp_cpu_destroy(1);
>>>>> =20
>>>>> -	smp_cpu_setup(1, psw);
>>>>> +	smp_cpu_start(1, psw);
>>>>>  	wait_for_flag();
>>>>>  	set_flag(0);
>>>>>  	sigp(1, SIGP_EXTERNAL_CALL, 0, NULL);
>>>>> @@ -172,9 +172,8 @@ static void test_emcall(void)
>>>>> =20
>>>>>  	report_prefix_push("emcall");
>>>>>  	set_flag(0);
>>>>> -	smp_cpu_destroy(1);
>>>>> =20
>>>>> -	smp_cpu_setup(1, psw);
>>>>> +	smp_cpu_start(1, psw);
>>>>>  	wait_for_flag();
>>>>>  	set_flag(0);
>>>>>  	sigp(1, SIGP_EMERGENCY_SIGNAL, 0, NULL);
>>>>> @@ -192,7 +191,7 @@ static void test_reset_initial(void)
>>>>>  	psw.addr =3D (unsigned long)test_func;
>>>>> =20
>>>>>  	report_prefix_push("reset initial");
>>>>> -	smp_cpu_setup(1, psw);
>>>>> +	smp_cpu_start(1, psw);
>>>>> =20
>>>>>  	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
>>>>>  	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
>>>>> @@ -223,7 +222,7 @@ static void test_reset(void)
>>>>>  	psw.addr =3D (unsigned long)test_func;
>>>>> =20
>>>>>  	report_prefix_push("cpu reset");
>>>>> -	smp_cpu_setup(1, psw);
>>>>> +	smp_cpu_start(1, psw);
>>>>> =20
>>>>>  	sigp_retry(1, SIGP_CPU_RESET, 0, NULL);
>>>>>  	report(smp_cpu_stopped(1), "cpu stopped");
>>>>> @@ -232,6 +231,7 @@ static void test_reset(void)
>>>>> =20
>>>>>  int main(void)
>>>>>  {
>>>>> +	struct psw psw;
>>>>>  	report_prefix_push("smp");
>>>>> =20
>>>>>  	if (smp_query_num_cpus() =3D=3D 1) {
>>>>> @@ -239,6 +239,12 @@ int main(void)
>>>>>  		goto done;
>>>>>  	}
>>>>> =20
>>>>> +	/* Setting up the cpu to give it a stack and lowcore */
>>>>> +	psw.mask =3D extract_psw_mask();
>>>>> +	psw.addr =3D (unsigned long)cpu_loop;
>>>>> +	smp_cpu_setup(1, psw);
>>>>> +	smp_cpu_stop(1);
>>>>> +
>>>>>  	test_start();
>>>>>  	test_stop();
>>>>>  	test_stop_store_status();
>>>>> @@ -247,6 +253,7 @@ int main(void)
>>>>>  	test_emcall();
>>>>>  	test_reset();
>>>>>  	test_reset_initial();
>>>>> +	smp_cpu_destroy(1);
>>>>> =20
>>>>>  done:
>>>>>  	report_prefix_pop();
>>>>>
>>>>
>>>> With this patch, I get timeouts under TCG. Seems to loop forever.
>>>>
>>> The branch works on lpar and kvm without a problem.
>>
>> Which could mean that either TCG is broken or your test is broken (e.g=
.,
>> a race condition that does not trigger under LPAR because it's faster,
>> or some undocumented/not guaranteed behavior).
>>
>=20
> So, the test works every now and then under TCG.
>=20
> It seems to work very reliably with "-smp 2"
>=20
> With smp 8, it sometimes works, sometimes not.
>=20
> t480s: ~/git/kvm-unit-tests (kein Branch, Rebase von s390x-prep) $
> ./s390x-run s390x/smp.elf -smp 8
> /home/dhildenb/git/qemu/s390x-softmmu/qemu-system-s390x -nodefaults
> -nographic -machine s390-ccw-virtio,accel=3Dtcg -chardev stdio,id=3Dcon=
0
> -device sclpconsole,chardev=3Dcon0 -kernel s390x/smp.elf -smp 8 # -init=
rd
> /tmp/tmp.UL9ZaqoKBW
> SMP: Initializing, found 8 cpus
> PASS: smp: start
> PASS: smp: stop
> PASS: smp: stop store status: prefix
> PASS: smp: stop store status: stack
> PASS: smp: store status at address: running: incorrect state
> PASS: smp: store status at address: running: status not written
> PASS: smp: store status at address: stopped: status written
> PASS: smp: ecall: ecall
> PASS: smp: emcall: ecall
> PASS: smp: cpu reset: cpu stopped
> PASS: smp: reset initial: clear: psw
> PASS: smp: reset initial: clear: prefix
> PASS: smp: reset initial: clear: fpc
> PASS: smp: reset initial: clear: cpu timer
> PASS: smp: reset initial: clear: todpr
> PASS: smp: reset initial: initialized: cr0 =3D=3D 0xE0
> PASS: smp: reset initial: initialized: cr14 =3D=3D 0xC2000000
> PASS: smp: reset initial: cpu stopped
> SUMMARY: 18 tests
>=20
> EXIT: STATUS=3D1
>=20
> t480s: ~/git/kvm-unit-tests (kein Branch, Rebase von s390x-prep) $
> ./s390x-run s390x/smp.elf -smp 8
> /home/dhildenb/git/qemu/s390x-softmmu/qemu-system-s390x -nodefaults
> -nographic -machine s390-ccw-virtio,accel=3Dtcg -chardev stdio,id=3Dcon=
0
> -device sclpconsole,chardev=3Dcon0 -kernel s390x/smp.elf -smp 8 # -init=
rd
> /tmp/tmp.csifrEDgnC
> SMP: Initializing, found 8 cpus
> PASS: smp: start
> PASS: smp: stop
> PASS: smp: stop store status: prefix
> FAIL: smp: stop store status: stack
> PASS: smp: store status at address: running: incorrect state
> PASS: smp: store status at address: running: status not written
> PASS: smp: store status at address: stopped: status written
> [... hang]
>=20
>=20
> Note that there is a previous failure for "smp: stop store status:
> stack" whenever the test will hang later.
>=20
>=20

In smp_cpu_stop_nolock(), when you do a SIGP_STOP_AND_STORE_STATUS, you
wait until the target CPU is stopped.

This does, however, not guarantee that the state has already been stored
- especially not if the target CPU is already stopped.

Stop and Store Status
The addressed CPU performs the stop function, fol-
lowed by the store-status operation (see =93Store Sta-
tus=94 on page 4-82). The CPU does not necessarily
complete the operation, or even enter the stopped
state, during the execution of SIGNAL PROCES-
SOR ..."

So there is a race in your code. I do wonder how you can test if the
order on the target CPU has been executed, without issuing another SIGP
operation (e.g., restart) or by testing if the content to be stored was
all changed ...

--=20
Thanks,

David / dhildenb

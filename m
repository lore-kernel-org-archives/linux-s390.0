Return-Path: <linux-kselftest-owner@vger.kernel.org>
Subject: Re: [PATCH 1/2] KVM: selftests: Implement ucall() for s390x
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-2-thuth@redhat.com>
 <20190730104807.7uzuvd52foybakgu@kamzik.brq.redhat.com>
 <d9cb3c86-6390-3803-f2c6-d47f5c24139f@redhat.com>
 <20190731102849.x26rdan7cddmpvhe@kamzik.brq.redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0c38beb7-7383-a7ac-13d4-9d4bde4a21bb@redhat.com>
Date: Wed, 31 Jul 2019 13:16:31 +0200
MIME-Version: 1.0
In-Reply-To: <20190731102849.x26rdan7cddmpvhe@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Jones <drjones@redhat.com>
Cc: kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>

On 31/07/2019 12.28, Andrew Jones wrote:
> On Wed, Jul 31, 2019 at 11:43:16AM +0200, Thomas Huth wrote:
>> On 30/07/2019 12.48, Andrew Jones wrote:
>>> On Tue, Jul 30, 2019 at 12:01:11PM +0200, Thomas Huth wrote:
>>>> On s390x, we can neither exit via PIO nor MMIO, but have to use
>>>> an instruction like DIAGNOSE. While we're at it, rename UCALL_PIO
>>>> to UCALL_DEFAULT, since PIO only works on x86 anyway, and this
>>>> way we can re-use the "default" type for the DIAGNOSE exit on s390x.
>>>>
>>>> Now that ucall() is implemented, we can use it in the sync_reg_test
>>>> on s390x, too.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  .../testing/selftests/kvm/include/kvm_util.h  |  2 +-
>>>>  tools/testing/selftests/kvm/lib/ucall.c       | 34 +++++++++++++++----
>>>>  .../selftests/kvm/s390x/sync_regs_test.c      |  6 ++--
>>>>  3 files changed, 32 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
>>>> index e0e66b115ef2..c37aea2e33e5 100644
>>>> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>>>> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
>>>> @@ -167,7 +167,7 @@ int vm_create_device(struct kvm_vm *vm, struct kvm_create_device *cd);
>>>>  
>>>>  /* ucall implementation types */
>>>>  typedef enum {
>>>> -	UCALL_PIO,
>>>> +	UCALL_DEFAULT,
>>>
>>> I'd rather we keep explicit types defined; keep PIO and add DIAG. Then
>>> we can have
>>>
>>> /*  Set default ucall types */
>>> #if defined(__x86_64__)
>>>   ucall_type = UCALL_PIO;
>>> #elif defined(__aarch64__)
>>>   ucall_type = UCALL_MMIO;
>>>   ucall_requires_init = true;
>>> #elif defined(__s390x__)
>>>   ucall_type = UCALL_DIAG;
>>> #endif
>>>
>>> And add an assert in get_ucall()
>>>
>>>  assert(!ucall_requires_init || ucall_initialized);
>>
>> I'm not sure whether I really like that. It's yet another additional
>> #ifdef block, and yet another variable ...
>>
>> What do you think about removing the enum completely and simply code it
>> directly, without the ucall_type indirection, i.e.:
>>
>> void ucall(uint64_t cmd, int nargs, ...)
>> {
>> 	struct ucall uc = {
>> 		.cmd = cmd,
>> 	};
>> 	va_list va;
>> 	int i;
>>
>> 	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
>>
>> 	va_start(va, nargs);
>> 	for (i = 0; i < nargs; ++i)
>> 		uc.args[i] = va_arg(va, uint64_t);
>> 	va_end(va);
>>
>> #if defined(__x86_64__)
>>
>> 	/* Exit via PIO */
>> 	asm volatile("in %[port], %%al"
>> 		: : [port] "d" (UCALL_PIO_PORT), "D" (&uc) : "rax");
>>
>> #elif defined(__aarch64__)
>>
>> 	*ucall_exit_mmio_addr = (vm_vaddr_t)&uc;
>>
>> #elif defined(__s390x__)
>>
>> 	/* Exit via DIAGNOSE 0x501 (normally used for breakpoints) */
>> 	asm volatile ("diag 0,%0,0x501" : : "a"(&uc) : "memory");
>>
>> #endif
>> }
>>
>> I think that's way less confusing than having to understand the meaning
>> of ucall_type etc. before...?
>>
> 
> Sounds good to me.

Or maybe even better: Let's move this file into lib/x86_64/ and
lib/aarch64/ instead, since there is more different code between the
architectures here than common code.

 Thomas

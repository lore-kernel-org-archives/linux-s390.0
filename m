Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725870AbgK3Mnb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Nov 2020 07:43:31 -0500
Subject: Re: [kvm-unit-tests PATCH v2 5/7] s390x: sie: Add first SIE test
References: <20201127130629.120469-1-frankja@linux.ibm.com>
 <20201127130629.120469-6-frankja@linux.ibm.com>
 <20201130114532.6fea10ac.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <e312e141-5cee-9e4d-9e2c-d4770e77473d@linux.ibm.com>
Date: Mon, 30 Nov 2020 13:42:44 +0100
MIME-Version: 1.0
In-Reply-To: <20201130114532.6fea10ac.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, linux-s390@vger.kernel.org

On 11/30/20 11:45 AM, Cornelia Huck wrote:
> On Fri, 27 Nov 2020 08:06:27 -0500
> Janosch Frank <frankja@linux.ibm.com> wrote:
> 
>> Let's check if we get the correct interception data on a few
>> diags. This commit is more of an addition of boilerplate code than a
>> real test.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  s390x/Makefile      |   1 +
>>  s390x/sie.c         | 125 ++++++++++++++++++++++++++++++++++++++++++++
>>  s390x/unittests.cfg |   3 ++
>>  3 files changed, 129 insertions(+)
>>  create mode 100644 s390x/sie.c
>>
> 
> (...)
> 
>> +static void sie(struct vm *vm)
>> +{
>> +	while (vm->sblk->icptcode == 0) {
>> +		sie64a(vm->sblk, &vm->save_area);
>> +		if (vm->sblk->icptcode == 32)
> 
> Can you maybe add #defines for the intercept codes you're checking for?

Sure ICTP_VALIDITY and ICPT_INSTRUCTION would make sense.

> 
>> +		    handle_validity(vm);
>> +	}
>> +	vm->save_area.guest.grs[14] = vm->sblk->gg14;
>> +	vm->save_area.guest.grs[15] = vm->sblk->gg15;
>> +}
>> +
>> +static void sblk_cleanup(struct vm *vm)
>> +{
>> +	vm->sblk->icptcode = 0;
>> +}
>> +
>> +static void intercept_diag_10(void)
>> +{
>> +	u32 instr = 0x83020010;
>> +
>> +	vm.sblk->gpsw.addr = PAGE_SIZE * 2;
>> +	vm.sblk->gpsw.mask = 0x0000000180000000ULL;
>> +
>> +	memset(guest_instr, 0, PAGE_SIZE);
>> +	memcpy(guest_instr, &instr, 4);
>> +	sie(&vm);
>> +	report(vm.sblk->icptcode == 4 && vm.sblk->ipa == 0x8302 && vm.sblk->ipb == 0x100000,
> 
> Again, some #defines might help here, making clear that 0x8302 means
> diag. (The ipb value is clear enough :) Maybe you can also assemble
> instr out of pre-made pieces? Or factor out some code to a common
> function?

Yes, a diag test function that has the code as a parameter would make
this look nicer and I could also test ipa against the first 16bits of instr.

> 
>> +	       "Diag 10 intercept");
>> +	sblk_cleanup(&vm);
>> +}
>> +
>> +static void intercept_diag_44(void)
>> +{
>> +	u32 instr = 0x83020044;
>> +
>> +	vm.sblk->gpsw.addr = PAGE_SIZE * 2;
>> +	vm.sblk->gpsw.mask = 0x0000000180000000ULL;
>> +
>> +	memset(guest_instr, 0, PAGE_SIZE);
>> +	memcpy(guest_instr, &instr, 4);
>> +	sie(&vm);
>> +	report(vm.sblk->icptcode == 4 && vm.sblk->ipa == 0x8302 && vm.sblk->ipb == 0x440000,
>> +	       "Diag 44 intercept");
>> +	sblk_cleanup(&vm);
>> +}
>> +
>> +static void intercept_diag_9c(void)
>> +{
>> +	u32 instr = 0x8302009c;
>> +
>> +	vm.sblk->gpsw.addr = PAGE_SIZE * 2;
>> +	vm.sblk->gpsw.mask = 0x0000000180000000ULL;
>> +
>> +	memset(guest_instr, 0, PAGE_SIZE);
>> +	memcpy(guest_instr, &instr, 4);
>> +	sie(&vm);
>> +	report(vm.sblk->icptcode == 4 && vm.sblk->ipa == 0x8302 && vm.sblk->ipb == 0x9c0000,
>> +	       "Diag 9c intercept");
>> +	sblk_cleanup(&vm);
>> +}
> 
> (...)
> 

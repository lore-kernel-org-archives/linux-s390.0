From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 02 Mar 2015 19:51:45 +0000
Subject: Re: sigsegv/sigbus not setting si_addr correctly for insn faults
Message-Id: <54F4BF51.2010504@de.ibm.com>
In-Reply-To: <20150302171835.GI8519@vapier>
References: <20150302171835.GI8519@vapier>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Am 02.03.2015 um 18:18 schrieb Mike Frysinger:
> On 02 Mar 2015 09:56, Christian Borntraeger wrote:
>> Am 28.02.2015 um 22:24 schrieb Mike Frysinger:
>>> when running strace tests, we noticed that si_addr appears to be wrong.  the 
>>> attached test shows the problem -- si_addr isn't set to the faulting address.
>>>
>>> i hacked arch/s390/mm/fault.c:do_sigsegv to load regs->psw.addr (sans mask),
>>> and it worked for insn based crashes.  but obviously that doesn't work for
>>> data based ones.  i'm not familiar with how regs->int_parm_long works though,
>>> so maybe it's supposed to be loaded indirectly.  the use of __FAIL_ADDR_MASK
>>> blindly is most certainly incorrect ...
>>>
>>> whatever the fix, do_sigbus probably needs it too.
>>
>> The problem is that all faults on s390 give the address only on page
>> granularity (HW-wise)
>> e.g. if you use 0x123456 as fail address you get si_addr == 0x123000
> 
> can't you detect when the fault is data-vs-code access ?  you could at least 
> make the code fault exact.
> -mike

There is no indication which part caused the fault. Worst case: there can be
3 sources: instruction address, address1 and address 2 (for example the MVC
instruction). Now, we could start with "guessing", but what happens if 2 or
3 of the addresses are in the same page (e.g. some trampoline code on the
stack). Or we could start walking page tables: this would require us to decode
~1000 instructions just to race against other kernel code that does invalidation,
e.g. vmscan/swap. IMHO the proper solution is to accept that translation faults 
are on the page, unless the maintainers Martin or Heiko have a clever idea.

Christian

PS: Programs that need the fault address might need special handling. For an example
have a look at valgrind: https://github.com/svn2github/valgrind/blob/master/coregrind/m_signals.c
line 2385 fault_mask

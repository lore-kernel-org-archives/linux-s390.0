Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] bpf: correct broken uapi for
 BPF_PROG_TYPE_PERF_EVENT program type
From: Daniel Borkmann <daniel@iogearbox.net>
References: <1512381409-19775-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <e879ca95-25d7-d7b6-e811-81a5017ea5cf@iogearbox.net>
Message-ID: <3f9dcf23-478b-dfb9-cd93-370c2c96275c@iogearbox.net>
Date: Wed, 6 Dec 2017 00:51:36 +0100
MIME-Version: 1.0
In-Reply-To: <e879ca95-25d7-d7b6-e811-81a5017ea5cf@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 12/05/2017 04:53 PM, Daniel Borkmann wrote:
> On 12/04/2017 10:56 AM, Hendrik Brueckner wrote:
>> Perf tool bpf selftests revealed a broken uapi for s390 and arm64.
>> With the BPF_PROG_TYPE_PERF_EVENT program type the bpf_perf_event
>> structure exports the pt_regs structure for all architectures.
>>
>> This fails for s390 and arm64 because pt_regs are not part of the
>> user api and kept in-kernel only.  To mitigate the broken uapi,
>> introduce a wrapper that exports pt_regs in an asm-generic way.
>> For arm64, export the exising user_pt_regs structure.  For s390,
>> introduce a user_pt_regs structure that exports the beginning of
>> pt_regs.
>>
>> Note that user_pt_regs must export from the beginning of pt_regs
>> as BPF_PROG_TYPE_PERF_EVENT program type is not the only type for
>> running BPF programs.
>>
>> Some more background:
>> 	For the bpf_perf_event, there is a uapi definition that is
>> 	passed to the BPF program.  For other "probe" points like
>> 	trace points, kprobes, and uprobes, there is no uapi and the
>> 	BPF program is always passed pt_regs (which is OK as the BPF
>> 	program runs in the kernel context).  The perf tool can attach
>> 	BPF programs to all of these "probe" points and, optionally,
>> 	can create a BPF prologue to access particular arguments
>> 	(passed as registers).  For this, it uses DWARF/CFI
>> 	information to obtain the register and calls a perf-arch
>> 	backend function, regs_query_register_offset().  This function
>> 	returns the index into (user_)pt_regs for a particular
>> 	register.  Then, perf creates a BPF prologue that accesses
>> 	this register based on the passed stucture from the "probe"
>> 	point.
>>
>> Part of this series, are also updates to the testing and bpf selftest
>> to deal with asm-specifics.  To complete the bpf support in perf, the
>> the regs_query_register_offset function is added for s390 to support
>> BPF prologue creation.
>>
>> Changelog v1 -> v2:
>> - Correct kbuild test bot issues by including
>>   asm-generic/bpf_perf_event.h for archictectures that do not have
>>   their own asm version.
>> - Added patch to clean-up whitespace and coding style issues in s390
>>   asm/ptrace.h (#4/6) as suggested by Alexei.
>>
>>
>> Hendrik Brueckner (6):
>>   bpf: correct broken uapi for BPF_PROG_TYPE_PERF_EVENT program type
>>   s390/bpf: correct broken uapi for BPF_PROG_TYPE_PERF_EVENT program
>>     type
>>   arm64/bpf: correct broken uapi for BPF_PROG_TYPE_PERF_EVENT program
>>     type
>>   s390/uapi: correct whitespace & coding style in asm/ptrace.h
>>   selftests/bpf: sync kernel headers and introduce arch support in
>>     Makefile
>>   perf s390: add regs_query_register_offset()
> 
> Series looks good to me, thanks for working on this Hendrik! If nobody
> hollers, I would take the fixes via bpf tree later tonight.

Done, applied to bpf, thanks Hendrik!

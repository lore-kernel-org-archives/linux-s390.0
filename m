From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: SPARC issue
Date: Tue, 19 Jan 2016 15:37:17 -0800
Message-ID: <CALCETrUkm-2bUrj+XHnp_YoP8Ji_VcmE1X4JqfFb4zJOuuZjwQ@mail.gmail.com>
References: <CALCETrVso3Dd7qyf0FMDB7_nFK0wtX6_SrE7rcd48ZE_rOkFQw@mail.gmail.com>
 <20160119.171849.2126169792640472591.davem@davemloft.net> <CALCETrXxPdoLBWFbQw179Zvq5Ba4pVb=MGALDy=8GA0oUiXN-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <CALCETrXxPdoLBWFbQw179Zvq5Ba4pVb=MGALDy=8GA0oUiXN-w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andrew Lutomirski <luto@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Kees Cook <keescook@chromium.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 19, 2016 at 3:11 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Tue, Jan 19, 2016 at 2:18 PM, David Miller <davem@davemloft.net> wrote:
>> From: Andy Lutomirski <luto@amacapital.net>
>> Date: Tue, 19 Jan 2016 14:14:43 -0800
>>
>>> On Tue, Jan 19, 2016 at 1:55 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>>>> On Tue, Jan 19, 2016 at 01:47:24PM -0800, Andy Lutomirski wrote:
>>>>> Essentially all users of is_compat_task in the kernel are trying to
>>>>> determine whether they are executing in the context of a compat
>>>>> syscall.  On at least x86_64 and sparc, these are not at all the
>>>>> same question.
>>>>>
>>>>> On x86_64 and sparc, therefore, is_compat_task doesn't return the
>>>>> overall compat state of the task; it returns true if the task is
>>>>> currently in a compat syscall.
>>>>
>>>> The hell it does.  Andy, TIF_32BIT is *NOT* set on syscall entry; it is
>>>> set by execve().  And 64bit task (with that bit clear) can bloody well
>>>> issue 32bit syscalls.  Really.
>>>
>>> It does on x86.  It does not on sparc.  But syscall_get_arch on sparc
>>> *also* doesn't appear to work right.
>>>
>>> davem, how can I check the current syscall bitness on sparc?  It's not
>>> obvious to me that it's possible.
>>
>> You have to do it by context if it's important.
>>
>
> What does "by context" mean?  This is definitely important for seccomp
> and audit, and I think it's probably important for other users, too.
>
>> In addition to the example Al gave, 32-bit processes can make 64-bit
>> syscalls too.  GDB and other ptrace() using applications can use this
>> to trace 64-bit programs from 32-bit tracer apps.
>
> On x86, is_compat_task returns true in 32-bit syscalls and false in
> 64-bit syscalls.  So a 64-bit task that calls a 32-bit syscall gets
> is_compat_task.
>
> I think that the naming makes no sense whatsoever but that the
> behavior is actually desirable.  If I'm a 32-bit task and I call
> 64-bit ptrace() [1], I think I want to see the 64-bit siginfo format,
> not the 32-bit format.  A bunch of the drivers that use is_compat_task
> are specifically trying to distinguish compat from non-compat ioctls.
> The SPARC is_compat_task implementation doesn't do that.
>
> I'm trying to phase out is_compat_task entirely from non-arch code.
> The WIP version is here:
>
> https://git.kernel.org/cgit/linux/kernel/git/luto/linux.git/log/?h=in_compat_syscall
>
> but it has issues on SPARC.

Can we use pt_regs_trap_type for this?

--Andy

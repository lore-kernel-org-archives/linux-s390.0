From: David Miller <davem@davemloft.net>
Subject: Re: SPARC issue
Date: Tue, 19 Jan 2016 17:18:49 -0500 (EST)
Message-ID: <20160119.171849.2126169792640472591.davem@davemloft.net>
References: <CALCETrVso3Dd7qyf0FMDB7_nFK0wtX6_SrE7rcd48ZE_rOkFQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <CALCETrVso3Dd7qyf0FMDB7_nFK0wtX6_SrE7rcd48ZE_rOkFQw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: luto@amacapital.net
Cc: viro@zeniv.linux.org.uk, luto@kernel.org, torvalds@linux-foundation.org, mingo@kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, keescook@chromium.org
List-ID: <linux-s390.vger.kernel.org>

From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 19 Jan 2016 14:14:43 -0800

> On Tue, Jan 19, 2016 at 1:55 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>> On Tue, Jan 19, 2016 at 01:47:24PM -0800, Andy Lutomirski wrote:
>>> Essentially all users of is_compat_task in the kernel are trying to
>>> determine whether they are executing in the context of a compat
>>> syscall.  On at least x86_64 and sparc, these are not at all the
>>> same question.
>>>
>>> On x86_64 and sparc, therefore, is_compat_task doesn't return the
>>> overall compat state of the task; it returns true if the task is
>>> currently in a compat syscall.
>>
>> The hell it does.  Andy, TIF_32BIT is *NOT* set on syscall entry; it is
>> set by execve().  And 64bit task (with that bit clear) can bloody well
>> issue 32bit syscalls.  Really.
> 
> It does on x86.  It does not on sparc.  But syscall_get_arch on sparc
> *also* doesn't appear to work right.
> 
> davem, how can I check the current syscall bitness on sparc?  It's not
> obvious to me that it's possible.

You have to do it by context if it's important.

In addition to the example Al gave, 32-bit processes can make 64-bit
syscalls too.  GDB and other ptrace() using applications can use this
to trace 64-bit programs from 32-bit tracer apps.

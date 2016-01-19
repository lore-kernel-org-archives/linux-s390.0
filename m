From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] Rename is_compat_task to in_compat_syscall
Date: Tue, 19 Jan 2016 15:15:21 -0800
Message-ID: <CALCETrV07e2P-wnaoVfc3vD_qUWJWbjwKcREnBicn97mHCQ1Tg@mail.gmail.com>
References: <79347eb4ec12be34098b36693bcf613eb597cbe9.1453239942.git.luto@kernel.org>
 <20160119215535.GU17997@ZenIV.linux.org.uk> <20160119.171643.1125867148856105860.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20160119.171643.1125867148856105860.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andrew Lutomirski <luto@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 19, 2016 at 2:16 PM, David Miller <davem@davemloft.net> wrote:
> From: Al Viro <viro@ZenIV.linux.org.uk>
> Date: Tue, 19 Jan 2016 21:55:36 +0000
>
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
> Correct.

See the other thread.  My patch here is garbage, but x86 and sparc
really do work differently here, and I think that x86's behavior is
better than sparc's.

-- 
Andy Lutomirski
AMA Capital Management, LLC

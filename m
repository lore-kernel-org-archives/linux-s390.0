From: Andy Lutomirski <luto@amacapital.net>
Subject: SPARC issue (Re: [PATCH] Rename is_compat_task to in_compat_syscall)
Date: Tue, 19 Jan 2016 14:14:43 -0800
Message-ID: <CALCETrVso3Dd7qyf0FMDB7_nFK0wtX6_SrE7rcd48ZE_rOkFQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Kees Cook <keescook@chromium.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 19, 2016 at 1:55 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Tue, Jan 19, 2016 at 01:47:24PM -0800, Andy Lutomirski wrote:
>> Essentially all users of is_compat_task in the kernel are trying to
>> determine whether they are executing in the context of a compat
>> syscall.  On at least x86_64 and sparc, these are not at all the
>> same question.
>>
>> On x86_64 and sparc, therefore, is_compat_task doesn't return the
>> overall compat state of the task; it returns true if the task is
>> currently in a compat syscall.
>
> The hell it does.  Andy, TIF_32BIT is *NOT* set on syscall entry; it is
> set by execve().  And 64bit task (with that bit clear) can bloody well
> issue 32bit syscalls.  Really.

It does on x86.  It does not on sparc.  But syscall_get_arch on sparc
*also* doesn't appear to work right.

davem, how can I check the current syscall bitness on sparc?  It's not
obvious to me that it's possible.

Everyone should consider this patch withdrawn until I figure out
what's going on with sparc.

--Andy

Return-Path: <luto@amacapital.net>
MIME-Version: 1.0
In-Reply-To: <20160429201139.pudoged2yathyo64@treble>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <f8816223098569a9b2f478caa5b4a7a0c27dda00.1461875890.git.jpoimboe@redhat.com>
 <CALCETrVjJdPCE92D6NY3B2+0STAdWL0pbNqCBfQUwn-sVWLD5w@mail.gmail.com>
 <20160429201139.pudoged2yathyo64@treble>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 29 Apr 2016 13:19:23 -0700
Message-ID: <CALCETrW8G8qCHBkH7GFDTFuH82abJpbVq_-bDaRAdL7U0jLGNQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 05/18] sched: add task flag for preempt IRQ tracking
Content-Type: text/plain; charset=UTF-8
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, live-patching@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, linuxppc-dev@lists.ozlabs.org, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Petr Mladek <pmladek@suse.com>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Apr 29, 2016 at 1:11 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Fri, Apr 29, 2016 at 11:06:53AM -0700, Andy Lutomirski wrote:
>> On Thu, Apr 28, 2016 at 1:44 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>> > A preempted function might not have had a chance to save the frame
>> > pointer to the stack yet, which can result in its caller getting skipped
>> > on a stack trace.
>> >
>> > Add a flag to indicate when the task has been preempted so that stack
>> > dump code can determine whether the stack trace is reliable.
>>
>> I think I like this, but how do you handle the rather similar case in
>> which a task goes to sleep because it's waiting on IO that happened in
>> response to get_user, put_user, copy_from_user, etc?
>
> Hm, good question.  I was thinking that page faults had a dedicated
> stack, but now looking at the entry and traps code, that doesn't seem to
> be the case.
>
> Anyway I think it shouldn't be a problem if we make sure that any kernel
> function which might trigger a valid page fault (e.g.,
> copy_user_generic_string) do the proper frame pointer setup first.  Then
> the stack should still be reliable.
>
> In fact I might be able to teach objtool to enforce that: any function
> which uses an exception table should create a stack frame.
>
> Or alternatively, maybe set some kind of flag for page faults, similar
> to what I did with this patch.
>

How about doing it the other way around: teach the unwinder to detect
when it hits a non-outermost entry (i.e. it lands in idtentry, etc)
and use some reasonable heuristic as to whether it's okay to keep
unwinding.  You should be able to handle preemption like that, too --
the unwind process will end up in an IRQ frame.

--Andy

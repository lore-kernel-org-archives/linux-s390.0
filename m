From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: Avoiding information leaks between users and between processes
 by default? [Was: : [PATCH 1/5] prctl: add PR_ISOLATE_BP process control]
Date: Wed, 24 Jan 2018 13:48:03 +0100
Message-ID: <20180124134803.3e11c6d6@mschwideX1>
References: <1516712825-2917-1-git-send-email-schwidefsky@de.ibm.com>
        <1516712825-2917-2-git-send-email-schwidefsky@de.ibm.com>
        <20180123170719.GA4154@isilmar-4.linta.de>
        <20180124072953.50851fec@mschwideX1>
        <20180124083705.GA14868@light.dominikbrodowski.net>
        <20180124111552.GA24675@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180124111552.GA24675@amd>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>, w@1wt.eu, keescook@chromium.org, thomas.lendacky@amd.com, dwmw@amazon.co.uk, ak@linux.intel.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 24 Jan 2018 12:15:53 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> On Wed 2018-01-24 09:37:05, Dominik Brodowski wrote:
> > On Wed, Jan 24, 2018 at 07:29:53AM +0100, Martin Schwidefsky wrote:  
> > > On Tue, 23 Jan 2018 18:07:19 +0100
> > > Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> > >   
> > > > On Tue, Jan 23, 2018 at 02:07:01PM +0100, Martin Schwidefsky wrote:  
> > > > > Add the PR_ISOLATE_BP operation to prctl. The effect of the process
> > > > > control is to make all branch prediction entries created by the execution
> > > > > of the user space code of this task not applicable to kernel code or the
> > > > > code of any other task.    
> > > > 
> > > > What is the rationale for requiring a per-process *opt-in* for this added
> > > > protection?
> > > > 
> > > > For KPTI on x86, the exact opposite approach is being discussed (see, e.g.
> > > > http://lkml.kernel.org/r/1515612500-14505-1-git-send-email-w@1wt.eu ): By
> > > > default, play it safe, with KPTI enabled. But for "trusted" processes, one
> > > > may opt out using prctrl.  
> > > 
> > > The rationale is that there are cases where you got code from *somewhere*
> > > and want to run it in an isolated context. Think: a docker container that
> > > runs under KVM. But with spectre this is still not really safe. So you
> > > include a wrapper program in the docker container to use the trap door
> > > prctl to start the potential malicious program. Now you should be good, no?  
> > 
> > Well, partly. It may be that s390 and its use cases are special -- but as I
> > understand it, this uapi question goes beyond this question:
> > 
> > To my understanding, Linux traditionally tried to aim for the security goal
> > of avoiding information leaks *between* users[+], probably even between
> > processes of the same user. It wasn't a guarantee, and there always  
> 
> It used to be guarantee. It still is, on non-buggy CPUs.

In a perfect world none of this would have ever happened.
But reality begs to differ.

> Leaks between users need to be prevented.
> 
> Leaks between one user should be prevented, too. There are various
> ways to restrict the user these days, and for example sandboxed
> chromium process should not be able to read my ~/.ssh.

Interesting that you mention the use case of a sandboxed browser process.
Why do you sandbox it in the first place? Because your do not trust it
as it might download malicious java-script code which uses some form of
attack to read the content of your ~/.ssh files. That is the use case for
the new prctl, limit this piece of code you *identified* as untrusted.

> can_ptrace() is closer to "can allow leaks between these two". Still
> not quite there, as code might be running in process that
> can_ptrace(), but the code has been audited by JIT or something not to
> do syscalls.
> 
> > (and will be) information leaks -- and that is where additional safeguards
> > such as seccomp come into play, which reduce the attack surface against
> > unknown or unresolved security-related bugs. And everyone knew (or should
> > have known) that allowing "untrusted" code to be run (be it by an user, be
> > it JavaScript, etc.) is more risky. But still, avoiding information leaks
> > between users and between processes was (to my understanding) at least a
> > goal.[§]
> > 
> > In recent days however, the outlook on this issue seems to have shifted:
> > 
> > - Your proposal would mean to trust all userspace code, unless it is
> >   specifically marked as untrusted. As I understand it, this would mean that
> >   by default, spectre isn't fully mitigated cross-user and cross-process,
> >   though the kernel could. And rogue user-run code may make use of that,
> >   unless it is run with a special wrapper.  
> 
> Yeah, well, that proposal does not fly, then.
 
It does not fly as a solution for the general case if cross-process attacks.
But for the special case where you can identify all of the potential untrusted
code in your setup it should work just fine, no?

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

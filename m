Return-Path: <jpoimboe@redhat.com>
Date: Wed, 18 May 2016 11:51:47 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: livepatch: change to a per-task consistency model
Message-ID: <20160518165147.vyuamqfnm5kfwiqf@treble>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
 <20160517225357.GA30725@packer-debian-8-amd64.digitalocean.com>
 <alpine.LNX.2.00.1605181011550.31937@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.LNX.2.00.1605181011550.31937@cbobk.fhfr.pm>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Jiri Kosina <jikos@kernel.org>
Cc: Jessica Yu <jeyu@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Petr Mladek <pmladek@suse.com>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 18, 2016 at 10:16:22AM +0200, Jiri Kosina wrote:
> On Tue, 17 May 2016, Jessica Yu wrote:
> 
> > What about tasks sleeping on affected functions in uninterruptible sleep 
> > (possibly indefinitely)? Since all signals are ignored, we wouldn't be 
> > able to patch those tasks in this way, right? Would that be an 
> > unsupported case?
> 
> I don't think there is any better way out of this situation than 
> documenting that the convergence of patching could in such cases could 
> take quite a lot of time (well, we can pro-actively try to detect this 
> situation before the patching actually start, and warn about the possible 
> consequences).
> 
> But let's face it, this should be pretty uncommon, because (a) it's not 
> realistic for the wait times to be really indefinite (b) the task is 
> likely to be in TASK_KILLABLE rather than just plain TASK_UNINTERRUPTIBLE.

Yeah, I think this situation -- a task sleeping on an affected function
in uninterruptible state for a long period of time -- would be
exceedingly rare and not something we need to worry about for now.

-- 
Josh

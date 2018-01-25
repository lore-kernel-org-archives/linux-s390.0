Return-Path: <peterz@infradead.org>
Date: Thu, 25 Jan 2018 13:44:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 13/15] livepatch: change to a per-task consistency model
Message-ID: <20180125124403.GE2228@hirez.programming.kicks-ass.net>
References: <cover.1487036215.git.jpoimboe@redhat.com>
 <a999d965d598b23564355c24db0ed6799f105fa6.1487036215.git.jpoimboe@redhat.com>
 <20180125090444.GB2339@hirez.programming.kicks-ass.net>
 <20180125102414.wu5od5ye5nmx2ckl@pathway.suse.cz>
 <20180125103855.GC2228@hirez.programming.kicks-ass.net>
 <20180125121321.6rzrl5rsrvewxn7j@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180125121321.6rzrl5rsrvewxn7j@pathway.suse.cz>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Petr Mladek <pmladek@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 25, 2018 at 01:13:21PM +0100, Petr Mladek wrote:
> > What I was getting at, the klp stuff is the very first thing we run when
> > we schedule the idle task, but its placed at the very end of the
> > function. This is confusing.
> 
> I see.
> 
> 
> > The above still doesn't help with solving that. Do you want to run
> > something before we go idle, or before we leave idle, in neither cases
> > would I place it where it is.
> 
> In fact, both ways are fine. We require going the idle task
> through the entire cycle anyway. It is because both situations,
> too long idling or non-idling, would block finishing the patch
> transition.
> 
> Feel free to move it right before schedule_idle() or
> __current_set_polling().

OK, I'll move it. Thanks!

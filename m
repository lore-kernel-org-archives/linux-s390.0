Return-Path: <jikos@kernel.org>
Date: Wed, 25 May 2016 00:45:05 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
Subject: RE: livepatch: change to a per-task consistency model
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F4C5254@AcuExch.aculab.com>
Message-ID: <alpine.LNX.2.00.1605250042020.31937@cbobk.fhfr.pm>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
 <20160517225357.GA30725@packer-debian-8-amd64.digitalocean.com>
 <alpine.LNX.2.00.1605181011550.31937@cbobk.fhfr.pm>
 <20160518165147.vyuamqfnm5kfwiqf@treble>
 <alpine.LNX.2.00.1605182221420.31937@cbobk.fhfr.pm>
 <063D6719AE5E284EB5DD2968C1650D6D5F4C40D2@AcuExch.aculab.com>
 <alpine.LNX.2.00.1605232043300.31937@cbobk.fhfr.pm>
 <063D6719AE5E284EB5DD2968C1650D6D5F4C5254@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Jessica Yu <jeyu@redhat.com>, Vojtech Pavlik <vojtech@suse.com>, Petr Mladek <pmladek@suse.com>, Peter Zijlstra <peterz@infradead.org>, "x86@kernel.org" <x86@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, Miroslav Benes <mbenes@suse.cz>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Chris J Arges <chris.j.arges@canonical.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 24 May 2016, David Laight wrote:

> > > Related, please can we have a flag for the sleep and/or process so that
> > > an uninterruptible sleep doesn't trigger the 'hung task' detector
> > 
> > TASK_KILLABLE
> 
> Not sure that does what I want.
> It appears to allow some 'kill' actions to wake the process.
> I'm sure I've looked at the 'hung task' code since 2007.

The trick is the 

	if (t->state == TASK_UNINTERRUPTIBLE)

test in check_hung_uninterruptible_tasks(). That makes sure that 
TASK_KILLABLE tasks (e.g. waiting on NFS I/O, but not limited only to 
that; feel free to set it whereever you need) are skipped. Please note 
that TASK_KILLABLE is actually a _mask_ that includes TASK_UNINTERRUPTIBLE 
as well; therefore the '==' test skips such tasks.

-- 
Jiri Kosina
SUSE Labs

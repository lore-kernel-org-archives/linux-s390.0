Return-Path: <bsingharora@gmail.com>
Message-ID: <1481348777.28041.1.camel@gmail.com>
Subject: Re: [PATCH v3 00/15] livepatch: hybrid consistency model
From: Balbir Singh <bsingharora@gmail.com>
Date: Sat, 10 Dec 2016 16:46:17 +1100
In-Reply-To: <cover.1481220077.git.jpoimboe@redhat.com>
References: <cover.1481220077.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, live-patching@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>, Chris J Arges <chris.j.arges@canonical.com>
List-ID: <linux-s390.vger.kernel.org>
Content-Transfer-Encoding: 8bit

On Thu, 2016-12-08 at 12:08 -0600, Josh Poimboeuf wrote:
> Dusting the cobwebs off the consistency model again.  This is based on
> linux-next/master.
> 
> v1 was posted on 2015-02-09:
> 
>   https://lkml.kernel.org/r/cover.1423499826.git.jpoimboe@redhat.com
> 
> v2 was posted on 2016-04-28:
> 
>   https://lkml.kernel.org/r/cover.1461875890.git.jpoimboe@redhat.com
> 
> The biggest issue from v2 was finding a decent way to detect preemption
> and page faults on the stack of a sleeping task.  

Could you please elaborate on this? Preemption of a sleeping task and
faults as in the future (time) preemption and faults?

Balbir Singh.

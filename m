Return-Path: <josh@joshtriplett.org>
In-Reply-To: <20150104161416.GA5280@linux.vnet.ibm.com>
References: <1419918382-4758-1-git-send-email-bobby.prani@gmail.com>
 <1419918382-4758-2-git-send-email-bobby.prani@gmail.com>
 <20141230185008.GA23965@worktop.programming.kicks-ass.net>
 <CAJhHMCDsxOsBKphPrH8N5ymPgdN_OVSujQWQt5CB52TK2PO9cA@mail.gmail.com>
 <1420364152.26772.0.camel@ellerman.id.au>
 <20150104161416.GA5280@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v2] srcu: Isolate srcu sections using CONFIG_SRCU
From: Josh Triplett <josh@joshtriplett.org>
Date: Sun, 04 Jan 2015 20:57:54 -0800
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Message-ID: <EA3B4EC8-5E29-4DA3-B826-52ABA92D7710@joshtriplett.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: paulmck@linux.vnet.ibm.com, Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Tiejun Chen <tiejun.chen@windriver.com>, Paul Mackerras <paulus@samba.org>, Daniel Walter <dwalter@google.com>, Ingo Molnar <mingo@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Pranith Kumar <bobby.prani@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, S390, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Anton Blanchard <anton@samba.org>, Scott Wood <scottwood@freescale.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Li Zhong <zhong@linux.vnet.ibm.com>, Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, open list <linux-kernel@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "supporter:S390" <linux390@de.ibm.com>, linux-s390@vger.kernel.org, "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-ID: <linux-s390.vger.kernel.org>

On January 4, 2015 8:14:16 AM PST, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
>On Sun, Jan 04, 2015 at 08:35:52PM +1100, Michael Ellerman wrote:
>> On Tue, 2014-12-30 at 13:54 -0500, Pranith Kumar wrote:
>> > On Tue, Dec 30, 2014 at 1:50 PM, Peter Zijlstra
><peterz@infradead.org> wrote:
>> > > On Tue, Dec 30, 2014 at 12:46:22AM -0500, Pranith Kumar wrote:
>> > >> Isolate the SRCU functions and data structures within
>CONFIG_SRCU so that there
>> > >> is a compile time failure if srcu is used when not enabled. This
>was decided to
>> > >> be better than waiting until link time for a failure to occur.
>> > >
>> > > Why?
>> > 
>> > This is part of the kernel tinification efforts. The first patch
>was
>> > posted here: https://lkml.org/lkml/2014/12/4/848. This patch
>enables a
>> > compile time failure instead of a link time failure.
>> 
>> The punch line was:
>> 
>>   "so the savings are about ~2000 bytes."
>> 
>> Which is utterly not worth the effort IMO. There have got to be more
>attractive
>> targets for tinification than this.
>
>There probably are.  But if the tinification effort is to come anywhere
>near reaching its goals, it is going to need 2000-byte savings,
>especially
>on the small systems that are this effort's main target.
>
>That said, Peter's suggestion of falling back to the link-time
>diagnostic
>does simplify things a bit, and might be a good approach.

Agreed on both fronts; I don't think we should add any significant complexity just to turn link errors into compile errors.

- Josh Triplett

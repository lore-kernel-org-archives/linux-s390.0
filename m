Return-Path: <peterz@infradead.org>
Date: Tue, 30 Dec 2014 19:50:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] srcu: Isolate srcu sections using CONFIG_SRCU
Message-ID: <20141230185008.GA23965@worktop.programming.kicks-ass.net>
References: <1419918382-4758-1-git-send-email-bobby.prani@gmail.com>
 <1419918382-4758-2-git-send-email-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419918382-4758-2-git-send-email-bobby.prani@gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Tiejun Chen <tiejun.chen@windriver.com>, Paul Mackerras <paulus@samba.org>, Daniel Walter <dwalter@google.com>, Ingo Molnar <mingo@kernel.org>, "open list:S390" <linux-s390@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Anton Blanchard <anton@samba.org>, Scott Wood <scottwood@freescale.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Li Zhong <zhong@linux.vnet.ibm.com>, Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, open list <linux-kernel@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "supporter:S390" <linux390@de.ibm.com>, "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Dec 30, 2014 at 12:46:22AM -0500, Pranith Kumar wrote:
> Isolate the SRCU functions and data structures within CONFIG_SRCU so that there
> is a compile time failure if srcu is used when not enabled. This was decided to
> be better than waiting until link time for a failure to occur.

Why?

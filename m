From: David Howells <dhowells@redhat.com>
Subject: Re: [RFC 10/12] x86, rwsem: simplify __down_write
Date: Thu, 09 Jun 2016 15:40:58 +0100
Message-ID: <29355.1465483258@warthog.procyon.org.uk>
References: <20160603223417.GB3892@twins.programming.kicks-ass.net> <1454444369-2146-1-git-send-email-mhocko@kernel.org> <1454444369-2146-11-git-send-email-mhocko@kernel.org> <20160203081016.GD32652@gmail.com> <20160603161339.GC3693@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <20160603223417.GB3892@twins.programming.kicks-ass.net>
Content-ID: <29354.1465483258.1@warthog.procyon.org.uk>
Sender: linux-ia64-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: dhowells@redhat.com, Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Michal Hocko <mhocko@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@us.ibm.com>, Jason Low <jason.low2@hpe.com>
List-ID: <linux-s390.vger.kernel.org>

Peter Zijlstra <peterz@infradead.org> wrote:

> Blergh; so looking at more asm there's still a few tricks we cannot do.
> So while overall size is down, some paths do end up more expensive. (It
> typically boils down to creative use of condition flags, which is very
> hard in C)

It can be done using ISO __atomic_fetch_add() and suchlike.

David

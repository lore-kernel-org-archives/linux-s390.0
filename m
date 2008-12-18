Return-Path: <linux-kernel-owner+w=401wt.eu-S1754020AbYLRWxS@vger.kernel.org>
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: local_add_return
Date: Fri, 19 Dec 2008 09:22:56 +1030
References: <alpine.DEB.1.10.0812150823370.18692@gandalf.stny.rr.com> <200812170908.05423.rusty@rustcorp.com.au> <20081217000155.GA28174@Krystal>
In-Reply-To: <20081217000155.GA28174@Krystal>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812190922.57629.rusty@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: David Miller <davem@davemloft.net>, rostedt@goodmis.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, paulus@samba.org, benh@kernel.crashing.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, Christoph Lameter <christoph@lameter.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Martin Bligh <mbligh@google.com>
List-ID: <linux-s390.vger.kernel.org>

On Wednesday 17 December 2008 10:31:55 Mathieu Desnoyers wrote:
> I think we have two different use-cases here :
> 
> - local_t is useful as-is for things such as a tracer, which need to
>   modify an element of data atomically wrt local interrupts. The
>   atomic_long_t, in this case, is the correct fallback.
> - local_count_t could be used for fast counters.

Hi Mathieu,

   Complete agreement.

   I guess I'm biassed towards local_t == counter version, something else
== nmi-safe version because that's what it was originally.  Looking through
the tree, there are only 5 users: module, dmaengine and percpu_counter want
a counter, and tracing and x86 nmi.c want nmi-safe.  There are several other
places I know of which want local_t-the-counter.

   I'll prepare a patch which adds nmi_safe_t, and see how it looks.  There's
no amazing hurry on this, so I won't race to hit the merge window.

Thanks!
Rusty.

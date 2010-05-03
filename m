Return-Path: <davem@davemloft.net>
Date: Mon, 03 May 2010 14:12:40 -0700 (PDT)
Message-Id: <20100503.141240.22516688.davem@davemloft.net>
Subject: Re: [PATCH v21 001/100] eclone (1/11): Factor out code to allocate
	pidmap page
From: David Miller <davem@davemloft.net>
In-Reply-To: <1272920551.12034.4729.camel@nimitz>
References: <1272723382-19470-2-git-send-email-orenl@cs.columbia.edu>
	<20100501.151022.190375136.davem@davemloft.net>
	<1272920551.12034.4729.camel@nimitz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: dave@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, orenl@cs.columbia.edu, containers@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, matthltc@us.ibm.com, linux-api@vger.kernel.org, serue@us.ibm.com, akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com, xemul@openvz.org
List-ID: <linux-s390.vger.kernel.org>

From: Dave Hansen <dave@linux.vnet.ibm.com>
Date: Mon, 03 May 2010 14:02:31 -0700

> It has implications _everywhere_.

That does not remove the responsibility to break things up into
managable pieces, not does it make such a task impossible or
even hard to do.

You post sets of 10 to 15 at a time, once those are agreed to
and to everyone's general liking, you toss them into a GIT tree
and you say "here's the next 10 to 15 and they are relative to
the changes in GIT tree X which have already been fully reviewed"

And so on and so forth.

And this is the only logical thing to do, because if someone wants
a change in patch 7, it can effect patch 23 so it's pointless to
post for review a patch that's going to end up changing anyways.
That's a waste of reviewer resources.

To be honest, I'm really tired of what tends to be people's knee jerk
reaction to this situations, which is a lot of people doing nothing
but defending themselves.  Even if it did not violate documented
policy (it did), it violates common sense.  So, can people do
something more constructive than trying to defend themselves on this?

It's stupid and shouldn't have been done, and we should move on.

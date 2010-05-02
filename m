Return-Path: <jwboyer@gmail.com>
Date: Sat, 1 May 2010 20:14:27 -0400
From: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH v21 001/100] eclone (1/11): Factor out code to allocate
	pidmap page
Message-ID: <20100502001427.GH2671@hansolo.jdub.homelinux.org>
References: <1272723382-19470-1-git-send-email-orenl@cs.columbia.edu>
	<1272723382-19470-2-git-send-email-orenl@cs.columbia.edu>
	<20100501.151022.190375136.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100501.151022.190375136.davem@davemloft.net>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: David Miller <davem@davemloft.net>
Cc: linux-s390@vger.kernel.org, orenl@cs.columbia.edu, containers@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, matthltc@us.ibm.com, linux-api@vger.kernel.org, serue@us.ibm.com, akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com, xemul@openvz.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, May 01, 2010 at 03:10:22PM -0700, David Miller wrote:
>
>NO WAY, there is no way in the world you should post 100 patches
>at a time to any mailing list, especially those at vger.kernel.org
>that have thousands upon thousands of subscribers.
>
>Post only small, well contained, sets of patches at a time.  At most
>10 or so in one go.
>
>Do you realize how much mail traffic you generate by posting so many
>patches at one time, and how unlikely it is for anyone to actually
>sift through and review your patches after you've spammed them by
>posting so many at one time?
>
>A second infraction and I will have no choice but to block you at the
>SMTP level at vger.kernel.org so please do not do it again.

So I really agree with everything you said here, but I do wonder why you haven't
sent a similar rant about the often 100+ patchsets for the -stable series.  We  
are supposed to review those and follow up on them to be sure they're suitable  
for a stable release.

Or the 100+ emails about regressions from version to version.  Etc, etc.

I'm not saying you're wrong, but it does seem a bit odd that you choose to reply
to this one, and not the other umpteen cases I often see.  Maybe it isn't about 
the size or volume of the emails, and more about the fact that it's 100 patches 
to implement _one_ thing?  If so, then I don't really think it's about list
traffic at all...

josh

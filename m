Return-Path: <davem@davemloft.net>
Date: Sat, 01 May 2010 15:10:22 -0700 (PDT)
Message-Id: <20100501.151022.190375136.davem@davemloft.net>
Subject: Re: [PATCH v21 001/100] eclone (1/11): Factor out code to allocate
	pidmap page
From: David Miller <davem@davemloft.net>
In-Reply-To: <1272723382-19470-2-git-send-email-orenl@cs.columbia.edu>
References: <1272723382-19470-1-git-send-email-orenl@cs.columbia.edu>
	<1272723382-19470-2-git-send-email-orenl@cs.columbia.edu>
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
To: orenl@cs.columbia.edu
Cc: linux-s390@vger.kernel.org, linux-api@vger.kernel.org, containers@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, matthltc@us.ibm.com, serue@us.ibm.com, akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com, xemul@openvz.org
List-ID: <linux-s390.vger.kernel.org>


NO WAY, there is no way in the world you should post 100 patches
at a time to any mailing list, especially those at vger.kernel.org
that have thousands upon thousands of subscribers.

Post only small, well contained, sets of patches at a time.  At most
10 or so in one go.

Do you realize how much mail traffic you generate by posting so many
patches at one time, and how unlikely it is for anyone to actually
sift through and review your patches after you've spammed them by
posting so many at one time?

A second infraction and I will have no choice but to block you at the
SMTP level at vger.kernel.org so please do not do it again.

Thanks.

Return-Path: <sukadev@linux.vnet.ibm.com>
Date: Wed, 5 May 2010 15:25:53 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v21 011/100] eclone (11/11): Document sys_eclone
Message-ID: <20100505222553.GA6555@us.ibm.com>
References: <1272723382-19470-1-git-send-email-orenl@cs.columbia.edu>
	<1272723382-19470-12-git-send-email-orenl@cs.columbia.edu>
	<20100505141447.fc2397f6.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100505141447.fc2397f6.randy.dunlap@oracle.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-s390@vger.kernel.org, Oren Laadan <orenl@cs.columbia.edu>, containers@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Matt Helsley <matthltc@us.ibm.com>, linux-api@vger.kernel.org, Serge Hallyn <serue@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Pavel Emelyanov <xemul@openvz.org>
List-ID: <linux-s390.vger.kernel.org>

Randy Dunlap [randy.dunlap@oracle.com] wrote:
| > +		base of the region allocated for stack. These architectures
| > +		must pass in the size of the stack-region in ->child_stack_size.
| 
| 		                             stack region
| 
| Seems unfortunate that different architectures use the fields differently.

Yes and no. The field still has a single purpose, just that some architectures
may not need it. We enforce that if unused on an architecture, the field must
be 0. It looked like the easiest way to keep the API common across
architectures.

| 
| Is this example program meant to build only on i386?

Yes. Will add a pointer to the clone*.[chS] and libeclone.a files in

	git://git.ncl.cs.columbia.edu/pub/git/user-cr.git

for other architectures (currently x86_64, ppc, s390).

Thanks for the review. Will fix the errors and repost.

Sukadev

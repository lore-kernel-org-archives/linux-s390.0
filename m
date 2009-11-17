From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [-next Nov 17] s390 build
 break(arch/s390/kernel/compat_wrapper.S)
Date: Tue, 17 Nov 2009 17:14:24 +0100
Message-ID: <20091117161424.GH5124@osiris.boeblingen.de.ibm.com>
References: <20091117195309.6cc3ead0.sfr@canb.auug.org.au>
 <4B0291BB.3090005@in.ibm.com>
 <20091117125201.GB5124@osiris.boeblingen.de.ibm.com>
 <1258465241.2876.29.camel@dhcp231-106.rdu.redhat.com>
 <20091117135525.GF5124@osiris.boeblingen.de.ibm.com>
 <1258471436.2876.34.camel@dhcp231-106.rdu.redhat.com>
 <20091117155029.GG5124@osiris.boeblingen.de.ibm.com>
 <1258473465.2876.37.camel@dhcp231-106.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1258473465.2876.37.camel@dhcp231-106.rdu.redhat.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Eric Paris <eparis@redhat.com>
Cc: Sachin Sant <sachinp@in.ibm.com>, linux-s390@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Nov 17, 2009 at 10:57:45AM -0500, Eric Paris wrote:
> On Tue, 2009-11-17 at 16:50 +0100, Heiko Carstens wrote:
> > On Tue, Nov 17, 2009 at 10:23:56AM -0500, Eric Paris wrote:
> > > On Tue, 2009-11-17 at 14:55 +0100, Heiko Carstens wrote:
> > The third argument an int and hence it should have been lgfr ;)
> 
> It should have been an unsigned int, just noticed it today (because of
> this discussion) and fixed it.  You'll see in a patch which does so in
> -next tomorrow.
> 
> I'll let this settle a bit and come back to linux-s390 in a week or two
> to ask you guys to write/review some hooks!

We will be triggered automatically as soon as your patch gets merged.
The build system emits a warning for each new syscall which isn't wired up
and present for x86.

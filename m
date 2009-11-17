From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [-next Nov 17] s390 build
 break(arch/s390/kernel/compat_wrapper.S)
Date: Tue, 17 Nov 2009 14:55:25 +0100
Message-ID: <20091117135525.GF5124@osiris.boeblingen.de.ibm.com>
References: <20091117195309.6cc3ead0.sfr@canb.auug.org.au>
 <4B0291BB.3090005@in.ibm.com>
 <20091117125201.GB5124@osiris.boeblingen.de.ibm.com>
 <1258465241.2876.29.camel@dhcp231-106.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1258465241.2876.29.camel@dhcp231-106.rdu.redhat.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Eric Paris <eparis@redhat.com>
Cc: Sachin Sant <sachinp@in.ibm.com>, linux-s390@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Nov 17, 2009 at 08:40:41AM -0500, Eric Paris wrote:
> On Tue, 2009-11-17 at 13:52 +0100, Heiko Carstens wrote:
> > On Tue, Nov 17, 2009 at 05:36:19PM +0530, Sachin Sant wrote:
> > > Today's next 20091117 build failed on s390 with
> > > 
> > > arch/s390/kernel/compat_wrapper.S: Assembler messages:
> > > arch/s390/kernel/compat_wrapper.S:1871: Error: operand out of range (164 is not between 0 and 15)
> > > arch/s390/kernel/compat_wrapper.S:1871: Error: junk at end of line: `(%r15)'
> > > make[1]: *** [arch/s390/kernel/compat_wrapper.o] Error 1
> > > 
> > > The code in question was added by commit 9db3031ac785b068eb4636465eebb7b346c48dbb
> > > 
> > > fanotify: sys_fanotify_mark declartion
> > 
> > Hmm, the compat wrapper for sys_fanotify_mark is more broken (besides the
> > fact that it doesn't compile).
> > The same is true for sys_fanotify_init.
> > 
> > I thought it was general consensus that new syscalls should be wired up only
> > on x86 and let arch maintainers wire them up on their architectures.
> > Besides that a simple C source needs to be delivered so it can be easily
> > tested on each architecture.
> > 
> > Especially we want to avoid subtle sign extension bugs like we have them here.
> > Probably gone unnoticed if there wouldn't be a compile bug.
> 
> I'll un-wire tonight or fix it if you tell me how.  I guess my code was
> supposed to use l instead of or as in sys_fallocate_wrapper() instead of
> copying sys32_lookup_dcookie_wrapper().

Yes, also some places should have used lgfr instead of llgfr for proper sign
extension. But please, just drop the s390 bits from your patch.
Its easier and less painful for us to do it ourselves instead of reviewing
and fixing these things. (No offence intended!).

> Simple C source is available, but without s390 syscall definitions at
> people.redhat.com/~eparis/fanotify
> 
> touch /tmp/tmp
> ./fanotify /tmp/tmp &
> ^Z
> echo hello > /tmp/tmp
> fg
> ^C

Ok, thanks!

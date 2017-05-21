Return-Path: <viro@ftp.linux.org.uk>
Date: Sun, 21 May 2017 19:23:12 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 2/9] timers: provide a "modern" variant of timers
Message-ID: <20170521182312.GZ390@ZenIV.linux.org.uk>
References: <20170516114812.10660-1-hch@lst.de>
 <20170516114812.10660-3-hch@lst.de>
 <CAK8P3a106wR4h_muGGF7S7uh5UrH-OcJObMfVgk22P9brP5Bjg@mail.gmail.com>
 <20170518082448.GB3812@lst.de> <20170518084136.GA5331@lst.de>
 <alpine.DEB.2.20.1705211920280.3023@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1705211920280.3023@nanos>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Mark Gross <mark.gross@intel.com>, Tejun Heo <tj@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, May 21, 2017 at 07:57:53PM +0200, Thomas Gleixner wrote:
> On Thu, 18 May 2017, Christoph Hellwig wrote:
> > On Thu, May 18, 2017 at 10:24:48AM +0200, Christoph Hellwig wrote:
> > > > b) give the union a name (breaks any reference to timer_list->func in C code):
> > > > 
> > > >  +       union {
> > > >  +               void            (*func)(struct timer_list *timer);
> > > >  +               void            (*function)(unsigned long);
> > > >  +       } u;
> > > 
> > > I'll look into that, as it seems a lot safer, and places outside
> > > the timer code shouldn't really touch it (although I bet they do,
> > > so more fixes for this series..)
> > 
> > Meh.  All the old init_timer users set function directly, so
> > I guess we need to use the other approach.
> 
> There is another possibility. Create a coccinelle script which wraps all
> 
>       timer.function = f;
>       timer->function = f;
> 
> assignements into a helper timer_set_function(timer, func) and ask Linus to
> run it right before the next -rc. That handles everything in tree and the
> few new instances in next can be addressed with patches sent to the
> maintainers.

FWIW, there was another possible approach - I toyed with that several years
ago, but it didn't go anywhere.  Namely, make timer.function take void *
*and* turn the setup part into setup(timer, callback, argument), verifying
that
	* callback(argument) will be acceptable expression for C typechecking
	* callback returns void
	* argument is a pointer type
then cast callback to void (*)(void *) and argument to void *.  That way
we get rid of any boilerplate in callbacks and get sane typechecking...

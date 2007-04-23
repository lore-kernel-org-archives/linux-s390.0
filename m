Return-Path: <linas@austin.ibm.com>
Date: Mon, 23 Apr 2007 15:50:20 -0500
Subject: Re: [PATCH] powerpc pseries eeh: Convert to kthread API
Message-ID: <20070423205020.GR31947@austin.ibm.com>
References: <m1slawn9eb.fsf@ebiederm.dsl.xmission.com>
	<11769695763104-git-send-email-ebiederm@xmission.com>
	<20070422123155.GF20763@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070422123155.GF20763@infradead.org>
From: linas@austin.ibm.com (Linas Vepstas)
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
To: Christoph Hellwig <hch@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "<Andrew Morton" <akpm@osdl.org>, containers@lists.osdl.org, Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org, linuxppc-dev@ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, Apr 22, 2007 at 01:31:55PM +0100, Christoph Hellwig wrote:
> On Thu, Apr 19, 2007 at 01:58:45AM -0600, Eric W. Biederman wrote:
> > From: Eric W. Biederman <ebiederm@xmission.com>
> > 
> > This patch modifies the startup of eehd to use kthread_run
> > not a combination of kernel_thread and daemonize.  Making
> > the code slightly simpler and more maintainable.
> 
> This one has the same scheme as the various s390 drivers where a thread
> is spawned using a workqueue on demand.  I think we should not blindly
> convert it but think a litte more about it.
> 
> The first question is obviously, is this really something we want?
> spawning kernel thread on demand without reaping them properly seems
> quite dangerous.

I'm not quite sure what the intent of this patch really is, being
at most a somewhat passing and casual user of kernel threads.

Some background may be useful: (this in reply to some comments from
Andrew Morton)

EEH events are supposed to be very rare, as they correspond to 
hardware failures, typically PCI bus parity errors, but also 
things like wild DMA's.  The code that generates these will limit
them to no more than 6 per hour per pci device. Any more than that,
and the PCI device is permanently disabled (the sysadmin would 
need to do something to recover).

The only reason for using threads here is to get the error recovery
out of an interrupt context (where errors may be detected), and then,
an hour later, decrement a counter (which is how we limit these to 
6 per hour). Thread reaping is "trivial", the thread just exits
after an hour.

Since these are events rare, I've no particular concern about
performance or resource consumption. The current code seems 
to work just fine. :-)

--linas

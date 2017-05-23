Return-Path: <tglx@linutronix.de>
Date: Tue, 23 May 2017 13:58:57 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: RFC: better timer interface
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFFFD8B2@AcuExch.aculab.com>
Message-ID: <alpine.DEB.2.20.1705231358220.2740@nanos>
References: <20170516114812.10660-1-hch@lst.de>
 <CAK8P3a1FoR_usw7du3ZRMF+PPhJ712EpArL_e1bLVNs7BYBu-w@mail.gmail.com>
 <20170516155132.GA1494@lst.de>
 <CAK8P3a3_Rjz9gTmayN1w8HrFHWY+wakeFgQSYRTAADJzF6zKJA@mail.gmail.com>
 <alpine.DEB.2.20.1705211859410.3023@nanos>
 <alpine.DEB.2.20.1705211959370.3023@nanos>
 <063D6719AE5E284EB5DD2968C1650D6DCFFFD8B2@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-s390 <linux-s390@vger.kernel.org>, Mark Gross <mark.gross@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 23 May 2017, David Laight wrote:

> From: Thomas Gleixner
> > Sent: 21 May 2017 19:15
> ...
> > > timer_start(timer, ms, abs)
> > 
> > I'm not even sure, whether we need absolute timer wheel timers at
> > all, because most use cases are relative to now.
> 
> Posix requires absolute timers for some userspace calls
> (annoying because the code often wants relative).

Posix is completely irrelevant here. These timers are purely kernel
internal.

Thanks,

	tglx

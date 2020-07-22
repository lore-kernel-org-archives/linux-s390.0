Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:55401 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbgGVIHa (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Jul 2020 04:07:30 -0400
Date: Wed, 22 Jul 2020 10:07:24 +0200
From: 'Christoph Hellwig' <hch@lst.de>
Subject: Re: get rid of the address_space override in setsockopt
Message-ID: <20200722080724.GB26864@lst.de>
References: <20200720124737.118617-1-hch@lst.de> <ae6a743aaea3406596dbc89e332b6b3e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae6a743aaea3406596dbc89e332b6b3e@AcuMS.aculab.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Christoph Hellwig' <hch@lst.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Eric Dumazet <edumazet@google.com>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>, "coreteam@netfilter.org" <coreteam@netfilter.org>, "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>, "linux-hams@vger.kernel.org" <linux-hams@vger.kernel.org>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "dccp@vger.kernel.org" <dccp@vger.kernel.org>, "linux-decnet-user@lists.sourceforge.net" <linux-decnet-user@lists.sourceforge.net>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "mptcp@lists.01.org" <mptcp@lists.01.org>, "lvs-devel@vger.kernel.org" <lvs-devel@vger.kernel.org>, "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>, "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>, "tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, "linux-x25@vger.kernel.org" <linux-x25@vger.kernel.org>

On Tue, Jul 21, 2020 at 10:26:58AM +0000, David Laight wrote:
> From: Christoph Hellwig
> > Sent: 20 July 2020 13:47
> > 
> > setsockopt is the last place in architecture-independ code that still
> > uses set_fs to force the uaccess routines to operate on kernel pointers.
> > 
> > This series adds a new sockptr_t type that can contained either a kernel
> > or user pointer, and which has accessors that do the right thing, and
> > then uses it for setsockopt, starting by refactoring some low-level
> > helpers and moving them over to it before finally doing the main
> > setsockopt method.
> 
> Another 'gotcha' ...
> 
> On an least some architectures (possibly only m68k) IIRC all structures
> are actually passed by reference.
> (This used to be true for sparc - but it may have changed in the
> last 30 years.)

Tough luck for ABIs wit suboptimal calling conventions.  At least we can
do the right thing for those that do not have the problem.

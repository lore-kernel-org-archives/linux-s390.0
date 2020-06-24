Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39242 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbgFXNR2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 24 Jun 2020 09:17:28 -0400
Date: Wed, 24 Jun 2020 13:17:25 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: linux-next: umh: fix processed error when UMH_WAIT_PROC is used
 seems to break linux bridge on s390x (bisected)
Message-ID: <20200624131725.GL13911@42.do-not-panic.com>
References: <20200610154923.27510-5-mcgrof@kernel.org>
 <20200623141157.5409-1-borntraeger@de.ibm.com>
 <b7d658b9-606a-feb1-61f9-b58e3420d711@de.ibm.com>
 <3118dc0d-a3af-9337-c897-2380062a8644@de.ibm.com>
 <20200624120546.GC4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624120546.GC4332@42.do-not-panic.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Martin Doucha <mdoucha@suse.cz>
Cc: ast@kernel.org, axboe@kernel.dk, bfields@fieldses.org, bridge@lists.linux-foundation.org, chainsaw@gentoo.org, christian.brauner@ubuntu.com, chuck.lever@oracle.com, davem@davemloft.net, dhowells@redhat.com, gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, josh@joshtriplett.org, keescook@chromium.org, keyrings@vger.kernel.org, kuba@kernel.org, lars.ellenberg@linbit.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, nikolay@cumulusnetworks.com, philipp.reisner@linbit.com, ravenexp@gmail.com, roopa@cumulusnetworks.com, serge@hallyn.com, slyfox@gentoo.org, viro@zeniv.linux.org.uk, yangtiezhu@loongson.cn, netdev@vger.kernel.org, markward@linux.ibm.com, linux-s390 <linux-s390@vger.kernel.org>

Martin, your eyeballs would be appreciated for a bit on this.

On Wed, Jun 24, 2020 at 12:05:46PM +0000, Luis Chamberlain wrote:
> On Wed, Jun 24, 2020 at 01:11:54PM +0200, Christian Borntraeger wrote:
> > 
> > 
> > On 23.06.20 16:23, Christian Borntraeger wrote:
> > > 
> > > 
> > > On 23.06.20 16:11, Christian Borntraeger wrote:
> > >> Jens Markwardt reported a regression in the linux-next runs.  with "umh: fix
> > >> processed error when UMH_WAIT_PROC is used" (from linux-next) a linux bridge
> > >> with an KVM guests no longer activates :
> > >>
> > >> without patch
> > >> # ip addr show dev virbr1
> > >> 6: virbr1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
> > >>     link/ether 52:54:00:1e:3f:c0 brd ff:ff:ff:ff:ff:ff
> > >>     inet 192.168.254.254/24 brd 192.168.254.255 scope global virbr1
> > >>        valid_lft forever preferred_lft forever
> > >>
> > >> with this patch the bridge stays DOWN with NO-CARRIER
> > >>
> > >> # ip addr show dev virbr1
> > >> 6: virbr1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
> > >>     link/ether 52:54:00:1e:3f:c0 brd ff:ff:ff:ff:ff:ff
> > >>     inet 192.168.254.254/24 brd 192.168.254.255 scope global virbr1
> > >>        valid_lft forever preferred_lft forever
> > >>
> > >> This was bisected in linux-next. Reverting from linux-next also fixes the issue.
> > >>
> > >> Any idea?
> > > 
> > > FWIW, s390 is big endian. Maybe some of the shifts inn the __KW* macros are wrong.
> > 
> > Does anyone have an idea why "umh: fix processed error when UMH_WAIT_PROC is used" breaks the
> > linux-bridge on s390?
> 
> glibc for instance defines __WEXITSTATUS in only one location: bits/waitstatus.h
> and it does not special case it per architecture, so at this point I'd
> have to say we have to look somewhere else for why this is happening.

I found however an LTP bug indicating the need to test for
s390 wait macros [0] in light of a recent bug in glibc for s390.
I am asking for references to that issue given I cannot find
any mention of this on glibc yet.

I'm in hopes Martin might be aware of that mentioned s390 glic bug.

[0] https://github.com/linux-test-project/ltp/issues/605

  Luis

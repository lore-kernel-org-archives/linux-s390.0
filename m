Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgGTUsB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Jul 2020 16:48:01 -0400
Date: Mon, 20 Jul 2020 13:47:56 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: get rid of the address_space override in setsockopt
Message-ID: <20200720204756.iengwcguikj2yrxt@ast-mbp.dhcp.thefacebook.com>
References: <20200720124737.118617-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720124737.118617-1-hch@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Eric Dumazet <edumazet@google.com>, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, linux-sctp@vger.kernel.org, linux-hams@vger.kernel.org, linux-bluetooth@vger.kernel.org, bridge@lists.linux-foundation.org, linux-can@vger.kernel.org, dccp@vger.kernel.org, linux-decnet-user@lists.sourceforge.net, linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org, mptcp@lists.01.org, lvs-devel@vger.kernel.org, rds-devel@oss.oracle.com, linux-afs@lists.infradead.org, tipc-discussion@lists.sourceforge.net, linux-x25@vger.kernel.org

On Mon, Jul 20, 2020 at 02:47:13PM +0200, Christoph Hellwig wrote:
> Hi Dave,
> 
> setsockopt is the last place in architecture-independ code that still
> uses set_fs to force the uaccess routines to operate on kernel pointers.
> 
> This series adds a new sockptr_t type that can contained either a kernel
> or user pointer, and which has accessors that do the right thing, and
> then uses it for setsockopt, starting by refactoring some low-level
> helpers and moving them over to it before finally doing the main
> setsockopt method.
> 
> Note that I could not get the eBPF selftests to work, so this has been
> tested with a testing patch that always copies the data first and passes
> a kernel pointer.  This is something that works for most common sockopts
> (and is something that the ePBF support relies on), but unfortunately
> in various corner cases we either don't use the passed in length, or in
> one case actually copy data back from setsockopt, so we unfortunately
> can't just always do the copy in the highlevel code, which would have
> been much nicer.

could you rebase on bpf-next tree and we can route it this way then?
we'll also test the whole thing before applying.

sounds like v2 is needed anyway to address Eric's addr space concern?

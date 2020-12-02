Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbgLBBF1 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 1 Dec 2020 20:05:27 -0500
Date: Tue, 1 Dec 2020 17:04:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/6] s390/ctcm: updates 2020-11-30
Message-ID: <20201201170445.5e67042a@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <20201130100950.42051-1-jwi@linux.ibm.com>
References: <20201130100950.42051-1-jwi@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On Mon, 30 Nov 2020 11:09:44 +0100 Julian Wiedmann wrote:
> Some rare ctcm updates by Sebastian, who cleans up all places where
> in_interrupt() was used to determine the correct GFP_* mask for
> allocations.
> In the first three patches we can get rid of those allocations entirely,
> as they just end up being copied into the skb.

Applied, thanks!

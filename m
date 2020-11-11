Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbgKKCKe (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Nov 2020 21:10:34 -0500
Date: Tue, 10 Nov 2020 18:10:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net v2 0/2] net/iucv: fixes 2020-11-09
Message-ID: <20201110181032.55e4a320@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201109075706.56573-1-jwi@linux.ibm.com>
References: <20201109075706.56573-1-jwi@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>

On Mon,  9 Nov 2020 08:57:04 +0100 Julian Wiedmann wrote:
> Hi Jakub,
> 
> please apply the following patch series to netdev's net tree.
> 
> One fix in the shutdown path for af_iucv sockets. This is relevant for
> stable as well.
> Also sending along an update for the Maintainers file.
> 
> v1 -> v2: use the correct Fixes tag in patch 1 (Jakub)

Applied, and queued, thanks!

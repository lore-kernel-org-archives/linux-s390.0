Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388946AbgJOQ7h (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 15 Oct 2020 12:59:37 -0400
Date: Thu, 15 Oct 2020 09:59:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net 0/3] net/smc: fixes 2020-10-14
Message-ID: <20201015095934.72b09e9e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201014174329.35791-1-kgraul@linux.ibm.com>
References: <20201014174329.35791-1-kgraul@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Karsten Graul <kgraul@linux.ibm.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

On Wed, 14 Oct 2020 19:43:26 +0200 Karsten Graul wrote:
> Please apply the following patch series for smc to netdev's net tree.
> 
> The first patch fixes a possible use-after-free of delayed llc events.
> Patch 2 corrects the number of DMB buffer sizes. And patch 3 ensures
> a correctly formatted return code when smc_ism_register_dmb() fails to
> create a new DMB.

Applied and queued for stable, thanks!

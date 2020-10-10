Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729629AbgJJBUR (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 9 Oct 2020 21:20:17 -0400
Date: Fri, 9 Oct 2020 18:19:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/3] net/smc: updates 2020-10-07
Message-ID: <20201009181952.3e607c63@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201007205743.83535-1-kgraul@linux.ibm.com>
References: <20201007205743.83535-1-kgraul@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Karsten Graul <kgraul@linux.ibm.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

On Wed,  7 Oct 2020 22:57:40 +0200 Karsten Graul wrote:
> Please apply the following patch series for smc to netdev's net-next tree.
> 
> Patch 1 and 2 address warnings from static code checkers, and patch 3 handles
> a case when all proposed ISM V2 devices fail to init and no V1 devices are
> tried afterwards.

Applied, thanks!

I'm inducing the last patch is a fix for code only in net-next.
It would still have been better to have a Fixes tag there to make
it clear that there is no need to backport.

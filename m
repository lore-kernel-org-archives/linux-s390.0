Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729675AbgKSRpx (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 12:45:53 -0500
Date: Thu, 19 Nov 2020 09:45:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/9] s390/qeth: updates 2020-11-17
Message-ID: <20201119094551.27baf47a@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <46384624-7fbe-fc18-9dd5-fb9c114a1868@linux.ibm.com>
References: <20201117161520.1089-1-jwi@linux.ibm.com>
        <20201118173517.4cfaa900@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <46384624-7fbe-fc18-9dd5-fb9c114a1868@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>

On Thu, 19 Nov 2020 11:25:31 +0200 Julian Wiedmann wrote:
> On 19.11.20 03:35, Jakub Kicinski wrote:
> > On Tue, 17 Nov 2020 17:15:11 +0100 Julian Wiedmann wrote:  
> >> please apply the following patch series for qeth to netdev's net-next tree.
> >>
> >> This brings some cleanups, and a bunch of improvements for our
> >> .get_link_ksettings() code.  
> > 
> > Applied, thanks!
> >   
> 
> Thank you! Looks like you missed patch 1 in the series though... no biggie,
> I'll resend it with the next batch of patches.

Ahhh, sorry, somehow patchwork did not fold it into the same series, 
and I didn't notice:

https://patchwork.kernel.org/project/netdevbpf/list/?series=386125&state=*

Let me add a big fat warning to my scripts so this doesn't happen again.

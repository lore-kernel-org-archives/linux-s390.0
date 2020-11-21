Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgKUDDj (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Nov 2020 22:03:39 -0500
Date: Fri, 20 Nov 2020 19:03:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net 0/4] s390/qeth: fixes 2020-11-20
Message-ID: <20201120190338.2ca6153c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201120090939.101406-1-jwi@linux.ibm.com>
References: <20201120090939.101406-1-jwi@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>

On Fri, 20 Nov 2020 10:09:35 +0100 Julian Wiedmann wrote:
> please apply the following patch series to netdev's net tree.
> 
> This brings several fixes for qeth's af_iucv-specific code paths.
> 
> Also one fix by Alexandra for the recently added BR_LEARNING_SYNC
> support. We want to trust the feature indication bit, so that HW can
> mask it out if there's any issues on their end.

Applied, thank you!

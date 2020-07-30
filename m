Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbgG3XjF (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jul 2020 19:39:05 -0400
Date: Thu, 30 Jul 2020 16:39:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/4] s390/qeth: updates 2020-07-30
Message-ID: <20200730163903.002a49d6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200730150121.18005-1-jwi@linux.ibm.com>
References: <20200730150121.18005-1-jwi@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>

On Thu, 30 Jul 2020 17:01:17 +0200 Julian Wiedmann wrote:
> Hi Dave & Jakub,
> 
> please apply the following patch series for qeth to netdev's net-next tree.
> 
> This primarily brings some modernization to the RX path, laying the
> groundwork for smarter RX refill policies.
> Some of the patches are tagged as fixes, but really target only rare /
> theoretical issues. So given where we are in the release cycle and that we
> touch the main RX path, taking them through net-next seems more appropriate.

First 2 patches look good to me:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

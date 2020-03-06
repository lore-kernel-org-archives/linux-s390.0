Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgCFSoc (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 6 Mar 2020 13:44:32 -0500
Date: Fri, 6 Mar 2020 10:44:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/2] s390/qeth: updates 2020-03-06
Message-ID: <20200306104430.712ea933@kicinski-fedora-PC1C0HJN>
In-Reply-To: <20200306081311.50635-1-jwi@linux.ibm.com>
References: <20200306081311.50635-1-jwi@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>

On Fri,  6 Mar 2020 09:13:09 +0100 Julian Wiedmann wrote:
> Hi Dave,
> 
> please apply the following patch series for qeth to netdev's net-next
> tree.
> 
> Just a small update to take care of a regression wrt to IRQ handling in
> net-next, reported by Qian Cai. The fix needs some qdio layer changes,
> so you will find Vasily's Acked-by in that patch.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

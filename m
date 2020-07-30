Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbgG3XhR (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jul 2020 19:37:17 -0400
Date: Thu, 30 Jul 2020 16:37:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 4/4] s390/qeth: use all configured RX buffers
Message-ID: <20200730163714.7d6a5017@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200730150121.18005-5-jwi@linux.ibm.com>
References: <20200730150121.18005-1-jwi@linux.ibm.com>
        <20200730150121.18005-5-jwi@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>

On Thu, 30 Jul 2020 17:01:21 +0200 Julian Wiedmann wrote:
> The (misplaced) comment doesn't make any sense, enforcing an
> uninitialized RX buffer won't help with IRQ reduction.
> 
> So make the best use of all available RX buffers.

Often one entry in the ring is left free to make it easy to
differentiate between empty and full conditions. 

Is this not the reason here?

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgKSBfT (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Nov 2020 20:35:19 -0500
Date: Wed, 18 Nov 2020 17:35:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/9] s390/qeth: updates 2020-11-17
Message-ID: <20201118173517.4cfaa900@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20201117161520.1089-1-jwi@linux.ibm.com>
References: <20201117161520.1089-1-jwi@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>

On Tue, 17 Nov 2020 17:15:11 +0100 Julian Wiedmann wrote:
> please apply the following patch series for qeth to netdev's net-next tree.
> 
> This brings some cleanups, and a bunch of improvements for our
> .get_link_ksettings() code.

Applied, thanks!

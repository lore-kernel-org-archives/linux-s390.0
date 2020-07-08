Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgGHTeO (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 8 Jul 2020 15:34:14 -0400
Date: Wed, 8 Jul 2020 14:39:42 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH][next] s390/dasd: Use struct_size() helper
Message-ID: <20200708193942.GJ11533@embeddedor>
References: <20200619165600.GA8668@embeddedor>
 <47a86753-fd4d-9a7a-c808-5f387c872ab3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47a86753-fd4d-9a7a-c808-5f387c872ab3@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

On Wed, Jul 08, 2020 at 11:13:08AM +0200, Stefan Haberland wrote:
> Am 19.06.20 um 18:56 schrieb Gustavo A. R. Silva:
> > Make use of the struct_size() helper instead of an open-coded version
> > in order to avoid any potential type mistakes. Also, remove unnecessary
> > variable _datasize_.
> >
> > This code was detected with the help of Coccinelle and, audited and
> > fixed manually.
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Thanks for the patch.
> Tested and applied.

Thanks, Stefan.

--
Gustavo

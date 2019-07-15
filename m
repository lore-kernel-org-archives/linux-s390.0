Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:33492 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730071AbfGONU2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 15 Jul 2019 09:20:28 -0400
Date: Mon, 15 Jul 2019 06:20:27 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/1] s390/protvirt: restore force_dma_unencrypted()
Message-ID: <20190715132027.GA18357@infradead.org>
References: <20190715131719.100650-1-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715131719.100650-1-pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Thomas Gleixner <tglx@linutronix.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

This looks good to me - if you and Tom are fine with it I'd like to
fold it into his commit so that what I'll send to Linus is bisection
clean.

> Note: we still need sev_active() defined because of the reference
> in fs/core/vmcore, but this one is likely to go away soon along
> with the need for an s390 sev_active().

Any chance we could not change the return value from the function
at least in this patch/fold as that change seems unrelated to the
dma functionality.  If that is what you really wanted and only
the dma code was in the way we can happily merge it as a separate
patch, of couse.

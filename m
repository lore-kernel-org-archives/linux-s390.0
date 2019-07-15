Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:35960 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbfGON3a (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 15 Jul 2019 09:29:30 -0400
Date: Mon, 15 Jul 2019 06:29:29 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/1] s390/protvirt: restore force_dma_unencrypted()
Message-ID: <20190715132929.GA32348@infradead.org>
References: <20190715131719.100650-1-pasic@linux.ibm.com>
 <20190715132027.GA18357@infradead.org>
 <7e393b48-4165-e1d4-0450-e52dd914a3cd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e393b48-4165-e1d4-0450-e52dd914a3cd@amd.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: Christoph Hellwig <hch@infradead.org>, Halil Pasic <pasic@linux.ibm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Mon, Jul 15, 2019 at 01:28:19PM +0000, Lendacky, Thomas wrote:
> On 7/15/19 8:20 AM, Christoph Hellwig wrote:
> > This looks good to me - if you and Tom are fine with it I'd like to
> > fold it into his commit so that what I'll send to Linus is bisection
> > clean.
> 
> I'm ok with folding it in. Sorry about missing that.

The s390 changes were queued up in a different tree for 5.2, so you
had no easy way of noticing this.

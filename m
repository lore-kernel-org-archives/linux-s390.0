Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727150AbgKBRFH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Nov 2020 12:05:07 -0500
Date: Mon, 2 Nov 2020 18:04:43 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH] s390: add support for TIF_NOTIFY_SIGNAL
Message-ID: <20201102170443.GA4494@osiris>
References: <362e3645e2c0891309c07e244a147f0c32f106da.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <362e3645e2c0891309c07e244a147f0c32f106da.camel@redhat.com>
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, tglx@linutronix.de, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>

On Mon, Nov 02, 2020 at 11:59:41AM -0500, Qian Cai wrote:
> On Sun, 2020-11-01 at 17:31 +0000, Heiko Carstens wrote:
> > On Thu, Oct 29, 2020 at 10:21:11AM -0600, Jens Axboe wrote:
> > > Wire up TIF_NOTIFY_SIGNAL handling for s390.
> > > 
> > > Cc: linux-s390@vger.kernel.org
> > > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Even though I did confirm that today's linux-next contains this additional patch
> from Heiko below, a z10 guest is still unable to boot. Reverting the whole
> series (reverting only "s390: add support for TIF_NOTIFY_SIGNAL" introduced
> compiling errors) fixed the problem, i.e., git revert --no-edit
> af0dd809f3d3..7b074c15374c [1]
> 
> .config: https://cailca.coding.net/public/linux/mm/git/files/master/s390.config

I'll take a look at it, but probably not today anymore.

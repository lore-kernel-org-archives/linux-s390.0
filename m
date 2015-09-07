Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 7 Sep 2015 16:13:49 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] [s390]: Use .rept directive to store/load fpu registers
Message-ID: <20150907141349.GA13774@osiris>
References: <1440769787-8942-1-git-send-email-kuleshovmail@gmail.com>
 <55E55904.1070606@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55E55904.1070606@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Sep 01, 2015 at 09:51:32AM +0200, Christian Borntraeger wrote:
> Am 28.08.2015 um 15:49 schrieb Alexander Kuleshov:
> >  arch/s390/kernel/swsusp.S | 49 ++++++++++++++++-------------------------------
> >  1 file changed, 17 insertions(+), 32 deletions(-)
> > 
> > diff --git a/arch/s390/kernel/swsusp.S b/arch/s390/kernel/swsusp.S
> > index ca62946..8011e14 100644
> > --- a/arch/s390/kernel/swsusp.S
> > +++ b/arch/s390/kernel/swsusp.S
> > @@ -48,22 +48,15 @@ ENTRY(swsusp_arch_suspend)
> >  	/* Store registers */
> >  	mvc	0x318(4,%r1),__SF_EMPTY(%r15)	/* move prefix to lowcore */
> >  	stfpc	0x31c(%r1)			/* store fpu control */
> > -	std	0,0x200(%r1)			/* store f0 */
> > -	std	1,0x208(%r1)			/* store f1 */
> > -	std	2,0x210(%r1)			/* store f2 */
> > -	std	3,0x218(%r1)			/* store f3 */
> > -	std	4,0x220(%r1)			/* store f4 */
> > -	std	5,0x228(%r1)			/* store f5 */
> > -	std	6,0x230(%r1)			/* store f6 */
> > -	std	7,0x238(%r1)			/* store f7 */
> > -	std	8,0x240(%r1)			/* store f8 */
> > -	std	9,0x248(%r1)			/* store f9 */
> > -	std	10,0x250(%r1)			/* store f10 */
> > -	std	11,0x258(%r1)			/* store f11 */
> > -	std	12,0x260(%r1)			/* store f12 */
> > -	std	13,0x268(%r1)			/* store f13 */
> > -	std	14,0x270(%r1)			/* store f14 */
> > -	std	15,0x278(%r1)			/* store f15 */
> > +
> > +	/* store f0..f15 floating point registers */
> > +	.set i, 0
> > +	.set f, 0x200
> > +	.rept 16
> > +	std i, f(%r1)
> > +	.set i, (i+1)
> > +	.set f, (f+0x8)
> > +	.endr
> 
> I personally find the existing code easier to read, especially as it matches the
> assembler output and I can directly where the slots are, (e.g. f11 is 0x258)

Yes, I agree with Christian. Let's keep the code as it is.

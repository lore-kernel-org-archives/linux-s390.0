Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:57538 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgCSK23 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Mar 2020 06:28:29 -0400
Date: Thu, 19 Mar 2020 11:28:34 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH -v2] treewide: Rename "unencrypted" to "decrypted"
Message-ID: <20200319102834.GC13073@zn.tnic>
References: <20200317111822.GA15609@zn.tnic>
 <20200319101657.GB13073@zn.tnic>
 <20200319102011.GA3617@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200319102011.GA3617@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, Tom Lendacky <thomas.lendacky@amd.com>

On Thu, Mar 19, 2020 at 11:20:11AM +0100, Christoph Hellwig wrote:
> I thought we agreed that decrypted is absolutely the wrong term.

I don't think we did. At least I don't know where we did that.

> So NAK - if you want to change things it needs to go the other way.

We are already using "decrypted" everywhere in arch/x86/. Changing that
would be a *lot* more churn.

And it is just a term, for chrissakes, to denote memory which is not
encrypted. And it would make our lifes easier if we had only *two* terms
instead of three or more. Especially if the concept we denote with this
is a binary one: encrypted memory and *not* encrypted memory.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

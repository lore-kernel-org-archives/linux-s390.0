Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:36672 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCSLUu (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Mar 2020 07:20:50 -0400
Date: Thu, 19 Mar 2020 12:20:54 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH -v2] treewide: Rename "unencrypted" to "decrypted"
Message-ID: <20200319112054.GD13073@zn.tnic>
References: <20200317111822.GA15609@zn.tnic>
 <20200319101657.GB13073@zn.tnic>
 <20200319102011.GA3617@lst.de>
 <20200319102834.GC13073@zn.tnic>
 <8d6d3b6c-7e4e-7d9e-3e19-38f7d4477c72@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8d6d3b6c-7e4e-7d9e-3e19-38f7d4477c72@arm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, lkml <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, Tom Lendacky <thomas.lendacky@amd.com>

On Thu, Mar 19, 2020 at 11:06:15AM +0000, Robin Murphy wrote:
> Let me add another vote from a native English speaker that "unencrypted" is
> the appropriate term to imply the *absence* of encryption, whereas
> "decrypted" implies the *reversal* of applied encryption.
> 
> Naming things is famously hard, for good reason - names are *important* for
> understanding. Just because a decision was already made one way doesn't mean
> that that decision was necessarily right. Churning one area to be
> consistently inaccurate just because it's less work than churning another
> area to be consistently accurate isn't really the best excuse.

Well, the reason we chose "decrypted" vs something else is so to be as
different from "encrypted" as possible. If we called it "unencrypted"
you'd have stuff like:

       if (force_dma_unencrypted(dev))
                set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);

and I *betcha* people will misread this and maybe even introduce bugs.

So I don't think renaming it to "unencrypted" is better. And yes, I'm
deliberately putting the language semantics here on a second place
because of readability examples like the one above.

But ok, since people don't want this, we can leave it as is. It's not
like I don't have anything better to do.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

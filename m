Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:33708 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgCSR0U (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 Mar 2020 13:26:20 -0400
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -v2] treewide: Rename "unencrypted" to "decrypted"
In-Reply-To: <20200319112054.GD13073@zn.tnic>
References: <20200317111822.GA15609@zn.tnic> <20200319101657.GB13073@zn.tnic> <20200319102011.GA3617@lst.de> <20200319102834.GC13073@zn.tnic> <8d6d3b6c-7e4e-7d9e-3e19-38f7d4477c72@arm.com> <20200319112054.GD13073@zn.tnic>
Date: Thu, 19 Mar 2020 18:25:49 +0100
Message-ID: <878sjw5k9u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>, Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, lkml <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, Tom Lendacky <thomas.lendacky@amd.com>

Borislav Petkov <bp@alien8.de> writes:

> On Thu, Mar 19, 2020 at 11:06:15AM +0000, Robin Murphy wrote:
>> Let me add another vote from a native English speaker that "unencrypted" is
>> the appropriate term to imply the *absence* of encryption, whereas
>> "decrypted" implies the *reversal* of applied encryption.
>> 
>> Naming things is famously hard, for good reason - names are *important* for
>> understanding. Just because a decision was already made one way doesn't mean
>> that that decision was necessarily right. Churning one area to be
>> consistently inaccurate just because it's less work than churning another
>> area to be consistently accurate isn't really the best excuse.
>
> Well, the reason we chose "decrypted" vs something else is so to be as
> different from "encrypted" as possible. If we called it "unencrypted"
> you'd have stuff like:
>
>        if (force_dma_unencrypted(dev))
>                 set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);

TBH, I don't see how

	if (force_dma_decrypted(dev))
		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
       
makes more sense than the above. It's both non-sensical unless there is
a big fat comment explaining what this is about.

Thanks,

        tglx

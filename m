Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:56009 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgCQWBu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 17 Mar 2020 18:01:50 -0400
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] treewide: Rename "unencrypted" to "decrypted"
In-Reply-To: <20200317210602.GG15609@zn.tnic>
References: <20200317111822.GA15609@zn.tnic> <2cb4a8ae-3b13-67bd-c021-aee47fdf58c5@intel.com> <20200317210602.GG15609@zn.tnic>
Date: Tue, 17 Mar 2020 23:01:11 +0100
Message-ID: <87fte6bpzs.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@suse.de>, lkml <linux-kernel@vger.kernel.org>, "Schofield, Alison" <alison.schofield@intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, Tom Lendacky <thomas.lendacky@amd.com>, "Shutemov, Kirill" <kirill.shutemov@intel.com>

Borislav Petkov <bp@alien8.de> writes:

> On Tue, Mar 17, 2020 at 01:35:12PM -0700, Dave Hansen wrote:
>> On 3/17/20 4:18 AM, Borislav Petkov wrote:
>> > Back then when the whole SME machinery started getting mainlined, it
>> > was agreed that for simplicity, clarity and sanity's sake, the terms
>> > denoting encrypted and not-encrypted memory should be "encrypted" and
>> > "decrypted". And the majority of the code sticks to that convention
>> > except those two. So rename them.
>> 
>> Don't "unencrypted" and "decrypted" mean different things?
>> 
>> Unencrypted to me means "encryption was never used for this data".
>> 
>> Decrypted means "this was/is encrypted but here is a plaintext copy".
>
> Maybe but linguistical semantics is not the point here.
>
> The idea is to represent a "binary" concept of memory being encrypted
> or memory being not encrypted. And at the time we decided to use
> "encrypted" and "decrypted" for those two things.
>
> Do you see the need to differentiate a third "state", so to speak, of
> memory which was never encrypted?

I think so.

encrypted data is something you can't use without having the key

decrypted data is the plaintext copy of something encrypted, so
it might be of sensible nature.

unencrypted data can still be sensible, but nothing ever bothered to
encrypt it in the first place.

So having this distinction is useful in terms of setting the context
straight.

Thanks,

        tglx

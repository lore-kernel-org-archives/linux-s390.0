Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:17562 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgCQUfO (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Mar 2020 16:35:14 -0400
Subject: Re: [PATCH] treewide: Rename "unencrypted" to "decrypted"
References: <20200317111822.GA15609@zn.tnic>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <2cb4a8ae-3b13-67bd-c021-aee47fdf58c5@intel.com>
Date: Tue, 17 Mar 2020 13:35:12 -0700
MIME-Version: 1.0
In-Reply-To: <20200317111822.GA15609@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Borislav Petkov <bp@suse.de>, lkml <linux-kernel@vger.kernel.org>, "Schofield, Alison" <alison.schofield@intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, Tom Lendacky <thomas.lendacky@amd.com>, "Shutemov, Kirill" <kirill.shutemov@intel.com>

On 3/17/20 4:18 AM, Borislav Petkov wrote:
> Back then when the whole SME machinery started getting mainlined, it
> was agreed that for simplicity, clarity and sanity's sake, the terms
> denoting encrypted and not-encrypted memory should be "encrypted" and
> "decrypted". And the majority of the code sticks to that convention
> except those two. So rename them.

Don't "unencrypted" and "decrypted" mean different things?

Unencrypted to me means "encryption was never used for this data".

Decrypted means "this was/is encrypted but here is a plaintext copy".

This, for instance:

> +++ b/kernel/dma/direct.c
> @@ -26,7 +26,7 @@ unsigned int zone_dma_bits __ro_after_init = 24;
>  static inline dma_addr_t phys_to_dma_direct(struct device *dev,
>  		phys_addr_t phys)
>  {
> -	if (force_dma_unencrypted(dev))
> +	if (force_dma_decrypted(dev))
>  		return __phys_to_dma(dev, phys);

is referring to DMA that is not and never was encrypted.  It's skipping
the encryption altogether.  There's no act of "decryption" anywhere.

This, on the other hand, seems named wrong to me:

> /*
>  * Macros to add or remove encryption attribute
>  */
> #define pgprot_encrypted(prot)  __pgprot(__sme_set(pgprot_val(prot)))
> #define pgprot_decrypted(prot)  __pgprot(__sme_clr(pgprot_val(prot)))

This seems like it would be better named pgprot_unencrypted().

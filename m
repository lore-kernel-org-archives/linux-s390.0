Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:40906 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgCQVbJ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Mar 2020 17:31:09 -0400
Date: Tue, 17 Mar 2020 22:31:14 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] treewide: Rename "unencrypted" to "decrypted"
Message-ID: <20200317213100.GH15609@zn.tnic>
References: <20200317111822.GA15609@zn.tnic>
 <2cb4a8ae-3b13-67bd-c021-aee47fdf58c5@intel.com>
 <20200317210602.GG15609@zn.tnic>
 <f3e520c6-f455-9c82-abfc-d014ca63eeb5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3e520c6-f455-9c82-abfc-d014ca63eeb5@intel.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, "Schofield, Alison" <alison.schofield@intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, Tom Lendacky <thomas.lendacky@amd.com>, "Shutemov, Kirill" <kirill.shutemov@intel.com>

On Tue, Mar 17, 2020 at 02:24:59PM -0700, Dave Hansen wrote:
> No, there are just two states.  I just think the "!encrypted" case
> should not be called "decrypted".

Yeah, we suck at naming - news at 11! :-)

I believe we even considered things like "encrypted" vs "clear" but
that sucked too. ;-\

In any case, that ship has sailed now and having two as differently as
possible looking words to denote the two "states" should be good enough
for our purposes...

Oh well.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

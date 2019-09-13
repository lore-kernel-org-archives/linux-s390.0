Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:40505 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbfIMGcQ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 13 Sep 2019 02:32:16 -0400
Subject: Re: [PATCH V2 0/2] mm/debug: Add tests for architecture exported page
 table helpers
References: <1568268173-31302-1-git-send-email-anshuman.khandual@arm.com>
 <527edfce-c986-de4c-e286-34a70f6a2790@c-s.fr>
 <1b467d7a-0324-eb2c-876a-f04a99b9c596@arm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <ba2314ff-54c1-0deb-b207-b591647fac9d@c-s.fr>
Date: Fri, 13 Sep 2019 08:32:11 +0200
MIME-Version: 1.0
In-Reply-To: <1b467d7a-0324-eb2c-876a-f04a99b9c596@arm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Dan Williams <dan.j.williams@intel.com>, Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Steven Price <Steven.Price@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Matthew Wilcox <willy@infradead.org>, Sri Krishna chowdary <schowdary@nvidia.com>, Dave Hansen <dave.hansen@intel.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Vineet Gupta <vgupta@synopsys.com>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Mike Kravetz <mike.kravetz@oracle.com>, linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org



Le 13/09/2019 à 08:24, Anshuman Khandual a écrit :
> 
> 
> On 09/12/2019 08:12 PM, Christophe Leroy wrote:
>> Hi,
>>
>> I didn't get patch 1 of this series, and it is not on linuxppc-dev patchwork either. Can you resend ?
> 
> Its there on linux-mm patchwork and copied on linux-kernel@vger.kernel.org
> as well. The CC list for the first patch was different than the second one.
> 
> https://patchwork.kernel.org/patch/11142317/
> 
> Let me know if you can not find it either on MM or LKML list.
> 

I finaly found it on linux-mm archive, thanks. See my other mails and my 
fixing patch.

Christophe

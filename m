Return-Path: <linux-kbuild-owner@vger.kernel.org>
Subject: Re: [PATCH 01/11] powerpc: remove dead ifdefs in <asm/checksum.h>
References: <20190213174005.28785-1-hch@lst.de>
 <20190213174005.28785-2-hch@lst.de>
 <e7a2efe3-f56c-7dfd-6613-dc9229556673@c-s.fr> <20190214170510.GC32441@lst.de>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d5451fc4-9183-702a-e9ed-4a2be1f82a11@c-s.fr>
Date: Fri, 15 Feb 2019 09:17:43 +0100
MIME-Version: 1.0
In-Reply-To: <20190214170510.GC32441@lst.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-xtensa@linux-xtensa.org, linux-s390@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>



Le 14/02/2019 à 18:05, Christoph Hellwig a écrit :
> On Thu, Feb 14, 2019 at 09:26:19AM +0100, Christophe Leroy wrote:
>> Could you also remove the 'config GENERIC_CSUM' item in
>> arch/powerpc/Kconfig ?
> 
> All the separate declarations go away later in this series.
> 

I saw, but the purpose of the later patch is to replace arch defined 
GENERIC_CSUM by a common one that arches select. For the powerpc you are 
not in that case as the powerpc does not select GENERIC_CSUM.

So I really believe that all stale bits of remaining GENERIC_CSUM in 
powerpc should go away as a single dedicated patch, as a fix of commit 
d4fde568a34a ("powerpc/64: Use optimized checksum routines on 
little-endian")

Regarding the #ifdef __KERNEL__ , I think we should do a wide cleanup in 
arch/powerpc/include/asm, not only asm/checksum.h

Christophe

From: Joseph Myers <joseph@codesourcery.com>
Date: Wed, 19 Aug 2015 14:39:27 +0000
Subject: Ping Re: [PATCH 0/8] math-emu: Update kernel math-emu code from current glibc soft-fp
Message-Id: <alpine.DEB.2.10.1508191433380.11312@digraph.polyomino.org.uk>
References: <alpine.DEB.2.10.1507021542380.29415@digraph.polyomino.org.uk>
In-Reply-To: <alpine.DEB.2.10.1507021542380.29415@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-sh/>
List-Post: <mailto:linux-sh@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, mpe@ellerman.id.au
List-ID: <linux-s390.vger.kernel.org>

I'd like to ping this patch series, not having seen any comments on it.

[PATCH 0/8] math-emu: Update kernel math-emu code from current glibc soft-fp
https://lkml.org/lkml/2015/7/2/394

[PATCH 1/8] math-emu: Move math-emu to math-emu-old
https://lkml.org/lkml/2015/7/2/395

[PATCH 2/8] math-emu: Import current glibc soft-fp as include/math-emu
https://lkml.org/lkml/2015/7/2/398

[PATCH 3/8] alpha/math-emu: Move alpha from math-emu-old to math-emu
https://lkml.org/lkml/2015/7/2/399

[PATCH 4/8] powerpc/math-emu: Move powerpc from math-emu-old to math-emu
https://lkml.org/lkml/2015/7/2/400

[PATCH 5/8] s390/math-emu: Move s390 from math-emu-old to math-emu
https://lkml.org/lkml/2015/7/2/401

[PATCH 6/8] sh/math-emu: Move sh from math-emu-old to math-emu
https://lkml.org/lkml/2015/7/2/402

[PATCH 7/8] sparc/math-emu: Move sparc from math-emu-old to math-emu
https://lkml.org/lkml/2015/7/2/404

[PATCH 8/8] math-emu: Remove math-emu-old
https://lkml.org/lkml/2015/7/2/405

As noted in patch 0, the dependencies are as follows: patch 2 depends on 
patch 1, patches 3-7 depend on patches 1 and 2 but are independent of each 
other, patch 8 depends on all the other patches.

-- 
Joseph S. Myers
joseph@codesourcery.com

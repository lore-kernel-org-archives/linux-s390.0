Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40140 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393789AbfJYFxD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 25 Oct 2019 01:53:03 -0400
Received: by mail-qk1-f193.google.com with SMTP id y81so699594qkb.7
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 22:53:01 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V7] mm/debug: Add tests validating architecture page table helpers
Date: Fri, 25 Oct 2019 01:52:59 -0400
Message-Id: <69256008-2235-4AF1-A3BA-0146C82CCB93@lca.pw>
References: <ccdd4f7a-c7dc-ca10-d30c-0bc05c7136c7@arm.com>
In-Reply-To: <ccdd4f7a-c7dc-ca10-d30c-0bc05c7136c7@arm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <Anshuman.Khandual@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Dan Williams <dan.j.williams@intel.com>, Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Mark Brown <broonie@kernel.org>, Steven Price <Steven.Price@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Matthew Wilcox <willy@infradead.org>, Sri Krishna chowdary <schowdary@nvidia.com>, Dave Hansen <dave.hansen@intel.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Vineet Gupta <vgupta@synopsys.com>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Mike Kravetz <mike.kravetz@oracle.com>, Ingo Molnar <mingo@kernel.org>, linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org



> On Oct 24, 2019, at 11:45 PM, Anshuman Khandual <Anshuman.Khandual@arm.com=
> wrote:
>=20
> Nothing specific. But just tested this with x86 defconfig with relevant co=
nfigs
> which are required for this test. Not sure if it involved W=3D1.

No, it will not. It needs to run like,

make W=3D1 -j 64 2>/tmp/warns=

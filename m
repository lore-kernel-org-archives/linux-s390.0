Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41274 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbgA1THO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 28 Jan 2020 14:07:14 -0500
Received: by mail-qt1-f195.google.com with SMTP id l19so5597864qtq.8
        for <linux-s390@vger.kernel.org>; Tue, 28 Jan 2020 11:07:12 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V12] mm/debug: Add tests validating architecture page table helpers
Date: Tue, 28 Jan 2020 14:07:10 -0500
Message-Id: <69091BA4-18C4-4425-A5E2-31FBE4654AF9@lca.pw>
References: <20200128174709.GK655507@arrakis.emea.arm.com>
In-Reply-To: <20200128174709.GK655507@arrakis.emea.arm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Anshuman Khandual <Anshuman.Khandual@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Dave Hansen <dave.hansen@intel.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, Matthew Wilcox <willy@infradead.org>, Steven Price <Steven.Price@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mark Brown <broonie@kernel.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Dan Williams <dan.j.williams@intel.com>, Vlastimil Babka <vbabka@suse.cz>, Christophe Leroy <christophe.leroy@c-s.fr>, Sri Krishna chowdary <schowdary@nvidia.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>



> On Jan 28, 2020, at 12:47 PM, Catalin Marinas <catalin.marinas@arm.com> wr=
ote:
>=20
> The primary goal here is not finding regressions but having clearly
> defined semantics of the page table accessors across architectures. x86
> and arm64 are a good starting point and other architectures will be
> enabled as they are aligned to the same semantics.

This still does not answer the fundamental question. If this test is simply i=
nefficient to find bugs, who wants to spend time to use it regularly?  If th=
is is just one off test that may get running once in a few years (when intro=
ducing a new arch), how does it justify the ongoing cost to maintain it?

I do agree there could be a need to clearly define this thing but that belon=
gs to documentation rather than testing purpose. It is confusing to mix this=
 with other config options which have somewhat a different purpose, it will t=
hen be a waste of time for people who mistakenly enable this for regular aut=
omatic testing and never found any bug from it.=

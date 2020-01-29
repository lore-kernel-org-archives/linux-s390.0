Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qv1-f65.google.com ([209.85.219.65]:38314 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgA2LKA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 29 Jan 2020 06:10:00 -0500
Received: by mail-qv1-f65.google.com with SMTP id g6so7497982qvy.5
        for <linux-s390@vger.kernel.org>; Wed, 29 Jan 2020 03:09:59 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH V12] mm/debug: Add tests validating architecture page
 table helpers
From: Qian Cai <cai@lca.pw>
In-Reply-To: <20200129103640.GA668562@arrakis.emea.arm.com>
Date: Wed, 29 Jan 2020 06:09:56 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <50B7EFFE-1FF0-4B16-84A1-D851052B18B4@lca.pw>
References: <20200128174709.GK655507@arrakis.emea.arm.com>
 <69091BA4-18C4-4425-A5E2-31FBE4654AF9@lca.pw>
 <20200129103640.GA668562@arrakis.emea.arm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, Linux-MM <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-s390@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, Michael Ellerman <mpe@ellerman.id.au>, Vlastimil Babka <vbabka@suse.cz>, the arch/x86 maintainers <x86@kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Matthew Wilcox <willy@infradead.org>, Steven Price <Steven.Price@arm.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, Kees Cook <keescook@chromium.org>, Anshuman Khandual <Anshuman.Khandual@arm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Dan Williams <dan.j.williams@intel.com>, Mark Brown <broonie@kernel.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Thomas Gleixner <tglx@linutronix.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Sri Krishna chowdary <schowdary@nvidia.com>, Dave Hansen <dave.hansen@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>



> On Jan 29, 2020, at 5:36 AM, Catalin Marinas <catalin.marinas@arm.com> =
wrote:
>=20
> On Tue, Jan 28, 2020 at 02:07:10PM -0500, Qian Cai wrote:
>> On Jan 28, 2020, at 12:47 PM, Catalin Marinas =
<catalin.marinas@arm.com> wrote:
>>> The primary goal here is not finding regressions but having clearly
>>> defined semantics of the page table accessors across architectures. =
x86
>>> and arm64 are a good starting point and other architectures will be
>>> enabled as they are aligned to the same semantics.
>>=20
>> This still does not answer the fundamental question. If this test is
>> simply inefficient to find bugs,
>=20
> Who said this is inefficient (other than you)?

Inefficient of finding bugs. It said only found a bug or two in its =
lifetime?

>=20
>> who wants to spend time to use it regularly?=20
>=20
> Arch maintainers, mm maintainers introducing new macros or assuming
> certain new semantics of the existing macros.
>=20
>> If this is just one off test that may get running once in a few years
>> (when introducing a new arch), how does it justify the ongoing cost =
to
>> maintain it?
>=20
> You are really missing the point. It's not only for a new arch but
> changes to existing arch code. And if the arch code churn in this area
> is relatively small, I'd expect a similarly small cost of maintaining
> this test.
>=20
> If you only turn DEBUG_VM on once every few years, don't generalise =
this
> to the rest of the kernel developers (as others pointed out, this test
> is default y if DEBUG_VM).

Quite the opposite, I am running DEBUG_VM almost daily for regression
workload while I felt strongly this thing does not add any value mixing =
there.

So, I would suggest to decouple this away from DEBUG_VM, and clearly
document that this test is not something intended for automated =
regression
workloads, so those people don=E2=80=99t need to waste time running =
this.

>=20
> Anyway, I think that's a pointless discussion, so not going to reply
> further (unless you have technical content to add).
>=20
> --=20
> Catalin

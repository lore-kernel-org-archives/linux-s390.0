Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33876 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgA1Fsc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 28 Jan 2020 00:48:32 -0500
Received: by mail-qk1-f196.google.com with SMTP id d10so12263554qke.1
        for <linux-s390@vger.kernel.org>; Mon, 27 Jan 2020 21:48:32 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V12] mm/debug: Add tests validating architecture page table helpers
Date: Tue, 28 Jan 2020 00:48:30 -0500
Message-Id: <EE5B936C-121E-4322-A285-603D82D59B3A@lca.pw>
References: <012158b7-a40e-050f-cd1b-d6ce7faf042f@arm.com>
In-Reply-To: <012158b7-a40e-050f-cd1b-d6ce7faf042f@arm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <Anshuman.Khandual@arm.com>
Cc: Linux-MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Dan Williams <dan.j.williams@intel.com>, Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Mark Brown <broonie@kernel.org>, Steven Price <Steven.Price@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Matthew Wilcox <willy@infradead.org>, Sri Krishna chowdary <schowdary@nvidia.com>, Dave Hansen <dave.hansen@intel.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Vineet Gupta <vgupta@synopsys.com>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Ingo Molnar <mingo@kernel.org>, linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org



> On Jan 27, 2020, at 11:58 PM, Anshuman Khandual <Anshuman.Khandual@arm.com=
> wrote:
>=20
> As I had mentioned before, the test attempts to formalize page table helpe=
r semantics
> as expected from generic MM code paths and intend to catch deviations when=
 enabled on
> a given platform. How else should we test semantics errors otherwise ? The=
re are past
> examples of usefulness for this procedure on arm64 and on s390. I am wonde=
ring how
> else to prove the usefulness of a debug feature if these references are no=
t enough.

Not saying it will not be useful. As you mentioned it actually found a bug o=
r two in the past. The problem is that there is always a cost to maintain so=
mething like this, and nobody knew how things could be broken even for the i=
solated code you mentioned in the future given how complicated the kernel co=
de base is. I am not so positive that many developers would enable this debu=
g feature and use it on a regular basis from the information you gave so far=
.=20

On the other hand, it might just be good at maintaining this thing out of tr=
ee by yourself anyway, because if there isn=E2=80=99t going to be used by ma=
ny developers, few people is going to contribute to this and even noticed wh=
en it is broken. What=E2=80=99s the point of getting this merged apart from b=
eing getting some meaningless credits?=

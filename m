Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32949 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgA1HM7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 28 Jan 2020 02:12:59 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so9541591qto.0
        for <linux-s390@vger.kernel.org>; Mon, 27 Jan 2020 23:12:58 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V12] mm/debug: Add tests validating architecture page table helpers
Date: Tue, 28 Jan 2020 02:12:56 -0500
Message-Id: <144F3894-7934-4EC7-A9F9-C6A84CA08C65@lca.pw>
References: <a7ba6d8a-6443-5994-6a34-2824aa9b054b@c-s.fr>
In-Reply-To: <a7ba6d8a-6443-5994-6a34-2824aa9b054b@c-s.fr>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Anshuman Khandual <Anshuman.Khandual@arm.com>, Linux-MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Dan Williams <dan.j.williams@intel.com>, Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Mark Brown <broonie@kernel.org>, Steven Price <Steven.Price@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Matthew Wilcox <willy@infradead.org>, Sri Krishna chowdary <schowdary@nvidia.com>, Dave Hansen <dave.hansen@intel.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Vineet Gupta <vgupta@synopsys.com>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org



> On Jan 28, 2020, at 1:13 AM, Christophe Leroy <christophe.leroy@c-s.fr> wr=
ote:
>=20
> ppc32 an indecent / legacy platform ? Are you kidying ?
>=20
> Powerquicc II PRO for instance is fully supported by the manufacturer and w=
idely used in many small networking devices.

Of course I forgot about embedded devices. The problem is that how many deve=
lopers are actually going to run this debug option on embedded devices?=

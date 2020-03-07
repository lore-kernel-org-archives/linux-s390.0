Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33719 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCGAeV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Mar 2020 19:34:21 -0500
Received: by mail-qt1-f195.google.com with SMTP id d22so3145359qtn.0
        for <linux-s390@vger.kernel.org>; Fri, 06 Mar 2020 16:34:21 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V15] mm/debug: Add tests validating architecture page table helpers
Date: Fri, 6 Mar 2020 19:34:18 -0500
Message-Id: <CEEAD95E-D468-4C58-A65B-7E8AED91168A@lca.pw>
References: <61250cdc-f80b-2e50-5168-2ec67ec6f1e6@arm.com>
In-Reply-To: <61250cdc-f80b-2e50-5168-2ec67ec6f1e6@arm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <Anshuman.Khandual@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>



> On Mar 6, 2020, at 7:03 PM, Anshuman Khandual <Anshuman.Khandual@arm.com> w=
rote:
>=20
> Hmm, set_pte_at() function is not preferred here for these tests. The idea=

> is to avoid or atleast minimize TLB/cache flushes triggered from these sor=
t
> of 'static' tests. set_pte_at() is platform provided and could/might trigg=
er
> these flushes or some other platform specific synchronization stuff. Just

Why is that important for this debugging option?

> wondering is there specific reason with respect to the soft lock up proble=
m
> making it necessary to use set_pte_at() rather than a simple WRITE_ONCE() ?=


Looks at the s390 version of set_pte_at(), it has this comment,
vmaddr);

/*
 * Certain architectures need to do special things when PTEs
 * within a page table are directly modified.  Thus, the following
 * hook is made available.
 */

I can only guess that powerpc  could be the same here.=

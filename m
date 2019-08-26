Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:38547 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfHZWi7 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 26 Aug 2019 18:38:59 -0400
Subject: Re: [PATCH RESEND 0/8] Fix mmap base in bottom-up mmap
References: <20190620050328.8942-1-alex@ghiti.fr>
 <abc7ed75-0f51-7f21-5a74-d389f968ee55@ghiti.fr>
From: Helge Deller <deller@gmx.de>
Message-ID: <9639ebd4-7dcb-0ea5-e0a6-adb8eaecd92a@gmx.de>
Date: Tue, 27 Aug 2019 00:37:37 +0200
MIME-Version: 1.0
In-Reply-To: <abc7ed75-0f51-7f21-5a74-d389f968ee55@ghiti.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>, Andrew Morton <akpm@linux-foundation.org>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org

On 26.08.19 09:34, Alexandre Ghiti wrote:
> On 6/20/19 7:03 AM, Alexandre Ghiti wrote:
>> This series fixes the fallback of the top-down mmap: in case of
>> failure, a bottom-up scheme can be tried as a last resort between
>> the top-down mmap base and the stack, hoping for a large unused stack
>> limit.
>>
>> Lots of architectures and even mm code start this fallback
>> at TASK_UNMAPPED_BASE, which is useless since the top-down scheme
>> already failed on the whole address space: instead, simply use
>> mmap_base.
>>
>> Along the way, it allows to get rid of of mmap_legacy_base and
>> mmap_compat_legacy_base from mm_struct.
>>
>> Note that arm and mips already implement this behaviour.
>>
>> Alexandre Ghiti (8):
>> =C2=A0=C2=A0 s390: Start fallback of top-down mmap at mm->mmap_base
>> =C2=A0=C2=A0 sh: Start fallback of top-down mmap at mm->mmap_base
>> =C2=A0=C2=A0 sparc: Start fallback of top-down mmap at mm->mmap_base
>> =C2=A0=C2=A0 x86, hugetlbpage: Start fallback of top-down mmap at mm->m=
map_base
>> =C2=A0=C2=A0 mm: Start fallback top-down mmap at mm->mmap_base
>> =C2=A0=C2=A0 parisc: Use mmap_base, not mmap_legacy_base, as low_limit =
for
>> =C2=A0=C2=A0=C2=A0=C2=A0 bottom-up mmap
>> =C2=A0=C2=A0 x86: Use mmap_*base, not mmap_*legacy_base, as low_limit f=
or bottom-up
>> =C2=A0=C2=A0=C2=A0=C2=A0 mmap
>> =C2=A0=C2=A0 mm: Remove mmap_legacy_base and mmap_compat_legacy_code fi=
elds from
>> =C2=A0=C2=A0=C2=A0=C2=A0 mm_struct
>>
>> =C2=A0 arch/parisc/kernel/sys_parisc.c=C2=A0 |=C2=A0 8 +++-----
>> =C2=A0 arch/s390/mm/mmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0 arch/sh/mm/mmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0 arch/sparc/kernel/sys_sparc_64.c |=C2=A0 2 +-
>> =C2=A0 arch/sparc/mm/hugetlbpage.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +-
>> =C2=A0 arch/x86/include/asm/elf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 +-
>> =C2=A0 arch/x86/kernel/sys_x86_64.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +=
+--
>> =C2=A0 arch/x86/mm/hugetlbpage.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 7 ++++---
>> =C2=A0 arch/x86/mm/mmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20 +++++++++-----------
>> =C2=A0 include/linux/mm_types.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 --
>> =C2=A0 mm/debug.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 4 ++--
>> =C2=A0 mm/mmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0 12 files changed, 26 insertions(+), 31 deletions(-)
>>
>
> Any thoughts about that series ? As said before, this is just a preparat=
ory patchset in order to
> merge x86 mmap top down code with the generic version.

I just tested your patch series successfully on the parisc
architeture. You may add:

Tested-by: Helge Deller <deller@gmx.de> # parisc

Thanks!
Helge

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgAFRkg (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 6 Jan 2020 12:40:36 -0500
Date: Mon, 6 Jan 2020 17:40:28 +0000
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 02/22] compat: provide compat_ptr() on all
 architectures
Message-ID: <20200106174027.GC9676@willie-the-truck>
References: <20200102145552.1853992-1-arnd@arndb.de>
 <20200102145552.1853992-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102145552.1853992-3-arnd@arndb.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Robert Richter <rric@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, oprofile-list@lists.sf.net, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org

On Thu, Jan 02, 2020 at 03:55:20PM +0100, Arnd Bergmann wrote:
> In order to avoid needless #ifdef CONFIG_COMPAT checks,
> move the compat_ptr() definition to linux/compat.h
> where it can be seen by any file regardless of the
> architecture.
> 
> Only s390 needs a special definition, this can use the
> self-#define trick we have elsewhere.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/include/asm/compat.h   | 17 -----------------
>  arch/mips/include/asm/compat.h    | 18 ------------------
>  arch/parisc/include/asm/compat.h  | 17 -----------------
>  arch/powerpc/include/asm/compat.h | 17 -----------------
>  arch/powerpc/oprofile/backtrace.c |  2 +-
>  arch/s390/include/asm/compat.h    |  6 +-----
>  arch/sparc/include/asm/compat.h   | 17 -----------------
>  arch/x86/include/asm/compat.h     | 17 -----------------
>  include/linux/compat.h            | 18 ++++++++++++++++++
>  9 files changed, 20 insertions(+), 109 deletions(-)

For arm64:

Acked-by: Will Deacon <will@kernel.org>

Will

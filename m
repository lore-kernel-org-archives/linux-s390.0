Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 17 Jan 2019 14:36:19 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 0/5] s390: rework compat wrapper generation
References: <20190116131527.2071570-1-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20190116131527.2071570-1-arnd@arndb.de>
Message-Id: <20190117133619.GD18351@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, y2038@lists.linaro.org, Dominik Brodowski <linux@dominikbrodowski.net>, Mark Rutland <mark.rutland@arm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 16, 2019 at 02:15:18PM +0100, Arnd Bergmann wrote:
> Hi Heiko and Martin,
> 
> As promised, I gave this a go and changed the SYSCALL_DEFINEx()
> infrastructure to always include the wrappers for doing the
> 31-bit argument conversion on s390 compat mode.
> 
> This does three main things:
> 
> - The UID16 rework saved a lot of duplicated code, and would
>   probably make sense by itself, but is also required as
>   we can no longer call sys_*() functions directly after the
>   last step.
> 
> - Removing the compat_wrapper.c file is of course the main
>   goal here, in order to remove the need to maintain the
>   compat_wrapper.c file when new system calls get added.
>   Unfortunately, this requires adding some complexity in
>   syscall_wrapper.h, and trades a small reduction in source
>   code lines for a small increase in binary size for
>   unused wrappers.
> 
> - As an added benefit, the use of syscall_wrapper.h now makes
>   it easy to change the syscall wrappers so they no longer
>   see all user space register contents, similar to changes
>   done in commits fa697140f9a2 ("syscalls/x86: Use 'struct pt_regs'
>   based syscall calling convention for 64-bit syscalls") and
>   4378a7d4be30 ("arm64: implement syscall wrappers").
>   I leave the actual implementation of this for you, if you
>   want to do it later.
> 
> I did not test the changes at runtime, but I looked at the
> generated object code, which seems fine here and includes
> the same conversions as before.

All looks good and seems to work fine. This is a very nice
simplification of our compat code, even if it adds some dead code to
the kernel image.

I did some tests and it all looks good. Also the generated code looks
fine. So, if nothing breaks, this will go upstream with next merge
window via the s390 tree.

Thanks again for your work!

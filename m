Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Mon, 21 Jan 2019 09:53:17 -0600
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/4] kbuild: add real-prereqs shorthand for
 $(filter-out FORCE,$^)
Message-ID: <20190121155317.GA7426@bogus>
References: <1547719364-18849-1-git-send-email-yamada.masahiro@socionext.com>
 <1547719364-18849-3-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547719364-18849-3-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Borislav Petkov <bp@alien8.de>, linux-mips@vger.kernel.org, James Hogan <jhogan@kernel.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michal Marek <michal.lkml@markovi.net>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Mark Rutland <mark.rutland@arm.com>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 17, 2019 at 07:02:43PM +0900, Masahiro Yamada wrote:
> In Kbuild, if_changed and friends must have FORCE as a prerequisite.
> 
> Hence, $(filter-out FORCE,$^) or $(filter-out $(PHONY),$^) is a common
> pattern to get the names of all the prerequisites except phony targets.
> 
> Add real-prereqs as a shorthand.
> 
> Note:
> We cannot replace $(filter %.o,$^) in cmd_link_multi-m because $^ may
> include auto-generated dependencies from the .*.cmd file when a single
> object module is changed into a multi object module. Refer to commit
> 69ea912fda74 ("kbuild: remove unneeded link_multi_deps"). I added some
> comment to avoid accidental breakage.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> The patch context depends on some other ones.
> Please use 'git am -C1' if you want to test this
> on Linus' tree.
> 
> 
> Changes in v2:
>   - clean up arch/s390/boot/Makefile as well
> 
>  Documentation/devicetree/bindings/Makefile |  2 +-

Acked-by: Rob Herring <robh@kernel.org>

>  arch/mips/boot/Makefile                    |  2 +-
>  arch/powerpc/boot/Makefile                 |  2 +-
>  arch/s390/boot/Makefile                    |  2 +-
>  arch/x86/realmode/rm/Makefile              |  3 +--
>  scripts/Kbuild.include                     |  4 ++++
>  scripts/Makefile.build                     |  9 ++++++---
>  scripts/Makefile.lib                       | 18 +++++++++---------
>  scripts/Makefile.modpost                   |  2 +-
>  9 files changed, 25 insertions(+), 19 deletions(-)

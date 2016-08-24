Subject: Re: [PATCH] treewide: replace config_enabled() with IS_ENABLED() (2nd
 round)
References: <1471970749-24867-1-git-send-email-yamada.masahiro@socionext.com>
From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Date: Wed, 24 Aug 2016 09:51:36 +0200
MIME-Version: 1.0
In-Reply-To: <1471970749-24867-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Message-Id: <55efa12b-4368-3d1c-c4df-466d920f6de7@linux.vnet.ibm.com>
Return-Path: <oberpar@linux.vnet.ibm.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Kees Cook <keescook@chromium.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Dan Williams <dan.j.williams@intel.com>, Toshi Kani <toshi.kani@hpe.com>, linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>, Ingo Molnar <mingo@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Thomas Garnier <thgarnie@google.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 23.08.2016 18:45, Masahiro Yamada wrote:
> Commit 97f2645f358b ("tree-wide: replace config_enabled() with
> IS_ENABLED()") mostly killed config_enabled(), but some new users
> have appeared for v4.8-rc1.  They are all used for a boolean option,
> so can be replaced with IS_ENABLED() safely.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>

> ---
> 
>  arch/mips/include/asm/page.h | 4 ++--
>  arch/s390/kernel/setup.c     | 6 ++----
>  arch/x86/mm/kaslr.c          | 2 +-
>  3 files changed, 5 insertions(+), 7 deletions(-)

-- 
Peter Oberparleiter
Linux on z Systems Development - IBM Germany

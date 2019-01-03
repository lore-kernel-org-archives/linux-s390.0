Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Thu, 3 Jan 2019 08:36:52 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] kbuild: use assignment instead of define ... endef for
 filechk_* rules
References: <1546478214-20394-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
In-Reply-To: <1546478214-20394-1-git-send-email-yamada.masahiro@socionext.com>
Message-Id: <20190103073652.GA3957@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 03, 2019 at 10:16:54AM +0900, Masahiro Yamada wrote:
> You do not have to use define ... endef for filechk_* rules.
> 
> For simple cases, the use of assignment looks cleaner, IMHO.
> 
> I updated the usage for scripts/Kbuild.include in case somebody
> misunderstands the 'define ... endif' is the requirement.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  Kbuild                             |  4 +---
>  Makefile                           |  3 +--
>  arch/s390/kernel/syscalls/Makefile | 12 +++---------
>  arch/s390/tools/Makefile           |  7 ++-----
>  scripts/Kbuild.include             |  8 ++++----
>  scripts/kconfig/Makefile           |  4 +---
>  6 files changed, 12 insertions(+), 26 deletions(-)

For the s390 bits:
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

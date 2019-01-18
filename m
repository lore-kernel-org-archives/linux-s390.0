Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Fri, 18 Jan 2019 10:22:35 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 2/4] s390: make thin archives not directly depend on
 *.o.chkbss files
References: <1547719364-18849-1-git-send-email-yamada.masahiro@socionext.com>
 <1547719364-18849-2-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
In-Reply-To: <1547719364-18849-2-git-send-email-yamada.masahiro@socionext.com>
Message-Id: <20190118092235.GB4160@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 17, 2019 at 07:02:42PM +0900, Masahiro Yamada wrote:
> When I was refactoring cmd_ar_builtin in scripts/Makefile.build,
> I noticed the build breakage of s390.
> 
> Some Makefiles of s390 add extra dependencies to built-in.a;
> built-in.a depends on timestamp files *.o.chkbss, but $(AR) does
> not want to include them into built-in.a.
> 
> Insert a phony target 'chkbss' in between so that $(AR) can take
> $(filter-out $(PHONY), $^) as input.
> 
> While I was here, I refactored Makefile.chkbss a little bit.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> I want Acked-by from a s390 maintainer so this series can go
> into kbuild tree.
> 
> Changes in v2:
>  - New patch
> 
>  arch/s390/boot/Makefile            |  4 ++--
>  arch/s390/boot/compressed/Makefile |  4 ++--
>  arch/s390/scripts/Makefile.chkbss  | 25 +++++++++++--------------
>  3 files changed, 15 insertions(+), 18 deletions(-)

Tested and still seems to work like before.

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

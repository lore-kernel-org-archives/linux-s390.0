Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Mon, 6 Aug 2018 11:07:40 -0700
From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/4] trace: avoid calling cc-option -mrecord-mcount for
 every Makefile
Message-ID: <20180806180740.GI4238@tassilo.jf.intel.com>
References: <cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours>
 <patch-2.thread-aa7b8d.git-de935bace15a.your-ad-here.call-01533557518-ext-9465@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <patch-2.thread-aa7b8d.git-de935bace15a.your-ad-here.call-01533557518-ext-9465@work.hours>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Aug 06, 2018 at 03:17:44PM +0200, Vasily Gorbik wrote:
> Currently if CONFIG_FTRACE_MCOUNT_RECORD is enabled -mrecord-mcount
> compiler flag support is tested for every Makefile.

Good catch.  Does it make a measurable compile time difference?

> 
> Top 4 cc-option usages:
>     511 -mrecord-mcount
>      11  -fno-stack-protector
>       9 -Wno-override-init
>       2 -fsched-pressure
> 
> To address that move cc-option from scripts/Makefile.build to top Makefile
> and export CC_USING_RECORD_MCOUNT to be used in original place.
> 
> While doing that also add -mrecord-mcount to CC_FLAGS_FTRACE (if gcc
> actually supports it).
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Acked-by: Andi Kleen <ak@linux.intel.com>

-Andi

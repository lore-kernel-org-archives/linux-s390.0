Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Tue, 7 Aug 2018 07:30:17 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 4/4] s390/ftrace: add -mfentry and -mnop-mcount support
References: <cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours>
 <patch-4.thread-aa7b8d.git-aa7b8dbf236f.your-ad-here.call-01533557518-ext-9465@work.hours>
MIME-Version: 1.0
In-Reply-To: <patch-4.thread-aa7b8d.git-aa7b8dbf236f.your-ad-here.call-01533557518-ext-9465@work.hours>
Message-Id: <20180807053017.GA6613@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Aug 06, 2018 at 03:17:47PM +0200, Vasily Gorbik wrote:
> Utilize -mfentry and -mnop-mcount gcc options together with
> -mrecord-mcount to get compiler generated calls to the profiling functions
> as nops which are compatible with current -mhotpatch=0,3 approach.  At the
> same time -mrecord-mcount enables __mcount_loc section generation by
> the compiler which allows to avoid using scripts/recordmcount.pl script.
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  arch/s390/Kconfig              |  2 ++
>  arch/s390/Makefile             | 16 +++++++++-------
>  arch/s390/include/asm/ftrace.h |  6 +++---
>  arch/s390/kernel/ftrace.c      |  2 +-
>  arch/s390/kernel/mcount.S      |  2 +-
>  5 files changed, 16 insertions(+), 12 deletions(-)

Do you have numbers which tell how much this reduces the compile time of
the kernel on s390? I assume this change makes quite some difference.

Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>

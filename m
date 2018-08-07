Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Tue, 7 Aug 2018 13:59:31 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 2/4] trace: avoid calling cc-option -mrecord-mcount for
 every Makefile
References: <cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours>
 <patch-2.thread-aa7b8d.git-de935bace15a.your-ad-here.call-01533557518-ext-9465@work.hours>
 <20180806180740.GI4238@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180806180740.GI4238@tassilo.jf.intel.com>
Message-Id: <your-ad-here.call-01533643171-ext-1234@work.hours>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Aug 06, 2018 at 11:07:40AM -0700, Andi Kleen wrote:
> On Mon, Aug 06, 2018 at 03:17:44PM +0200, Vasily Gorbik wrote:
> > Currently if CONFIG_FTRACE_MCOUNT_RECORD is enabled -mrecord-mcount
> > compiler flag support is tested for every Makefile.
> 
> Good catch.  Does it make a measurable compile time difference?
> 

A bit more than couple of seconds, but it does make a difference for a
delta build:
with patch:
real    0m9.405s
user    0m6.966s
sys     0m2.287s

without:
real    0m12.153s
user    0m9.058s
sys     0m3.026s

with -j48 on s390 24 cores lpar:
with patch:
real    0m1.949s
user    0m7.034s
sys     0m2.400s

without:
real    0m2.255s
user    0m9.243s
sys     0m3.266s

> > 
> > Top 4 cc-option usages:
> >     511 -mrecord-mcount

From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/3] perf s390: generate system call table from
 asm/unistd.h
Date: Thu, 7 Dec 2017 14:37:31 -0300
Message-ID: <20171207173731.GF3173@kernel.org>
References: <1512635281-20733-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1512635281-20733-2-git-send-email-brueckner@linux.vnet.ibm.com>
 <20171207153040.GB3173@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171207153040.GB3173@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Em Thu, Dec 07, 2017 at 12:30:40PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Dec 07, 2017 at 09:27:59AM +0100, Hendrik Brueckner escreveu:
> > This should speed up accessing new system calls introduced with
> > the kernel rather than waiting for libaudit updates to include
> > them.
> 
> So, this needs to be split in multiple patches, one grabbing the
> tools/arch/s390/include/uapi/asm/unistd.h copy and adding it to
> check-headers.sh (cool, you did it! :))
> 
> I'll take a stab at splitting it here.

So, splitted it into three patches and tested the generation, showing
the steps and results on the second patch commit message:

[acme@jouet perf]$ git log -3 --oneline
b91e81b8e967 (HEAD -> perf/core, acme.korg/perf/core) perf trace: Use generated syscall table on s390 too
8fe39fe5058d perf s390: Generate system call table from asm/unistd.h
fdd7d74b2782 tools include s390: Grab a copy of arch/s390/include/uapi/asm/unistd.h
[acme@jouet perf]$

And pushed it to my perf/core branch on:

git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

Please take a look and check that I didn't mess anything up :-)

- Arnaldo

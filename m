From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2 5/5] perf trace: Remove audit-libs dependency if
 syscall tables are present
Date: Sun, 21 Jan 2018 09:27:48 -0300
Message-ID: <20180121122748.GF23453@kernel.org>
References: <1516352177-11106-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1516352177-11106-6-git-send-email-brueckner@linux.vnet.ibm.com>
 <20180119140426.GB23453@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180119140426.GB23453@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Em Fri, Jan 19, 2018 at 11:04:26AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Jan 19, 2018 at 09:56:17AM +0100, Hendrik Brueckner escreveu:
> > Change the Makefile and build process to no longer require audit-libs
> > interfaces when the architecture provides system call tables.
> > 
> > Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> > Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> 
> So, I need this extra patch to really stop linking against
> audit-libs-devel (aka libaudit), which I merged with this 5/5 patch and
> have now in my tree, thanks for your work!

So, test building it on centos:5 fails:

  CC       /tmp/build/perf/bench/sched-messaging.o
In file included from trace/beauty/arch_errno_names.c:1,
                 from builtin-trace.c:547:
/tmp/build/perf/trace/beauty/generated/arch_errno_name_array.c:1708:2: error: no newline at end of file

I'm fixing this up.

- Arnaldo

From: Arnaldo Carvalho de Melo <acme@kernel.org>
Date: Tue, 24 Apr 2018 14:04:11 +0000
Subject: Re: [PATCH] perf tests: let 'perf test list' display subtests
Message-Id: <20180424140411.GC3788@kernel.org>
In-Reply-To: <20180424102112.GB19043@krava>
References: <20180424102112.GB19043@krava>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Em Tue, Apr 24, 2018 at 12:21:12PM +0200, Jiri Olsa escreveu:
> On Fri, Apr 13, 2018 at 09:42:23AM +0200, Hendrik Brueckner wrote:
> > The output of perf test and perf test list differ because perf test list
> > does not display subtests.  Correct this behavior and also let perf test
> > list report subtests.
> > 
> > For example:
> > 
> > 	$ ./perf test 2>&1 |wc -l
> > 	65
> > 
> > Without this commit:
> > 	$ ./perf test list 2>&1 |wc -l
> > 	57
> > 
> > With this commit:
> > 	$ ./perf test list 2>&1 |wc -l
> > 	65
> > 
> > Reviewed-by: Thomas Richter <tmricht@linux.ibm.com>
> > Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo

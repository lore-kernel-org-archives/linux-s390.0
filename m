Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064214414;
	Thu,  2 Apr 2026 00:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775088232; cv=none; b=gXPA8+KSA2T+NGIrw0qoHky2KlvnALJo52q3lJcBLRphj6lhyAfG6JG+0mdAknJGLzYBwCbx/bCiLT3lU0Ysgs2uGB4l64yC/OYf5K43bhylCwBSwplIOb4FPHHoyrJ+JCp1n1UWJMHfc5tbYp33S946xK0QWdOFp4sUrF//Fyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775088232; c=relaxed/simple;
	bh=DWZ5wWCFWkWGETdfR0kKyQefbSSF0P88fzS9CZ8C8Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYnCjQ0v1IJpNZRIUmFco7Bx5FiaZfqnIkc9bD4u+JXdnT6rNsDrseW+3PFWYRTkUuT9yC0bStnngSZegxrlEHEj+7mY9LMHoYFm0GD0271+5gZ39Oc2n+76xkT7ryZTSeGgl3dOn0jupercO8Ba8YuRxb1GuThO7hgBPyGNo7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+mX4KhN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+mX4KhN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E03C4CEF7;
	Thu,  2 Apr 2026 00:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775088231;
	bh=DWZ5wWCFWkWGETdfR0kKyQefbSSF0P88fzS9CZ8C8Lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+mX4KhNSfm2z1hppMt4T4pLkJCqRe5WlMTQKV395AUaOvVM0zcXbI5kuo9haFJDa
	 SkskK/UqhSdMgjevajxJHDY+CKDRuceiak76F+OobSxxvmR2Exh6wusuN8hixF3DYf
	 aSDBu+8Yw+ATR00PbEBRr0angvAf+92UiB8PHAymFkKeP9Adw9h+P5SPlWiUjp/ZbO
	 DtidlEUc6pYKg7P4Rv0TgP9qGGo6XmYMv8ZWij7cxcwQXJN+d6P4XYWR4OUj18Xdpf
	 RdEBrCoYCWzPQnT0h06CdhI9cE2fZZ95NcP0Xk59TPAeZ/xms1LcOpPj+EANbuvUIa
	 VZHRkoG+STXWQ==
Date: Wed, 1 Apr 2026 17:03:49 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
	acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH 3/3] perf addr2line: Remove global variable
 addr2line_timeout_ms
Message-ID: <ac2yZU-GHKxRLLrV@google.com>
References: <20260325120627.1841175-1-tmricht@linux.ibm.com>
 <20260325120627.1841175-4-tmricht@linux.ibm.com>
 <CAP-5=fV+Xn_7Q1DZmO43MBrOAHZv6YUu8wwF8jyy7Stwo=BNRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV+Xn_7Q1DZmO43MBrOAHZv6YUu8wwF8jyy7Stwo=BNRQ@mail.gmail.com>

On Wed, Mar 25, 2026 at 08:05:22AM -0700, Ian Rogers wrote:
> On Wed, Mar 25, 2026 at 5:06 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >
> > Remove global variable addr2line_timeout_ms and add is as member
> > to symbol_conf structure. No functional change.
> >
> > Fixes: 257046a36750a ("perf srcline: Fallback between addr2line implementations")
> > Cc: Ian Rogers <irogers@google.com>
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> 
> I'm a bit curious about the no functional change and the Fixes tag :-)

Right, it should belong somewhere else.


> I think the trend for addr2line is to use libdw. The forking of both
> objdump and addr2line is quite brittle and slow.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/util/addr2line.c   | 8 ++++----
> >  tools/perf/util/addr2line.h   | 2 --
> >  tools/perf/util/config.c      | 3 +--
> >  tools/perf/util/symbol_conf.h | 1 +
> >  4 files changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/util/addr2line.c b/tools/perf/util/addr2line.c
> > index e9f084db0802..1b7f66ece570 100644
> > --- a/tools/perf/util/addr2line.c
> > +++ b/tools/perf/util/addr2line.c
> > @@ -18,9 +18,6 @@
> >
> >  #define MAX_INLINE_NEST 1024
> >
> > -/* If addr2line doesn't return data for 5 seconds then timeout. */
> > -int addr2line_timeout_ms = 5 * 1000;
> > -
> >  static int filename_split(char *filename, unsigned int *line_nr)
> >  {
> >         char *sep;
> > @@ -87,6 +84,9 @@ static struct child_process *addr2line_subprocess_init(const char *addr2line_pat
> >                 return NULL;
> >         }
> >
> > +       if (!symbol_conf.addr2line_timeout_ms)
> > +               symbol_conf.addr2line_timeout_ms = 5 * 1000;

Please put this in the util/symbol.c where the symbol_conf is defined.

Thanks,
Namhyung


> > +
> >         return a2l;
> >  }
> >
> > @@ -335,7 +335,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
> >                 goto out;
> >         }
> >         io__init(&io, a2l->out, buf, sizeof(buf));
> > -       io.timeout_ms = addr2line_timeout_ms;
> > +       io.timeout_ms = symbol_conf.addr2line_timeout_ms;
> >         switch (read_addr2line_record(&io, cmd_a2l_style, dso_name, addr, /*first=*/true,
> >                                       &record_function, &record_filename, &record_line_nr)) {
> >         case -1:
> > diff --git a/tools/perf/util/addr2line.h b/tools/perf/util/addr2line.h
> > index d35a47ba8dab..75989a92f16b 100644
> > --- a/tools/perf/util/addr2line.h
> > +++ b/tools/perf/util/addr2line.h
> > @@ -8,8 +8,6 @@ struct dso;
> >  struct inline_node;
> >  struct symbol;
> >
> > -extern int addr2line_timeout_ms;
> > -
> >  int cmd__addr2line(const char *dso_name, u64 addr,
> >                    char **file, unsigned int *line_nr,
> >                    struct dso *dso,
> > diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> > index 31541e03aab7..573b3a3f5999 100644
> > --- a/tools/perf/util/config.c
> > +++ b/tools/perf/util/config.c
> > @@ -19,7 +19,6 @@
> >  #include "util/hist.h"  /* perf_hist_config */
> >  #include "util/stat.h"  /* perf_stat__set_big_num */
> >  #include "util/evsel.h"  /* evsel__hw_names, evsel__use_bpf_counters */
> > -#include "util/addr2line.h"  /* addr2line_timeout_ms */
> >  #include "srcline.h"
> >  #include "build-id.h"
> >  #include "debug.h"
> > @@ -459,7 +458,7 @@ static int perf_default_core_config(const char *var, const char *value)
> >                 proc_map_timeout = strtoul(value, NULL, 10);
> >
> >         if (!strcmp(var, "core.addr2line-timeout"))
> > -               addr2line_timeout_ms = strtoul(value, NULL, 10);
> > +               symbol_conf.addr2line_timeout_ms = strtoul(value, NULL, 10);
> >
> >         if (!strcmp(var, "core.addr2line-disable-warn"))
> >                 symbol_conf.addr2line_disable_warn = strtoul(value, NULL, 10);
> > diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> > index ff229942fbb1..c86f4c0ca46b 100644
> > --- a/tools/perf/util/symbol_conf.h
> > +++ b/tools/perf/util/symbol_conf.h
> > @@ -80,6 +80,7 @@ struct symbol_conf {
> >                         *bt_stop_list_str;
> >         const char              *addr2line_path;
> >         enum a2l_style  addr2line_style[MAX_A2L_STYLE];
> > +       int             addr2line_timeout_ms;
> >         unsigned long   time_quantum;
> >         struct strlist  *dso_list,
> >                         *comm_list,
> > --
> > 2.53.0
> >

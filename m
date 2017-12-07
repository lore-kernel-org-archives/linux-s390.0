From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/3] fixup! perf: introduce errno_to_name() function
Date: Thu, 7 Dec 2017 11:48:46 -0300
Message-ID: <20171207144846.GB6458@kernel.org>
References: <1512635281-20733-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1512635281-20733-3-git-send-email-brueckner@linux.vnet.ibm.com>
 <20171207083717.GD4889@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171207083717.GD4889@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Em Thu, Dec 07, 2017 at 09:37:17AM +0100, Hendrik Brueckner escreveu:
> Hi Arnaldo,
> 
> just looking through my posting and just need a fixup for one hunk.  Please
> let me know whether I shall re-post the series again.  Sorry for this
> inconvenience.

NP, in these cases please resend the affected patch with a v2 in the
subject line, i.e.:

Subject: [PATCH 2/3 v2] perf: introduce errno_to_name() function

Some other issues with that subject line, please check the differences:

Subject: [PATCH 2/3 v2] perf trace: Introduce errno_to_name()

Regards,

- Arnaldo
 
> On Thu, Dec 07, 2017 at 09:28:00AM +0100, Hendrik Brueckner wrote:
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> [...]
> > @@ -1659,6 +1658,18 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
> >  	return sample__fprintf_callchain(sample, 38, print_opts, &callchain_cursor, trace->output);
> >  }
> > 
> > +static const char *errno_to_name(int err)
> > +{
> > +	switch (err) {
> > +#define ERRNO_NAME_MAP(_err, _num) case _num: return #_err;
> > +	ALL_ERRNO_NAME_MAPPINGS
> > +#undef ONE_ERRNO_NAME
> 
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index b7aef0f..04af6a1 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1663,7 +1663,7 @@ static const char *errno_to_name(int err)
>  	switch (err) {
>  #define ERRNO_NAME_MAP(_err, _num) case _num: return #_err;
>  	ALL_ERRNO_NAME_MAPPINGS
> -#undef ONE_ERRNO_NAME
> +#undef ERRNO_NAME_MAP
>  	default:
>  		return "(unknown)";
>  		break;

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A56D2F4A05;
	Wed, 11 Mar 2026 06:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773209345; cv=none; b=KC9N4fkGtFQJ3HY2maa5J/aKguHVymQYrRxG/QXExPiBtZvPEqeLntfi4Mv4CFv5Ju9eOzTFqeVRrU6bLKHKeYAanNHxl0m5JYbElgDl23z2WGAhLQ2iGjqr5hwa+/y401N03BfZ2dt7O7EfU1f52x7CG/K+/zsC1FFSVs8qBZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773209345; c=relaxed/simple;
	bh=DmYQ6vpGcOowWzmg/xavd+uS24m5fO1EdRRYKPjbV7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1XGXVME+OwZbjzXukllFyxANHsrY5W1b+L6HUlZYeOZB1KaMmeCotaGxSwglbiOdG2NzxdBRUZwXx25aqljCohG9dfHrWrUwBOM4O+Wv8peXqEX6dCnLNei4/e6aFRsCLxSEjNaxJFQ7I76zgkiFoO+Y8oC9afSHc3rBAOzOgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4ne5Ft0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4ne5Ft0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B49DC4CEF7;
	Wed, 11 Mar 2026 06:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773209345;
	bh=DmYQ6vpGcOowWzmg/xavd+uS24m5fO1EdRRYKPjbV7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n4ne5Ft03RZcvgJEAvSwefW52x3F15TJHPJtYkviir3A2oFRkAWdBC76cVR0e4YRw
	 Qia5XKZ8BNM/8+NJ8BleIJ6tIZlE9+BaYfGDH91lMFMurY08kQVZR7V7h0/9DDplN2
	 EwVyLhhqegqpRXd2qp2VqsYmM2flNvnrHJjS9xITH1q2bIPgIfCwa/PoetSp2OU+px
	 OuzRg8aIVfCYIY5Osm1BN5NmOSMIgZ4ORfcf7bSOYb9wFiOfkBayT7tQll9q3iJgK+
	 8AoJ/B2tBvhpmd3AT3XuZKNL9dDu6BEjXY1gn1aG1v081sK66FhhE1HMpnTeZPaaYh
	 ue/fmMr1ipthw==
Date: Tue, 10 Mar 2026 23:09:02 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Jan Polensky <japo@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
	acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH] perf test: Fix test case 120 and 121 for s390
Message-ID: <abEG_lty-tgMXJYx@z2>
References: <20260306071002.2526085-1-tmricht@linux.ibm.com>
 <aar4GKP1c66egZnn@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CAP-5=fXs0UrMVhwU-_=iunCYa_ye18FHj0W1V8sE5T9nOkeZWg@mail.gmail.com>
 <a3b8bf7e-ec5c-460b-9ffc-ca1d2cd9e223@linux.ibm.com>
 <CAP-5=fVziHx2B8QPWafPo0T_JWm06zD4vwtR4DmcFyePV04U0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVziHx2B8QPWafPo0T_JWm06zD4vwtR4DmcFyePV04U0Q@mail.gmail.com>

On Mon, Mar 09, 2026 at 11:18:28AM -0700, Ian Rogers wrote:
> On Mon, Mar 9, 2026 at 5:59 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >
> > On 3/6/26 17:53, Ian Rogers wrote:
> > > On Fri, Mar 6, 2026 at 7:52 AM Jan Polensky <japo@linux.ibm.com> wrote:
> > >>
> > >> On Fri, Mar 06, 2026 at 08:10:02AM +0100, Thomas Richter wrote:
> > >>> Perf tests
> > >>> 120: 'perf data convert --to-ctf' command test
> > >>> 121: 'perf data convert --to-json' command test
> > >>> fail on s390. It is caused by selecting the default event cycles
> > >>> which does not exist on s390 z/VM. Use software event cpu-clock
> > >>> and specify it explicitly on the command line.
> > >>>
> > >>> Output before:
> > >>> ❯ perf test 120 121
> > >>> 120: 'perf data convert --to-ctf' command test       : FAILED!
> > >>> 121: 'perf data convert --to-json' command test      : FAILED!
> > >>>
> > >>> Output after:
> > >>> ❯ perf test 120 121
> > >>> 120: 'perf data convert --to-ctf' command test       : Ok
> > >>> 121: 'perf data convert --to-json' command test      : Ok
> > >>>
> > >>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > >> [snip]
> > >> Thanks for providing this, Thomas!
> > >> Tested-by: Jan Polensky <japo@linux.ibm.com>
> > >> Reviewed-by: Jan Polensky <japo@linux.ibm.com>
> > >
> > > Should we not fallback for the cycles as a default event?
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/builtin-record.c#n1374
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/evsel.c#n3792
> > >
> > > Thanks,
> > > Ian
> > >
> >
> > The fallback should be cpu-clock in case hardware event cycles (or CPU_CYCLES on s390) does not exist.
> 
> Thanks Thomas, so the change is doing:
> ```
> -       if ! perf record -o "$perfdata" -F 99 -g -- perf test -w noploop
> +       if ! perf record -o "$perfdata" -e cpu-clock -F 99 -g -- perf
> test -w noploop
> ```
> where the default event is cycles:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/evlist.c#n116
> Given that cycles will fail but then fallback to cpu-clock:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/evsel.c#n3792
> I wonder if the issue is that the fallback is broken. Specifically:
> ```
>    evsel->core.attr.type   == PERF_TYPE_HARDWARE &&
>    evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES) {
> ```
> It isn't going to work well on hybrid machines or those whose PMU's
> sysfs events or JSON include a cycles event. I wonder if using
> `evsel__match(evsel, HARDWARE, CYCLES)` would be better, as the
> evsel__match code is more robust to these kind of variances. I don't
> know if that will address the fallback problem for you.

I suspect it may return a different error code on s390.

Thanks,
Namhyung


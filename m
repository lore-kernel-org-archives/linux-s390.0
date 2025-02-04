Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC24117E8E2;
	Tue,  4 Feb 2025 03:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738640103; cv=none; b=dTCCJENtbYc6Mr3m0O+xRm0JZFefgNZugwU+BokNJu5cF9axljzuavddr/j0/cOyw2YgQ2FfOR7f9XHHSZ2GxxIYD/URfUI910/xs7r35qbGE+LM1+2DnOoBm/pSTESDKMo2bxfHKjKa7aumNDPuMyAHzpUf/6eQsgEtFzG34Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738640103; c=relaxed/simple;
	bh=BWG+XJj6NVSJYMNtUk9tJm/93ZBM6I88QxjkkFxizCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXJagbc1r+K8V4dONxhctAxhxyztDPHWaAx8Aut4A1JgaFidE7LW69tkMTDiKQWNX1weULtasfOxqxyN5sFEkA3y2jfRQMyAF6GqndqWNqHxPgoEcCTJRz589gsz2zMpil3s7tUmtPHta8NgrbS4KM5hBaduO2NTyX7x54mbRQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DujbAS6N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DujbAS6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D3AC4CEE2;
	Tue,  4 Feb 2025 03:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738640103;
	bh=BWG+XJj6NVSJYMNtUk9tJm/93ZBM6I88QxjkkFxizCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DujbAS6NDArgdAv8De44hGKpnFb06o5GqsZStx9XOpWmHrlhV7U2u8B5Tyk8Fk1no
	 cj23Jxfhb2hxU43+pFsKSkPW3gJwOGwzsMh/1daagNS9RA8gCbif3Au9KwdxicG3NW
	 NUmCYp9AwB5ypDtC0QDhfPfPoitONuFHZaI6zm7uvnLl1gatRdn++V5fa8BL0tiU+/
	 0Aqxwv0nAgu0lNblRdhefu715mCEbdxxsGJWtGSQ580k85zbo9q2WEBwy/d+M3uGtD
	 fRc/aMrtJohO3BwBycVK+VQMKbPYOpA1lrdGzhqTqCA9cYn+r0+KSByQoym2VSRbC7
	 Xt+iXMJCCY3qw==
Date: Mon, 3 Feb 2025 19:35:01 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH] perf test: Fix perf test 11 hwmon endianess issue
Message-ID: <Z6GK5TJR-H7P9wUI@google.com>
References: <20250131112400.568975-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250131112400.568975-1-tmricht@linux.ibm.com>

On Fri, Jan 31, 2025 at 12:24:00PM +0100, Thomas Richter wrote:
> perf test 11 hwmon fails on s390 with this error
> 
>  # ./perf test -Fv 11
>  --- start ---
>  ---- end ----
>  11.1: Basic parsing test             : Ok
>  --- start ---
>  Testing 'temp_test_hwmon_event1'
>  Using CPUID IBM,3931,704,A01,3.7,002f
>  temp_test_hwmon_event1 -> hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
>  FAILED tests/hwmon_pmu.c:189 Unexpected config for
>     'temp_test_hwmon_event1', 292470092988416 != 655361
>  ---- end ----
>  11.2: Parsing without PMU name       : FAILED!
>  --- start ---
>  Testing 'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/'
>  FAILED tests/hwmon_pmu.c:189 Unexpected config for
>     'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/',
>     292470092988416 != 655361
>  ---- end ----
>  11.3: Parsing with PMU name          : FAILED!
>  #
> 
> The root cause is in member test_event::config which is initialized
> to 0xA0001 or 655361. During event parsing a long list event parsing
> functions are called and end up with this gdb call stack:
> 
>  #0  hwmon_pmu__config_term (hwm=0x168dfd0, attr=0x3ffffff5ee8,
> 	term=0x168db60, err=0x3ffffff81c8) at util/hwmon_pmu.c:623
>  #1  hwmon_pmu__config_terms (pmu=0x168dfd0, attr=0x3ffffff5ee8,
> 	terms=0x3ffffff5ea8, err=0x3ffffff81c8) at util/hwmon_pmu.c:662
>  #2  0x00000000012f870c in perf_pmu__config_terms (pmu=0x168dfd0,
> 	attr=0x3ffffff5ee8, terms=0x3ffffff5ea8, zero=false,
> 	apply_hardcoded=false, err=0x3ffffff81c8) at util/pmu.c:1519
>  #3  0x00000000012f88a4 in perf_pmu__config (pmu=0x168dfd0, attr=0x3ffffff5ee8,
> 	head_terms=0x3ffffff5ea8, apply_hardcoded=false, err=0x3ffffff81c8)
> 	at util/pmu.c:1545
>  #4  0x00000000012680c4 in parse_events_add_pmu (parse_state=0x3ffffff7fb8,
> 	list=0x168dc00, pmu=0x168dfd0, const_parsed_terms=0x3ffffff6090,
> 	auto_merge_stats=true, alternate_hw_config=10)
> 	at util/parse-events.c:1508
>  #5  0x00000000012684c6 in parse_events_multi_pmu_add (parse_state=0x3ffffff7fb8,
> 	event_name=0x168ec10 "temp_test_hwmon_event1", hw_config=10,
> 	const_parsed_terms=0x0, listp=0x3ffffff6230, loc_=0x3ffffff70e0)
> 	at util/parse-events.c:1592
>  #6  0x00000000012f0e4e in parse_events_parse (_parse_state=0x3ffffff7fb8,
> 	scanner=0x16878c0) at util/parse-events.y:293
>  #7  0x00000000012695a0 in parse_events__scanner (str=0x3ffffff81d8
> 	"temp_test_hwmon_event1", input=0x0, parse_state=0x3ffffff7fb8)
> 	at util/parse-events.c:1867
>  #8  0x000000000126a1e8 in __parse_events (evlist=0x168b580,
> 	str=0x3ffffff81d8 "temp_test_hwmon_event1", pmu_filter=0x0,
> 	err=0x3ffffff81c8, fake_pmu=false, warn_if_reordered=true,
> 	fake_tp=false) at util/parse-events.c:2136
>  #9  0x00000000011e36aa in parse_events (evlist=0x168b580,
> 	str=0x3ffffff81d8 "temp_test_hwmon_event1", err=0x3ffffff81c8)
> 	at /root/linux/tools/perf/util/parse-events.h:41
>  #10 0x00000000011e3e64 in do_test (i=0, with_pmu=false, with_alias=false)
> 	at tests/hwmon_pmu.c:164
>  #11 0x00000000011e422c in test__hwmon_pmu (with_pmu=false)
> 	at tests/hwmon_pmu.c:219
>  #12 0x00000000011e431c in test__hwmon_pmu_without_pmu (test=0x1610368
> 	<suite.hwmon_pmu>, subtest=1) at tests/hwmon_pmu.c:23
> 
> where the attr::config is set to value 292470092988416 or 0x10a0000000000
> in line 625 of file ./util/hwmon_pmu.c:
> 
>    attr->config = key.type_and_num;
> 
> However member key::type_and_num is defined as union and bit field:
> 
>    union hwmon_pmu_event_key {
>         long type_and_num;
>         struct {
>                 int num :16;
>                 enum hwmon_type type :8;
>         };
>    };
> 
> s390 is big endian and Intel is little endian architecture.
> The events for the hwmon dummy pmu have num = 1 or num = 2 and
> type is set to HWMON_TYPE_TEMP (which is 10).
> On s390 this assignes member key::type_and_num the value of
> 0x10a0000000000 (which is 292470092988416) as shown in above
> trace output.
> 
> Fix this and export the structure/union hwmon_pmu_event_key
> so the test shares the same implementation as the event parsing
> functions for union and bit fields. This should avoid
> endianess issues on all platforms.
> 
> Output after:
>  # ./perf test -F 11
>  11.1: Basic parsing test         : Ok
>  11.2: Parsing without PMU name   : Ok
>  11.3: Parsing with PMU name      : Ok
>  #
> 
> Fixes: 531ee0fd4836 ("perf test: Add hwmon "PMU" test")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/tests/hwmon_pmu.c | 16 +++++++++++-----
>  tools/perf/util/hwmon_pmu.c  | 14 --------------
>  tools/perf/util/hwmon_pmu.h  | 16 ++++++++++++++++
>  3 files changed, 27 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
> index d2b066a2b557..0837aca1cdfa 100644
> --- a/tools/perf/tests/hwmon_pmu.c
> +++ b/tools/perf/tests/hwmon_pmu.c
> @@ -13,17 +13,23 @@
>  static const struct test_event {
>  	const char *name;
>  	const char *alias;
> -	long config;
> +	union hwmon_pmu_event_key key;
>  } test_events[] = {
>  	{
>  		"temp_test_hwmon_event1",
>  		"temp1",
> -		0xA0001,
> +		.key = {
> +			.num = 1,
> +			.type = 10
> +		},
>  	},
>  	{
>  		"temp_test_hwmon_event2",
>  		"temp2",
> -		0xA0002,
> +		.key = {
> +			.num = 2,
> +			.type = 10
> +		},
>  	},
>  };
>  
> @@ -183,11 +189,11 @@ static int do_test(size_t i, bool with_pmu, bool with_alias)
>  		    strcmp(evsel->pmu->name, "hwmon_a_test_hwmon_pmu"))
>  			continue;
>  
> -		if (evsel->core.attr.config != (u64)test_events[i].config) {
> +		if (evsel->core.attr.config != (u64)test_events[i].key.type_and_num) {
>  			pr_debug("FAILED %s:%d Unexpected config for '%s', %lld != %ld\n",
>  				__FILE__, __LINE__, str,
>  				evsel->core.attr.config,
> -				test_events[i].config);
> +				test_events[i].key.type_and_num);
>  			ret = TEST_FAIL;
>  			goto out;
>  		}
> diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> index 4acb9bb19b84..acd889b2462f 100644
> --- a/tools/perf/util/hwmon_pmu.c
> +++ b/tools/perf/util/hwmon_pmu.c
> @@ -107,20 +107,6 @@ struct hwmon_pmu {
>  	int hwmon_dir_fd;
>  };
>  
> -/**
> - * union hwmon_pmu_event_key: Key for hwmon_pmu->events as such each key
> - * represents an event.
> - *
> - * Related hwmon files start <type><number> that this key represents.
> - */
> -union hwmon_pmu_event_key {
> -	long type_and_num;
> -	struct {
> -		int num :16;
> -		enum hwmon_type type :8;
> -	};
> -};
> -
>  /**
>   * struct hwmon_pmu_event_value: Value in hwmon_pmu->events.
>   *
> diff --git a/tools/perf/util/hwmon_pmu.h b/tools/perf/util/hwmon_pmu.h
> index 882566846df4..b3329774d2b2 100644
> --- a/tools/perf/util/hwmon_pmu.h
> +++ b/tools/perf/util/hwmon_pmu.h
> @@ -91,6 +91,22 @@ enum hwmon_item {
>  	HWMON_ITEM__MAX,
>  };
>  
> +/**
> + * union hwmon_pmu_event_key: Key for hwmon_pmu->events as such each key
> + * represents an event.
> + * union is exposed for testing to ensure problems are avoided on big
> + * endian machines.
> + *
> + * Related hwmon files start <type><number> that this key represents.
> + */
> +union hwmon_pmu_event_key {
> +	long type_and_num;
> +	struct {
> +		int num :16;
> +		enum hwmon_type type :8;

I'm curious if we could add this maybe as a follow-up.

		int unused: 8;
#if __SIZEOF_LONG__ == 8
		int unused2;
#endif

Thanks,
Namhyung


> +	};
> +};
> +
>  bool perf_pmu__is_hwmon(const struct perf_pmu *pmu);
>  bool evsel__is_hwmon(const struct evsel *evsel);
>  
> -- 
> 2.48.1
> 

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3B82253EB;
	Thu, 19 Mar 2026 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773906807; cv=none; b=hotD1ZVK9uBBAXEUsPUnTnro6jYkTsNOhUMRAN9O1BESc+LXkvTm7M1wnJnCReDMGc4OuxNY3j7XjkPMTuTcyeKIQP1ZwXVfgtDdh6SEYd0PNTXSpFsw+PU33d2UeNy4O0UMzTcTgKWtWe0SfCr23hY4ck4hGBN2e88r2T4B7VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773906807; c=relaxed/simple;
	bh=PEKB3DOSkBKghLJh1fWKJ8Wke9VmRBPhnGrVcYkRMos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiro/v+2DQFgEd4DXcWqFsjrvSy9nffQ/AC0MFqMA5Sq/9n+t+OPexACzEV6jjK+RFZxSbDILyor6WYclWmYJMn6SkVfDfNxBVRhSDA2EdFkAFK3CW+Nzp7LOt1cHsL6YyyF8TdXdqhNeVQly1Q+ubWx1vFN8EyOu7qTzH9LAGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DmgTUDwi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DmgTUDwi"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J23t6r1188759;
	Thu, 19 Mar 2026 07:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kLJzDQ
	wB96xe+KSAvMa6istqUWqn2RuxZbrvNE5aqE0=; b=DmgTUDwirfZld0OzlyQ8VC
	S5lcqsSTdk72E4Ao0OB5mMo7XjM6bMP5IR4lUgQc0uGAUi+h1Ym2n0GSiKeRFFXc
	b8Z+d5x63qbEoba19lA2YfyhYABgp3dmFHBkuYhIz7zIduoy/kvOHVSfzpZVHBCs
	DbHY7jyDK7vauPrHlkWRZNIP7+SZWiZG0WEf0ALL9Hnj3LsorKOSeet0X0j9IjjE
	8ky6SpksgsYO5LjKK1Q5U2VOyeChVI6WUKya6EWemzERvxvQ0B8JKoYt62N7wV1l
	K2Hm3nX3HpsRVydLaM3G/Wpu6/Z3iEBiDIbPrpthcXZP5I47YXzrLJvUwhea1LaA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfr4y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 07:53:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62J4S4dd015676;
	Thu, 19 Mar 2026 07:53:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0nhhb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 07:53:21 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62J7rH3K43712900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 07:53:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E71522008E;
	Thu, 19 Mar 2026 07:53:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CEFA20083;
	Thu, 19 Mar 2026 07:53:16 +0000 (GMT)
Received: from [9.111.17.237] (unknown [9.111.17.237])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Mar 2026 07:53:16 +0000 (GMT)
Message-ID: <b3d92726-d313-4d95-9777-8a3c3e41f56b@linux.ibm.com>
Date: Thu, 19 Mar 2026 08:53:15 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] perf evlist: Improve default event for s390
To: Ian Rogers <irogers@google.com>, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        japo@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org,
        sumanthk@linux.ibm.com
References: <20260318175808.582009-1-irogers@google.com>
 <20260318234600.730340-1-irogers@google.com>
 <20260318234600.730340-6-irogers@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260318234600.730340-6-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: zgaETeYPVz3gZqlrzKyCgfSQ3fdSmhex
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69bbab73 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=ItZninn63OV56wBhuS0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA1OSBTYWx0ZWRfX0saFB8Nqfmql
 WzSxM20nSvgS/QyAE1ox/BGsH6o6wh20p+FlvMYFr+QWye49VXzwgFFxqKDmstIR8NXAt2AlrKj
 g7YUVReHk9ts6HJZ90h9+1LH/wPI6c+u6W6hWzMc1N1yYsyP5OGqH1TXi23+MPtXaWdcamEq6RG
 1nRNju+aH7I4kNBuChqiMZoBxLK6mf8gpOJ9W8XP7jigYsIfCb6LwZHBoLXibl0wnzEQw3RqNwu
 +UGDAzlVAKzjrXaXu1xJkB4cbk4IyO+3bxMgJieb5Oc+xL6PLioWQLl0ePdht4gZ/DyNAs1WyQR
 2sZ9UmJyhcXXVWainaLc6uTTxWSaf8UpNhxgKuX+pWv8XgNlPaf5CD0gXCzDy88nbd5P2gcRh22
 rFLDnvHup4/w1Fw6875RLR1AsYAxJ/OQoK8zdZEumarcKBTwsAttf49AeLoFyxNi9tNvgWJTepd
 CSKnwJQUaymaUjWeFfQ==
X-Proofpoint-GUID: 4_J8FqTRymumOz4rF3KrWVuB02g0HOr6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190059

On 3/19/26 00:46, Ian Rogers wrote:
> Frame pointer callchains are not supported on s390 and dwarf
> callchains are only supported on software events.
> 
> Switch the default event from the hardware 'cycles' event to the
> software 'cpu-clock' or 'task-clock' on s390 if callchains are
> enabled. Move some of the target initialization earlier in builtin-top
> and builtin-record, so it is ready for use by evlist__new_default.
> 
> If frame pointer callchains are requested on s390 show a
> warning. Modify the '-g' option of `perf top` and `perf record` to
> default to dwarf callchains on s390.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/builtin-record.c      | 18 +++++++++++-------
>  tools/perf/builtin-top.c         | 23 ++++++++++++-----------
>  tools/perf/tests/event_update.c  |  4 +++-
>  tools/perf/tests/expand-cgroup.c |  4 +++-
>  tools/perf/tests/perf-record.c   |  7 +++++--
>  tools/perf/tests/topology.c      |  4 +++-
>  tools/perf/util/evlist.c         | 32 +++++++++++++++++++++-----------
>  tools/perf/util/evlist.h         |  2 +-
>  tools/perf/util/evsel.c          |  5 +++++
>  9 files changed, 64 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 59b8125d1b13..3276ffdc3141 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -55,6 +55,7 @@
>  #include "asm/bug.h"
>  #include "perf.h"
>  #include "cputopo.h"
> +#include "dwarf-regs.h"
>  
>  #include <errno.h>
>  #include <inttypes.h>
> @@ -2995,7 +2996,9 @@ static int record_callchain_opt(const struct option *opt,
>  		return 0;
>  	}
>  
> -	return record_opts__parse_callchain(opt->value, &callchain_param, "fp", unset);
> +	return record_opts__parse_callchain(opt->value, &callchain_param,
> +					    EM_HOST != EM_S390 ? "fp" : "dwarf",
> +					    unset);
>  }
>  
>  
> @@ -4095,8 +4098,11 @@ int cmd_record(int argc, const char **argv)
>  
>  	perf_debuginfod_setup(&record.debuginfod);
>  
> -	/* Make system wide (-a) the default target. */
> -	if (!argc && target__none(&rec->opts.target))
> +	/*
> +	 * Use system wide (-a) for the default target (ie. when no
> +	 * workload). User ID filtering also implies system-wide.
> +	 */
> +	if ((!argc && target__none(&rec->opts.target)) || rec->uid_str)
>  		rec->opts.target.system_wide = true;
>  
>  	if (nr_cgroups && !rec->opts.target.system_wide) {
> @@ -4274,7 +4280,8 @@ int cmd_record(int argc, const char **argv)
>  		record.opts.tail_synthesize = true;
>  
>  	if (rec->evlist->core.nr_entries == 0) {
> -		struct evlist *def_evlist = evlist__new_default();
> +		struct evlist *def_evlist = evlist__new_default(&rec->opts.target,
> +								callchain_param.enabled);
>  
>  		if (!def_evlist)
>  			goto out;
> @@ -4303,9 +4310,6 @@ int cmd_record(int argc, const char **argv)
>  		err = parse_uid_filter(rec->evlist, uid);
>  		if (err)
>  			goto out;
> -
> -		/* User ID filtering implies system wide. */
> -		rec->opts.target.system_wide = true;
>  	}
>  
>  	/* Enable ignoring missing threads when -p option is defined. */
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index b6726f4dffb3..37950efb28ac 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -56,6 +56,7 @@
>  #include "util/debug.h"
>  #include "util/ordered-events.h"
>  #include "util/pfm.h"
> +#include "dwarf-regs.h"
>  
>  #include <assert.h>
>  #include <elf.h>
> @@ -1420,7 +1421,7 @@ callchain_opt(const struct option *opt, const char *arg __maybe_unused, int unse
>  		return 0;
>  	}
>  
> -	return parse_callchain_opt(opt, "fp", unset);
> +	return parse_callchain_opt(opt, EM_HOST != EM_S390 ? "fp" : "dwarf", unset);
>  }
>  
>  
> @@ -1705,8 +1706,17 @@ int cmd_top(int argc, const char **argv)
>  	if (annotate_check_args() < 0)
>  		goto out_delete_evlist;
>  
> +	status = target__validate(target);
> +	if (status) {
> +		target__strerror(target, status, errbuf, BUFSIZ);
> +		ui__warning("%s\n", errbuf);
> +	}
> +
> +	if (target__none(target))
> +		target->system_wide = true;
> +
>  	if (!top.evlist->core.nr_entries) {
> -		struct evlist *def_evlist = evlist__new_default();
> +		struct evlist *def_evlist = evlist__new_default(target, callchain_param.enabled);
>  
>  		if (!def_evlist)
>  			goto out_delete_evlist;
> @@ -1799,12 +1809,6 @@ int cmd_top(int argc, const char **argv)
>  		goto out_delete_evlist;
>  	}
>  
> -	status = target__validate(target);
> -	if (status) {
> -		target__strerror(target, status, errbuf, BUFSIZ);
> -		ui__warning("%s\n", errbuf);
> -	}
> -
>  	if (top.uid_str) {
>  		uid_t uid = parse_uid(top.uid_str);
>  
> @@ -1818,9 +1822,6 @@ int cmd_top(int argc, const char **argv)
>  			goto out_delete_evlist;
>  	}
>  
> -	if (target__none(target))
> -		target->system_wide = true;
> -
>  	if (evlist__create_maps(top.evlist, target) < 0) {
>  		ui__error("Couldn't create thread/CPU maps: %s\n",
>  			  errno == ENOENT ? "No such process" : str_error_r(errno, errbuf, sizeof(errbuf)));
> diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
> index cb9e6de2e033..facc65e29f20 100644
> --- a/tools/perf/tests/event_update.c
> +++ b/tools/perf/tests/event_update.c
> @@ -8,6 +8,7 @@
>  #include "header.h"
>  #include "machine.h"
>  #include "util/synthetic-events.h"
> +#include "target.h"
>  #include "tool.h"
>  #include "tests.h"
>  #include "debug.h"
> @@ -81,7 +82,8 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
>  {
>  	struct evsel *evsel;
>  	struct event_name tmp;
> -	struct evlist *evlist = evlist__new_default();
> +	struct target target = {};
> +	struct evlist *evlist = evlist__new_default(&target, /*sample_callchains=*/false);
>  
>  	TEST_ASSERT_VAL("failed to get evlist", evlist);
>  
> diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
> index c7b32a220ca1..dd547f2f77cc 100644
> --- a/tools/perf/tests/expand-cgroup.c
> +++ b/tools/perf/tests/expand-cgroup.c
> @@ -8,6 +8,7 @@
>  #include "parse-events.h"
>  #include "pmu-events/pmu-events.h"
>  #include "pfm.h"
> +#include "target.h"
>  #include <subcmd/parse-options.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -99,7 +100,8 @@ out:	for (i = 0; i < nr_events; i++)
>  static int expand_default_events(void)
>  {
>  	int ret;
> -	struct evlist *evlist = evlist__new_default();
> +	struct target target = {};
> +	struct evlist *evlist = evlist__new_default(&target, /*sample_callchains=*/false);
>  
>  	TEST_ASSERT_VAL("failed to get evlist", evlist);
>  
> diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
> index efbd9cd60c63..c6e31ab8a6b8 100644
> --- a/tools/perf/tests/perf-record.c
> +++ b/tools/perf/tests/perf-record.c
> @@ -84,8 +84,11 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
>  	CPU_ZERO_S(cpu_mask_size, cpu_mask);
>  
>  	perf_sample__init(&sample, /*all=*/false);
> -	if (evlist == NULL) /* Fallback for kernels lacking PERF_COUNT_SW_DUMMY */
> -		evlist = evlist__new_default();
> +	if (evlist == NULL) { /* Fallback for kernels lacking PERF_COUNT_SW_DUMMY */
> +		struct target target = {};
> +
> +		evlist = evlist__new_default(&target, /*sample_callchains=*/false);
> +	}
>  
>  	if (evlist == NULL) {
>  		pr_debug("Not enough memory to create evlist\n");
> diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
> index ec01150d208d..a34a7ab19a80 100644
> --- a/tools/perf/tests/topology.c
> +++ b/tools/perf/tests/topology.c
> @@ -9,6 +9,7 @@
>  #include "evlist.h"
>  #include "debug.h"
>  #include "pmus.h"
> +#include "target.h"
>  #include <linux/err.h>
>  
>  #define TEMPL "/tmp/perf-test-XXXXXX"
> @@ -37,11 +38,12 @@ static int session_write_header(char *path)
>  		.path = path,
>  		.mode = PERF_DATA_MODE_WRITE,
>  	};
> +	struct target target = {};
>  
>  	session = perf_session__new(&data, NULL);
>  	TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
>  
> -	session->evlist = evlist__new_default();
> +	session->evlist = evlist__new_default(&target, /*sample_callchains=*/false);
>  	TEST_ASSERT_VAL("can't get evlist", session->evlist);
>  	session->evlist->session = session;
>  
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 591bdf0b3e2a..c702741a9173 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -13,6 +13,7 @@
>  #include "util/mmap.h"
>  #include "thread_map.h"
>  #include "target.h"
> +#include "dwarf-regs.h"
>  #include "evlist.h"
>  #include "evsel.h"
>  #include "record.h"
> @@ -98,38 +99,47 @@ struct evlist *evlist__new(void)
>  	return evlist;
>  }
>  
> -struct evlist *evlist__new_default(void)
> +struct evlist *evlist__new_default(const struct target *target, bool sample_callchains)
>  {
>  	struct evlist *evlist = evlist__new();
>  	bool can_profile_kernel;
>  	struct perf_pmu *pmu = NULL;
> +	struct evsel *evsel;
> +	char buf[256];
> +	int err;
>  
>  	if (!evlist)
>  		return NULL;
>  
>  	can_profile_kernel = perf_event_paranoid_check(1);
>  
> -	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
> -		char buf[256];
> -		int err;
> -
> -		snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
> +	if (EM_HOST == EM_S390 && sample_callchains) {
> +		snprintf(buf, sizeof(buf), "software/%s/%s",
> +			 target__has_cpu(target) ? "cpu-clock" : "task-clock",
>  			 can_profile_kernel ? "P" : "Pu");
>  		err = parse_event(evlist, buf);
> -		if (err) {
> -			evlist__delete(evlist);
> -			return NULL;
> +		if (err)
> +			goto out_err;
> +	} else {
> +		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
> +			snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
> +				can_profile_kernel ? "P" : "Pu");
> +			err = parse_event(evlist, buf);
> +			if (err)
> +				goto out_err;
>  		}
>  	}
>  
> +	/* If there is only 1 event a sample identifier isn't necessary. */
>  	if (evlist->core.nr_entries > 1) {
> -		struct evsel *evsel;
> -
>  		evlist__for_each_entry(evlist, evsel)
>  			evsel__set_sample_id(evsel, /*can_sample_identifier=*/false);
>  	}
>  
>  	return evlist;
> +out_err:
> +	evlist__delete(evlist);
> +	return NULL;
>  }
>  
>  struct evlist *evlist__new_dummy(void)
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index d17c3b57a409..e507f5f20ef6 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -104,7 +104,7 @@ struct evsel_str_handler {
>  };
>  
>  struct evlist *evlist__new(void);
> -struct evlist *evlist__new_default(void);
> +struct evlist *evlist__new_default(const struct target *target, bool sample_callchains);
>  struct evlist *evlist__new_dummy(void);
>  void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
>  		  struct perf_thread_map *threads);
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 54c8922a8e47..5a294595a677 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1021,6 +1021,11 @@ static void __evsel__config_callchain(struct evsel *evsel, const struct record_o
>  	bool function = evsel__is_function_event(evsel);
>  	struct perf_event_attr *attr = &evsel->core.attr;
>  
> +	if (EM_HOST == EM_S390 && param->record_mode == CALLCHAIN_FP) {
> +		pr_warning_once(
> +			"Framepointer unwinding lacks kernel support. Use '--call-graph dwarf'\n");
> +	}
> +
>  	evsel__set_sample_bit(evsel, CALLCHAIN);
>  
>  	attr->sample_max_stack = param->max_stack;

Ian,

again Thanks very much.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

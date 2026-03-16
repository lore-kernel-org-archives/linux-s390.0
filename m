Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017E5395DB5;
	Mon, 16 Mar 2026 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773663199; cv=none; b=Z2tTsy71zjgCyj9qMFSshE+zIC8GYU/G43C2AGIzueAqQr4x2GFtQwozvv2hL8/6iTlqH6gQG7bBBbzhw6fOcYCE/baieEfLNEkmiqut2xmWOO7xmhY6+C/U+abXqLBMBliHO70foelpKWyqCUGO43+fOFuHNsb0X9sw0qR39WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773663199; c=relaxed/simple;
	bh=88S8/0i83dlqrJjT2MbvpG5Jo17wiItc++sT9jlDABA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtwaJbCzSJrDXIk9TUvMOogvBKCjxqRKr+KddYjt6IPaUvMQDlLp48UM7Uz0sZi5VJAGE9ttq9/5ji+ccJ4zT4JfHGMNHDjCu1+u8g/F2TdVNfXDcQeG5DlEvHLrgPXDyoesYEm1RoPsg9EtbzITlSnxZX2zIR3zZ3ARv9cVJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HfWj4N7b; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HfWj4N7b"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FNk0r51363601;
	Mon, 16 Mar 2026 12:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bRjZ+H
	bmCwmN2NCDq8j5UX5mwx+VaqKP+RvUKkDYcJw=; b=HfWj4N7bJqjIWvvxDcbWd6
	LBMgZIaSuNMbouOHdHCY4ssaLgHe0aFPzwfkiTsUpqMrd6PY26v/KpV+T0xHMW+g
	vyLtlET+vxXu2rbxIZ0ZRnwYaTIp5HYRvXY+cC5eQ9FoSAlLIbBQUzOSV8DbF/vE
	gCf3vlfnu82qLWRCaZgZSR8J+4hEYqIGBMTR0ivJxUBRR/ykIsyrFklgIv8JNv4A
	nRObdHCviz8lmglXNQEtiQdkpigtcxVYazl+m7apOCbnq3M/en4RvgmpxOjYZuV7
	B58dfWBdeoMqRsfBWarGNpK07DojI0UaLGKGMcmAI4VnaLV79cjmD8eGuP8aE5eA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64fsa7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 12:13:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GBoXIx028510;
	Mon, 16 Mar 2026 12:13:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq14gpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 12:13:12 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GCD9TH47907298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 12:13:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FE9D20043;
	Mon, 16 Mar 2026 12:13:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A800B20040;
	Mon, 16 Mar 2026 12:13:08 +0000 (GMT)
Received: from [9.111.90.13] (unknown [9.111.90.13])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 12:13:08 +0000 (GMT)
Message-ID: <6e9e5208-3e92-48f4-81fb-d37e5c0080ae@linux.ibm.com>
Date: Mon, 16 Mar 2026 13:13:08 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] perf evlist: Improve default event for s390
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org,
        namhyung@kernel.org, sumanthk@linux.ibm.com
References: <20260312061628.1593105-1-irogers@google.com>
 <20260313202811.2599195-1-irogers@google.com>
 <20260313202811.2599195-4-irogers@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260313202811.2599195-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: sv7XyqkG_mLFRVWOfkmNpWTZz3fTtbwE
X-Proofpoint-GUID: 7_6DgbesUrf5GZXRzq2IZsx26oFfmjMg
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69b7f3da cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=y1uQG0x6g7_J814r8qQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5MyBTYWx0ZWRfXzYKlesd7r5g3
 2/p09gRSfU0RTRhrc4boN6am/90n6BAwcTWHufc4ZRdCPOHr4LW2mH/J+ESrqAxqYaapNxz+vYO
 mb5r2Ak8U59luvTP3qeeP5CwfQKeomiH2bfA5psQmAII4y7EJ2P6UajhotLdARD5U6wcS+nNDVX
 imzkceYoyiifwgMEnVU2PWT/yVvnxtWXIpQKhIvi3dnBlmkm5eAEZAAYxO6FPyvr91Ou/ejFbqm
 VPam3MdtZi3NWQVkNalyoDWzQA1i2NGROJU8WAiePap10SUsENdxcIHr4h1RYeWwuRyuRjlbOBs
 8QmVZbyv6cR8O+8M7d6ob+WLm0OT3Zq3tzPuZWA/azf+aWigTPhKmfQMUfKSl9E0WviNLYzeuzA
 559XdH+NZ9hc6UC2jHqnbngjJAz5zBhL2DMi2ZxCcIRDi1xbqqu/sC62/VOXPrWV2xAD0e5oa47
 rzb22D+dvkVeQiIvVYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160093

On 3/13/26 21:28, Ian Rogers wrote:
> Frame pointer callchains are not supported on s390 and dwarf
> callchains are only supported on software events.
> 
> Switch the default event from cycles to cpu-clock or task-clock on
> s390 if callchains are enabled.
> 
> If frame pointer callchains are requested on s390, warn and switch to
> dwarf callchains.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-record.c      |  3 ++-
>  tools/perf/builtin-top.c         |  2 +-
>  tools/perf/tests/event_update.c  |  4 +++-
>  tools/perf/tests/expand-cgroup.c |  4 +++-
>  tools/perf/tests/perf-record.c   |  7 ++++--
>  tools/perf/tests/topology.c      |  4 +++-
>  tools/perf/util/evlist.c         | 37 +++++++++++++++++++-------------
>  tools/perf/util/evlist.h         |  2 +-
>  tools/perf/util/evsel.c          | 11 ++++++++--
>  9 files changed, 49 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 60d764068302..07ecc8a5fec7 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -4310,7 +4310,8 @@ int cmd_record(int argc, const char **argv)
>  		record.opts.tail_synthesize = true;
>  
>  	if (rec->evlist->core.nr_entries == 0) {
> -		struct evlist *def_evlist = evlist__new_default();
> +		struct evlist *def_evlist = evlist__new_default(&rec->opts.target,
> +								callchain_param.enabled);
>  
>  		if (!def_evlist)
>  			goto out;
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 710604c4f6f6..58bab595b024 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1695,7 +1695,7 @@ int cmd_top(int argc, const char **argv)
>  		goto out_delete_evlist;
>  
>  	if (!top.evlist->core.nr_entries) {
> -		struct evlist *def_evlist = evlist__new_default();
> +		struct evlist *def_evlist = evlist__new_default(target, callchain_param.enabled);
>  
>  		if (!def_evlist)
>  			goto out_delete_evlist;
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
> index 591bdf0b3e2a..e6c518cc4a69 100644
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
> @@ -98,38 +99,44 @@ struct evlist *evlist__new(void)
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
> -	if (evlist->core.nr_entries > 1) {
> -		struct evsel *evsel;
> -
> -		evlist__for_each_entry(evlist, evsel)
> -			evsel__set_sample_id(evsel, /*can_sample_identifier=*/false);
> -	}
> +	evlist__for_each_entry(evlist, evsel)
> +		evsel__set_sample_id(evsel, /*can_sample_identifier=*/false);
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
> index bd14d9bbc91f..caa95dc06ac5 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1020,6 +1020,13 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
>  {
>  	bool function = evsel__is_function_event(evsel);
>  	struct perf_event_attr *attr = &evsel->core.attr;
> +	enum perf_call_graph_mode record_mode = param->record_mode;
> +
> +	if (EM_HOST == EM_S390 && param->record_mode == CALLCHAIN_FP) {
> +		pr_warning("Framepointer unwinding switched to dwarf due to a lack of kernel support.\n"
> +			   "Use '--call-graph dwarf' to silence this warning.\n");
> +		record_mode = CALLCHAIN_DWARF;
> +	}
>  
>  	evsel__set_sample_bit(evsel, CALLCHAIN);
>  
> @@ -1029,7 +1036,7 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
>  		attr->exclude_callchain_user = 1;
>  	if (opts->user_callchains)
>  		attr->exclude_callchain_kernel = 1;
> -	if (param->record_mode == CALLCHAIN_LBR) {
> +	if (record_mode == CALLCHAIN_LBR) {
>  		if (!opts->branch_stack) {
>  			if (attr->exclude_user) {
>  				pr_warning("LBR callstack option is only available "
> @@ -1048,7 +1055,7 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
>  				    "Falling back to framepointers.\n");
>  	}
>  
> -	if (param->record_mode == CALLCHAIN_DWARF) {
> +	if (record_mode == CALLCHAIN_DWARF) {
>  		if (!function) {
>  			uint16_t e_machine = evsel__e_machine(evsel, /*e_flags=*/NULL);
>  

Ian, Thanks very much.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>

The fall back to cpu-clock works nicely when --call-graph or -g is specified on s390.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A403E33F370;
	Tue, 17 Mar 2026 07:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733954; cv=none; b=TGwArUWt0zWvIwf5YWg7vl9G6G8v3QIlBXeQGvWr9yjjaDhxE0K52Bxn1VMXEoC8ILvkruv6rcaui8mF741x62y5O2fW8hhHP+1y85T8af7ceJuueuYRjfHBXMUUisfqQuJ19dv09L2CmziPSJaH+ZzQIkZgY9n4QDMZ4S1WsSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733954; c=relaxed/simple;
	bh=uBaESwmycrWrTRKSSAuGLAPUHANTLMiQC/xnz7TKlu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nl+9KNqiXYc41OF5PU2NpS3UxFl3OCDaU51IlDgM94yztEFTQkKDkaM9A2WoGuDww3356JgVwUnaMj4URgCUhvz30C6ibntawGVhnrxukCjWMVLn26FR+G6eSqVK60vJY22g43WZrxtdx4Gmw5KZvZVlT2c1sBmtomWjV4hEcE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e/60dEBH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e/60dEBH"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H6dOkb231841;
	Tue, 17 Mar 2026 07:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cw89Ki
	Wod8luehAQAkMUSahhQA1jbRX1OqQUsB1vCmE=; b=e/60dEBHj6S0bCnC36K7kc
	+/HaELWZDFsrrja5ShepsPkrcLNLLkaMQzPeBQGc7JcDVNio5KUqL6Z8koLNVZDk
	0khyJjH/dLsokKqhKmiHw4coibA0Y0nSGYURZChxCMTGNk+27KPwFJNxgVL85wn/
	p5t/ng62S+m9WvxCwvT9LkW4VaVgmm1fbvwDJxhhAnF8ycVyYgMp+w9C3LFLJ3C4
	1TGC0xQbKWwxSjWhdCXMF8zJJ9DfIEMig+wXFAUJ6luAqbVToXgajmLhBjUYoJ/H
	cqTiRP/YgaR3cwq1quZ+Qov9oqTmPBr7ZPpLRjLkqLWJZpABQtumcjT7FsnM7ezA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs3kw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 07:52:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62H6d2vq013996;
	Tue, 17 Mar 2026 07:52:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcy07r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 07:52:16 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62H7qCEN36110714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 07:52:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2589B20063;
	Tue, 17 Mar 2026 07:52:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC9A72004B;
	Tue, 17 Mar 2026 07:52:11 +0000 (GMT)
Received: from [9.52.199.37] (unknown [9.52.199.37])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 07:52:11 +0000 (GMT)
Message-ID: <e8087f8c-09e8-4204-a9c9-fc635d0453b5@linux.ibm.com>
Date: Tue, 17 Mar 2026 08:52:11 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] perf evlist: Improve default event for s390
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org,
        namhyung@kernel.org, sumanthk@linux.ibm.com
References: <20260317030601.567422-1-irogers@google.com>
 <20260317055334.760347-1-irogers@google.com>
 <20260317055334.760347-6-irogers@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260317055334.760347-6-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b90831 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=bqfBD2JWZyNg3Hh1bRcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rHFHrB4jP-50V9eIE9_rNreOQexot1fi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA2NiBTYWx0ZWRfX+BNh8jOSv0sc
 0XfbnFJscvRRhD5/KNk/apk1ntTKYuEVCrlwXo+GWXZFnppibPCdQD1PmPL0ILVyOiaDK+Atri+
 +ezsErSEtQanpHHKPtCvx3xVprQWIEczb3LQyVdZMhVSJVw+vLik4WO5e0yrKcgi5XKJksMJEJ/
 fYWb4Sm5PWRLEvhA2Fa3QsZBbnftbu/9agCTSkNSKC4LPqTL7PasnMS13ZFQgXr6932wnxec7qx
 BWQF5LB06Z4z+P7q1hh3ErLtWEEj71tQS1zgvdjaH9w+jsLFraXgS4DsTc6+X1U+J2uowVTsym3
 hB5SNf8e5RnIAsbciJNy2do7TeBYggx0XaWzXCduNSh1+9mm1Gexk7A7jrnmfRP/tMI2xX0j0jz
 PNd57Rjx7dHZel/H7vTnYtUzJ5ejFTN9E32TWweaU8WQ7/MrZC46vFOHx855ylgPOZxLP8CZYbI
 eKrrD7ha3z0dUsi76EQ==
X-Proofpoint-GUID: 7xlHs3jLz7sGMDSDn0R2rs4XOi7T5Wfg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170066

On 3/17/26 06:53, Ian Rogers wrote:
> Frame pointer callchains are not supported on s390 and dwarf
> callchains are only supported on software events.
> 
> Switch the default event from cycles to cpu-clock or task-clock on
> s390 if callchains are enabled.
> 
> If frame pointer callchains are requested on s390 show a
> warning. Modify the '-g' option of `perf top` and `perf record` to
> default to dwarf callchains on s390.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-record.c      |  8 ++++++--
>  tools/perf/builtin-top.c         |  5 +++--
>  tools/perf/tests/event_update.c  |  4 +++-
>  tools/perf/tests/expand-cgroup.c |  4 +++-
>  tools/perf/tests/perf-record.c   |  7 +++++--
>  tools/perf/tests/topology.c      |  4 +++-
>  tools/perf/util/evlist.c         | 32 +++++++++++++++++++++-----------
>  tools/perf/util/evlist.h         |  2 +-
>  tools/perf/util/evsel.c          |  5 +++++
>  9 files changed, 50 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index af1fe6b7c65c..ef97c7a54088 100644
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
> @@ -2986,7 +2987,9 @@ static int record_callchain_opt(const struct option *opt,
>  				const char *arg __maybe_unused,
>  				int unset)
>  {
> -	return record_opts__parse_callchain(opt->value, &callchain_param, "fp", unset);
> +	return record_opts__parse_callchain(opt->value, &callchain_param,
> +					    EM_HOST != EM_S390 ? "fp" : "dwarf",
> +					    unset);
>  }
>  
>  
> @@ -4265,7 +4268,8 @@ int cmd_record(int argc, const char **argv)
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
> index 2a949d956d0b..84211a78977e 100644
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
> @@ -1409,7 +1410,7 @@ parse_callchain_opt(const struct option *opt, const char *arg, int unset)
>  static int
>  callchain_opt(const struct option *opt, const char *arg __maybe_unused, int unset)
>  {
> -	return parse_callchain_opt(opt, "fp", unset);
> +	return parse_callchain_opt(opt, EM_HOST != EM_S390 ? "fp" : "dwarf", unset);
>  }
>  
>  
> @@ -1695,7 +1696,7 @@ int cmd_top(int argc, const char **argv)
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

Great, here is the output on my LPAR. Thanks very much fpr addressing and fixing this!!!

root in 🌐 b83lp69 in mirror-linux-next/tools/perf on  master [⇡] via C v15.2.1-gcc took 2s 
❯ ./perf record  --call-graph dwarf  -- perf test -w noploop
[ perf record: Woken up 133 times to write data ]
[ perf record: Captured and wrote 32.928 MB perf.data (4039 samples) ]

root in 🌐 b83lp69 in mirror-linux-next/tools/perf on  master [⇡] via C v15.2.1-gcc took 2s 
❯ ./perf evlist
software/task-clock/P

root in 🌐 b83lp69 in mirror-linux-next/tools/perf on  master [⇡] via C v15.2.1-gcc 
❯ ./perf record  -g -- perf test -w noploop
[ perf record: Woken up 133 times to write data ]
[ perf record: Captured and wrote 32.952 MB perf.data (4042 samples) ]

root in 🌐 b83lp69 in mirror-linux-next/tools/perf on  master [⇡] via C v15.2.1-gcc took 2s 
❯ ./perf evlist
software/task-clock/P

root in 🌐 b83lp69 in mirror-linux-next/tools/perf on  master [⇡] via C v15.2.1-gcc 
❯ ./perf record  -- perf test -w noploop
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.179 MB perf.data (3974 samples) ]

root in 🌐 b83lp69 in mirror-linux-next/tools/perf on  master [⇡] via C v15.2.1-gcc took 2s 
❯ ./perf evlist
cpum_cf/cycles/P

root in 🌐 b83lp69 in mirror-linux-next/tools/perf on  master [⇡] via C v15.2.1-gcc 
❯ ./perf record  
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.250 MB perf.data (24 samples) ]


root in 🌐 b83lp69 in mirror-linux-next/tools/perf on  master [⇡] via C v15.2.1-gcc took 3s 
❯ ./perf evlist
cpum_cf/cycles/P
dummy:u

root in 🌐 b83lp69 in mirror-linux-next/tools/perf on  master [⇡] via C v15.2.1-gcc 
❯ ./perf record  -g
^C[ perf record: Woken up 8 times to write data ]
[ perf record: Captured and wrote 5.186 MB perf.data (34255 samples) ]


root in 🌐 b83lp69 in mirror-linux-next/tools/perf on  master [⇡] via C v15.2.1-gcc took 3s 
❯ ./perf evlist
software/cpu-clock/P
dummy:u


root in 🌐 b83lp69 in mirror-linux-next/tools/perf on  master [⇡] via C v15.2.1-gcc took 3s 
 
Tested-by:  Thomas Richter <tmricht@linux.ibm.com>
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

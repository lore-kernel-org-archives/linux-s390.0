Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12362797A4;
	Wed, 23 Jul 2025 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753258005; cv=none; b=VXv7DWPthCBIydKhIFWuB/sttzYbGZMMdF6gzQG5VJhG8sznXpmwAG3IxUy+yPMgrHIH67S/rlI5DhB62YgaDl/YzloZyPcJNYk85J4gGucipxLNwK1gCTbYmZHsTWpIdb3MteepBT/uLaBmxWXQqw8zXnZ4eCnBud9oWyPjLl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753258005; c=relaxed/simple;
	bh=7wxD8Yrjg6ZlsoNeZb1eFvzqUhJjLEB9d0SVb221OC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLdjmxlLgnFO4ZQMyvpNdnIoL0H2ydGg11wM6S9aJ5/S1jLmMKGxv4czOh+Jx4Iod3nbZlJFi+7DdgpGRe/e0VM+sHpmi0zvB9qLHZy2EPjzgGARyT0+PQmXhuH/0k3lP5NCHoDp5yfxlDsMhEyk+5WOOusNZLdcVfWPAqnFy8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c/ApPuz6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c/ApPuz6"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N5LmIv021999;
	Wed, 23 Jul 2025 08:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=58wkRkSKcLcDEF5ZpxWaTthSD+CKaD
	ykasPLRcT80yk=; b=c/ApPuz6OliBbckWbDjKtnmlPUcms020Ik98ZSaVtLrV/w
	GoJG8rTwwk9QieM14bFJokKaUQMo9RFIuCc9z5nYu+B565O0P0mWYuRZ6XuQ0o7y
	TcSd4qgXaCK+nvVkZECN/ekec2JwGutHNDPi7NszWNncFTsK2Pu8GRK1DMJ9f3JR
	Q4WG+8Avv21eQfnSfx5Mv5qsaroL+K1o6mvyfhFZu+MM86tJLn+zlsLUaZ96kQ5u
	TeVyXfmwcPVJDd7CNB3g41e7QQq5qyK4ggNtZrvSxSlRnxSi9L6MNmhaYFwcNGXM
	t++5GaeUXo1QbzRYuyjrllXGG2ncG3bGXMfkIa/A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ffbbfk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 08:06:32 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56N86VBJ030152;
	Wed, 23 Jul 2025 08:06:31 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ffbbfk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 08:06:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56N418eo014301;
	Wed, 23 Jul 2025 08:06:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480ppp6x8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 08:06:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56N86Sj754722954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 08:06:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 773FA2004E;
	Wed, 23 Jul 2025 08:06:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7ADC20040;
	Wed, 23 Jul 2025 08:06:27 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.19.130])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Jul 2025 08:06:27 +0000 (GMT)
Date: Wed, 23 Jul 2025 10:06:26 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
        irogers@google.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, eranian@google.com,
        ctshao@google.com, tmricht@linux.ibm.com, leo.yan@arm.com,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH V4 07/16] s390/perf: Remove driver-specific throttle
 support
Message-ID: <aICYAqM5EQUlTqtX@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
 <20250520181644.2673067-8-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520181644.2673067-8-kan.liang@linux.intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UTGLOoyD7eJ7cIMYlST5sCU3mdpQlqP1
X-Authority-Analysis: v=2.4 cv=De8XqutW c=1 sm=1 tr=0 ts=68809808 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=k1CFeq3D6HfWPww2QuQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: k3aRQo9I_5iPyc5ns6G-HrgSk84Jim1i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA2NCBTYWx0ZWRfXz4XBSkNWq/nF
 AtnF7eFSlj+Xvytj4a/39E60iU3A65LOzhQE8mL8nCPQ2rNMgQPzsqlkRjrD1sPmfZk0GSGqXrw
 ogTLsDLFX+1gT9/F094rseC2aE4Z+D06wz4saj4aP2UulT+nJI6hOoSFbpJDmgL8PG8NSbmiEXI
 XoJqy/FAkJ390bnTZbv7zEylXziEJ2zgBut5FgPBhHfp4ROWNMm4dvWGrpP6jn42nKryIi/oTjh
 z49UZjyPlCQbFs0i2MPjwBU50obx4EiPyQUolwa9WByxOyD3pT2VRcRiIBW79X64EguE/glPxh7
 hKSkraIoFQUJ1jjclHvD0/KGQhLeND0KJzHSjMYaaUZgrohuZHB/GqOtBg29i/DLIyip/VQlDbv
 fvNgBhfoJGyD54UFH7MHWBbapUTIATTRgYwSXelhBG48MmAGsO1Zpzc6Fp9DbBwAjw2uyHUw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 clxscore=1011 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230064

On Tue, May 20, 2025 at 11:16:35AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The throttle support has been added in the generic code. Remove
> the driver-specific throttle support.
> 
> Besides the throttle, perf_event_overflow may return true because of
> event_limit. It already does an inatomic event disable. The pmu->stop
> is not required either.
> 
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/kernel/perf_cpum_cf.c | 2 --
>  arch/s390/kernel/perf_cpum_sf.c | 5 +----
>  2 files changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
> index e657fad7e376..6a262e198e35 100644
> --- a/arch/s390/kernel/perf_cpum_cf.c
> +++ b/arch/s390/kernel/perf_cpum_cf.c
> @@ -980,8 +980,6 @@ static int cfdiag_push_sample(struct perf_event *event,
>  	}
>  
>  	overflow = perf_event_overflow(event, &data, &regs);
> -	if (overflow)
> -		event->pmu->stop(event, 0);
>  
>  	perf_event_update_userpage(event);
>  	return overflow;
> diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
> index ad22799d8a7d..91469401f2c9 100644
> --- a/arch/s390/kernel/perf_cpum_sf.c
> +++ b/arch/s390/kernel/perf_cpum_sf.c
> @@ -1072,10 +1072,7 @@ static int perf_push_sample(struct perf_event *event,
>  	overflow = 0;
>  	if (perf_event_exclude(event, &regs, sde_regs))
>  		goto out;
> -	if (perf_event_overflow(event, &data, &regs)) {
> -		overflow = 1;
> -		event->pmu->stop(event, 0);
> -	}
> +	overflow = perf_event_overflow(event, &data, &regs);
>  	perf_event_update_userpage(event);
>  out:
>  	return overflow;
> -- 
> 2.38.1

Hi all,

This seems to break POLL_HUP delivery to userspace - when event_limit reaches 0

From perf_event_open man page:
PERF_EVENT_IOC_REFRESH
              Non-inherited overflow counters can use this to enable a
              counter for a number of overflows specified by the
              argument, after which it is disabled.  Subsequent calls of
              this ioctl add the argument value to the current count.  An
              overflow notification with POLL_IN set will happen on each
              overflow until the count reaches 0; when that happens a
              notification with POLL_HUP set is sent and the event is
              disabled.

When the event_limit reaches 0, the POLL_HUP signal is expected to be
sent. Prior to this patch, an explicit call to event->stop() was made,
which may have contributed to ensuring that the POLL_HUP signal was
ultimately delivered. However, after  this change, I often did not
observe the POLL_HUP signal being delivered as expected in the end

Example program:
output:
Computation result: 49951804672
count.hup: 0 count.pollin: 22

Expected output should be:
count.hup: 1 in the end

#define _GNU_SOURCE
#include <time.h>
#include <stdbool.h>
#include <signal.h>
#include <poll.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>

#include <sys/ioctl.h>
#include <sys/syscall.h>
#include <linux/perf_event.h>

static struct signal_counts {
        int in;
	int out;
	int hup;
	int unknown;
} count;


static unsigned long sample_type = PERF_SAMPLE_IP | PERF_SAMPLE_TID |
		PERF_SAMPLE_TIME | PERF_SAMPLE_ADDR | PERF_SAMPLE_READ |
		PERF_SAMPLE_ID | PERF_SAMPLE_CPU |
		PERF_SAMPLE_PERIOD | PERF_SAMPLE_STREAM_ID | PERF_SAMPLE_RAW;

static void sighandler(int signum, siginfo_t *info, void *uc)
{
	switch(info->si_code) {
                case POLL_IN:  count.in++;  break;
                case POLL_OUT: count.out++; break;
                case POLL_HUP: count.hup++; break;
                default: count.unknown++; break;
        }
}

void generate_load(unsigned long long iterations) {
    unsigned long long sum = 0;
    srand(time(0));

    for (unsigned long long i = 0; i < iterations; ++i) {
        int rnd = rand();
        sum += (rnd ^ (rnd >> 3)) % 1000;
    }
    printf("Computation result: %llu\n", sum);
}

void perf_attr(struct perf_event_attr *pe,
		       unsigned long config, unsigned long period, bool freq,
		       unsigned long bits)
{
	memset(pe, 0, sizeof(struct perf_event_attr));
	pe->size = sizeof(struct perf_event_attr);
	pe->type = PERF_TYPE_HARDWARE;
	pe->config = PERF_COUNT_HW_CPU_CYCLES;
	pe->exclude_kernel = 0;
	pe->sample_period = 50000;
	pe->freq = 1;
	pe->disabled = 1;
	pe->config = config;
	pe->freq = freq;
	pe->sample_type = bits;
}

int main(int argc, char **argv)
{
	int fd, signo = SIGIO, rc = -1;
	struct sigaction sa, sa_old;
	struct perf_event_attr pe;

	perf_attr(&pe, PERF_COUNT_HW_CPU_CYCLES, 50000, 1, sample_type);
	/* Set up overflow handler */
	memset(&sa, 0, sizeof(struct sigaction));
	memset(&sa_old, 0, sizeof(struct sigaction));
	sa.sa_sigaction = sighandler;
	sa.sa_flags = SA_SIGINFO;
	if (sigaction(signo, &sa, &sa_old) < 0)
		goto out;

	fd = syscall(__NR_perf_event_open, &pe, 0, -1, -1, 0);
	if (fd < 0)
		return rc;

	rc = fcntl(fd, F_SETFL, O_RDWR | O_NONBLOCK | O_ASYNC);
	rc |= fcntl(fd, F_SETSIG, signo);
	rc |= fcntl(fd, F_SETOWN, getpid());
	if (rc)
		goto out;

	rc = ioctl(fd, PERF_EVENT_IOC_REFRESH, 2500);
	if (rc)
		goto out;

	generate_load(100000000ULL);
	sigaction(signo, &sa_old, NULL);
	printf("count.hup: %d count.pollin: %d\n", count.hup, count.in);
	close(fd);
	return 0;
out:
	return rc;
}

Thank you,
Sumanth

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F95721ABA2;
	Wed,  6 Aug 2025 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754469504; cv=none; b=X+QbvxKu4yQh7C1pTBfRD+pTezJq5pThd+Suru2c08tlnCHDEqgv5MFuUW4BHMA7Xm4Cr92cUnYiYxkDRS9X2GHYD+8v3AIfvUH0fDH7ZYM5T6ZqoSh5PlHkj4Hp7baC8YXuPvCJD6NGg2ATTKaq2l3wpwFhJ/BuQzEhuzIAmio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754469504; c=relaxed/simple;
	bh=INZZW86BTHBinp5CUjHA7l3SdNfTRdSs53V6aTM3PIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nN30oYoPmDBwp8zvYck0K26AtT8fKmHk/3Q0dAkTl8KTO0oP8qt5QnbIv5LkO97ZRoayWC5Rrej/RUfxAwa84/efK10d10kSgb4wA0f9CWp9Q/G63Zg+jzlC+WYUCBo9ytaqpkX/HTHFa/e/4U9OldyuwDJ1LnyPEtB/vYD8WGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KjP+rwxK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KjP+rwxK"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5768QAHr021615;
	Wed, 6 Aug 2025 08:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=BFRcT+PNR7FsIXduEUPRQV6M3wexi+
	hFcjbQ3v0Iu0c=; b=KjP+rwxKxhPVJDapoCQhL/BHcamX30+0byZWwxaRoc79JG
	6+zEBkpmP7xndvFCvCMZwwqN6z7YCX49FQMN1yJzzt1oA3e+PD3erfe++Zek+rEa
	6AlYX0sLnOKj4npfmKTwSTspdEzo/ZC0XodZToH4rCUW1Lo1AACzK1RUzGEQBE2b
	x9C9y/gdGPaWVA2fe+IAwFDcaSdj3ETL9pQSXlm3yGtP0T85Qn9q6IAbascPLv7B
	cwuujKS2rBT8ELLLMboBozsi12IqXsNo5O9TJj9nFRCkqvTYTW7Aey8a/CDugnLW
	6FlRQAYTQk4aJGHQjr1/38Vq5moUPaL5SqQ0cQtA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq61u11h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 08:38:04 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5768KIiY004961;
	Wed, 6 Aug 2025 08:38:04 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq61u10a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 08:38:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57683FVA020612;
	Wed, 6 Aug 2025 08:38:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwmtrkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 08:38:01 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5768bx8n53281060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 08:37:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9728C20043;
	Wed,  6 Aug 2025 08:37:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BF1E2004B;
	Wed,  6 Aug 2025 08:37:59 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.70.156])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Aug 2025 08:37:58 +0000 (GMT)
Date: Wed, 6 Aug 2025 10:37:57 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
        irogers@google.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, eranian@google.com,
        ctshao@google.com, tmricht@linux.ibm.com, leo.yan@arm.com,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH V4 07/16] s390/perf: Remove driver-specific throttle
 support
Message-ID: <aJMUZTJ7FmB9FW9r@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
 <20250520181644.2673067-8-kan.liang@linux.intel.com>
 <aICYAqM5EQUlTqtX@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aICYAqM5EQUlTqtX@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA1MCBTYWx0ZWRfXzLQszVLavcpk
 MFZxR1mRWK8/PGyE/RAus43GApDs8wsIgKz59S79YaUGSBUBvI3q5/2EJvjezfpyxU0a7snHNhk
 1Ji1rckwlVvxdxefLMEvTd2F2dwKhS+qZSGU1oBBwqExEBFbnkgmVNtVU+bTeMEbTDZxbknr8wR
 P0XX6YZDhEQ1JDCoSqWN/2Cn46jv7BjJteniA9+VwHEJ+qBiqBLu+Kz+hG1nbvCdq6v0JzjKueq
 UpTkIYtte/0e0v8wg2QvKeZGuHL09atjhAMibgQlb4deSL3gUjrtQWm5FekO3j/lpSFzA8PapMK
 uqq8uIeEyKmV55FcBcegoGaY6z/WfxegUN7uE+jbd5OWUR6q/baO2bQd4M/3Xo7GN/29My5a9P/
 WkGSdA5R/rb2GyRYtW8iWZ2LsNZunmFWzx5tebB+0qwxntsPGB8hKMZh8wHKmqmEV/VcZSJU
X-Proofpoint-GUID: hFnD0kb1fyAEcLYEHj9ZK07E2WjMpeGm
X-Authority-Analysis: v=2.4 cv=BIuzrEQG c=1 sm=1 tr=0 ts=6893146c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Uf_jtusGSZTfHGq8c9EA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: t7K-OPae5mdZWsx89JZINyHOaEdoW6Nm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_01,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 malwarescore=0 phishscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060050

On Wed, Jul 23, 2025 at 10:06:26AM +0200, Sumanth Korikkar wrote:
> On Tue, May 20, 2025 at 11:16:35AM -0700, kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > 
> > The throttle support has been added in the generic code. Remove
> > the driver-specific throttle support.
> > 
> > Besides the throttle, perf_event_overflow may return true because of
> > event_limit. It already does an inatomic event disable. The pmu->stop
> > is not required either.
> > 
> > Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Thomas Richter <tmricht@linux.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > ---
> >  arch/s390/kernel/perf_cpum_cf.c | 2 --
> >  arch/s390/kernel/perf_cpum_sf.c | 5 +----
> >  2 files changed, 1 insertion(+), 6 deletions(-)
> > 
> > diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
> > index e657fad7e376..6a262e198e35 100644
> > --- a/arch/s390/kernel/perf_cpum_cf.c
> > +++ b/arch/s390/kernel/perf_cpum_cf.c
> > @@ -980,8 +980,6 @@ static int cfdiag_push_sample(struct perf_event *event,
> >  	}
> >  
> >  	overflow = perf_event_overflow(event, &data, &regs);
> > -	if (overflow)
> > -		event->pmu->stop(event, 0);
> >  
> >  	perf_event_update_userpage(event);
> >  	return overflow;
> > diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
> > index ad22799d8a7d..91469401f2c9 100644
> > --- a/arch/s390/kernel/perf_cpum_sf.c
> > +++ b/arch/s390/kernel/perf_cpum_sf.c
> > @@ -1072,10 +1072,7 @@ static int perf_push_sample(struct perf_event *event,
> >  	overflow = 0;
> >  	if (perf_event_exclude(event, &regs, sde_regs))
> >  		goto out;
> > -	if (perf_event_overflow(event, &data, &regs)) {
> > -		overflow = 1;
> > -		event->pmu->stop(event, 0);
> > -	}
> > +	overflow = perf_event_overflow(event, &data, &regs);
> >  	perf_event_update_userpage(event);
> >  out:
> >  	return overflow;
> > -- 
> > 2.38.1
> 
> Hi all,
> 
> This seems to break POLL_HUP delivery to userspace - when event_limit reaches 0
> 
> From perf_event_open man page:
> PERF_EVENT_IOC_REFRESH
>               Non-inherited overflow counters can use this to enable a
>               counter for a number of overflows specified by the
>               argument, after which it is disabled.  Subsequent calls of
>               this ioctl add the argument value to the current count.  An
>               overflow notification with POLL_IN set will happen on each
>               overflow until the count reaches 0; when that happens a
>               notification with POLL_HUP set is sent and the event is
>               disabled.
> 
> When the event_limit reaches 0, the POLL_HUP signal is expected to be
> sent. Prior to this patch, an explicit call to event->stop() was made,
> which may have contributed to ensuring that the POLL_HUP signal was
> ultimately delivered. However, after  this change, I often did not
> observe the POLL_HUP signal being delivered as expected in the end
> 
> Example program:
> output:
> Computation result: 49951804672
> count.hup: 0 count.pollin: 22
> 
> Expected output should be:
> count.hup: 1 in the end
> 
> #define _GNU_SOURCE
> #include <time.h>
> #include <stdbool.h>
> #include <signal.h>
> #include <poll.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <time.h>
> 
> #include <sys/ioctl.h>
> #include <sys/syscall.h>
> #include <linux/perf_event.h>
> 
> static struct signal_counts {
>         int in;
> 	int out;
> 	int hup;
> 	int unknown;
> } count;
> 
> 
> static unsigned long sample_type = PERF_SAMPLE_IP | PERF_SAMPLE_TID |
> 		PERF_SAMPLE_TIME | PERF_SAMPLE_ADDR | PERF_SAMPLE_READ |
> 		PERF_SAMPLE_ID | PERF_SAMPLE_CPU |
> 		PERF_SAMPLE_PERIOD | PERF_SAMPLE_STREAM_ID | PERF_SAMPLE_RAW;
> 
> static void sighandler(int signum, siginfo_t *info, void *uc)
> {
> 	switch(info->si_code) {
>                 case POLL_IN:  count.in++;  break;
>                 case POLL_OUT: count.out++; break;
>                 case POLL_HUP: count.hup++; break;
>                 default: count.unknown++; break;
>         }
> }
> 
> void generate_load(unsigned long long iterations) {
>     unsigned long long sum = 0;
>     srand(time(0));
> 
>     for (unsigned long long i = 0; i < iterations; ++i) {
>         int rnd = rand();
>         sum += (rnd ^ (rnd >> 3)) % 1000;
>     }
>     printf("Computation result: %llu\n", sum);
> }
> 
> void perf_attr(struct perf_event_attr *pe,
> 		       unsigned long config, unsigned long period, bool freq,
> 		       unsigned long bits)
> {
> 	memset(pe, 0, sizeof(struct perf_event_attr));
> 	pe->size = sizeof(struct perf_event_attr);
> 	pe->type = PERF_TYPE_HARDWARE;
> 	pe->config = PERF_COUNT_HW_CPU_CYCLES;
> 	pe->exclude_kernel = 0;
> 	pe->sample_period = 50000;
> 	pe->freq = 1;
> 	pe->disabled = 1;
> 	pe->config = config;
> 	pe->freq = freq;
> 	pe->sample_type = bits;
> }
> 
> int main(int argc, char **argv)
> {
> 	int fd, signo = SIGIO, rc = -1;
> 	struct sigaction sa, sa_old;
> 	struct perf_event_attr pe;
> 
> 	perf_attr(&pe, PERF_COUNT_HW_CPU_CYCLES, 50000, 1, sample_type);
> 	/* Set up overflow handler */
> 	memset(&sa, 0, sizeof(struct sigaction));
> 	memset(&sa_old, 0, sizeof(struct sigaction));
> 	sa.sa_sigaction = sighandler;
> 	sa.sa_flags = SA_SIGINFO;
> 	if (sigaction(signo, &sa, &sa_old) < 0)
> 		goto out;
> 
> 	fd = syscall(__NR_perf_event_open, &pe, 0, -1, -1, 0);
> 	if (fd < 0)
> 		return rc;
> 
> 	rc = fcntl(fd, F_SETFL, O_RDWR | O_NONBLOCK | O_ASYNC);
> 	rc |= fcntl(fd, F_SETSIG, signo);
> 	rc |= fcntl(fd, F_SETOWN, getpid());
> 	if (rc)
> 		goto out;
> 
> 	rc = ioctl(fd, PERF_EVENT_IOC_REFRESH, 2500);
> 	if (rc)
> 		goto out;
> 
> 	generate_load(100000000ULL);
> 	sigaction(signo, &sa_old, NULL);
> 	printf("count.hup: %d count.pollin: %d\n", count.hup, count.in);
> 	close(fd);
> 	return 0;
> out:
> 	return rc;
> }

Hi Kan,

It would be great if you could share your feedback on this issue.

Thank you.

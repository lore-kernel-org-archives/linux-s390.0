Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FB673451;
	Wed, 23 Oct 2024 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729668814; cv=none; b=G3tHnI3zHonIUeoHEV7dwBga2NgM5fs9wP+S9eaATf8A4/FJjXQg75cHrjgOVOxv2p5TwImtj9LH+swql5h5eec2nT+eOpBwGJl/y5002B62pgsJV1WmnUz5MePLF2IEYD+Uw0e+KqCxb+XwLOH1zlKN2PYWRLqf0Ls9oaCLJDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729668814; c=relaxed/simple;
	bh=hjrh+N7pG6QkaiT1Rq5synmi4FTXHv4iBa3jgHNJ1Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2lXFoLtwjsBYgeDiBCmHdq+1JhNwZtQl1faoXRKtFHwI5ponR1HCsd5fyevgqy6mO+tvebcNwyxBugPkE2d9sDNQcKQa04GcbOgmGoUhXP/LGIYzVRpFKix3mYagplD4D1CSsFKTEAb4eH/Z7LI9fcqlIPwrfKkYWZp/B8c5Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=juK//rR2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="juK//rR2"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N0N3ew016718;
	Wed, 23 Oct 2024 07:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+14j3B
	s1y17Qe/TmSl9HqlcusnpTT/37DpsFx8amwoA=; b=juK//rR2e6I+SU7MGdx86V
	OORqc5gb3uipO/CCQZO2z13oeKk5/H/q4jbdV105vdR7RZ61bubyKkiCEfvnBEW0
	klUiRD/HdfRCWG10lIEXfAGgUr1sjbbWeEsRHXx9xuuu/xfkhwxl7UEBPN6dfeOi
	aqH3jJ086YHkTWWFJpyAykWTY0BpHD9QaHbLn0pO/qH8qp//sERvAB7gvQGgWx2Y
	eOq9l+p2Eol6W8BeKxR+ZKAISLEuw29D7yH4fjozsMfC5NNedVmOhm1r5YeIqBzL
	wwoMBFKKJpCsi3oK/jwhFhXyS8206r1NHli4ToiwpLgvK8tHuVThScF3sjThsKJQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emajht6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 07:33:17 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49N7UwCG012410;
	Wed, 23 Oct 2024 07:33:16 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emajht68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 07:33:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49N7TX3w008791;
	Wed, 23 Oct 2024 07:33:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emkahrx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 07:33:15 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49N7XCRn17105252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 07:33:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1618E20043;
	Wed, 23 Oct 2024 07:33:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF79F20040;
	Wed, 23 Oct 2024 07:33:11 +0000 (GMT)
Received: from [9.152.212.137] (unknown [9.152.212.137])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Oct 2024 07:33:11 +0000 (GMT)
Message-ID: <7234670b-b119-44c2-9465-dd4d9451aae7@linux.ibm.com>
Date: Wed, 23 Oct 2024 09:33:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] perf/core: Export perf_exclude_event()
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland
 <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20241023000928.957077-1-namhyung@kernel.org>
 <20241023000928.957077-3-namhyung@kernel.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20241023000928.957077-3-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Zxrj1CMsiVQ9VCHWXHBRQiTHjJUHo6MH
X-Proofpoint-GUID: CPcuLdcL4WMafYnVbigjxFqDoFUbO5VD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410230042

On 10/23/24 02:09, Namhyung Kim wrote:
> And increase the dropped_sample count when it returns 1.  Now it can
> track how many samples are dropped due to the privilege filters in
> software events.
> 
> While at it, rename the same function in s390 cpum_sf PMU and also count
> the dropped samples.
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  arch/s390/kernel/perf_cpum_sf.c |  8 +++++---
>  include/linux/perf_event.h      |  6 ++++++
>  kernel/events/core.c            | 11 +++++++----
>  3 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
> index 5b765e3ccf0cadc8..ff9e694f2be45c6b 100644
> --- a/arch/s390/kernel/perf_cpum_sf.c
> +++ b/arch/s390/kernel/perf_cpum_sf.c
> @@ -996,7 +996,7 @@ static void cpumsf_pmu_disable(struct pmu *pmu)
>  	cpuhw->flags &= ~PMU_F_ENABLED;
>  }
>  
> -/* perf_exclude_event() - Filter event
> +/* perf_event_exclude() - Filter event
>   * @event:	The perf event
>   * @regs:	pt_regs structure
>   * @sde_regs:	Sample-data-entry (sde) regs structure
> @@ -1005,7 +1005,7 @@ static void cpumsf_pmu_disable(struct pmu *pmu)
>   *
>   * Return non-zero if the event shall be excluded.
>   */
> -static int perf_exclude_event(struct perf_event *event, struct pt_regs *regs,
> +static int perf_event_exclude(struct perf_event *event, struct pt_regs *regs,
>  			      struct perf_sf_sde_regs *sde_regs)
>  {
>  	if (event->attr.exclude_user && user_mode(regs))
> @@ -1088,8 +1088,10 @@ static int perf_push_sample(struct perf_event *event,
>  	data.tid_entry.pid = basic->hpp & LPP_PID_MASK;
>  
>  	overflow = 0;
> -	if (perf_exclude_event(event, &regs, sde_regs))
> +	if (perf_event_exclude(event, &regs, sde_regs)) {
> +		atomic64_inc(&event->dropped_samples);
>  		goto out;
> +	}
>  	if (perf_event_overflow(event, &data, &regs)) {
>  		overflow = 1;
>  		event->pmu->stop(event, 0);

For the s390 part:

Acked-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

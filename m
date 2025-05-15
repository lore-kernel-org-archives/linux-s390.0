Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6244E2581;
	Thu, 15 May 2025 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314978; cv=none; b=dbKIFz215gldemHYxoKqH2j4ntajPv2DTGO8ObD3iPA2id+9QQnMMR0armpC0pE2a3c9GD2d3A01KUnBI18EUGhCyfUl5vixjVocF7JZDFsApFRr68vh77Hc/pTfWoVIgqrLqT2ZaVVzMrEP+tEvkXdqyddihwSosJVkmPp8qTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314978; c=relaxed/simple;
	bh=/foRtK30244Y6vx7qd0F0GOygInRY+jAMjfoJ/j1WrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5UMRCjhsBstSPbFltRH+EASMvj2ItS5m8eTD5N8P/joQDxCl43bd+0GHD8+c+TtHDDRTstiz2Ug2lV1uh0mYoVlBMeKQxWJAk/IJjOq6xtBghw8oi+X5lLVxlhGP4Cbu6qwaTf8UIvJKEurbRPT2ZmLKO/HacZQS1/TZqWfDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ekz6JbB7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ekz6JbB7"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCgBGF004810;
	Thu, 15 May 2025 13:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=K8eSWs
	kk7y1WnwI4RQTrKWmfmUf+E2VpeXbQUkcUybc=; b=ekz6JbB7iUMeaJO8Zgm/xD
	HiKuN5VxsRPhASWlfw3z9j/4ZXlKZHTlh0+qiPamAMwQzafpe5Shdj99iezgRgoz
	mmQdzP1STPkxj9Kn028nFKNbe2JP9+8/DjUzKqLPqAAvSCQFUxqKnYrkDlwhMJtr
	3OWwiCzuYfUad9CBOvc7mnDZVguFNN27n60vE6mMpkpvc8EEmkBI32maBTtpPqov
	mTFJL4ZbDKXCO1gRAmJIfGMgYSpFSZqLqNwlAKR7tlxp7o6/ZjitC0SPHebcm/GS
	+A/46xynLr6IwE+5rVrkJxxu+DRoMZUfb44AaF5FN5FvWZecQY2OGRLSWQkhDW0w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjs5h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 13:15:58 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FD9JMO003541;
	Thu, 15 May 2025 13:15:57 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjs5h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 13:15:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FAls4p026947;
	Thu, 15 May 2025 13:15:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpjavc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 13:15:57 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54FDFtfr33555120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 13:15:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FFF32006A;
	Thu, 15 May 2025 13:15:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C0BC20067;
	Thu, 15 May 2025 13:15:55 +0000 (GMT)
Received: from [9.152.212.229] (unknown [9.152.212.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 May 2025 13:15:54 +0000 (GMT)
Message-ID: <ec0827aa-0bae-4625-ad60-f1a1765a4811@linux.ibm.com>
Date: Thu, 15 May 2025 15:15:54 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 06/15] s390/perf: Remove driver-specific throttle
 support
To: kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, irogers@google.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: eranian@google.com, ctshao@google.com, linux-s390@vger.kernel.org
References: <20250514151401.2547932-1-kan.liang@linux.intel.com>
 <20250514151401.2547932-7-kan.liang@linux.intel.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20250514151401.2547932-7-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TiGGmCsi-Q4CEQDqJeIsc5m_1DEQCo2c
X-Authority-Analysis: v=2.4 cv=ecg9f6EH c=1 sm=1 tr=0 ts=6825e90e cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=3pcsZ_9yFVMwK54gUSUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _xFvpzNXaCvkt0etVGSLJ4aTiaHA05X6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDEyOSBTYWx0ZWRfX00XKEgoWCOzp H3lB03YVH+jZWCa/UwtLfav8AUW+QPtdjmuVQ9mDElOouHi6fNfP5SCQ3xcxc8WEJs4GVRoxnQd ah8WwpSpfchkibE54oAicenS7Iev+pj0iuuUy7paXW8gkVcVzOr8VxKxSprloUi5PEmUdv51pfE
 CcwHO16L/UWcfHsBfpFg8msOwx9/x85jDxF2WRky8/fQTC1h/JN59ygteY2CCkB62sSTCCslZYX p4vsBZLoSuopVeyskF82oq48AcwIvUGKKkbYY/YkfzXjivg9JiYv7Rw9En3MbFRknwaTB8Y/i3a 2Vp0CVrvDuUC7PPUI9bTsS+yl8Zpzu+LHB4CEvyvqXwmyeyJB7Pb1GxyafB+wHfVqfKcDube5lb
 nrnvEtgxqQq4BSAbFv8Efql+sFlroIJ2HVilet9Mo5uWstIfRgZQCipLZZJe1fzEizSAy2YT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_05,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150129

On 5/14/25 17:13, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The throttle support has been added in the generic code. Remove
> the driver-specific throttle support.
> 
> Besides the throttle, perf_event_overflow may return true because of
> event_limit. It already does an inatomic event disable. The pmu->stop
> is not required either.
> 
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

I have installed patch 1 and 6 on top of the linux-next kernel today.
The results look good, much better than before, but I still do not
get both counter values in sync on each iteration all the time.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

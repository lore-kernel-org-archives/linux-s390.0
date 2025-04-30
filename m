Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C7F1E50B;
	Wed, 30 Apr 2025 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746021645; cv=none; b=NWKQJvI8L1nLcO9ea/otlwrt1SKNGsC9VvWLbnRvr3MIzN7Di6/IVo9oN4gPop81upMQqBdiOfjyd1pnJqJSLJr91iXhEtAU4NEALgcGZvToPGwlQbxqjIUdftOW58/vOZQQmMIEFwFcfCA5Z4BHN+skoEP49ldgllZi61i0KGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746021645; c=relaxed/simple;
	bh=yx2wEOAFgXewt07Uh8b3G92s1UT3Nr7VVujc0HNCDiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQEJLmw4pd41f6qzZgNMR0qbEtb0YZoZxYacqZlt7VuYAIKfDh8CZnhlxZrs90EHPt2ljd74Cw/n9X1iRGpFeMlmsMqmJSuQPmjFCnMBOoeQAdjjBTze1lUdu/X4zTbpP1Jzzkby+VeRRafdU9kaf6/lm1d+g0wGllPksyNo5YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZQcPYc5N; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZQcPYc5N"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UCo0dV024548;
	Wed, 30 Apr 2025 14:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PHcIhf
	/Hg/v5q3P6bgsIf0he7ViXGC7s26Zz87dieUY=; b=ZQcPYc5NBe1SD5RFSY3VzQ
	+qSPYn3A8I5zta6ideT2GezV7CHGG54wxUtfTv+HBsKzOWqv+jOB4xt27dGZRWe+
	DfhAWPa9X1QYb/88VFiz9gV8bUBf/L/gOxofyHnUPXfqizQ1QWfP/OAZBsA1lT8q
	QJ1NYU1bxVtJEL3eKoflTwZgWbEBTCf+TZvpfuMcyN19wepaFDqQaJjhcNspjo/g
	GdlPinxeBRjUDTUva2J9z4oT1Mbk01ZFi7uE7xwuh/QMB+d6j5F/Bf7eDIZMxU/G
	fwRzmH3xKchBFAQ5MwGXqjyGKw13RJbDJ5zhNA8fDPav15BfFmcyXXM2tYFU6pUg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46b6wwbc8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 14:00:27 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53UDac7J015491;
	Wed, 30 Apr 2025 14:00:26 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46b6wwbc8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 14:00:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53UBPJZG031677;
	Wed, 30 Apr 2025 14:00:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4699tu88km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 14:00:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53UE0MtX42140040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 14:00:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BD1120043;
	Wed, 30 Apr 2025 14:00:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D14E720040;
	Wed, 30 Apr 2025 14:00:21 +0000 (GMT)
Received: from [9.152.212.229] (unknown [9.152.212.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Apr 2025 14:00:21 +0000 (GMT)
Message-ID: <273daacc-4a82-41d0-bb8e-af28540868ec@linux.ibm.com>
Date: Wed, 30 Apr 2025 16:00:21 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PING PATCH v3] perf test: Allow tolerance for leader sampling
 test
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, namhyung@kernel.org,
        ctshao@google.com, irogers@google.com, agordeev@linux.ibm.com,
        gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com
References: <20250422110643.2900090-1-tmricht@linux.ibm.com>
 <aBIeFio2nkbzFj0b@x1>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <aBIeFio2nkbzFj0b@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GTAMxfKHPmV21pmP-LzF8qPabfrh-O7p
X-Proofpoint-GUID: JBmxKgMB-U9lWdIsCOQFhlO1Mlg1YOaN
X-Authority-Analysis: v=2.4 cv=GOIIEvNK c=1 sm=1 tr=0 ts=68122cfb cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=RwRM1mRPO-xhfnsLoCkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA5NiBTYWx0ZWRfX63QeRVDajKwU NtFaEwFMdhhzeKZ+B/B7KD8PJgqgIxEApnetV4ZCBTUknD2qSJ9eOcrIzxm7YO3HTHsgiGHAW+h rYGTQKIVS5ihEZGj8VGmYBqv4FvKRBBAoy8rK4Orb+pgWZXrAV6KYY67if5QtK8Yk98D/weLkTk
 jcVOuxmpcXDwL2GuLvy9d88WFHcwodZgSRtw3mLFBOazLZjVqFf53txHVma9UhdU5y0bQKyd30w MomgilL7Sha9Pc+Sx0lTEFi99VQgjsalObl9b86B+X8emU5nludMyW+cDOTwJ+xjXjXtuewatcn 2zfmk7jl+Rw5T7sAyo1Qo6qJgABNclUWavESZ05W5bkUlObz5b5m2IGKYdvbLIfUxR3nPGyQs/K
 kP/Hpb0WnP0V2X7BIpAYn4VFdh6dA0SnnU0Ppqy2TZoyEWdWKTwqMWv0eeKS+4YpEBb3+Pau
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300096

On 4/30/25 14:56, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 22, 2025 at 01:06:43PM +0200, Thomas Richter wrote:
>> V3: Added check for missing samples as suggested by Chun-Tse.
>> V2: Changed bc invocation to return 0 on success and 1 on error.
>  
>> There is a known issue that the leader sampling is inconsistent, since
>> throttle only affect leader, not the slave. The detail is in [1]. To
>> maintain test coverage, this patch sets a tolerance rate of 80% to
>> accommodate the throttled samples and prevent test failures due to
>> throttling.
>  
>> [1] lore.kernel.org/20250328182752.769662-1-ctshao@google.com
>  
>> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
>> Suggested-by: Ian Rogers <irogers@google.com>
>> Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
>> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> 
> This doesn't apply to perf-tools-next:
> 
> ⬢ [acme@toolbx perf-tools-next]$        git am ./v3_20250422_tmricht_perf_test_allow_tolerance_for_leader_sampling_test.mbx
> Applying: perf test: Allow tolerance for leader sampling test
> error: patch failed: tools/perf/tests/shell/record.sh:238
> error: tools/perf/tests/shell/record.sh: patch does not apply
> Patch failed at 0001 perf test: Allow tolerance for leader sampling test
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config set advice.mergeConflict false"
> ⬢ [acme@toolbx perf-tools-next]$
> 
> Are you proposing this for perf-tools, i.e. for this release cycles?
> 
> Namhyung, what do you think?
> 
>

It would be good if this could go onto linux-next. However I noticed
this patch does not apply anymore on that tree. I will send updated
patch as version 4.

Thanks a lot

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

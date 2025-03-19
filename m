Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5C8372;
	Wed, 19 Mar 2025 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387293; cv=none; b=OGsgIzdeMCPCswndVC4zfTHBV6mKBegGMuwx6s+wXa2yLmtJlooI5BlCryGnxTukiLUzuj3IhTTqiIc9A00/m36UDF7aUOanlVp1CeJy93KOMcbU4IIjYYSv3ezJNx8p5UdXsH+NLzaEcE20l45/AtrPqdOV/VInAhgxyQ4VQ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387293; c=relaxed/simple;
	bh=OPH5Nary7E9IdqycTXq/IeMpyCsF4bDGdCutnM0PKqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SkcTWllQaixFsXvV0wlP1z6lJT4eHVUdJ36s2RYi7x9u8//9fjEbvwkdjV2RJ3SyUtIvPoQghuNgqutNtf2HI/tsyhiODtyniu6D4YzhOhNYreNc3mg6rxOc8QKRz/KUDeLebYnisfyyidOiQT6GNcfwnvhx4rYRVBAtO97QfbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sEGh97zs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sEGh97zs"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JCRvl5011881;
	Wed, 19 Mar 2025 12:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dvQbFM
	sZkPWeGhu6y1+yueYG0WzOohNzsniNmgooJ3A=; b=sEGh97zsPB0L4k5xGPxZn4
	uNrDlN/ZDMIkmbPIPqkaRQvA1ij6E/7mY/Lza+bWbIFgBZ5ZZM/u7D2lsVFa/qvY
	R+++aCceShJchFNpZOw1LJHtEGTMroIvUd0WMw7yxEsPLqQr1CBu1E/eJ3vNDMlU
	NlWRRQE6VIJ/+9cvirkkEHJFKXwS7gYPTqBKoa/BaiiyE2aWzEJ0HcM2G6dm49Ps
	x9SDUVH9pXdAczT4CV78dG8h+DkPq0RZ1dGlWX9RheFzP+42Y8nyzWxzYpfxmJqW
	b3lDH9c4teu5Y0W2b8jNXubZVj/cnsiMn+kEVjoLEek4kPo8g6S6Z89UpeCo7SzA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fwy20013-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 12:28:07 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52JCS6SM012830;
	Wed, 19 Mar 2025 12:28:06 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fwy20010-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 12:28:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52JAQeYc005752;
	Wed, 19 Mar 2025 12:28:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dpk2h4ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 12:28:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52JCS2uf22872544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 12:28:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76F3D2004D;
	Wed, 19 Mar 2025 12:28:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AE092004B;
	Wed, 19 Mar 2025 12:28:02 +0000 (GMT)
Received: from [9.152.212.229] (unknown [9.152.212.229])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Mar 2025 12:28:02 +0000 (GMT)
Message-ID: <552882a0-936d-439b-a5ed-b852bd39f9d6@linux.ibm.com>
Date: Wed, 19 Mar 2025 13:28:02 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf pmu: Handle memory failure in tool_pmu__new()
To: James Clark <james.clark@linaro.org>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org, irogers@google.com
References: <20250319092847.1192988-1-tmricht@linux.ibm.com>
 <9f9c007a-78fe-4709-9063-eb4df72d4f63@linaro.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <9f9c007a-78fe-4709-9063-eb4df72d4f63@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Tdb4LtLZuxUao68fjAk_iBdSp2ALa685
X-Proofpoint-GUID: UM6ZQx76Gbsf5HBsZgBZeGSenWGzds2G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_04,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=918 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190085

On 3/19/25 10:58, James Clark wrote:
> 
> 
> On 19/03/2025 9:28 am, Thomas Richter wrote:
>> On linux-next
>> commit 72c6f57a4193 ("perf pmu: Dynamically allocate tool PMU")
>> allocated PMU named "tool" dynamicly. However that allocation
>> can fail and a NULL pointer is returned. That case is currently
>> not handled and would result in an invalid address reference.
>> Add a check for NULL pointer.
>>
>> Fixes: 72c6f57a4193 ("perf pmu: Dynamically allocate tool PMU")
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> Cc: Ian Rogers <irogers@google.com>
>> Cc: James Clark <james.clark@linaro.org>
>> ---
>>   tools/perf/util/pmus.c     | 3 ++-
>>   tools/perf/util/tool_pmu.c | 9 +++++++++
>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
>> index 9b5a63ecb249..b99292de7669 100644
>> --- a/tools/perf/util/pmus.c
>> +++ b/tools/perf/util/pmus.c
>> @@ -265,7 +265,8 @@ static void pmu_read_sysfs(unsigned int to_read_types)
>>       if ((to_read_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) != 0 &&
>>           (read_pmu_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) == 0) {
>>           tool_pmu = tool_pmu__new();
>> -        list_add_tail(&tool_pmu->list, &other_pmus);
>> +        if (tool_pmu)
>> +            list_add_tail(&tool_pmu->list, &other_pmus);
>>       }
>>       if ((to_read_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) != 0 &&
>>           (read_pmu_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) == 0)
>> diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
>> index b60ac390d52d..d764c4734be6 100644
>> --- a/tools/perf/util/tool_pmu.c
>> +++ b/tools/perf/util/tool_pmu.c
>> @@ -495,12 +495,21 @@ struct perf_pmu *tool_pmu__new(void)
>>   {
>>       struct perf_pmu *tool = zalloc(sizeof(struct perf_pmu));
>>   +    if (!tool)
>> +        goto out;
>>       tool->name = strdup("tool");
>> +    if (!tool->name) {
>> +        zfree(tool);
>> +        tool = NULL;
> 
> Hi Thomas,
> 
> zfree() already sets the thing to NULL but you need to pass a pointer to it:
> 
>   zfree(&tool);
> 
> Without doing that you only free the first u64 of the struct, which happens to be zero in this case so free() does nothing. Then zfree() sets the first u64 of the struct to zero which it already is.
> 
> With that fixed:
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
> 
> 

Thanks for the finding. I'll post verion 2 soon.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

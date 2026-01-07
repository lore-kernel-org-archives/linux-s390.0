Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4221EB1AA;
	Wed,  7 Jan 2026 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767790880; cv=none; b=oYLJmZu1vG/rx9Pk7clHrubfEkPrMQl2BVj3GBslp8+jDefHJcOtuYX0emzMFe0glQOYRxMofCKlr1aeMBDpMKJGnTXCrXNWSHUwsV1YCsYYKiERylkp2qMv1kx1sf+H1HgFYQmzlYUIPwSNORTOpTTL4xVQ0zuAmg1j/FjCWDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767790880; c=relaxed/simple;
	bh=J7DNc49U0v5Pqr/Z2NI7WTkUwmx2ilro0RTKNW3TSVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgQhcKVvO+Ih95/er0Urj2bLcvw/I8aPTNAXc/hbluGsekkclnaQngdtnPKSSt2IJbbXHp1fysawBcJ2NsK3LFeNfQAagKSJEFRRZr/WwWjWZsyKlh2HBRlda55OuKlsvgEUjmeuIUcx3sJtZ41RD3y89uHoR/ZaVIYNzEZNttQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ShG7AQRM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ShG7AQRM"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 607A0qjB032439;
	Wed, 7 Jan 2026 13:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SN5m8G
	QzVPJuEj/Z7bYA+x5N5GmhXuzJymeq6dLVo04=; b=ShG7AQRMh9W5rHvctQ0EHQ
	MmtR8/mRbL8GJ+DSJljDLX3xWu+XtJnlfsPfSmQ6bee6iam31mLSTzrnaVKTDjG6
	evnKIJs1cQlwU8y40QRfLn9L4ZckhsKD0Hj0zpy0K8ZLfhansz2A6J0rDHMtAIGQ
	vEE7hkxecQ+pElg7OCxgVpSwxv4lJbvEcg+vFnOMrwwUofGI7930gdq7yrbDjA+D
	YkpKh81RwoAoyfM2bvHep+XK6InmzDX0Z6rKfxiocs7DQn0jesuXrKxOYk+RKpgT
	lBbyzRTgAfLUrcgzH7f6VzTHj+/SQd59MEdY8YhSVpIpjf00Cb0QhCrHQrf5xb+w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu68wk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 13:01:12 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 607D1CGu032068;
	Wed, 7 Jan 2026 13:01:12 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu68wjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 13:01:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 607As5bD015205;
	Wed, 7 Jan 2026 13:01:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfdesh6v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 13:01:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 607D17b514483728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Jan 2026 13:01:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6567320049;
	Wed,  7 Jan 2026 13:01:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BEA520040;
	Wed,  7 Jan 2026 13:01:07 +0000 (GMT)
Received: from [9.111.10.96] (unknown [9.111.10.96])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Jan 2026 13:01:06 +0000 (GMT)
Message-ID: <0f55cde3-cba0-4e43-b2ac-1f1b506f4e15@linux.ibm.com>
Date: Wed, 7 Jan 2026 14:01:06 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Fix test perf stat tests for virtualized
 machines
To: James Clark <james.clark@linaro.org>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org, irogers@google.com
References: <20260107094835.131882-1-tmricht@linux.ibm.com>
 <2e0d7dce-a52f-4825-990e-f4bdaa1175ac@linaro.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <2e0d7dce-a52f-4825-990e-f4bdaa1175ac@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=695e5918 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Lh2iM_emvY-ES8JQXb4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: miFQb7bvRgM5FlX3aH_AR1a9MKYS35QU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA5NyBTYWx0ZWRfX/hTW3la+6SmD
 sFBTyGpoH3iIrV8sKhtIFtTHSTGJdyB5W4ONBzgM2VOZumv7rzTavZXz4Gpt72JZwv8YIXCBFeU
 TRUluzi9OJ6LfPA59pcmfLIe+wNRhOK02by2TJBz5sZ7DC+dxMSl5MnIXDYUaGtWBQiGZErg3/d
 K722VHUrUyHOZsksz64lJ1bojJZAzP4A+yu9I0Bv4idl0TGZ3E0B1oi1QENgcgr9Z5VUi9c6TBB
 yuRuWO46lkj6dhunXNtS8AEsWB2415BOdkXPeIM35lCs1NpYyVDLsJC+68yw1rZWT9fE4tUKwO3
 BsNBwAdxNVQEOgUUJBEc9c43VBD+W7eyzkgGRMbL1XR8zpglnRBRG0/+vfzToLtFP8K3NdRa5Ip
 I8ZwOzOXmY8S0rjtXJdT29JIEHsiWJ9fwxs9FEfV8oei9mCO08HKwFZeboACc8iv8oKmnJBWANr
 PvuzaG++agu/atpFq9g==
X-Proofpoint-GUID: BVPKldA4AplypkX92HJ2n8NJ704RAPSW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601070097

On 1/7/26 12:18, James Clark wrote:
> 
> 
> On 07/01/2026 9:48 am, Thomas Richter wrote:
>> On s390 perf test 'perf stat tests', subtest test_hybrid fails
>> for z/VM systems.
>> The root cause is this statement:
>>
>>    $(perf stat -a -- sleep 0.1 2>&1 |\
>>                    grep -E "/cpu-cycles/[uH]*|  cpu-cycles[:uH]* -c)
>>
>> The perf stat output on a s390 z/VM system is
>>
>>   # perf stat -a -- sleep 0.1 2>&1
>>   Performance counter stats for 'system wide':
>>
>>         56      context-switches  #     46.3 cs/sec  cs_per_second
>>   1,210.41 msec cpu-clock         #     11.9 CPUs  CPUs_utilized
>>         12      cpu-migrations    #      9.9 migrations/sec ...
>>         81      page-faults       #     66.9 faults/sec ...
>>
>>         0.100891009 seconds time elapsed
>>
>> The grep command does not match any single line and exits with error
>> code 1. As the bash script is executed with set -e, it aborts with the
>> first error code being non-zero.
>>
>> Fix this and use wc -l to count matching lines instead of grep ... -c.
>>
>> Output before:
>>   # perf test 102
>>   102: perf stat tests                      : FAILED!
>>   #
>> Output after:
>>   # perf test 102
>>   102: perf stat tests                      : Ok
>>   #
>>
>> Fixes: 65d11821910bd ("perf test: Add a test for default perf stat command")
> 
> I think the change looks ok, but doesn't it fix 65d11821910bd ("perf tools: Add fallback for exclude_guest") where the existing wc -l was changed to grep -c?
> 

You are correct, James.
I will send V2 with updated Fixes tag.

Thanks
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

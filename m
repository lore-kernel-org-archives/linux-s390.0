Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7E5221578;
	Thu, 22 Jan 2026 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078930; cv=none; b=DR38TbmYOmruTO6uiYy4SCEQv7145cMsX6AUonexbA3q9S7YY8ZCTWqkYBo7aIVmpa8D0+vJqnyeVxlRWqSlZgve3+b69sTudFBg4H5sM61i+Lt88sMnuiovDEiG3pHMTSwewNpjwOV7etQBNNglk47xsst1a6tXT0vzPrSLLmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078930; c=relaxed/simple;
	bh=kPiiJETIxUP9WsAPxqgNFZO0zZM5C0cJmzk3IqciBOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkyNxQoSo2V/K49LjzOZyBPK2hlZSKdr54cEozLo63tN4DTVeOYQaQ36D9pjPnVXV0ybO4fHJiqbGakCejHudeOoVIKE9aX6JibjMbEgnl4jFXr53yKHemf1zVeC6ITqlLZzk7FKbGAr7CjQe8kY2GDQO6GAGNvuPAesIdVwK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T5BIC/2i; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T5BIC/2i"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60M00DxX028856;
	Thu, 22 Jan 2026 10:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JNDE2R
	YtSAzYx77ZcKAr+u5QG1KpD5RS54LtC4BwprM=; b=T5BIC/2iPPrLjFv5kExttY
	dNpstnCYKO0TgSUNb2kwoG0K0P5iARD5l6186s8nOZuW5WVAQZ/WCswwiFpuApwT
	4T6Ln8rxYQdALZkPUx0RB+5gT8skEKa1iKNdOGCEcTq+bllbbnSJjoeJ1pwvCp3O
	cx6B1Lb0BmKKQFmihU616AGgnmwMo+LGdYvMVjGl4YlxT6jh00ttn+l86UbMMHUL
	+81bSbe5ALe8Yo+O+VuD6Nmwx2cMCG5sTTtRmmDQr9dS+SLyQ0s029Y7wxNeAX5u
	dvrDJ3HzxqGQNK88cPMe1OitbA7mLu/VXGAu/3SZ4l4dFmxLDbwVefEr/GdrOCuw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt60evr38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 10:48:38 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60MAZf1X032071;
	Thu, 22 Jan 2026 10:48:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt60evr33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 10:48:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60M9tHW0017070;
	Thu, 22 Jan 2026 10:48:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4y9sb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 10:48:36 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60MAmW7358851776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 10:48:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC7D22004B;
	Thu, 22 Jan 2026 10:48:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75E5F20043;
	Thu, 22 Jan 2026 10:48:31 +0000 (GMT)
Received: from [9.111.56.62] (unknown [9.111.56.62])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Jan 2026 10:48:31 +0000 (GMT)
Message-ID: <38a7bed7-1272-40a5-8612-6be20d9493ef@linux.ibm.com>
Date: Thu, 22 Jan 2026 11:48:31 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 linux-next] perf test: Subtest Exclude disjoint subcmd
 names fails
To: Ian Rogers <irogers@google.com>,
        "Jayaramappa, Srilakshmi" <sjayaram@akamai.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com
References: <20260121082402.2311962-1-tmricht@linux.ibm.com>
 <CAP-5=fXwPrR-gwPbD7CcY6_fKg=s0yfNWSasFyYVQxCDhKKm=A@mail.gmail.com>
 <CAP-5=fWjzR0WqD7RyDE66ChUQnt4_qwauEPiDsrhtL02u_zo4A@mail.gmail.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAP-5=fWjzR0WqD7RyDE66ChUQnt4_qwauEPiDsrhtL02u_zo4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WMdyn3sR c=1 sm=1 tr=0 ts=69720086 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=X7Ea-ya5AAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=fmlYeatMnGT4I4VfyBoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oSAH5abIN6coRfqOOJ9GqWjlnmQFL52Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA3NyBTYWx0ZWRfX4QufSCCLtHJE
 HQYiQGXMzpT7PQH+O5nyTsqhIqj+N+PB9EgvKI1j1hpWp0bR5OJ6R/v4xCAlFe6b6iYhXGWmAgq
 Nuw5SjGHXG5sTCbKR3idZ7oAA2Y7LfnDH8U8YDkwxpRxcJ3stPkAtg5pjXKSz+iA1bLT3jdadt1
 ZudlnO7dOxFyfByi+2Zbs17CHLQj3w/lHkyUFawRB2wtvEGlVGTtewTfxFKiKZpCR+Lf0wYh6s3
 cmGqiGB+UCXEfbJPVVDqFnbDNErYDERgXzCK3yhcJCEzOsPCMbisWP/omhf7Ts0OjRb5eAfl8nq
 rJ9hvxCi1MPXSy1wHiCl+GxlZXiXvPw9QlCSeTotfHImY6I3nU6sA6u34Q2kyrCxBRtxlCjp0sa
 KulDRi9wIk49ViRGP9KjoXBZ8VPHmLHkqDCNphmxT0Qle4T7g01jcXJGM7h2pOA7qxSRqbzxQl/
 X3Hy44g/XRIy5uosskQ==
X-Proofpoint-ORIG-GUID: J320bGWI5U96L3gZilDtDcug0YG6h8Fg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601220077

On 1/21/26 17:14, Ian Rogers wrote:
> On Wed, Jan 21, 2026 at 8:12 AM Ian Rogers <irogers@google.com> wrote:
>>
>> On Wed, Jan 21, 2026 at 12:24 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>>
>>> V1 --> V2: Add linux next repository
>>>            s/needed/unneeded/ in commit message
>>>
>>> The perf test case 'libsubcmd help tests', subtest
>>> 'Exclude disjoint subcmd names' fails all the time.
>>>
>>> Root case is a special case of sorted input which the exclude_cmds()
>>> in libsubcmd can not handle. Assume the following inputs:
>>> cmds = { X, Y, Z } and excludes = { A, B }.
>>>
>>> This leads to
>>>  ci  cj  ei   cmds-name  excludes
>>>  ----------|--------------------
>>>  0   0   0 |     X         A       :    cmp > 0, ei++
>>>  0   0   1 |     X         B       :    cmp > 0, ei++
>>>
>>> At this point, the loop is terminated due to ei == excludes->cnt.
>>> The for-loop now checks for trailing names which had to be deleted.
>>> But the first entry points to a name: cmds->names[0].name == "X"
>>> and this is a valid entry.
>>>
>>> This is the case when all commands listed in excludes are less than
>>> all commands listed in cmds.
>>> Only check for existing names when cmds list was changed, that is ci != cj.
>>>
>>> Also remove an unneeded if (cmp > 0).
>>>
>>> -
>>> Output before:
>>>  # ./perf test -F 68
>>>  68.1: Load subcmd names                           : Ok
>>>  68.2: Uniquify subcmd names                       : Ok
>>>  68.3: Exclude duplicate subcmd names              : Ok
>>>  perf: help.c:112: exclude_cmds: Assertion `cmds->names[ci] == NULL' \
>>>         failed.
>>>  Aborted                    ./perf test -F 68
>>>
>>> Output after:
>>>  # ./perf test -F 68
>>>  68.1: Load subcmd names                           : Ok
>>>  68.2: Uniquify subcmd names                       : Ok
>>>  68.3: Exclude duplicate subcmd names              : Ok
>>>  68.4: Exclude disjoint subcmd names               : Ok
>>>
>>> Fixes: 1fdf938168c4 ("perf tools: Fix use-after-free in help_unknown_cmd()")
>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>> Cc: Ian Rogers <irogers@google.com>
>>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>>
>> Thanks Thomas!
>>
>> I tried to apply this on a perf-tools-next tree but it fails. Looking
>> into the git logs I see on linux-next:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/tools/lib/subcmd/help.c
>> the last patch is:
>> 2025-09-12 perf subcmd: avoid crash in exclude_cmds when excludes is empty
>> In perf-tools-next:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/tools/lib/subcmd/help.c?h=tmp.perf-tools-next
>> I see:
>> 8 days libsubcmd: Fix null intersection case in exclude_cmds()
>> 2025-09-12 perf subcmd: avoid crash in exclude_cmds when excludes is empty
>>
>> The test I wrote was to give coverage for  Sri Jayaramappa's fix:
>> https://lore.kernel.org/r/20251202213632.2873731-1-sjayaram@akamai.com
>>
>> I wonder if we've put the test into linux-next but not Sri's fix, well
>> that's what it looks like to me.
>>
>> Now that we have both your fix and Sri's fix, and they differ :-) I'm
>> wondering how to resolve the differences.
> 
> Sorry, resending as I got Sri's email address wrong.
> Ian
> 
Hi Ian, Jayaramappa,

I have looked at both patches and Jayaramappa's patch is already
in perf-tool-next and solves the issue too. I am fine with this one.
So lets simply drop mine.

Thanks Thomas
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

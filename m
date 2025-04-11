Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B9427CB1A;
	Fri, 11 Apr 2025 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744354737; cv=none; b=Ri8xjkwxaC5QsqXSIZm7JvwpSyWsWrn0XcQjskivsfdKJ1MrEguKSKr+WQwbfYDmtehBesoCrZUGccIxK+0O5fA1SW9KgazUtjIYFpRt/fjWrGYDdZI6uWg1u2hNRjn9XDkxMOthSSwDtvo+RdSGCD1WMLcRB780Q10UYfRq+6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744354737; c=relaxed/simple;
	bh=GmLFsC6Fs2/66dx1rzmBxOZiZDZJWqhmWvqJHTynw1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8i1N0aTvDf6fwxFk9lc/HrJ+GYFOAE8X/ysTRaQX1GvkxuPDrr9mhxhS/cOI5mk7v24LH8zZyKT7TszFojAUzoeYGoE8aXLuQkTIsHPIhXcHioHhj+uyfUyhF4xyy1Rif9vgl6rJJDFOT1t6LfUFBnfOxHsfv2W0nra8sVTITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UQDyVGDL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UQDyVGDL"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AKd1Mf013182;
	Fri, 11 Apr 2025 06:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oTe4j4
	3kHg8/zm+xNdrivAb3CTTMqczYkB128gpUdhY=; b=UQDyVGDLgQAZ313gCsnaJt
	OMi9HwkX/g21R9DAl8xV1uZsRBAhEeEIHggV7sTetTzEkWgOWHtOgwSGKf7aBdOY
	NZcrHnZVf3tqQAvq5AUP2h2hRrYAbM90pVEAwPLvh5y9NxPu/Ga5W/pesIGckR2z
	QguABWRXGw9kySDDw3j//91kfM9FRo9qC/wwvfji3wIiiEagWB4u9I+iYj+tWM7j
	LWKprqJEWaar56OApv+qmG58hEPi+cgWsloq0Mpd5ZaJcCmDLswZGwSWflU1qqCW
	HdeISaMVS7WWfnZd7zfEBY7XoG/7ydVMWlncb1RAoQvn+9BkXaQudQQhs7Ae8rxA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xn71a1ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 06:58:51 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53B6omw9008432;
	Fri, 11 Apr 2025 06:58:51 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xn71a1ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 06:58:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53B3mnZs029520;
	Fri, 11 Apr 2025 06:58:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45x1k77ppb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 06:58:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53B6wk1b45613520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 06:58:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1AF22004E;
	Fri, 11 Apr 2025 06:58:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A1A62004D;
	Fri, 11 Apr 2025 06:58:46 +0000 (GMT)
Received: from [9.171.64.254] (unknown [9.171.64.254])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 06:58:46 +0000 (GMT)
Message-ID: <27901544-619e-4704-a2a6-132e8ab6a6e4@linux.ibm.com>
Date: Fri, 11 Apr 2025 08:58:45 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf test: Allow tolerance for leader sampling test
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, ctshao@google.com,
        rogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com,
        Ian Rogers <irogers@google.com>
References: <20250410085522.465401-1-tmricht@linux.ibm.com>
 <Z_hkF6R9giaDGQZD@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <Z_hkF6R9giaDGQZD@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mgHeVlParuItWwpAApKfDzZ4A0bUQtEt
X-Proofpoint-GUID: nfbx7SrZZ8SfJDdmsYMzJ3_dQU-4e9h-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110045

On 4/11/25 02:36, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Apr 10, 2025 at 10:55:22AM +0200, Thomas Richter wrote:
>> V3: Added check for missing samples as suggested by Chun-Tse.
>> V2: Changed bc invocation to return 0 on success and 1 on error.
>>
>> There is a known issue that the leader sampling is inconsistent, since
>> throttle only affect leader, not the slave. The detail is in [1]. To
>> maintain test coverage, this patch sets a tolerance rate of 80% to
>> accommodate the throttled samples and prevent test failures due to
>> throttling.
>>
>> [1] lore.kernel.org/20250328182752.769662-1-ctshao@google.com
>>
>> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
>> Suggested-by: Ian Rogers <irogers@google.com>
>> Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
>> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> ---
>>  tools/perf/tests/shell/record.sh | 33 ++++++++++++++++++++++++++------
>>  1 file changed, 27 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
>> index ba8d873d3ca7..0075ffe783ad 100755
>> --- a/tools/perf/tests/shell/record.sh
>> +++ b/tools/perf/tests/shell/record.sh
>> @@ -238,22 +238,43 @@ test_leader_sampling() {
>>      err=1
>>      return
>>    fi
>> +  perf script -i "${perfdata}" | grep brstack > $script_output
>> +  # Check if the two instruction counts are equal in each record.
>> +  # However, the throttling code doesn't consider event grouping. During throttling, only the
>> +  # leader is stopped, causing the slave's counts significantly higher. To temporarily solve this,
>> +  # let's set the tolerance rate to 80%.
>> +  # TODO: Revert the code for tolerance once the throttling mechanism is fixed.
>>    index=0
>> -  perf script -i "${perfdata}" > $script_output
>> +  valid_counts=0
>> +  invalid_counts=0
>> +  tolerance_rate=0.8
>>    while IFS= read -r line
>>    do
>> -    # Check if the two instruction counts are equal in each record
>>      cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
>>      if [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
>>      then
>> -      echo "Leader sampling [Failed inconsistent cycles count]"
>> -      err=1
>> -      return
>> +      invalid_counts=$(($invalid_counts+1))
>> +    else
>> +      valid_counts=$(($valid_counts+1))
>>      fi
>>      index=$(($index+1))
>>      prev_cycles=$cycles
>>    done < $script_output
>> -  echo "Basic leader sampling test [Success]"
>> +  total_counts=$(bc <<< "$invalid_counts+$valid_counts")
>> +  if (( $(bc <<< "$total_counts <= 0") ))
>> +  then
>> +    echo "Leader sampling [No sample generated]"
>> +    err=1
>> +    return
>> +  fi
>> +  isok=$(bc <<< "scale=2; if (($invalid_counts/$total_counts) < (1-$tolerance_rate)) { 0 } else { 1 };")
> 
> Is 'scale=2' really needed?  Does something similar to the above like
> 
>   if (( $(bc <<< "($invalid_counts / $total_counts) < (1 - $tolerance_rate)") ))
> 
> work?
> 
> Thanks,
> Namhyung
> 
> 

From the man page of bc:


NUMBERS
       The most basic element in bc is the number.  Numbers are arbitrary precision numbers.   This
       precision  is both in the integer part and the fractional part.  All numbers are represented
       internally in decimal and all computation is done in decimal.  (This version  truncates  re‐
       sults from divide and multiply operations.)
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This can be proved with:
# bc <<< "2/27"
0
# bc <<< "scale=2;2/27"
.07
#

Without scale there is no fractional part and integer arithmetic will lead to wrong results.

I think scale=2 is necessary or we need to use something different like awk.

Thanks
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FE0D530;
	Tue, 22 Apr 2025 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745314264; cv=none; b=U2juq03KupEkHl4ghTbaaLT12/HI3ZZQ/+M6aYBc4lUk4h3fS2bGlGgVzXmNT+PikBynR/tMAmP1ZNvUhmW6wKP3581ekBwwOB3Dx2ageHNdfN44O7LJ9CcA+Gm62ME1lUG7nRJh509A2+EtKV6ecarxDl5hG6olIovYUtqD6aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745314264; c=relaxed/simple;
	bh=dVWut1y1uCXZbzkPySleeRDuQj+6ALhRGToeQfGQjww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggO/QXhW88bQNq2m33oQ1lFo0wo/tcEb7KerLvY5ViKNAlUE5+lYgNFIk/kdEpHDufHDMcyz78mR7SL6Ij5thdne1hJ2XeWHAc1s6pElBCFO23VwIdY4gmWRCYxHbjZ5GIupP62GDU7MZDp8UkxAIC2+PWwJD43UhyqBkVhXvZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FevK4pVq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FevK4pVq"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M97GL3021363;
	Tue, 22 Apr 2025 09:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qqmyx8
	EsmhliMxc5DdpnjRqAisS7wFj6uL5Bcak4MB4=; b=FevK4pVq9N+zKYgWAHq13D
	GfvivrRjJU8Cs5w8pefrtwFILbaykPU9P0f7t9t5og4Z1hNPd2lPjp2CYBarD1K7
	z1wRLsMAYMLF8hOR3RmIgZlGRFLYDyk0EOTY7mFrYPg6ZoQa+LF4+eHod6Cg3O1Y
	/iM2nJymSxOEEsS4RIdGttPSia2RuHlXA636XGRZOLzW5awosFWOzMbD+7Z2ssr2
	68vlWueWctlCEnkX9ZGcAzSNHTZza/xdyoDhaneM0+GQndifP/JPX2r8JAfnWk7d
	IHOTi7/OVyQssr2BxcOxz4xxJtbz5/6xKe0xUV9c2WgkeRdv+d0eUvc3rv2A9GtQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46686s831p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 09:30:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53M8kn8A028130;
	Tue, 22 Apr 2025 09:30:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 464rv21vbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 09:30:31 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53M9USwN55247320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 09:30:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D09320043;
	Tue, 22 Apr 2025 09:30:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E3E920040;
	Tue, 22 Apr 2025 09:30:28 +0000 (GMT)
Received: from [9.152.212.229] (unknown [9.152.212.229])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Apr 2025 09:30:27 +0000 (GMT)
Message-ID: <4dc2211b-9a34-4b97-96d5-197445f75bad@linux.ibm.com>
Date: Tue, 22 Apr 2025 11:30:27 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/tests: Fix tests 84 and 86 Add --metric-only on s390
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com
References: <20250415134553.3089594-1-tmricht@linux.ibm.com>
 <20250417115204.12521Ef5-hca@linux.ibm.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20250417115204.12521Ef5-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WP1/XmsR c=1 sm=1 tr=0 ts=680761d2 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=x4kxwI2lhZTCVj833_4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ssXgtLYNmP5udv_rnM7wKvVWH2_2SKQI
X-Proofpoint-GUID: ssXgtLYNmP5udv_rnM7wKvVWH2_2SKQI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_04,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220071

On 4/17/25 13:52, Heiko Carstens wrote:
> On Tue, Apr 15, 2025 at 03:45:53PM +0200, Thomas Richter wrote:
>> On s390x z/VM machines the CPU Measurement Facility is not available.
>> Events cycles and instructions do not exist.
>> Running above tests on s390 z/VM always fails with this error:
>>
>>  # ./perf test 84 86
>>  84: perf stat JSON output linter          : FAILED!
>>  86: perf stat STD output linter           : FAILED!
>>  #
> 
> I would guess this fails also for KVM guests?

Yes
> 
>> diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests/shell/lib/stat_output.sh
>> index 4d4aac547f01..a708dedf7d9d 100644
>> --- a/tools/perf/tests/shell/lib/stat_output.sh
>> +++ b/tools/perf/tests/shell/lib/stat_output.sh
>> @@ -151,6 +151,11 @@ check_per_socket()
>>  check_metric_only()
>>  {
>>  	echo -n "Checking $1 output: metric only "
>> +	if [ "$(uname -m)" = "s390x" ] && grep -q z/VM /proc/sysinfo
>> +	then
>> +		echo "[Skip] not supported on z/VM"
>> +		return
>> +	fi
> 
> Wouldn't it be better to test for the availability of the CPU-measurement
> counter facility? That is: test if facility number 67 is present in the
> facilities field of /proc/cpuinfo.
> 

I can certains change the check and grep for facilities number 67.
Will send v2.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

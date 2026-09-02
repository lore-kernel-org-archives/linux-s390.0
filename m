Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D259B379C2E;
	Wed,  2 Sep 2026 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330196; cv=none; b=OhvWJsuCd6M0+pVWMZZrkZ9Z0dZpF8c7CZ+hdug/V31qezj04fyFBIkCgvi8OZQzHGD1P+rYbebP7pcZtYMHQJQHJ/+w1HWXA8Ze1Bh+QBu/VyMBblymF7NkEG2hLF5Xt9ci8vLW9xi5TuzSPktrFw8l5MniV9dpj5vdu4JCHYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330196; c=relaxed/simple;
	bh=N6HGV2v34tIxrvNW7pb87uKl/c8R+EPdDWnxyhz6kx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGT9OGsa5wzK+3OZXlzymRmrWlcQgnfDEHEDVX79prMpHLArm2zp+V6mxLzfU87bVuoqazguiT7NRXARzXMW+GXCJhsvbroy+1s5MjU9NLty8Zva8Kv4plwKDvjFlsQOKuB5bxbUsBgPh3SzHNwn8/IE0Mv60dTSeS1GB1MRt0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qJ9/Zolh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qJ9/Zolh"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681KWoQP1100696;
	Wed, 2 Sep 2026 06:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=43Xnnl
	ynqqKaQn6iPZ1B/MuUxSVG9jKdFzru1OJeYGY=; b=qJ9/ZolhhZXU4acm5TPByk
	R0M6WBSvVtLRy7w8qhSppu1Q5UfEdwi5IMTFb6IRPWRtHr5/K0bd+mC6JaQpg5A3
	+737pczYomPq6i2t31QpOa6onTqedHbCdsBvXd4k1qmjGarc/LmofzL2kv9X5uyn
	lsL1kJyL76/JrOMUPhYO2NnDaVW2JiosdeKk73uwnXcypvEWDXia0kj49EMWpUuH
	CP9f1mOLbo9KQTPLc699tW63W/GCBcpWA3t5L/9faTTOJnbuOSQn9YkZPUgeE/RH
	lamtNeH41FAmv4vV+eL8/1+cBf+69k7PBnz1d+vne6HPbvwc3aZyVJF+4Oi3pj9g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudvekx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 06:23:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6826BGCW015087;
	Wed, 2 Sep 2026 06:23:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccey7wvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 06:23:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6826N8KL52101520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 06:23:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1DE420043;
	Wed,  2 Sep 2026 06:23:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB40B20040;
	Wed,  2 Sep 2026 06:23:08 +0000 (GMT)
Received: from [9.224.77.157] (unknown [9.224.77.157])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 06:23:08 +0000 (GMT)
Message-ID: <35066cf0-62d8-4f2d-91e7-f00487d9cff1@linux.ibm.com>
Date: Wed, 2 Sep 2026 08:23:08 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] s390/pai: Support CPU hotplug for PMU PAI
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, stable@vger.kernel.org,
        Jan Polensky <japo@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260901123320.670897-1-tmricht@linux.ibm.com>
 <20260901123320.670897-4-tmricht@linux.ibm.com>
 <20260901141942.14482E83-hca@linux.ibm.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260901141942.14482E83-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WwmGeqscJSCCFR31tpLwXKXqhEP4fxEv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA1MiBTYWx0ZWRfX9w2DVoSvwT1e
 5aI5vZ459G/Os7iTgQ98FVMruszClwLlf2U6NMQFte9k9mb75GUxM78almafpYmwRO//M7+jlS0
 XQLfW4/46kgRxY5DoFK7AzgrkozmZXLw2T0rqeB/DGHasDnJBDtEzrUFjUtnZidrs8+7PqSYeS8
 SEgXD3L1l95paBywYZA8PAzbdHLmZRKVwbudpRDEQsIEFhoy1CRnxONjb12ilvgyQtRixUwlPaG
 fvXZEDTjo+EfsRmaNJkDZLPBJONSZ9WonBhN4F9JL9213vJYILXeH+qg5y55XoEqM7t0GayhRpq
 E1GSEgdvjQWcD4zpeR++vuQ2V+KB2PKB+nmbEAxK7JkBvR+QJULduJeY7luuixM40yrUzPOCNi0
 NI8I53e32lbw/t6OenFoDBBugwupCRu1toSZrTcCnkJ4QYLS0dklGxpnAEeIAjmq6erCldaWfix
 tAafPX2NQXPIpZ/Mr7w==
X-Proofpoint-ORIG-GUID: WwmGeqscJSCCFR31tpLwXKXqhEP4fxEv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA1MiBTYWx0ZWRfX8Aq2/2jfcKxu
 PwwbJKVmpvnKyEuYvaSJVRBaVESWnrttEK6PFP5iIA0b4Dl6wO0r+/Bzc+kFwUoHLKtJ9qJebG4
 Ndof9SlYYo+Wrvn3GC0MFac8dDPpQxM=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a97c0d1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=XtJnxE0v6AKZ2ENc6gMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020052

On 9/1/26 16:19, Heiko Carstens wrote:
> On Tue, Sep 01, 2026 at 02:33:20PM +0200, Thomas Richter wrote:
>> +	/* CPUHP_BP_PREPARE_DYN --> before CPU is brought online */
>> +	rc = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "perf/pai:prepare",
>> +			       pai_online_cpu, pai_offline_cpu);
>> +	if (rc < 0)
>> +		goto out_debug;
>> +
>>  	if (!paipmu_setup()) {
>>  		/* No PMU registration, no need for debug buffer */
>> -		debug_unregister_view(paidbg, &debug_sprintf_view);
>> -		debug_unregister(paidbg);
>> -		return -ENODEV;
>> +		rc = -ENODEV;
>> +		goto out_cpuhp;
>>  	}
>>  	return 0;
>> +
>> +out_cpuhp:
>> +	cpuhp_remove_state(rc);
> 
> This would now use "-ENODEV" as state for cpuhp_remove_state. I fixed
> it up since I suggested this code, so you can blame me in any case.

Ahhh right, thanks for fixing this for me.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9B813B284;
	Tue, 24 Jun 2025 06:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750746931; cv=none; b=UYN+xGMGiWlKc2XLBYiFktdY9E/3cigpCqnpfKPOrG/dD1ecznAyGvjAf8+GU6E3NgYHZpJEnHbdTdiL4JMQZP1eSQZ7u+hiTNH9rLGRbCIw3vGHKaKSlnoBntXUO2pYZXgyvs+dYXMnyOBQEKSkNJrnpmCRLqxWVm5P0v0S95w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750746931; c=relaxed/simple;
	bh=JqHIVqC0ywsMBOqVkOcMY7gYmKbvXVQXDpqzSThGHlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMd4OVCIN/hRFkY/sQLdsHz+CxxYnBSF+tdki8HWAKelbwP9m31qXPxEycb9mPYJnLHI9oxgHDjiJa0puFhB+naA8wVDDL/HffMnh+d0nnRIJQqR9YVE8UnI/iT+8BR2VsA/U7jffsJUd0GkmqLtSUyjYp0BdRE0xJXTbB4T8QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HbU6agOt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HbU6agOt"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O5pqHZ026632;
	Tue, 24 Jun 2025 06:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EU8lPQ
	cM4c4rLi13rmWV1+8Jm1PcKek1/5wjDEiebyI=; b=HbU6agOtrC+H6vCutsomUd
	b1+UDthAbGvbU3w3jiPW+vDbpYOR81BVVsu37dWrfg0iwiF4it7M5jQfLgirXn99
	PBfmvmg4GNgEJwfTAzt8ui939O0d+yKUI6TAfBBmAF/vTM0pAMN4ZfLjz6777fC2
	TljAqRxXMXwQnrWmLQNP08p+hfH9TeVAjj99UTPQ2POF8IO5ZxWoKQoxpL6XLVOE
	pPUKwuDDBQrD3DFV0neaDn8Ye07PmiEiCc2vZDTzdXSv6YlkPyil8EIGLXkp968s
	5Cg1MqU0bUPxQrH8i1ug17S1duBWH1icQczsW1w53OoxGL/wtcQbJ4+9+Z3uwpmw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dme16pyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 06:35:27 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55O6UcQB024730;
	Tue, 24 Jun 2025 06:35:26 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dme16pys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 06:35:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55O5UJY5030487;
	Tue, 24 Jun 2025 06:35:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e7eytr03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 06:35:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55O6ZLUx45810056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 06:35:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 758462004B;
	Tue, 24 Jun 2025 06:35:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2630720043;
	Tue, 24 Jun 2025 06:35:21 +0000 (GMT)
Received: from [9.152.212.130] (unknown [9.152.212.130])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Jun 2025 06:35:21 +0000 (GMT)
Message-ID: <ad905a68-a89b-458d-8a8b-2081a6656b91@linux.ibm.com>
Date: Tue, 24 Jun 2025 08:35:20 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf list: Add IBM z17 event descriptions
To: Ian Rogers <irogers@google.com>, sumanthk@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        japo@linux.ibm.com
References: <20250623132731.899525-1-tmricht@linux.ibm.com>
 <CAP-5=fV_hXzq0A-91NakejcQGnvPp+uJGGe=vccwM+47JVCmtA@mail.gmail.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAP-5=fV_hXzq0A-91NakejcQGnvPp+uJGGe=vccwM+47JVCmtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Tc6WtQQh c=1 sm=1 tr=0 ts=685a472f cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=Ijd6lzqJG2aW12Tu_CUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: O_PDUk_VDM-TxWmpuruxgOrmND4Gbd3q
X-Proofpoint-ORIG-GUID: tn4b4MwragX7YbONVuR0l9BqJMnIX0YZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA1MiBTYWx0ZWRfX0DY1VwK2+kBT BgQ5kxel7HtuGuy9qNOhiN5Cp9fw762HcJOoU4HQgqfQaeAsrT8E8CnGO5EkLj2G80zKGQDmDr1 rURO2lL2GqRD+ngbvS/9i8ajz2ivCjzbTvxF6AxKHPedqi67oujQtMobKmQR37lgWXp0LzfQlD1
 ULWvoAdz5z/Z8cJB5U9Qe7Mtn5v4EZNLvZmKDVcaOkzTbvSODslWnXWIRaKK5Rj9ul6kaqceM3A CcTbV7eqBr/DqSV7e/aKkz6c5giqFOCDIpzPWlzQI51iDcXj+FHJO5lIVIS7RkQarqUuhX+yWxr 7C3oPjzSZKFKSv4Cnf3hAVUF98IxHu5CL4/2nxYnBpbx86m1Y+su1nWVi/3coJoLHgJj1l95whh
 IDNctXSpE3IQjrhp47L1F8/RMw1cZ66/y4bmhnhQ8M/lNv2QVDTNfjl7v5mAB/BNBeKJBSfM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240052

On 6/23/25 19:53, Ian Rogers wrote:
> On Mon, Jun 23, 2025 at 6:35 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>
>> Update IBM z17 counter description using document SA23-2260-08:
>> "The Load-Program-Parameter and the CPU-Measurement Facilities"
>> released in May 2025 to include counter definitions for IBM z17
>> counter sets:
>> * Basic counter set
>> * Problem/user counter set
>> * Crypto counter set.
>>
>> Use document SA23-2261-09:
>> "The CPU-Measurement Facility Extended Counters Definition
>>  for z10, z196/z114, zEC12/zBC12, z13/z13s, z14, z15, z16 and z17"
>> released on April 2025 to include counter definitions for IBM z17
>> * Extended counter set
>> * MT-Diagnostic counter set.
>>
>> Use document SA22-7832-14:
>> "z/Architecture Principles of Operation."
>> released in April 2025 to include counter definitions for IBM z17
>> * PAI-Crypto counter set
>> * PAI-Extention counter set.
>>
>> Use document
>> "CPU MF Formulas and Updates April 2025"
>> released in April 2025 to include metric calculations.
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> 
> [snip]
> 
>> +       {
>> +               "Unit": "CPU-M-CF",
>> +               "EventCode": "143",
>> +               "EventName": "L1C_TLB2_MISSES",
>> +               "BriefDescription": "L1C TLB2 Misses",
>> +               "PublicDescription": "Increments by one for any cycle where a Level-1 cache or Level-2 TLB miss is in progress."
>> +       },
> 
> [snip]
> 
>> +  {
>> +    "BriefDescription": "Cycles per Instructions from Finite cache/memory",
>> +    "MetricName": "finite_cpi",
>> +    "MetricExpr": "L1C_TLB2_MISSES / INSTRUCTIONS if has_event(L1C_TLB2_MISSES) else 0"
>> +  },
>> +  {
>> +    "BriefDescription": "Estimated Instruction Complexity CPI infinite Level 1",
>> +    "MetricName": "est_cpi",
>> +    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS) if has_event(INSTRUCTIONS) else 0"
>> +  },
>> +  {
>> +    "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
>> +    "MetricName": "scpl1m",
>> +    "MetricExpr": "L1C_TLB2_MISSES / (L1I_DIR_WRITES + L1D_DIR_WRITES) if has_event(L1C_TLB2_MISSES) else 0"
>> +  },
> 
> Just a quick check. If the PMU CPU-M-CF is always present then the
> "has_event(L1C_TLB2_MISSES)" check will always be true as the event is
> in json and not in sysfs. I'm guessing this is being done for the
> benefit of hypervisors.
> 

The issue is indeed with z/VM, where the CPU Measurement facility is not exported to
any guest OS including linux.
If you run Linux on top of z/VM then these events do not exist.

# uname -a
Linux a8345022.lnxne.boe 6.16.0-rc1m-perf #14 SMP Tue Jun 10 07:39:06 CEST 2025 s390x GNU/Linux
# grep VM /proc/sysinfo 
VM00 Name:            A8345022
VM00 Control Program: z/VM    7.4.0   
VM00 Adjustment:      50
VM00 CPUs Total:      4
VM00 CPUs Configured: 4
VM00 CPUs Standby:    0
VM00 CPUs Reserved:   0
# lscpumf 
lscpumf: No CPU-measurement facilities detected
# 

Without this if..else the perf stat -e metric fail when Linux is installed on top of z/VM systems.
See commit c2f3d7dfc7373 ("perf stat: Do not fail on metrics on s390 z/VM systems")

which fixed it for z16 machine generation.

Hope this helps.

> Thanks,
> Ian


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

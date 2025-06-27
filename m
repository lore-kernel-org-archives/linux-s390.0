Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B83224AE0;
	Fri, 27 Jun 2025 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751012029; cv=none; b=sFEXyOiMtl6miwoyP+kUpsjN53hHG4DzVtVKrVE2WkyRPSHOyxnzxCvLVrdRQBB0nFmESJPYhnt1fr/qEaaY5AzN7nE3RAuNiiqIifEHAJEFKd24yXJWWMR58Ym7hir89y9M63tBAr2iyLgMQpc0KdTjmT49RQ/dlKTfwsIQTfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751012029; c=relaxed/simple;
	bh=o6hJzsHfwa7l8QymsFAPFL0BssPaa5+yNqxXr8OOqGI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=f/Y2L+NuT6jdHrL2YQbQkKJMZXCgBUzvGgNVgSBCocLo5cUDrBADALtAqhRLml0rj/AHKZPvcLgCf+JMaRTatf4YLVtif4EBRrYElw2ynXzZCeToTgWW6Rd+CnbddKrOrLlGgSShhoxKLx0mu0+7gPcdF0VBJ2aSJo8A5jpgl6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gsdC/VKN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gsdC/VKN"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QMGbdt019573;
	Fri, 27 Jun 2025 08:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FRv+jf
	+H2WOoOyo2DrESPYPWQcOAbheMqs0hH1dSsC0=; b=gsdC/VKNSU+UJ+Kcn/+wtu
	yJCxzlTOYh3GGpn1VLdgrMabickgPWQEi7EDVtMgY/nTKEFysxFiFHb+oRYm7XpN
	V/qlAKAc4U+71qUzZet1qHqVWu2L+yMyUslWkUyeTyCO3NXXt913EnJ/DBtaxFzD
	bggmXNoGq/14AL781KTrszjV00NDUKV0OmZbmMR4xHZXWwzXVe1nzugMNgebXrwe
	ynzCKJgbVLVk+hO84zW+2yyLrN79I8rhJ331Lfscbas64hXXiOjyW8M31xUyoD9R
	U6s62xYtD4m4zTL7kPEjT/AVQh3TJcGlnuykaiDCwzq3Ak/1WfPO8R2ZDfIJ5+ng
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf3kgva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 08:13:43 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55R8BC8A015251;
	Fri, 27 Jun 2025 08:13:43 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf3kgv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 08:13:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55R4OUEJ031277;
	Fri, 27 Jun 2025 08:13:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e7f0b8su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 08:13:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55R8Dc6F56295772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 08:13:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CED5C2004B;
	Fri, 27 Jun 2025 08:13:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D0C920040;
	Fri, 27 Jun 2025 08:13:38 +0000 (GMT)
Received: from [9.111.10.20] (unknown [9.111.10.20])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Jun 2025 08:13:38 +0000 (GMT)
Message-ID: <283e109b-9eb5-4e7d-b7df-215f54496503@linux.ibm.com>
Date: Fri, 27 Jun 2025 10:13:37 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [Ping][PATCH] perf list: Add IBM z17 event descriptions
From: Thomas Richter <tmricht@linux.ibm.com>
To: Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        japo@linux.ibm.com
References: <20250623132731.899525-1-tmricht@linux.ibm.com>
 <CAP-5=fV_hXzq0A-91NakejcQGnvPp+uJGGe=vccwM+47JVCmtA@mail.gmail.com>
 <ad905a68-a89b-458d-8a8b-2081a6656b91@linux.ibm.com>
Content-Language: en-US
Organization: IBM
In-Reply-To: <ad905a68-a89b-458d-8a8b-2081a6656b91@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=685e52b8 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=NzcymgBwEkHtfacI-E8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA2MiBTYWx0ZWRfX+Z3hlRaHsMty 5w8fwgVXRRbsE8H9zke3lhvmZyEMj6pDkpSDpASIrAw90DYXYcLuya9GZ+i+3P+XYNdQryLdP+b 3/iNWPpCv3jTDTJXWkp+LahcZil7g29OdYO/SEE7UFLR03KqI9JDFbm1/RbxYsDVPJw4iDENfhd
 XHoArKJo+GTqD+fHMaDXKVC1R5kJCv/aI+z6rvSBGMePajpZdvVNJjYUR/Z/MCNx8lZwOMY4iNc Xuw6iu7pVXkOieCvCaVDseecUDcrNf7Y6mwf+x0La1zy5ad/zi0bKO3Ynz4UtvZphHkhuCsBBXr qyrknjgSxa2VDGlcovmYMlPqlp5/Ylvbmv2Wdy94+0KOW/pbtkIIZFysuOkdyMnSzeSjxb14WQW
 1yCS3RcWUqC9GaXOoEYkeNQaFpNWDDIG11VGdD0ZJmFl0Do1JVwLatz2Gm8+5IOKiM0Gpngy
X-Proofpoint-GUID: H2R94vQXsgPCdjztjCGfVvEv9kHIMcb_
X-Proofpoint-ORIG-GUID: USYL82GF2n57L5lrjJkladDPLAScSt2A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_02,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270062

On 6/24/25 08:35, Thomas Richter wrote:

Gently Ping

Ian, I have responded to your comments some days ago.
See below.

Thanks a lot.

> On 6/23/25 19:53, Ian Rogers wrote:
>> On Mon, Jun 23, 2025 at 6:35 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>>
>>> Update IBM z17 counter description using document SA23-2260-08:
>>> "The Load-Program-Parameter and the CPU-Measurement Facilities"
>>> released in May 2025 to include counter definitions for IBM z17
>>> counter sets:
>>> * Basic counter set
>>> * Problem/user counter set
>>> * Crypto counter set.
>>>
>>> Use document SA23-2261-09:
>>> "The CPU-Measurement Facility Extended Counters Definition
>>>  for z10, z196/z114, zEC12/zBC12, z13/z13s, z14, z15, z16 and z17"
>>> released on April 2025 to include counter definitions for IBM z17
>>> * Extended counter set
>>> * MT-Diagnostic counter set.
>>>
>>> Use document SA22-7832-14:
>>> "z/Architecture Principles of Operation."
>>> released in April 2025 to include counter definitions for IBM z17
>>> * PAI-Crypto counter set
>>> * PAI-Extention counter set.
>>>
>>> Use document
>>> "CPU MF Formulas and Updates April 2025"
>>> released in April 2025 to include metric calculations.
>>>
>>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>>> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
>>
>> [snip]
>>
>>> +       {
>>> +               "Unit": "CPU-M-CF",
>>> +               "EventCode": "143",
>>> +               "EventName": "L1C_TLB2_MISSES",
>>> +               "BriefDescription": "L1C TLB2 Misses",
>>> +               "PublicDescription": "Increments by one for any cycle where a Level-1 cache or Level-2 TLB miss is in progress."
>>> +       },
>>
>> [snip]
>>
>>> +  {
>>> +    "BriefDescription": "Cycles per Instructions from Finite cache/memory",
>>> +    "MetricName": "finite_cpi",
>>> +    "MetricExpr": "L1C_TLB2_MISSES / INSTRUCTIONS if has_event(L1C_TLB2_MISSES) else 0"
>>> +  },
>>> +  {
>>> +    "BriefDescription": "Estimated Instruction Complexity CPI infinite Level 1",
>>> +    "MetricName": "est_cpi",
>>> +    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS) if has_event(INSTRUCTIONS) else 0"
>>> +  },
>>> +  {
>>> +    "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
>>> +    "MetricName": "scpl1m",
>>> +    "MetricExpr": "L1C_TLB2_MISSES / (L1I_DIR_WRITES + L1D_DIR_WRITES) if has_event(L1C_TLB2_MISSES) else 0"
>>> +  },
>>
>> Just a quick check. If the PMU CPU-M-CF is always present then the
>> "has_event(L1C_TLB2_MISSES)" check will always be true as the event is
>> in json and not in sysfs. I'm guessing this is being done for the
>> benefit of hypervisors.
>>
> 
> The issue is indeed with z/VM, where the CPU Measurement facility is not exported to
> any guest OS including linux.
> If you run Linux on top of z/VM then these events do not exist.
> 
> # uname -a
> Linux a8345022.lnxne.boe 6.16.0-rc1m-perf #14 SMP Tue Jun 10 07:39:06 CEST 2025 s390x GNU/Linux
> # grep VM /proc/sysinfo 
> VM00 Name:            A8345022
> VM00 Control Program: z/VM    7.4.0   
> VM00 Adjustment:      50
> VM00 CPUs Total:      4
> VM00 CPUs Configured: 4
> VM00 CPUs Standby:    0
> VM00 CPUs Reserved:   0
> # lscpumf 
> lscpumf: No CPU-measurement facilities detected
> # 
> 
> Without this if..else the perf stat -e metric fail when Linux is installed on top of z/VM systems.
> See commit c2f3d7dfc7373 ("perf stat: Do not fail on metrics on s390 z/VM systems")
> 
> which fixed it for z16 machine generation.
> 
> Hope this helps.
> 
>> Thanks,
>> Ian
> 
> 

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

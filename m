Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFEB2C375A;
	Wed, 18 Mar 2026 06:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815268; cv=none; b=VbpEGbMPjfL+G8QvB0LcsEJkvNfLH8RjRvYHO+NWWW3DzooZUyEM0zriBMIJhcI6cSEJerhen81YP9oZKghg3nFr/yJQN45w2g9hkbYicFAuOOLGSYBW5Z/SriMXI/I2/76hKpBWPjArICpex7YCdsgBbIIoLdB5s1e4QYU4IVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815268; c=relaxed/simple;
	bh=7bgER+2HXLBBaGBvT8Sv/EmUeSlZYaDNvSVCwbN7xEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rd+4lwD4xBVMP4cSQ7zizhEs+rp0G45YXnxXfQ7NKAr6K3wCsHIk+gPhEpTPt4/Ll23sr/0uUVAKBs1ael5eHny75uMCigSm2Km/hIlVxdQBWU1vwUNFT4BzTN/yGcIEbKhFnY3U1ddVU5UYk9KAbzAsMxBG+/pZevK5ifVXQxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OcmtagQK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OcmtagQK"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I5XwGQ3291959;
	Wed, 18 Mar 2026 06:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vhZw8N
	xDlM2IPs7Di6yVltP3+MTSiOO59m1ac2csSRE=; b=OcmtagQKWd8snAR/SFDRZc
	PabyFOOmAzE/NQd/PFKDygfkPNRevkQxBukx9Zz4kns/P0l7StJW2yBZ6lLGy97G
	nJGgHMVqzjpXe9I+UtSdll4igikTYr9VGSDmkETrebsjf6vpA5f9+/tQZ08cKdZH
	baVNXptSyO65rv1tfj+pfvBsNlW4yCeo4SP58hNgHICHcgYukiDCWW0Se52M6u6Y
	tgiVcLt2GYUt69yFebdHDqXCoJY85M1p7PxAN6hBd6dKYQQDL7PzGwYelQtPjagX
	yqzKSNcuejYPzz0Zx5qVCOpkZgBr9cc2tx8rUM+uptwfZcWMoa6u8FOw20LRckMg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cyx8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 06:27:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I4KTYm004563;
	Wed, 18 Mar 2026 06:27:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0scuak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 06:27:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62I6RVeL53608746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 06:27:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A15920043;
	Wed, 18 Mar 2026 06:27:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E2F120040;
	Wed, 18 Mar 2026 06:27:31 +0000 (GMT)
Received: from [9.52.199.37] (unknown [9.52.199.37])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 06:27:30 +0000 (GMT)
Message-ID: <6dac1f79-ff68-4583-a108-e9d291422438@linux.ibm.com>
Date: Wed, 18 Mar 2026 07:27:30 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf record: Add support for arch_sdt_arg_parse_op()
 on s390
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org, irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com
References: <20260317110641.39975-1-tmricht@linux.ibm.com>
 <53039fb5-4785-48ac-8e9a-7b561a3242c6@linux.intel.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <53039fb5-4785-48ac-8e9a-7b561a3242c6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69ba45d8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=aUDzc13T6hfFQuJ2b8gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA1MSBTYWx0ZWRfX6A2uICfy/Q0Z
 N2Y0Q7QKKZ5XcCJ8ewXRo8fTstwN9BHIwgy7bjH/npxyecNWZ7S2t4p6ePVXbYTth8AEFH8tdl8
 LENkfZLo3oGuXCKnETeHCcL1zHZcCPs6ugc8k4pkVltaxwJkDqx43DX5InIf68A73pk9hQgXVk7
 K1hJ5MfNjJGFDpY4tbE7SDGkJvaJMSEbiW93yZXLIUQGidHW3ws8k+wOIYHGpz7kEw427Vv1N18
 UAIAEk9E+zK5qVByImJ+FujYFjQ80yllDfs7cSwBk40hKqGnOtg4HihrvwBJAZ5+ojc38Q1gSB2
 YMSZ/r7epUJjFs1VZNnKXJnRZuzGeC5WsBk1glbSgdPZONnBY1ef7gGzyXtrbZ2xnNTjltQNg3M
 Hf3mIOsaM1TdW9J/UFAKPSSn029/osiEasxT19uJ73PGn/3Bv39nurq6itRy/RuV8uFx8y2Uw5B
 FBuztCLVCNaG40AER9g==
X-Proofpoint-GUID: GYMRQXyn8CFEMKpp_Ht4F20F9uXo-WKP
X-Proofpoint-ORIG-GUID: mTsSjCs5UHMb86vnPDwaeZGmdjD0r8ag
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180051

On 3/18/26 02:52, Mi, Dapeng wrote:
> 
> On 3/17/2026 7:06 PM, Thomas Richter wrote:
>> commit e5e66adfe45a6 ("perf regs: Remove __weak attributive arch_sdt_arg_parse_op() function")
>> removes arch_sdt_arg_parse_op() functions and s390 support is lost.
>> The following warning is printed:
> 
> Not sure if I miss something, but it looks there was also no s390 specific
> support for arch_sdt_arg_parse_op() before the commit e5e66adfe45a6 ("perf
> regs: Remove __weak attributive arch_sdt_arg_parse_op() function") and we
> would see same warning even without the commit e5e66adfe45a6, right?
> 
> 
Absolutely Correct, but in my opinion it does not matter if it was your patch or if
you just remove the __weak attribute. Your patch revealed the missing s390 support, which triggered
this patch.
If you do not like the wording, what do  you suggest?

Thanks Thomas
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

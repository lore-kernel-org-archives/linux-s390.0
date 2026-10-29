Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276784;
	b=pA+ljIoixh++k9y335zGWYduwQ4ZuYMvF3Nlpl99Pk4QqHzTi6SSnAmEfLBFPFZ2C/81
	 VeN13EYHblM5g79B42u9Xl3fYKZRgQJN4hGC/dbJXvWfOH4UXAKxBleML56rcg3LmZeCo
	 Yz2pajDpToVvR3qSEkON+/gtcx/jUCMa+jSrfunxJZnHYJWXEHoXT7BFyUJ/rcGYSCwaB
	 SGUeyf843+QPnE5sJhGgJOCEhqv1lFQ2aKw0kTUtsKqyS4PhT7mZjTXZuVG1Mdj194zyy
	 cgkaYj2ojF0qlx28gYkZtPCULttB8C/h+uSCrk/JR642zDTEYpOA3hyG9wAOesulgqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276784;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NhZM8bfaMOlAUskRwuZdYFdBouah6ljFuWI4CEHi4OM=;
	b=Skg8Jt4rpNiISQH+voOpsalkroDtp/FAohCQKHcwOpdEM8GO7JPeiKaSa/fWnU7lPl1y
	 ZvqXV213f3zupvu5iX+nFa+ALIrqc0ZsxMJNOcXYLeiTKtbCV9CpU9xYH3btwrd/yOwLd
	 pNZREYtxMwZsRAOsPL7B/rBzBShXsi4oWdJomgSDXxYJJaR5xjgD5L6mLDroNZvOTIs5N
	 nZxmFfKGUptUR4HvrV5H+9WGp8qZ242tO04zId3nqHwmdmpdrLkLZP79pQjOv1CnXS6HN
	 klRJ11W7W+DGKh/mHSsbnBFVqqD5hrpkkQHzoFrJzBG/gNxO01llyMCE9iyhEaPRuKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="YUMSvKh/";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33B3606A31A;
	Thu, 29 Oct 2026 12:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D33B3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YUMSvKh/
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T9Ep8V3777010;
	Thu, 29 Oct 2026 12:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NhZM8b
	faMOlAUskRwuZdYFdBouah6ljFuWI4CEHi4OM=; b=YUMSvKh/JCtiZUqTtFZsI0
	zOYVJron2zNzSyPMNA8prDp/B1LIArQrgQgq7XkD8SFkwFMUfeRqHKtwoxeKKJ9m
	XTy/aC8y1SSSuHN9Ve/XhAZBa1zc+TZ4fnpBtc1p2NZRjiikAi3FlbWTLwHvEJeV
	hJ+GXsYKGrmjjhbWVIK4YjPaj9mIV/2wuZvzvMAz4ZV8L5kfSqBadPaqenTbiiCP
	bHQcBL0KwK2tzIwhJGoJjC6fNNJhoVG2JhRzEyGzSRiXYR4ClkfPqbt4ahosnVgs
	Zw8Lk1rBLyiE0eHfhUw0nfQ5j2PHbftKHhIIJHvDS94pIcQjcoumgqKZhSv2IV/A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmavsj40-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 12:25:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69T952Et2945443;
	Thu, 29 Oct 2026 12:25:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8ghbsjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 12:25:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TCPn9C30605828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 12:25:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D109B20040;
	Thu, 29 Oct 2026 12:25:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E95972004E;
	Thu, 29 Oct 2026 12:25:44 +0000 (GMT)
Received: from [9.124.223.8] (unknown [9.124.223.8])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Oct 2026 12:25:44 +0000 (GMT)
Message-ID: <261148c1-48ba-4ede-bad6-24c18ed9d545@linux.ibm.com>
Date: Thu, 29 Oct 2026 17:55:43 +0530
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] sched: Introduce idle SMT priority for asymmetric
 capacity systems
To: Mete Durlu <meted@linux.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc: Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20261008-hiperdispatchfix-v1-0-73fe41081070@linux.ibm.com>
 <aseIPhrDGCYFtJNE@gpd4> <90454932-1d82-450a-ac4c-499acdedb9d7@linux.ibm.com>
 <ffbeae31-0e93-4386-8e0e-dba13960b283@linux.ibm.com>
 <CAKfTPtCianGNWSu0s2J_B_aO_rtKWO17k9guYmwgXXLUHQE+SA@mail.gmail.com>
 <d412d939-4704-4246-a9bd-b49b457099b8@linux.ibm.com>
 <CAKfTPtAGiesy0FZQ3aOny_1QkqaX0P2MCOdkE42ERdihRJL99g@mail.gmail.com>
 <ce85388c-3ea0-4363-8c89-fe2bf71b284a@linux.ibm.com>
 <CAKfTPtC70sx58uiaMEXv=vOk+o-Q_1PcHewiVjGCWMd_kvn=tA@mail.gmail.com>
 <e560fc10-f0f4-4cfe-b86d-4df4e2ba3120@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <e560fc10-f0f4-4cfe-b86d-4df4e2ba3120@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6ae33b53 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=b4NwTnLg8QrBWy7gGLMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qPilgbHAXR4fdbQFrM_chj1dNSsLwUpW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0NyBTYWx0ZWRfX16fUt37wj3XE
 4pXnRVwr+VKeaTccfKEn0eHeMcxMxrvcpdnsO9qrhKb5R696jpw82cm70i/KUhPhEROVgwOfWlf
 QlJ037wJ3DpuPdGuN4G2WeTfkrK84OA=
X-Proofpoint-ORIG-GUID: PKm2xy41HcAiQd2hM2YwRMLd-yz0ZfJZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0NyBTYWx0ZWRfX4koadrSnndvG
 qJdFq2fda7SOWZXBSKUlm0y94DcBenut/Hy9CsorzxqkUr2FVjzwGrIP1HrtSrbjLzzNH7VatSv
 r6fFU1C8LdOeb76DGAaGNnDTUcG4x3dRI1UptqCLcLUmASwwFAc3qe+F9V9XN/HU+X2LZupWb7e
 v5uK200Qvb2hhO4cUkhOQyoTZNM6p6X0FfHhyKSf77Di6gvwWIy6mmUmK7n9njSzIUgAWetXQL6
 7ubGWzDtZxnRAuHK2wkuta9XZLGWdqRosBWsGKPA7V2bLjI9OdGvbU5Dabr4p+wV2+k5LWdq0Ef
 cMZx3KIIdFS8Q0Voby8xXDFkUKF/LamZhdbPvzNzwH0nxCZNZkBw+4g59YRpNiFj7AIqLHw4nQN
 lH48Nf+9tE7ejYp6Bjt+ipp0vIv/ANTtZzvAS8TbG3gk5JrRDCBXlK99cc8o84ELB/bx6ZQL2xX
 XfBwki/0GQ65b+ZFC5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290047

Hi Mete.

On 10/20/26 2:43 PM, Mete Durlu wrote:
> Hi again,
> 
>>>> What you describe really fit into the prefered core that Shrikanth
>>>> Hegde has developped
>>>
>>> I agree, but Shrikanth's solution can not bring some of the
>>> behavior changes required. cpu_preferred_mask can help
>>> direct task placement away from low capacity cores but idle
>>> core first approach still places tasks to fully idle low
>>> capacity cores. This patches proposal tries to move tasks
>>> first to the idle SMT siblings.
>>
>> We have compute capacity to decide which CPU is better than others.
>> The capacity of SMT CPU has also been somewhat random, but we should
>> find a way to fix this instead of adding a threshold to decide whether
>> to pack or spread tasks onto idle cores. With correct per CPU
>> capacity, we can easily decide if an idle low core is better or not
>> than the sibling of an already busy high core.
>>
> After thinking about this a bit more, I have decided to work
> on a different approach rather than trying to integrate
> into Shrikanth's vCPU backoff or trying to expand this series.
> 
> I'll come back with another series after I become more familiar
> with how the SMT capacities are calculated and incorporated in
> the decision making process. My gut says the real challenge is
> going to be finding a way to benefit all architectures that
> configure asymmetric capacities but I'll give it a shot.
>

I think you can split this issues into two.

1. Does choosing idle vertical high SMT CPU is always better than
    an idle vertical low SMT core. This isn't related to any system pressure
    or steal time. If yes, you may need something like ASYM_PACKING, or
    select_idle_capacity etc.

2. If you want to avoid vertical low cores when under high steal time, then
    using steal governor is probably right direction.
    We could add arch specific hooks if current logic doesn't achieve it.
    But this is only under HW pressure, not always.
  
> Thanks for the valuable comments and guidance.
> -Mete


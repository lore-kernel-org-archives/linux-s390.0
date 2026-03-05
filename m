Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D5C3E51E5;
	Thu,  5 Mar 2026 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772731516; cv=none; b=oaOdvNJYBrfLxdpXBdyad+V1f+dIQiEv+iEHYc5AJmmkhgYSNUVd07XdxOoehD14/cxfpYGrNlse2mzUdfMUHJMdFcAsCYrI4Wmkj4GlW8BJVMYlwehev7qpJ78JGd8QhO5xw/nur3/sQhV8Hwo+1+PjRFPPeFsdGAVVr1ox/Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772731516; c=relaxed/simple;
	bh=cBMxkXv8SoYpT5t1ny+k5C56RqZts3Wp9Jaetnp+0ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKybPucJ7219cja2dAJm9bVTzpXnmL4ILBVi3zC3k7yyRtmvv/SbtHsono3wbEGqW9+/fvqiAwAW5hbmVDfbLUlEKUFyG6EMrLSPAH066ay+2Ut2pNlu/+amRFEkJmpgQGW2x/0jc9QR17In5RgXNaYb2kY1sE+7oHud8bTi/6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XSLTff2j; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XSLTff2j"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6256Xha82358989;
	Thu, 5 Mar 2026 17:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1/Rf+R
	Q9iNn2RJqfEb3mYjJSwWt36B8HMUjS+9r4b0Q=; b=XSLTff2jIKaT3XUvNvky8g
	DQMs95ePNyqgdzD0us05Tnq/1O1AezmL9MHKNNpkc1ZKYpJrDM8fYO1fqfFwfZy8
	ynV60YiAkODN8irnFiNDWskoPBr5U/JlZFhzcBEb5OnW5gNTAxnX7OADEcRyPgoo
	4TuUuCw33KmaJ8T/kwiBudaAv84+b0J9/bhfvXPXaTPM8tBVOG4YC3sjpyOHC+8I
	X1I2+NVB7/qf4s1mVEQg1ZD+to+uFtEUuJ71nn2BkKmnDwLWmH/Xb6JhUOKUXZDW
	8cHDwpzfQVL5tdswfzN+bVu5c4gVhk54/5R7nmxoLgM12DBlLitBQ9BO6qLSkzLw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk44cat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 17:24:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 625E05fI010317;
	Thu, 5 Mar 2026 17:24:54 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6kc7ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 17:24:54 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 625HOqRp30999096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Mar 2026 17:24:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A52E458058;
	Thu,  5 Mar 2026 17:24:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7377258057;
	Thu,  5 Mar 2026 17:24:51 +0000 (GMT)
Received: from [9.52.221.31] (unknown [9.52.221.31])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  5 Mar 2026 17:24:51 +0000 (GMT)
Message-ID: <cfd76996-ecae-4ed9-add0-70ca2e59ef11@linux.ibm.com>
Date: Thu, 5 Mar 2026 18:24:48 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next][s390] Boot hang after merge c50f05bd3c4e
 (sched/hrtick)
To: Heiko Carstens <hca@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-next@vger.kernel.org, linux-s390@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Egorenkov
 <egorenar@linux.ibm.com>,
        Thomas Gleixner <tglx@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <af549a19-db99-4b16-8511-bf315177a13e@linux.ibm.com>
 <28add480-4841-4e6a-a8a9-1211280ecc51@linux.ibm.com>
 <20260305074922.7170Ad3-hca@linux.ibm.com>
 <20260305121201.GB596554@noisy.programming.kicks-ass.net>
 <20260305123505.GA1395416@noisy.programming.kicks-ass.net>
 <20260305124501.GB1395416@noisy.programming.kicks-ass.net>
 <20260305130725.GB652779@noisy.programming.kicks-ass.net>
 <20260305150210.7170D10-hca@linux.ibm.com>
Content-Language: en-US
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
In-Reply-To: <20260305150210.7170D10-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N2TvqY9IMQqgqq70Y0Q9xGSR3M8mD1yp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE0MCBTYWx0ZWRfXxlLuEiY9WvcO
 kyVjn1RtVgzn3VDJRAU+jnQvzBKYyki0HlEXzwuwyevypXYiB4AggnN1sHbYTt1woCNIPXYKXQ0
 BDkI0GIdYZEbk2OGTd5N5TYjN+lpNpJlWf7VdBLdSLduwIqZ5ObgJc+xUnH4iIkrkSB+ODmS6dg
 O3W/hIs+5Wb3yaTon3XxdZBGXs5iO9pllHItNYTpFBs1S3VvcjP2NxwZjnW7vr/S1QOR6Laua1+
 jTofd1outRazoDpkP2VHgFObflv2ICc28yosckyuKXx+oaDtN4JfXYO6VnY0VgUj9v0XMdc69gb
 cM/LAyvSPnCyZfBv/G36h+lvqjr53qULpO+dFuQTi61OVCxGKUFnzAKIJ1ZEcN6JZ/qr09+Lbn1
 bssi9Qwb8SxoqR1P9KkhXvzLAd65yXr4gehS7BLuCCYuwRww70/2qdvxHTZKv5fSPj9pg18Y+id
 S+4BgtH6/svqyZMCqrw==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a9bc66 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=XzDXOgBD491ubj_CJSkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: N2TvqY9IMQqgqq70Y0Q9xGSR3M8mD1yp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_05,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1011 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050140



On 05-Mar-26 16:02, Heiko Carstens wrote:
> On Thu, Mar 05, 2026 at 02:07:25PM +0100, Peter Zijlstra wrote:
>>>> Moving that before irq_enter_rcu() means it doesn't see HARDIRQ_OFFSET
>>>> in preempt_count(). As such, it might actually call into schedule() from
>>>> hardirq context.
>>>>
>>>> Or am I missing something?
>>>
>>> N/m, it turns into __this_cpu_add() and that doesn't have
>>> preempt_enable().
>>>
>>> 00d8b035eb71 ("s390/idle: Slightly optimize idle time accounting")
>>>
>>> Is actually a correctness fix afaict.
> 
> Yes. Those dependencies become quite subtle when calling early into C code.
> 
>> Another change is that you clear I and E in the PSW bit before
>> irq_enter_rcu(), which, per:
>>
>>   7e641e52cf5f ("softirq: Prepare for deferred hrtimer rearming")
>>
>> can re-arm the timer.
>>
>> So where previously it would re-arm and still have the I/E bits set, so
>> the timer could fire, they are now disabled.
>>
>> I really don't know if this is a problem; I'm clutching at s390 straws
>> here that I really don't know much about.
> 
> That's the old PSW where the interrupt happened, not the one with which the
> CPU is running with, and shouldn't have any effect.
> 
> ...but reverting that commit actually does fix it for me. 

For me it doesn't. But reverting this one helps:
15dd3a948855 ("hrtimer: Push reprogramming timers into the interrupt return path")



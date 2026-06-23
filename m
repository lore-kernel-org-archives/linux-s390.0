Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A0D3537E5
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782216167; cv=none; b=kjVm8oE/dBHhPa3kdT9v9FEZ86Ldge6PhCzaPtHzEy5Jg127u9+2lYI28JMJ6Z4JMDpVfdEKCsoudMf6GEXbdXe2xgTaECcNZddj6HvTqzmq7VSZBFZ4d/q+jKa/lEjVXNQ2M07hGMygKiXCY3RGKEsQZTYbERiBavHMKRKOf9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782216167; c=relaxed/simple;
	bh=m4AlDMOVgMhv7q/euT4CPCuvDzbhszHDNZZB57ccKmg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=B1NfRIvvqErVoJWAMHjDSb52dW8mUPtdVlfqVRqWRadW6xt1NXPpDWuvWw1H/T5hHoEcAICsHz1AXRO5Fco3UO5TEsGHbqrzD4+uUejPRYs0IGWr+yHn1I77sWn8hlROmRRX1oYmWXWavSXYsmMBubU5PKJ+opotG2isqS8mmuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G0c5XNub; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G0c5XNub"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmjCx1915054;
	Tue, 23 Jun 2026 12:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=PDLhRE+YjYyYFPgNhhkYVNqJcnd0PkSiJavUudGCwM4=; b=G0c5XNubIrhL
	njya5pj9BTq+caZu9tURF39/CkK59ynau/NZbZTasPSYKPrM5paIP91TgtKureB/
	0/kCyEDNisBWTTxgMzE3zaAucknAOTXN7HIEpoAll5SSxzjR4NZOGJoZUcRr/x+W
	iVJhpm4ON9RtgxnraisgHiyisRs9Z3vPC/YQUMdxrqVIuZvCnFeyVFnoIgnkwxIq
	YFbgzHRiP84kBckNKIoWX6uDWxRta3bJV9PVHUFDMZYOPE1S8ytvhhKMI8fJdCs0
	/wtazRZ+oOpW5GUsaM5/c2h+W3hqZjNcjecAtfuOpSKPIXLvPHAmTBeZawRWsaBX
	JujSCa1O8g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4e9an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 12:02:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NBncPx010829;
	Tue, 23 Jun 2026 12:02:33 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k32mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 12:02:33 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NC2WAk20578974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 12:02:32 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28FC758068;
	Tue, 23 Jun 2026 12:02:32 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D559F58055;
	Tue, 23 Jun 2026 12:02:30 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 12:02:30 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 14:02:30 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Finn Callies <fcallies@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org, linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v7 10/17] target/s390x: Support protected key AES ECB for
 cpacf km instruction
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <7b9de533-5755-4c58-8ea8-4be47fbfc7a3@linux.ibm.com>
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-11-freude@linux.ibm.com>
 <7b9de533-5755-4c58-8ea8-4be47fbfc7a3@linux.ibm.com>
Message-ID: <06f34e1d81212a937f391f699b21071a@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA5NyBTYWx0ZWRfX7fO9NX4acb7S
 upPf95W5XWmeWQgCzFIOaeXN/OG5UOJf/iUVRtKTl8ePRp2DmJj6IKPY7vpIWshh7/XusLdWAKb
 GBd7EaoB5u2wPXx4kXfUSzJ0ODqyz1Y=
X-Proofpoint-ORIG-GUID: 1gCz99LkUeCr-NROszGvlBO3Tu3Evp4d
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3a75db cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=PCYrZotcpQq2-XiLgeAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA5NyBTYWx0ZWRfXzzMY9s9Lgr3A
 4+9n8rU0Vbb2jL7jbYa72OopQWIpQ1JBANGZzwAy+faWw/wbzGRxyKHjI38gfSDCfTGqWGJ4ix3
 7KjYFe0K4IPkOLpZ9Rrdy2usmd9q8+L6d7gJ0WKOMBFEk94CTzmMdwQMsQMdiOskBHHay6wSYVI
 qnoR42xsqqUrhZ/XNQ2UhLx5aaijYZbDPNnelnsXTrHotJXpwoiLOtrPaQxygq/amiPYZcA++Ki
 sx13bVXtaKebaoip+wFTJtqlfN+upJQ7H9eiO80p/FDSNvOC34IW/aUVsgpfsdu2e7sZb1rNFx5
 6CeHcaYE/+27FY65PIOM+TZcUaJW+O0zz9K9T3RU2wV6htEvfHyVH4IJPZyH0tjO8nm32SDnFz4
 XJ7KUwmPcQAXAmOLk8sXTaPd4uKlnYdvtfRfflBHwJdX/IcOLUsnpzS04oeZ4XcNfHFGW5fx9PI
 fBA2zjIOqbLklIDzz5A==
X-Proofpoint-GUID: 1gCz99LkUeCr-NROszGvlBO3Tu3Evp4d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230097

On 2026-06-18 08:05, Finn Callies wrote:
> On 17.06.26 11:48, Harald Freudenberger wrote:
>> Support the subfunctions CPACF_KM_PAES_128, CPACF_KM_PAES_192
>> and CPACF_KM_PAES_256 for the cpacf km instruction.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
>> ---
>>   target/s390x/gen-features.c      |  3 ++
>>   target/s390x/tcg/cpacf.h         |  4 ++
>>   target/s390x/tcg/cpacf_aes.c     | 87 
>> ++++++++++++++++++++++++++++++++
>>   target/s390x/tcg/crypto_helper.c |  7 +++
>>   4 files changed, 101 insertions(+)
> 
> [ snip ]
> 
>> diff --git a/target/s390x/tcg/crypto_helper.c 
>> b/target/s390x/tcg/crypto_helper.c
>> index e1952ae4bc..988226338d 100644
>> --- a/target/s390x/tcg/crypto_helper.c
>> +++ b/target/s390x/tcg/crypto_helper.c
>> @@ -103,6 +103,13 @@ static int cpacf_km(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>>                              &env->regs[r1], &env->regs[r2], 
>> &env->regs[r2 + 1],
>>                              S390_FEAT_TYPE_KM, fc, mod);
>>           break;
>> +    case 0x1a: /* CPACF_KM_PAES_128 */
>> +    case 0x1b: /* CPACF_KM_PAES_192 */
>> +    case 0x1c: /* CPACF_KM_PAES_256 */
> 
> please order these correctly in the switch. For the switch statement
> it doesn't matter but it improves readability. 0x1a is greater than
> 0x34.
> 

I don't get this. The switch is ordered by increasing value. What do you 
mean here ?

>> +        rc = cpacf_paes_ecb(env, mmu_idx, ra, env->regs[1],
>> +                            &env->regs[r1], &env->regs[r2], 
>> &env->regs[r2 + 1],
>> +                            S390_FEAT_TYPE_KM, fc, mod);
>> +        break;
>>       case 0x32: /* CPACF_KM_XTS_128 */
>>       case 0x34: /* CPACF_KM_XTS_256 */
>>           rc = cpacf_aes_xts(env, mmu_idx, ra, env->regs[1],

Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3D73D6467;
	Fri, 24 Apr 2026 20:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777061405; cv=none; b=vBzNtcB6E/koTfGi/dd13H77o9SDInPT+ENsYz/tr6VOKMS4Oh85VbvoQhspL+wAHthm5Ku1/024eJQpNpzVPkmI4B1ElwRSMxLb58NYm1QMSOHXkHWfC225WNHKF5qfmgfN4z6xrXdHSq5WFogf6uB+qG75woDG4ZHH/Lz1NFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777061405; c=relaxed/simple;
	bh=F3cwnQW7D8LiYH503XHMJ8Kj9/V/I6VXEal3wlm+ghQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3vIA8Z47nOZvSSr/C+JdhRhtJ+TSDcx7aC25abzQRdPte79GokcHvP/LkAUBiyQgSy+UvKBjLMgkaiAt+5kPt+u5sEKRRo4J+R1Rojcy9djOWkERemQttbXcE6SbseeIdmBPPDTq+Zdd7QI7lkFtrKxC9Rf+liobikoqsQ4sJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rd19fhga; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rd19fhga"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63OCUNhW3944372;
	Fri, 24 Apr 2026 20:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=I33drf
	efZQmVD9JtJ615KdZVWbQq/SGPrNVO/WQDP5s=; b=rd19fhgadBZe3GbjblFu1o
	+OqoMOohqgUkMqL4lBAZCqaXKfVvkE9TziLTJRXOIdxdp0u4Z2odL4VtC8/9xwvk
	SifR+Xzn5/6C6/NRQ4K2Hl5Klr7m9bYDgdLIOnrwx69OjugGZ7NVv/8bgSqsN8Jm
	6WyGyAk3V7e08o0IoXx1BqbrFwo2T9HUNfeEz0IPPteGxcXZsFtyxHN2/yoI7Va9
	3cAplEtw60HoRfSbU5/mQUkJrXydLD3ViK6HddUZ7E7INAzI0SvfkgfX7zBHn2uM
	ZxgW6Uk7EQgmFaZnNV2EbQkUS8YUa8z9fjUGuE2EveLmUoO7bZ91nz3mGR75l4jg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3xpp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 20:09:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63OK5RRe012637;
	Fri, 24 Apr 2026 20:09:55 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkymbu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 20:09:55 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63OK9s8O24707786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 20:09:54 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4961958055;
	Fri, 24 Apr 2026 20:09:54 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD1AB5804B;
	Fri, 24 Apr 2026 20:09:52 +0000 (GMT)
Received: from [9.61.79.186] (unknown [9.61.79.186])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Apr 2026 20:09:52 +0000 (GMT)
Message-ID: <1acdd73d-2b30-4d92-af83-1d5d1ec34c7d@linux.ibm.com>
Date: Fri, 24 Apr 2026 16:09:52 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: s390: pci: Fix aisb calculation
To: Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, borntraeger@linux.ibm.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260424193900.940816-1-mjrosato@linux.ibm.com>
 <d0765cdf0f3832c3fd92af53d2a4060d2d018439.camel@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <d0765cdf0f3832c3fd92af53d2a4060d2d018439.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JKP1uo35xPvVuPs2fK03h189BQbAZj6E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE5MyBTYWx0ZWRfXy3klnv0oJ8Hy
 mhgw9HtJA/UOD8HVZy9+LsswztAkxPgRNaIKlgNZuMzHjrSAvPMIjdGTsP4AFwrIWWCXtf5SYC2
 Eo3IX1r7YOe/QwxlGX9cxdNe0VsFqExu26KPQIoGP1wqyp9LHAEKiC0MCMSq48YJB56z2vD7x5N
 g2SL6K9ZQyMkD+FBPR/pa13pM87ZoOEUQrKzu5lCkyM22DDTUgFJ70A6eFObILraanEvZdN8Pp1
 980he99Q5fJo0PTwrSkJsvEcYeNdaKHgBl0W+g9pYwScfKRFfKGKXeDEqqsqNZYlWiT9eSFQ4Ut
 Ug8DA7iGaaUf3FPsilE7qMYVQDfgWIQQuszPzbvE7Z+8lqUrgiVj213LqtJVw+l1JbrhVsh2tmX
 q4ivb/GLQBEiUI9eJnzTJHC7yWPmWrjt4qBVU4ufft23bOQE6DLkS18y9EsRJzsPvFsBZzyA1QF
 5Kh5kUK5BfTQ21k0ilw==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69ebce14 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=AC7riLsFB4pJyvA54YkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JKP1uo35xPvVuPs2fK03h189BQbAZj6E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240193

On 4/24/26 3:55 PM, Niklas Schnelle wrote:
> On Fri, 2026-04-24 at 15:39 -0400, Matthew Rosato wrote:
>> The current implementation of aisb calculation will erroneously index
>> via an unsigned long * as well as multiply by 8B for every 64-bits in
>> the offset; only one or the other is required.  This throws off aisb
>> calculations once the number of devices exceeds 64, and can result
>> in out-of-bounds access as well as failure to indicate summary bits
>> associated with those devices in guests.
>>
>> Fix this by converting to a physical address before applying the
>> offset, as is already done in arch/s390/pci/pci_irq.c.
>>
>> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>  arch/s390/kvm/pci.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
>> index 86d93e8dddae..338171f9371b 100644
>> --- a/arch/s390/kvm/pci.c
>> +++ b/arch/s390/kvm/pci.c
>> @@ -166,7 +166,7 @@ static int kvm_zpci_set_airq(struct zpci_dev *zdev)
>>  	fib.fmt0.noi = airq_iv_end(zdev->aibv);
>>  	fib.fmt0.aibv = virt_to_phys(zdev->aibv->vector);
>>  	fib.fmt0.aibvo = 0;
>> -	fib.fmt0.aisb = virt_to_phys(aift->sbv->vector + (zdev->aisb / 64) * 8);
>> +	fib.fmt0.aisb = virt_to_phys(aift->sbv->vector) + (zdev->aisb / 64) * 8;
> 
> As you state, one or the other would work, wouldn't it be easy to read
> like below:
> 
>          fib.fmt0.aisb = virt_to_phys(aift->sbv->vector + (zdev->aisb / 64));

My rationale was to match exactly what zpci_set_airq() in
arch/s390/pci/pci_irq.c is doing (I tested that code at the same time to
ensure it produced the expected result as a comparison to the code
changed by this patch).

I'd rather all 3 places stay the same unless you have a strong opinion
on it.  I think the reason they ended up different in the first place is
because this code and the pci_irq.c code were updated independently for
V!=R.

> 
>>  	fib.fmt0.aisbo = zdev->aisb & 63;
>>  	fib.gd = zdev->gisa;
>>  
>> @@ -309,7 +309,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>>  
>>  	/* Update guest FIB for re-issue */
>>  	fib->fmt0.aisbo = zdev->aisb & 63;
>> -	fib->fmt0.aisb = virt_to_phys(aift->sbv->vector + (zdev->aisb / 64) * 8);
>> +	fib->fmt0.aisb = virt_to_phys(aift->sbv->vector) + (zdev->aisb / 64) * 8;
> 
> Same argument as above.
> 
>>  	fib->fmt0.isc = gisc;
>>  
>>  	/* Save some guest fib values in the host for later use */
> 
> Ouch, good catch! Was this kind of a follow up to the issue someone
> found upstream with a wrong calculation in the gait? Or did you just
> notice things break with more than 64 devices?

A follow-up of sorts.  Sashiko gave various outputs to that gait patch
that were unrelated to it; I'm looking into those things and it led me
to at least this issue which I did verify is a real bug.

Thanks,
Matt


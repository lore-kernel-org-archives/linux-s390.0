Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C37932AAB2;
	Wed,  1 Apr 2026 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055042; cv=none; b=r7hyo8O5+Ei//vszKv3vcAtLe2I+cOD7ltX1jxaGgavnfmmZ40lV9NxlrFniUo58XklCdIpFuAuaFGCyuPyzZfOF6jnHGQeA8l0ARbkoMeSyagzvuEe8OvLsTBzlguhacXoOnJY1UJTSqwQD9gT/m/d1A+dKYNvO9Rp/nVrfPaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055042; c=relaxed/simple;
	bh=42j/rXFWYTWigblZmdaAlvQQHg/NsDReCMHaCWDyLdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKlwIarlw18AtIR965lc8p/emm5YfTPUI3oxxvNQRTTMmOKOyHF6L9Dd4MN28ZX8c3ow1XxnklCCow89ytz3+yqCczwac5IWMpy1inbAnroNUPZuUZ/lZ48K46/HQGazGnVFPmTpyHwi8IEX0l2Dj+LzMUlJVNdePktG0sN/Nq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SPE7h3Sr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SPE7h3Sr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631BbE844019302;
	Wed, 1 Apr 2026 14:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MMBuOi
	GExGo9XVQyG+qprS7rpH8L7Cgj1MLPDxpdx7I=; b=SPE7h3SrgBnS45Shw0OGM8
	BqrsuPoMhtTukH3BDYcNABCjvDIbfh1ummmnIWbvf8NwpAN1tQXEVSkag+kLOuwl
	neFU1PhSIJJ2eFhHRYU3vfNcz2XMlYH1z/GlYUnx20nsXIhPFWCk5yh7n3SvAiel
	B/sLTlvMnU7fXzaQ75MQc2kW/tOZb8Ahdt46F2p9TXOaluq1H9VxnSvH9GakCMDL
	l6QaeChSvS1RyTg5HYsZe7Ddqa9cNe0MbZEUVXFF4aRpzAZY9K3zOSc3F/P8ZfDx
	0imqUpdDAHg5m6Q6jWqHvdgSHlvODGA0rnqT236xzHXteBqgxTOar5fmLMwl6gTw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcg0mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 14:50:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631CO9Hb013922;
	Wed, 1 Apr 2026 14:50:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttknygb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 14:50:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631EoR2u47448360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 14:50:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBD2320043;
	Wed,  1 Apr 2026 14:50:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62D2120040;
	Wed,  1 Apr 2026 14:50:27 +0000 (GMT)
Received: from [9.111.57.22] (unknown [9.111.57.22])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 14:50:27 +0000 (GMT)
Message-ID: <e9172a57-4125-41e1-aea9-0feaa5ff6eaf@linux.ibm.com>
Date: Wed, 1 Apr 2026 16:50:27 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] KVM: s390: vsie: Disable some bits when in ESA
 mode
To: Eric Farman <farman@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20260401020915.1339228-1-farman@linux.ibm.com>
 <20260401020915.1339228-3-farman@linux.ibm.com>
 <91feaccb-9d28-4519-8e89-43f75e88b8bd@linux.ibm.com>
 <ca84cb51f1d4f6520012ef2e2df475a5d2a344f2.camel@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <ca84cb51f1d4f6520012ef2e2df475a5d2a344f2.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cd30b8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=bbUTgpqrEuBwE8QX_m4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0GEZgkY25yg_BUVfxDpBy0a_oNIrIv4y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEzOCBTYWx0ZWRfXwlgNFMMMb70e
 erBQVC+CxgXBfL1EotMZptRnjy6Q0RCJflMdRlsFEG6hMRbXcnj7qSgRab7zwUJc5PitEmR3qfi
 KQ6R0KOhZ8lzLJbXswLeC5nOxxu/T2MQp0Y86ykU3rJVSZ7pzZ0nH2kd7+Flc+At62LYVraeyi7
 X5qhiF6vZRF/Yrx5kK2NkSW2WBHbb/+6/amcPzhyZHTD4QBkxFhma+Q2/zWQFEOf5gCeT++TE9u
 92pkOFzbC4bVp19vzSft+xSB7t99CO9VR9wPS5U73rPEagbmPwlnf5gWE438LCqmGVRmCtMQBlK
 Plcd5ftz2Wp562xcveRKuVB6v+uzMglPvpg9KbGLc9jyRyk49P9yCferbPQWM44jmmKeZouN2Si
 yS2N3JFxThyUNqGT+fGI9MZWmPttmo7xUCIXYftbCwKRfCqXF9d0Nm9XueLnhNbsvaGoNuknKjI
 lQMWcUgrt2tzYrooGBg==
X-Proofpoint-ORIG-GUID: 0GEZgkY25yg_BUVfxDpBy0a_oNIrIv4y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010138

On 4/1/26 15:46, Eric Farman wrote:
> On Wed, 2026-04-01 at 14:58 +0200, Christian Borntraeger wrote:
>>
>> Am 01.04.26 um 04:09 schrieb Eric Farman:
>>> In the event that a nested guest is put in ESA mode,
>>> ensure that some bits are scrubbed from the shadow SCB.
>>>
>>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>>
>> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>> apart from one thing below
>>
>>> ---
>>>    arch/s390/kvm/vsie.c | 14 ++++++++++++++
>>>    1 file changed, 14 insertions(+)
>>>
>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>> index 888370a02ef7..584fc7803632 100644
>>> --- a/arch/s390/kvm/vsie.c
>>> +++ b/arch/s390/kvm/vsie.c
>>> @@ -387,6 +387,17 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>    	return 0;
>>>    }
>>>    
>>> +static void shadow_esa(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>> +{
>>> +	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
>>> +
>>> +	/* Ensure these bits are indeed turned off */
>>> +	scb_s->eca &= ~ECA_VX;
>>> +	scb_s->ecb &= ~ECB_GS;
>>> +	scb_s->ecb3 &= ~ECB3_RI;
>>> +	scb_s->ecd &= ~ECD_HOSTREGMGMT;
>>
>> shouldnt we also remove the TE bit (transactional execution)?
> 
> Ahh, good point. Yeah, that should be removed.
> 
> @Janosch, I'll spin a quick v2 with this and the other nits, so you don't have to do the fixups.
> Just want to doublecheck this one.

Great, thanks

> 
>>
>>> +}
>>> +
>>>    /* shadow (round up/down) the ibc to avoid validity icpt */
>>>    static void prepare_ibc(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>    {
>>> @@ -590,6 +601,9 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>    	scb_s->hpid = HPID_VSIE;
>>>    	scb_s->cpnc = scb_o->cpnc;
>>>    
>>> +	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_ZARCH))
>>> +		shadow_esa(vcpu, vsie_page);
>>> +
>>>    	prepare_ibc(vcpu, vsie_page);
>>>    	rc = shadow_crycb(vcpu, vsie_page);
>>>    out:


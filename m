Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681986;
	b=Y7c/4k3oAk23Evr+oBNPFuD+Kn9KLNbxgGh7TXjMhBewqjcaGa7V6zaVxjKVgV+Z9ooj
	 ThiKM3aPa2YD6RAI5VhvkzRfe3lJ8ObvdpCw68EOLl7+I9kDJ0zDFpkjnG9JuUv5pSQ6n
	 ACCyQEhHBSPRpariMlsXFMqNDCkF7VMmw6UoKycKxwnbrRSmngzUOWMHFDmIxlWaQZWiQ
	 x5TjELizpXhJTsGo2CqQdHPWmaTFRrYTsTzv1uGIhMkX8fsxO6Gie8I5i9GzIZGrOrVcF
	 Xa8q+kwmSOlSuVRm36gB7+OUqrcj0/F1pYsQFXTRV4KmdKKi3np6S4ruw65LCTf52Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681986;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=V0IooT5qWpGyP7hAnTF6L8O/w819f9flfoXR0yPvf6s=;
	b=jQqu5KcF8ifh+E+KFdv+ndohdgHHe0E8AuX/zQsyB3hpMCAqJG8dqjb4GEyjIDp80fnA
	 ANWT46qj+V1SiS0I3irUQRA1CiWNjGh1+B0WvKVXwMbId7QnVck/Aa+RrfRCV9ZR0ecOG
	 4pWumIqFVPu/kPp1Hw6jDbF1WP+cPf8upaeWxfwlH2civfvWXFZ/P6tgOJU6Rd4I97q3s
	 vjVh5/LKO5rYCj3WS5rwF4V3SCls+Vii8EmDYs87u3Ow7GUNoG1hupruFBrDPdc2dk0P/
	 ybx89sPUeuRHY5ycrGpZ7MogycASXeQIkunosqhijyh9jZqL6E1IgcOGONT3rDXMN7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=REoRW2de;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91899606A329;
	Thu, 26 Nov 2026 08:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91899606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=REoRW2de
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7ZCDU2082790;
	Thu, 26 Nov 2026 08:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=V0IooT
	5qWpGyP7hAnTF6L8O/w819f9flfoXR0yPvf6s=; b=REoRW2de76UymswdBB/i5T
	VTBx5XzvQ+hIIlxfVlRUkVmcOqEhjaMJQvnYpPlPr7oVVfGRy/wJ0Cmwn8cywoR8
	8T+cx4S8UHbbrYM6sUCMHAsRgl1lawMXcLf/E6EK5/EQlaeoPhfV1xgkDHValRnG
	Z3LGcj5KjyhnkHREsiH4Eb2sfv//Saxd3sLww5mGF7LlcJUojA7Kgpq4ZJQiHPU2
	KSLqe9Joz7R0kWiZY7l1XKRhq7URPkZqOc4/epD8+aX9U9rQgzKhYs7/ZyPlGjkw
	4NfLXp/K+Nv9RkreIiFwgVKz6DItX4ywo+7vqJazfTBy93kLcO3b3Ps1bwLveVPg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3ger2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 08:32:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7JFWC1900396;
	Thu, 26 Nov 2026 08:32:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5axky80v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 08:32:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AQ8WgZA43254128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 08:32:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 188E72004B;
	Thu, 26 Nov 2026 08:32:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4CDA20043;
	Thu, 26 Nov 2026 08:32:41 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Nov 2026 08:32:41 +0000 (GMT)
Message-ID: <de93466c-42fc-4f1a-a69c-6e29809a2494@linux.ibm.com>
Date: Thu, 26 Nov 2026 09:32:41 +0100
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
Subject: Re: [PATCH v2 1/2] KVM: s390: vsie: Rewind the PSW of ESA mode guests
 in the right format
To: Yvan Janssens <yvanj@cyber.gent>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, Eric Farman <farman@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261125165604.3074595-1-yvanj@cyber.gent>
 <20261125165604.3074595-2-yvanj@cyber.gent>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261125165604.3074595-2-yvanj@cyber.gent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b07eeaf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=l9r1cnm4-fEY1RtK:21 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=7QR1kp5T8qIJlEpKUbQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzMSBTYWx0ZWRfX6was81MEIPux
 s4ZAJ1gR4C/Tn62Cm8Y/SFdLiZ+EOa6SDDPPLQR+r2jlF/47CWyEzVxWDo5QJgxLHz2htA5GEz0
 +uCoDT+25tWGTLSfNvejR8bepFdqyBg=
X-Proofpoint-ORIG-GUID: 1a-1-zTuUDZK3zmbCf9b5BHK5mSmEOC4
X-Proofpoint-GUID: jVIROOhjmLH4IZd3t2habS1fzUEvFNdg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzMSBTYWx0ZWRfX25kJiCUFDFow
 ANPoy+r2UlBMXPk7rBcdjDzmNebkBrbyMphuRsF5Av7wJ4wVWCCd+WQ6oNzcWM8btG9JmlpHs0z
 edIbvsvg0xKfPsVhxE8sxADV+A67zJDnPF3BeO8DJNvUBbA2mECpEgdEkxj7o19+08w7AqSEIBs
 vjr9Mpf+w8VwKrY5Obo/bg96vJcyouQZ2RE/LbnLpTvUg9Sq7bSLP50lnts5IYcz1shgDJ4481i
 3zhi3/Ra9aCSX0zAcDweriAMItDSOSQsjqpDo3XRp3asogQQdB3IkRhD9tRUg73L4O3WkztloL+
 pPoWadf7E6ZtTg6vLv8zW639rg/qtWVPSagEzNmEdrfn7v6miK8E2mnAENQxOr4GM+d32mBqbT3
 qLxC0WRmI551YVd212/gek0GosC5YYRglZ+9xOQWxeYeceb+k4UleRlrrfkA8hFlF3nxJCjhJIX
 6UgiPldveZkIMV1b28g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260031

Am 25.11.26 um 17:56 schrieb Yvan Janssens:
> ESA-mode guests in vsie have existed since commit b0ad874d9852 ("KVM:
> s390: vsie: Allow non-zarch guests"); they use the 8-byte short PSW -
> the mask and instruction address share one doubleword.
> 
> vsie's PSW rewind originally still changed the second doubleword, which
> is unused in ESA mode, so the instruction is skipped instead of
> repeated. The visible effect is that the first STFLE after entering SIE
> does nothing in a nested guest.

There might be other cases as well that we skip. So when applying maybe
replace "The visible" with "One visible"

> 
> This patch adds a vsie-specific rewind function that handles both
> formats; no short-PSW type is introduced - for ESA guests mask and
> address are written into the mask field.
> 
> Fixes: b0ad874d9852 ("KVM: s390: vsie: Allow non-zarch guests")
> Cc: stable@vger.kernel.org # 7.1+
> Signed-off-by: Yvan Janssens <yvanj@cyber.gent>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>


> ---
>   arch/s390/kvm/s390/vsie.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index 3ce133f20fa2..ed40d40d89e4 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c
> @@ -948,6 +948,20 @@ static inline void clear_vsie_icpt(struct vsie_page *vsie_page)
>   	vsie_page->scb_s.icptcode = 0;
>   }
>   
> +static void vsie_rewind_psw(struct kvm_s390_sie_block *scb, int ilen)
> +{
> +	u64 addr_mask;
> +
> +	if (atomic_read(&scb->cpuflags) & CPUSTAT_ZARCH) {
> +		scb->gpsw.addr = __rewind_psw(scb->gpsw, ilen);
> +		return;
> +	}
> +	/* ESA short PSW: mask and address both live in gpsw.mask */
> +	addr_mask = scb->gpsw.mask & PSW32_ADDR_AMODE ? PSW32_ADDR_INSN : 0x00ffffffUL;
> +	scb->gpsw.mask = (scb->gpsw.mask & ~PSW32_ADDR_INSN) |
> +			 ((scb->gpsw.mask - ilen) & addr_mask);
> +}
> +
>   /* rewind the psw and clear the vsie icpt, so we can retry execution */
>   static void retry_vsie_icpt(struct vsie_page *vsie_page)
>   {
> @@ -960,7 +974,7 @@ static void retry_vsie_icpt(struct vsie_page *vsie_page)
>   		if (!ilen)
>   			ilen = 4;
>   	}
> -	scb_s->gpsw.addr = __rewind_psw(scb_s->gpsw, ilen);
> +	vsie_rewind_psw(scb_s, ilen);
>   	clear_vsie_icpt(vsie_page);
>   }
>   
> @@ -1413,7 +1427,7 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>   		scb_s->icptcode = ICPT_PROGI;
>   		scb_s->iprcc = PGM_ADDRESSING;
>   		scb_s->pgmilc = 4;
> -		scb_s->gpsw.addr = __rewind_psw(scb_s->gpsw, 4);
> +		vsie_rewind_psw(scb_s, 4);
>   		rc = 1;
>   	}
>   	return rc;


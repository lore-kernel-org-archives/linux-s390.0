Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623599;
	b=HWMz7+7ax9F64GA7GtzHXREZmev5FxY86wlSALpIQ60R9d0AKeT2BaNvz4gMXzghHS5m
	 9zxJSR25p3/6nibl2IS/Fy6M2qVom0G0R5Y1glhoHzFI+SHvAZYrJ2vbj3QTxnRFBRyUW
	 JynzZr2MxMIAn/sxkTxIdccyBmFo/UNt1hSyTZPHZhjhAp/LMCX6X/R0afe4udRWGbyp9
	 lb0xpKHqHeS0r7/ObmkkARH4BGBZ9KXS9NmUqmE5W0HzdFW+mYkKqMaEXxuopkBvmGiod
	 zzkiw1UgfI60BUT2+89Ugp+gGZwC7g37KMCR8X1QbOwNQWNOdxYmAieiN3tfdHgr4cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623599;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=t+dEuT9uDjbOW6oQnlCgKgn7HvHu9U+cq9CuBbInj+U=;
	b=NVl/MKC/+HclmeZsKpQWLFRpJH0BeQPUsPXVgOXnnYorXGdZcA63XjiyX7MLJR0bFY3i
	 V7gzD/VhhY1Ez1BSuuHw/3dMbQdghN6qq4RG9mEOOSSK0NZuX9Iv/G9AQybcCwWgr50G4
	 j4HM5TeVd0iKC1WD+hW7ZggarxHhAF2r4vay/9r0Roah0NOIQAjOcCwDn3SY5yfQPozoT
	 zfsxeF5t216g0dGKZNgyUJSnRzKkPtDx0smhls1GKZQ/vQehLgobuolaUxb9Atxynt9Ng
	 P4ib/Wj0Lfs25PdudVw/oAAnrxdDHV6ZR+Fl2r5gROPtfUlS+VduLKhhSUp6UXQKdzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aAaZjvt6;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C98606A31E;
	Wed, 25 Nov 2026 16:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43C98606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aAaZjvt6
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEYdT3340963;
	Wed, 25 Nov 2026 16:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=t+dEuT
	9uDjbOW6oQnlCgKgn7HvHu9U+cq9CuBbInj+U=; b=aAaZjvt63oq2cWrElrupZO
	/l9ahK2OKFkZDwdD9PwQWEn0aaL6h7CmxDuhhjRaIG27PVobx0Bh6QdCvMYHM1aO
	91qIg1s+Fi7KvCC3xdwYcVunIQfHDx+JpXaFTEKnfS7Il9iYHxBHIJmQeo3A4F4W
	axV3kioeVnmdiO1rIvKpzo5NlawyLPJnA9pIvQ7uPQBVyxpEVqo5anuVhFOyYdF5
	Bk+g2JC7V0DmH2mq+72eY40R67NNRsPaULzPDh1wiADB3UHPk9+MAbZ9ImL1ny6F
	xV0H7sR5J26ZKOkbhpud6Gj2blfvX9YdERGd+bt59IxtmAxbERIJmBuo6uuksmpA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4mpqs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 16:19:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEKHFx810361;
	Wed, 25 Nov 2026 16:19:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5axkvgvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 16:19:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APGJaAn28705288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 16:19:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 186CB20043;
	Wed, 25 Nov 2026 16:19:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF40220040;
	Wed, 25 Nov 2026 16:19:35 +0000 (GMT)
Received: from [9.68.23.45] (unknown [9.68.23.45])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 16:19:35 +0000 (GMT)
Message-ID: <f64f9cd9-e2c9-4821-9d37-6c6ecdcb5239@linux.ibm.com>
Date: Wed, 25 Nov 2026 17:19:35 +0100
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
Subject: Re: [PATCH 1/2] KVM: s390: vsie: Rewind the PSW of ESA mode guests in
 the right format
To: Yvan Janssens <yvanj@cyber.gent>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
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
References: <20261125151607.3039477-1-yvanj@cyber.gent>
 <20261125151607.3039477-2-yvanj@cyber.gent>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20261125151607.3039477-2-yvanj@cyber.gent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2NCBTYWx0ZWRfX4x0x9S96nZSu
 8ealpEUtlaMd9tGVAwBzUyijjg9LseZiE11L/ohm7OTIUjkxBsQweFRBipXh7H29O72Y53SIJQA
 RGHbRjJTgXOQY2fr/f0JDwY1KwRVjfI=
X-Proofpoint-GUID: ZYlzTMNY9wbnNXqqRqrPHJnjOo7okSBG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2NCBTYWx0ZWRfX6/ISt0j3Pm3y
 dUGp8T6iCLagWMsPJD0MRUODEUKuBNVM6HaCtnJ9ppwIJF3OJ6R3RkNUYUvxySMEQ8u7jfbVSf6
 WdUeY7+4XGlILVTl8qoHg4IaBhW8exfY79WmHZvkUVZmUte99s8mEzFKwp1Jdlle2HTEbNTHRKe
 pxVMWjj1DKUz5cs1G3zjomPhylaMo4tTfAXA+1A74IzlFZix/DhJ0sZHQqoB92P9tEAkbrEWWhh
 Go3+fBEYKwEVN9E2IP08TXv2J4YDIh4l21+QuQascn6UhiNUdmzl+MbBM9pdfqccTyG6r56bi9P
 axxvwjn6wd0QM5Lx4EkunaePmsbkD7JBwYUvTQmPzZJh9Spdm0lQko2F+83ZDLwnhaWWltP1l66
 vqbxOeWv7qE0dqnRuGjm6lSBx/pANdfh2nctjxfXUPY+9Dv7rCI/RyID7aBxvkpBAg0SJcnMXlI
 xy+LKJY5NqapwvFWFlQ==
X-Proofpoint-ORIG-GUID: V3XdeLNEddL4_so8KpzLefe2N8w5HzFl
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b070a9d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=l9r1cnm4-fEY1RtK:21 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=VwQbUJbxAAAA:8 a=rvDQJkCU4pW1DR69TEEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250064

On 11/25/26 4:16 PM, Yvan Janssens wrote:
> A state description without the z/Architecture flag holds the eight-byte
> ESA/390 PSW in the first doubleword of its PSW field: the addressing mode
> is bit 32 and the instruction address is in bits 33-63 of that doubleword
> (Principles of Operation, "Program-Status Word" as it applies in the
> ESA/390-compatibility mode). The second doubleword is not part of the
> PSW.
> 
> Since nested guests can be run in ESA mode, vsie still rewinds the PSW of
> their shadow state description as if it were a z/Architecture PSW. It
> subtracts the instruction length from the second doubleword, which leaves
> the instruction address alone and stores a wrapped address there
> (0x7ffffffc for one four-byte instruction). The value is copied back into
> the state description of guest 2 when the shadow is released.
> 
> The rewind is how vsie repeats an instruction: STORE FACILITY LIST
> EXTENDED after the facility list that guest 2 designates has been
> shadowed (handle_stfle()), MOVE PAGE after a fault was resolved
> (vsie_handle_mvpg()), and the instruction that is reported with an
> addressing exception when guest 3 touches memory guest 2 does not have.
> For a guest in ESA mode the instruction is skipped instead. The first
> STORE FACILITY LIST EXTENDED after every entry into SIE returns with its
> operand and the condition code untouched, so a program in the nested
> guest that looks at the facility list sees zeros.
> 
> Rewind the instruction address where the format of the state description
> has it.
> 
> The selftest in the next patch reproduces the problem: on 7.3.6 the
> second doubleword of the PSW field comes back as 0x7ffffff8 after two

I'm wondering if we should only copy the a DWORD back to the guest for 
the PSW in ESA mode and not the long PSW. On the other hand I'd like to 
have as little ESA accommodations in this code as possible. Sigh.

> skipped instructions and the nested guest never stores a facility list.

While I do appreciate documentation of what a patch changes and why it 
changes it, I don't like lengthy explanations of basic concepts.
Please take the time to write this yourself if it's not 100% trivial. 
This helps me to decide if you actually understood the changes that 
you're proposing. Especially when you change obscure stuff like this :)

I'd suggest something like:

Basic ESA mode support for vsie was introduced with b0ad874d9852.
Such guests use the 8 byte short PSW instead of the 16 byte zArch PSW.
This means that the mask and the address have to share the same DWORD.

Unfortunately the vsie code does not consider this when rewinding the 
PSW address in the shadow scb and manipulates the (unused) second DWORD 
instead of the first. This patch adds a vsie specific rewind function to 
address that.

Since vsie only provides basic ESA support I'm not adding a short PSW 
and we make do with writing mask and address into the same PSW mask field.




Code seems fine.

> 
> Fixes: b0ad874d9852 ("KVM: s390: vsie: Allow non-zarch guests")
> Cc: stable@vger.kernel.org # 7.1+
> Assisted-by: Claude:claude-fable-5-2
> Signed-off-by: Yvan Janssens <yvanj@cyber.gent>
> ---
>   arch/s390/kvm/s390/vsie.c | 23 +++++++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index 3ce133f20fa2..58afe913bff4 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c
> @@ -948,6 +948,25 @@ static inline void clear_vsie_icpt(struct vsie_page *vsie_page)
>   	vsie_page->scb_s.icptcode = 0;
>   }
>   
> +/*
> + * Rewind the PSW of a shadow scb. An ESA mode guest has the eight-byte
> + * ESA/390 PSW in the first doubleword of the PSW field: the addressing mode
> + * in bit 32 and the instruction address in bits 33-63. The second doubleword
> + * is not part of its PSW.
> + */

Please remove this comment it suffers from the same problem that the 
commit message has.

> +static void vsie_rewind_psw(struct kvm_s390_sie_block *scb, int ilen)
> +{
> +	u64 addr_mask;
> +
> +	if (atomic_read(&scb->cpuflags) & CPUSTAT_ZARCH) {
> +		scb->gpsw.addr = __rewind_psw(scb->gpsw, ilen);
> +		return;
> +	}

Please add a short comment that this is for the esa short psw and that's 
why everything is written to the mask.

> +	addr_mask = scb->gpsw.mask & PSW32_ADDR_AMODE ? PSW32_ADDR_INSN : 0x00ffffffUL;
> +	scb->gpsw.mask = (scb->gpsw.mask & ~PSW32_ADDR_INSN) |
> +			 ((scb->gpsw.mask - ilen) & addr_mask);
> +}
> +
>   /* rewind the psw and clear the vsie icpt, so we can retry execution */
>   static void retry_vsie_icpt(struct vsie_page *vsie_page)
>   {
> @@ -960,7 +979,7 @@ static void retry_vsie_icpt(struct vsie_page *vsie_page)
>   		if (!ilen)
>   			ilen = 4;
>   	}
> -	scb_s->gpsw.addr = __rewind_psw(scb_s->gpsw, ilen);
> +	vsie_rewind_psw(scb_s, ilen);
>   	clear_vsie_icpt(vsie_page);
>   }
>   
> @@ -1413,7 +1432,7 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>   		scb_s->icptcode = ICPT_PROGI;
>   		scb_s->iprcc = PGM_ADDRESSING;
>   		scb_s->pgmilc = 4;
> -		scb_s->gpsw.addr = __rewind_psw(scb_s->gpsw, 4);
> +		vsie_rewind_psw(scb_s, 4);
>   		rc = 1;
>   	}
>   	return rc;


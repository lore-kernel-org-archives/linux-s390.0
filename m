Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C5A3264F5;
	Wed,  4 Mar 2026 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772655403; cv=none; b=DgxE8T7smqS578xaqr2rPMSrQ/yLYSBEbjwE5hUzQ4yK3IbdBFhww4bVdP8JxtFl/RMRHlw2shwPp7ZzjCaNJr4fe9ZJpPtCfvI0e90FXLw2dHk7P58nVu3J9LA0cXncrHhrf2eAiBXbBxHCpXI35+LXXwKaCAgnZV/mQlbbO0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772655403; c=relaxed/simple;
	bh=+iyspxPjL3O2RRORpAzvAAgl0083szT1PhZ+P5by7fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqQrF8G3ZdoWQxawyaUpISSCMKhkNxelqfWHG6QVAqasf7Ipg6nc1h79i38X883VC2rjofoJhE09+hDPZMM8kV9Wu7seJZp9rSU4zYFfe73HjnOQQH18X/ZAopp3rVwgjw0w2Rop+0gdK5yEbWs/CaW9Fl89cX6QHWKzHrr3mUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cm/09sD/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cm/09sD/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6249FQBM1517870;
	Wed, 4 Mar 2026 20:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tIzTUx
	K24q7XtMWqyR7WYtSMlNBaYETqv7k6Y3GNf1A=; b=cm/09sD/hdK943LsY1Qva9
	lOOLE41oROKsNZixTorNBAjxRYSFVE9nAuHKVpUN/siX059JKqDHGHLEM9SGYbOB
	5kukCp1KIWYfoAfv9AfnmGu98An/asi78eLZ1X+r6cuJNv6Ls4n1JESBRFL3NlFb
	V3yKke4cFBX7DR30bC5HF3gBbwdPw2AokJKZZ2KAXz9a6oM5Dpjrah8L19BC9oIf
	jpF7tIAck4wg35VDCNI3R+rU2o8SwGqmgyWtr3DFzENg2UN/GX+QzG30/pilvDCl
	CFv2ODe1q239o5xc7HX12aKTukjsSH2x6NdMmCr8Y4zpNn3PrSK/vsjVgcu+TLvw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskd1247-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 20:16:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 624I8RFR003284;
	Wed, 4 Mar 2026 20:16:40 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2y8d0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 20:16:40 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 624KGGll11272768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Mar 2026 20:16:16 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 822B158055;
	Wed,  4 Mar 2026 20:16:38 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1E2A5804B;
	Wed,  4 Mar 2026 20:16:37 +0000 (GMT)
Received: from [9.61.30.112] (unknown [9.61.30.112])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Mar 2026 20:16:37 +0000 (GMT)
Message-ID: <be334141-01d4-4398-b89f-09f84519f29d@linux.ibm.com>
Date: Wed, 4 Mar 2026 15:16:37 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] KVM: s390: Limit adapter indicator access to
 mapped page
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, freimuth@linux.ibm.com, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com
References: <20260303135250.3665-1-frankja@linux.ibm.com>
 <20260303135250.3665-2-frankja@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260303135250.3665-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1Qgm9wz8vZR2jaVxhkkAtYcdJFx_JbNe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE2NSBTYWx0ZWRfX6p4mzDL0eVtE
 37PUundSDYGCFtyK/Dai7UYZ++4gDBfVG55pDC9XL4Fdf5s0icpXHY/5heavYWr024dYqTjo4mF
 Xv9UuC24qxXhwe2lJEDIcrlXNJK8EcvU7b08beSfRiaFmajCYMfZpSG+KLW62N4+jWqPpHzGuFZ
 ngv3R9ZocQdnxtuOgbIcKNLE+H9WUPvYwLzrlwbAk8SGWhWaGlRcFUGol9HaXaNOVqh5/RRpM2Y
 MKbA/OJFKtBquAmqC3zs5S636JjFf7/EDaCNNBcvQk5/yNT2zEyAYwVwRGct0Yfq3HdSom34PAk
 WcKqQkWV8uo6pbKwxHNmtTfDsxAlwZCLGgOmz4mfOcog3eHWrZkNRras9jYQu8K1+s5+oSpviOF
 6VJ5d3XkNs2rJjgAX4Ex/nhWg9C61UvP+knBGrDxEiS1giQuydpyEupGU6Hw/akR/9CZFesfY9i
 28cU40UKEr4sR3lhRaQ==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69a89329 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=CMI0G6NvRWwute07TxkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1Qgm9wz8vZR2jaVxhkkAtYcdJFx_JbNe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040165

On 3/3/26 8:46 AM, Janosch Frank wrote:
> While we check the address for errors, we don't seem to check the bit
> offsets and since they are 32 and 64 bits a lot of memory can be
> reached indirectly via those offsets.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Fixes: 84223598778b ("KVM: s390: irq routing for adapter interrupts.")
> Suggested-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  arch/s390/kvm/interrupt.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 18932a65ca68..1a702e8ef574 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2724,6 +2724,9 @@ static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
>  
>  	bit = bit_nr + (addr % PAGE_SIZE) * 8;
>  
> +	/* kvm_set_routing_entry() should never allow this to happen */
> +	WARN_ON_ONCE(bit > (PAGE_SIZE * BITS_PER_BYTE - 1));
> +
>  	return swap ? (bit ^ (BITS_PER_LONG - 1)) : bit;
>  }
>  
> @@ -2852,6 +2855,7 @@ int kvm_set_routing_entry(struct kvm *kvm,
>  			  struct kvm_kernel_irq_routing_entry *e,
>  			  const struct kvm_irq_routing_entry *ue)
>  {
> +	const struct kvm_irq_routing_s390_adapter *adapter;
>  	u64 uaddr_s, uaddr_i;
>  	int idx;
>  
> @@ -2862,6 +2866,14 @@ int kvm_set_routing_entry(struct kvm *kvm,
>  			return -EINVAL;
>  		e->set = set_adapter_int;
>  
> +		adapter = &ue->u.adapter;
> +		if (adapter->summary_addr + (adapter->summary_offset / 8) >=
> +		    (adapter->summary_addr & PAGE_MASK) + PAGE_SIZE)
> +			return -EINVAL;
> +		if (adapter->ind_addr + (adapter->ind_offset / 8) >=
> +		    (adapter->ind_addr & PAGE_MASK) + PAGE_SIZE)
> +			return -EINVAL;
> +
>  		idx = srcu_read_lock(&kvm->srcu);
>  		uaddr_s = gpa_to_hva(kvm, ue->u.adapter.summary_addr);
>  		uaddr_i = gpa_to_hva(kvm, ue->u.adapter.ind_addr);


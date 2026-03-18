Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A573D7D89;
	Wed, 18 Mar 2026 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849862; cv=none; b=c+6KM5JeOu6PxiRKa6ZKUsYcb+ngFxO4HjDmvceaujwqzC+tgVj6KJUxdYc+7tFSzhu+waoX0i8ZJWno6zhzf85rnIGRog0i2KtsLNBktxZbO3yeFvgSqg5Lma0T6v5JcK/+GgxaoiytJgEgzBKOKagI9rPjvoR7t8rPO7/er+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849862; c=relaxed/simple;
	bh=o9b7VRRQYGxh61hzs+cLVzdeTONuQ3xfu1ylC+QzziE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YfkLM3LGx1GtwMR5VZzntPuqiWr17N4l1DvcOkuh2nIDevJNzfviW9Qx9p+W3GxZV1Br4+fkJN3T29pj+E+tAQn8RMlNnx8sjTiAoMvkDk/sN4vpOY0ojS6D3TSgki6TAT4Tv1tB/XCx+mOXOJDuZOGw+KstxxfhLWfdtIJ9K08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ngWL/Bvk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ngWL/Bvk"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IBUeAA711139;
	Wed, 18 Mar 2026 16:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jKr25v
	aovNjL1l8D8poYgHJAAIVpGKuHr/NZk2nYjdk=; b=ngWL/BvkP1YVhAT3A56Ve8
	0wokmPC9J+BBWfIcRsZo2lUB2CHgI3ap0hcKrSciW/q9wOHq3BtX0kvsdtxfBfrb
	lycMdYD3Cdg+qxtKUXs050rhsqoPfA1GoTwox9dhRAE2yXptWwz+OT7algQssvYX
	+54n3A81QDDfHeGigzgMCj+4ssHbUdk87SJY1PzJIYKyu9cdySsvu0NOKQAjQMpc
	ILmvS2bCfN3KItr0/7fiy4RaGMtpiVq+i4OxqUTaVF6e1eUon+NJ6dUZn2SQkGLx
	YKS4CdTEcFwfSKr0ya/iAwO4o1/d3dqXQpPpqfz3q8FGoo7wGDLCIq+TX15dtHlA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3d2718-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 16:04:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62IEj4GQ028496;
	Wed, 18 Mar 2026 16:04:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1ef9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 16:04:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62IG490w45678974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 16:04:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66B1220043;
	Wed, 18 Mar 2026 16:04:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 441132004E;
	Wed, 18 Mar 2026 16:04:09 +0000 (GMT)
Received: from p-imbrenda (unknown [9.52.223.175])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 18 Mar 2026 16:04:09 +0000 (GMT)
Date: Wed, 18 Mar 2026 17:04:06 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        akrowiak@linux.ibm.com
Subject: Re: [RFC 01/10] KVM: s390: diag258: Pass absolute address to
 kvm_is_gpa_in_memslot()
Message-ID: <20260318170406.56274c20@p-imbrenda>
In-Reply-To: <20260316180310.17765-2-frankja@linux.ibm.com>
References: <20260316180310.17765-1-frankja@linux.ibm.com>
	<20260316180310.17765-2-frankja@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69baccfe cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=hmbiDVwH1lKaQpimJPgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEzNCBTYWx0ZWRfX3/+iDdbsfxq9
 T56QLTSihjS+bjqEuUx156ZHjTUbT9xuUnIvV2gI+jyLqOqTjAOAteR+KGGEUbTldKxfTzQ4oOg
 6ZKHmjVSzyeilT7jXu2b7wfrKPbNaFpycX1tBrg5y72aHI1l2ZlQJK8nfuzsHB5qT6Y//ss6Fnk
 5a67YyNs5UdOairVrPtLPF8t6HEpac5BQHv4gTmaJKNa714uPfbAsTm/Nb04+R8xTZq/aAmdq74
 ziThSN/t/8KcCI7wJoyXbSuWZPm4yPI0QU1+rtRazCGppIiEOX7UFh/+5lFY5yKPY84AUZR6y90
 j7tYymLItIQXVVb82GWvOoGileiGohLSnAgdcJnti5p01vvPFJDYZbGfFHgjPHM/ouCMAqOe4iK
 oJeTEKYGHK70A4TNW8Edm1papkVEz8WY4XHjob8kmKk7vFPXnp59PCEy4wvHXamfoZUIzdSOvhK
 r8dqZah+OiKo/MUyKxQ==
X-Proofpoint-GUID: YLlZSoPKD4P61kD9uMJWo8K65ggdduPa
X-Proofpoint-ORIG-GUID: YLlZSoPKD4P61kD9uMJWo8K65ggdduPa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180134

On Mon, 16 Mar 2026 16:23:48 +0000
Janosch Frank <frankja@linux.ibm.com> wrote:

> The token address is a real address and as such we need to translate
> it before it's a true gpa.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Fixes: 3c038e6be0e29 ("KVM: async_pf: Async page fault support on s390")

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/kvm/diag.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
> index d89d1c381522..51ba4dcc3905 100644
> --- a/arch/s390/kvm/diag.c
> +++ b/arch/s390/kvm/diag.c
> @@ -122,7 +122,7 @@ static int __diag_page_ref_service(struct kvm_vcpu *vcpu)
>  		    parm.token_addr & 7 || parm.zarch != 0x8000000000000000ULL)
>  			return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
>  
> -		if (!kvm_is_gpa_in_memslot(vcpu->kvm, parm.token_addr))
> +		if (!kvm_is_gpa_in_memslot(vcpu->kvm, kvm_s390_real_to_abs(vcpu, parm.token_addr)))
>  			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
>  
>  		vcpu->arch.pfault_token = parm.token_addr;


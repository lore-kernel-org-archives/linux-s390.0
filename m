Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793779987;
	b=q/VmxkFbhxEPFq8v2GBoVw88oNunP6n0SabFehS/9bcHSOu/Zg4TGK7Sx4j5GhQZm7HW
	 5Vse5iBAyhyO/FGr/ZKKwokzJpMfvcqXQN8Ll6eO9KOGexxFbZ+UnjFA6HOJLJ5zThyaI
	 Yhdh/kR3T0QxyDg2BUUuNCMxw8HoZxM3j6Jo+I1o6DITeNchJ2LGkEtnbB7fWkMNxp2hs
	 ajCEyj81wF6wX/JeRXu085JbSVP7RJu2xgPaSC82jdM2IcRv89WzpWubr0clGFrRcpXGs
	 4QyHHenMpZMs8BZuiQmy/lWE9VXLVns3igMyrEjDaajsAXlp0XuU0wMuRTZrF4qu2OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779987;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=MAAONbLFFv6aSYl2s8jr/4VRt0DVnf2M9sQY30h8Jr8=;
	b=G37ExxLole4PPQxbO//xz+sxIlm+TUv9qpiFnXRKNEXB48/v0Ez5gh/YsNis0DUNahOO
	 hvx7UGYtdM/2yDyK/vago2sqbwq7L2xnoHPrQ9B0yskfeGZVT4CLZP2dT9p3AYqqzE7y0
	 ts8inBsS9l6ct0tJ5SMd/UneZnppUg4DUnzBYlhwoZqs4/z2nh0glQqloQbNlBC+huJbw
	 Bj7QkfloE32SzT87PVCihmdaJ489uBq6M+Zv1OivNBnPhzW4DFrzn8TcZtTFffnEp5kNL
	 ZurgnOO0E+TADzwGbsZdDVirVebT88dpxMHSvIPpPeq23eZ9SqiIcRymzHzon8wP1/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HUXwul5V;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D814606A31B;
	Wed,  4 Nov 2026 08:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D814606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HUXwul5V
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40j2CA3561532;
	Wed, 4 Nov 2026 08:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MAAONbLFFv6aSYl2s8jr/4VRt0DVnf
	2M9sQY30h8Jr8=; b=HUXwul5VbqQGiwkM6yOtnysZWhTPOLXSAlqWA3qQBARg1S
	KaZ+rxBpR2y4WDQmKwdSmm718cgyo1tMv6P+e6kZBrqIsd8R5yOylfa+BbdOT0F2
	HQzcVkkrZkEm4IcQMmFs6vNgfzTlgaNlkBvgCl8Tl6EIbiCD+XIa0FlbgZR4yTSA
	LljgG65HFUIcm49Pqt9UCvJzb9/8sXbMpy+SWtC2yFR+aOcPaRJouOezImbArn7E
	4pBwzZ69MPTsws5cgCnGT2HzBZ3w71lKwA/lUHMX8wuWcFQJJ7xElasGeSYt3soa
	NHnvIVQXwfqyn9VvvPuzd1cNeTKARxQ+Qbv8Sw+A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7u3jqa1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:13:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A45MScX2167360;
	Wed, 4 Nov 2026 08:13:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqsf59kef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:13:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A48Cx5e9961756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Nov 2026 08:12:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B03F62004B;
	Wed,  4 Nov 2026 08:12:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9099F20040;
	Wed,  4 Nov 2026 08:12:59 +0000 (GMT)
Received: from localhost (unknown [9.111.93.238])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Nov 2026 08:12:59 +0000 (GMT)
Date: Wed, 4 Nov 2026 09:12:59 +0100
From: Andreas Grapentin <gra@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] KVM: s390: arm64: Turn vcpu->arch.pause into a
 counter
Message-ID: <aurovf0ywffRX4z6@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
References: <20261103-s390_arm64_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com>
 <20261103-s390_arm64_kvm_fixups-v1-1-21c36fedd878@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-s390_arm64_kvm_fixups-v1-1-21c36fedd878@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6aeae910 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=lmcJkAaRRjC2wQrgi-sA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: w-_bEPiha6HAiSq2Astn33aQGzOvTxJv
X-Proofpoint-GUID: w-_bEPiha6HAiSq2Astn33aQGzOvTxJv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzMCBTYWx0ZWRfXzXlVoF1FlSXY
 gnN0kQ8hA1mjUMcftYX2/A1eCLyaLhCa/N968r6ChgLMnIadwuoY3zLE6PB6XDnDKYoHZmPcLH1
 0HKC1fz7s937zk34K4OD70c23o0FTrHvCcJYf78AqeDRuIDIp9KUvRuAPEslKUYP9+FY5MmXuBh
 Dt1JZUVJsAE92Vjw9JMIv0Sj7Hm/qjOkUzC1IajP+2DlUHWVD8wJ1PdtCoazWnNfffjj+3PjO9c
 7Yh8G/zgSADVn7P/RwRiUpqhzHnd9Rl4OiWK73z8ry7n7Z2/w7tflwmAHBq6PHlV/agXOJ3O21J
 IlY/vULPifaxS3tP7V6uv6hALs0Ur7F61S7T0y+iKgGWCflBKwzpleOgwBokKCgWM/Sf48zFyyg
 O5MnxdhgV4hgjwMyDCCxNAWUUvG+feHY4Chspm6BVHb4u3gprmNb5RcE9XYJys+nWArlq35vEZ3
 w3r+YI75bJ8OxEYr0pg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzMCBTYWx0ZWRfXwu2CBz9Rzphg
 AItga5ODDBB3JbStrrzG+wRHPmZ02unWMb001oMnnbKfGotvsMHv6qpu+XsSre0oChmkodjx7YU
 JWmaBIWqV+pcNY5QzoGIpebDJN6H/0s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040030

On Nov 03 26, Andreas Grapentin wrote:
> From: Steffen Eiden <seiden@linux.ibm.com>
> 
> The s390 arm64 vcpu struct mirrors arm64's kvm_vcpu_arch. When commit
> e64309198eda2 ("KVM: arm64: Turn vcpu->arch.pause into a counter")
> changed the type of kvm_vcpu_arch.pause from bool to atomic_t, the merge
> into this tree missed the s390 copy, leaving it out of sync.
> 
> Nothing on the s390 side accesses vcpu->arch.pause yet, so this has
> no functional effect. Align the type to keep the mirror identical to
> its arm64 counterpart.
> 
> Fixes: e6c329180d1d ("KVM: s390: arm64: Introduce host definitions")
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host_arm64.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
> index 82343e723ebf..a3e40650d75d 100644
> --- a/arch/s390/include/asm/kvm_host_arm64.h
> +++ b/arch/s390/include/asm/kvm_host_arm64.h
> @@ -63,11 +63,10 @@ struct kvm_vcpu_arch {
>  	/*
>  	 * Don't run the guest (internal implementation need).
>  	 *
> -	 * Contrary to the flags above, this is set/cleared outside of
> -	 * a vcpu context, and thus cannot be mixed with the flags
> -	 * themselves (or the flag accesses need to be made atomic).
> +	 * Contrary to the flags above, this is updated outside of
> +	 * a vcpu context, and thus cannot be mixed with the flags.
>  	 */
> -	bool pause;
> +	atomic_t pause;
>  
>  	/* vcpu power state */
>  	struct kvm_mp_state mp_state;
> 
> -- 
> 2.55.0
> 

Reviewed-by: Andreas Grapentin <gra@linux.ibm.com>

Best,
-A

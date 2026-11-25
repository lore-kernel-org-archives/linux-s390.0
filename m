Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608176;
	b=hlwY6x9mEPBToJtMLoeq0lGVH3sfcr/3PXc93fq6pReroIutcQ4/n7YTkrCEuVFH3j51
	 qakpi6Iq52etqvvZGllrwjMkmQslLDSAEW/yCoTuRxgkr/D/tY0zROfybzLpVqa27id3R
	 lmu2gNDcKm91SJDPIQHa99u2u37fTrPc2RhqpVAlrsgktwHyw6KAcY6s5kHgsLWLOLKrX
	 jVsEwT29s5v/xhgaVyspNd4aDXVQ6JQ4Gl37ezKNeB6FmTeuL96D6lQRMkPojgiEYyRUP
	 uG0w+Nk6nEP+E36JF/ElVP8jBcEJP/IrFTIrKH3lseRnl6L8kH6Y3ctS8goR6zp5I8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608176;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1/3s/ojeDiUUURTn0NikgHdXitYRVYHj2QGMfZR4toE=;
	b=NNoJf3m526doGDP7UMUEEnzN0jU1giY7dWuGFSf2yBb1NjOIDvvNJ0A28fa6JOcipS0W
	 +q07ZkiKyijUKALZn7Gm0La6Ntz1sbGc5KIFj3eLbxvWgMhHHPpRXE5cAOUZ2E1xhOSh9
	 6s8rI/rGlofQeYT+T1Ypyww0ZXaloeBbxtU+BDyZPeQDY0Bs4sy/qLoIX8aiAGm9eXL/1
	 p0nLCj1MYvSdC9acZQ7Px8mXT5h+ukbWnlrvdEkuF56Uou818X7FEk0L2yF/k6riY12Tz
	 /g0ZRJeEekdP49i426P5J76aX7Qqy4tCTxLG3boyjLdYPVJR6zp7GNJXA2AG9ihpFww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P8j89lUU;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F39F606A326;
	Wed, 25 Nov 2026 12:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F39F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P8j89lUU
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APA4fUQ3596895;
	Wed, 25 Nov 2026 12:02:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1/3s/o
	jeDiUUURTn0NikgHdXitYRVYHj2QGMfZR4toE=; b=P8j89lUUSn8o4YpG2k17Vg
	YGuMZb87xZLBGO9HLztCdYGOBq4+AQNmfunC/rybmK705AIlZTbKt54oije1zTx0
	8V97WnJNETjhapOYpcLhJcfOtYqLBXewBWucMBmQPk7pu4pOZQdACjTHWi/2Fhj+
	FBwYj/2cBv67DtywM0BO9lbuSG8ZDRicFGRcGaTRRtOAfDYE/72mgxUVnLbsFpWI
	bQz/EbeJwCUxWYOdT29CjxEtmUVO9yqA+C64ZLactXFi1qmvDbriRKehxGKGtZHJ
	OLUYrAnI1tClV7KAwBK5j/ktyjLVfAJ4jsCs2F8DrGjUhfisbjOU9Q9n5y2HVLmA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3cadb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 12:02:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9nFB5522008;
	Wed, 25 Nov 2026 12:02:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5axkusm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 12:02:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APC2fPM37486848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 12:02:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 673F22004B;
	Wed, 25 Nov 2026 12:02:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1680F20043;
	Wed, 25 Nov 2026 12:02:41 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 12:02:41 +0000 (GMT)
Message-ID: <1cd2d2c3-c026-4b98-b1d2-f0ded1bddfdd@linux.ibm.com>
Date: Wed, 25 Nov 2026 13:02:55 +0100
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
Subject: Re: [PATCH] KVM: s390: arm64: Stub kvm_vgic_put/load to prepare for
 kvm_vcpu_wfi
To: Andreas Grapentin <gra@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261125-kvm_vgic_stubs-v1-1-c53ca2c5959a@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261125-kvm_vgic_stubs-v1-1-c53ca2c5959a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b06ce66 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=useJOpUMA5kRy2FdWNcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0NiBTYWx0ZWRfX5972ehs9w9Bq
 fl7MmN3wcAV32Nhhx4f03HSdK2aUEt9p6D5wOHBSIjnSsGEiUkWrRVza8lKFc9LeXTzNce/Rl4x
 bNqYgsWLB93YS0iuDA773SbFa+32eEQ=
X-Proofpoint-ORIG-GUID: mGs8vkCsdXtfUfzPXvvNj9kNCC46_XFt
X-Proofpoint-GUID: mGs8vkCsdXtfUfzPXvvNj9kNCC46_XFt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0NiBTYWx0ZWRfX6nr8j0oQADRp
 iFQEc/8rsbN/eA+THkzZPp7WVC3/F1Akh2AjaLDcypS6rQgt5w6GzIRqIRPfMrW8hzD9DNDuFfW
 RLkqiysb+/ZC91CiPFRBaZwLZIYnbuVRs7h9zn9EVG6oVEM5UF02uFPfwSSU5J9enoeeOJMt0vn
 RTKOssR2vSLPf36l079F8KI/dNHA8TPRVoVIRcFoSOZGgnzJws7PudDnHAaYK/3FeyoXX4KadPi
 KljrWIXf5T6sYq/N5LDOqOQdPaqHqbbjjKpxdD+Wzqkf12oBhyji9eVAvOhAnNtBwtCauRPiYiv
 O4K6rRWdwREAFXT1kH049qbu9O2wql9JuZcoSJpIsb9wtTaMBEJYDOkymwtUZNRxbRjEVPwKsA/
 EC8KnZTOhOofUOuKmmz2eTrNfK3eDFSC+b5BBmM/+hXeDdAWgCZG2P8XgIR5xjhhHm1UI3q4bY8
 AXbxgXH4XECMte1z7Qw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250046



Am 25.11.26 um 11:12 schrieb Andreas Grapentin:
> In order to be able to share kvm_vcpu_wfi with arm, we need definitions
> for kvm_vgic_put and kvm_vgic_load. Add these as empty stubs now to
> reduce baggage in future series.
> 
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>

I will queue for kvms390/next.
Thanks.

> ---
>   arch/s390/kvm/arm64/arm.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/s390/kvm/arm64/arm.h b/arch/s390/kvm/arm64/arm.h
> index 760230685ca1..871fc853675d 100644
> --- a/arch/s390/kvm/arm64/arm.h
> +++ b/arch/s390/kvm/arm64/arm.h
> @@ -55,4 +55,15 @@ static __always_inline int kvm_s390_vm_stop_migration(struct kvm *kvm)
>   	return -EINVAL;
>   }
>   
> +/* temporary stubs */
> +static inline void kvm_vgic_put(struct kvm_vcpu *vcpu)
> +{
> +	/* Current state of the implementation: no in-kernel gic and no vhe -> noop */
> +}
> +
> +static inline void kvm_vgic_load(struct kvm_vcpu *vcpu)
> +{
> +	/* Current state of the implementation: no in-kernel gic and no vhe -> noop */
> +}
> +
>   #endif /* ARCH_S390_KVM_ARM64_H */
> 
> ---
> base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
> change-id: 20261125-kvm_vgic_stubs-e1a1eeb4a075
> 
> Best regards,


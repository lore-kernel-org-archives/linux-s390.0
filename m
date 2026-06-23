Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CB641C71;
	Tue, 23 Jun 2026 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207033; cv=none; b=Fg0ikTGy1UXrajzzXOyoKxLMFe26to1954WSsj95StV2gBf0Rct98e0UnXJjClezt21mnpBGqDGPAzp3JqNLrQXnB9G4VZhBDBglxqRg88P4xFAK8t9/WrMaXe5qzcze0IYYKJz9mMAhqAcRpmC3qDWE1C+Alp3upbiJtIXFpNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207033; c=relaxed/simple;
	bh=tHhLpzROOUIobSnTIVYKh0uFp37FGRkySQBRBvyabFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmlXbpKDWazrwoZEk8mC1GtWy0aL4lCYtVN1TJCANrVUZx18EkHLuhHo0xkLgPdoZXgMkMVBUh5uGrWGvRsOJAvc1kYMiNidHifwhAPRf+dVCxX0akmWYq1mtsCUpeeI0bybkieuxhCFTCfqHHerhRAxqMNa1cuigNCPwFJVg+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jEFsTtti; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jEFsTtti"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6mORE1148025;
	Tue, 23 Jun 2026 09:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZxsSo7
	nh4MMC/qTTYE43jvOabWRqBr8+7Y8inwBE6UY=; b=jEFsTttiHbZ60UyoHS/7wp
	dJIb2pAlsUp4Wi+LjxXV/J0lEeFH+J9v+7C8qKNlVabf5Ow0Hk+w0S50PTwhcFcn
	mMm14gb0buUuY+yx8AmHNMZarysl3kg/W1UlY67wVq4oZ+l3JhzwycpoSVEL4YC/
	Z3O3bJWiluFquOImF3phqQd6jIlk2jqqvkvrVx/2PcOZq8pzSYnZpaAg1d2Yt42F
	V6Af4PE/xoVTiEwkIy6nA2czGfPyHF8niqoelIS+cQkQPptvWOrPqY3dsjjhlUI3
	s/fdleVrHjTBW1VIw/paMXzFgS1FwJnBxx/4+Mnv0DKU3Mv5Mxe1rFB6c7PE57LA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4dq0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 09:30:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N9JrPX016363;
	Tue, 23 Jun 2026 09:30:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qaqhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 09:30:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65N9UOps45678934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 09:30:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEB142004D;
	Tue, 23 Jun 2026 09:30:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC36020043;
	Tue, 23 Jun 2026 09:30:24 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 09:30:24 +0000 (GMT)
Message-ID: <117d0a80-345f-43d0-9b8d-b86c12eafc05@de.ibm.com>
Date: Tue, 23 Jun 2026 11:30:24 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] KVM: s390: Return failure in case of failure in
 kvm_s390_set_cmma_bits()
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com, hca@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
References: <20260622160739.202044-1-imbrenda@linux.ibm.com>
 <20260622160739.202044-10-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260622160739.202044-10-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3NSBTYWx0ZWRfX/gYUJLjYviHo
 IDOXtLwyOItAaUyDGuYvluGlpErvv7dFWDfuYdoP2bM7S1yhwsTJfXEHhfp7T4YbZAcLMBelqRU
 MZy1C7SDwGT0BWlD9wOE78Eg69G/P3w=
X-Proofpoint-ORIG-GUID: E2F9fPS3mw-5K5V_QfxRScjRJOsWBolc
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3a5235 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=-B3mOUPiwokqgSWFVnUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3NSBTYWx0ZWRfX9HW/kuMY+kTi
 u/KFAa0Psc4tMtQTFMzSjypTzfBVdVKmJ5IZKpNxOXL8FjzPbMgIL7t/DW3iB5XkQxaRhuv7cc9
 iX2CXlbY+gs7wrGFZ30go70h4givgLvRyM8n1eHizVWvJpByGx0Mzdo8p9pdsd1vjpKZqe5OACu
 dBMdqHU2Tk3+SK4yg7PNvuEl5QXv6JcqKi9QqNce4PLK1FpYGAohLpisjQ+UCuBiRMhfydb7QQR
 oL0CyHxAUYN5pvGzmGYAHyy+Om8IG8PF+Y2sTJ9E3CVvQLP0sQCn/oXeAd0bjcR8qlykQGP4Yhz
 a8Spq0SGesZINVqDeLIehDDdqfWo53VmwX1nm36jXpfnq6iLeKIogvVnuCM9TRqlop6iV01TR/w
 RnostnZkRvme8ovoxNecs1ntrsdfynaYIH5S1Y+3N9MhFlYHxVCpfFYS6/WiAeRd//FKUlS5B+6
 Q34XyYkVFx1gWxmhCNQ==
X-Proofpoint-GUID: E2F9fPS3mw-5K5V_QfxRScjRJOsWBolc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230075



Am 22.06.26 um 18:07 schrieb Claudio Imbrenda:
> If the allocation of the bits array failed, kvm_s390_set_cmma_bits()
> would return 0 instead of an error code.
> 
> Rework the function to use the __free() macros and thus simplify the
> code flow; when the above mentioned allocation fails, simply return
> -ENOMEM.
> 
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>   arch/s390/kvm/kvm-s390.c | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index cdd8b41d24ed..27d6004132d2 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2282,8 +2282,8 @@ static int kvm_s390_get_cmma_bits(struct kvm *kvm,
>   static int kvm_s390_set_cmma_bits(struct kvm *kvm,
>   				  const struct kvm_s390_cmma_log *args)
>   {
> -	struct kvm_s390_mmu_cache *mc;
> -	u8 *bits = NULL;
> +	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
> +	u8 *bits __free(kvfree) = NULL;

why kvfree and not vfree?

>   	int r = 0;
>   
>   	if (!kvm->arch.use_cmma)
> @@ -2303,18 +2303,16 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
>   		return -ENOMEM;
>   	bits = vmalloc(array_size(sizeof(*bits), args->count));
>   	if (!bits)
> -		goto out;
> +		return -ENOMEM;
>   
>   	r = copy_from_user(bits, (void __user *)args->values, args->count);
> -	if (r) {
> -		r = -EFAULT;
> -		goto out;
> -	}
> +	if (r)
> +		return -EFAULT;
>   
>   	do {
>   		r = kvm_s390_mmu_cache_topup(mc);
>   		if (r)
> -			break;
> +			return r;
>   		scoped_guard(read_lock, &kvm->mmu_lock) {
>   			r = dat_set_cmma_bits(mc, kvm->arch.gmap->asce, args->start_gfn,
>   					      args->count, args->mask, bits);
> @@ -2322,9 +2320,7 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
>   	} while (r == -ENOMEM);
>   
>   	set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
> -out:
> -	kvm_s390_free_mmu_cache(mc);
> -	vfree(bits);
> +
>   	return r;
>   }
>   


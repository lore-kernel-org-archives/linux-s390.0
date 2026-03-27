Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11F531717C;
	Fri, 27 Mar 2026 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627173; cv=none; b=Zjdkecz4WZao3mYwG15MXTuT651snwliek2U1M2BxpQSCsME/sxI5DiD9+OBMhNViLkY7/Vs2NXsACFFzkcLvUMa7N3AqdVA+v5XBNyDoUctM++jWnayW0TTjoYF0QC0KR988FBk8d3NHZHDfrcyFDYeM4aRPp8cZIl/HAl9KQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627173; c=relaxed/simple;
	bh=i2IP8ThVTC0d6iGsnAfh+bdHE++71jXxYuQCTkSpJrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M7daCdw2pHNHK5Pud1pfCABzOTMeyBo+cDrLOJ2qCCt+WxDxMOhNc5aLTVhGDR+inW1O+Op1XFkvkMPqyRDY3GjLS/nc/UU+a6i8t1iJv6+++EEexxOsTfnMvwePpHd5pcy/6B/6yCTD1okJKYUiM9jmHdV7B6YPXuGv1HDSDbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o42M8tpN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o42M8tpN"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R64Tuw1013982;
	Fri, 27 Mar 2026 15:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fI6p/U
	E053vkrlBrmPd1/NoPIXU/AhwxEwsOE/A4N4E=; b=o42M8tpNJwIrNSeaqis5I1
	ozv+xiGzJ9iJx/tGytKuUwJ7FW60aqfxH7hYo5mczIYSiaPWHApvwYaB+HfYgv9Q
	PiF6RKstSdBz3EWFqYFcESN1sQ8miRdBbAoqPn9E4O5bp8v9ZrUrX+Cdo1NIxCcx
	zmFnpG/g+Xj2dmL5Yf/f72hqZGJgUJFUW15wbdZC6CTYnl+MshqiAF8ak+TEHO7E
	5Tz0/7RrJFJEa0LLqdnKb7ULEbzzjipS6/uL7QbamIVPS0jUHG2rvRnd56/Q91dD
	GL+Iahy2d8XOI0jJvRauqFQnwC/QZeu81gUkFhyoHdcjs92+sW08oua1puhWpi/w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqu1q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:59:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RF9mYR005964;
	Fri, 27 Mar 2026 15:59:28 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d262007jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:59:28 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62RFxRbA8192600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 15:59:27 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F102858057;
	Fri, 27 Mar 2026 15:59:26 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 162F158058;
	Fri, 27 Mar 2026 15:59:26 +0000 (GMT)
Received: from [9.61.87.139] (unknown [9.61.87.139])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 15:59:25 +0000 (GMT)
Message-ID: <a850f18a-635a-457a-98ac-8a51a6dcdb8b@linux.ibm.com>
Date: Fri, 27 Mar 2026 11:59:25 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic
 fast inject
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260326014247.2085-1-freimuth@linux.ibm.com>
 <20260326014247.2085-4-freimuth@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260326014247.2085-4-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: czk_SyF7Y2LMLI_JwUZbhP0nVLW1pPOM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwOSBTYWx0ZWRfX3T/KUckFRXJO
 RXTem8jQXdgfXUfDvljbDiG3zqLKu+Wla7Vs2eEm8o7yVxblFiAwsUbqsR1NdKRMr7RZB7xDg6P
 KzcpsA0VAueHHcomYx4M3ha55o/q3NG8iBtF0ganfSnh3VY/bfwnXkSxQdLzBi/4NGAW/jXqsgp
 znDu30bLZbAXTtmw3bR/vOpf/Kk+yT5a/JWKT8QriBop5tmLVTAHXH/87DcpF6QL2ajcQ8dT5Ww
 4A0FqpsLANQQxa3YrSQjonRWysV75oP2G77JpLlik8bu4Rf3VqqyzUR8Jxa1ItIwBj87nWw9esC
 3NFJJhALv/V+YwGsdT1u4RdcEmx/mh/yR7l0qb2AxF67To2uUUJ+10Cun5oMvTwOCa5UKzL2qUq
 ogPDMo5dukSHc2Y/lA4NVsccBuzM1cWoVLP0GncRyWuvEdT9zeP+vA0tnlZSAwi3YOVPZLyOBkL
 Ab8Ho67FRcyrZUBzLKQ==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c6a961 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=U2YKr12-NB40uPE2UvUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: czk_SyF7Y2LMLI_JwUZbhP0nVLW1pPOM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270109

On 3/25/26 9:42 PM, Douglas Freimuth wrote:

> @@ -1963,15 +1963,10 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
>  }
>  
>  int kvm_s390_inject_vm(struct kvm *kvm,
> -		       struct kvm_s390_interrupt *s390int)
> +		       struct kvm_s390_interrupt *s390int, struct kvm_s390_interrupt_info *inti)

Sashiko makes a point here, sort of.

I believe it's wrong in the sense that you still left the code in this
function that frees inti on error paths, effectively freeing it under
the exact same circumstances as before this patch when it was allocated
in kvm_s390_inject_vm.

But now that you have moved allocation of inti to be the responsibility
of the caller of kvm_s390_inject_vm it generally would imply that the
caller should ALSO be responsible for freeing that memory.  But now both
the passing case and the failing case have given up control of that
memory and assume it's taken care of.

I think that's worth a comment explaining it.

[...]

> +/*
> + * kvm_arch_set_irq_inatomic: fast-path for irqfd injection
> + */
> +int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
> +			      struct kvm *kvm, int irq_source_id, int level,
> +			      bool line_status)
> +{
> +	int ret;
> +	struct s390_io_adapter *adapter;
> +	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
> +	struct kvm_s390_interrupt_info *inti;
> +	struct kvm_s390_interrupt s390int = {
> +			.type = KVM_S390_INT_IO(1, 0, 0, 0),
> +			.parm = 0,
> +	};
> +
> +	kvm->stat.io_390_inatomic++;
> +
> +	/* We're only interested in the 0->1 transition. */
> +	if (!level)
> +		return -EWOULDBLOCK;
> +	if (e->type != KVM_IRQ_ROUTING_S390_ADAPTER)
> +		return -EWOULDBLOCK;
> +
> +	adapter = get_io_adapter(kvm, e->adapter.adapter_id);
> +	if (!adapter)
> +		return -EWOULDBLOCK;
> +
> +	s390int.parm64 = isc_to_int_word(adapter->isc);
> +	ret = adapter_indicators_set_fast(kvm, adapter, &e->adapter);

Sashiko asks an interesting question around this point.  I think it's a
bit more broad than it states, however:

What happens if we -EWOULDBLOCK for any reason past this point and
adapter_indicators_set_fast above here has set the summary bit.

If we then fall back to the 'slow path' and the code in
adapter_indicators_set(), we could possibly see the summary bit was
already set (by adapter_indicators_set_fast() above) and assume that we
don't need to inject anything because the thread of executing that set
the summary bit ALSO did the inject.  But in this particular case we
actually never did.

Do we need to unset the summary bit for these subsequent -EWOULDBLOCK
cases so that the subsequent fallback path will know it must inject?
But we should only undo this if adapter_indicators_set_fast() actually
set the summary bit in the first place.
The indicator bits themselves that might have been set by
adapter_indicators_set_fast() should be fine to leave on, injection
decision is based on the setting of the summary indicator.

> +	if (ret < 0)
> +		return -EWOULDBLOCK;
> +	if (!ret || adapter->masked) {
> +		kvm->stat.io_390_inatomic_adapter_masked++;
> +		return 0;
> +	}
> +
> +	inti = kzalloc_obj(*inti, GFP_ATOMIC);
> +	if (!inti)
> +		return -EWOULDBLOCK;
> +
> +	if (!test_kvm_facility(kvm, 72) || !adapter->suppressible) {
> +		ret = kvm_s390_inject_vm(kvm, &s390int, inti);
> +			if (ret == 0)
> +				return ret;
> +			else
> +				return -EWOULDBLOCK;
> +		}
> +
> +	spin_lock(&fi->ais_lock);
> +	if (fi->nimm & AIS_MODE_MASK(adapter->isc)) {
> +		trace_kvm_s390_airq_suppressed(adapter->id, adapter->isc);
> +		kfree(inti);
> +		goto out;
> +	}
> +
> +	ret = kvm_s390_inject_vm(kvm, &s390int, inti);
> +	if (!ret && (fi->simm & AIS_MODE_MASK(adapter->isc))) {
> +		fi->nimm |= AIS_MODE_MASK(adapter->isc);
> +		trace_kvm_s390_modify_ais_mode(adapter->isc,
> +					       KVM_S390_AIS_MODE_SINGLE, 2);
> +	}
> +	goto out;

Goto is unncessary here.

Also, you don't check returns from kvm_s390_inject_vm on this path?  If
any errors we still return 0 to caller (compare this to the call above
where any errors would instead yield -EWOULDBLOCK)  Can you please
double check this?

[...]

>  
> -static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
> -				      unsigned long token)
> +static int __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
> +				     unsigned long token)

You updated this to return a value but AFAICT you never update the
callers of this function to actually handle the return value.



Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2280370D62;
	Mon, 23 Mar 2026 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774264244; cv=none; b=QU3zv+7b3hG67AhxDiZYysKPbErsY58rzAgd0MKP42ngBV5bkYcNN7GObMLG8cxmaWOTr4K8S+D3kZ6+iPlt8ILYEmjVS3ia9Cm333NCPCiP4gkQHYFu5mg+b0VcwIuRERrjtUvNeXLzZ2LsdgGVxjKx/gF0SIIvrevBvdG1NxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774264244; c=relaxed/simple;
	bh=PhMgXPtohPprDyWKckQS+qsz7/JdrHk0gACJo2xHv8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odR8EaZIj3ZbbShMl/SO+WLUWup1uHdJqIya+aI3Stq/Bu8n1ZwptmkzofLMmXjptWefCBHXY21ald1nnYo3ZjRafqiWivNp1jDqE8HYQQN4//+d3FXG6SGN77aIp/WraRIlok/6CF+oxGhHutmiaSp6aA93jP+3AhwMlrlPDNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PR6Wghz9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PR6Wghz9"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MIUniR107409;
	Mon, 23 Mar 2026 11:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Or0i6+gDk2cVqpWRET+Mid9YbsGguX
	w+/eCnFZLuIAk=; b=PR6Wghz9X6U1ARcAxVAJz1+HuIsYSktr0vZxgQfR3HVzVv
	ir9XXiFxy2chzOf4MSSyF43OAD1uathy/qHGu6p2ImwC1q53Gsmpf14GbjvRfWQB
	ehJMfQLSsEXZWXnK0T7MIfPpXSQLi1vbjAupk8WVbUmgrOe+654hQTeH/nRRZwp5
	1Kr6X72coYETcBGAPgu2MlBjV4vvDX7h+QKF53wHKU+4NdyNo3OZd1JDdLMzJy7D
	UL1kme93Qf/qVVChLdvdB+fXHdJ7U28l3NMDJvBNd52xAa5OMiI5fTygq3mV3iqD
	86GR+3Q4fP0n+xVYOnPW0fvtcMSRJ/Z3TUpQcjWg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxpgg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 11:10:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N6SY4C031598;
	Mon, 23 Mar 2026 11:10:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nsn7ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 11:10:39 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NBAZit52035856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 11:10:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA78220043;
	Mon, 23 Mar 2026 11:10:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FA562004B;
	Mon, 23 Mar 2026 11:10:35 +0000 (GMT)
Received: from osiris (unknown [9.111.67.16])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 23 Mar 2026 11:10:35 +0000 (GMT)
Date: Mon, 23 Mar 2026 12:10:33 +0100
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, gra@linux.ibm.com,
        schlameuss@linux.ibm.com, hca@linux.ibm.com, david@kernel.org
Subject: Re: [PATCH v2 8/8] KVM: s390: Fix KVM_S390_VCPU_FAULT ioctl
Message-ID: <20260323111033.66303-F-seiden@linux.ibm.com>
References: <20260320161542.202913-1-imbrenda@linux.ibm.com>
 <20260320161542.202913-9-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320161542.202913-9-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c11fb0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=qADLU7ugqkt86NIBnJAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MyBTYWx0ZWRfX0v5TnTDsIF9e
 miBChkV4S/WrvWvLq0jlINRwCXd44DzMxVCg3d0zTk/QTml/YVVCm2KbvFeAJatkOT+r1NroSI1
 7vD3oaRZay/CmyGCvB3SVUs398j8J22fmny0QZQi62kDW7cnL+l+88fFYzOVX+/lDVRWrpXnrIv
 MVpEf0FofY+GQG1rFxmkhI74lvbZo+JuttUnny0xEwsdPN3RX6G3D2rcJAH/bfuKCsniLIHsh1j
 iE9TvEIbkzuhPkgXDw+1UWXeVPRLhVHuiCbjqteFvfexL1XoD/Rrq/J3IYvf+N2W1yJN41wQWHi
 7+nxfNoDFcRPRWeJ00qRTPpnGWXdU3xb14rO46BZTYLVt/DR9xzzDq1W58EfwaCActNz1oNNsbs
 Z/PU++eDOCuskI3r9iioni9URx6JjI11D8x+dgzLAPVuGkY5d/eqZKaHp+Csb00LyUJhjFaxQqd
 YAKD6TeQaPSdgsVkxew==
X-Proofpoint-GUID: AWTw3O-3Bqf-6dIaOv0cC18j2a6FyK6J
X-Proofpoint-ORIG-GUID: AWTw3O-3Bqf-6dIaOv0cC18j2a6FyK6J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230083

On Fri, Mar 20, 2026 at 05:15:42PM +0100, Claudio Imbrenda wrote:
> A previous commit changed the behaviour of the KVM_S390_VCPU_FAULT
> ioctl. The current (wrong) implementation will trigger a guest
> addressing exception if the requested address lies outside of a
> memslot, unless the VM is UCONTROL.
> 
> Restore the previous behaviour by open coding the fault-in logic.
> 
> Fixes: 3762e905ec2e ("KVM: s390: use __kvm_faultin_pfn()")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

But I have a comment on a changed logic. And a nit

> ---
>  arch/s390/kvm/kvm-s390.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index ebcb0ef8835e..62f04931b54d 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -5520,9 +5520,21 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  	}
>  #endif
>  	case KVM_S390_VCPU_FAULT: {
> -		idx = srcu_read_lock(&vcpu->kvm->srcu);
> -		r = vcpu_dat_fault_handler(vcpu, arg, 0);
	in here every vcpu_ucontrol_translate error (incl ENONEMs from
	kvm_s390_mmu_cache_topup) is converted into EREMOTE ...
> -		srcu_read_unlock(&vcpu->kvm->srcu, idx);
> +		gpa_t gaddr = arg;
> +
> +		scoped_guard(srcu, &vcpu->kvm->srcu) {
> +			r = vcpu_ucontrol_translate(vcpu, &gaddr);
> +			if (r)
> +				break;
	... which is not longer the case here. As you explicitly convert
	ENOMENS in gmap_ucas_translate before the topup call tnot converting
	might be an overlook (in the topup function?).
> +
> +			r = kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(gaddr), false);
> +			if (r == PGM_ADDRESSING)
> +				r = -EFAULT;
> +			if (r <= 0)
> +				break;
	nit: in vcpu_dat_fault_handler the ifs are in the inverse order.
	They are independent, so this does not make any difference, but this
	itches me a little. :) 

> +			r = -EIO;
> +			KVM_BUG_ON(r, vcpu->kvm);
> +		}
>  		break;
>  	}
>  	case KVM_ENABLE_CAP:
> -- 
> 2.53.0
> 
	Steffen

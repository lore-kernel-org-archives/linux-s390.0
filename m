Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B8538F232;
	Wed, 12 Aug 2026 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532131; cv=none; b=P3y6l8693qvCyx3ADmc5F0iXfsa3PKcPqzP/xdS64zsZFe6laXtyKdE2GR1XNuN2BIPo2PDacbeH5Itt0T5GS4EU0SSDVxIfnKIO1zLakB4i88TQJYvwdWTPJsYkPIknTt+esGLxp1VfGRzxYx6tmRAm6kCfGTNQke/aTAE0Ra8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532131; c=relaxed/simple;
	bh=MeughnLzy8Y+4yeNkZz09j+PcdZ9Pk1J+Z0xffRg2dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7Jvqj8iEv6grDNg6Ap2COUSRJRGfc+j/yLFo7WAv3Pxr4EdyjxEAlTuEDfnJ51xSBM5w4m2SbN7uVJXNPH0TkShsF+QiHitwdqddSRb1Snfed0E3mL6z+lJ/IAVCftRilQtFHVFHSd/bp4USioT+U8NAmtsdjoe1vzm0TcMRiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R1TGglK/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R1TGglK/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CA1UMp1306525;
	Wed, 12 Aug 2026 10:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VHS0Tq
	SsobuJsblzp5Bm0TiHtEgBBCgS7zgwn/ux4xk=; b=R1TGglK/+CbiACQaFi71za
	XV26r3oV/VkjGFHmPCf5mp+6F7BCSuRNu5NiHkRtYJW5eLQWfaUVvdOmXfN5SP8C
	PgEUdTpRbT6MPamQdoG0ae+qlWvCRH+4o4S27JMFWRS0hMzqXCkbKgIVbRqYkdYX
	XxMeHLSt78s61WdvrMtk/yBWmr+XMsTClcvkAGAS1kX5KRSt3FZiYVyO6FaRIv4e
	DCjqJ9R1kMThotso3DqmsFQkdgKE1lHq0RVb7l36VD/1Z16KC319zW9rwyKzrF3F
	rwvjoDT7IWFolOpJJ9QbZeaz/d3EjLjDCfig8detxF816gEauacW3FS0VYcai6Tg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk020pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:55:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CAfHuO025109;
	Wed, 12 Aug 2026 10:55:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h5jy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:55:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CAtNbx17695026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 10:55:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E62120043;
	Wed, 12 Aug 2026 10:55:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6E5B20040;
	Wed, 12 Aug 2026 10:55:22 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 10:55:22 +0000 (GMT)
Message-ID: <1e34c861-7219-4136-8f93-7e2004ccd8a5@de.ibm.com>
Date: Wed, 12 Aug 2026 12:55:21 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] KVM: s390: Fix get_all_floating_irqs()
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
 <20260812104436.109741-4-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260812104436.109741-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfXyeT1laMZETug
 CJHsFnaATNu/2bnpFVoet6xiD8AGs1sZ6ESDRPoA1IkHFCRLof439lTfMhs2BN9MNFgptxfLxRq
 NF5QqZUDv6fbqrNc11NmqnpT+rO2hivJSURSEGo9LP8xQtgopnJc91uBm7sXs6U0Ckm9YZq0mLe
 CTpfH8WoLhpEMTkWcn6DlBtE1JvH9A4COurWuVi7XDbC05B+2hN+ZFDZMoH7I0PliQ+8Y46Uagp
 0wLJ00W7WC3fHWWZYUmByn1euvxqQKZiZZxt5Ax9x7sMkamfLC0LlJPsfCuC9PLbQBgRwZTxSuC
 hn+LKst9lkyGpabuj9oegSiiiZ/xJM+wus9nFln6eQ4Qgu8WzS+s9sU1Zjyo5a0OW+6VjlfAomm
 QO5HF/+sbU8GG2jwoYpePof8kS++pHMiSCmpd47etwSbsneW4zUosJ+h0Q7v6FtIcNtaawKX8bK
 /xi1Tw5KDvXvK9473ww==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfXxmYqN4yhOMx7
 4gfXXJvaGl7cnfcD3dpwEb/yMeTIgJtAGSPCJ7LesDp1Z7u4gui4HpnYSP+VkQj9ot6JkB0sYm+
 a10L5eoprzClFlKqCJ5OUf0n1TvhROY=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7c511f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=qrknQNrlDZ0fREQFVdQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FD_CxI6dAl9fRJTKz4zvK1sZpo2LiZqE
X-Proofpoint-ORIG-GUID: FD_CxI6dAl9fRJTKz4zvK1sZpo2LiZqE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120084

Am 12.08.26 um 12:44 schrieb Claudio Imbrenda:
> When attempting to report all pending floating interrupt to userspace,
> the GISA IPM bits are atomically tested and cleared, and the
> corresponding interrupt description is written in the output buffer. If
> the output buffer is too small, an error is returned to userspace, but
> the GISA IPM bits are now lost.
> 
> Moreover, the contract of KVM_DEV_FLIC_GET_ALL_IRQS, which is the only
> path to get_all_floating_irqs(), states that:
> 
>> All interrupts remain pending, i.e. are not deleted from the list of
>> currently pending interrupts.
> 
> Fix by non-destructively testing for the GISA IPM bits.
> 
> Fixes: 24160af6cb28 ("KVM: s390: add GISA interrupts to FLIC ioctl interface")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

much better.

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/interrupt.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 6b3f97a7513b..61e75d10110e 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -273,6 +273,11 @@ static inline int gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
>   	return test_and_clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
>   }
>   
> +static inline int gisa_test_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
> +{
> +	return test_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *)gisa);
> +}
> +
>   static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
>   {
>   	unsigned long pending = vcpu->kvm->arch.float_int.pending_irqs |
> @@ -2242,7 +2247,7 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
>   				ret = -ENOMEM;
>   				goto out_nolock;
>   			}
> -			if (gisa_tac_ipm_gisc(gi->origin, i)) {
> +			if (gisa_test_ipm_gisc(gi->origin, i)) {
>   				irq = (struct kvm_s390_irq *) &buf[n];
>   				irq->type = KVM_S390_INT_IO(1, 0, 0, 0);
>   				irq->u.io.io_int_word = isc_to_int_word(i);


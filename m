Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487897;
	b=Ms+PSwaYM3QzqIifVSLwWkfd66Ht6IoPxLTKOzsNFX0tvXyB3cFV1sdRkMQDkyrNhMeM
	 aU2S/i9Zpftp7iL9emfhwDANmKkORGWMATYqFDaWzusxTvRHTsgFR2x3ehfoaMmRURz1B
	 ra3QFgcxFv5agSAPGdpiS+2XRhUA2uHSfZm/+u+Ul6pqHN6O5vpCb0PT7twcqtOa9IMwK
	 GBKotISyXFprXi3nhQdcp3pLysXcCO9gDDxyoD4/P1GBs57s9RKoKqbk07RKtFuibgXUg
	 9UbSI8EJvctg+5dC1D0YeUr5hm5FfSSopswmKtMUoKB8b1TujieCJQeN+1v0gB7eP7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487897;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zZae8cCLpGUPs+pgeY59E6wTBH/4CN2UxTfUiGkfupo=;
	b=M9Mf81U3buyldj4gbgxyUIEmUSmxOX1OSEhZbE88GPgZ1TID+zQG5z8KxRC4F6ELz2BL
	 gqiUDcive7rxXymrbTEsTnNE/ZDQpHUs/wOlp2rXgIJ6VGqAptnxnuySmDo8YQ2KZENvc
	 obcZC+/ffFpEeVlAwvMsY6sX4XFWYljI38mOqoyTNDY+AEk2axVbZ1ndI5N/qg0kJdxTE
	 VVx2MCkPWPHXSpWgp6ARHke5HPSLUSkF1ZdMsibHsAklXxCsjlOPfA/Nwwl+M+3R4RdUQ
	 Q4mE4pv1jJUAK5NojO6dsgKIcSP/KDPBd+AZ16E2JbOaD/EjF80MkFsCPQEIiQbS25w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TSm1sS73;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919EC606A319;
	Tue, 20 Oct 2026 09:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 919EC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TSm1sS73
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K1EAwo4175533;
	Tue, 20 Oct 2026 09:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zZae8c
	CLpGUPs+pgeY59E6wTBH/4CN2UxTfUiGkfupo=; b=TSm1sS7384MwU32CQ3D9TQ
	EGjUlRiTBZseIomCBXlf2hHMHFOKW6hg519Buwm1HycLbjIwpd7IDYDtzkChh22Y
	XOffHG9G2KLxwS99H0Hx5xnxBwqJsfO2WffinJdSiQy/5LdmBpF2POFsL4T0vE70
	4f6m5WGTR0TWuKM5QFP5kLAUz3LfrhDmgIn3wUsbpZrUogONO372X5pG4Xv9DFSk
	+Q/VC9/hEZR2KWpT+unY65zvbwBm8YEUU4UV7j5u/Q6J56x3et8+i1v1Ks+RwfJ6
	510tEazYLwDy7BBbKjIo0UEvPWvT2+xDxQ/Zxyg6pCtBO33PWCgrdlMmjcKb7XFw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw581vxx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 09:18:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69K6q9d63754457;
	Tue, 20 Oct 2026 09:18:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hcnjh19cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 09:18:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69K9I7IN31064644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2026 09:18:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70C202004B;
	Tue, 20 Oct 2026 09:18:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AAA220043;
	Tue, 20 Oct 2026 09:18:07 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Oct 2026 09:18:07 +0000 (GMT)
Message-ID: <4e7493a4-98c1-42c9-8bfb-62dc41801568@linux.ibm.com>
Date: Tue, 20 Oct 2026 11:18:06 +0200
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
Subject: Re: [PATCH v1 1/1] KVM: s390: pqap: fix AP status written to wrong
 half of GR1
To: Gautam Gala <ggala@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com,
        pmorel@linux.ibm.com
References: <20261020082534.481867-1-ggala@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261020082534.481867-1-ggala@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzNiBTYWx0ZWRfX/S8XNpCXTvtr
 HKCx0g4FDFZJzpGQxB6+4+6+8GfvuQgiSR+SzvBJRGO/RZtkGA9Sq2T0iIN6Hl4oN2QDl5+Zu1T
 59NQoFA4cjeMGlxQquuSV1xte7YiuVE=
X-Proofpoint-GUID: MrG2SlkIfGcqEZcCSfbGtJD1xLcbKk-9
X-Proofpoint-ORIG-GUID: MrG2SlkIfGcqEZcCSfbGtJD1xLcbKk-9
X-Authority-Analysis: v=2.4 cv=UOBIjyfy c=1 sm=1 tr=0 ts=6ad731d5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=_B2Ys1ejglQFZ4E6RQEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzNiBTYWx0ZWRfX+STS1bZaGM92
 gJRI12AYZAqP/IFShEBHnp7KuZZXgTdzud96Q77n3cGSOAyaogA6Q9DI+2ZaNy70TaTsLdZNtDG
 Z1pBq4HJNCbi7Yng0x0LG8WF4OUcI5how83KxZKn2nHooC+4aMIIDBKuspKdWH9+7al/337GD5X
 VJlwoL3C0znRc8L2lNajBBpC7Tsvf7IcaEtM5k234R6H6Rfyq7/I6vmxvbIPZr0J40ITS07QN/P
 7W4ZBNbbB30mrn8zm4bQiCdGuB1yDctOU9xnMbCdC2VKUSuw26d+gIBklIG2jHJWA1maSUa1+Qp
 ASmuULRqbayNKIhzJK2MRP8opC2yDRytSHUizOP7apg3LYrZQExfDXTqhySeROu6ysEjBTxSW0S
 03/Z0EM7BS/f8pdXJKmUk5qzl8jurlyKPgG2AYCr/6A+OVLXGnCQ0xK78/zASr1PaA/bgyPw/Ze
 FJMFgkjhMGDHQVpECuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200036

Am 20.10.26 um 10:25 schrieb Gautam Gala:
> The AP Queue Status Word (APQSW) occupies bit positions 32-63 of GR1,
> i.e. the low 32 bits of the 64-bit register, while the upper 32 bits
> are reserved.
> 
> The no-hook fallback path in handle_pqap() synthesizes an APQSW and
> copies struct ap_queue_status directly into GPR1 using memcpy(). On
> big-endian s390 this places the APQSW in the upper 32 bits of the
> register rather than in the architecturally defined APQSW field.
> 
> Use union ap_queue_status_reg and assign its value directly to GPR1.
> This places APQSW in the correct half of the register and aligns the
> fallback path with the register layout used by the AP infrastructure.
> 
> Fixes: e5282de93105 ("s390: ap: kvm: add PQAP interception for AQIC")
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Thanks. applied.

> ---
>   arch/s390/kvm/s390/priv.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/s390/priv.c b/arch/s390/kvm/s390/priv.c
> index b3cb2c2c3aa7..ccb2a7830265 100644
> --- a/arch/s390/kvm/s390/priv.c
> +++ b/arch/s390/kvm/s390/priv.c
> @@ -592,7 +592,7 @@ EXPORT_SYMBOL_FOR_MODULES(kvm_s390_is_gpa_in_memslot, "vfio_ap");
>    */
>   static int handle_pqap(struct kvm_vcpu *vcpu)
>   {
> -	struct ap_queue_status status = {};
> +	union ap_queue_status_reg status = {};
>   	crypto_hook pqap_hook;
>   	unsigned long reg0;
>   	int ret;
> @@ -661,8 +661,8 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>   	 * No hook means no driver to enable the SIE CRYCB and no queues.
>   	 * We send this response to the guest.
>   	 */
> -	status.response_code = 0x01;
> -	memcpy(&vcpu->run->s.regs.gprs[1], &status, sizeof(status));
> +	status.status.response_code = 0x01;
> +	vcpu->run->s.regs.gprs[1] = status.value;
>   	kvm_s390_set_psw_cc(vcpu, 3);
>   	return 0;
>   }


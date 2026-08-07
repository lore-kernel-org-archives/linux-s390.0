Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7052C41B8EE;
	Fri,  7 Aug 2026 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098739; cv=none; b=ipQ8D/Cw4MXg40PZa4nj5o4cQ6yuwFI7iZPSABN6Mmy575RusgJTiv9Y1VQ4WMM1Ki/nb51XM8U+Mucczy3Eu8dmvI85idcPd+7ySsBzHodeiV7R2/9juyOQm3JwEpo7TexggxIx6m5OkqkcGgfy2n1tTMoZnmw6gv79qI3oSKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098739; c=relaxed/simple;
	bh=6jPwr4BcnNhEnQlWRJRK6CugI8jK/fk7B++z30GJZuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKtxSZcs2pxpG/SxjvNWv8PrBc+SvgEkhUeIs6/1zghBxb3304U+grQGndRgVb4SXmZQ5t7ia1y8oPJfyNWUWKgzPNGtMZ/9MxOUquA7CZ8uxlP79ILsx2QRRugXG1nuq3/AGGvfD88Pbp0NxYnOnrNs/Vj9bf0zG411Oae8I2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sUnIig+F; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sUnIig+F"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HZNL2275998;
	Fri, 7 Aug 2026 10:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ftf8cS
	ADQIx349O2Eywy9Byz1UFWjQ2N8M9b0/7iU0M=; b=sUnIig+FzG/GxUVoriPO2B
	dLx+mi2XtexwaWBZboFQQ13uPH5E1xG6s3BU4WTwKtxxFOQGcgAK4aIWzN7C71ZE
	eUU3xJKIePwmATgVIGy7gdxT+CY/AE1nU8whRi75IwDSQRcT4xNLtg8lpvYvgcDY
	3MbhcsaOwPU+LWhSpdQrXokaRhQ2kaKcAOS7kpzkJZb2L2Us//hrfmK8llAIBqEx
	HPAiMT5zAGLaqbo3NZ3ssqaSovCHBi1FKQHsskZAe2QYvjAzIRbV3n/BtIKaGNOO
	kzoXhYhPkX2NECpvwzRkvakcq2ufxkCZroVrqGppO2d7Sn2RvDQUbQpozZ6koHyA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy01kdyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:32:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677AQQrK016682;
	Fri, 7 Aug 2026 10:32:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qydrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:32:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677AWBgY40173954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 10:32:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FD642004B;
	Fri,  7 Aug 2026 10:32:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2956520040;
	Fri,  7 Aug 2026 10:32:11 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 10:32:11 +0000 (GMT)
Message-ID: <eea54688-da7f-420d-9b88-04384519572d@linux.ibm.com>
Date: Fri, 7 Aug 2026 12:32:10 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] KVM: s390: vsie: Remove duplicate assertion
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
 <20260807-vsie-cleanup-202607-v1-2-b18659b55e3d@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260807-vsie-cleanup-202607-v1-2-b18659b55e3d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JDoQ15JVwpgiPWFrgSdkQDo6kVTcJKl8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3OCBTYWx0ZWRfX8TjH3ili/1KQ
 zkOptYGQcd1YJYCdYjkuYy35F1LLFHhFIhXw3HLRChCsrAn57J8AWBhoB38fpkYYMAKFlRvLGOk
 M9+f6XuvzbR+lJM+cpX9yZL9PBaBKrM=
X-Proofpoint-ORIG-GUID: JDoQ15JVwpgiPWFrgSdkQDo6kVTcJKl8
X-Authority-Analysis: v=2.4 cv=afNRWxot c=1 sm=1 tr=0 ts=6a75b430 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=P3lmscs1VvsUGeS8l7IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3OCBTYWx0ZWRfX+6T45E7bocPA
 hKPyuMkZnAD8KnIDDLa4tHJ7s+GfHzGKUbDfVontglvmgVCZyo+Nboo4uT5uXdsEfT8xuqx5fbY
 KJyU3z67GUg6S1y2jGBeFSgoJYiQE62vS8s2Murlr7D8RO2XIWFuw6YsYeo4cQzsiaYRoIJIix4
 F+q02PeufSxgGVVCMIg1KLONw0ODj3EoEyiSIWw8dkrpmELxZbznpEkTysdT/Fqqrs0K43T4SJJ
 OAEd5MXuihyq+K2FK8/KLIlIXQkmhokZnxksptcf0J2b2SFtdgnMY2KhLvjcVvnLlmd1dFA0rwt
 TNwYjp5dzKX6GDsc6XFC3x++cuNnmOnLCRGYrpiCVH3v03/uZC38EfU+n7G9kCatSH8YK9D4YIm
 /vnft7OLO0JwLA0ML+sCo4RrFZ2yddbuXcMwlfQFW0Ert03utdDg38R2gYGCL8josjuf2Q7v7OI
 sNRtFDikAZqIC4cdP+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070078

Am 07.08.26 um 11:57 schrieb Christoph Schlameuss:
> This is covered by a static_assert at the struct vsie_page definition.
> 
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")

we could argue to remove this as this is likely not needed for stable
since its a build bug, but does not hurt.



> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>   arch/s390/kvm/vsie.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index eea24562e7db..3e956c7faa4b 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -1565,7 +1565,6 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
>   	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
>   		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>   
> -	BUILD_BUG_ON(sizeof(struct vsie_page) != PAGE_SIZE);
>   	scb_addr = kvm_s390_get_base_disp_s(vcpu, NULL);
>   
>   	/* 512 byte alignment */
> 


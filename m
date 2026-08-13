Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDCA495501;
	Thu, 13 Aug 2026 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786639423; cv=none; b=CFXvCEvx3Ar1S2+eiP386bL26KblMH2zYsq/EsWo1Vwngb6uyFE7OCFWKvaKPsNy3u0vwO05oRklA87yY93S5ce3+cg2WoXKUpLQOVV84pcxR+AaM4ipSNqpbQY3iAb5krlC0OUoMWEp6YZ2hZYNPUkSloyUO4OcRC57Y+x7Ams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786639423; c=relaxed/simple;
	bh=1pFmfPJ/NS4woqYIYPZY2u5Z4FXyXNnoiEkLH8xPrCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+P510zCWzKcWCA4K36jOkKhyaG+aJ1SWrL6llQ2sfA80BW/Jj7rxj2cQes9bYDKu0fILlOPG6PcCUi0S3NaZNfq7WI9M8EEEpXvgrCtUtKspjkLt31bmuyvSyCr3tvYatT4B+8jifkYFRoWng3dxqEPDO6eTWLace/ni1dHJ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TXj8ZcO5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TXj8ZcO5"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DFWg051629131;
	Thu, 13 Aug 2026 16:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mCu5XM
	+/703dwdT+kC7YbRAuyNhk17M21ts/P/wSqb4=; b=TXj8ZcO5KayzNVRaqpzZEX
	u5fgeSqp652cZ8pWdHAhj0cb6NEIO4CPVmunj+y7l3gFgc76EdkrDW5J0n2mA1pV
	WLeZTBSdESyIs8eFVYeq2eNIIzoWdfXTUmRFmAlHtj6zMY0Dct9tcM2aVTaKnHNk
	Ej0hdjahN+2wVcNBNhrQZlokJ9UjU+FKQHOJwrThhm4wvJZBvAEGtfd8u+19cYug
	kj1tmPLWtm/gkV3Ksm4l293HVnO5XAz5TYEcosH3AgF0QWiwqtgKDO52Ev2H5G65
	iphJeNtyPddgzBhN6hGdrduuVyzY3KBSpJUfJmLsplagX403pslz26KQFph4RnJw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb24192h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 16:43:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DGfK2c002548;
	Thu, 13 Aug 2026 16:43:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5wbwbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 16:43:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DGhPBc38404370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 16:43:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2144520043;
	Thu, 13 Aug 2026 16:43:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E385620040;
	Thu, 13 Aug 2026 16:43:24 +0000 (GMT)
Received: from [9.111.39.35] (unknown [9.111.39.35])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 16:43:24 +0000 (GMT)
Message-ID: <ac0193b2-f286-404b-b8e9-8f67e4489aa8@linux.ibm.com>
Date: Thu, 13 Aug 2026 18:43:24 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kvm: s390: Improve floating IRQ injection behavior
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: imbrenda@linux.ibm.com, linux-s390@vger.kernel.org
References: <20260813154040.73437-1-frankja@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260813154040.73437-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7df431 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=vhUChTvZ1_M9NrF1dGAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDExOSBTYWx0ZWRfXylf6wl5Z3kwo
 cSj2FDWspK12nlyeu/gktsg3sgLXitQx5SdYfaMXPhWu4hDRPVyrZQp7XeOpRL9hapfeU+sMoaE
 pJ3pvPUkB0ujFvHAWJFIb8XHjhyUFBUzwYheaU1PKm7WIzW/N8opOuRKzB6m9q5uwTNurdWxA0i
 vo7mxAm3qwxfM35vOorK2gue/gtu3WrOfMAXVhR6j/3FsMbDb9woDIIOGBmsflNIuDhHDfdcHMP
 vgehQOPulvrUpUQqq3qFeAnb5pRleWseUPigQ+i4Bi7kTjVzWkQU/K8aWMl+rxwF8L0iWD4Yxjt
 O1V7Rtdg6t0vyeLltHxKOT9Ave44hOPajrzMbe7RfU64A/2e2FWCyw9cjg23zsKf7TQUaR3b12+
 Jaw5ASdzp/eFa9OcrSfs9eUX4Cu2OZ4AyI2WEWhxxXni7D8khonzKNlPJ6O4zgMIK0QLXqK9bt0
 HmGMSnCxveJYSjPX8jw==
X-Proofpoint-ORIG-GUID: 09UimnzEgnZiMvf7nGIp6Lsg3y0kSHGX
X-Proofpoint-GUID: 09UimnzEgnZiMvf7nGIp6Lsg3y0kSHGX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDExOSBTYWx0ZWRfXyfel2LQg7H8Q
 BVeMiZY3xc7cow3WkEjAhaZxg08X+me4ql4ohrAFyqWRT0QKHO4jZZMBV829F3PCIX/JU8d+gc7
 OdX3FEIkiUhILxHZmRSdCvA2LZc1GaQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130119



Am 13.08.26 um 16:56 schrieb Janosch Frank:
  	kvm_s390_set_cpuflags(vcpu, CPUSTAT_WAIT);
> @@ -1933,7 +1964,8 @@ static void __floating_irq_kick(struct kvm *kvm, u64 type)
>   	for (sigcpu = kvm->arch.float_int.last_sleep_cpu; ; sigcpu++) {
>   		sigcpu %= online_vcpus;
>   		dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
> -		if (!is_vcpu_stopped(dst_vcpu))
> +		if (!is_vcpu_stopped(dst_vcpu) &&
> +		    deliverable_irqs(dst_vcpu))

We have the type. Wouldnt it be better to actually check if type is deliverable?

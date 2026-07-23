Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7447B44781A;
	Thu, 23 Jul 2026 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815926; cv=none; b=XYBdgbQ2/TDGVItEzm2zTEeqns8g6auuPdyOXyV5qPOypcec36eL/NASXLlmh+SObbrdmBc15FcFT9jCVTCv6Qy13c7heyEBIreM87SCmcrtTaeOqE58MVbjrsLrSNXecf78CUHRTsEzIcjImIMf4Rk3PVQPK7w4IVU+fmJD9IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815926; c=relaxed/simple;
	bh=9JzmQ0MTzYE54NBaILJpaLFvOBKjFJgeBepkHRdbcCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQMjCknNBBF5rlEmmsrBvT4kVNUJPfWyH+0QSrn6PwqVRip+smFjJgWotSHdRTe/wSqiHjD32Dv9Gl8vgmVbNd8zPEsrCVGOQuxv/IbmsD920s+IzXWX6MCtMSm2DEzh+B+jYEt3lyDXsrkvRsq+1Ngy/ifB5dchzMvnz9fSwsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eCdjGozx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eCdjGozx"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBiED3094722;
	Thu, 23 Jul 2026 14:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=W8cWkG
	3314HhnwRypVglv8MynAvC07EAsSSwDjObe78=; b=eCdjGozx0G3dKIXNgAmMS+
	0RSOtCywzj30M9haThE1WrsyR3t7MyI8oRPmsSSnn2Pa/GmD4LCtVthETkQ+lAw9
	ED9CkU0JPS6LAJQ7eh88WnfUHNgQyGKX4wJHZdK8MATIyhEU3E0KA8ccttJAHO8R
	g0wuHWEypdN54ggnat31ah9c9LKm4DZ+2nFJBEIEyNgftT2ODOp5q4+lYay3jdK0
	I5oFE6W/UxXMTNzydHuNKreTA/2Icj1Bb4Q1Y6zd+QD6Tjr0LeynRnYFjyrwdDvK
	w7tUMGwNufMFJK7SNGZwuJ/Cv1eRXkN3/gpVXg4HDMrr6tJBYy9iO8360frIBkqQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahfbat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 14:11:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NE4ZnM029834;
	Thu, 23 Jul 2026 14:11:48 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqcpfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 14:11:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NEBlOP42533360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 14:11:47 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59BA358053;
	Thu, 23 Jul 2026 14:11:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F50F58043;
	Thu, 23 Jul 2026 14:11:46 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 14:11:46 +0000 (GMT)
Message-ID: <51f8e489-490c-4312-be0a-dc2917531634@linux.ibm.com>
Date: Thu, 23 Jul 2026 10:11:46 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] KVM: s390: pci: Reject adapter interrupt
 forwarding if already enabled
To: Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@linux.ibm.com, farman@linux.ibm.com
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-2-alifm@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260722170621.1686-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xX-ow8IgkU3QB6cmMhHqTPUhwSe6zWmF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE0MCBTYWx0ZWRfX6itlgRVLFzyY
 8H8vF1y2NaDxz2io4oFWXVUEWdf+DyKNLiRUYY1DB5r34SM691R+zS5MLaPx9lS3DMFEHvBCV07
 qYBCW9Y1KzZI5cC8P5yrky5ntOzwrh1LomH3Dq53V+oLuzzGww1bmmg1gx2L9SI84CYOhkXoTM5
 5PJ0P20WoCSSCJAUrssBg/5GnIKiNPFh8MfQU1GWYfazb5OQO89hZ8zHqNZKqNOTYkGaPug/8Tx
 ahz87ODcSKV7O7ABUGlS3T/kerZ6gafAtzHShYwuhNuTCyMt4TK1LLLNJ5WXMe6+BdR9hLOlaLX
 fNWuiQSMgCa0mGgiGr9yuSH+b3dBXQZJOKZbh+JpsGGXUsNhEemLsrFGzZQ5533muc1gRL52FUx
 Hln4d1I3oFRncNqmm69bg6hHck8jp8SwSV/JcAUVujNplH4QzgEv3Fgf/DSTXrmmKqDjkRlXUnE
 ucdOgO+rRuPb8CR/i9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE0MCBTYWx0ZWRfX71QMhuS8RQXm
 owTRhijCHMnMFixa+dUgG2U7451Ul/HZbllf0tug7Oo+JdG0jY2xuNwHNiVAEx9Txxz+PcZxNwz
 hvUgf/+P7dPqDB/3wT5iFSUvNYGp5bA=
X-Proofpoint-GUID: xX-ow8IgkU3QB6cmMhHqTPUhwSe6zWmF
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a622125 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=qTyBGSm_4S1F8pAM02kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230140

On 7/22/26 1:06 PM, Farhan Ali wrote:
> The MPCIFC instruction doesn't allow registering adapter interrupts without
> first unregistering. So reject any request to enable interrupt forwarding
> if its already enabled for the zPCI device. This also fixes overwriting and
> thus leaking resources when the ioctl is called multiple times for the same
> device.
> 
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  arch/s390/kvm/pci.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 720bb58cabe2..d2a11cdf6941 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -237,6 +237,10 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>  	if (zdev->gisa == 0)
>  		return -EINVAL;
>  
> +	/* AIF already enabled for the device */
> +	if (zdev->kzdev->fib.fmt0.aibv != 0)
> +		return -EINVAL;
> +
>  	kvm = zdev->kzdev->kvm;
>  	msi_vecs = min_t(unsigned int, fib->fmt0.noi, zdev->max_msi);
>  


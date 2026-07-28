Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3333B5DEE;
	Tue, 28 Jul 2026 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242422; cv=none; b=o3dkmr4TbVeX174WbL4ShXwgoAZtBABjugGojJBsPE6mkPpkdPpOdBrSYEG5B/AhyZB3hvCsypGSMojwwFj7vp9RjAJYnkVMNKpepH3ouzH85o290PepkpE8hrdQuCRTEKfSzzjdqH1CqTjYeBnW2zJcXzjXEgNWvxJJyGudlAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242422; c=relaxed/simple;
	bh=ATaJ+vCiaCYkhADUOEEvZAEpCjCfGpIpfMsICowcuDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCx3hwRLD95gGllf224BWHDHFzw1u2ItD+NECXnAepMaq74KUYMzdAVME1Yoq0XmHhHyPrzzFU3vuktU6Mn7QkYPuxnP9Jt/mJTKBwN4SC2CHHKl8TfKLWrfzTbD85D/gotcUyHSWhrCLLr+HsfkPvlTbJaAwE2X+Vo3vxmOEUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W7ytSD8C; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W7ytSD8C"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SBHc2l961642;
	Tue, 28 Jul 2026 12:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=6Dzd1k5MG1fchQFTFX/sRaCd6uvt9F
	jOZXKvzWqjeW0=; b=W7ytSD8CaBkC0ZJuf9VaRFRNDkCk1ADoAeu74PNZi94VMO
	dSc1PRtecqNrEbtPhu+UAdcv/hB/7BiKTnbWBFeZ72SdCoV8JnNPsmEQIUfLDoNY
	YScv+y80YbRDdRqIalFlj++F9sfQ2xohK99nUwZakED2TZxxK1qDxA6vkl1K8lRE
	6dW0nLH4/ZCzdIteMTA96IylHjf5OlBR+dZbYA/YaoowXrT5tYVvyMmUGbDJaVdY
	ZnGvyZM4cuE8i2TB0EGZ461TY/E9rzS0DmAq9xfJC+T4SIIMUuLu1CioAMHamJRr
	+Pou1dJiHuC4RI+x5gBz/oS+ArEpQ/UlCdZ2XV/A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xn57r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 12:40:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SCQGjs014965;
	Tue, 28 Jul 2026 12:40:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw1wxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 12:40:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SCe9xN48955714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 12:40:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2238A20049;
	Tue, 28 Jul 2026 12:40:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB2C62004B;
	Tue, 28 Jul 2026 12:40:08 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Jul 2026 12:40:08 +0000 (GMT)
Date: Tue, 28 Jul 2026 14:40:07 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: Re: [PATCH v3 10/10] KVM: s390: Fix cleanup in
 kvm_s390_pv_create_cpu()
Message-ID: <20260728124007.385398-C-seiden@linux.ibm.com>
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
 <20260727150254.236021-11-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727150254.236021-11-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PtyKNFv1j-hpnXYziDO6yAb5ZN_i_aMT
X-Proofpoint-ORIG-GUID: PtyKNFv1j-hpnXYziDO6yAb5ZN_i_aMT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEwOCBTYWx0ZWRfX4gXlvFPdZCVa
 L1ssyYVU+1e+YnxWYcqPA/ZVwXTPKhX5iF/VstdmCBxxabpGntH4i5tsRyuSNyZRN+2nTqaM+VX
 nksohJXT0UAnNj+cUioiI2iYCofMqxA=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a68a32e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=3LDMQD1oRKttpTK8AWQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEwOCBTYWx0ZWRfX7QcpeqguCufZ
 4qLI7CMsZVBexS9RNw4KMByaNFM12nKEcVUFLK4h0lRrTsfjme8gQITc1JP+6xk3z8hvbuRwObB
 obAQfbf3AOc3FXAPCJpAt1k2cchuT4m7lnNt3lA3rVKd8LExz6vAXWzsu3oEB73C2bqHksyJUZA
 q0zmJitBQLpsCDZbO4qtOXdlGC8ukQhoLJN9sWERaWB66HwtfYYYe7tQnmFspBEwcH87wJUvFNP
 +x3VoyqaFLO1AJfQJv/LU8Q/x5IUQZ8fhNejkj+zPepCZ78fWiNsmC4spRuSOspNeIEkdIePKoB
 xzQjTwdDQCqRDaNSTyg0ncRbhdaGdJMXK5B/wwoONrhNJ0qSGyYKWu/8kUlgy80yPdhUUeN24FC
 OG7OYrH2Tjr6kx6/sK75L2Q5CtFNm/lZy00VIDVeoJUjjlhdOOzjnMMQwBSlcBtpQjITqzQx4HB
 1ygBHSoFPgG9GuOUeDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280108

On Mon, Jul 27, 2026 at 05:02:54PM +0200, Claudio Imbrenda wrote:
> If creating a protected vCPU in kvm_s390_pv_create_cpu() fails,
> kvm_s390_pv_destroy_cpu() was called, which checks whether the vCPU has
> a PV handle and exits doing nothing otherwise. At that point, due to
> not having created the protected vCPU, the PV handle will not be set,
> and kvm_s390_pv_destroy_cpu() will do nothing, thus leaking the
> allocated memory.
> 
> Fix by factoring out the code to free and reset a PV vCPU; call it from
> kvm_s390_pv_destroy_cpu() and kvm_s390_pv_create_cpu().
> 
> Fixes: d4074324b07a ("KVM: s390: pv: avoid double free of sida page")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

> ---
>  arch/s390/kvm/pv.c | 41 +++++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> index dc204b521052..b02e0159d3cd 100644
> --- a/arch/s390/kvm/pv.c
> +++ b/arch/s390/kvm/pv.c
...
>  int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc)
>  {
>
...

> -	return cc ? EIO : 0;
> +	return cc ? -EIO : 0;

maye add a comment that you fixed this return value as well.

	Steffen

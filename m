Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922253254B7;
	Fri, 21 Nov 2025 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741476; cv=none; b=LxtfKuWjy9Jrk/Ke8SESaf+w9T9DATbHZ5IXAjIZKfylJ8GqmDyXWnkKw2nFbr2GFcDZ3oEqt2vXtDgCo+KhBQSauz9p4OHq4JtIQCP3CNecZhSwxwt2l3773REegoOMz8pRSHt5cega/OIxAK1WCTqSWMfIXtkymFmknzqMfTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741476; c=relaxed/simple;
	bh=1f7m5y9Lh68E427YEWYT1L0XLZXETs0F2U1DAb24cJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NR8Jm+piJQ6YEDHuV1T1bzRscY+dBTfJOyPqE4yhPas3WPLJFcSiQcvgfly28x9WtyyeKIF9N8waZ5cG4WX9F7XHiaIY5JWLts5kKGW85thNrJzN9sTQq9HGGMKkY122FeNwezrBPXkEmCm6XT8RJTEKcAga/joF4H2tAXT04rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sHRWv3M+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sHRWv3M+"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALDj84O021451;
	Fri, 21 Nov 2025 16:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=rHf2FeBtT7rYqPAMJxVV5ZdEBILrke
	vg+0NAbPaIIQA=; b=sHRWv3M+1WbEkzqhIKJYY2jqZa9CF2Y3tmrBSB8jlfDfB7
	vmTSsuSe+TBqfztyn0fRYp1Fh0+WZjfQv7+N+ohBCoseyRuHLIM3351tIbqnQJ8N
	qex8r4cfq0p+3N5jm8tGi6GJJWkmBEszeqneApKqxNpmDYQw0lhV70M9aneWmT1K
	jV33kmdgyLQCqiNh3ZBQjoGpiG7glGYLVEk7TwuCUM+v02Yj3SzjppQuJPdcBP41
	GyNF53tB67JSdflGfc++KyIrJ7ZPEefl01KgjfF7aVsS9ie1ljOwolYgsWt7/apA
	vFg6FlHyg+Iy/4qvHllulQdhPOQbmEKV95NJ0e+w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjwmxps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 16:11:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALD1viN017305;
	Fri, 21 Nov 2025 16:11:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af6j24ud7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 16:11:10 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ALGB6nN54264100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 16:11:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9869520040;
	Fri, 21 Nov 2025 16:11:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00B6E20049;
	Fri, 21 Nov 2025 16:11:06 +0000 (GMT)
Received: from osiris (unknown [9.111.15.252])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 21 Nov 2025 16:11:05 +0000 (GMT)
Date: Fri, 21 Nov 2025 17:11:04 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Tobias Schumacher <ts@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v6 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain API
Message-ID: <20251121161104.27602Ee9-hca@linux.ibm.com>
References: <20251121-implement-msi-domain-v6-0-444f4a6479c3@linux.ibm.com>
 <20251121-implement-msi-domain-v6-2-444f4a6479c3@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-implement-msi-domain-v6-2-444f4a6479c3@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BanVE7t2 c=1 sm=1 tr=0 ts=69208f1f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=b67PWr6P2bOeenGFTbsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX8ggH+phNlYWE
 qweticClHnhMnKJU+O95P43AdANFS+YKXcHCEH+1yLxALi3fk+KjnoBkgOXNzCLdBaHv6riX9tK
 2G/yheiEkzC9uCYwwF+KU19yrjsYgfVOF1Jrl8iB8ByURUcZghBmKCl9dI4oNRKXrCROhWJy90+
 e9OQHxZnKdEUzEWTQbXRIzwnfBczWoerzkgmaQKtfft3SygjQmisnRhDV/x8x9HnhXZNjR2Ldgy
 QMNodV4ChU3ZZn1ycRUEbc0ekEcMe4XcpG2pRmOS1mDXq5hb3CvQbMecfq5nEyUNb6HJ6desZhF
 LDnoJ8ksV4aT/wbKuokxfXQhw+9Il9Vk21vIewSaKQKsmNG1U3igK3KCQESwRR2hrPYij9ecF0t
 VJp4CX6EhHxd+HYudA9I7F02427lGg==
X-Proofpoint-GUID: SvMwNIrYhTt7yiMLt8Y6WhowcGlEZdyR
X-Proofpoint-ORIG-GUID: SvMwNIrYhTt7yiMLt8Y6WhowcGlEZdyR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

On Fri, Nov 21, 2025 at 04:45:43PM +0100, Tobias Schumacher wrote:
> +static const struct irq_domain_ops zpci_msi_domain_ops = {
> +	.alloc = zpci_msi_domain_alloc,
> +	.free  = zpci_msi_domain_free
...
> +static struct msi_parent_ops zpci_msi_parent_ops = {
> +	.supported_flags   = MSI_GENERIC_FLAGS_MASK	|
> +			     MSI_FLAG_PCI_MSIX		|
> +			     MSI_FLAG_MULTI_PCI_MSI,
> +	.required_flags	   = MSI_FLAG_USE_DEF_DOM_OPS  |
> +			     MSI_FLAG_USE_DEF_CHIP_OPS,
> +	.init_dev_msi_info = zpci_init_dev_msi_info
...
> +	struct irq_domain_info info = {
> +		.fwnode		= irq_domain_alloc_named_fwnode(fwnode_name),
> +		.ops		= &zpci_msi_domain_ops

All initializers should come with a comma at the end. Anyway, let's wait
for Gerd. If he is fine with this version I'll add them when applying.

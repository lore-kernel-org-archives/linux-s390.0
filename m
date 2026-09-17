Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2654E36C6;
	Thu, 17 Sep 2026 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673751; cv=none; b=qWz9sRuA8HLmOuqrEXScTI4R37PqWYsXFf4XYBWcbdX7MtL1VFJEdUxgoigUm/uxvKjzQFuyiREdjellcTy9PpPJeHr6DObJoXWc/TEsyAknDaPgY9FRvV/PGxGAGPYICV/7fru2qD15tnbAI6J2SLL9XzTKyDoeqWDOQHFxilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673751; c=relaxed/simple;
	bh=ZdaDZ7DmgcYhunGLg9XN1aRRnPTk3xh49WnefUvS7T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIc6YYVhN4U3S9FQ3LFK1IPsfq4lP/tf1lGweQBrNsx1OEH4AusbpZr97Z3x+LKfwdtxXOqP4LnJg/1uNZLGc2nGh+BzA4T7rs2MsJkdhB81lGvqaZjH2ZX1mvpJ3XkHRogEC8xSG+FEqrLMNB4CgFoDSageKwpqGYWIv/fQLMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cO2PKqwG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cO2PKqwG"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HHVagS3182107;
	Thu, 17 Sep 2026 19:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=1gItC5phrprkxYX1pujl44KNc3xrKd
	TC8XyZgAuFYKA=; b=cO2PKqwG6l8g1+RpnY+AS0Gu2nykZb2obCSx4a4UNM/Ssm
	IvOxOvCBBUqQKR8Xg53u9IHYuMlc1IeQlrZYQ5PaZ51DZ8o450G7mHbncV6Wb+tM
	/9Hcp27ezuN/Jze+JRzsERJPwZ4h2m/HKNyFWQ2NPA5kY2i/mDlaa/yTqnz7bNQV
	tdJrmQkIj+X/tvR7FcOUMtcysn/4pUjm1LPd2LWLPirgh+SJewehwl8kPrz4w0rb
	knIpLNvj5SRif7zN1Y9hvTXxtzxp8hBpR5+Wvhd+shGJNoy2eyiLC6P4xeEd2/Cs
	9Y2wk5pN8Qb+mTDl1VvY3CG2t8Nj5obs7B+eE8Fw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcvbud7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:35:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH9Ahe261621;
	Thu, 17 Sep 2026 19:35:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr7gekmj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:35:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HJZgRX47513880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 19:35:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4598020043;
	Thu, 17 Sep 2026 19:35:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC17E20040;
	Thu, 17 Sep 2026 19:35:41 +0000 (GMT)
Received: from osiris (unknown [9.111.82.95])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 17 Sep 2026 19:35:41 +0000 (GMT)
Date: Thu, 17 Sep 2026 21:35:40 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/uv: Rework page allocation for guest variable
 storage area
Message-ID: <20260917193540.13842A26-hca@linux.ibm.com>
References: <20260915144307.2367089-1-hca@linux.ibm.com>
 <1a53b72c-b215-496c-b9f0-04f3afd09693-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a53b72c-b215-496c-b9f0-04f3afd09693-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI3OSBTYWx0ZWRfXw4jJYB+9KF/d
 xKLhadtAYAtxneldBMLwYgbI8OcJet93/F66t1ATbCN26ZcMBhByNxijjqtOj37wlGf5jW26C7b
 6EwQylkrlePwXvemYYHSY4bJOBZidKU=
X-Proofpoint-ORIG-GUID: RgQNPFIvEn6DnAy0Re0sBklNzp7bgJnV
X-Proofpoint-GUID: RgQNPFIvEn6DnAy0Re0sBklNzp7bgJnV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI3OSBTYWx0ZWRfX60DLld6w6aQP
 2wyOM3A52M/we0tHkvOB9NkNoAQA4mMjpS/eTMTVNAK1WND0R5D5v4iXRczIaWfx+He/Kro8ZKc
 E7RzKwsDgfqndNAAcx13Ru6W0I43RBWMbjysnSF9GPfxrIu8Wmxi+mpmZa1Cz6TmS1VBh47qjdQ
 WGeZibRUX8h+VNdmRdgdFZeRQVUXiwYrOTLPlTwWLFcSfuXps1a5kXHj6ctXMauKkBBXBmJAolq
 FzXHONRXR27AdaIfMS7ueQs3rsPpMyfpou7owDq51HcNsDelXdgoGbYuFq2B2pW9wKnJozgraWR
 rzk52A3bp4LiK9RY96S/+OiXvd3V2perwfqKTgki65PXvxsxUMdedMqVubRaGKz19WFQmLVLg7K
 WBvTnZDk9seSnc1DhJwjVHp7ZZH1TlS39GrbYMML9imnHjDPZc5tSl7UhPdzTU3mx3/nMzfLZPb
 DHHmoM5x82LUmFX+Gnw==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aac4112 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=xgZBs7X4GezASKjRQcQA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170279

On Thu, Sep 17, 2026 at 12:26:55PM +0200, Alexander Gordeev wrote:
> On Tue, Sep 15, 2026 at 04:43:07PM +0200, Heiko Carstens wrote:
> Hi Heiko,
> ...
> > +	for (i = 0; i < nr_pages; i++) {
> > +		pages[i] = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> > +		if (!pages[i])
> > +			goto free_pages;
> > +	}
> ...
> > +	for (i = 0; i < nr_pages; i++) {
> > +		if (pages[i])
> > +			__free_page(pages[i]);
> > +	}
> 
> Why not alloc_pages_bulk()/free_pages_bulk()?

That's because alloc_pages_bulk() contains this:

	/* Bulk allocator does not support memcg accounting. */
	if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT))
		goto failed;

Which does not work with GFP_KERNEL_ACCOUNT.

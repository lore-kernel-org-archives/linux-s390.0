Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0EC4E56CB;
	Wed, 16 Sep 2026 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563987; cv=none; b=IV23hvIJRDwkHyoxWA2MGgPmFo8CA4RhflWPUqmj1w1yjd3JEksuNk7RqhHDKC6SKzwR1uT4urDQn7HVGIegW89eepAbdRHbSvShUhIr9ayQFubjDdJN2QEpa+zSjRJpAMgesEQNrlk9XgRbBqgq8ZCrwzvUvUiy9cmUzF/btYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563987; c=relaxed/simple;
	bh=OUBiFLESNee+9G10i63Jn7JGR3GrU98MhmR17Ae58gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdosXj0wm4EE84UnROTvKy3Xc6Ziq0GztkzAisQbV7YX+5+0PsC0hNZ1h/VHmJrRSGJddEMFgq0wr8uq5Wl0Q1KCd91zfLbf06Ht9679IGzhf4amLbl6WM0TEEi+mGB3277OwIENPYT17VgjHrLGrL0STQW3l5sZ1SD/r5dwqp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QYx6XfSc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QYx6XfSc"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GCVmvC3793176;
	Wed, 16 Sep 2026 13:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=QNWO4sF6JJSPgCQ563b79471qNq7+Q
	ih5/QZYS1AokE=; b=QYx6XfSc3srQiZUA0BAaWTxH14xH7+An5XfuTY8pdxtjqu
	IUEiBndkQxbYGi4rVDTqMHgJ7eUUgTPnJzYMIGzE8cpO6xeIWk5UWlkzLTuEUQSj
	P7lRhObGO/FnNL5FIU9Jjf6onnQetNKy6w5XhItuYNl5+4tQ/YvRqImgMhrBQK/o
	p7BBHaGj9MX6WRVimd98xbo9HQAAV9Zp0FltQDAtb3850XbeVHKdV3lkn29VE8Ia
	UBRkcb72TIW31mP7lQzheOdp0+sOXAoLz0f1vpWFNM7XAOZULGd23AZZdZinLUBL
	2HRg4O3joIje4kzi4Z87JHWZKj4wMEwS+jrNsMHg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcv49hg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 13:06:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GCZJW41491467;
	Wed, 16 Sep 2026 13:06:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpywexefy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 13:06:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GD6FEq44040464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 13:06:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0CBA2004B;
	Wed, 16 Sep 2026 13:06:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E5D320040;
	Wed, 16 Sep 2026 13:06:14 +0000 (GMT)
Received: from osiris (unknown [9.111.77.138])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Sep 2026 13:06:14 +0000 (GMT)
Date: Wed, 16 Sep 2026 15:06:13 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 00/13] s390/cio: replace page allocator calls with
 k[mz]alloc()
Message-ID: <20260916130613.15587F91-hca@linux.ibm.com>
References: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE3NCBTYWx0ZWRfX+o2F8YeFAktz
 +yDxv5+GTeDFJLw4b36D3SahaOWlvmwAiGvmVWpq3YtVZ4Ab91rDjKsi2owL7F0cgRBE3RvCFLm
 hBX6YSEGESg15p+MADmY/mT066iypR4=
X-Proofpoint-ORIG-GUID: ntCVBk8ZFkXutvp8Zb1bdGyaY_Ijiriy
X-Proofpoint-GUID: ntCVBk8ZFkXutvp8Zb1bdGyaY_Ijiriy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE3NCBTYWx0ZWRfX6TPOHMSh5PrQ
 kpLWSj1DtAS4wYJKW4LQKxhYjs35yDZhjcCfP/IRU6FJzfH8d7tHHeStz1cS723nLZdfH6s0S+N
 L7RqCAD4NrA0vWPwJAWSe1YxHqlN+qruoUI2KCfHWvYoM6pW01kWWZGuUdSOeY0QDr8xsX11900
 TZ5XNM7b+2i0QEr8aoiqyg+BE9VNpcw/apptpZXqZGwfj/qm0YGCQVF7iLSGhOsgbtXC7PKD3Dg
 AhWRAdOg6aLjkpcPTqa20qzPCxh8BtDZvJZRy34zmhYawlezHuBjrwHpGD2iXYdjg3d4Ao8KLwn
 DkB36jz1YogN83fwL/zSXEs8gffuOcTomsBRkGHyPAOwIkQHlpOyQpNDE7iGkS1ykNkKRpgq65P
 aFD2XvGkNTYymqroFeXIzK0oHv6o/X3L9q3CCcWtG6N/taN3FLR26PP3tpoBa0E4eL6mdg19omQ
 zPGwUMpeL/WvXfk/pcw==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aaa944b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=ZIp3wtoaij0CHaT4FdYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160174

On Wed, Sep 16, 2026 at 03:03:07PM +0300, Mike Rapoport (Microsoft) wrote:
> The saga continues :)
> 
> This series covers CIO, QDIO, SCM and IDAL buffer allocations.

...

> Mike Rapoport (Microsoft) (13):
>       s390/chsc: Use kzalloc() for CUBs
>       s390/chsc: Use kzalloc() for the SEI work area
>       s390/chsc_sch: Use kzalloc() for CHSC requests
>       s390/chsc_sch: Use __free(kfree) for synchronous CHSC requests
>       s390/cio: Use kzalloc() for CHSC work areas
>       s390/cmf: Use kmalloc() for the CMB area
>       s390/idals: Use kmalloc() for IDAL data buffers
>       s390/qdio_main: Use kzalloc() for the IRQ structure
>       s390/qdio_main: Use kzalloc() for the QDR
>       s390/qdio_setup: Use kzalloc() for QDIO buffers
>       s390/qdio_setup: Use kmalloc() for the storage list
>       s390/qdio_setup: Use kmalloc() for the SSQD request
>       s390/scm: Use kmalloc() for SCM information
> 
>  arch/s390/include/asm/idals.h   |   9 +-
>  drivers/s390/cio/chsc.c         |  20 +--
>  drivers/s390/cio/chsc_sch.c     | 300 ++++++++++++++--------------------------
>  drivers/s390/cio/cmf.c          |  11 +-
>  drivers/s390/cio/qdio.h         |   2 +-
>  drivers/s390/cio/qdio_main.c    |  23 ++-
>  drivers/s390/cio/qdio_setup.c   |  14 +-
>  drivers/s390/cio/qdio_thinint.c |   2 +-
>  drivers/s390/cio/scm.c          |   7 +-
>  9 files changed, 150 insertions(+), 238 deletions(-)

As far as I am concerned:
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

Waiting for IO folks before applying. Thanks!

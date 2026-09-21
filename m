Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8775846983E;
	Mon, 21 Sep 2026 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982168; cv=none; b=X3DYhvohHsCyOCtQI41S6h3XEqwPZwsVxZS1Vn95eLdkFpSKp/EexcXgta/hn+DlrhVE9hSB/n11qrPHvEG1oxUCXOGISQKL+7GtdBlMuxwFpaVhACq3ekXhv4lV84M6AWSjp9MtBaIV+9jHr5pYyX1ZTQ7UXhhfR4mi7Y/U3wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982168; c=relaxed/simple;
	bh=2+8NrvDpjLPpdYxh3uMpv/1JipjmFhrvDKunqqKN7uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDfva+CPoE1M9mTZZGu/6UqEzxtpOsITbovhI4d3Y52TmBYtYtmKFjXoBrB6YqbyqMCusYU/ze42VkBKf+JsNnh740oj/SW7K3pcGVsW1SInJVD2Waav23CGo1Ucu95uuINiBTb3s/860C1fZ7fhs0Riesut61Gu1l4+oHnKuB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jmD+VfWq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jmD+VfWq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZUuD863160;
	Mon, 21 Sep 2026 09:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Ag5Jep3N2zc3pAZE+xB5+uhLv5hPUr
	/nqXu7cMR2+vg=; b=jmD+VfWqly/wJxcZmYGZ93lBi97JfX1FJ/i1Ah+BHYAf1d
	sjhnQqqtBIZmKEKaqyNNypU2Taz1YF76FUgGuu5JpDVZL822i33jmcLz8jFz5fDi
	A294s954cR8ODMCpAeOqs4rZmOjpOYSsMPDl6ApvRsScEyo/gNZDOp4+2kACsCUC
	UsauLz4dhHyKRlvbi9x0oqcwgX3IVNKwUmgBl8tD2N/dQ8EVbnfstWUB7vexna1d
	6wFfiYqEc0+FeKGy201mztCEaVR9ZOD7yZlvczezdLmX9GPRBhVl+4QeDALXLxaj
	pKEokX0GKHwfvrPZAqqIx7xPOKMK6WJFyzHdtnwg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskduyj9q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 09:15:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7Hifs1835697;
	Mon, 21 Sep 2026 09:15:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy4bys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 09:15:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L9FoZD45154706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 09:15:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E975520049;
	Mon, 21 Sep 2026 09:15:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81A0A20040;
	Mon, 21 Sep 2026 09:15:49 +0000 (GMT)
Received: from osiris (unknown [9.111.14.239])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 21 Sep 2026 09:15:49 +0000 (GMT)
Date: Mon, 21 Sep 2026 11:15:48 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mete Durlu <meted@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 00/11] s390: More this_cpu_*() changes
Message-ID: <20260921091548.9433A66-hca@linux.ibm.com>
References: <20260921084005.4022574-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921084005.4022574-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oE9JNTFy4KkUP2s8deJHy02weHyHNfAX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzMCBTYWx0ZWRfX9+0EPcwmjZGm
 dsZZtZgdeB+YneBrM5cGYeuOS8e3lmvsAwBn97nPj/utRcVP1quP8vW4SvZeEw0AYttEgRbWyu3
 eovzxn3UkvgmzPZaWh3HHBzc8kFBWnk=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab0f5ca cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=fNzBTV0gexBZmlcSxmMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: oE9JNTFy4KkUP2s8deJHy02weHyHNfAX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzMCBTYWx0ZWRfX/Dew/jzx4rBb
 PirUjgYyl3WE2dL5o7qfLLVdK8f4KA1lkyrKbrz1e+O3WBb6Oep2gAM7S9Unf/5g7fqoxeTf44K
 kfddsxpefpxEpJT/KlJ6oh2KSQ/rEYyRKqfddKOO2FBEX1wtQpdFQtYZBjJAU39uSUlpE3znzzF
 WbJbr9wlfKgUkbFbcBEMKR1DV+o9dn7f2a9fZCQmn7ephjZfFnRIu2ngHmExe6dn6Hwc8JpUilA
 CtwwFFo6oEF+GKvNfujxZnv/Leldm+jM+w+m2WA4y4Rf3mM5eh5c2/Wu9GXkQSz40j6e7gUf21g
 KrVFcs9RV1wnE4ZMJWxvkwO5yzvjeRUvhygXFAAOBIolJ388XN6YNH2GCiwW1sZfVH87zz0uc4P
 AUpkx/GiLvg1uQ1RSnjiGmKMiF/lURCGWk0n65X6AGNdjZKFNioOJo63URMulDfutWClo08bIbo
 GPVFVHEYXk5Z6CcpATA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210130

On Mon, Sep 21, 2026 at 10:39:54AM +0200, Heiko Carstens wrote:
> v3:
> - Add various sanity checks to enforce correct register usage
>   [Mark Rutland]
...
>   s390/percpu: Rework to simplify percpu_entry() and percpu_exit()
> 
>  arch/s390/include/asm/entry-percpu.h |  71 ++----
>  arch/s390/include/asm/lowcore.h      |   5 +-
>  arch/s390/include/asm/percpu.h       | 354 +++++++++++++++++----------
>  arch/s390/kernel/irq.c               |  10 +-
>  arch/s390/kernel/nmi.c               |   4 +-
>  arch/s390/kernel/traps.c             |   4 +-
>  6 files changed, 248 insertions(+), 200 deletions(-)

Please ignore this version.

The checks are still not sufficient, and there is indeed a bug with
register allocation in the last patch which Sashiko reported. The
incorrect register allocation happened exactly once in my test build,
which explains why everything worked for me (tm).

I will need to send yet another version - sorry for the noise.

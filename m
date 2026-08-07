Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B794A432E7C;
	Fri,  7 Aug 2026 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102146; cv=none; b=GJjlrINpFG+BOhDdw8TX7TJpA1bwGSu2+dwK7/sD7D/ocgIQeOcnpjpMq1vYk6dP/bssQMZ2MX4JA2WE8SzToimoQB+3M2YxLxL0xaCytwhI0K3XxuemQmC80aFR2pUkXGXuXFmDHsBqRVVe+PFTUdVj2i/l/cTcJ9hkggBfYGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102146; c=relaxed/simple;
	bh=Q8YfH7X+oS+bLr2Dr0CNiHvw7PxU0hvxRcKvBg45lv8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUBUPNH/bARj0oRYOGJe3PVZmrwxvo8nBSgl1OhNWog+g7hsaYY/R3HsYb/EzsKqFl0EVYhdY4rYLHEiD3uUk9upuf4ixvQqeeY2Qgpr/2lwyW3KeDg+tjeWB1U74kcD4UPgG47W0TdCZ4WJMiGvOXJvJgm8BOGEq1Mk1kYJR7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c1uBUxaS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c1uBUxaS"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HrNc4134317;
	Fri, 7 Aug 2026 11:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cCpbx/
	ZsnRrdyGagm9TlMoqkhy6qVucs9ID3v5Bnd3I=; b=c1uBUxaSs+gfW7RtAnTRv1
	WxRhSeRTUf4g6zd/oM87Wpt3mCwCfHXx6HPjphB3LAwM5CHI0zIq5UTdfhbUItJL
	KzpRIbHfvkxzx6DmG4qL7VsYSneyHtYdbJKij/3lldlexpoZLzkxXsUwLRSHPZD2
	9u67GZ1JWt4TMiUrLBpsig87TkFlD17g6R4GG5QivgAZ3yjxH4tJFQpGPpx8PGd+
	GIfhFTubzmUm2II7v7uW6mYm054aZz6tAFAtcwyLCh6U/gVdfVK7xrEFQLglW3it
	oM5V6o8oFvt1ALeaVUJIimqI0K30vSmodVzlFQCvPU6cyuEaQd9U/n65CeKUqmgw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy043m78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:29:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677BQHLe019965;
	Fri, 7 Aug 2026 11:29:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qyjyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:29:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677BSv7S50069876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 11:28:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC3492004D;
	Fri,  7 Aug 2026 11:28:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83B9A2004B;
	Fri,  7 Aug 2026 11:28:57 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri,  7 Aug 2026 11:28:57 +0000 (GMT)
Date: Fri, 7 Aug 2026 12:59:25 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christoph Schlameuss <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand
 <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven
 Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        Hendrik
 Brueckner <brueckner@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH 1/6] KVM: s390: Remove double 64bscao feature check
Message-ID: <20260807125925.008ed24c@p-imbrenda>
In-Reply-To: <20260807-vsie-cleanup-202607-v1-1-b18659b55e3d@linux.ibm.com>
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
	<20260807-vsie-cleanup-202607-v1-1-b18659b55e3d@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfXzaFnMsYFJrQO
 vSM03eCw7i2gchRi+Hcczflflmzs/vI27OPj1tdDbz1Tm5tT9EjAeS+ItfKW/CrJEoNH0t5s7jv
 hVp0krd8SP9TdelqdDTws523wm721cPvWRoWdHATwNhAY0o4KFx+38SkOBD6imNQJygKl+kwy3B
 FM1lvb5MyADbpYB+rLO7gqHyYMnAksuwTYtu+tseKzXZxFC14TBz8UF5BA3hA7YynFrmQ+4IHoJ
 Ty5jMYHoZtfGOLZvtNUSpIEktje3et+jOnJaP1rHwyZfpOmee4f6xEZX+2Zqp7xvbxE0cP+25Az
 yH0bFKKlAUHeRkG/aN8SZtDpP82JEbySaQtmwVE8mM5v9b5eH8TdD9nARyh/C9Wo2ej2uNQCd/T
 0HibloReE1JeG9S9Cv+E4aux4m0fccbA+zxPtrUQ8PYfQSdnSVgv40vdDIFJMAVlXlQ376hMtiw
 Pq1DAZkgfPsz2bqtvKQ==
X-Proofpoint-ORIG-GUID: amAtga2zBq3kel2Of_9pwHd09JUnpnZW
X-Proofpoint-GUID: amAtga2zBq3kel2Of_9pwHd09JUnpnZW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfX3wqPFa3AvdUJ
 XK671qdT/SjPZz1kd55Z/m4gtFYkSfgGkJNlscsiGc+gkrykrtx9y1UhO6lA6wJoSZxRnntlLiY
 3GzxNNYl3b3rJrGUePz86XGZwjle/YQ=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a75c17e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=G2unJUWrhksDkq23Fi0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070087

On Fri, 07 Aug 2026 11:57:42 +0200
Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:

> sclp.has_64bscao is already verified in the guard clause a few lines
> above this. So we cannot reach this code if it is not true.
> 
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/kvm/kvm-s390.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 150b5dd2170e..c679d8f83c0e 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -455,8 +455,7 @@ static void __init kvm_s390_cpu_feat_init(void)
>  	    !test_facility(3) || !nested)
>  		return;
>  	allow_cpu_feat(KVM_S390_VM_CPU_FEAT_SIEF2);
> -	if (sclp.has_64bscao)
> -		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_64BSCAO);
> +	allow_cpu_feat(KVM_S390_VM_CPU_FEAT_64BSCAO);
>  	if (sclp.has_siif)
>  		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_SIIF);
>  	if (sclp.has_gpere)
> 


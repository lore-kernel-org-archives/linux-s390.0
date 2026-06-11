Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFEA3BADA3;
	Thu, 11 Jun 2026 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781176695; cv=none; b=jI8952WoCF5DaDnoVaVYHIm+6X7HyIki3C8Hbrysb3fFAOL4fn0+pJPc8ByAFqR8y+lkOpm1U2WFMYWzrT3Y0Lj0bzgAxn9pBk/r/BKIR9M+AToeJUTgVdojKNs1XxH8ierHIg8LDNP9XUTCSV8g9jD1DzOPk9sAWTSTelDO/QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781176695; c=relaxed/simple;
	bh=oc9KhMdfcugf5aWfH5yguODUPYLhY1Uk1y4qaWzLAYM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zh4CIeS6FxXu7hTh1Mo9YdNFQeFhS2S5REcJhgBM7RDVDDaHFI0tUcpjTOTt6TvPXoDb8T/QAAcD2gTne4aM/8iKaDj/GIxDNh+UTNXpMrorwc2uzHwWKHh0JDEmt5XBTbcpZWU1Kwz0doFGed6LttfpFejQ5oXbEvWbxbnb360=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=saVxodt/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="saVxodt/"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJu3BY3872821;
	Thu, 11 Jun 2026 11:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KNLrZd
	m5gdH0V5JUGY9ETwr/c5aC9Q1VpXOOT/ua7zo=; b=saVxodt/kq/Ci4no4vMw5k
	nAXvFrqOvnRrkL3jXNMN/AUF9Z15nxXtZkfOnOPY46RvgevErQ24qhL4y2USTDkw
	T5pbBv7xoamU7UDwDYFm8vYxRZWUFYMRl351orqk6KAeaeZFFcTVNjJL3lq1sGQm
	G6jBCaZ8fFgw7TZWZAYDW+JZsXeX5u6NTmrC1KtMmFxMu0bKWR7FixK7UnfjdTUH
	ytv6VyR3PMVq0a8GO6+zFB9gJlHeO54yn5jIscP6/nf0cEJoNhWjHiLZgSYNC2+K
	Vy4Kyh7GZtIVemog9fN5Xxgm6T0pfsZRhojIgLBpsGEqs07n6J6PgLT3farWZCFA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8eu246-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 11:18:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BB4b4v010878;
	Thu, 11 Jun 2026 11:18:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09jw2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 11:18:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BBI7EC27460038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 11:18:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C524220040;
	Thu, 11 Jun 2026 11:18:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1A042004E;
	Thu, 11 Jun 2026 11:18:07 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 11 Jun 2026 11:18:07 +0000 (GMT)
Date: Thu, 11 Jun 2026 13:18:05 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        David
 Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: s390: Initialize KVM_S390_GET_CMMA_BITS memory
Message-ID: <20260611131805.58d60613@p-imbrenda>
In-Reply-To: <20260611105036.11491-1-borntraeger@linux.ibm.com>
References: <20260611105036.11491-1-borntraeger@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExMSBTYWx0ZWRfXyqtdXXs3NZ25
 CWQluJP5mkqTF1lCSNJR33oAmXfrHPUrjVCtwhYv0e/wZsaJ4L9Eao/6+aEqzBdDuVQp20IRF52
 h/TYwazfDl6mp1Idk/ObTdxA18OzYU85vEuKxetRkMPF80EBcucIFTkn+R0rgHwMhIp6kl1dOwa
 NwyOau1GKMPZ/rVAfJ7ESiTpa2MO0lez+dX0gLmfK6+Tmlrli8LwCvQztei26FYGay+I9VvkjO6
 zzomwNeW5v5C9MpCme46gLBQX7b5M3sztZle8dyX+sfWHUg48OXKoIQI3rxbHFxkpKPVrlo90mD
 t3tBGIVPeHBUqpHjWNNB16PXpPvxR0TJgJ2FeAWUXprUTBtztsGRXR6QeQH6SbLxtOZdFL4lLhD
 +A7khODrlfoVTiIU0uIh/kDm63B6xMexvPFBEH/Duol6lkPHXqlAqN296f49WAH0w+TU1ym8Hm+
 VzDftc37MnmAWREFcqw==
X-Authority-Analysis: v=2.4 cv=dr7rzVg4 c=1 sm=1 tr=0 ts=6a2a9974 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=VPH5gqUGor3fcHHDZiYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: D-qF7_5KEpgCIO8EroAZdf-LSlwPb2Zq
X-Proofpoint-GUID: D-qF7_5KEpgCIO8EroAZdf-LSlwPb2Zq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExMSBTYWx0ZWRfX++I1ek8woBJR
 dQmwGuv/JCnu81RtrxH76icUuUfDiDzuYTiUwLGG/WhQTP4gYcFmb9LloXiSFINpcRDQCgCfMbI
 rgN8BMZmQvcsTbicnr0ol8bSkJZwoPU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110111

On Thu, 11 Jun 2026 12:50:36 +0200
Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> kvm_s390_get_cmma_bits() allocates its output buffer with vmalloc(),
> which does not zero the returned pages:
> 
> 	values = vmalloc(args->count);
> 
> In the non-peek (migration) path, dat_get_cmma() reports a byte count
> spanning from the first to the last dirty page, but __dat_get_cmma_pte()
> writes values[gfn - start] only for pages whose CMMA dirty bit is set.
> The walk uses DAT_WALK_IGN_HOLES, so clean and unmapped pages that lie
> between two dirty pages within the reported span are visited but never
> store their byte.  Those gaps (up to KVM_S390_MAX_BIT_DISTANCE pages
> each) stay uninitialized yet fall inside [0, count) and are copied out
> by copy_to_user(), disclosing stale kernel memory to user space.
> 
> Before the switch to the new gmap implementation the buffer was fully
> populated for every gfn in the span, so no uninitialized bytes were
> exposed; the dirty-only walk introduced the leak.
> 
> Use vzalloc() so the gaps read back as zero.
> 
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/kvm/kvm-s390.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 9fb8ce45eee9..05f8a8499701 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2247,7 +2247,7 @@ static int kvm_s390_get_cmma_bits(struct kvm *kvm,
>  		return 0;
>  	}
>  
> -	values = vmalloc(args->count);
> +	values = vzalloc(args->count);
>  	if (!values)
>  		return -ENOMEM;
>  


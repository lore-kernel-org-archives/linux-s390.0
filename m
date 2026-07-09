Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB953BB9EB;
	Thu,  9 Jul 2026 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584961; cv=none; b=Q4j1U/bTRhVns1vITadstmdDv3SDkHGRKQ9smJ2O96iaFDp6BtEe/7xRT/OFwUAgV3x0+3XzWY6U+Qwv3bMdrhQwZKe8nv1jXykRBHb5oLFBa3Z5jTadTHNvuxyv2TEVDZVtWHDlIe/6BhnTjhNYKlkLYCzXiZg+tlok1dLeP84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584961; c=relaxed/simple;
	bh=fEQwAeU8zTfy3uivdYohB2m26gCS5jlN1iq4q2t+zFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kicq6Bfjsv/jvo+p1SH1AY4MyBVUBNjrAQoijPWwSFeiDPm/HftTFF5ZVQjG2UzmoyM5FSqlq1bnxthbnIG+wukP1k0UVjS7vRTbDEH8RSNEq2DVA6vbDZ79tufWfJVw9k+g0Y3bMyDDOwNNH4TUeFcqBDZ4xtfC5xxRdqDXfMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NSLbevx3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NSLbevx3"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696IaeI1897829;
	Thu, 9 Jul 2026 08:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hzWblM
	bR51EsQC2E09Yc431rRlRCID5E6VgOjNa+ZuU=; b=NSLbevx39oCK8SOEbtx3NC
	L0ukBk8KtqHXHrOFtb7feGRGhdJrtMAr3VAp5aHHxEI6zsY/qBB88AdBWIP0Nx9Q
	rcpq0a9gWtYl0Px+RrUMEUY2zymKi8Xru4w1WnGUvkIt8vNkRqdFb/TiYXja3Jd9
	CCvkHL+XpbG+yTsYAJHH5UQ1u6YDH7Z/4x+rswdLEL7Dkv2VWYpK0xtWxBTFqmte
	OdmKfkjzGXCLGlO6XUcFzN+zxrViHk/aeBqEANmBeMep5pI7bPAJOOnB71GXYrD7
	YLtEJAMs9QguPiG9vH6xVNtQiF2cC+ciJDrC9LO9F8F4XIUY0OGZBWaoHc9WIyvg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur0erv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 08:15:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66984dlX023459;
	Thu, 9 Jul 2026 08:15:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgkc89m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 08:15:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6698Fq6p39387534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 08:15:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A07552004E;
	Thu,  9 Jul 2026 08:15:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A8252004B;
	Thu,  9 Jul 2026 08:15:52 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 08:15:52 +0000 (GMT)
Message-ID: <3c07df88-6d8c-4d2e-b697-95b085787ff8@de.ibm.com>
Date: Thu, 9 Jul 2026 10:15:52 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/8] KVM: s390: Fix return value of
 kvm_s390_set_cmma_bits()
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260702152406.204782-1-imbrenda@linux.ibm.com>
 <20260702152406.204782-5-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260702152406.204782-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA3MyBTYWx0ZWRfX7XLpwWokVhGJ
 E6NSWoS67LUHRDdLYh5PgaJ3M9c2Cm9x++2HJBQNnt5zKUIot79bLzF3pblPuNmaRfh9GBV+XGl
 0N/oyPocuKaNd5VwYmSw62AWMrGdAq8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA3MyBTYWx0ZWRfX+H9EfQAmMPQF
 cHfhgM6U5hW+aRM4peyXPgPp/TUI6HGh9kpf0k9URYQ//8R8/r6rFibwT4hXENgkqT6bRiAq7T8
 kSxQj9c8/C9K/jbFToBP/c+iEKoI8qPlXD1b8EqEhxDn/XPURwAaYn/0pkZ4FSaHP1vSIDkl5tl
 GIOqZ7tc1tyRCoLus2qqWYTosztZBtQgopay5wtaAGVpRXSYRIUbHA2/EKlml1jc/9SSWo7eGFc
 Fbmsafe3mnGoE+Ow9R+ZFhthxQNadcvuqvBz/CWkEdwG9FwNBhs1hMBqEskIZBAT60iijTWAotn
 VktW+fUmJZue9ER4RYQDI9oI+06CmiZy5tf3CuS3DMEAa/mT4WHbDTHS86jofDnujgdYc3hU6RQ
 uys6ZNa9lLRd2yQ4TCa9RNZvUXS23V0wTKfYCcQnJU49lWZKa8M4nd0EIif+hqGQbBLYBsnTYIX
 k/+Dpt5bKVekm4lZxVQ==
X-Proofpoint-GUID: sGXZv-fkYVRsnQ0L7hiadufRNiZWQIQy
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4f58bd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=pCTlWr4eTs1s8Ph53O8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sGXZv-fkYVRsnQ0L7hiadufRNiZWQIQy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090073



Am 02.07.26 um 17:24 schrieb Claudio Imbrenda:
> If kvm_s390_set_cmma_bits() is asked to set CMMA values outside of a
> memslot, PGM_ADDRESSING (5) is returned, instead of a negative error
> value.
> 
> Fix by returning -EFAULT whenever the return value would be > 0, which
> is consistent with the behaviour before the gmap rewrite.
> 
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Not wrong, but should we fix the documentation for dat_set_cmma_bits which says
  * Return: %0 in case of success, a negative error value otherwise.
  */

or should be handle PGM_ADDRESSING there instead of here?

> ---
>   arch/s390/kvm/kvm-s390.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 784f7d9c79c7..512c81eee068 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2384,7 +2384,7 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
>   
>   	set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
>   
> -	return r;
> +	return r <= 0 ? r : -EFAULT;
>   }
>   
>   /**


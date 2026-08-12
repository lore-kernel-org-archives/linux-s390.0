Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8372833556D;
	Wed, 12 Aug 2026 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518139; cv=none; b=JZccyLi0cT4Nd3N3KjW4jBrv2s7FGgiVp2tS7RSl3eQCHCKhL9BxomE1W3fLyTyHatFlzUTbwybTSvxXNtqXpq1+sddbe0L4NwIwMe0eHKgvS6YOZO45Fa8Pi3QOjShQegVnCrnsbhhPKj2UP3tlp5Iq4j7YvvlZMv+Yxq4af9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518139; c=relaxed/simple;
	bh=dHYATjJJ+WNqjqoTLb+lO2lEAc1PAu1SabcgDUbtirk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHErZ4OgIcodBoKi4Yi16gllPqgHQHb8f67Yf+1o9NwAig7ZKhIxXe0zJ99UHsdgeWXuhSSutekyEhj2+Wf0zwq1eQWnuzV/p2rlxwXkB475zetgjpc0GVuQORHcQslwEaSAOypbGosSVx9DLN7BxOUaGz9bqbunqq78fPe555Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oONVI7P+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oONVI7P+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C63PLQ1580881;
	Wed, 12 Aug 2026 07:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KGiR1c
	HK0dsTKDZ0fPqjmNwgXO82p51xLp+Ao9d1om0=; b=oONVI7P+XRT7fsAJYNKBVS
	aMvHk/297W9yn6zs5U8HkHiwuvc5aWnpTGBZahO7ndBy2Di3x/wwOoUIimLDWoom
	2Eojz3PAtP4gqG7pqDH9QJjE3ARU2Kq7qFEOq7e/4mo9/F+QrX0TeXxzd0znoG4S
	qrgPYzd1psvtLWmy1JFv+PcbSSgCjN+uDbJDgyL8nqjDmG2TWqn5mvBmavZysLeK
	k090VaW6t646kmoPXO1zlk8BTP73gRIlom6DXdzeUFzNLdDSWQodRwcxNVUyZy6L
	bjz+EGKnzHXofpuU8028/TDWA+Z69E6nkMzjvEgn2Q/QaPGtTWHawGnhpdMYzE0A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23suba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 07:02:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C6uQgZ015799;
	Wed, 12 Aug 2026 07:02:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w51rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 07:02:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C72B2X6881772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 07:02:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E358620043;
	Wed, 12 Aug 2026 07:02:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A706120040;
	Wed, 12 Aug 2026 07:02:10 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 07:02:10 +0000 (GMT)
Message-ID: <bc6e44fb-67d5-4a84-8ba5-20b866b5473c@de.ibm.com>
Date: Wed, 12 Aug 2026 09:02:10 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/11] KVM: s390: Properly handle NULL pointer in
 dat_cond_set_storage_key()
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260811155641.219777-1-imbrenda@linux.ibm.com>
 <20260811155641.219777-2-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260811155641.219777-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7c1a77 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=vhqekoQfE-IZdy2BCykA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfX+vUdJxu+83rP
 jrt1ii+gIinwuY5h/liIrj61EGr8DHTX3MB0YrViKhfINheRuZEIkOd017Fu3Co3zFJk62S5GYB
 hKY8m4SmGnvAhr2XA7Wvl/V1l0REIrbJZehs3Cg0e08gJj6+DR4Crv6VFulido8lHYUz178YTxI
 yiYnpNagrFD2H312N6vZF8OJeuSVq1UtVBqZ01qRWlWsIr2V/RSrjrzwID3UUhwOVoZpkxaiedZ
 TIxc2hV3bSUzhBQ2SeMZDzsTjy6ObhXRErZt4hIZjai+IQV4KPjib4HIBCzcSnKIt0vOHmPnX0n
 zN1ot8bTWZCumEo1lvN2BqOVBM4/0lQfpUToivfu37Mhzk0PH5Ob8cZ277EA1//hKH3tBBRDeWq
 EoBtnZlU15VmemsiK2FI6flQ6nLbGZJFYJxawRClj+AJ3j9hpYbdr1ywdZWGR2KVJ0xbUUqhLJf
 XSTSiap6npk4s2BtSeg==
X-Proofpoint-ORIG-GUID: ajaEHEY4RZqGYapkGAvJWVFSwOY3PDE7
X-Proofpoint-GUID: ajaEHEY4RZqGYapkGAvJWVFSwOY3PDE7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfXzKy/lMBJSNN5
 3TmC6D+C5RVTB3e92JtruaXfV0fw0lWyFkF9g58Djifks3Mhy5Wx5k/xYVrlo4NyeQA4YAeM6Wa
 zZ1Pkjpg01o4sXizYiZa7A5gEdXSp84=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120054



Am 11.08.26 um 17:56 schrieb Claudio Imbrenda:
> Some callers pass NULL as oldkey. Calling page_cond_set_storage_key()
> will cause that NULL pointer to get dereferenced.
> 
> Fix by checking for NULL and assigning the pointer to a dummy local
> variable to avoid crashes.
> 
> Fixes: 8e03e8316eb2 ("KVM: s390: KVM page table management functions: storage keys")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

the whole thing looks a bit complicated, but as as fix I cannot see anything better

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>



> ---
>   arch/s390/kvm/dat.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
> index 3f2d6e8902d7..165c704fcf29 100644
> --- a/arch/s390/kvm/dat.c
> +++ b/arch/s390/kvm/dat.c
> @@ -722,9 +722,12 @@ int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce asce, gf
>   	if (rc)
>   		return rc;
>   
> -	if (!ptep)
> +	if (!ptep) {
> +		if (!oldkey)
> +			oldkey = &prev;
>   		return page_cond_set_storage_key(large_crste_to_phys(*crstep, gfn), skey, oldkey,
>   						 nq, mr, mc);
> +	}
>   
>   	old = pgste_get_lock(ptep);
>   	pgste = old;


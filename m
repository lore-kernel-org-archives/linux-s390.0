Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CC5431A4C;
	Tue, 11 Aug 2026 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786468100; cv=none; b=oGZQhZZCHEdyHcpaeqb+SZat+2TL93D6kX1M0bEDIn4rUhlnMujQ4bn+qhDpMYo6nZ+6w+qCOPOu2tDUWpQwQ6z0WzfB4w0vfSUvGQfz2Eo6k0LjQeQGl6VyzW8KU8xzyfjURHZd2uVUgMvqN+ofs7gWtf+kKpMYU2d5j8z0D0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786468100; c=relaxed/simple;
	bh=mDAWd7pESTSmTnmAJJHnYg7xYIZrhdvoMH7KIlPDVXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qc6JxpAQRt0CZNfmBvoB00WRSbHh6YQ6xFp8CedLrX4+bUmQU9lL1g9Wo9jgr7STgF1ql+IiKBaJwsQ9FuywFGsIF41S8ngJzbhhVSGi7+acilcTyLE2cNA6a55NputqDWUmVRvzIoiQUxXNUNDMmkezxOHdZSh9bdxroj7z43A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LL0pTM3b; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LL0pTM3b"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGW2Qi965145;
	Tue, 11 Aug 2026 17:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=flgPDw
	4CtiGTq0TDev8OVpLLV8udGJS4JPfYQalsTfg=; b=LL0pTM3b/OFgrRsD/maiID
	zxEIeHtgcbyTRkY6DsL2tvKLyxkbtXhWIrke9mNecO7/ZIL/tgDYSbbUOuU2tv7k
	TbsYqj15gUZMvPDOh8wZYkU5Lus10gBYBc1zvJAKlFzkktjInLP/lF1ObmK2ONK3
	6WK9ctosc72jKNk6tzmA90IzuFD7MsAPhAjgvqvNWd1qwz1jy6IEQgbyK45wcDH0
	4Ls7xOFAW+/t3sB7vOqrnw9KS0fbbeT4HJ358Pl/i6z0gcjy5DIW46c7eNEMOfYX
	Sn8Uo9Ss8g+vkAn1WU2geyiXaBSV0M8loid0UME5lPe0j3e1tbIczmSKcfiQWFwQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw5ekk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 17:08:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BGuOmG010608;
	Tue, 11 Aug 2026 17:08:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g9s5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 17:08:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BH86AC34079008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 17:08:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCF7B2004D;
	Tue, 11 Aug 2026 17:08:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56A8120040;
	Tue, 11 Aug 2026 17:08:04 +0000 (GMT)
Received: from [9.111.66.26] (unknown [9.111.66.26])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 17:08:04 +0000 (GMT)
Message-ID: <04103d5d-c381-4f19-8701-d2d5b4702552@de.ibm.com>
Date: Tue, 11 Aug 2026 19:07:59 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/11] KVM: s390: Fix pgste_get_trylock_multiple()
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260811155641.219777-1-imbrenda@linux.ibm.com>
 <20260811155641.219777-6-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260811155641.219777-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7b56ff cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=kkBAQRtnjaafe31RCVoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8F4RdetSwew73jERyq2n4ma3BvnxpTOu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE0MiBTYWx0ZWRfX9PQEvfhrj0bZ
 LrB3Fi6T5B67jtLPyyXIP1e/mxNwaHocgbZAthh0RUzj6+wRLzFApz1Ed1WDhqJH/CGSGqknRZy
 IshMvspyl0A/L0tsBjgraKiuWTYci0wZc4bJDSEXMnQh9Od8RyhXSN3LoxV+1denRFcOcP5whth
 LsTQzZ+orOI89pvV1jNyhgsT/fVAZl/MY8ugaYy7ZOWh6cU4TjGWg/R2CfVfFTVHKcRTdYc5qJ6
 TEOmJWD/VctVsQKKDEM/z7ucT3wpIvHWxu7sG+f3rMPHEa0ZsY7UAkYKBbNeVHHoYrbv5K8tNOf
 fjFHX15yXNY2FLOAFwi1sFgaAoCptMJ7Y794F94imcP6bzgW76zd4KF5+ekv3Lk92a9Vw5ne7Gq
 8x228RImNqr6V50434Lk6bQ37EtcWBt80xvqDfMeFxaY9W8hYsOOt7qV6+2iDR4siFFkJK8O0eP
 rrZASMIqjs8TF3fSFPA==
X-Proofpoint-ORIG-GUID: 8F4RdetSwew73jERyq2n4ma3BvnxpTOu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE0MiBTYWx0ZWRfX1VflBsbX6ftu
 wjNKqKfX/lplHd3tNFkz89CCoIbir4nmxALvjmskg0Nm4N4jZfUI4dfGtV9fsFPGKhb/UThLDAr
 SsdmgEQpfW0ummA6bi4xJCM6f+F6Rcg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110142

Am 11.08.26 um 17:56 schrieb Claudio Imbrenda:
> In case of failure, pgste_get_trylock_multiple() will attempt to unlock
> the locked PGSTEs based on whether the PCL is set. In some
> circumstances this can lead to unlocking PGSTEs that were locked by
> other threads.
> 
> Fix by unlocking the amount of PGSTEs that were actually locked,
> ignoring the PCL bit in the array.
> 
> Fixes: 94fd9b16cc67 ("KVM: s390: KVM page table management functions: lifecycle management")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>


Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/dat.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
> index 165c704fcf29..f4dd6f783417 100644
> --- a/arch/s390/kvm/dat.c
> +++ b/arch/s390/kvm/dat.c
> @@ -923,11 +923,8 @@ static void pgste_set_unlock_multiple(union pte *first, int n, union pgste *pgst
>   {
>   	int i;
>   
> -	for (i = 0; i < n; i++) {
> -		if (!pgstes[i].pcl)
> -			break;
> +	for (i = 0; i < n; i++)
>   		pgste_set_unlock(first + i, pgstes[i]);
> -	}
>   }
>   
>   static bool pgste_get_trylock_multiple(union pte *first, int n, union pgste *pgstes)
> @@ -940,7 +937,7 @@ static bool pgste_get_trylock_multiple(union pte *first, int n, union pgste *pgs
>   	}
>   	if (i == n)
>   		return true;
> -	pgste_set_unlock_multiple(first, n, pgstes);
> +	pgste_set_unlock_multiple(first, i, pgstes);
>   	return false;
>   }
>   


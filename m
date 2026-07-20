Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B4930569D;
	Mon, 20 Jul 2026 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544322; cv=none; b=TfkFsBe1eSTTwodmVVe3Pkq3KDy0Rf528CVOI1BA6Yc8QGdmVWNdUHa0MZIHcuJDMIgdRiQMN8y06EHRKT5TvkIvZ44Grko6A99Gp+MSnITPTwPwEyvOxZ5IX4IsJ3mheKtc6x36D0k6csWfr8toFQ1U58G4t2i4CSyL9SPeEwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544322; c=relaxed/simple;
	bh=vHVqw3unWkjgrDUdzB2rkIZJOqKnQrqLqK+bANJtNZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RolYkeFpoOtIGotOu/v573irmvbyGoCEgjbYabx8c58n+JDsOG4ftnUZArizEbQgfAUmQrOYP6gqUizoVTRhK3FvHsEDMKTsygvCVZ4mmAc1qFL6HVNtAuLk4vRhOpRiFam77rzlziKIPDl6VyFGs82SsIhVrZl/c5i7aGvCGNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LoyGUEVV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LoyGUEVV"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KABjHS1811444;
	Mon, 20 Jul 2026 10:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=S9P/u6
	aU6FBlOrmrT/QWUimUnQWX3v1wK+H+KZ2eh8Q=; b=LoyGUEVV7Oxz4ffCIaU/yg
	z0VaXnqmu3FKfHbKTTYM0huSpSNq5qeehC0w1u7fyRI3raI4oPVMCLgBQFDRSNyM
	hujnYH2oeXqIwfCShw/kkIh0xzQONuZ35CWPD8hNHMrz620Q/oOepX5j7xOVVGNz
	Z3F06uVCIeQKTcaaa73NJeSSoNK+8a0H7LuBemlYgGgZI+oawYCvWitT31tDLXeR
	9JP4Q9P3v5bEapc22wptNscIt3YIInZboPh9Z5xqAwpjaUIy65/+O7TOUHciASM/
	uNDoharfKhR1FvH42vgDuu5mNjkfnROe6/nFsGVOGF/alCpVB0MtDA8B2iiDbIoQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78fxrct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:45:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KAYdFE026994;
	Mon, 20 Jul 2026 10:45:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnagw5e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:45:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KAj0wW48038392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 10:45:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56E282004B;
	Mon, 20 Jul 2026 10:45:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFC8120043;
	Mon, 20 Jul 2026 10:44:59 +0000 (GMT)
Received: from [9.111.21.55] (unknown [9.111.21.55])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 10:44:59 +0000 (GMT)
Message-ID: <da9010eb-a66f-4407-835d-8bf7f558d6e1@linux.ibm.com>
Date: Mon, 20 Jul 2026 12:44:59 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] s390/mm: Add missing mm check to
 do_secure_storage_access()
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260720085834.898025-1-hca@linux.ibm.com>
 <20260720085834.898025-3-hca@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260720085834.898025-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX+TR4QlVe47bm
 nAVNv550qG2A4/giiwoksUEtI37sdju8NIAzCyH31waxbrPSi0Y8Z2n0maYv4orEtnDp9DMtWW/
 lN57R50TzkJ7xskja3N9Z69I8k495dFnMGCBihEVj6uwCawo++fB3/ccjEn+J5R1AT8YyeuhCWi
 1IfhbrwiD3IItj8NdzXpP8VYz2lqay+1V4BxlG7xGDuTYL03KNhn1Eq4J9Tmym3JWVm0tOl1ETh
 203t/tTQB22S3QHWhrBZqicJXfhlUN9oOStx9cKqJalUU0fjKQLOcglN8KRnU0AN/3STtNrqK3e
 qos068XhoWO1rgAwVKy1iwYLUAyUkc7Zhvp23xwROmc3+BYSTQy/UalD2RGT1mSHfJp3yZlRH3u
 2TzhXMA9dgqcqgCy7ziBGUv63e35uRiOxjyA/8j/s9ok4bPKkEiVGA6M6ITn/JZdeJgNO9B7zJZ
 JeokZ+Judeic6i2t8Hw==
X-Proofpoint-GUID: hvkhiUvoV-ywoozxat4JE7CDaw4W6THz
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5dfc30 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=piDdzEt4iOiqkmhSgIoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfXxW/Ko4B12jvc
 rxBrAL8HRyDAijBEPGF9bRrs6aiLVMri5Gqz3SsaOzLHVuLhvBG/3ZtUbmzBonRQmfKqI5jRP+o
 ZV1dv5sbWoKpsRh+rxnuqf/xKWW3XD0=
X-Proofpoint-ORIG-GUID: hvkhiUvoV-ywoozxat4JE7CDaw4W6THz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200119

Am 20.07.26 um 10:58 schrieb Heiko Carstens:
> Similar like the normal exception handler the secure storage access
> exception handler needs to verify if mm is not NULL, which may happen
> with kernel threads.
> 
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260717132345.539A11F00A3A@smtp.kernel.org/
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>> ---
>   arch/s390/mm/fault.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 028aeb9c48d6..2839d7a64401 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -409,9 +409,9 @@ void do_secure_storage_access(struct pt_regs *regs)
>   {
>   	union teid teid = { .val = regs->int_parm_long };
>   	unsigned long addr = get_fault_address(regs);
> +	struct mm_struct *mm = current->mm;
>   	struct vm_area_struct *vma;
>   	struct folio_walk fw;
> -	struct mm_struct *mm;
>   	struct folio *folio;
>   	int rc;
>   
> @@ -453,9 +453,8 @@ void do_secure_storage_access(struct pt_regs *regs)
>   		if (rc)
>   			return handle_fault_error_nolock(regs, 0);
>   	} else {
> -		if (faulthandler_disabled())
> +		if (faulthandler_disabled() || !mm)
>   			return handle_fault_error_nolock(regs, 0);
> -		mm = current->mm;
>   		mmap_read_lock(mm);
>   		vma = find_vma(mm, addr);
>   		if (!vma)


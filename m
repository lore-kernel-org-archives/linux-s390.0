Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C693DB302;
	Mon, 20 Jul 2026 10:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544821; cv=none; b=PnIOa0AYmktz2+qOFN3j77HYrGCIaqJE/SqjzmJPPupBlMGiijk8mcsQ/2yF4zuDPHgu0xlONXTSFit97j3NZdDBB6hdCRN5DN7FUbwkzHeQKcNCGn64Peca4OpGAvXX6lFje+QM0rFiMC+c/WQVDkRHN+PHHVF4VP3f9aQYBY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544821; c=relaxed/simple;
	bh=Kdc2cLdI7Lr2NYKdlGTp3/8wsk+GrOPcjZJEUwB3Eck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBkiSVMxpCwycvT0pm4/qhPvJrXwgrpLzFE7pFnYlXGShQC6rb/NO9jhtx3VakkW8ZfXXYDCkU0JIVvgVRLfRs047+i4AZbxbozGTALpmrDNnEQT+wnGd/7rnEHPg4MHrT6/PVGv2K0Q10sIAX1oe2MuDQqrKrD+fhwIDWph+iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gmQKE0HC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gmQKE0HC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KABmsh1913539;
	Mon, 20 Jul 2026 10:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+Wn/Jm
	bJClgUu2D9FO2N7yukQbuuAJaKayNAx4Y54FI=; b=gmQKE0HCzB/yPdcHHej96U
	QATNyKpQF/95ZcxdWB3W1M5kRNzfurV0U/EFuW6ikLbcn2T/gVo/q7uN0G+cPggo
	kG4ZFxRubcQRB/WEBHE4sxurDxw/OIx/NuhkiH0MycHV3GjXlnXekPmO1omvMln1
	UIpw60NlrtZmKS3XY/FVEH4pM83HtNr9vfRwjc+UAGAdLIzIe/TSQBUqTvbkcbfk
	ArrIT7n17ZT0S9OKyNw0+PAr0AjeJPJXeaiqYJO7DOXbhwyIrISW4+jaW+Pp/+ep
	BvAuGOT1q1V5gRoNGbXWSeeDOoNI7RfNshwS3WXZVB3sb+gJJYDub0rD22wBSDQg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790q1r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:53:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KAnkWf010454;
	Mon, 20 Jul 2026 10:53:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnagw681-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:53:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KArUK762456176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 10:53:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 462182004D;
	Mon, 20 Jul 2026 10:53:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9F4020043;
	Mon, 20 Jul 2026 10:53:29 +0000 (GMT)
Received: from [9.111.21.55] (unknown [9.111.21.55])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 10:53:29 +0000 (GMT)
Message-ID: <da93640f-4fd4-4cae-bedf-921916dd4682@linux.ibm.com>
Date: Mon, 20 Jul 2026 12:53:29 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] s390/mm: Remove folio handling for kernel faults
 in do_secure_storage_access()
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260720085834.898025-1-hca@linux.ibm.com>
 <20260720085834.898025-6-hca@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260720085834.898025-6-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Mh4wfhIxE92DL75SlhSoLI251i1cqwKb
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5dfe2f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=9BmIAjpcb-zscLG4a-YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfXwBvnF6o91fKl
 /PHbZfgqM8DfuW+Hv6TMbBnSpajrARfxqVTnOqe6uU9owjVu8olRFUWZJZuhQY9Zlf8FItTAFAI
 TOB864gP3r1vALHe9Nclmdr9OQUzVGg=
X-Proofpoint-GUID: Mh4wfhIxE92DL75SlhSoLI251i1cqwKb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX5r1x2dUyhurg
 B3kJ7vI9iHpYLc0mb+qhQKWBGNvMtZ5BmkDZ1sUuolt45UfSr3TbE5jPbxKg+Y3AkMw8hocE9zx
 PAr+6dt05yGsGx/Xb5BxbQ1v79EM96LS844hiFc/ADwaabKbLQZRUnpBR/xR0FA8KwkObPGTJCi
 4hxn8QFObs9xgFK+8YakeyAh2S731D8iXjRIuslKuJu6SlcRjKCJg3rtsiaMi7XbzsUq995bRPh
 vTAdwYQULGgahHnfrRLqeublvnRwt9TOP/V+oPY5GJwVqKCAAhIEOFubhpLtepjqmqj0XD9cCPx
 9E4kXoG5RjioXzD9i0AgUeNPHDHJSgETpZTmpwVvuBz7W7lVr0oqhTJPmzuZcwkMateomj74P12
 QPy/QHe0amK3mxH7UqHMPFh1h+a1MC5XJdSE6dendWEf8EZ1gnM5R//bjKuAUCzYR6M8HwybHky
 +tnWn9y+DQQ7TrDyqYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200119



Am 20.07.26 um 10:58 schrieb Heiko Carstens:
> Remove folio handling for secure storage access exceptions that happen
> via the kernel mapping. Using folio_try_get() for exceptions via the
> kernel mapping is racy: for example such an exception may happen on one
> CPU, while a different CPU frees the corresponding page. Subsequently the
> page can be part of a folio of different size, before the faulting CPU
> executes folio_try_get(). This may lead to data corruption.
> 
> As of now this scenario does not seem to be possible, however with the
> upcoming load_unaligned_zeropad() this is possible.
> 
> As a side effect PG_arch_1 is not cleared anymore for such faults via the
> kernel mapping. However given that this bit is over-indicating it
> shouldn't matter.
> 
> Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Ideally Claudio should confirm that PG_arch_1 is over-indicating.

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/mm/fault.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index e650cdfa2523..776549d55c94 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -440,13 +440,7 @@ void do_secure_storage_access(struct pt_regs *regs)
>   	if (is_kernel_fault(regs)) {
>   		if (is_vmalloc_addr((void *)addr))
>   			return handle_fault_error_nolock(regs, 0);
> -		folio = virt_to_folio((void *)addr);
> -		if (unlikely(!folio_try_get(folio)))
> -			return;
> -		rc = uv_convert_from_secure(folio_to_phys(folio));
> -		if (!rc)
> -			clear_bit(PG_arch_1, &folio->flags.f);
> -		folio_put(folio);
> +		rc = uv_convert_from_secure(__pa(addr));
>   		/*
>   		 * There are some valid fixup types for kernel
>   		 * accesses to donated secure memory. zeropad is one


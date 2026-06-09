Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85A33FFF80;
	Tue,  9 Jun 2026 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781008763; cv=none; b=bFfjlPymaP6qy+WFnySv437ZT+KSFrU/C/wR7tbnANP0OjwXFojw2N+zPV2iJSFNWBZ7t2jfx4PkX2DoNpuQjxf9sre4/K1HZe8E3wXulngYcSuOMURwa2qoY76+fOTrm76sPApkihQkHy6moyqGUouCTUhRG5Mhto/b3W7p69M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781008763; c=relaxed/simple;
	bh=OHc3F7nYRsEkp7EmnHbBEgmgUcIxUK7PSaeXv/3BIa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YF87DrcCSocWapUd+BAi0sXXjAqUD6qcoyg/cRYknUyGDZ8eGv4nM77hNTWmdnoTB7BscNJSZUx2R5fO1nQQNByzYuH7sZTMAWuqKYqpXCL+6qkgTY/2rZAvWTIHtDDzbDjV3BVhnfCH0aOxYsbb1tSWlo/IuvH0dawz4fYb7mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hBn/waIy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hBn/waIy"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658NkhGd2909046;
	Tue, 9 Jun 2026 12:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Pc1SV4
	F6NgGrGFjET7AaEgAfPKwnmYGo45/H/b3IhEU=; b=hBn/waIy1XGTBNSZZriuis
	PaSSpQdq1BppkcbZEhZNC2s4M2RDIbHz/gjGPipcjqy++82COSgcP6/7lzIkme+m
	3TpEI7AkSplD80E3HxkKbOTlbxVG57yIRVxsTVyEpEO048EjmQixzxwstRHeZ8By
	pltVOn8QQWve/M2CkPkMNnB4MQqO/vaS7URdd2x1A/8Hens4r8mIXAIidYzczPTj
	tMycWk6NfsADvRdSeaSh1L8gyldC1dERnA9etEJ+NieKRFjTI/pyw5BoWdfzjpDn
	3kYewr/LcHZB/6teKRLMuYAuRseUKOyaxpWdZMzQPgKr5pDEhSqSn3R/b4XfgckA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23v57p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 12:38:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659CYjF2015576;
	Tue, 9 Jun 2026 12:38:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emych1v78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 12:38:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659CclsT37814618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 12:38:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 704832004D;
	Tue,  9 Jun 2026 12:38:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0D2A20043;
	Tue,  9 Jun 2026 12:38:46 +0000 (GMT)
Received: from [9.111.89.123] (unknown [9.111.89.123])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 12:38:46 +0000 (GMT)
Message-ID: <7bb6c04b-ded9-47e3-9350-563344de9f80@linux.ibm.com>
Date: Tue, 9 Jun 2026 14:38:45 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390: export memory encryption helper functions
To: Arnd Bergmann <arnd@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Sumit Semwal
 <sumit.semwal@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, Andrew Davis <afd@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        "David Hildenbrand (Arm)" <david@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260526102113.2594501-1-arnd@kernel.org>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260526102113.2594501-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a28095d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=nebloLCbriYy-_gPf0QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8skPL6famGFf0ka6fSZAj4LGODMXgQ4K
X-Proofpoint-GUID: uPmd5knbe44TRFTmhqJxHSn1CYbxuU3u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDExOSBTYWx0ZWRfXwkQDHhA4QgEH
 ilqFGke01vK+SeXXK+nWQ6P79nUQCwx7X8X/Zkqg7fSv9VMBL87fu6wf9IK93DE4V7qeBhUHoGa
 mc4P2Kk4AvivJ83QuKeW0HwdHF8ZfmePEmqWLLHvteD4X08HRhiG0dcm3ODmI24Bm0ddQrITc8B
 qdRCrs4LxPTTFJy4HSfJLBjZF/xFRNomNoNUYZgU9z7jY6No5a4OxV2KfVc3GJ/UIHgUVaZMs/m
 qAEPeV6+XsE+DRV4IJvk5f7/KNTLxazyazbmlwK6EYEMB2VmjAkw15HUWFR3Mr1EMr+6QRHHzVA
 8B1snPPB/m7SYS/GmTL7F4BHw9q5C1NOLxgDbeoJ0p70qFVxwmT5lW88aItS8purZpE/cf3H02O
 d5zXVMNDhL3oxGfeRo9YULMPQUA7I7s5mXixxmPiM4uKkIBa7dCzGCt4zCb6bxtQmWm4XTewRa3
 JPV/WkYXQN0s03F4Y+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090119

Am 26.05.26 um 12:20 schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The set_memory_encrypted/set_memory_decrypted functions are exported
> on x86 and arm64 but not on s390, which leads to a new build failure
> because they are now used in a loadable module:
> 
> ERROR: modpost: "set_memory_encrypted" [drivers/dma-buf/heaps/system_heap.ko] undefined!
> ERROR: modpost: "set_memory_decrypted" [drivers/dma-buf/heaps/system_heap.ko] undefined!
> 
> Export these the same way we do on the other architectures.
> 
> Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module")

This commit id was from an next tree? Seems to be no longer valid.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

@Alexander/vasily/Heiko, can you maybe queue that via the s390 fixes tree?> ---
>   arch/s390/mm/init.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index f07168a0d3dd..d589c5e4d388 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -124,6 +124,7 @@ int set_memory_encrypted(unsigned long vaddr, int numpages)
>   	}
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(set_memory_encrypted);
>   
>   int set_memory_decrypted(unsigned long vaddr, int numpages)
>   {
> @@ -135,6 +136,7 @@ int set_memory_decrypted(unsigned long vaddr, int numpages)
>   	}
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(set_memory_decrypted);
>   
>   /* are we a protected virtualization guest? */
>   bool force_dma_unencrypted(struct device *dev)


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205E62BD5B2;
	Tue, 30 Dec 2025 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767133812; cv=none; b=WtoAPjZA1NOEKBZpdIgTzJr+A2CcZkrRH9y0pxd3LJ/kGIcFXmebWRGSs2ifHW0RA/0WLWwIRyhX84Hr9VbRs7xOsX34S4BEb+7E3iFtapBnmQqyoPWfLYfL7Q2J8oLGf/SsGNlBdid6ds/DLkQWCVKYa8rOREsKMkFxQoALJMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767133812; c=relaxed/simple;
	bh=yhNHEVyHwzbAGKw2k0mPXkKjytox3Wq0DZ/d3GYPKTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVfJC2vWJ6f5i6js4sLSyI0XlyjjAHaNnbLLWAvHuetS7Dy3abjarKLJz0LWswI4cMyzOa09/A5gXv5ptAqzhQvJQ+tCBK5MG2h+S3SjszjfMe3azU5auDFT9B1oyAInM3tCHJ2g6mukmnZE62AGYrQHmBQnjfNZ2Pcg5x0G9wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UsKCZIUo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UsKCZIUo"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BUCFUfB032018;
	Tue, 30 Dec 2025 22:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZQE+9A
	1MhhESPJ5j/+v5z7o286UmQFi/EUHQ2Fe0TP0=; b=UsKCZIUo+8rbov/I+UL4X+
	p4QOGdwSNphepR4ecl5z9GggHSNhOORc6PPM4GkSzUUR5JVVd+6th2e5g06Cpppz
	p/1NzfZF5+DhZCe0CrgX7aI2GeRmCGgKOfZwO7QP5Wos9mLZi9o/ywcGbDpyhENr
	C/drrUfYjmRD7Z1WiqX6xEoDEIM50BNunFh0FA77PB1QcyYn/G/jsmAXKuK5WqVH
	Ly0WFlsF8UkvB+2KUMzIZu1WRo14/DUIVMPtkvxHR8KoXn+G7b3qSbVgFX6MtI4h
	Cw/WIvjhqMGzg/VWAxUQKSqhj5aXj1ds6KH8sBGj4yoOd1huKPvJgnt74/3jdAXQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bb46xhs98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 22:29:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BUJPT5c026066;
	Tue, 30 Dec 2025 22:29:58 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4batsnc0h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 22:29:58 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BUMTue526346002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Dec 2025 22:29:56 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5E4758059;
	Tue, 30 Dec 2025 22:29:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0178958058;
	Tue, 30 Dec 2025 22:29:56 +0000 (GMT)
Received: from [9.61.11.78] (unknown [9.61.11.78])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 30 Dec 2025 22:29:55 +0000 (GMT)
Message-ID: <670091f4-0187-4350-939a-bd0040e5edd7@linux.ibm.com>
Date: Tue, 30 Dec 2025 16:29:55 -0600
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/ap: fix typo in function name reference
To: Julia Lawall <Julia.Lawall@inria.fr>,
        Harald Freudenberger <freude@linux.ibm.com>
Cc: yunbolyu@smu.edu.sg, kexinsun@smail.nju.edu.cn, ratnadiraw@smu.edu.sg,
        xutong.ma@inria.fr, Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251230154239.98756-1-Julia.Lawall@inria.fr>
Content-Language: en-US
From: Jimmy Brisson <jbrisson@linux.ibm.com>
In-Reply-To: <20251230154239.98756-1-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDE5OSBTYWx0ZWRfX6n21sSCfA2RD
 BfCnV4wg0Bg4c5+/ElhYqw9+DL5qmBVew2Nj8Ktosc8OwfgoFlL980OGDxIHl+7PzAIK8QGzbSB
 1/Uhf9ZeTVNkiL/Jcvxy/XuapnZxo5mIb1Yq8vkkMkLxdCf1WCMPMGuGl2eEav2y1VJpzyqdjbo
 WhQ/PpfuQYkAWcH5U+thcEk7HTiEAD+/zyXwfKxpw4ZsFl+x61uQRBqke3SMMu13eFulsHDpWxo
 zEK+Ex3S9NuKgfuktr8aK9RsqOUK0Xynn/M9oRW4ZrqPv92pK+ocy1JViNCa5QlUWri1G3juboX
 PGqg2ya6dsBM0N5xTPo/0IxJr8XHVvObMLZyzCejhdz/EjZOBHM9FLb8OunkV+NiAYEYlUF2ye2
 0rK2z0fsH8gg/nTLALjN1bvjvG8TlmLAWN5H7mbASYDJIURf1zkQl7PQ2BGJWdZdtZa87fR5V/a
 Lk/47csBNEuZnxq5ckw==
X-Proofpoint-ORIG-GUID: e8e4GrB7xCvvjdq1VLucg9awApiTjk36
X-Authority-Analysis: v=2.4 cv=L7AQguT8 c=1 sm=1 tr=0 ts=69545267 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=ULJ_M-2MmIJxTCu8-3gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: e8e4GrB7xCvvjdq1VLucg9awApiTjk36
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512300199

On 12/30/25 9:42 AM, Julia Lawall wrote:
> Add missing s into ap_intructions_available.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>   arch/s390/include/asm/ap.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
> index b24459f692fa..3b95c6531a67 100644
> --- a/arch/s390/include/asm/ap.h
> +++ b/arch/s390/include/asm/ap.h
> @@ -78,7 +78,7 @@ union ap_queue_status_reg {
>   };
>   
>   /**
> - * ap_intructions_available() - Test if AP instructions are available.
> + * ap_instructions_available() - Test if AP instructions are available.
>    *
>    * Returns true if the AP instructions are installed, otherwise false.
>    */
> 
> 

Looks great, Thanks

Reviewed-by: Jimmy Brisson <jbrisson@linux.ibm.com>

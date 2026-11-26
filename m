Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795693897;
	b=zP9tivwr+6OlNQAFysXR0SEzOo9+r/k3cdIRSytDfIGLqpoc9W2Ci98F+1WKdSrA3wI6
	 Wm3kWZykF5oxE7pejCX7FrqJ0TRUbOAcXCJ2q4h7cvpBaseV+3OGTPai+slYz4MBOQoqN
	 m0TAijZTXdx0ZziydvD46tYECxzZyi16KmsYOb3roowHDWuEQ/1itUk2irsOwdiyWBdVx
	 +WePfNJ707aTrYVMh8UwzqdvqdmZYsNX9KZhV7XHiufcoKA0YPSQmc+d+YsZ/cpkZzIpA
	 bnNnL6Lsd3FCb2pHiyEwtUdjSVLomxe5l1sDEdCuEqTcIJYgY+bbWxlSEvWzYeFW9lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693897;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=UyA1q9HRdIYEzEBRlibk7URQlhQr6cKxZVJ59dL9cSc=;
	b=awESILKqF7mgc0CuopS10R/kbhyahcclLQQ1+UlKoNA2jMftdB250xECYRqO3JQVO+D8
	 jEaH2QbGfe9VGwboCQtu/7byYZT4/mCP5bSftnROHenmgQmXYzV7fHym2BEo3snNHaSWz
	 06LKsOKTWljgK1lZkFhRN70dFrg22DAQNxzEsnFDikS7J0l7PCT4i2z93PwU/D749ovoL
	 Xu59qTGNgKlRYHFty+wA/2LRgP5gG9Ao0IfUR59XVniRR8vqSy6uKaX+sI7zysWgbMQ6I
	 stFbpGY5ZA3J31UGzvFyt1neleFqm3B9WT4RYlsKW8agqcSCrXaofEMpsZSRxmT4FEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="rPKc/Prn";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D97606A31C;
	Thu, 26 Nov 2026 11:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1D97606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rPKc/Prn
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBYq51165311;
	Thu, 26 Nov 2026 11:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UyA1q9HRdIYEzEBRlibk7URQlhQr6c
	KxZVJ59dL9cSc=; b=rPKc/PrnltCkqnr+M+NlMWYatQgAO2NpITE0vHJLmqVCxO
	V9o6KChnGkWIpT7aIVfOJJvt2wzS4sAE7TOpZThjUOAaIxUq4a64xtEDZbyV3hZI
	ByCUGQJMTdBZVH5MhYUDoqd2tK2E39dc+EquUpxE+876XCsWN+lkqRmvPtTN3Iol
	ddGk86gFQ4ipmd18XSNCp6512nNMYiIy/DiHeueKfgQVQTOL5jzpV2wP+zoY7FAd
	AW4plJoaniM0wrZFRMD/1UWd0j4ZMN8eLIU1CgnTWxQLdWzdJTAE18kFMngIpSqR
	UdIhIYTw8Acn2rYTUWiMHrvNdAipbmpezO+xCiiw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fah60a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 11:51:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBYOSY3663893;
	Thu, 26 Nov 2026 11:51:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5a417ytq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 11:51:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AQBpJoq43254064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 11:51:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EBDD2005A;
	Thu, 26 Nov 2026 11:51:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6DC02004B;
	Thu, 26 Nov 2026 11:51:18 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.14.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 26 Nov 2026 11:51:18 +0000 (GMT)
Date: Thu, 26 Nov 2026 12:51:17 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/kdump: write protect the crash kernel memory by its
 virtual address
Message-ID: <a666d0dd-905c-4099-8a00-3c656370f986-agordeev@linux.ibm.com>
References: <20261117-fixes-s390-v1-1-2d9d04ca0072@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117-fixes-s390-v1-1-2d9d04ca0072@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0NSBTYWx0ZWRfX6lVYd8twLpYU
 IuCMzwxcOm91ylFqney16xzkEQnr/C4fmCcolcOHoROM+xiuJpD5kIvAVoCwXEL0jjLXs5BNbr1
 kXON/IGB3AyOeyw1R1Z3pHu7ScKpwE8Ok9f836i3UOLEkaU/H2FOUmX5WZmPZcvh330i8dOBVSJ
 Rtn/eBSuxuIqlmBxLxsQrad5JUW6j63rfch5RN0MGpsO+Yl6/MaeHcbGZghWOHqel9FY3NH4ZU0
 pWYCRrizJhp8aB1Gics7uZEHotDVzBvxuPkI74VNNaU9hUgHZdP6I7yMB3YRA12zkmmzEw48E4V
 /Y6np9z92A9lgWqR30/gZJkTozrJ+TWCw7DrMa/vIy4RyrqkqV6JbbvHHB9ltw8vCbw54Q8nVAI
 ZmD1xxTGR9L3AIk07Q/LApPyFuZDzIrg0RC6V9vOXOEM5s2IBEcFHOrFIFIWuZgUb1LpG1XZmXA
 U2x8RYwAjRMwq7aJe0g==
X-Proofpoint-ORIG-GUID: 5-68tLI2aTpf8KqRawJiD83emc3a_Ov-
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b081d3c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=bMDRMTjxwqQvzsmnqE4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 5-68tLI2aTpf8KqRawJiD83emc3a_Ov-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0NSBTYWx0ZWRfXwxT5N6IgY7Ka
 FYqNFOLfsvO1/ITA2NXi01C/fFJRIgr5LkaArsBZZCBONNA0XYLoAnUJ/eJNTjIa1eszRmsnze8
 NhhIzI3pGZzIBDgdrmmZBsUxj88SUIk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611260045

On Tue, Nov 17, 2026 at 04:01:04PM +0200, Mike Rapoport (Microsoft) wrote:
> crash_protect_pages() passes crashk_res.start to set_memory_ro() and
> set_memory_rw(). That is a physical address. Since the identity mapping
> may start above zero, it is not the address of the crash kernel memory
> in the kernel page tables.
> 
> With CONFIG_RANDOMIZE_IDENTITY_BASE the page table walk finds no mapping
> at that address and fails. The error is ignored, and the crash kernel
> memory stays writable after "kexec -p" loads it.
> 
> Use the identity mapping address of the crash kernel memory.
> 
> Fixes: c98d2ecae08f ("s390/mm: Uncouple physical vs virtual address spaces")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
> I found this while working on a generic implementation of the set_memory
> APIs. Only build tested.
> ---
>  arch/s390/kernel/machine_kexec.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
> index baeb3dcfc1c8..20ea3018462f 100644
> --- a/arch/s390/kernel/machine_kexec.c
> +++ b/arch/s390/kernel/machine_kexec.c
> @@ -151,15 +151,16 @@ void crash_free_reserved_phys_range(unsigned long begin, unsigned long end)
>  
>  static void crash_protect_pages(int protect)
>  {
> -	unsigned long size;
> +	unsigned long addr, size;
>  
>  	if (!crashk_res.end)
>  		return;
> +	addr = (unsigned long)__va(crashk_res.start);
>  	size = resource_size(&crashk_res);
>  	if (protect)
> -		set_memory_ro(crashk_res.start, size >> PAGE_SHIFT);
> +		set_memory_ro(addr, size >> PAGE_SHIFT);
>  	else
> -		set_memory_rw(crashk_res.start, size >> PAGE_SHIFT);
> +		set_memory_rw(addr, size >> PAGE_SHIFT);
>  }
>  
>  void arch_kexec_protect_crashkres(void)
> 
...
> Sincerely yours,
> Mike.

Applied, thanks!

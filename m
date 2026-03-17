Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02051D6187;
	Tue, 17 Mar 2026 02:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773715212; cv=none; b=jML5BtzSdsiiPaPp+nWMXbiSXufyjtRYgtTMnVfZSkJQNLvks06R18MTKiCLNdwwvgkn+9gLhtWkimUYRL/eRa5r2DyRdilDhooMwcsSrrOacJ956+Qo8ShpNFssykw2WNWpApqzPWxe4BCHsCqjpDQrqPoFAzsB9pFQfSKHLEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773715212; c=relaxed/simple;
	bh=X6qwPl31UQqUO6kv8xeMSvgA4cyYoPHvmx8Dzjr7Sl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmVKFSWZ7vzMak6HcqA8QdAEBimoCQfXqvVOgQRvgvy9NGFcw9JqQPlCAdcwd5PtsJ8wmRfVeTgDJ2xsNVQ13AJiWr9oSWkqkftk29hnzFGmhQjXFsGuW1LGGplKRdStM8ZjJ1dC/iGGqecldHz6UAh8dFgd7XqmhjDYhupFwIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nVrnEhTT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nVrnEhTT"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GFmO7Q1067860;
	Tue, 17 Mar 2026 02:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WAyxlZ
	Ob18faDii1hcBxce5sODl/jY3fcpYkQYaZOtY=; b=nVrnEhTTLbk/Spff2mRY4U
	Bk1xD4c7IRsuUQn2vkQWWQnsTW/n9CztKIRqpCqgswr1gAN9izU/AmUNyr52krq7
	Ebjv73kCfCp7xk9eKMg6LYkMGxzpLeIpffM6NWo3IyGvQeEvApEQ9bDSBAJq7/CP
	rh45PAGE4cd4d8eKVA7j+ks402Bw2yiQLotdYBs52KJN62oiR2atI6uHi9TxLj5J
	OdH+C5rgBXaTz7snJSJf4qXaj95VxdkqOKTARCFoApbhPLCiDoLPYef7WRdP0Fma
	q/leTHOKiVDuZ8EtsU1N4KXXIHZ/JZll9xoTl88NeNZRiGiB882uJ3B99myaGbBQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs2pa9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 02:39:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62H1NC99028708;
	Tue, 17 Mar 2026 02:39:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgk77u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 02:39:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62H2dkFp58327300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 02:39:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEF492004E;
	Tue, 17 Mar 2026 02:39:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E8312004B;
	Tue, 17 Mar 2026 02:39:43 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 02:39:42 +0000 (GMT)
Message-ID: <161b024f-9022-45c6-9808-815b8ea83bd9@linux.ibm.com>
Date: Tue, 17 Mar 2026 08:09:41 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/15] arch/powerpc: don't initialize kasan if it's
 disabled
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Baoquan He <bhe@redhat.com>, kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org, andreyknvl@gmail.com, ryabinin.a.a@gmail.com,
        glider@google.com, dvyukov@google.com, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, x86@kernel.org, chris@zankel.net,
        jcmvbkbc@gmail.com, linux-s390@vger.kernel.org, hca@linux.ibm.com
References: <20260225081412.76502-1-bhe@redhat.com>
 <20260225081412.76502-10-bhe@redhat.com>
 <71921cca-b890-41c4-93e9-957d3f647ffa@linux.ibm.com>
 <0bc30137-3f1d-4a4a-8573-8f26866fcc26@kernel.org>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <0bc30137-3f1d-4a4a-8573-8f26866fcc26@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b8bef6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=voM4FWlXAAAA:8 a=VnNF1IyMAAAA:8 a=5rPG81X-PvUkzTHTjkcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: HWoExDelsoEK2cbRMVIpcCVRBxC05kk2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDAxNyBTYWx0ZWRfXywbZf72OQQWO
 6dqxsntbcC6njezyY+HUqTo0rMFEcHOa573IhojGtmtl6Ek/h9rDkQ2yRH41g07ro4PtNLNlOC6
 bI4CP+Eo7cJqO30z4F4OpwJRb7oS9s2B+PdrBZGIhhBwTfWdoX+mdVUGUIDK9tPDGQazj/yuJTA
 8yPRocQXGhSyuDnhQ4sEbwI/SIqoTBAF+OwumN6W7cofg79urUof1tkhBjgR3ss/tzvou0Gkwsd
 kjOMcJu1j/1arCqKQXLU99t6T+WhXTTVqGlTTLue2d9D5oEUDDDzvtgbq8qOG3+dpMjYEFX37y/
 MF9157RX5GHtISXonVIOAQoXt0lzPq516Jmwt2G/r+aSNaAAKuzXUoWGFtTXrZT8xJszLvgcI2P
 Fo9Fl3eSCV46HHhRmWODojBiOnxk4jwwWvyrUxIBwQYEXgzcNqAiNbnyKMgsdgR+EmKOgA328e5
 Ky+m+8qMEGSY1KVS2Cw==
X-Proofpoint-GUID: ey18HYg4huOLB-DOzeSP3hWnR40_py-b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170017



On 12/03/26 16:53, Christophe Leroy (CS GROUP) wrote:
>
>
> Le 12/03/2026 à 12:12, Sourabh Jain a écrit :
>>
>>
>> On 25/02/26 13:44, Baoquan He wrote:
>>> Here, kasan is disabled if specified 'kasan=off' in kernel cmdline.
>>>
>>> This includes 32bit, book3s/64 and book3e/64.
>>>
>>> Signed-off-by: Baoquan He <bhe@redhat.com>
>>> Cc: linuxppc-dev@lists.ozlabs.org
>>> ---
>>>   arch/powerpc/mm/kasan/init_32.c        | 6 +++++-
>>>   arch/powerpc/mm/kasan/init_book3e_64.c | 4 ++++
>>>   arch/powerpc/mm/kasan/init_book3s_64.c | 4 ++++
>>>   3 files changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/mm/kasan/init_32.c 
>>> b/arch/powerpc/mm/kasan/ init_32.c
>>> index 1d083597464f..0ea2a636c992 100644
>>> --- a/arch/powerpc/mm/kasan/init_32.c
>>> +++ b/arch/powerpc/mm/kasan/init_32.c
>>> @@ -141,6 +141,10 @@ void __init kasan_init(void)
>>>       u64 i;
>>>       int ret;
>>> +    /* If KASAN is disabled via command line, don't initialize it. */
>>> +    if (kasan_arg_disabled)
>>> +        return;
>>> +
>>>       for_each_mem_range(i, &base, &end) {
>>>           phys_addr_t top = min(end, total_lowmem);
>>> @@ -170,7 +174,7 @@ void __init kasan_init(void)
>>>   void __init kasan_late_init(void)
>>>   {
>>> -    if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
>>> +    if (IS_ENABLED(CONFIG_KASAN_VMALLOC) && kasan_enabled())
>>>           kasan_unmap_early_shadow_vmalloc();
>>>   }
>>> diff --git a/arch/powerpc/mm/kasan/init_book3e_64.c 
>>> b/arch/powerpc/mm/ kasan/init_book3e_64.c
>>> index 0d3a73d6d4b0..fbe4c9a7e460 100644
>>> --- a/arch/powerpc/mm/kasan/init_book3e_64.c
>>> +++ b/arch/powerpc/mm/kasan/init_book3e_64.c
>>> @@ -111,6 +111,10 @@ void __init kasan_init(void)
>>>       u64 i;
>>>       pte_t zero_pte = pfn_pte(virt_to_pfn(kasan_early_shadow_page), 
>>> PAGE_KERNEL_RO);
>>> +    /* If KASAN is disabled via command line, don't initialize it. */
>>> +    if (kasan_arg_disabled)
>>> +        return;
>>> +
>>>       for_each_mem_range(i, &start, &end)
>>>           kasan_init_phys_region(phys_to_virt(start), 
>>> phys_to_virt(end));
>>> diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c 
>>> b/arch/powerpc/mm/ kasan/init_book3s_64.c
>>> index dcafa641804c..f7906f9ef9be 100644
>>> --- a/arch/powerpc/mm/kasan/init_book3s_64.c
>>> +++ b/arch/powerpc/mm/kasan/init_book3s_64.c
>>> @@ -54,6 +54,10 @@ void __init kasan_init(void)
>>>       u64 i;
>>>       pte_t zero_pte = pfn_pte(virt_to_pfn(kasan_early_shadow_page), 
>>> PAGE_KERNEL);
>>> +    /* If KASAN is disabled via command line, don't initialize it. */
>>> +    if (kasan_arg_disabled)
>>> +        return;
>>> +
>>>       if (!early_radix_enabled()) {
>>>           pr_warn("KASAN not enabled as it requires radix!");
>>>           return;
>>
>> Should we log in the kernel log buffer that KASAN is disabled?
>>
>> Right now, I don't see the kernel advertising the same.
>
> When KASAN is enabled it is advertised with:
>
>     pr_info("KernelAddressSanitizer initialized (generic)\n");
>
> Isn't the absence of that message enough to understand KASAN is not 
> there ?

Yes this should work. Thanks.


- Sourabh Jain


>
>>
>> $ dmesg | grep -i kasan
>> [    0.000000] Kernel command line: BOOT_IMAGE=(ieee1275//vdevice/v- 
>> scsi@30000070/disk@8100000000000000,msdos2)/vmlinuz-7.0.0-rc3+ 
>> crashkernel=2G kasan=off
>>
>> Tested this series on powerpc Pseries platform.
>> So feel free to add:
>> Tested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>
>> - Sourabh Jain
>>
>


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C162C9A;
	Thu, 23 Jan 2025 03:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737603051; cv=none; b=fK0aWNxwaMPcQ6WwU0rbFPIdlykDVqJDJLXuqncscpXLPqHbaH3cud2LsIOBdAnv91aWsalKhGDS3UO/0dSOMO5LBJxoBDGft5vNDLwRsfG/4NcPm/VGnd3owDjdF5aKaY08exgdsMSL3H+EJUJD6xD+KimClit0YNLCzkUIT9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737603051; c=relaxed/simple;
	bh=/Gg28fZ6XTo4bzoa5SJH279/YT+vQs51tNDlVTdUiaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBFUKsrUQMFVL4x+VbsyIjC9t01L7nfIprYJT9g+bgivGuGC613kpyxYf9kYGMbhJlH6UIAM4jqhppT6aRUr5qapHQ4wBvK1WPvzrEr+jGDP8ciutrnIIyLPEbcY51FNICnjMOVRttSruMpq4SJyN42BWu/54ZP3qqoRY3TiFfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=skBEgtL1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="skBEgtL1"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N2mqbB016790;
	Thu, 23 Jan 2025 03:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/Gg28f
	Z6XTo4bzoa5SJH279/YT+vQs51tNDlVTdUiaQ=; b=skBEgtL1wwVl3bfROv/mc6
	rqEp4D4shwNI9OE2/7gHzYgCfcBKihw4fkAwunTeAQ4z0pSi/jOr7NgyMd80+OvK
	W5ATEFCjdOfZ7nFOUQEDnSes2PK/brxsQAdsAvGBYEeYN4GF8YA7tVdyZMJq7Drh
	USwapeTTMG32ukzmQxr35oJF5mBjCtP/3LfhXEORJaK8M8tksye3ak4aXNil1ouG
	lPkV+WO7UKxPRaDINJWyU4SVREI3Zpt2nwllCNrbu45W9OdAPrhNqYkuBVuqu2Ri
	JMwW0XuW4Ilw69FwoBbwiyi5+FrvPUGoxQQ01ZGizTfoQnyjZQ9X11pZ0YqekOyQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44b3gttqys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 03:30:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MNkiim021080;
	Thu, 23 Jan 2025 03:30:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 448sb1k7v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 03:30:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50N3UE4I34996722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 03:30:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20DCE2004B;
	Thu, 23 Jan 2025 03:30:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27CE620040;
	Thu, 23 Jan 2025 03:30:11 +0000 (GMT)
Received: from [9.109.204.94] (unknown [9.109.204.94])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 03:30:10 +0000 (GMT)
Message-ID: <f6576f1c-bba3-44cc-bcb4-95318d2ece5c@linux.ibm.com>
Date: Thu, 23 Jan 2025 09:00:10 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: bring gigantic page allocation under
 hugepages_supported()
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: akpm@linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Muchun Song <muchun.song@linux.dev>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
References: <20250121150419.1342794-1-sourabhjain@linux.ibm.com>
 <20250122150613.28a92438@thinkpad-T15>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20250122150613.28a92438@thinkpad-T15>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w2m3_3a-QB9cdFcKEir-4B9cCAZ8Nu9t
X-Proofpoint-GUID: w2m3_3a-QB9cdFcKEir-4B9cCAZ8Nu9t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_01,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxlogscore=828 phishscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230024

Hello Gerald,

On 22/01/25 19:36, Gerald Schaefer wrote:
> On Tue, 21 Jan 2025 20:34:19 +0530
> Sourabh Jain <sourabhjain@linux.ibm.com> wrote:
>
>> Despite having kernel arguments to enable gigantic hugepages, this
>> provides a way for the architecture to disable gigantic hugepages on the
>> fly, similar to what we do for hugepages.
>>
>> Components like fadump (PowerPC-specific) need this functionality to
>> disable gigantic hugepages when the kernel is booted solely to collect
>> the kernel core dump.
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Heiko Carstens <hca@linux.ibm.com>
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: Muchun Song <muchun.song@linux.dev>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>
>> To evaluate the impact of this change on architectures other than
>> PowerPC, I did the following analysis:
>>
>> For architectures where hugepages_supported() is not redefined, it
>> depends on HPAGE_SHIFT, which is found to be a constant. It is mostly
>> initialized to PMD_SHIFT.
>>
>> Architecture : HPAGE_SHIFT initialized with
>>
>> ARC: PMD_SHIFT (constant)
>> ARM: PMD_SHIFT (constant)
>> ARM64: PMD_SHIFT (constant)
>> Hexagon: 22 (constant)
>> LoongArch: (PAGE_SHIFT + PAGE_SHIFT - 3) (appears to be constant)
>> MIPS: (PAGE_SHIFT + PAGE_SHIFT - 3) (appears to be constant)
>> PARISC: PMD_SHIFT (appears to be constant)
>> RISC-V: PMD_SHIFT (constant)
>> SH: 16 | 18 | 20 | 22 | 26 (constant)
>> SPARC: 23 (constant)
>>
>> So seems like this change shouldn't have any impact on above
>> architectures.
>>
>> On the S390 and X86 architectures, hugepages_supported() is redefined,
>> and I am uncertain at what point it is safe to call
>> hugepages_supported().
> For s390, hugepages_supported() checks EDAT1 machine flag, which is
> initialized long before any initcalls. So it is safe to be called
> here.
Thanks for the info.
>
> My common code hugetlb skills got a little rusty, but shouldn't
> arch_hugetlb_valid_size() already prevent getting here for gigantic
> hugepages, in case they are not supported? And could you not use
> that for your purpose?

Yes, handling this in arch_hugetlb_valid_size is even better. That way,
we can avoid initializing data structures to hold hstate, which is not
required anyway.

Thanks for the review and suggestion. I will handle this in the
architecture-specific code.

- Sourabh Jain

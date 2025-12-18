Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D5733769A;
	Thu, 18 Dec 2025 13:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766063271; cv=none; b=R3Ywgyrl1eKLr/jY+LYT+pjqX8kUeTlxEBwdACsdlKQ8P+dautw+wWUczFHK4vTxi1lC9K9zLRO7yazXOpo9PoWgUqcqs2nRhQbZwblrNqirKRfhk4AIWGPskbzLeKi7zu/aI9R9q1RTG9VZRGmfLd9f4K0AalaQ1KzmHp2EQOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766063271; c=relaxed/simple;
	bh=qdVAbP3QdgWw1fa/xc95vhxPKXSw87WBooQ9RFjHQWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J30iYlxNaJdE1an2IzXGhNyBtenriIgGSiQtYbfRT0brYVh956EZ5UMncYkD7kTKOSP/J9S3X8cGTWY8AVXh5wR34Qm8dtHEm/mJhKQpAzkfGZhZuJpXLHKBl1SfdEre7EGWt59k0u+YiOoTCTzixdJ3PzileBkEglfVeRci9Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oL2wrKYV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oL2wrKYV"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIAJhM4011462;
	Thu, 18 Dec 2025 13:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9bVjFf
	tHVS7uWdZpW9/LtnWIGLoCJqI5JblUIwN+Kv4=; b=oL2wrKYVOkb6Hv4O5sGlX1
	rjEWnNqOztiynELQMggvGq8sx4nrgdq1QaK6OB19ZDDyZwz0rKWJHidtJUhCMaJu
	B7LcNUlO3wMkXNs7e7ec/P/qxoDBRhsVrfopSTRnPAv8UK1zyc14VnF09QBNQIEm
	lczyTTVcO68kdK/IHwk4dNMSPA20vfmz1QH06R34ov9HdfFUoXmXbZ0OYUZmhVDx
	7YbmVhdj6WtdVmjGfabIeYHScdtHQ8IAkLDWMyOKQPNxLAk8mdHnVzQgjMq5Qgbj
	Tbl9d74sAxgcGJj+UNAaSflpuWhcgigBGelVggjXhlcK1BmuP/iDBPNKaLBKflGA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjm9ur6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 13:06:56 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BID6TwE012531;
	Thu, 18 Dec 2025 13:06:56 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjm9ur0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 13:06:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIBAuvo002863;
	Thu, 18 Dec 2025 13:06:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1kfngdew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 13:06:55 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BID6pOB37159190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 13:06:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58C302004B;
	Thu, 18 Dec 2025 13:06:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC06A20040;
	Thu, 18 Dec 2025 13:06:47 +0000 (GMT)
Received: from [9.39.19.14] (unknown [9.39.19.14])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Dec 2025 13:06:47 +0000 (GMT)
Message-ID: <1fddcf72-26f7-4fb4-84b8-1328e486d58e@linux.ibm.com>
Date: Thu, 18 Dec 2025 18:36:46 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mm/hugetlb: ignore hugepage kernel args if hugepages
 are unsupported
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
        linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov
 <bp@alien8.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        x86@kernel.org, linux-arm64@lists.infradead.org,
        linux-riscv@lists.infradead.org
References: <20251218114154.228484-1-sourabhjain@linux.ibm.com>
 <83920c44-47f5-4a46-bfa7-76713197d7e4@kernel.org>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <83920c44-47f5-4a46-bfa7-76713197d7e4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IOMjxDdqC_INVd8pD7lbLmjPG0vfkoRD
X-Authority-Analysis: v=2.4 cv=CLgnnBrD c=1 sm=1 tr=0 ts=6943fc70 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=GZ12N8NoI2vug0DTctEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rGJZSZAJBQua-nl0FXSZ6hN3il9LBdnD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwOSBTYWx0ZWRfX81IRjmUONXph
 vRAcgAYV2crAU/QbOJ7+PfueA+I8tNHkip0kvKVvQuphwhyC7oqrgSAukbSdpdjxuNYI5umCGCf
 K5+w/qkxfOWhS8HgN14q7okSGpEUZPEtvWx8GpHcGsHSgXZ/Shnj02rFvKJO0xre4+CKtuCEoiP
 dB/GPOCFuV2MF7RA2vZ/lJCBgpIf0a6AsuMAiXDOksBsJQAZ6BxUndMDhkNRxtGXrQ+5MRzP/f0
 AAzNUoSX1crFlsF+mhqU6AVJ7Lzod1K8N/ryvc5l/6RHwdO7me0NDg3htWywFTtQjNefRZQ5SKC
 ikJN5U/o/W0IHViZx/Iiyjg/YIxIUhQ4Nw1yEeALa1D+Ehzv78TUPYuXU8Z2O09tp4XTChyShNV
 qpiBfzUVNwRMF7hOaLwoM49FW/BVRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130009



On 18/12/25 17:32, David Hildenbrand (Red Hat) wrote:
> On 12/18/25 12:41, Sourabh Jain wrote:
>> Skip processing hugepage kernel arguments (hugepagesz, hugepages, and
>> default_hugepagesz) when hugepages are not supported by the
>> architecture.
>>
>> Some architectures may need to disable hugepages based on conditions
>> discovered during kernel boot. The hugepages_supported() helper allows
>> architecture code to advertise whether hugepages are supported.
>>
>> Currently, normal hugepage allocation is guarded by
>> hugepages_supported(), but gigantic hugepages are allocated regardless
>> of this check. This causes problems on powerpc for fadump (firmware-
>> assisted dump).
>>
>> In the fadump (firmware-assisted dump) scenario, a production kernel
>> crash causes the system to boot into a special kernel whose sole
>> purpose is to collect the memory dump and reboot. Features such as
>> hugepages are not required in this environment and should be
>> disabled.
>>
>> For example, fadump kernel booting with the kernel arguments
>> default_hugepagesz=1GB hugepagesz=1GB hugepages=200 prints the
>> following logs:
>>
>> HugeTLB: allocating 200 of page size 1.00 GiB failed.  Only allocated 
>> 58 hugepages.
>> HugeTLB support is disabled!
>> HugeTLB: huge pages not supported, ignoring associated command-line 
>> parameters
>> hugetlbfs: disabling because there are no supported hugepage sizes
>>
>> Even though the logs say that hugetlb support is disabled, gigantic
>> hugepages are still getting allocated, which causes the fadump kernel
>> to run out of memory during boot.
>
> Yeah, that's suboptimal.
>
>>
>> To fix this, the gigantic hugepage allocation should come under
>> hugepages_supported().
>>
>> To bring gigantic hugepage allocation under hugepages_supported(), two
>> approaches were previously proposed:
>> [1] Check hugepages_supported() in the generic code before allocating
>> gigantic hugepages.
>> [2] Make arch_hugetlb_valid_size() return false for all hugetlb sizes.
>>
>> Approach [2] has two minor issues:
>> 1. It prints misleading logs about invalid hugepage sizes
>> 2. The kernel still processes hugepage kernel arguments unnecessarily
>>
>> To control gigantic hugepage allocation, it is proposed to skip
>> processing the hugepage kernel arguments (hugepagesz, hugepages, and
>> default_hugepagesz) when hugepages_support() returns false.
>
> You could briefly mention the new output here, so one has a 
> before-after comparison.

Here is the fadump kernel boot logs after this patch applied:
kernel command had: default_hugepagesz=1GB hugepagesz=1GB hugepages=200

HugeTLB: hugepages unsupported, ignoring default_hugepagesz=1GB cmdline
HugeTLB: hugepages unsupported, ignoring hugepagesz=1GB cmdline
HugeTLB: hugepages unsupported, ignoring hugepages=200 cmdline
HugeTLB support is disabled!
hugetlbfs: disabling because there are no supported hugepage sizes

I will wait for a day or two before sending v2 with the above logs 
included in
the commit message.

>
> Curious, should we at least add a Fixes: tag? Allocating memory when 
> it's completely unusable sounds wrong.

Not sure which commit I should use for Fixes. This issue has
been present for a long time, possibly since the beginning.

I also noticed an interesting issue related to excessive memory
allocation, where the production/first kernel failed to boot.
While testing this patch, I configured a very high hugepages (hugepagesz=2M)
count, and the first kernel failed to boot as a result. I will report 
this issue separately.

>
> [...]
>
>> +    if (!hugepages_supported()) {
>> +        pr_warn("HugeTLB: hugepages unsupported, ignoring 
>> default_hugepagesz=%s cmdline\n",
>> +            s);
>> +        return 0;
>> +    }
>> +
>>       parsed_valid_hugepagesz = false;
>>       if (parsed_default_hugepagesz) {
>>           pr_err("HugeTLB: default_hugepagesz previously specified, 
>> ignoring %s\n", s);
>
>
> LGTM!
>
> Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
>

Thanks for the Ack David.

- Sourabh Jain

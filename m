Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B3F46C4C5
	for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925487; cv=none; b=UtsXpn2ZW7iXxlCdlZA0m5OXdwj9jOGpPS3oj96YYqj/fLzpHH+BzYcyl39A213jmtnKT0LgUUwiDtKsGzo2HXwZPwO+CnbjMbEWGWs0oqSsW23x0MUy9FnoEC1AEMwVxwvYp9z3BXQKxQExViOEgnUMddOfqyTDtMG9F7lZC4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925487; c=relaxed/simple;
	bh=QsyJ2HRJsFDq5R7wOEMO92MTSmLiaCAhgb09nlxikY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HlMlrcKNjYw8J9d7kmO2Yu2TKfx6xfKsIOmrsUg1klgUwAtBKlaPzkcXMAm7QWR0Qdvcex4xLVjLMD1S9VoC8ph947TJCXdzzQpf8CvcHS4GeYv8qjP7OUeqRzicmVSV0gdnVaF1Ikxkedx8jnDNXMfdLZX3sSc/mrGtkO+uH+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fuic+5Pd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fuic+5Pd"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDVfZn2023725;
	Fri, 28 Aug 2026 13:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0Exnqs
	rwiqqyk8qB6LesOF3zWwY7pePXMn6LBmDrgA8=; b=fuic+5PduezPTBf2BSbm38
	OD5jNkCNC/p9Wx5NoLFvr3Ch+yIc21fLDTLGiRHrzU3MwOJt/lspqkShKBif/zEe
	Bq5uzwtAcFvaQVvmW9RA0J3YnObkgvwG60V/LPFTqCP6drFd0/SOg9jv5GXEp4vb
	JpkoHs9F79eXW5XTIlEKY8LwVGyV8LNqroc0xmGzw0q1arQe1vZUDlmr8W5G35hl
	KLDj244bv0PESQy6I89vZ+sjmz/SOLD35LhB8SwqxjFcrYTxjTZdACymiBGnGaa7
	4QG3WJVlhxgaCWweOD7sC36RpPm2Reg05Jc8m+SVHjgqjsLylAvYsF3MKV89QFzg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716jckmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 13:58:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SDuFbT013199;
	Fri, 28 Aug 2026 13:58:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragxbr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 13:58:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SDvwoL39911896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 13:57:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D886720049;
	Fri, 28 Aug 2026 13:57:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 899E920040;
	Fri, 28 Aug 2026 13:57:58 +0000 (GMT)
Received: from [9.87.144.188] (unknown [9.87.144.188])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 13:57:58 +0000 (GMT)
Message-ID: <da7ac4e9-4da0-489a-9bf5-f37c90bee826@linux.ibm.com>
Date: Fri, 28 Aug 2026 14:57:58 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] s390/iomem: register initrd as an iomem resource when
 retain_initrd is set
To: Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: eoin.mcnamara@ibm.com, Christian Brauner <brauner@kernel.org>,
        Alexander Graf <graf@amazon.com>, cathcartj08@gmail.com
References: <20260818175755.3520-1-josephc@linux.ibm.com>
 <6f66956a-9793-4f96-b973-6e5875e5e433@linux.ibm.com>
Content-Language: en-US
From: Joseph Cathcart <josephc@linux.ibm.com>
In-Reply-To: <6f66956a-9793-4f96-b973-6e5875e5e433@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDExNyBTYWx0ZWRfXx300RZOcaplk
 gSIYM3CwQHTNy3woo2iU4JKKLVhHxcwLtfvwjpp4HUiZ0sdE2o1vSxgKziyhRKLuxoEl9BGZ+ef
 eYYZUGMbF2dgCv0y0wZYlFvwnSC39HI=
X-Proofpoint-GUID: pPQd0ogcYSrH-vPZTOodgToJEpsH5p47
X-Proofpoint-ORIG-GUID: ssfm6xT3T3C4kUdNbTZLmQknf5PAGW1g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDExNyBTYWx0ZWRfXyEQEj+yqe4KP
 n2ILE8ns6CyLyYN516GmbpamMA7TTnMn0+bF3fM9XtYDFqNDeeNrqepAzB48Do1kQrNDP9ikBq0
 PRPBcHOn4daqeQYH5cZFxigSu2yFSMrItnrCjzi9vz/4vdo4DuG05cyy6SqodpBXiWIQaR2dnHn
 R1j3T0TiqehWgDr7chWzBytA1v9Mbi6qGi4Xr+YFfjsrTNgV2RD8eBw465pw+I/fGA63Z65+1qr
 DzXdL1ahD/ZbwvK/On0TaA9LgwEJm5lJSGaAnEywK4oyybC5K5BK3mwDLXlTCgLeZPleAsel9dx
 gQeXOV8ZL2mRLvmBIkxhhCDfqDzkOlAHZSJqS8p2XwgsxAgHXLtI8bGb6HfybSr1b0xjyrwAZqF
 pmIAy5vWx5DIAypad0KFjWN1zCSu1uK+78b4ksBTEM1Waw1zkux1H/Lto0a5CBqCq2ZY4fBc9Un
 YYBQ3jDbfYBAqoqfMcg==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a9193e9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=gP-4D4jaNGx_qVbSGcQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280117

On 8/19/26 7:40 AM, Ilya Leoshkevich wrote:

>
>
> On 8/18/26 19:57, Joseph Cathcart wrote:
>> Currently, /proc/iomem contains no reference to initrd memory, even
>> when initrd is retained and still held in RAM. This makes the memory
>> ranges invisible from userspace, and unusable to programs such as
>> kexec. (A sysfs bin file is created for initrd, but this doesn't
>> help programs which need the explicit memory ranges)
>>
>> Add initrd to standard_resources[] unconditionally. Add initrd as a
>> child of iomem_resources only if retain_initrd is specified.
>>
>> strstr() could match substrings like "retain_initrd=0" or
>> "no_retain_initrd", but this is how PPC chose to check for
>> "retain_initrd" param too. (arch/powerpc/kexec/ranges.c)
>>
>> Signed-off-by: Joseph Cathcart <josephc@linux.ibm.com>
>> ---
>>   arch/s390/kernel/setup.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>
> Checkpatch complains:
>
> $ b4 shazam 
> 'https://lore.kernel.org/all/20260818175755.3520-1-josephc@linux.ibm.com/'
>
> $ git format-patch -1 --stdout | ./scripts/checkpatch.pl -
> ERROR: trailing whitespace
> #58: FILE: arch/s390/kernel/setup.c:513:
> +^I$
>
>> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
>> index b60284328fe3..373e54ed7519 100644
>> --- a/arch/s390/kernel/setup.c
>> +++ b/arch/s390/kernel/setup.c
>> @@ -481,15 +481,22 @@ static struct resource bss_resource = {
>>       .flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
>>   };
>>   +static struct resource initrd_resource = {
>> +    .name = "initrd",
>> +    .flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
>> +};
>> +
>>   static struct resource __initdata *standard_resources[] = {
>>       &code_resource,
>>       &data_resource,
>>       &bss_resource,
>> +    &initrd_resource,
>>   };
>>     static void __init setup_resources(void)
>>   {
>>       struct resource *res, *std_res, *sub_res;
>> +    bool retain_initrd = false;
>>       phys_addr_t start, end;
>>       int j;
>>       u64 i;
>> @@ -501,6 +508,19 @@ static void __init setup_resources(void)
>>       bss_resource.start = __pa_symbol(__bss_start);
>>       bss_resource.end = __pa_symbol(__bss_stop) - 1;
>>   +    if (IS_ENABLED(CONFIG_BLK_DEV_INITRD)) {
>> +        unsigned long initrd_addr, initrd_size;
>> +
>> +        if (strstr(boot_command_line, "retain_initrd"))
>> +            retain_initrd = true;
>> +        if (retain_initrd && get_physmem_reserved(RR_INITRD, 
>> &initrd_addr, &initrd_size)) {
>> +            initrd_resource.start = initrd_addr;
>> +            initrd_resource.end = initrd_resource.start + 
>> initrd_size - 1;
>> +        } else {
>> +            retain_initrd = false;
>> +        }
>> +    }
>> +
>>       for_each_mem_range(i, &start, &end) {
>>           res = memblock_alloc_or_panic(sizeof(*res), 8);
>>           res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
>> @@ -517,6 +537,8 @@ static void __init setup_resources(void)
>>             for (j = 0; j < ARRAY_SIZE(standard_resources); j++) {
>>               std_res = standard_resources[j];
>> +            if (std_res == &initrd_resource && !retain_initrd)
>> +                continue;
>>               if (std_res->start < res->start ||
>>                   std_res->start > res->end)
>>                   continue;
>
> Cc: Christian and Alexander.
>
> I wonder if it would make sense to move initrd resource creation to
> do_populate_rootfs(), right after /sys/firmware/initrd creation,
> enabling this feature on all architectures? 


As I will no longer have access to my IBM email address after today, I 
will be continuing

my contributions through my personal email address "cathcartj08@gmail.com"


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BA748094A;
	Mon, 14 Sep 2026 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396356; cv=none; b=oQaL4vaN8RqeKBoxoij76rFX3cD67yV7m+sVvUXMcLBkba4w14k3gDq6GBO+C9PPDgWECraA89u6OV+RJE6+0SEUOo+lfYYerC27kxOgrwm3uLhW2VMYA7vwAmGvNyDShLY6pQj+sabwnmB5yfPLK1b7g3FJDjmwt5IpYkNyXtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396356; c=relaxed/simple;
	bh=vfyVWaASYJAa3XBr84CWqbsMBqaQh38W4E06mZRemZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6mljLUAosUjvNXApY7wog2jCtwaoiNOYQgumbLPjFmrRIUj2D0bPx6XWe36/4sra/I6/yq+7VP07Q5uevr9Rve1qa1pLGEIR6IWwnFQM6hxN+egd5tgXq8zxF5vdd4zwiJOpDIHKLp9p6BJ9zZeUXScdEKjKj2g5rx6hkBqL2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y9YbGuF/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y9YbGuF/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EETfGS418792;
	Mon, 14 Sep 2026 14:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lVy0wc
	XmbENnS+FIQ0KsOhquQgH/WDKRXcVnniyEvQ8=; b=Y9YbGuF/6yudLXssUg8jCA
	WHDwi/zo5S+r0wyg40x+9vgo/yA1EfC0aCeAnMePsUFBT0RfgeYVrjLFnxHZosNK
	t46W4wP8IfM1KUbGvI9sRsxuJ/gSjNJpSdmhopm+fECMlU9vhulcmkRDy/+Agxpi
	lz0xaWW4MVXk3/fvDSHL+NcYFFx4eOYRljbrgQIn5m6oBR5CfHePtZFfi//RQQLB
	tBuRb112INMWtkR48+xTstxdC9ggtUmC/3OhEWdKVdDmsQ+Jtx7eYAzW6AY+kkhv
	HFWgG9NxwRz/NDPhzAi5kTwZSfvrDrRxZtPg9RigMZkjAx993MyrhuEDfggYOGxQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdq1ymf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 14:32:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED54rW2298667;
	Mon, 14 Sep 2026 14:32:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnj2jxhw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 14:32:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68EEWHCn49217820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 14:32:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9E912004E;
	Mon, 14 Sep 2026 14:32:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64DE220040;
	Mon, 14 Sep 2026 14:32:17 +0000 (GMT)
Received: from [9.111.205.105] (unknown [9.111.205.105])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Sep 2026 14:32:17 +0000 (GMT)
Message-ID: <66cf03dc-fe3b-4853-a5c1-54dd17860e90@linux.ibm.com>
Date: Mon, 14 Sep 2026 16:32:17 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 14/24] unwind_user/eh_frame: Add .eh_frame[_hdr]
 validation option
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-trace-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-15-jremus@linux.ibm.com>
 <20260821201016.855101F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260821201016.855101F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIwMSBTYWx0ZWRfX3jFlJ2EhZ36W
 sl+hosiaeBmRShwGZU39Nw8kd7/p6niyeAn/ZzZzt15V11xnlYn6Gh8wJfDZmHnZ88ed/TwDIuH
 MwtP2ZPgeQsTy6BUpzbwVUcT0sOKY/JIurbqGMb98dqeP63R4n+Bg5MjA3wtsO5/il6M25jzLV5
 yui7vjVDsgE2kT3yA6WhXQz8qhoqY49MXlOjAIVoqZs1XJVx79+v6rUFhOY2zkeIyCqI/Ya81o+
 zTOORnWO4AW5GrdKbppfcAQ6AlpNkR5/DoX8OfRTb8180wu9zplaS7MoSHovPAFPJ10+OvTi8bE
 8kG2aD+QdDdEWioDusaEuecblmSNR61jA3xBAnQi796Sn/zHTD2NbRbE17HKZU77cyMOQC6TBMI
 RU2aCXLmXXwpQXB4E2EjrG6dz/Lwfc28pAXfrESENJDfMv73HE+zDw0prEFuT2I7o7+hcUj21HD
 9XUPTpbUGuF4EouwLTA==
X-Proofpoint-GUID: 1fRiUsxXqOND91to644MAHhaExCfcnlQ
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aa80576 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Up-5jpl08WEPYK_orUQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1fRiUsxXqOND91to644MAHhaExCfcnlQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIwMSBTYWx0ZWRfX4nZtxJsgdccm
 XWw0z6CWTG+j+UiNWmTpmoDrnPx4iEz6bQd17+DldTc3vHq67UAW0kW/Y4lAF4TWzwPt2h8MsbV
 ifaWm9ie7uV2K0nkNRzyKAy5dor17qY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140201

On 8/21/2026 10:10 PM, sashiko-bot@kernel.org wrote:

> Add a debug feature to validate all .eh_frame[_hdr] sections when first
> loading the file rather than on demand.

>> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c

>> @@ -1216,6 +1216,92 @@ int eh_frame_find(unsigned long ip, struct unwind_user_frame *frame)
>>  	return ret;
>>  }
>>  
>> +#ifdef CONFIG_EH_FRAME_VALIDATION
>> +
>> +static int eh_frame_validate_section(struct eh_frame_section *sec)
>> +{
> [ ... ]
>> +	table_start_ptr = (void __user *)sec->binary_search_table_start;
>> +	table_size = sec->binary_search_table_end - sec->binary_search_table_start;
>> +
>> +	for (i = 0; i < sec->fde_count; i++) {
> 
> [Severity: High]
> Could this unbounded loop cause CPU stalls or trigger soft lockup warnings?
> 
> Since fde_count is controlled by the size of the mapped .eh_frame_hdr VMA,
> it can be extremely large for maliciously crafted ELF files, potentially
> stalling the CPU for seconds or minutes.
> 
> Because mmap_read_lock is released before this is called, would it be safer
> to add a cond_resched() in this loop?

According to Steven this is not required.

> 
>> +		struct eh_frame_fde fde;
>> +		unsigned long cur;
>> +		unsigned long func_addr, fde_addr;
>> +		int ret;
>> +
>> +		cur = sec->binary_search_table_start + i * entry_size;
>> +
>> +		scoped_user_read_access_size(table_start_ptr, table_size, Efault) {
>> +			/* Read function start address from table */
>> +			ret = read_encoded_pointer(sec, &cur,
>> +						   sec->binary_search_table_end,
>> +						   table_enc, &func_addr);
> 
> [Severity: High]
> Does this bypass the Spectre v1 mitigations provided by the scoped access
> macro?
> 
> The scoped_user_read_access_size() macro shadows the table_start_ptr variable
> to enforce usage of a masked pointer. However, the code ignores that masked
> pointer and instead uses the unmasked cur pointer derived outside the scope:
> 
>     cur = sec->binary_search_table_start + i * entry_size;
> 
> When read_encoded_pointer() uses this unmasked pointer inside
> unsafe_get_user(), the masking mitigations are bypassed, allowing potential
> arbitrary speculative reads.

True.  Will resolve as part of resolving the next finding.


> 
>> +			if (ret) {
>> +				dbg_sec_ehfh(cur, "table[%lu]: failed to read function start address\n", i);
> 
> [Severity: High]
> Is it safe to call printk wrappers like dbg_sec_ehfh() or dbg_sec() while user
> access (UACCESS) is enabled?
> 
> Calling complex functions like printk inside a scoped_user_read_access_size()
> block can lead to deadlocks or kernel panics. It does internal locking, can
> sleep, and may clobber architecture-specific user access state like the SMAP
> AC flag.

Will resolve by introducing and using a safe_read_encoded_pointer()
variant, similar to the safe_read_{fde|fre}() in the .sframe series.
This also gets rid of the scoped user access region and thus resolves
the previous finding as well.

> 
>> +				return ret;
>> +			}
>> +			if (i && func_addr <= prev_func_addr) {
>> +				dbg_sec(".eh_frame_hdr: table[%lu]: not sorted\n", i);
>> +				return -EINVAL;
>> +			}
> 

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


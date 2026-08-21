Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98B0379998;
	Fri, 21 Aug 2026 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341295; cv=none; b=O+MoVwEaWz3NBB5bhsUGf1YnYE30oDtbCzhL8ABSSxDo4VRtumkZwSKUqIJpv6P1rpgtnP5t0gACm5/kbOcvskCdYBwRFqoyfLBm+AU2L9sAqhSKt9+B1mtn9QxKxT7XcYcFfyjGhJ2ValnD2okVnL8epHhXsJqOh4Jr+CRQ5YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341295; c=relaxed/simple;
	bh=sGHd9gPxh05mKr7/JBcsNX7MWUNOeLTe7Qgg1vrOI80=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q3DJAclDRF8aTTgi8W9fZxrQD/oaOP+iv8c+R7KBw5o4fcU9GtBbEpSgJOl/10SOVhL5D4U1tt0uGMR4rqQw1UE+s8xXfJKjR2hRMzN4TDXIokSHlnc0v0detxqnPK804dJCm1qL0rUkQJ6qYmMDvcUa/WvxK5+/ArKGMqGiLr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FYSS0LI4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FYSS0LI4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVxYl2253970;
	Fri, 21 Aug 2026 19:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mAK8H9
	arkdKQfGbAmzD1v5qtanS+SnB36/rrPekBMIQ=; b=FYSS0LI4c0WK/R+2KyHq4i
	Cu8f1V+yriCPvU0uJ11zR2ULFOcr0iFiSt+wd51nwnd5ptXoLbHIJSIUyY8VngRY
	T5aF7PgWUj5cmCTow75dv8mv0L7otYrzOkdpLicbnoSOClgreEENG9mGUIovNL2p
	DJ6lcI6Yx/MqACxObJae4elMWENjVe1aakADhoXgS4dkZt/8nJ6ek1hb8Ft65INi
	8MT8ga1vPEhm2Z9Ngg6pMMnBwaRoLPNhkMZZudPEE51dCtuwIfl3srlMLDbiSWAQ
	ZND58mdfUkMGMMs8+lC6/pyGGsBwhRpeWqbNYEwkN66k23BsqSIWi51k70Ct0EIA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4kpd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfUv5023603;
	Fri, 21 Aug 2026 19:41:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twpp4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJfQu149545652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:41:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 677952004B;
	Fri, 21 Aug 2026 19:41:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F7AE20040;
	Fri, 21 Aug 2026 19:41:26 +0000 (GMT)
Received: from [9.111.132.173] (unknown [9.111.132.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:41:25 +0000 (GMT)
Message-ID: <44373099-6d51-47d0-88d0-4371524a3808@linux.ibm.com>
Date: Fri, 21 Aug 2026 21:41:26 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Remus <jremus@linux.ibm.com>
Subject: Re: [RFC PATCH v1 14/25] unwind_user/eh_frame: Add .eh_frame[_hdr]
 validation option
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-15-jremus@linux.ibm.com>
 <20260818150823.2422A1F000E9@smtp.kernel.org>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260818150823.2422A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX5KINjBixhm2x
 DWREH/7dv35lekXbWwSgRwp2OhFx6limjILu/Yg6Gm/hcpmcVCWAtR5FaoWN8z2q2En/X7SbzKp
 MNLs9FY5MlHGw8sDXkyRswV3PsUNG30=
X-Proofpoint-GUID: xaSNk5lO9bjJAjkuZCFR6wyRq7vuvP8i
X-Proofpoint-ORIG-GUID: xaSNk5lO9bjJAjkuZCFR6wyRq7vuvP8i
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a88a9eb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Eiylhle8zgek4H6P7-AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX5tWz6eYuD4na
 OXaH8pWZZtlaaq5lyVB1IeUsgfoc4WR+SjnJ+oFkayfwUdDlAOSpvZ3WY7TT0PBbzQ2s9QnjZMq
 3xt672iRNv0xZWPjX/uuP3rexnvbtniI4OL2s7f2Xt1PfY6hqi+aGM0nIKwPnzGKg26R+xgiuMP
 kZDTACCvaq42+P3ezTYiEF7+R0lpGz2oBZlC/ZeEJaoNrA593NOBrhAHo6sCMHqcwv+aMGJ84NI
 nMxOBVWlLY70gAKu3Vlhx/s9CX9my5UUcE3DsB4tfvmbzXMNcR885sDHaeh8nJMUW6Nu4PFmmvk
 3XvD8P+l5DKRIoqDG08CO/rcqSXys2HQAdDGhzVtan+Ida48SXmiqm85FmLbEdnTo78+NDZ8iAy
 zPcJaySxCyfg62Z/jSpozaxFpEy+dxFwt/TfOxdbO7VOmaFnZ7xRZNmHbO+Z1RzGsGPBca34oIy
 rXUsN/x9IZNGWEINQBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

On 8/18/2026 5:08 PM, sashiko-bot@kernel.org wrote:

>> diff --git a/arch/Kconfig b/arch/Kconfig

>> +config EH_FRAME_VALIDATION
>> +	bool "Enable .eh_frame[_hdr] section debugging"
>> +	depends on HAVE_UNWIND_USER_EH_FRAME
>> +	depends on DYNAMIC_DEBUG
>> +	help
>> +	  When adding an .eh_frame_hdr section for a test, validate the
>> +	  entire section and its referenced entrire .eh_frame section
> 
> [Severity: Low]
> Is there a typo here? (entrire -> entire)

Fixed in next version.

> 
>> +	  immediately rather than on demand.
> 
> [ ... ]

>> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c

>> +#ifdef CONFIG_EH_FRAME_VALIDATION
>> +
>> +static int eh_frame_validate_section(struct eh_frame_section *sec)
>> +{
>> +	void __user *table_start_ptr;
>> +	unsigned long table_size;
>> +	u8 table_enc;
>> +	int entry_size;
>> +	unsigned long prev_func_addr;
>> +	unsigned int i;

	unsigned long i;

>> +
>> +	if (!sec->has_binary_search_table)
> 
> [Severity: Low]
> Does this cause a build failure? It appears has_binary_search_table was never
> added to struct eh_frame_section.

That was a rebase error.  Fixed in next version.

> 
>> +		return 0;
>> +
>> +	if (!sec->fde_count) {
>> +		dbg_sec(".eh_frame_hdr: invalid FDE count\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	table_enc = sec->binary_search_table_enc;
>> +	entry_size = 2 * encoded_pointer_size(table_enc);
>> +	if (!entry_size) {
>> +		dbg_sec(".eh_frame_hdr: invalid binary search table entry size\n");
>> +		return -EINVAL;
>> +	}
>> +	table_start_ptr = (void __user *)sec->binary_search_table_start;
>> +	table_size = sec->binary_search_table_end - sec->binary_search_table_start;
>> +
>> +	for (i = 0; i < sec->fde_count; i++) {
> 
> [Severity: High]
> Can this loop become infinite and cause a hard lockup?
> 
> The loop counter i is a 32-bit unsigned int, while sec->fde_count is a 64-bit
> unsigned long. If sec->fde_count exceeds UINT_MAX, i will wrap around to 0, and
> the condition i < sec->fde_count will always evaluate to true.

My bad!  Fixed in next version.

> 
> [Severity: Medium]
> Additionally, can this unbounded loop over potentially millions of entries
> cause a CPU soft lockup or RCU stall? 
> 
> This loop executes entirely without a cond_resched() call, allowing a local
> user to load a moderately large ELF file and hold the CPU uninterrupted for
> seconds.

IIRC Steven told me not to add cond_resched() in reply to previous
Sashiko AI reviews of the unwind user sframe series.  Won't address
for now.

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
>> +			ret = read_encoded_pointer(sec, NULL, &cur,
>> +						   sec->binary_search_table_end,
>> +						   table_enc, &func_addr);
>> +			if (ret) {
>> +				dbg_sec_ehfh(cur, "table[%u]: failed to read function start address\n", i);
> 
> [Severity: High]
> Does calling dbg_sec_ehfh() inside scoped_user_read_access_size violate UACCESS
> rules?
> 
> The macro scoped_user_read_access_size enables UACCESS. dbg_sec_ehfh expands to
> pr_debug, which calls printk. Calling complex or sleepable functions like
> printk with UACCESS enabled can trigger page faults, take locks, or schedule,
> potentially leading to kernel oopses or panics.

This is mentioned in the patch notes.  I am looking for suggestions on
how to emit debug messages from a scoped UACCESS region.  Is the only
option to change to code from the unsafe to the safe versions of the
user access functions?

> 
>> +				return ret;
>> +			}
> 

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


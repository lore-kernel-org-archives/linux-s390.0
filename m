Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CEC367B9F;
	Fri, 11 Sep 2026 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138230; cv=none; b=fty8NAQoHs3zsWn3Jt9uCqC+Ui8eKBTKGBti3f27Twn+4j1EUEKGw9XZ24ME6whi8WWrISgm0jKMo1xnOu3XwO5f0n+PvokKbUi+Y3yQr235/i3tad7YloI/m0PtHRsAzWhkn1Hp9a1Ex9EqjE8FMOGAas69pe2qeO4jvwJSxU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138230; c=relaxed/simple;
	bh=V/r51ocWbzTF/bLY4JO9l8zJaW5k8+nQBG7BKtvNPgI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lwf+Zw4gy67mniUYMKtJQ2Ttcl7/N8nDU/aMCE0/9EsivCIAA4lx/1FN14ZSUtPzkVqhi4j3o+QSWbbUApEKpdUlZhd/6tYZMSOiiBwulHUmZUJGNH19gjTxdAiDrteptmsWRo0gTCzvcXJ3GQtzOWiWvSBDBlxeNMeG5eMqiPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DYzmKuSo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DYzmKuSo"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BD1hmI1714166;
	Fri, 11 Sep 2026 14:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/MwQov
	V48sdX1TRkq1h+r5FhZLNwmnQqYmgKyLwZRsQ=; b=DYzmKuSowMr3hDG0KuO2Yu
	zSVi9tGSBj6A7sHA1k6BxdNaqdl6ZQsOgDnK2XWk/6I39JPloOI1yuQkdQDCc5y0
	wwpjAvZREocUewpEwXGbMhwF8cRUkugizGIWWhBWFeXJBfGFInovxpHOEW3I/dN/
	Z6/7XUCrgMHVRzDLgWhIf/vDikN7Lpd2heW0XX73nB+kJN2ETfhfRBQKLZEIhPJU
	3RVi3Ifmn3n7fOPocZo6Ak/G+QxjtmW5ovtJM0sBF5G2p1E/57ltScOLJk2T8GFE
	ttNlSdvUsm2mjCn1wmgF6VKNkDTUvD8RdTs6b7OiJ8IfygQGunj7jBb2s1s4XOZA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8sc32e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 14:50:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEo7GY1802497;
	Fri, 11 Sep 2026 14:50:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvtfewu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 14:50:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68BEoI4c42205538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 14:50:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8679E2005A;
	Fri, 11 Sep 2026 14:50:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFF6D2004D;
	Fri, 11 Sep 2026 14:50:17 +0000 (GMT)
Received: from [9.111.140.161] (unknown [9.111.140.161])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Sep 2026 14:50:17 +0000 (GMT)
Message-ID: <fb8371eb-a869-462c-98ef-67a9f0c66836@linux.ibm.com>
Date: Fri, 11 Sep 2026 16:50:17 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Remus <jremus@linux.ibm.com>
Subject: Re: [RFC PATCH v2 07/24] unwind_user/eh_frame: Add support for
 reading .eh_frame_hdr section
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-trace-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-8-jremus@linux.ibm.com>
 <20260821200615.85E461F000E9@smtp.kernel.org>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260821200615.85E461F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: olRMpQ-yZwKAQZpbD1fMOQwBa_AEnfbs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIwMyBTYWx0ZWRfX4DHPfYfzNEXi
 GsUoKQhYXtMcDJJ2Gvq2hHnUrMNTeemoyEQCw4wUKSkWk/YVJlCfoKlA50xuOZVh6VpKuEN788L
 MVuVOGuS9J5MrlACGwxW7xwmMqz0PRKOsowbKSui24ILd2Lc9uPCyVoq2P1jZdG+9W/dR0MNUX9
 W1SOLBAVTeQ1twQd1Nr8Dv2msr7dRKWBI3XuwnYa81HtGnwNYquXCvSspBM7NxRp+K13KLCbiL+
 C1iXd8usIgwMYgowu6vKVBVESSsjKcf6V73q76jG0jyErDrAIVlR9xeILRVkmL9Q5nbzCHmAM76
 OXdHZ81BLwGa7Id49oraQXIu6HQ38RRkFf+U+V+sB2Iyi+NfZTrYO/FHR57vFoLvqR+dowTCkDC
 iPu80KTCnOUEMFrA/BJycswbJwog6cdXmbBpjcTBsVGtTeyypyD3SBfuIyhL3XTuElvBp+KD3Bt
 J+jr8TNOSFItEGHL5fA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIwMyBTYWx0ZWRfX3AYrBAz6CAR1
 tMG9jJXgr/KD1scZac+N3o0MeFRMDBVPW4egNrxnida066hlBemLyOiT5W4CLMNnXs69kVFYf/Q
 ZoiJGQep5WSkKuirY+lS2EIDXdGHRCA=
X-Authority-Analysis: v=2.4 cv=MpXHeGae c=1 sm=1 tr=0 ts=6aa4152f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=TB3WesdFtXAa7tQdJNQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: olRMpQ-yZwKAQZpbD1fMOQwBa_AEnfbs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110203

On 8/21/2026 10:06 PM, sashiko-bot@kernel.org wrote:

> In preparation for unwinding user space stacks with .eh_frame, add
> basic unwind user eh_frame infrastructure and support for reading the
> .eh_frame_hdr section.

>> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c

#include <linux/sched/task_stack.h>
#include <linux/unwind_user.h>

>> @@ -0,0 +1,366 @@
> 
> [ ... ]
> 
>> +static __always_inline int encoded_pointer_size(u8 encoding)
>> +{
>> +	u8 format = DW_EH_PE_format(encoding);
>> +
>> +	switch (format) {
>> +	case DW_EH_PE_absptr:

		if (IS_ENABLED(CONFIG_COMPAT))
			return unwind_user_word_size(task_pt_regs(current));

>> +		return sizeof(unsigned long);
> 
> [Severity: High]
> Does hardcoding sizeof(unsigned long) here cause issues for 32-bit compat
> tasks?

The word size from struct unwind_user_state field word_size cannot be used
because it needs to be known at .eh_frame[_hdr] section registration time:

eh_frame_add_section() -> eh_frame_read_header() -> read_encoded_pointer()

Would it be ok to determine the word size each time the special case
DW_EH_PE_absptr is handled in encoded_pointer_size() and
read_encoded_pointer()?  See also below.

Also I need to do some testing whether those actually occur in .eh_frame.
If not it would be preferable to drop DW_EH_PE_absptr support.

> 
> If a 64-bit kernel is profiling a 32-bit application, DW_EH_PE_absptr is
> expected to match the application's native 4-byte pointer size. Using
> sizeof(unsigned long) means the kernel will read 8 bytes, which could
> consume too much data and misalign the current pointer for the remainder
> of the unwinding process.
> 
>> +	case DW_EH_PE_udata2:
>> +	case DW_EH_PE_sdata2:
>> +		return 2;
> 
> [ ... ]
> 
>> +static __always_inline int read_encoded_pointer(struct eh_frame_section *sec,
>> +						unsigned long *addr,
>> +						unsigned long end,
>> +						u8 encoding,
>> +						unsigned long *value)
>> +{
> 
> [ ... ]
> 
>> +	/* Read value based on format */
>> +	switch (format) {
>> +	case DW_EH_PE_absptr: {
>> +		unsigned long tmp;
>> +		UNSAFE_GET_USER_INC(tmp, cur, end, Efault);
>> +		result += tmp;

Replace above with:

		if (IS_ENABLED(CONFIG_COMPAT) &&
		    unwind_user_word_size(task_pt_regs(current)) == sizeof(int)) {
			unsigned int tmp32;
			UNSAFE_GET_USER_INC(tmp32, cur, end, Efault);
			result += tmp32;
		} else {
			unsigned long tmp;
			UNSAFE_GET_USER_INC(tmp, cur, end, Efault);
			result += tmp;
		}

>> +		break;
>> +	}
> 
> [Severity: High]
> Will this also read 8 bytes instead of 4 for a 32-bit task?
> 
> Similar to encoded_pointer_size(), this reads a full unsigned long for an
> absolute pointer. If this is a 64-bit kernel unwinding a 32-bit compat
> application, it seems this might read past the intended data boundaries
> and corrupt the address parsing.
> 
>> +	case DW_EH_PE_uleb128: {
>> +		unsigned long tmp;
> 
> [ ... ]
> 
>> +static int eh_frame_read_header(struct eh_frame_section *sec)
>> +{
>> +	struct mm_struct *mm = current->mm;
>> +	void __user *eh_frame_hdr = (void __user *)sec->eh_frame_hdr_start;

	size_t size = sec->eh_frame_hdr_end - sec->eh_frame_hdr_start;

>> +	unsigned long cur = sec->eh_frame_hdr_start, end = sec->eh_frame_hdr_end;

Move cur and end into scoped user access block below.

> 
> [ ... ]
> 
>> +	scoped_user_read_access_size(eh_frame_hdr, end - sec->eh_frame_hdr_start,
>> +				     Efault) {

	scoped_user_read_access_size(eh_frame_hdr, size, Efault) {
		unsigned long cur = (unsigned long)eh_frame_hdr;
		unsigned long end = (unsigned long)eh_frame_hdr + size;

>> +		/* Read version */
>> +		UNSAFE_GET_USER_INC(version, cur, end, Efault);

Then whenever cur or end are expected to be unmasked pointers they need
to be converted back:

-		table_start = cur;
+		table_start = sec->eh_frame_hdr_start + (cur - (unsigned long)eh_frame_hdr);

...

-		if (fde_count > (end - table_start) / entry_size)
+		if (fde_count > (sec->eh_frame_hdr_end - table_start) / entry_size)
			return -EINVAL;

> 
> [Severity: High]
> Does this bypass the speculative execution pointer masking provided by
> scoped_user_read_access_size()?

True.  I was not aware of that.  While above seems to resolve this at a
first glance there are some implications in read_encoded_pointer():

DW_EH_PE_datarel (relative to .eh_frame_hdr) and DW_EH_PE_textrel
(relative to .text) return an unmasked pointer, which is ok, as the
callers expect it to be an unmasked value.

DW_EH_PE_pcrel (relative to the field itself) also returns an unmasked
pointer and now requires the unmasked cursor pointer to be provided as
input as well.

> 
> The block masks the eh_frame_hdr pointer, but inside the block,
> UNSAFE_GET_USER_INC() reads from the unmasked unsigned long cur variable:
> 
> #define UNSAFE_GET_USER_INC(to, from, end, label)
> ...
> 	unsafe_get_user(__to, (typeof(to) __user *)from, label);
> 
> Since cur is passed to unsafe_get_user() without being masked, it appears
> this defeats the Spectre V1 mitigation for architectures relying on
> can_do_masked_user_access().
> 
>> +		if (version != 1)
>> +			return -EINVAL;

>> +int eh_frame_add_section(unsigned long eh_frame_hdr_start,
>> +			 unsigned long eh_frame_hdr_end,
>> +			 unsigned long text_start,
>> +			 unsigned long text_end)
>> +{
>> +	struct mm_struct *mm = current->mm;
>> +	struct eh_frame_section *sec;
>> +	int ret;
> 
> [ ... ]
> 
>> +	scoped_guard(mmap_read_lock, mm) {
>> +		struct vm_area_struct *eh_frame_hdr_vma, *text_vma;
>> +
>> +		eh_frame_hdr_vma = vma_lookup(mm, eh_frame_hdr_start);
> 
> [ ... ]
> 
>> +	ret = eh_frame_read_header(sec);
>> +	if (ret)
>> +		goto err_free;
>> +
>> +	/* TODO nowhere to store it yet - just free it and return an error */
>> +	ret = -ENOSYS;
>> +
>> +err_free:
>> +	free_section(sec);
>> +	return ret;
>> +}
> 
> [Severity: Low]
> This isn't a bug, but should this function avoid mixing scoped_guard() and
> goto-based error handling?
> 
> The kernel cleanup guidelines recommend either fully converting to
> scope-based cleanup (for example, using __free() for the sec allocation)
> or strictly using goto-based cleanups without scoped_guard(). Mixing them
> in the same function can create confusing ownership semantics.

Other than converting the code to use mmap_read_lock(mm) and
mmap_read_unlock(mm) I don't see how the section cleanup logic
could be converted to scope-based cleanup, as it must not be
freed if it gets inserted into the mm->eh_frame_mt (in a
subsequent patch).  Sashiko probably misses this as in this
incomplete state it looks as if it could be converted, as the
section is always freed.

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


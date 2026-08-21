Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4B63DD50B;
	Fri, 21 Aug 2026 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341289; cv=none; b=DF3HnpEDSnnGBiWELty+roPO4UAstD1vpysPEvs7LrRUn+E8X4e4tOTm1iVPfOOQv1RStO4zIBB5e+OMvR6ZHzZ4tKa96UyrOA42fJ+tnmUWkyjQNKIvwnOQKZDu780iziJFblFNhmlMdbWjXxOCTU12qX/mRv4XlIrRT6ZzG5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341289; c=relaxed/simple;
	bh=nDpMoZ9umrUSD/rHNPFrlPgzpn5o3fhmAr2sNfVDuhk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rHbmg1zEJzv2bgOUYhVxU2xyhnhSjYlHWwHxWgPpgk4rULxDxOuUTFC2lTaQYs0rLOqGxNsMwEihoms9hLQxWBcYRGza0i8MGnA0ocO12ScStwY0INuQSTrIK0hgxEWoTY9Of1ABuaaVAjS7Gdg0SZJHYNxgDVqT0ThDpNy+RXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ST+tr01v; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ST+tr01v"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVmTT2387677;
	Fri, 21 Aug 2026 19:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9jg/xr
	1FA9gUkkhT5IMQyChm8oeUtjGTK9Do4ZNULdk=; b=ST+tr01vOvbNeJB7zRl+fG
	O0smDUXra8o9TjzeJIO3C+eRLC+/8p4GkQi2EmCf4c6/odcjqTsV1ZTcDRpCZ3c5
	GEk395waF6Su/1lznswvbjRfkkuKP/nT7sqvCBRVKWzmubnOv4juqCw1TWnxmJcE
	yorWbGmU9AIOovOjohKue6Xd5MEqIxdhBhEz383CWNlJ2pbqTUbNLoU+6XYNB1qR
	sGxLLaih2y+nzqpA3Poe1SBY0seOyZoTCqylNfft6qY0DIvVSmmQblLgEGGIB73g
	6EqEGmAVC0DXGUsianvBZdsm1kUmgpDlfUE8pTvvtlto/8cAofLDC9NShbtyfH4w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4kke5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJQOGU028713;
	Fri, 21 Aug 2026 19:41:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhpkck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJfDhb34210120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:41:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B83820043;
	Fri, 21 Aug 2026 19:41:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E6BE2004D;
	Fri, 21 Aug 2026 19:41:12 +0000 (GMT)
Received: from [9.111.132.173] (unknown [9.111.132.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:41:12 +0000 (GMT)
Message-ID: <0642fe79-ae5f-467e-a5a3-1b3d044faf75@linux.ibm.com>
Date: Fri, 21 Aug 2026 21:41:12 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Remus <jremus@linux.ibm.com>
Subject: Re: [RFC PATCH v1 08/25] unwind_user/eh_frame: Store .eh_frame_hdr
 section data in per-mm maple tree
To: sashiko-reviews@lists.linux.dev, Josh Poimboeuf <jpoimboe@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-trace-kernel@vger.kernel.org
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-9-jremus@linux.ibm.com>
 <20260818150849.293061F000E9@smtp.kernel.org>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260818150849.293061F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a88a9de cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=seHxCTPHKr5bFwb6n9AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RZYguaA5U7uo00NgCeRqf85HpcywGDWV
X-Proofpoint-GUID: RZYguaA5U7uo00NgCeRqf85HpcywGDWV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX8yirhSikkEby
 0nIPoSUvKZQAb+qte+SUffKAIFAnvcJCgfJXfnmG3NXRzY2J0pT0X6T2V3kB3m2XmHdH4yqUA8B
 JQXYt8ZkSoAaT28DniKVZg/vFdfhSZs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX46fPInJevePV
 iTKFXx2zN5FGuP1/POrcX4dRN72OSqPGeISMOqy/eN7jNmOQ7Ja72baB3/Dduykw9mqqw/hybEE
 xdtC3hdY2mUtcWSZ+JU63tWHOR74co5vS902hSBnba5wJ1VkjNQvq4CTrUx5iyjNXhECft4Q90a
 83gU/DDyIEPC4tvXLbw56oko7TjJwcTqMZvGXKZt/Wq8OzUHzidLsZTEma+Ym6QuJg9elkiOS+U
 8MjP+QZMCY8gvZWzOSmaeCMCB7A2wE/5XATrBqE6o4iJzrUd7nEtWuXTatDZD4su7Xq9GKbqr3E
 adyDtKj7bv/ZSs5Aun1XRtAc4gSjVum0p26NrTcN5XOiX2dsezei6vzm1lNcpMrzT51CNDdvEwt
 URT5qLwNdClsI5rYjvylVxARezVJYhWo2LcwxIS4BpIWYnB00HSU/V0euKyaUjTWMlG2xaT2xtk
 XuoEQ+QhbC9xM3Ui91Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210155

On 8/18/2026 5:08 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [Critical] The `eh_frame_mt` maple tree is initialized without `MT_FLAGS_USE_RCU`, causing internal nodes to be synchronously freed, which crashes concurrent lockless readers.

Josh, Steven, this seems like a valid finding.  See below.

> - [High] fork() fails to inherit .eh_frame_hdr registrations, breaking unwinding for child processes.

This is resolved by subsequent patch "unwind_user/eh_frame: Duplicate
registered .eh_frame[_hdr] section data on clone/fork".

> - [High] A TOCTOU race condition in `eh_frame_remove_section` allows a double-free of one section and a memory leak of another.

Steven, we somehow started to use the mmap_read_lock/mmap_write_lock to
synchronize adding/removing sections into the maple tree in the sframe
series, which my eh_frame series is missing:
https://lore.kernel.org/all/20260522071851.6a121c00@gandalf.local.home/

I think using the advanced maple tree API would be preferable.  See below.

> - [High] An integer overflow in `table_end` calculation allows maliciously crafted `.eh_frame_hdr` sections to bypass bounds checking.

This is fixed in preceding patch "[RFC PATCH v1 07/25] unwind_user/
eh_frame: Add support for reading .eh_frame_hdr section".

> - [Low] Appending INIT_MM_EH_FRAME in init_mm causes a missing comma syntax error on multiple architectures.

IIRC this can be left for affected architectures to fix?

>> diff --git a/include/linux/eh_frame.h b/include/linux/eh_frame.h

>> +#define INIT_MM_EH_FRAME .eh_frame_mt = MTREE_INIT(eh_frame_mt, 0),

#define EH_FRAME_MT_FLAGS (MT_FLAGS_USE_RCU)

#define INIT_MM_EH_FRAME .eh_frame_mt = MTREE_INIT(eh_frame_mt, EH_FRAME_MT_FLAGS),

> 
> [Severity: Critical]
> Is the MT_FLAGS_USE_RCU flag required here?
> 
> Since readers are locklessly iterating the tree using mt_for_each() (which
> relies on rcu_read_lock()), omitting MT_FLAGS_USE_RCU causes concurrent
> mtree_erase() or mtree_insert_range() to synchronously free internal nodes via
> kfree() instead of kfree_rcu(). Can this cause a use-after-free for the
> concurrent readers?

>> diff --git a/kernel/fork.c b/kernel/fork.c

>> +static void mm_init_eh_frame(struct mm_struct *mm)
>> +{
>> +#ifdef CONFIG_HAVE_UNWIND_USER_EH_FRAME
>> +	mt_init(&mm->eh_frame_mt);

	mt_init_flags(&mm->eh_frame_mt, EH_FRAME_MT_FLAGS);

> 
> [Severity: Critical]
> Should this use mt_init_flags() with MT_FLAGS_USE_RCU?
> 
> Similar to the INIT_MM_EH_FRAME macro, initializing without RCU could lead to
> a use-after-free if internal maple tree nodes are freed while lockless readers
> are iterating.
...
>> +#endif
>> +}

>> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c

>> +static int __eh_frame_remove_section(struct mm_struct *mm,

static int __eh_frame_remove_section(struct ma_state *mas,

>> +				     struct eh_frame_section *sec)
>> +{
>> +	if (!mtree_erase(&mm->eh_frame_mt, sec->text_start)) {
>> +		dbg("mtree_erase failed: text=%lx\n", sec->text_start);

	if (mas_erase(&mas) != sec) {
		dbg("mas_erase failed: text=%lx\n", sec->text_start);

>> +		return -EINVAL;
>> +	}
>> +
>> +	call_srcu(&eh_frame_srcu, &sec->rcu, eh_frame_free_srcu);
>> +
>> +	return 0;
>> +}
>> +
>>  int eh_frame_remove_section(unsigned long eh_frame_hdr_start)
>>  {
>> -	return -ENOSYS;
>> +	struct mm_struct *mm = current->mm;
>> +	struct eh_frame_section *sec;

	MA_STATE(mas, &mm->eh_frame_mt, 0, 0);

>> +	bool found = false;
>> +	int ret = 0;
>> +
>> +	guard(srcu)(&eh_frame_srcu);
>> +
>> +	mt_for_each(&mm->eh_frame_mt, sec, index, ULONG_MAX) {

	mtree_lock(&mm->eh_frame_mt);
	mas_for_each(&mas, sec, ULONG_MAX) {

>> +		if (sec->eh_frame_hdr_start == eh_frame_hdr_start) {
>> +			found = true;
>> +			ret |= __eh_frame_remove_section(mm, sec);
>> +		}
>> +	}

	mtree_unlock(&mm->eh_frame_mt);
	
> 
> [Severity: High]
> Can this mtree_erase() and call_srcu() sequence race with another thread and
> cause a double-free?
> 
> If Thread A locklessly iterates and finds sec1 in mt_for_each(), and Thread B
> concurrently removes sec1, Thread C could map a new section sec2 at the same
> text_start address.
> 
> When Thread A calls __eh_frame_remove_section(mm, sec1), mtree_erase() would
> successfully remove and return sec2. However, Thread A then passes the
> original sec1 pointer to call_srcu(), double-freeing sec1 and leaking sec2.

Valid.  Using the internal maple tree API to guard the whole iteration
and deletion of the eh_frame sections using the internal writer spinlock
should resolve this issue.

>> diff --git a/mm/init-mm.c b/mm/init-mm.c

>> @@ -48,6 +49,7 @@ struct mm_struct init_mm = {
>>  #endif
>>  	.flexible_array	= MM_STRUCT_FLEXIBLE_ARRAY_INIT,
>>  	INIT_MM_CONTEXT(init_mm)
>> +	INIT_MM_EH_FRAME
>>  };
> 
> [Severity: Low]
> Does appending INIT_MM_EH_FRAME here cause a missing comma syntax error on
> some architectures?
> 
> While x86's INIT_MM_CONTEXT was updated to include a trailing comma in this
> patch, other architectures (like UML or PowerPC Book3s 32-bit) may lack this
> trailing comma in their INIT_MM_CONTEXT definitions, breaking the build.

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


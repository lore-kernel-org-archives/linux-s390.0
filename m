Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4D246AA85;
	Mon, 14 Sep 2026 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389635; cv=none; b=RvFt3XvpzoY9n/4GJC+wfmg06b8yWmKysbR/epScyIQecZYjYRvORlnHJQhR+2gnP7hmM0VwYD2RHajBUwKeAB0AEEQs04xe+Tys+eVtxM9PVU0zlSdQF36fc+p/1dbYZy9fM0Q3gD85qSN89SFTWJulyDfaVDr7sK8RW5pDmgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389635; c=relaxed/simple;
	bh=WefzKgxG30Cyj+fenxlcnEF2bQNPVRFvkTZFA2rI/zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inedgGt+YMamy4fe8PGK+n8MsCdgUTMyhaOiG1BjQOhb35A90twTDic6QGOLhgnKlNl9oDITlNySk9f/fTzpxn142Fnv4NHor7fiKFNHBHGvwsxItF4zmWD+nhjhvqUukew7SowV/1joj/JsgxWhTO+vvzfDgpYXpZMJ5CLT1es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cOrQs4cg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cOrQs4cg"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EA1Zon1572335;
	Mon, 14 Sep 2026 12:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3o859w
	8koVHGjcJCXqMo2tIp5FaSk7kxdLPqJo3UyII=; b=cOrQs4cg59OfGlT69+wGO6
	7AZFDlGh18ViLs5wPbm5hh8cgGSAWjvvOnK9ERoOBya3UN9K40kV762zinug4mM/
	+poATbBQCSP0nYiQ40ICbje0LWcBvwk+85SC/nN84wphTwBsh6qG8WMkHdRONDcq
	tP13IrKX8uK9BMrSSqWeRWfyP+tzqCZUOAxEtMRsl/Eje15PIbKHfH1mTy0B9fwg
	7396TFSKrKUryg8KWgUkbD9WPIyS2MVcHaF5npdPk6uZmYuVwsBL7R5/KVhUy9k2
	YEBColamT3SYPXLJpefu6ocO+0Bjhpnuf512pqcnJptWMJjo4WsMETCf18YODzfg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5hhhy7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 12:40:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68E9o4nN2133360;
	Mon, 14 Sep 2026 12:40:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnk9j5ukq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 12:40:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68ECeNqY44106138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 12:40:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E5412004B;
	Mon, 14 Sep 2026 12:40:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E53C620043;
	Mon, 14 Sep 2026 12:40:22 +0000 (GMT)
Received: from [9.111.205.105] (unknown [9.111.205.105])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Sep 2026 12:40:22 +0000 (GMT)
Message-ID: <f2fda4cc-1ba1-4944-91e0-00c4ff91b2f9@linux.ibm.com>
Date: Mon, 14 Sep 2026 14:40:22 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 12/24] unwind_user/eh_frame: Remove .eh_frame[_hdr]
 section on detected corruption
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-trace-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-13-jremus@linux.ibm.com>
 <20260821201820.81B8D1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260821201820.81B8D1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE3OSBTYWx0ZWRfX3J4bRieoXKE4
 NkCh4AArl1+65uAUtnuThRJ3lUVt2X/BIuFWq0jkX1JaRLHjMmD5LQeSlCE3pY37t/BzjN3HgqI
 ilogZ+mT/ioFYN5xvd3AClSTIB9ipgeEMYVU1qo2NU6l+tBS8pAtdXjzIzMvG0x0gxO78fAgie6
 yj/QcoMv3ldTei3L1Pb+LVF9Dkw78bHr9ajgccJpdA2dXGekINN0V8IPekYwKcqR6k6zYhGapUM
 ymlEH9aV6Be9HMqd376F4uZ2KfU0ny0k5l2Kqh/vhucTn88P0HftU0a8EvncY9l/vWMu8MruojZ
 CeGXQZzx1XEgV7bRvi7y6vVvQlG1FWKkyjFrhDFiTj0wwbKCNeoDo+p7eGZpsxgKApqkQeU9s+9
 dr3XXR7izArlURY3jQA3mksangWIjeN88uYzB/snmGR9nZeQM31BIJV5X6OXweIrs+hlJgsHc1G
 LcR56jB4tcWHn9sJdjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE3OSBTYWx0ZWRfX39PZNQi/X9fu
 C0/nSqGyqSHckwMqBC6UkI947nB207ZaGraZh/RDwoZRS1n/sfq8WaaM0nRza4pAVd4RX0RZEmH
 8LT8NRdKz1ZeMA+mtbFY+VTtMrU0lV4=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aa7eb3c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=PwxMS5Maa9_4Qu9rs20A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dKC0FBrvRtzc56uzBVVPmQQTqZQVqWVb
X-Proofpoint-GUID: dKC0FBrvRtzc56uzBVVPmQQTqZQVqWVb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140179

On 8/21/2026 10:18 PM, sashiko-bot@kernel.org wrote:

> This commit adds logic to unregister .eh_frame or .eh_frame_hdr sections on
> demand when corruption is detected during lookup. This prevents repeated
> attempts to parse bad unwind sections by removing them immediately upon an
> error return.

>> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c

>> @@ -1202,6 +1202,15 @@ int eh_frame_find(unsigned long ip, struct unwind_user_frame *frame)
>>  	if (!ret)
>>  		ret = __find_frame_row(sec, &fde, ip, frame);
>>  
>> +	/*
>> +	 * Unregister .eh_frame[_hdr] in case of an error,
>> +	 * e.g. EINVAL (corrupted) or EFAULT (inaccessible).
>> +	 * Keep if ENOENT (not found) or EOPNOTSUPP (unsupported CFI).
>> +	 */
>> +	if (ret && (ret != -ENOENT && ret != -EOPNOTSUPP))
>> +		if (eh_frame_remove_section(sec->eh_frame_hdr_start))
>> +			dbg("eh_frame_remove_section() failed\n");
>> +
> 
> [Severity: High]
> Does this introduce a race condition with memory unmapping and mapping?
> 
> If a thread is delayed after retrieving sec in eh_frame_find(), another
> thread could unmap the library and map a new library at the exact same
> virtual address, registering it with the same eh_frame_hdr_start. When the
> first thread resumes and fails to parse against the new memory, passing the
> virtual address sec->eh_frame_hdr_start to eh_frame_remove_section() seems
> like it would unintentionally remove the newly loaded, valid library's
> section.

I don't think that is possible.  eh_frame_find() and likewise
eh_frame_remove_section() both guard using eh_frame_srcu.  So while one
thread has a reference to a section that cannot be removed and replaced.
I am missing something?

> 
> [Severity: High]
> Is it safe to assume -EINVAL always means corruption?
> 
> Looking at __do_cfi_program(), it also returns -EINVAL when kernel limits
> are hit, such as exceeding EH_FRAME_CFI_INSN_LIMIT or
> EH_FRAME_MAX_CODE_ALIGN.
> 
> If a valid library simply has a complex function that hits these limits,
> wouldn't this code globally and permanently disable unwinding for it by
> removing its section?

Following are the used conventions:
- EINVAL: bad .eh_frame; section should be removed
- EOPNOTSUPP: unsupported .eh_frame
- ENOENT: no .eh_frame for IP

One can argue whether a CIE/FDE with too many CFI instructions should
be considered bad or unsupported.  For now I decided for bad, to
prevent future unwind attempts in case of crafted .eh_frame.

> [Severity: High]
> This is a pre-existing issue, but looking at eh_frame_remove_section()
> which is called here, is there a memory leak if mas_erase() drops the lock?
> 
> eh_frame_remove_section() holds mtree_lock and iterates via mas_for_each().
> It calls __eh_frame_remove_section(), which calls mas_erase().
> 
> If mas_erase() needs to allocate memory via mas_nomem(mas, GFP_KERNEL), it
> can drop the tree lock. If a concurrent thread inserts a new section
> covering the same range during this unlocked window, mas_erase() retries,
> erases the new section, and returns it.
> 
> __eh_frame_remove_section() then sees the returned entry doesn't match sec,
> returns -EINVAL, and skips call_srcu(), potentially leaking the new section.

Help!  I fail to understand how the (internal) maple tree locking and
its advanced API are then supposed to be used correctly to iterate over
the items in the tree and remove some while doing so.  Is that why other
users use an external lock (MT_FLAGS_LOCK_EXTERN, MTREE_INIT_EXT())?
See MM_MT_FLAGS.

> [Severity: Critical]
> This is a pre-existing issue, but looking at __eh_frame_remove_section()
> called by eh_frame_remove_section(), can a memory allocation failure lead
> to a use-after-free?
> 
> If mas_nomem() fails to allocate memory during mas_erase(), it sets an
> error state and aborts without removing the node, but still returns the
> original sec:
> 
> __eh_frame_remove_section() {
>     ...
>     if (mas_erase(mas) != sec) {
>         return -EINVAL;
>     }
>     call_srcu(&eh_frame_srcu, &sec->rcu, eh_frame_free_srcu);
>     ...
> }
> 
> Because __eh_frame_remove_section() only checks if the return value does
> not equal sec, it misses the error state completely. It then calls
> call_srcu() to free the section while the node remains active in the maple
> tree. Could subsequent calls to eh_frame_find() load and access this freed
> memory?

This is resolved in the next version of "[RFC PATCH v2 08/24] unwind_user/
eh_frame: Store .eh_frame_hdr section data in per-mm maple tree".  See my
respective reply.

> 
>>  	return ret;
>>  }
>>
> 

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


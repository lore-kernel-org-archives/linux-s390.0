Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CA7368D7E;
	Fri, 11 Sep 2026 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139909; cv=none; b=OAMveDLtjGelmiFoD0656DF4/wkWztfWIWmVMqM0Hxt9dJvGKov1aSnsCgILmx8Qxc0/X/3png3aApoKmK8o6YUtjJ54OKtfSPRbQ79/9qJjNTjRwCefWAIO8xkEpbACtbtOdPEKyQY3L2ynTtE6Nz/XhFSAazDv4rojx8vW56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139909; c=relaxed/simple;
	bh=EmcvLDNd0Paz7dTy2pySpcGOrrthTH7KTzUaOeq+0zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtHwlJGeaKGJJef+Q7k1qLLu5bKv5Ffuz4rooKFs0gEKXBo69XPypas11u/DP8OQB9LhSdIeJoxLO7jXDbUvIFe5qW66nNCsWYtQpGgb+8dGtEqW4JhA+jhwNjF2rIqT0dHzmLK9NKblJoMOJ9hQiuRR+1Lfwf5QmDmKoI96dvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kaPjB6sD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kaPjB6sD"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BF1Wlp235551;
	Fri, 11 Sep 2026 15:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=frXvLE
	F9zGLwcmL0j8JCZ1dJCCZ5gp4kGM/fUAe0N+I=; b=kaPjB6sDiLQGbqbzW5QBbI
	fFZhCAcRyQkD5lzY3IjSlFBNN6xLiKenbXmBgSumm+Vdz5IZFger1nVQdU1CUKo6
	6jJPgppWtb73JGM3XhCMaENXoLcJZGuT57WNYQgvyBDk0Cwdg11vykZPOeanvezf
	eTvM8pd6KgMaCyWOlleGBQqW5G10vsZEAZKnC95KCGM26Y6YPRGT4SAGNLQky7D5
	+VMJIeCRNIpws8aXY1+73NfggINxgL2EdBCNWQ4SMlICIeWnATS9d6xx3NkM2zSi
	bDhLBEUSQWJIh9UgVblM+QotYpO/6vv59lnWlP9t5BDUgeTCeet4DyYVev88wy9Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8ncb6n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 15:18:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEo81V1764851;
	Fri, 11 Sep 2026 15:18:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvvrf0aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 15:18:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68BFIHgf16253426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 15:18:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D160A20043;
	Fri, 11 Sep 2026 15:18:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D9C42004B;
	Fri, 11 Sep 2026 15:18:17 +0000 (GMT)
Received: from [9.111.140.161] (unknown [9.111.140.161])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Sep 2026 15:18:17 +0000 (GMT)
Message-ID: <ae89a482-96ac-46ee-87a8-6d850035206b@linux.ibm.com>
Date: Fri, 11 Sep 2026 17:18:16 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 08/24] unwind_user/eh_frame: Store .eh_frame_hdr
 section data in per-mm maple tree
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-trace-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-9-jremus@linux.ibm.com>
 <20260821201338.86FF71F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260821201338.86FF71F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NMVAaE6g c=1 sm=1 tr=0 ts=6aa41bbf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=LFt20mCCc4CE-LtB3JUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jGKOmhl9wkzpTvGwodVpf0hrsp2vwaEB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfXzp87lMWBlOoY
 cl2U5Qrrgb6Ng/+xPbOwRh+6nk4fdcuTjqQaaIDQh3kGuhIj3v533eBYApe4GWHbPj/UjGMT17m
 PmXkcCCrGc+OsWKwQiZmf6TLy9QF4e7PO1dOcqozhnY4OOSsVj6G6czU9dQZx1z1XdNtdtL/ElP
 0E9s8pL1eRU0Og77pxNIdSTCOzj567g0PvcVzPcLsd7ANnIHiuU/3xj2M6dLG81AJ4qxn4G25gc
 nlrpowJWyEPwbrz8/hIWsMjHUVjg753lkfg6bqV8XmaCiAPZkS9JbU5i7wZWeoIWaEk3qdWEne6
 U8ljVMDiAMa+4LMX3KkwmW3Q773797rTStRGfo/x3waCi72HGhWoCz7FsXm0M2cEeM6mvnb20eg
 LIdxC/G0JngtR5lk63SHNMYyvPt3sa11pMvl03Fydjy5+x6dftqVEfIptyjI6omo5H8hsHt0myJ
 43GlTyzN4xwdGjLamKw==
X-Proofpoint-ORIG-GUID: jGKOmhl9wkzpTvGwodVpf0hrsp2vwaEB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfX+K7JrA9iOC/Z
 RClIyK63kNp9LxwRJyFpmRtOUSXJF50G2Q3yvJomrPdeNkE2wX9n6QYcaBzbMPH+3rBIChP9F7h
 tERmdtMQy58TNDl86snIda3yxNdYeeM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110210

On 8/21/2026 10:13 PM, sashiko-bot@kernel.org wrote:

> This commit associates .eh_frame_hdr sections with their mm_struct by
> adding them to a per-mm maple tree. The tree is indexed by the
> corresponding text address ranges.

>> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c

>> +static int __eh_frame_remove_section(struct ma_state *mas,
>> +				     struct eh_frame_section *sec)
>> +{
	struct eh_frame_section *erased;

	erased = mas_erase(mas);

>> +	if (mas_erase(mas) != sec) {

	if (mas_is_err(mas) || erased != sec) {

>> +		dbg("mas_erase failed: text=%lx\n", sec->text_start);
>> +		return -EINVAL;
>> +	}
>> +
>> +	call_srcu(&eh_frame_srcu, &sec->rcu, eh_frame_free_srcu);
> 
> [Severity: Critical]
> Can this cause a use-after-free if the maple tree erase operation fails?

Seems valid.  Fixed in next version.

> 
> If mas_erase fails due to memory exhaustion (for example, during tree
> rebalancing), it leaves the entry in the tree, sets mas_is_err(mas), and
> returns the pointer to the entry.
> 
> Because it returns the entry pointer, the condition mas_erase(mas) != sec
> will evaluate to false, skipping the error block.
> 
> The code would then proceed to call call_srcu and free the section while
> it remains linked in the maple tree, potentially causing a crash when the
> tree is traversed later. Should this check mas_is_err(mas) instead?
> 
>> +
>> +	return 0;
>> +}

>> diff --git a/mm/init-mm.c b/mm/init-mm.c

>> @@ -48,6 +49,7 @@ struct mm_struct init_mm = {
>>  #endif
>>  	.flexible_array	= MM_STRUCT_FLEXIBLE_ARRAY_INIT,
>>  	INIT_MM_CONTEXT(init_mm)
>> +	INIT_MM_EH_FRAME
>>  };
> 
> [Severity: Low]
> Does efi_mm in drivers/firmware/efi/efi.c also need this initializer?

Steven, Josh, I doubt that is required.  Do you agree?

Otherwise tboot_mm in arch/x86/kernel/tboot.c would be affected as well.

> 
> When a new initializer like INIT_MM_EH_FRAME is added to init_mm, it usually
> needs to be added to all static mm_struct definitions.
> 
> Leaving it out means the eh_frame_mt maple tree inside efi_mm remains
> zero-initialized rather than properly initialized with MTREE_INIT, which
> might lead to lock splats or crashes if accessed.

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


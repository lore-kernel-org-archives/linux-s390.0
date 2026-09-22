Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00AC538D98;
	Tue, 22 Sep 2026 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075204; cv=none; b=oyB70H5I/yesJoY9vOSC83I1CzseT6DLk2MAgd5irPnV8vjY/kNN8Qf3fCxTdEtzfw0MPJ8Ab8xUhV0hS59mhxJ0FRhn5a4faMMWzKKH46OBDCJBfxzYaRxgKZ+/34FLMz80VtTwuIeYsOULbNhMTvbUjv0Jm1OqseAWDJmBAs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075204; c=relaxed/simple;
	bh=xE8yN2TE+QvX43yPNYcBeUMHkW5PVSRTfEg/0N5TuSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PrXKkwQUbSRFmu9guOWWxfAURJDX6y/P14o9OqfJYQW/R+YLQDW6D9leJYrkJmwPjaDLFgmKqijGwlrIH4YFvfh8vEZxV5XmJNY8TUaVQIrH9461xT8zbk6w8NBDYXif2sy9oEc1ypfP4jfdNtmRnhwCADK3tdTdpBK6ythQKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OW2BZS6J; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OW2BZS6J"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M05w5j2949345;
	Tue, 22 Sep 2026 11:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qNR+K5
	DeZWG2i/T1RSGffb3dllQtMZp/bwKOxwUn4XM=; b=OW2BZS6JX1FGzgcKNJ64yN
	PmlArQtnECFhB3EWENroyp8VR0gxuCtVrv8vMT1h/xEn/Pyd1nhbGn2XCzDICfBh
	rd6rfCBLJZsozw28k3K6QIOGIkwX8PHrM8VjuR0DMIACLxy4WcANKZM2zwfqqK3F
	LwIBbeiIOvLZW1nV8GlqpKx1bBs1v2qFz9sBQ8jrAnxNHrWoZ7WcUUH8i+scEfTW
	uJiUvJWj89zZoO9x6thdfkixlhllKbZB6C7yvW4f73fXeK6OWA/boq07LC8a4yaH
	IC4M0GGDITUHEofRhbocDRwNJ3komiaTrGYYWi8iNH5baM59FiB8rxyWCblz1Zlg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs5b4c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 11:06:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MAG50g764401;
	Tue, 22 Sep 2026 11:06:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkc26s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 11:06:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MB6afA42074372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 11:06:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D5EC2004B;
	Tue, 22 Sep 2026 11:06:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E95EA20040;
	Tue, 22 Sep 2026 11:06:35 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 11:06:35 +0000 (GMT)
Message-ID: <1ae860b1-6aaf-4930-a571-8d8cc7a5c461@linux.ibm.com>
Date: Tue, 22 Sep 2026 13:06:35 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/uv: Rework page allocation for guest variable
 storage area
To: Heiko Carstens <hca@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260915144307.2367089-1-hca@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260915144307.2367089-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab26140 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WZdyr50IRSPTGao3C8IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tz4D_sfIADCO0qhN6CVjqBDevddrNPdo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE2MCBTYWx0ZWRfXyU6roT7CCYgT
 uF0xeMi2acvWYIHX5Rz3RO7M3Zh7B0w8ZgmgOvhqxi3sS2hOLZJNcNy8IkhjdtC16XMM8GtvsNg
 4hukspwWQPiChSoGF+xry6mGJMrS98iT5rRBJGvhGPEGM4q93UiXyaftsF5ColbDSscO6EsiS4l
 +Zugl+m4L7xCDEmZLgvidw5UhN4LwrCcXnFMhkvmmg4EML3ncA6Fx8jml2h/IUQLKuAJqpQ9AHj
 Rh+SuC1y+N+w7k0dDJc4hSpvFbfcaxsH0WG8mFKnuxtJPvspk0KEGG7kVGso8EIVeZdna6q90I6
 gnzRZUu+J2UwOJckwAR9JPeADRPAQPMt474NzAwILypHokgBtX+QaS8G/ByX1EQDyq0ne6OSsXW
 pEqWlLAbfI7W6MHMuv3DrPXhC7wiZEcauxk5Yp26ZM+SEdpzaqVyrcyApexZsC82gNTbMcGKLl1
 fqAsGBE20ozJ5meWlSQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE2MCBTYWx0ZWRfX6lSlNrePWOnH
 kLxPsNda5IKsJGBdsZsFUkEbcYsZiV9Dvs8aJr+sIW3Xl74/c/CkkubGxvC/L1dQyx4V2OlAO1a
 qLJy5+/wNWtoQzpLnQaGIfdCG4DHAkU=
X-Proofpoint-GUID: tz4D_sfIADCO0qhN6CVjqBDevddrNPdo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220160

Am 15.09.26 um 16:43 schrieb Heiko Carstens:
> Alexander Gordeev reported that the allocation of pages of the
> guest variable storage area via the uv_alloc_range_cb() callback
> of apply_to_page_range() will cause problems as soon as s390 fully
> supports lazy mmu mode.
> 
> Problem is that uv_alloc_range_cb() allocates pages with GFP_KERNEL while
> preemption would be disabled. This would result in reports like this:
> 
>   BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:322
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6092, name: qemu-kvm
>   preempt_count: 1, expected: 0
> ...
>   Call Trace:
>    dump_stack_lvl+0xae/0x108
>    __might_resched+0x1de/0x2f0
>    prepare_alloc_pages+0x1ba/0x220
>    __alloc_frozen_pages_noprof+0xc6/0x390
>    alloc_pages_mpol+0xe6/0x220
>    alloc_frozen_pages_noprof+0x5c/0x80
>    alloc_pages_noprof+0x22/0x80
>    uv_alloc_range_cb+0x30/0x300
>    apply_to_pte_range+0x11a/0x3b0
>    apply_to_pmd_range+0x13a/0x250
>    __apply_to_page_range+0x232/0x4d0
>    apply_to_page_range+0x28/0x40
>    uv_alloc_stor_var+0x5e/0x90
>    kvm_s390_pv_alloc_vm+0x118/0x1e0 [kvm]
>    kvm_s390_pv_init_vm+0x84/0x2e0 [kvm]
>    kvm_s390_handle_pv+0x502/0xf70 [kvm]
>    kvm_arch_vm_ioctl+0x234/0xdd0 [kvm]
>    kvm_vm_ioctl+0x33a/0x890 [kvm]
>    __s390x_sys_ioctl+0xfa/0x130
>    __do_syscall+0x1fc/0x700
>    system_call+0x72/0x90
> 
> Preallocate the pages and make use of vm_area_map_pages() to address this
> potential future bug.
> 
> Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Closes: https://lore.kernel.org/all/e9449c63-b8d2-4ed9-a184-7dcab3e8dfce-agordeev@linux.ibm.com
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>


Thanks applied. Will queue for the kvms390 tree after some CI runs.

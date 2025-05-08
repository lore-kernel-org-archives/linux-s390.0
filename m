Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812C1252917;
	Thu,  8 May 2025 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714034; cv=none; b=ZcY2bziM4I4gp9IFN5edIi1p3hfYow4V8M+Vw5V9zURFnUgNl3jGkJn/xsG6k3eKOPNogvAIkAFvIG829ANddWTT+qGWmqqVTwGRKtVvQrUXSKp+CItCew4z3RunwN/uKP0C+ihKrMfXLpPofT5mzluLNoUnjwduTpJgVU+EF2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714034; c=relaxed/simple;
	bh=cHhpldTiS697heQ8jF9oq0lqdYe2XmA+Hedchz/5inI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifS+u50nIibhfsjva7u/gP8pvzWEtB8IFiMGCvPZvCc7g7Y+rr8QmF0dtazhcJxjbCczxD3eFQMPii0EOeaoZlPRg/2PFEjwnZvrICgwZeDCfkERGtyLbtg9pMLpSiQXBNo2eRff31Y2qAlSDn/XuYB4uaQPzeWvu4Qd8887pdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ahmO8JKY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ahmO8JKY"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5488t3A5000532;
	Thu, 8 May 2025 14:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=oBsvYhNSfnnaJukBuPXgWSSmMLLdrg
	zw30jITZiQdG4=; b=ahmO8JKYKhBmI3cDYqsO9sryMnry5RVYsdK/gH8I87KX19
	3cDp9fzQDuvnX5pWOZs9afep7q9vC6VYN7DzTWRUgCFwYQQ66e2EWOwCahmjuJGE
	hi/ZWkGtlnmNZZddriDLnkRoYpbKZiTQcLW4aZuYrBGDbhwdwZRS1u7T8Pilo5ry
	+rOAMaAcQH5IdxlaV45lQWP6sKyR7FfQfqi5aYqVFGmx9hY5qyUVevYr5ZuYBfro
	2wPvA1//936BbzkKp0UpJ4sxtcc8JxUX4w3RNW/PgusPVj0eNGHSTvIxy1R8GuBr
	AOqR+Z2pOASHNHOoyYSpcKRwobscrlwQ25Da1NkQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gf3kv4ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 14:20:25 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 548EKHbJ015305;
	Thu, 8 May 2025 14:20:24 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gf3kv4r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 14:20:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548AWdIk014167;
	Thu, 8 May 2025 14:20:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dypkwwds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 14:20:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 548EKMqU19464472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 May 2025 14:20:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DBE020049;
	Thu,  8 May 2025 14:20:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE59920040;
	Thu,  8 May 2025 14:20:21 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 May 2025 14:20:21 +0000 (GMT)
Date: Thu, 8 May 2025 16:20:20 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Daniel Axtens <dja@axtens.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v5 1/1] kasan: Avoid sleepable page allocation from
 atomic context
Message-ID: <aBy9pJdTyzBgOjSE@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1746604607.git.agordeev@linux.ibm.com>
 <0388739e3a8aacdf9b9f7b11d5522b7934aea196.1746604607.git.agordeev@linux.ibm.com>
 <20250507170554.53a29e42d3edda8a9f072334@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507170554.53a29e42d3edda8a9f072334@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -h_qaOlO55CQud-hrKmm4MIkNdoM9j99
X-Proofpoint-GUID: gcKNb_I5z1L24ObaFP9ozqtSONUBoIu-
X-Authority-Analysis: v=2.4 cv=S/rZwJsP c=1 sm=1 tr=0 ts=681cbda9 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=7KtnEDDS5azdv5-FDD4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDEyMCBTYWx0ZWRfX5oNAmmUKn7st aBprH6+/8ICoXf2xtBa1OybNs5VHbsc1PgZiQQaXRxNpptOIGEebBmzUduBFL97Qn7WoBMKTN0b KgxCRv7P4hRcRhGcTSrdszynjtf3GvXmsc30SBjxIinhbWaPHb8bQswJANOFDKkrET6X8njm+mx
 W5w2sFtK++5/QhyNq2/sWV9UD/Y+JKGE7pqic4pQ5UR0sIooglrxbnck2WmnKiiFajLN5aRjgxx KAGWZy4Aske4EdnMGi7q4u0CRSzIb0BYZsCOqm1Sot9SiRS9bIpj9x+buaI5yYZWPXsj8BY0pCS UN7akEO1hWCHmc3iA6C6FWhkwm1xz1wxGLI07XiymUhszPHsJZHWoV8X+sPLdIhYnJfux4Y/1B+
 rbJcnUXxLMDR2+lzhUKkVzl31gyOAtq2y87uuBkdn1v/qlcxLmMMU7v+AGZ30dgS8g0p0sN6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=723
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 clxscore=1015 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080120

On Wed, May 07, 2025 at 05:05:54PM -0700, Andrew Morton wrote:
> Is this a crash, or a warning?  From the description I suspect it was a
> sleep-while-atomic warning?

Correct, that is a complaint printed by __might_resched()

> Can we please have the complete dmesg output?

I posted v6 with this output:

[    0.663336] BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:321
[    0.663348] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2, name: kthreadd
[    0.663358] preempt_count: 1, expected: 0
[    0.663366] RCU nest depth: 0, expected: 0
[    0.663375] no locks held by kthreadd/2.
[    0.663383] Preemption disabled at:
[    0.663386] [<0002f3284cbb4eda>] apply_to_pte_range+0xfa/0x4a0
[    0.663405] CPU: 0 UID: 0 PID: 2 Comm: kthreadd Not tainted 6.15.0-rc5-gcc-kasan-00043-gd76bb1ebb558-dirty #162 PREEMPT 
[    0.663408] Hardware name: IBM 3931 A01 701 (KVM/Linux)
[    0.663409] Call Trace:
[    0.663410]  [<0002f3284c385f58>] dump_stack_lvl+0xe8/0x140 
[    0.663413]  [<0002f3284c507b9e>] __might_resched+0x66e/0x700 
[    0.663415]  [<0002f3284cc4f6c0>] __alloc_frozen_pages_noprof+0x370/0x4b0 
[    0.663419]  [<0002f3284ccc73c0>] alloc_pages_mpol+0x1a0/0x4a0 
[    0.663421]  [<0002f3284ccc8518>] alloc_frozen_pages_noprof+0x88/0xc0 
[    0.663424]  [<0002f3284ccc8572>] alloc_pages_noprof+0x22/0x120 
[    0.663427]  [<0002f3284cc341ac>] get_free_pages_noprof+0x2c/0xc0 
[    0.663429]  [<0002f3284cceba70>] kasan_populate_vmalloc_pte+0x50/0x120 
[    0.663433]  [<0002f3284cbb4ef8>] apply_to_pte_range+0x118/0x4a0 
[    0.663435]  [<0002f3284cbc7c14>] apply_to_pmd_range+0x194/0x3e0 
[    0.663437]  [<0002f3284cbc99be>] __apply_to_page_range+0x2fe/0x7a0 
[    0.663440]  [<0002f3284cbc9e88>] apply_to_page_range+0x28/0x40 
[    0.663442]  [<0002f3284ccebf12>] kasan_populate_vmalloc+0x82/0xa0 
[    0.663445]  [<0002f3284cc1578c>] alloc_vmap_area+0x34c/0xc10 
[    0.663448]  [<0002f3284cc1c2a6>] __get_vm_area_node+0x186/0x2a0 
[    0.663451]  [<0002f3284cc1e696>] __vmalloc_node_range_noprof+0x116/0x310 
[    0.663454]  [<0002f3284cc1d950>] __vmalloc_node_noprof+0xd0/0x110 
[    0.663457]  [<0002f3284c454b88>] alloc_thread_stack_node+0xf8/0x330 
[    0.663460]  [<0002f3284c458d56>] dup_task_struct+0x66/0x4d0 
[    0.663463]  [<0002f3284c45be90>] copy_process+0x280/0x4b90 
[    0.663465]  [<0002f3284c460940>] kernel_clone+0xd0/0x4b0 
[    0.663467]  [<0002f3284c46115e>] kernel_thread+0xbe/0xe0 
[    0.663469]  [<0002f3284c4e440e>] kthreadd+0x50e/0x7f0 
[    0.663472]  [<0002f3284c38c04a>] __ret_from_fork+0x8a/0xf0 
[    0.663475]  [<0002f3284ed57ff2>] ret_from_fork+0xa/0x38 

Thanks!

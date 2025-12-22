Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6A335975;
	Mon, 22 Dec 2025 05:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766383140; cv=none; b=CPYAdZ8HAlD/R0qe5j046FeCBzvhquEFthyaqef7FBZQTr28ZRI/orWENNSCnpQdMCSwutdDOG/eTJAse2pPJHxmcOrkBqU8G+utZBX8Qv/FeWAwkQ4jbJuSRBarmeOOqGsCD4D/f28TQKnxXjnb3V+4gPuI/F4qrto3IS2jD2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766383140; c=relaxed/simple;
	bh=PVcvE25fzvsqUqk559YtluBqlIG9wllAU+kMVxPj42Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kn6wlwpjk2cB5tmjnr+eXJbJBE3VedkluAUOfbOe2z6ynNhRYoG4AF8YIphqj0NAUHZQWoJNKRhyWZmUoajSnOTnWJEf/My0d9VZ7Kz7Af0fxGCovKQS4Ldc241g7Wp0F+3/R1yZg4t3vxh1yVn9stclx1QQjA7UZgiND32WFKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cWL4iAVT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cWL4iAVT"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BLMhAvZ015053;
	Mon, 22 Dec 2025 05:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=X5EzYw
	+0qS6x7IrbJAsEhyBmKheOYvSaiiPnOy2Yisc=; b=cWL4iAVTUeG+ss+exyWDmA
	jq1KKOYYvyzpMuLMuIP52jZXxEB+i2/nFwWl2aqwXGPcKuT5lrYrshqrVZ7UiKEc
	2pMrlDC0iCfzng+RqQ+BQBMl4Muv/w+2xK6/5Zmdyj9d9Zv7VAiePHkWEz+5Zf1r
	ExZilm2QakhmCC7YUerpE9rikXFyzHPYjsb3tjaQiFpxBPsT6cGwJd2vhzQnHyaX
	RK/U0LeWaRiFrM8WVvQ1iJ+txWE4ZMRPl8PQK1rcCeUU75YDWOqJ7aHYDrbLkHqA
	HaKMjOLoqT7wsIZF8YQwZGC2v0JWLFxpZatC3QUQuvDEaU42T3ZR73t8oKUR9TzQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5ketp63e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 05:57:45 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BM5vbec022706;
	Mon, 22 Dec 2025 05:57:45 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5ketp637-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 05:57:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM4BkcY001099;
	Mon, 22 Dec 2025 05:57:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b664s4ngg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 05:57:44 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BM5vc8m50397562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 05:57:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 129FC20043;
	Mon, 22 Dec 2025 05:57:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC49620040;
	Mon, 22 Dec 2025 05:57:33 +0000 (GMT)
Received: from [9.124.208.188] (unknown [9.124.208.188])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Dec 2025 05:57:33 +0000 (GMT)
Message-ID: <16fef7a5-6853-4a6f-8d27-e005fa351eb7@linux.ibm.com>
Date: Mon, 22 Dec 2025 11:27:32 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] mm/hugetlb: ignore hugepage kernel args if hugepages
 are unsupported
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        "David Hildenbrand (Red Hat)" <david@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        x86@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20251221053611.441251-1-sourabhjain@linux.ibm.com>
 <87a4zcml36.ritesh.list@gmail.com>
 <655cc605-2ce1-4ccb-8cc0-a0a31a9c89fd@kernel.org>
 <87fr93ky5i.ritesh.list@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <87fr93ky5i.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HO9Y3xTMJbvw0LSrOOB0LjX7yn-FHs35
X-Authority-Analysis: v=2.4 cv=Qdxrf8bv c=1 sm=1 tr=0 ts=6948ddd9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=L2GzoeH3I7b4KdntMNgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9hic2OIlQ0QN3dNT0_DvKxFRKKtPor_n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA1MCBTYWx0ZWRfXx8qB1vId+1x7
 WH+r8WETKkHWnVlj5bSDn+RRQbheu8D+YozSZTmQKwmrjFw76JydBoKwfMEnznwRLC8VZsqpMmF
 JrIFwmXM4HYSApxOkQsp8Sa4PXCgxgdk4M9LmuzDtuT6eso3k5Zyr9Po0TKilPVlNAkWKc4mDxt
 s38D3+6/KI1g3ppSW6jCBeOP4WGzKWHSWOjxSZ1ulIB3pmhciF6IzgCtYBR0lA+4jjS5HZAdHoi
 PJzKZkaf2yC3Hc22u+yyjbH/2jfyowsSQys6UrvqFL+nUT0ksKtGCdHSg2bdxv+kAWaDjvMrGSg
 afs4DZ4ft8OZRZC72sIg6tVq0vIab+Pu+8RWF6/iwA7tGIekzrvl66XqgKlWG+/c0+tDqqOCq+0
 CuT3KaT27TXnbbej7xlc2ZEkDq6rB0Bpc2RXeqkCD1zWNDURuE5sSlLgU0mhPvquLuVDXDh5/fd
 fTtWNz5S/Yd1xpQGjOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512220050



On 22/12/25 08:42, Ritesh Harjani (IBM) wrote:
> "David Hildenbrand (Red Hat)" <david@kernel.org> writes:
>
>>> Coming back to the fixes tag. I did mention a bit of a history [2] of
>>> whatever I could find while reviewing this patch. I am not sure whether
>>> you have looked into the links shared in that email or not. Here [2]:
>>>
>>> [2]: https://lore.kernel.org/linuxppc-dev/875xa3ksz9.ritesh.list@gmail.com/
>>>
>>> Where I am coming from is.. The current patch is acutally a partial
>>> revert of the patch mentioned in the fixes tag. That means if this patch
>>> gets applied to the older stable kernels, it would end up bringing the
>>> same problem back, which the "Fixes" tagged patch is fixing in the 1st
>>> place, isnt' it? See this discussion [3]...
>>>
>>> [3]: https://lore.kernel.org/all/b1f04f9f-fa46-c2a0-7693-4a0679d2a1ee@oracle.com/T/#m0eee87b458d93559426b8b0e78dc6ebcd26ad3ae
>>>
>>> ... So, IMO - the right fixes tag, if we have to add, it should be the
>>> patch which moved the hpage_shift initialization to happen early i.e. in
>>> mmu_early_init_devtree. That would be this patch [4]:
>>>
>>> [4]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2354ad252b66695be02f4acd18e37bf6264f0464
>>>
>>> Now, it's not really that the patch [4] had any issue as such. But it
>>> seems like, that the current fix can only be applied after patch [4] is
>>> taken.
>>>
>>> Do we agree?
>> I think we should document all that in the cover letter, an describe
>> that this partial revert is only possible after [4],
> Yes, I agree. Let's add the above details in the commit msg.
>
>> and that that must
>> be considered when attempting any kind of stable backports.
> Sure. I would prefer if we change the Fixes tag to the one which I
> pointed in above [4] (with explaination in the commit msg). However I am
> still ok if we would like to retain the existing fixes tag and show [4]
> as a dependency.

I think we should keep the current Fixes tag with an explanation for 
dependency
on [1] in the commit message.

Would anyone have a different view?

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2354ad252b66695be02f4acd18e37bf6264f0464

- Sourabh Jain

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1C746AF03;
	Thu, 23 Jul 2026 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784808539; cv=none; b=jx2PZDjoepAoGXiHRi0bu6ephDoD+HBNbrItwcRNHgNetxHB2wJySUG98rOzBok6EtnWzjcGP4rkYro2TsTCfwYNQVIleT37J6m2MB9HoyOvmmhJYA4+Bc8LeS7t8c7k3h8nsOeGlJCoTOhuSRLDYyzgOcB6NHJxzhJA24f5aK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784808539; c=relaxed/simple;
	bh=GCX3hdhb3zhp10ECYf+NDUHPZwPcDTK8B5Nj1rX+9SU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgziS8benX9KL+gswRGHSglchYGnRMOYO0VvqDXAMeicm6tdtdxJ97eO3IaswUI0vg1YMNUZsNBRB84eaObg0rCpXkgCNrL66re7axYzvjnOuVR1+c3+8NCDGeUBgHuqrcFYryjtKkS2r9cV0BcfELzCiTgLSidK67xfV7Xcvuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l21HmUL4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l21HmUL4"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9C0vt701930;
	Thu, 23 Jul 2026 12:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dwXjH6
	XMsFr2Bnpg9+BfG29Y7DzQP3hrT8n8vaTG2Kk=; b=l21HmUL44Dhu0UZip3Nfw+
	C9haY0GDpQCchi/QqQhJrV+2zkjMVVWxrq9wJks/iDvydmW7035sNfX4EiZ9AHJC
	vaVpN8hdwwgUdSA+JZIIMHgmReww74/qN6QxCLnxwhmNDXCAbGEaFee1QfhVG4kf
	KXJKluATVCD7cEgZMrfChsCn0yR1lrvFqLOdNPaVjzfiT4zGi/VytZFbfcOKKRoO
	ANmDofhaSuCWvO6UxUN9Y4hiN9pUwD5PuRt/sRxgtyEFJPjXOT/gvkxyokiDrkWo
	CNWfRLrRArPUrrp+AsY2jgSKrJhlT8PV75wIMx7rqUs9BmzZzMf4dVcxjAK4v6HA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77aqbdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 12:08:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NC4dLc024566;
	Thu, 23 Jul 2026 12:08:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gktug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 12:08:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NC8rgI54133186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 12:08:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3502E20040;
	Thu, 23 Jul 2026 12:08:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 164742004F;
	Thu, 23 Jul 2026 12:08:53 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 12:08:52 +0000 (GMT)
Message-ID: <ec4f7c44-d4f1-4649-a366-8ba59684375e@linux.ibm.com>
Date: Thu, 23 Jul 2026 14:08:52 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] KVM: s390: pci: Fix memory accounting for
 pinned/unpinned pages
To: Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-3-alifm@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260722170621.1686-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p4o_DELfTJK3hRN0RSawgfO5MGA9bzAu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDExNSBTYWx0ZWRfX1Y1KT4mKp//u
 4RjEETW3xfJMLaNB55l898S7QLuIRDRtkh3mNIgCjnWo5hJ6bWMq69/L1voKJnbwP0vsWAPh9CP
 jM6z3s7AF5K/ienXnQpQqKACdxhfkro=
X-Proofpoint-GUID: p4o_DELfTJK3hRN0RSawgfO5MGA9bzAu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDExNSBTYWx0ZWRfX79QBXhZRzdM8
 1vN6LrZJKc8V7Aib+P81WzmhQ2w3aqAZgwqOi2FFKbmCp338i7xnbKOar2SDdqCX727/fu+0mPL
 u8eS81W6BYYCxIfuxBi7a1bKS89roTWtG6Dk1YLJObwZUsg+BH8vjHPejymwXIB/5V+taE29O9E
 CxqC6KoqvXyUwdzX2lS1EqayWyQpmB2A3UkIdYySDqKhIRvUdAD5RtPImq0JNr4fWdGpoNQ3veb
 YeQcm+gnahNCFgzzBhUAxakvPfllfuqczSaQ8TZNrR8xZ5mgfSMA/F2h7ebUA87GeU5BX/Wqevl
 F5pM59ADZTPnMrrIbczCrvYhsMJJ7vIg/MmyqYLCdxpXhMgu8nGDAUnO/L975uZM3G69Txuylth
 zVd8DXjWLaAHzVeJIhIAOZg8KEQ3r/NDNukf1sxHUxvAPXaVgCheDsZ8gPhDXW2xWrwpTqFViqB
 ooe+In/V+Y9L4P+ewJA==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a620459 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=oRZ2JS9Q_Y4o1hTOu6gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230115



Am 22.07.26 um 19:06 schrieb Farhan Ali:
> The account_mem() and unaccount_mem() functions call get_uid() which
> increments the reference count of struct user_struct on every invocation.
> But we don't decrement the count by calling free_uid(). It also
> accounted/unaccounted the pages against the current->mm. But its possible
> the unaccount_mem() can be called from a different process context than the
> one that originally pinned the pages.
> 
> Let's fix this by storing the pinning process user_struct and mm_struct
> when accounting for pinned pages, and subsequently free these resources
> when the pages are unpinned.
> 
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>


[..]
> -static inline int account_mem(unsigned long nr_pages)
> +static inline int account_mem(struct kvm_zdev *kzdev, unsigned long nr_pages)
>   {
>   	struct user_struct *user = get_uid(current_user());
>   	unsigned long page_limit, cur_pages, new_pages;
> +	int rc = 0;
>   
>   	page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>   
>   	cur_pages = atomic_long_read(&user->locked_vm);
>   	do {
>   		new_pages = cur_pages + nr_pages;
> -		if (new_pages > page_limit)
> -			return -ENOMEM;
> +		if (new_pages > page_limit) {
> +			rc =  -ENOMEM;
                             ^^double space. I can fixup during apply.


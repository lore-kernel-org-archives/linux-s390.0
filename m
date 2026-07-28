Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0103938F621;
	Tue, 28 Jul 2026 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257244; cv=none; b=aImsavYh+MzlRNltkC9//vPMiBliTT4DwglMSq9kMht5dXQPj1twUUEISoI66jM7mM2VP0++4IZmnqg/MT66mq284+ZFF0jX1VLf3/eoNT1kcfJhYzv2QcC1XBzRXGFhbjwQxfojRo+BvuOXUDctB44bt6hGsN18utJ4sUqLBuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257244; c=relaxed/simple;
	bh=IsfoklXLjZ3wiCGOkKNy8f4UDtzPg8vIFAJ3pt6ORgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMLNZwken1sjxxxzhYnwjICTN8hmuKxdnUP4JqHzOqmohYshCoNnaXLs/WuY5lKenwyoDDYIgdXMJT07e7qcuQAmHkapKTDTlsoFvwp4YygGyGASA5KUeKjyS5tKPMMj9nZWz78XNI/ezS9Fj+quJxvQQT/Scl5CnYG6wY2ZO8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sslGsd7l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sslGsd7l"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SEm1Zw1491778;
	Tue, 28 Jul 2026 16:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2TXgiI
	MaRc9Arx+XD3uc7z32DgJVLuoSeEnd9446NDQ=; b=sslGsd7lhg0dhViY3UMDN0
	pTmb0cg2RVJKxDFZN63eiMkzQSJUGbPtBcX7IKXSjBO8YgBDVIDn3yP03x73HVfe
	L10fz0b+JrQaFtkQ4jWU1JCEWo2XsmRQSvdsGuTinKlViRzBIXBJsfCHoMZe4LIS
	vIB8UYpgc0vdGmWIK13j7GTwBg4HEjHSbWxzd0tola+3ebp048/TL0LSbPErDm4U
	TAOydUnduVjL8D5VKQRsG+mQDpeiBxPs23uirD12LM0xr5YbVZzwh+oYCjJSCdaR
	MdQSiFx5PG3cY/b2rmg9xAQBmq+uRwuGMWRE2wszzn9Q3J7a83w7YjHGnD3CsXBA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xpe8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 16:47:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SGfFbe019188;
	Tue, 28 Jul 2026 16:47:12 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgan4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 16:47:12 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SGkY7x26673744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 16:46:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C955C58052;
	Tue, 28 Jul 2026 16:47:10 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8923858067;
	Tue, 28 Jul 2026 16:47:10 +0000 (GMT)
Received: from [9.61.248.127] (unknown [9.61.248.127])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 16:47:10 +0000 (GMT)
Message-ID: <cfbae0ef-51b3-4e5c-b9e9-9a9289dacd90@linux.ibm.com>
Date: Tue, 28 Jul 2026 11:47:08 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] KVM: s390: Fall back to short-term pinning in MAP
 ioctl
To: Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: david@kernel.org, svens@linux.ibm.com, freimuth@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260724133943.1664961-1-jhkim@linux.ibm.com>
 <b099b7bf-31c6-40ec-a43f-9081f2c64195@linux.ibm.com>
 <eb8e8909-1e0e-4144-988d-05be9221e2b8@linux.ibm.com>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <eb8e8909-1e0e-4144-988d-05be9221e2b8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lvCV0XwuEmMDBF02ohP8oTwNSqMX4sDP
X-Proofpoint-ORIG-GUID: lvCV0XwuEmMDBF02ohP8oTwNSqMX4sDP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfXy3ehGnQHEwZU
 zte0IP0lQefmuYIWTdECwo48VXYsxCG0RY2sGbiApAnGdMmCSnZNM6mvUTEUJf6roHeHh2GzaWf
 UStvZMYXcX6+MdO71MP3IjCmdwHrVy8=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a68dd11 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=EBKGDvUYjlEhDsWVOxYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfX7t6K9cWf9RSG
 Hk5kyPp0qVgtzQxIHWKFW4AvreiLfwMAaV5GBvwj5RkDEpFhA8h9FHuwbTA+At11cXgSzUwGUft
 m7KD2DTC4iI3eW0INsK3bruhsINTy0VIS8Y7iMvlWfIEFN0ZVZ/07ed+d3UcMlnL4Pr/Ojje8YA
 q6deg5wsxj9DSwr3pmd4cPMLtOorDV6o5tfwUbtI0MCfhMHKNBKhN1jtFGckcNKFgoXPFgjeA23
 c68QiYxSWNowl69DBEWL14asSmdO+B7dOYVwOUi6wuXpi3dUsIk0wQ1CppEfZPLcGYjugu/+gpi
 RWBtLJo/zqEqTaYqwDNcPJLAE7uHLRRP+t9YE2b6e+yv3NtRRV0oi3ArZd4he1pFN4i9riYy4w7
 rmlSl/PnR+/CkId7b4ZiSWqWfcnddS1e3hUBrrYaxJdFNcWxnKR7AgAzd7tKG60cwch1YO4TwVA
 MvpHB627gl2kdCxyI5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280149

On 7/28/2026 11:21 AM, Matthew Rosato wrote:
> On 7/27/26 3:29 AM, Christian Borntraeger wrote:
>> Am 24.07.26 um 15:39 schrieb Jaehoon Kim:
>>> FOLL_LONGTERM pinning fails for some memory types, such as file-backed
>>> guest memory. As a result, kvm_s390_adapter_map() returns -EINVAL and
>>> irqfd adapter registration fails even though interrupt delivery could
>>> still work via the existing non-atomic path.
>>>
>>> When FOLL_LONGTERM pinning fails, verify that the page is accessible
>>> using a short-term pin instead. If the short-term pin succeeds, unpin
>>> the page and add a map entry with pinned=false to preserve MAP/UNMAP
>>> symmetry. The non-atomic irqfd path already performs short-term pinning
>>> for interrupt delivery, so this restores the previous behavior for
>>> memory that cannot be pinned long-term.
>>>
>>> get_map_info() is updated to return NULL for unpinned entries so that
>>> the atomic irqfd fast path falls back to the non-atomic path.
>>> kvm_s390_adapter_unmap() and kvm_s390_unmap_all_adapters() skip dirty
>>> marking and unpin for unpinned entries.
>>>
>>> Update Documentation/virt/kvm/devices/s390_flic.rst to reflect the
>>> new MAP/UNMAP behavior.
>>>
>>> Fixes: c9a568838086 ("KVM: s390: Add map/unmap ioctl and clean
>>> mappings post-guest")
>>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
>>> Reviewed-by: Douglas Freimuth <freimuth@linux.ibm.com>
>>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> queued for kvm/master.
>>
>> Doug, Jaehoon, Matt,
>>
>> can you have a look at the sashiko feedback for the pre-existing issue
>> and work on a
>> followup fix?
>>
> I believe this report is not nearly as extreme as it sounds.
>
> It claims:
> "If a malicious guest or untrusted userspace configures an IRQ routing
> entry with an unmapped host virtual address for summary_addr, the
> short-term pin will fail:"
>
> However: the summary_page was previously validated when the route was
> setup in kvm_set_routing_entry():
>
> uaddr_s = gpa_to_hva(kvm, ue->u.adapter.summary_addr);
> ...
> if (kvm_is_error_hva(uaddr_s) || kvm_is_error_hva(uaddr_i))
> 	return -EFAULT;
> e->adapter.summary_addr = uaddr_s;
>
> So we already know that the address was pre-validated before we try to
> use it in adapter_indicators_set().  BTW this is similar to what Janosch
> did for
> dcf96f7ad556 KVM: s390: Limit adapter indicator access to mapped page
>
> I think we could only have some problem if we later remove a memslot
> that happened to have the summary page on it such that the up-front
> validation is no longer accurate?  Can this even happen?
>
> So: Not nearly as easy or user-controlled as 'guest provides bogus
> address, crashing panic_on_warn=1 host'
>
> All that said:
> The only reason this case is 'weird' is because we may have already
> indicated AIBV successfully (made changes to the guest) but cannot
> complete delivery because AISB is unreachable.
> Maybe the simple answer is to downgrade this to something like
> pr_warn_once("Cannot indicate summary on previously-validated routing
> entry") so we don't lose the breadcrumbs for this highly-unlikely
> scenario but also don't add the potential panic in the first place?  If
> we ever reach this situation, the guest in question is going to get bits
> set in AIBV but will likely never see them because it will poll first on
> AISB which we cannot set anymore.
>
>
> That would track with
> https://docs.kernel.org/process/coding-style.html#do-not-warn-lightly
> even if I don't think it's easy to trigger.
>
> Doug / Jaehoon / s390 KVM maintainers -- thoughts?

Thanks for clarifying. I agree that this is different from the original
Sashiko concern, since the address is already validated. pr_warn_once()
sounds like a good balance to keep the breadcrumb while avoiding a
potential panic.


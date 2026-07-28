Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35327345ED9;
	Tue, 28 Jul 2026 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268401; cv=none; b=uPso7Z3GXvjy/qHe6l3eAY2nrZ9LLJXmMHbmF1kcsdysjCjvroYQ9oqfJ6cCtgUnX9xFpwGCYtod7m4zPpU23UrJ2dC2fdGD9oHD2/MEbhlTsT3GrCg7VUJn5MSYrUZfl02YBaIfVxIPi/QvytOCEaWnmrcQxrp/8KIM/duU8gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268401; c=relaxed/simple;
	bh=G0nZzKE/Uqd3HsuxxpM9fIw48HVrjd2SBilh45xRUYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Egasnm47ZT9XwOLekkgv0J7lyV40yMUerD/M82G2QIp1NeKWEm38widkdDTLYdDO4J23/MP4PvH7j2UeRUlzz9iQH3RnW4IDb76i7yfuEvhZu8X5CQtgntNQ3B5tY5DZ7/1A95z4DcR8S3na4EDtXKZpPzKmi4oBl7pMAjbnXmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vv0Y7i1l; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vv0Y7i1l"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SIHrvw1848065;
	Tue, 28 Jul 2026 19:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cxjjPy
	AETx6UpYpPNooelYlC3tpcp0S7TPYW5U8JVlg=; b=Vv0Y7i1liQJBdd+ODHittT
	oA2cw2q/WMdBqPhigfZaeKk2iAgj59TAP84Y1LAvkjZ0BUhwi/v3mfL3xXo3kDmz
	hlG98Xc4Yr9w6l/xlnQAY6O/D40zC3gRy5W4ti+lgQ+eaftJlIypHgeq+vnwaket
	sHAwGyMbABPM84sJaXHXtc4FX/lf+/5zT/maOm5LM4jdCIGJkzqoBNml+U4x4VRX
	88V32SO7/evjBenMyWGgx77lw8L+PoirrkjGX3hyImbczJhGwaFixtTzdJUmsynP
	W//L+/gb7Wz2Cxp3jUr2JUNgieEmUPlxhZGmj1ofNxcRWAqyrKkeetEJnu4t7vXQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj6nnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 19:53:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SJfGej014225;
	Tue, 28 Jul 2026 19:53:16 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhbkcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 19:53:16 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SJrFxs21758510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 19:53:15 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 218F35805D;
	Tue, 28 Jul 2026 19:53:15 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3ACB5805A;
	Tue, 28 Jul 2026 19:53:13 +0000 (GMT)
Received: from [9.61.253.54] (unknown [9.61.253.54])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 19:53:13 +0000 (GMT)
Message-ID: <396bcb88-2073-4910-8da7-76a8d8b4e4aa@linux.ibm.com>
Date: Tue, 28 Jul 2026 15:53:13 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] KVM: s390: Fall back to short-term pinning in MAP
 ioctl
To: JAEHOON KIM <jhkim@linux.ibm.com>,
        Matthew Rosato
 <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: david@kernel.org, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260724133943.1664961-1-jhkim@linux.ibm.com>
 <b099b7bf-31c6-40ec-a43f-9081f2c64195@linux.ibm.com>
 <eb8e8909-1e0e-4144-988d-05be9221e2b8@linux.ibm.com>
 <cfbae0ef-51b3-4e5c-b9e9-9a9289dacd90@linux.ibm.com>
Content-Language: en-US
From: Douglas Freimuth <freimuth@linux.ibm.com>
In-Reply-To: <cfbae0ef-51b3-4e5c-b9e9-9a9289dacd90@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE3MCBTYWx0ZWRfXzPMgRZV/Nrtw
 gIxbsnElJnCwchfJ70qAiT+MMl/7/ucPM/afroB7fNJp++g+mX7s6/o0Uded+k7sksjiZTd4zMj
 DG7RuszhXwyAovfnwV95BU8QH+Xains=
X-Proofpoint-GUID: 6eEGA7uTCJzZs4e7INcs-PkzGN7MF99x
X-Proofpoint-ORIG-GUID: 6eEGA7uTCJzZs4e7INcs-PkzGN7MF99x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE3MCBTYWx0ZWRfX0wUFAkn7V+f+
 zxt0AgUkd5y/7HcPO+7kKaH7mTG+v9IG/1On76L5ZY4OBZ1fs6m0YO6UnUVgs/7jyMiowj+EcQ4
 TDixRXyxMvkqoQqzc6FdSOc7PShxK9JWejbFvveRTWpnWkBrD7walQD5Jwd4yLeBOvJ9GX8+TMm
 ygPd1jrQcPDa5GognRaTck1cNh8iCJRAVq2SbWTI+zUIEBeGhWG7eUPy62uyPZvAyRt1wdtGqLj
 bWuCgI225ApwXtNzHYlQhs43oMlOwe3PlU8R2ymYunlLHw2e6iB03LiXtFmwnyiU5xo31seoT1a
 5zqihkJdYucYU6NeJ4mWGWdxigrZ+Zwm6Ky3Ey7mJKfMXoqDfbSW2kEIzHIN6R5R1hWgJixJMki
 POkzsBu0RQ69vPBM9GQ57nML1hiJ9K3qqzLVd2oH+oUP/MRBvnSrbTrC824+arnDEA8Lxsze+IQ
 BjGcD6X/yPlWcxIu/3A==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6908ad cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=COE6Bpm35VolYt5YK5cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280170



On 7/28/26 12:47 PM, JAEHOON KIM wrote:
> On 7/28/2026 11:21 AM, Matthew Rosato wrote:
>> On 7/27/26 3:29 AM, Christian Borntraeger wrote:
>>> Am 24.07.26 um 15:39 schrieb Jaehoon Kim:
>>>> FOLL_LONGTERM pinning fails for some memory types, such as file-backed
>>>> guest memory. As a result, kvm_s390_adapter_map() returns -EINVAL and
>>>> irqfd adapter registration fails even though interrupt delivery could
>>>> still work via the existing non-atomic path.
>>>>
>>>> When FOLL_LONGTERM pinning fails, verify that the page is accessible
>>>> using a short-term pin instead. If the short-term pin succeeds, unpin
>>>> the page and add a map entry with pinned=false to preserve MAP/UNMAP
>>>> symmetry. The non-atomic irqfd path already performs short-term pinning
>>>> for interrupt delivery, so this restores the previous behavior for
>>>> memory that cannot be pinned long-term.
>>>>
>>>> get_map_info() is updated to return NULL for unpinned entries so that
>>>> the atomic irqfd fast path falls back to the non-atomic path.
>>>> kvm_s390_adapter_unmap() and kvm_s390_unmap_all_adapters() skip dirty
>>>> marking and unpin for unpinned entries.
>>>>
>>>> Update Documentation/virt/kvm/devices/s390_flic.rst to reflect the
>>>> new MAP/UNMAP behavior.
>>>>
>>>> Fixes: c9a568838086 ("KVM: s390: Add map/unmap ioctl and clean
>>>> mappings post-guest")
>>>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
>>>> Reviewed-by: Douglas Freimuth <freimuth@linux.ibm.com>
>>>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>> queued for kvm/master.
>>>
>>> Doug, Jaehoon, Matt,
>>>
>>> can you have a look at the sashiko feedback for the pre-existing issue
>>> and work on a
>>> followup fix?
>>>
>> I believe this report is not nearly as extreme as it sounds.
>>
>> It claims:
>> "If a malicious guest or untrusted userspace configures an IRQ routing
>> entry with an unmapped host virtual address for summary_addr, the
>> short-term pin will fail:"
>>
>> However: the summary_page was previously validated when the route was
>> setup in kvm_set_routing_entry():
>>
>> uaddr_s = gpa_to_hva(kvm, ue->u.adapter.summary_addr);
>> ...
>> if (kvm_is_error_hva(uaddr_s) || kvm_is_error_hva(uaddr_i))
>>     return -EFAULT;
>> e->adapter.summary_addr = uaddr_s;
>>
>> So we already know that the address was pre-validated before we try to
>> use it in adapter_indicators_set().  BTW this is similar to what Janosch
>> did for
>> dcf96f7ad556 KVM: s390: Limit adapter indicator access to mapped page
>>
>> I think we could only have some problem if we later remove a memslot
>> that happened to have the summary page on it such that the up-front
>> validation is no longer accurate?  Can this even happen?
>>
>> So: Not nearly as easy or user-controlled as 'guest provides bogus
>> address, crashing panic_on_warn=1 host'
>>
>> All that said:
>> The only reason this case is 'weird' is because we may have already
>> indicated AIBV successfully (made changes to the guest) but cannot
>> complete delivery because AISB is unreachable.
>> Maybe the simple answer is to downgrade this to something like
>> pr_warn_once("Cannot indicate summary on previously-validated routing
>> entry") so we don't lose the breadcrumbs for this highly-unlikely
>> scenario but also don't add the potential panic in the first place?  If
>> we ever reach this situation, the guest in question is going to get bits
>> set in AIBV but will likely never see them because it will poll first on
>> AISB which we cannot set anymore.
>>
>>
>> That would track with
>> https://docs.kernel.org/process/coding-style.html#do-not-warn-lightly
>> even if I don't think it's easy to trigger.
>>
>> Doug / Jaehoon / s390 KVM maintainers -- thoughts?
> 
> Thanks for clarifying. I agree that this is different from the original
> Sashiko concern, since the address is already validated. pr_warn_once()
> sounds like a good balance to keep the breadcrumb while avoiding a
> potential panic.
> 

The answer depends on the environment the system is running in. If it is 
running in an environment with tight tolerances for good reason then we 
might want to panic since the error state should be rare and we have 
note warned lightly. Tight tolerances can be set by enabling panic on 
WARN_ON_ONCE.

The admin knows how tightly they want to control the system so if they 
dont configure panic on WARN_ON_ONCE then this is just logged as desired 
without panic.

If we are concerned or have observed that the usage of panic for 
WARN_ON_ONCE is not done very discreetly then pr_warn_once("Cannot 
indicate summary on previously-validated routing
entry") is the answer.


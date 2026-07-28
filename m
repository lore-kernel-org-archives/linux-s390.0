Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378F5377A9A;
	Tue, 28 Jul 2026 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255693; cv=none; b=usT7TpRHnrWXUu8UnLQo5Z2IjR01oGxtFWeshck4++2hmMKC1AVUB6cUVUvfDXye9FoCKCbrUcO8RAUHPL0bJ3R9PU0oyKrq6DQluDzFcw7p2foAi0esjOp2UBiyP8ACE4cpTIJe93qxJoSp7J+88uTn3EkNPQOBbXlDMjZT0hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255693; c=relaxed/simple;
	bh=hYEi2jCuXLe8ZIWyOxoM8w7uww8HOwqnK9b6z+1Uamo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uR8CcOY6hGmlK88s6xaFsXjlwvy9owVaUjlF29ePv2DlebD3d7qOah4cNA8XBDOZ3hnD0pzttvcdYxgWJq+BHeCh5zUyoKvhwabuQRIfCHWsF88D20uGYqHN2U6yKwg9Z5EXxGRhdOQz8G+zTWTwPR0/ZOhchg52vP1yvz8qmW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZfaNeyBT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZfaNeyBT"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SElgkH1380153;
	Tue, 28 Jul 2026 16:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pFzsBu
	+BlHojYcL0C4kQwTXqxp1R62iqsMD7jRO2woo=; b=ZfaNeyBT6avCVc/8kAG9+5
	5Z3MmY/MGXFVj8ouHL8g7oN4fSw0cLZAxqAa7QaYpaUS7+6a/xugxd9iXTmQVvWJ
	Wa/JbVnV3SbgXzcswcMoPgTsdo+8cJLk8lh1bnlkAYWWFJ69gh+TxV/n0TuFtgQp
	UWypAEMv8bGzQ+oOoRhiVCkWWE/mJWumgKQNmTk//2/tYlXd2KPYUVRJOjWTHqbd
	LM4/UdQ7MPIBTIbGXLKos74L2FhM8zB31pLHp4yVlWMvRRn1UYnCePQfXtk/O/WY
	PVRq/dSFLX9EMSuXBePM9ePkfVp3BHjdFpGzAcClm8MsvwVd//dR3rX1wm834u5w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj5p5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 16:21:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SGBI6n027448;
	Tue, 28 Jul 2026 16:21:29 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk2r3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 16:21:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SGLRcI29360714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 16:21:28 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA27F58052;
	Tue, 28 Jul 2026 16:21:27 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 103C158062;
	Tue, 28 Jul 2026 16:21:27 +0000 (GMT)
Received: from [9.61.157.32] (unknown [9.61.157.32])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 16:21:26 +0000 (GMT)
Message-ID: <eb8e8909-1e0e-4144-988d-05be9221e2b8@linux.ibm.com>
Date: Tue, 28 Jul 2026 12:21:26 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] KVM: s390: Fall back to short-term pinning in MAP
 ioctl
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jaehoon Kim <jhkim@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: david@kernel.org, svens@linux.ibm.com, freimuth@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260724133943.1664961-1-jhkim@linux.ibm.com>
 <b099b7bf-31c6-40ec-a43f-9081f2c64195@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <b099b7bf-31c6-40ec-a43f-9081f2c64195@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0NCBTYWx0ZWRfX0l+J8yVqN5ND
 bLuNnc8uNaL6dTUix3VVNHijQSd+K422o9c/x3aNtiVtZI3KcvrgCv0fyofBUVaDmw42o6TO2tx
 wvx3dE6WeEYpl8MA+jp5wOwiM0V3nWA=
X-Proofpoint-GUID: eEJlClbBnWUGDbcpkReHxV0pI4w0o15b
X-Proofpoint-ORIG-GUID: eEJlClbBnWUGDbcpkReHxV0pI4w0o15b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0NCBTYWx0ZWRfXyxLpVVA436Ln
 zTNkNXvxrDF5Ir7EsJkwuvmgseuRN+TZAgX3FPFwLsjkCUgXp+iBAZGNsDypWvH5PaAgqeMIPsY
 2KODC2AjFORk2ZBM1Wr/13n5D7ivmzOU9SHRZUsPcvNAhKzFs70AYYQZUVDf/FkgbyOVj4rplTE
 F7aLsLYz+FXesQMLDFkmI5RkHij+OcxXGFDhe1zUTP1rAREoVFZy2nGav5NhEWTY9ocqWOW7fGD
 NV8VLtBfyo2P68Vrp/mAtgg/zO6xTXiRsRoJm9bJOjGv8AtmBfSyoM+dLnno5fRtRN/7zDQsaMM
 gCOCBu5TmnJvEqTmPk7CQ189HSysZXbh3+HLmcRE1ExaXfMi4ayrQOim2TcZJ1N8+qwlcvl9YQz
 LhKW9y8T9Ab1SYGDdk+35oUxt7AD6A==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a68d709 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yptSlSW76F1WqccU_tgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280144

On 7/27/26 3:29 AM, Christian Borntraeger wrote:
> Am 24.07.26 um 15:39 schrieb Jaehoon Kim:
>> FOLL_LONGTERM pinning fails for some memory types, such as file-backed
>> guest memory. As a result, kvm_s390_adapter_map() returns -EINVAL and
>> irqfd adapter registration fails even though interrupt delivery could
>> still work via the existing non-atomic path.
>>
>> When FOLL_LONGTERM pinning fails, verify that the page is accessible
>> using a short-term pin instead. If the short-term pin succeeds, unpin
>> the page and add a map entry with pinned=false to preserve MAP/UNMAP
>> symmetry. The non-atomic irqfd path already performs short-term pinning
>> for interrupt delivery, so this restores the previous behavior for
>> memory that cannot be pinned long-term.
>>
>> get_map_info() is updated to return NULL for unpinned entries so that
>> the atomic irqfd fast path falls back to the non-atomic path.
>> kvm_s390_adapter_unmap() and kvm_s390_unmap_all_adapters() skip dirty
>> marking and unpin for unpinned entries.
>>
>> Update Documentation/virt/kvm/devices/s390_flic.rst to reflect the
>> new MAP/UNMAP behavior.
>>
>> Fixes: c9a568838086 ("KVM: s390: Add map/unmap ioctl and clean
>> mappings post-guest")
>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
>> Reviewed-by: Douglas Freimuth <freimuth@linux.ibm.com>
>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> queued for kvm/master.
> 
> Doug, Jaehoon, Matt,
> 
> can you have a look at the sashiko feedback for the pre-existing issue
> and work on a
> followup fix?
> 

I believe this report is not nearly as extreme as it sounds.

It claims:
"If a malicious guest or untrusted userspace configures an IRQ routing
entry with an unmapped host virtual address for summary_addr, the
short-term pin will fail:"

However: the summary_page was previously validated when the route was
setup in kvm_set_routing_entry():

uaddr_s = gpa_to_hva(kvm, ue->u.adapter.summary_addr);
...
if (kvm_is_error_hva(uaddr_s) || kvm_is_error_hva(uaddr_i))
	return -EFAULT;
e->adapter.summary_addr = uaddr_s;

So we already know that the address was pre-validated before we try to
use it in adapter_indicators_set().  BTW this is similar to what Janosch
did for
dcf96f7ad556 KVM: s390: Limit adapter indicator access to mapped page

I think we could only have some problem if we later remove a memslot
that happened to have the summary page on it such that the up-front
validation is no longer accurate?  Can this even happen?

So: Not nearly as easy or user-controlled as 'guest provides bogus
address, crashing panic_on_warn=1 host'

All that said:
The only reason this case is 'weird' is because we may have already
indicated AIBV successfully (made changes to the guest) but cannot
complete delivery because AISB is unreachable.
Maybe the simple answer is to downgrade this to something like
pr_warn_once("Cannot indicate summary on previously-validated routing
entry") so we don't lose the breadcrumbs for this highly-unlikely
scenario but also don't add the potential panic in the first place?  If
we ever reach this situation, the guest in question is going to get bits
set in AIBV but will likely never see them because it will poll first on
AISB which we cannot set anymore.


That would track with
https://docs.kernel.org/process/coding-style.html#do-not-warn-lightly
even if I don't think it's easy to trigger.

Doug / Jaehoon / s390 KVM maintainers -- thoughts?

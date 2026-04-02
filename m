Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6EB3A544D;
	Thu,  2 Apr 2026 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775124480; cv=none; b=aWVPBj+/8B1b4lSDQ7acQq7xcC/MtNTtmlxguA1CmWOlEyrGX70GpBd85Lm9xcUr1uaxQnZGlPa8n+3eqluUag9gmvQH5TRziFeN+bxbv8Nb5cg02nFnmzGlNlJaIdCUqw1O471AePyDUJnGvE6/hPw/NZ6icB8OX76YYMqoK6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775124480; c=relaxed/simple;
	bh=fPfl/RRd4coonzCbv3IRGnXL4BYBkHW36xmrZo+0W/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUOVnAB6GamB8cTeIzy+Rie58q6gQOVoOpRRnBs+2wuSwNwYJPbjAt0lna42HpuDhVd9z4yOuGLCHB5qWirvzGz13nNwuzubp+ZYxQ99G8/vGRiY4oOcYmg/4OjMQ066eTB3Y+KSGl/ID+Yd70CcIioEuIgmNjpXbBOPZuErcng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y3QQHFtU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y3QQHFtU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631LlIav138974;
	Thu, 2 Apr 2026 10:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VGpvBl
	pPC7q1Fp7UtYpvAoI0Gq9YHSFZavDLiI3s1Dw=; b=Y3QQHFtUVzBSnb4IllhOnA
	+4OMcbDp6x3GxyIm7MYAqqNc81yjOCihRWr7HY6xTDJj42t6YWq3+VCjkPRqolqv
	ta78VJH8tTqsVuzdE6JXSzu/WlNEQCE4YutAMuh826ASr6SyaWLfFlSRLo3OV+EF
	/2SnJNfh8EnASirNIn9DoE92sUMHDYFI41CCZZIZZYkYF/j+nRzcDyTZxjG6U7Fo
	U8QGKtIDpfRhStxUKWUUxJvy7WfzqkYuOm64hOtyO8FsePPWzfDeBWJNXK5UViSm
	jAGSZh7wSm/vgSMiwRR7/KVM/OAepnxNMP/TIZRm8e1FzOcE685PPgsXJ0mxhNfA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dguj4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 10:07:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6326no4u013898;
	Thu, 2 Apr 2026 10:07:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttksghd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 10:07:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632A7OTK15860164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 10:07:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8062C20063;
	Thu,  2 Apr 2026 10:07:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA90A20067;
	Thu,  2 Apr 2026 10:07:23 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 10:07:23 +0000 (GMT)
Message-ID: <23d8ef83-3eb1-4f25-9a62-504122a60a8e@linux.ibm.com>
Date: Thu, 2 Apr 2026 12:07:22 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/27] KVM: s390: Introduce arm64 KVM
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Andreas Grapentin <Andreas.Grapentin@ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Gautam Gala
 <ggala@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
References: <20260402042125.3948963-1-seiden@linux.ibm.com>
 <3898bcc1-f02d-44ae-b13a-4ea52a5a998d@kernel.org>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <3898bcc1-f02d-44ae-b13a-4ea52a5a998d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA4OCBTYWx0ZWRfX+bYnSu0+H2Co
 TU8XGRT++5AI1juBC9wFKULMZwylTGyHVVJbXlel4T+PWP9VIUw1vPeDk0liS5ZM7ChcaeRnOwk
 ZBD4T78z5DBXH/ALiZh1S11bEaUNojbY8TnDr3jxQiGOconGZaol3G3YhZLFmPp7Fmqt19/y9A9
 QKey66/gHFgvFqjhooc1efpoFoFNH6zlZsSQBMRTgKgNlREgnrzWJ2a89k9a90QxgyTG+yNEKjD
 B4oOb8CcR6FRYvX/Vmss81mT1rkkPB3etH33a3n8ckWPgIHGueQT0mKRv+A12Miva2gfmf32DLv
 uNCk/KGnEE9K9Cxj9N+Pb6v4qNSW9t4bTaYC8qK4VbiSm31ppZ/GYom6k6JUuA1923GHPUXWWBt
 hhly6TvcfK8zst5TJvOWZT4DtwCkI0KbsZinkZCSCMBzvpnzYelwbHG5bbiXIdEK5f3vYp92CvW
 qLu1wSNNpTqvFwZFi7g==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69ce3fe1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=BrXnhqggJEmLmTzRH7MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: s_1pDfN2Mgrr-03qGQR_plhnaoiW23lU
X-Proofpoint-ORIG-GUID: s_1pDfN2Mgrr-03qGQR_plhnaoiW23lU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1011
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020088

Am 02.04.26 um 10:53 schrieb David Hildenbrand (Arm):
>>
>> KVM on s390:
>> 	The SAE (Start Arm Execution) instruction is introduced as the
>> 	s390 mechanism for running Arm64 guests, and a new kvm-arm64 module is
>> 	built up incrementally.
>>
>> Upcoming patch series will introduce system-register handling, interrupt
>> support, hypercalls, and additional features such as PMU.
> 
> Pretty cool stuff.
> 
> What's the rough timeline for the other work?

Over the next months. The idea was to split this into consumable chunks and start
with those things where a lot of people have to agree (code movement, code sharing
and shared maintainership). This will certainly evolve depending on patch feedback
and merge progress.

> 
> Regarding I/O, I guess it is primarily VIRTIO (VIRTIO_PCI) for these VMs
> only?

yes, virtio-pci.


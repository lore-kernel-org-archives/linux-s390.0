Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DEC4DEC23;
	Mon, 28 Sep 2026 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612343; cv=none; b=PPE75geH/SThJX30B98n42uy+XLkyAJwrYLjkKtWIJ9rSAQrHiC9Q0+LqQ0TTMC6dbocgDu0rmk3jiLIByIPWd3APJn+cRyQnJbu/lidiZWSijGroYVyQtUQkFLiXmnP1vQqdXBTBxYDsMB/oSmVZWFEEn9Npm1Ao/BAJjFGw00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612343; c=relaxed/simple;
	bh=3k52VKutc0OHAgAml/ar6iHZTaZsU9dWsG1lJC5bVRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TU3vkUfHX59k03wYqBGsyNsk4QVZMziZNbZpBgZf5dG2KycPXP8BCmNjcw7W00Z9YsUO+J/e4XCdxnZbkS6VHFbkLyTrwh+Wl2DNnx0QQ6a9wJ92pE5oAFddmL8tSqzFd3ay8aP+gob8pMvn7JCpvv2/KeRWYABiEEGrsu/usSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=USriATBR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="USriATBR"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SF5gZY217089;
	Mon, 28 Sep 2026 16:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VkhcCo
	zT4giUvNq7p7/Wt7ZMMq9OSsOPTtPNjk1hgag=; b=USriATBRkAsMsPtWWy6oek
	NWOXqPHejrHpeLDXqt2jxRLAjG6ufUszmIAXahFreyoKzt4vca1ilJ9K8xGVtmdl
	gpAoQaw+r8rEwkJCF3cPIB3yibHXw5BS52sP1CARnZSKXMCHL2J+QXjhiwjIcui2
	5D3+EQZ9rxa1u/uZA32hUXPw/AocxwuKKxBEpeXxvrUemMD/RpIXFEOJq7Zeb/aH
	/35FSX1U9pANZcywB9ho/WrbJnjuiQoRr30cC5UxUZzRDMRbIbFmdnv4af9gdYvq
	V6Q4a0R364fYRAPDTPFwkO1XArTQuwSuRlUWEjPYBQ/gfekwAXwcPEDGJ7tRZtMQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fe27yc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 16:18:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SElUYK3181786;
	Mon, 28 Sep 2026 16:18:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxtkg5vca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 16:18:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SGIWbH42402262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 16:18:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DE222004B;
	Mon, 28 Sep 2026 16:18:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 705D020040;
	Mon, 28 Sep 2026 16:18:31 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.81.16])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 16:18:31 +0000 (GMT)
Message-ID: <75b68915-1f7f-4172-8748-dbf06f7b1983@linux.ibm.com>
Date: Mon, 28 Sep 2026 18:18:31 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 20/29] s390: Introduce Start Arm Execution instruction
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter
 <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-21-seiden@linux.ibm.com>
 <1e3b65b3-0c21-466f-ae09-8426eeacb97d@linux.ibm.com>
 <20260928161546.428362-B-seiden@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260928161546.428362-B-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6aba935d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=hNaKMhA-TWiUr5-D4PQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfXxmEDTFdSqYV9
 RJWlir3toMY4CqmNwZGlTMXDJub1/DjsXxXj24YrnMVxob2Z2FZdoG3HSMbzeDBxqXrm+yOfMjD
 RguA50EV3jbAIy2pG2edDPHw5eag0Yo=
X-Proofpoint-ORIG-GUID: 6RqGq_y69ZMcg2bXD8bT2m5HyIA1vn5I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX3IOLZMkE0O8X
 LoDTpH41EcPb/lYoan1KfODFVIoIfMC3PNOZLCz+aQQX+53Tx5DJYUjQjvr6CRll3xBAyfuSTrD
 iXf4r1C+cGFsrKWsp4KPDpbBIQ6E6LlCDPudjO7Tq8n4WRsM8mHcUWOuqiFaz0vGooKoEyOUAm7
 M/RoDBsRXfwzvQxUVgcy6WgPH1V0LSGbzvyvmry5ciuE8r4GgBVw3+t64SWu5k2ENso7GiYOksh
 vQVcZXHuXz85xGY6Od+vlvNSEPXiY2+QDk/Cz0LBsitOyGYA7q/SqoZ1qtuIZmHw+fhejMCzlK5
 PQM75MeSu6RDigRMuOZCWGmUqFKACpPEmtEAVj2W2diN8qt0hCW6tfKZoHLRLrkvIDq8PZ2KIOn
 k2lDyxcX471IozSjvqJKbQXInVeeLgMWiyGuSOpMb3FOFMxUsjBWC+vPPu9bhXCOuAW/gYsptLm
 PWBbpiEs5i16O+ZsLHw==
X-Proofpoint-GUID: tt4ZhA4U_MFCZP6qe9B1xUJKS1hFpSTU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280064



On 9/28/26 18:15, Steffen Eiden wrote:
> On Mon, Sep 28, 2026 at 05:53:33PM +0200, Ilya Leoshkevich wrote:
>>
>>
>> On 9/18/26 15:30, Steffen Eiden wrote:
>>> The Start Arm Execution (SAE) instruction is the centerpiece for
>>> executing arm64 (KVM) guests on s390. Its purpose is, similar to SIE, to
>>> enable accelerated execution of arm64 virtual machines. SAE expects the
>>> physical address of a control block as the only argument.
>>>
>>> The host is responsible to save & restore
>>>    - GPRs 0-13
>>>    - access register 0-15
>>               ^^^^^^^^
>>               registers>   - breaking event register (BEAR)
>>>    - vector/floating point registers
>>> between SAE executions to guarantee host consistency.
>>>
>>> GPRs and BEAR are save and restores in the asm functions. The other
>>                      ^^^^^^^^^^^^^^^^^
>>                      saved and restored
>>
>>> register are handled in within C code. Access registers are handled in a
>>    ^^^^^^^^             ^^
>>    registers            not needed probably?
>>
>>> later patch and SVEs will be handled when they are introduced in a
>>> future series. Most arm64 registers are handled by a satellite block
>>> called save_area. Some registers, frequently used by hypervisors, are
>>> placed into the SAE control block itself.
>>>
>>> Enlighten asm/kvm_host_types.h for the new header variant. The new
>>> header is chosen instead of asm/kvm_host_s390_types.h if KVM_S390_ARM64
>>> is defined.
>>>
>>> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
>>> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
>>> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>>> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>>> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
>>> ---
>>>    arch/s390/include/asm/asm-prototypes.h       |   1 +
>>>    arch/s390/include/asm/kvm_host_arm64_types.h | 124 +++++++++++++++++++
>>>    arch/s390/include/asm/kvm_host_types.h       |   4 +
>>>    arch/s390/include/asm/sae.h                  |  58 +++++++++
>>>    arch/s390/include/asm/stacktrace.h           |   5 +
>>>    arch/s390/kernel/asm-offsets.c               |   1 +
>>>    arch/s390/kernel/entry.S                     |  22 ++++
>>>    arch/s390/tools/opcodes.txt                  |   3 +
>>>    8 files changed, 218 insertions(+)
>>>    create mode 100644 arch/s390/include/asm/kvm_host_arm64_types.h
>>>    create mode 100644 arch/s390/include/asm/sae.h

[...]
>>> +SYM_FUNC_START(__sae64a)
>>> +	stmg	%r6,%r14,__SF_GPRS(%r15)	# store kernel registers
>>
>> Strictly speaking we don't need to save %r14, but I guess you do this
>> for unwinding?
> yes. Also, some later (unsent) patch needs this and before I forget this, let's
> do it now.

Thanks for the clarification!

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

with typos fixes.

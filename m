Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2E53DD537;
	Fri, 10 Jul 2026 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783675379; cv=none; b=FsM1R5277+VN0J+otPhiyx7i5absyjPUA2EDIW3uycCOwNTvMMjeCxjjArYcvYCXqzkxaQwybaJ1ObDbOxYOpH+uksLHUiVqn9OYCJCkVQPpLHhblE1vBcsHcpdr7vSSrPA3hoNOijz4/s1qeHP5Y5kSoEWVfeX+jFx9qFxf75M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783675379; c=relaxed/simple;
	bh=5eENQcOtwV3FxaAvv0OX6vKER2iU3qMBq4X/10f/ntc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+slwom9/3aGVlUE+NqfcIQrODSL05W0j0GsdmzigCpmn7JGCAS2zEPT4QrVWrqLYQOp0ghMrflSlyN0jhi7sjE49WTeZvr+tdrbCT/HcjuSsqwgrZIfn6XBAxKcLG4NJtgNcvWUBojk6Rq+t4Bl7BBdIhbwuRg/rx3HDBk/u4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oaqXSSYs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oaqXSSYs"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7mm8w606167;
	Fri, 10 Jul 2026 09:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FXRozE
	PyRdFmB/eFiZ72fgSP/FDKUih11M+CkhAYU/k=; b=oaqXSSYsaFqf+O5qsWdd58
	SL/+3fQ4F7lJ9kEtq7G8rkeSeaZN7vs1Q/Z188unlRXOWgEI1S010R8/HMstq8XG
	FLxUdjn+K9MwN+t55WNjt+BScO9bfAPjiyiGo6DRdOv1SIExOadOes4m5vu5u27S
	CooNR/CHgHSG2fs93ZA/IKj1pP1XYVCj8J8plVGAy8I1XJL9cGtlw2QTGWhiGzhE
	Jn6hvplzVUrJybCE+dEYDi4bft07fz4RE88pmI8MJQz0jSN805x3QoLRDjIKdIKB
	GutQYC+RA8yYBWCc1lC/EBuNqtiBfg6yEqPloIIcazgomwEJdXl/Om/BWvb6uBOw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknwacf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 09:22:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A9JdkT005563;
	Fri, 10 Jul 2026 09:22:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hs6ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 09:22:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66A9MUPH52953514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 09:22:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D5572004B;
	Fri, 10 Jul 2026 09:22:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADA4020040;
	Fri, 10 Jul 2026 09:22:29 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 09:22:29 +0000 (GMT)
Message-ID: <857debcd-3e44-4844-8abc-b26b892d3d7c@linux.ibm.com>
Date: Fri, 10 Jul 2026 11:22:29 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/27] KVM: s390: Prepare KVM/s390 for a second KVM
 module
To: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter
 <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
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
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-14-seiden@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260706085229.979525-14-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a50b9dc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=4ICgCYz_5eq5xHeZtxMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -o4KQjMcDjW9IuVLEIRKcNyJghPFvYRL
X-Proofpoint-ORIG-GUID: -o4KQjMcDjW9IuVLEIRKcNyJghPFvYRL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5MSBTYWx0ZWRfX2ecZOaa89DVV
 gssTNZtsp6kCWQh3BZpnJBCXe2DvQYdq75vW9N5pArjyKm8u48rPcWepb+44q9RQXKSEN5TRyEh
 xRiW/37z37sshT/ABKTWAwi0OYKN3hY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5MSBTYWx0ZWRfX/l5xUK8u3CMN
 qUhQPgpmqH+LJR1SEuw6Fcxo+bGOzFeRYoNrT3dh6Lj7egsG5Ion6v85xELlib2BSDRlyae36Zt
 laK7fIsIJmNv1g7iL4rdH8SxCyYhn/sico5xnGsuHdfuGeZITWl+XzWCNPUszap18Mm2d4ITyA4
 ncrycSr/SlFUlH8fkMJVk8MfySO4fFRfTqMDU+eKGx4KhssgiIcJFkWkcbN/Ep5djq2q87WZnBk
 9uy1obn6eG7fAmNDe73hMH6VoFnixXal8GvpwRBDOj0ITgST3pYeeKXnuQySlBkuc0cyGS93iUR
 n3t2vodJZNBpzsTlwKunDIWfTLpFYEDvys3BjhVoMXNInUZqh31qRJrVnMHOl/NQwBgZw6xARQj
 JcIFdrch2H5TnWvuBdXuZuo37tV1QRl75Vc6ejJhJSITvcn06loCIEX7I4dMnrx5Q945Fid/Z2+
 pOE/sXfNswEOVDTdskA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100091



Am 06.07.26 um 10:52 schrieb Steffen Eiden:
> Lay the groundwork for a second KVM module. Guard KVM/s390 behind the
> KVM_S390 config and turn CONFIG_KVM on if selected. Move all the
> kvm_host definitions to _s390 postfixed headers. Prepare local header
> include guards for a new location. Move gamp related tracing into a
> separate file. While at it, rename the main KVM/s390 files from
> s390-kvm.{c,h} to just s390.{c,h} to match the naming scheme of other
> architectures.
> 
> No functional change.

[...]
>   arch/s390/include/asm/kvm_host.h              | 774 +-----------------
>   .../asm/{kvm_host.h => kvm_host_s390.h}       |   6 +-
>   arch/s390/include/asm/kvm_host_types.h        | 347 +-------
[...]
>   copy arch/s390/include/asm/{kvm_host.h => kvm_host_s390.h} (99%)
>   copy arch/s390/include/asm/{kvm_host_types.h => kvm_host_s390_types.h} (98%)
This is just an "almost" rename only in the end. Maybe we can convince git to show a better diffstat to reflect that?

In any case, I guess we can handle patch 13 and patch 14 pretty soon upfront so that the patch series gets smaller and is easier to review.

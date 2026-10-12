Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63010495501;
	Mon, 12 Oct 2026 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817709; cv=none; b=HJZjgC8bee4WYMn87pUfP0Dw4O8ki5+n2IaFdwnvyvXn3G1KF8orkLn95xTTjQNiJbfoLRHF+P/vCYnQVC4HLjq8A01iyeSH4feD3AHxbf5vuYg3I+Co0aiPQbU+aggpcIXIKi6Y3VPnGyIkzoMpkcFkDZHCelSoTvUTmevgveg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817709; c=relaxed/simple;
	bh=p2D3HnK1s0gKxBecFYzH84ct9HurTg3iJInrc7BAHM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+siPmP2dnbN89ltdjhj/V076W7/z3Zs4GkglFrk1IUf29gNwvvWsbtF66z5oXJfki4pQT3SJt8K/Xp4jWouVrzoYidzBTYvB4nBRxQDzwqgXqgcTy86qZoKDh/3tv6wgsEr6h8Yuq4A8U1Hct8aYlIETrcQiB9808P45DznYKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lhRJIWv5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lhRJIWv5"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEEQD3209693;
	Mon, 12 Oct 2026 15:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=n7h9gq
	XjPAW2nh6+wJU87ZzPbzenXgxvmTv6TZoTegI=; b=lhRJIWv5ZG+epZlgAT6Czd
	3KoQpMhdzxJwdzwxaASdPUZHxo3/4gup5G5igTUMtO0ue7V8CIc1ZbFIdU9arqEY
	01M3d7CYsKUmpEC+o/jX+msgdQri79Xi4JaTL3cbUUtfOC7lcZkwwBR/3xU3078q
	g+8HX7sRKIWYx4kemCxS+EX2LAg/ZK/ciX5Qeb75lgtcior6AwPKL6lVtl64dvwB
	72M45G48X1lfFQhLOwIvtk8eTOORK0+74NA0DNQQG4SlAq1Sj6+0GNrAm6wgu6OY
	CSXRx6+YLSxMgOllAeL4Px6jl4FwbR7yPUdPCG6dg6LkB9EZG94PXYO0hD/DnQBQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv097dq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:08:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4uew013441;
	Mon, 12 Oct 2026 15:08:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wfwhd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:08:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CF8MFd46530904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 15:08:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E5152004B;
	Mon, 12 Oct 2026 15:08:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBB8720049;
	Mon, 12 Oct 2026 15:08:21 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 15:08:21 +0000 (GMT)
Message-ID: <b42dadbd-bac5-40ca-ba69-be7582792474@linux.ibm.com>
Date: Mon, 12 Oct 2026 17:08:21 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/32] s390/dis: Improve show_code() output
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland
 <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-9-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-9-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1OCBTYWx0ZWRfX3K91gCbdt98s
 CLv8V1iGVyKXh5t3tQBcPS+1LvOJ26t+mzMkxwo7vVUHpTsLIFOk6QaFfitAp7v11kG7Gr0L+Cm
 YfgSzJSCssp0khfuWm56WFLpL/CN5lhnYlbBzOhJrH1hdl199MSt0p+pDNIIWvCLTvDsfSoBFEJ
 v1f83XKrn+/0k/Orskpq0R7S6X+6PqPw7VaMs/Xiw2ARncIUa4mQUvwcpslfhm5vIIj6Lugeitd
 giTAPQWPawIOoEWuS1934gHOMZyiWDymFd1MAH2HiVgt4UK8R+E9TYT/ctTaBfojW1z/xoqev21
 T/Fw7z9mbXs/rPso7Qu92b34aV+iAqkXC3PIqvYWVLFpw2ET+vcwZbXJzM+Kv6gpjKWfpZOdTYQ
 np/f16HvmAeFA5M68Ov/L4Vil75fdKSWqPZGkBn6s221RrwhlKCYd0klDeAKCM6DF2vb2CIad0Q
 ZLUbYigfdLkopXg0bAw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1OCBTYWx0ZWRfX8IxfMg/HPGaY
 OeuWp1mi9H1w3m78MM2cunhv6X2qt2g2kGHqOiofmA0GKunMHO9+4GfyE36cVaMM/kQAKuDG3UK
 1Ax1/3Ovse7jQRjPlHyFQXg/FHLsngI=
X-Proofpoint-ORIG-GUID: cdkNYWO4HPuYB8hpMlNxZ556uGGtctDR
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6accf7eb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=-4z61IKqeMHWxoAB5l8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cdkNYWO4HPuYB8hpMlNxZ556uGGtctDR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120058



On 10/1/26 12:32, Heiko Carstens wrote:
> Replace the '>' and '*' instruction markers with explicit 'PSW >' and
> 'PGM >' markers which identify both the PSW address and the faulting
> instruction.
> 
> Previously, '>' marked the PSW address, while '*' marked the preceding
> instruction as a guess for the faulting instruction for suppressing
> exceptions:
> 
>   Krnl Code:
>              000003ff8dc7bff8: e310f0080004 lg      %r1,8(%r15)
>             *000003ff8dc7bffe: e3a0e0000004 lg      %r10,0(%r14)
>             >000003ff8dc7c004: a7280000     lhi     %r2,0
>              000003ff8dc7c008: eb9ff0900024 stmg    %r9,%r15,144(%r15)
> 
> Now 'PGM >' explicitly marks the faulting instruction without guessing
> and 'PSW >' marks the PSW address:
> 
>   Krnl Code:
>              000003ff8dc7bff8: e310f0080004 lg      %r1,8(%r15)
>         PGM >000003ff8dc7bffe: e3a0e0000004 lg      %r10,0(%r14)
>         PSW >000003ff8dc7c004: a7280000     lhi     %r2,0
>              000003ff8dc7c008: eb9ff0900024 stmg    %r9,%r15,144(%r15)
> 
> For nullifying exceptions where both addresses are the same,
> 'PGM+PSW >' is printed instead:
> 
>   Krnl Code:
>              000003ff8dc7bff8: e310f0080004 lg      %r1,8(%r15)
>     PGM+PSW >000003ff8dc7bffe: e3a0e0000004 lg      %r10,0(%r14)
>              000003ff8dc7c004: a7280000     lhi     %r2,0
>              000003ff8dc7c008: eb9ff0900024 stmg    %r9,%r15,144(%r15)
> 
> show_code() may also be called in other contexts where pt_regs does not
> originate from a program check (e.g. system calls). Introduce and set
> PIF_PGM_CHECK to indicate when in program check context, and print the
> PGM marker only in such a context.
> 
> Note that corner cases are not taken into account. Like before kprobes is
> not considered, which means that the disassembly may contain unexpected
> instructions, or that disassembly and/or instruction length count as well
> as interruption do not match.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/include/asm/ptrace.h |  4 ++++
>   arch/s390/kernel/dis.c         | 16 +++++++++++-----
>   arch/s390/kernel/early.c       |  1 +
>   arch/s390/kernel/traps.c       |  4 +++-
>   4 files changed, 19 insertions(+), 6 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21173F2114;
	Wed,  6 May 2026 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079059; cv=none; b=jdoMKisgtOn3eUm/cvR9NGHkHE9JQf7xYfOGDqD6YgjZHOWVFvR/Lj620eFZwv5PL2B1OJHMpGzGoXlNtnY52tWeYPKPmrPke2aMO8GoWK48NC+zsAcQpQ3FwmQOwqvZ3mNvOZvWZjwIyyLaZelRqNPKobbahojJGoBqJaJ4ARA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079059; c=relaxed/simple;
	bh=lEQ+qSVW6EIwygyt9swWHQtyrw6Evt9IuoYFwTsaQ10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XvZH/237aQ6D3S/JqHzhKsRRXb1daL3VCR7InuvnfOMqh3eDbjMyjW5Tq9vgHpY5q0qRmGeNurjn45B0aeWtT32wMZciEvhaL3ZcFf/hDys8Qhzc2noOvsrpASPltTnJd/67zlkoMjJU1ks8IPx45vCo5dH2fSWXnD8hBadpFFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DQvd1A7t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DQvd1A7t"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64603HvH067384;
	Wed, 6 May 2026 14:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uMYzae
	8XLE9z3eL5ayLh28wWMN/rSPGtFkJwz/8+m9g=; b=DQvd1A7tpxgvFuIUIk1B+B
	i69RbUNyM0sBmjSd/lIJXQ1JT9VuHcqwB85a6hxqfhJsuFOzZt9wecVvW2kmu/IN
	SIrDcwJzum7d2q0vUTZpuumN0d0F7k6L0waJU4pJzkt1oGce+mIaY2AWuZX5yFlc
	OU39r2I1vypKv+sCCkNOXfX9nbdvw/Rmt1UthxrXvX2PZ02jVhDXNKYlX28oVQD7
	nZwiLCScXDcn3OARgXIgPtfKZCIWyeboSzHBqXSI6px7jT+XTtAVvEMZRBipj5Vn
	nDJsj3dRWpgTHFYFoWp8aNXopO6PeOJk1hehqUFOUVb4rNKiJsODE8+rhMUnvwFQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1h8tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:50:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646EdThh007349;
	Wed, 6 May 2026 14:50:55 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgeh16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:50:55 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646EorkY46727482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 14:50:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 863FB5806B;
	Wed,  6 May 2026 14:50:53 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F5E558052;
	Wed,  6 May 2026 14:50:52 +0000 (GMT)
Received: from [9.61.249.171] (unknown [9.61.249.171])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 14:50:52 +0000 (GMT)
Message-ID: <d39c54bc-1984-490c-9457-5eff63edef56@linux.ibm.com>
Date: Wed, 6 May 2026 10:50:52 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] KVM: s390: Change the fi->lock to a raw_spinlock
 for RT case
To: Heiko Carstens <hca@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
References: <20260505173728.160562-1-freimuth@linux.ibm.com>
 <20260505173728.160562-4-freimuth@linux.ibm.com>
 <20260506045734.11230A02-hca@linux.ibm.com>
Content-Language: en-US
From: Douglas Freimuth <freimuth@linux.ibm.com>
In-Reply-To: <20260506045734.11230A02-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: foTD0CRPasax-PbCZ_SrJMF1kD0N3KDn
X-Proofpoint-GUID: foTD0CRPasax-PbCZ_SrJMF1kD0N3KDn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE0NCBTYWx0ZWRfX+3AohF6DDMaY
 FopO4Wg2NqL70tqiN6lnBFKyuBQtqzi2hdAOwC+/GuOejrTzhAebj8znhc5sDR9R+xkDUH35vHy
 TlTRLfmzjQAoStpXkvPjhwrMojjzBQXyVWnZ7jpmBX1Ew5xRvFcOf2CHsmbkRMMZXkeqccb3zqA
 1BEfQOo+5l6o4eqWZd3WUeuKU9aRmSe8uXlOCPBYPcQ5Ng5qk8ATZFaozkisUCOY4OKHfe7YXij
 PV1ZjC1YVCN6Ts8gbRt7Om63V8SzGVzocboFDGdqp3gFcnAbbBq5sgwMB27bcAckOPkKiMst421
 yZNLXoO3L2y52J1U5Wxgkkwhh1goDCuawiF4f4KfOvxqFgUb2QTItktrrY77VlUwjmZX5bsO5wQ
 BYgyyCzoV0RPJ+wlsXZK4Gl4TGTUJ4Maumi3eQJZtPsG5nZUXP09oLf3RY/mpeQs4JpBS406zdh
 LXzyygpbehycnWC/4Bw==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fb5550 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=ljoCnXVPeUkr4m1FovgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060144



On 5/6/26 12:57 AM, Heiko Carstens wrote:
> On Tue, May 05, 2026 at 07:37:27PM +0200, Douglas Freimuth wrote:
>> s390 needs to maintain support for an RT kernel. This requires the
>> floating interrupt lock, fi->lock to be changed to a raw spin lock
>> since the fi->lock maybe called with interrupts disabled in __inject_io.
>>
>> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h |  2 +-
>>   arch/s390/kvm/intercept.c        |  4 +-
>>   arch/s390/kvm/interrupt.c        | 68 ++++++++++++++++----------------
>>   arch/s390/kvm/kvm-s390.c         |  2 +-
>>   4 files changed, 38 insertions(+), 38 deletions(-)
> 
> s390 does not support RT, but I guess you are referring to a lockdep splat
> which you would see without doing this change, similar like we have seen at
> other places.
> 
> Can you include the relevant parts of the splat for reference, please?

Heiko, thank you for you response. I dont recall trapping it with 
lockdep (while it was on) but discussion on the mailing list in an 
earlier version made us look closer (and we saw it across the AI models 
that reviewed the patch.) It appears that while RT isn't supported it 
can still be compiled in to the kernel so we wanted to mitigate the 
issues we would add to if someone does that while not impacting non-RT 
environments, the main use case.


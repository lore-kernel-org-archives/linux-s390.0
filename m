Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983FA2DFA3A;
	Thu, 20 Aug 2026 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787214627; cv=none; b=DX5V755c1VsX3YbboVibvVbvbHghNjVgOpRndtEj4JUkdj6aZ2wX8vgj4F0KDwnD30fEyI3MAyooh/BOWZR657UzBaL6VjWE9nwkqiJj4bR+TPAYauVPOUDmOZlOAobo5oP18Y46rEVQ9uYtx5Q4IHLvYhR0Hbe0VAcesj1sBZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787214627; c=relaxed/simple;
	bh=oDSU8vSQLqwcTh65G5j0qpJyt0M2GSgivvdrWe6Sm1I=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=P/sBneTPCdcNq4rKg8601dP7kOu1Eukl59Y+0wBqWZlnlD9wqUN5mjbSbnnpaXw4JuarxX+um0RQFNzs69ZD6tuIAbAA4+oLMtTHsIt46Q/WrD1RA/GSePRoGDEwHK5Py6ultRKpxU14DE4jaB76HfETa5mZGfQBKhUBcuQuHeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ijoNP3DZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ijoNP3DZ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JLVe3D424273;
	Thu, 20 Aug 2026 08:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xmyTCf
	YN06PUDU4U3wcc0ii3R3H37NzL/M6KjdO2gQw=; b=ijoNP3DZZkRoek4DfzNH/8
	STq/MXMmqggn3GaYhRd/komzAYJNnLnB9RoCmy9Cwed7LbNxV5mztG5LdSCVlJgC
	0cSjVG4IeWzMQUPG3IVueaLGx5dXSbWl30ff1ZHsG9uk+y2tz9tVhvf9nx7lWgol
	XK7/qFvRZegzgyTVYOiR7S4JgfFnplmtFZLh6XiRAJnEhptrbcG77jpLYjleMjlu
	52G7v9DWTiUpop71VVwMTsF7onYl9IAOoK3UunpqZk7cNGWP84bsfGSUP6oG5iCs
	8pC/bDfCrd/gFsno+gYilceJ48XrnKcnRMTVRR9hLT52vDxiYbSwHjzOiN3IidaQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1h0x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 08:30:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67K8QL5H027114;
	Thu, 20 Aug 2026 08:30:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekdffe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 08:30:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67K8UKU124183306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 08:30:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68A3720040;
	Thu, 20 Aug 2026 08:30:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ED342004B;
	Thu, 20 Aug 2026 08:30:20 +0000 (GMT)
Received: from localhost (unknown [9.111.13.52])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 08:30:20 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Aug 2026 10:30:19 +0200
Message-Id: <DKTMPHUMVTGX.XW4LY4FQKDB4@linux.ibm.com>
To: <sashiko-reviews@lists.linux.dev>, "Tobias Schumacher"
 <ts@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, <linux-s390@vger.kernel.org>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        "Heiko Carstens"
 <hca@linux.ibm.com>
Subject: Re: [PATCH 4/7] s390/pci: fix MSI directed-mode teardown IRQ bit
 count
From: "Tobias Schumacher" <ts@linux.ibm.com>
X-Mailer: aerc 0.22.0
References: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
 <20260819-s390_irq_domain_fixes-v1-4-826ff27b6e97@linux.ibm.com>
 <20260819090757.3F4051F000E9@smtp.kernel.org>
In-Reply-To: <20260819090757.3F4051F000E9@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a86bb21 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=QwlQo2ZzjPsFoGYGQ3oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Qm4fQjD-nvMNSnR3RzJWbbAzd4tRVAqf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA1NyBTYWx0ZWRfX3wpkgnI+tMRL
 6xmXAs3fD52tABJ1D3dMnOCfCcGV9iox7nxxsf6WlV+dG54z5ntK4+dBrBT0UxiuRV8fQF2KfpO
 axEd/4tuCIF0vyQLAAPcEHYiB1ySHzg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA1NyBTYWx0ZWRfX7mU2Bu+k4UkP
 5rIqURG9Fd/JvK7Hj5o8Bk+uOM2NSdeqzESwA9JV55/IagRPpVqcyMR8aTueYQ+BcX4wewINsgI
 lWU8eFcjJy6kBvg34Iva4QDp+Lp3nh/3HecqnXoDCSAZZxgmp11BMS6WyaERLf01D2KwUjyZTNj
 GPe4+Q4XV5l2M/CkS4jdfXqfuiOKBQdhvVdrhfwCNYiPlM80NLvRx+zLMNptG5qM48HXktBotc/
 q/R8TyQGNoNz9OuNzha6rlYKEZgUkieI65sdbu/oPhMvLZWBt31bxxScm3Rvybuppyw0+mU8OLU
 wHK6h0K6Yv+lBSZcIUapHLejhUdqhhV1PQhWGdHbXKOncluLHLTMu+6CqH/2MXmV3CChcv0o06K
 vCHAAUedGl7osak0V6fe6Yp8o4J34Yo2XwWXpH2LYqz0uMfvFTwqmScFpmtm5u5/g4uhiBVug/2
 0s7Glpkeix7XyjVB+Zw==
X-Proofpoint-ORIG-GUID: Qm4fQjD-nvMNSnR3RzJWbbAzd4tRVAqf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200057

On Wed Aug 19, 2026 at 11:07 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Double-addition logic error in `zpci_msi_clear_airq()` causes ou=
t-of-bounds memory writes and leaves dangling pointers.

yes, see below.

> - [High] Directed MSI teardown leaks uncleared hardware vector bits on CP=
Us > 0, causing spurious interrupts.
> - [Medium] Missing RCU pointer assignment when publishing `zdev->aibv` to=
 `zpci_ibv` array.

The last two findings were already discussed for the previous patches,
won't comment again here.

> --- Patch [4]: [PATCH 4/7] s390/pci: fix MSI directed-mode teardown IRQ b=
it count ---
> commit 061bcdd7920b9b7d42fc840ba0aa403eaf0255a5
> Author: Tobias Schumacher <ts@linux.ibm.com>
>
> s390/pci: fix MSI directed-mode teardown IRQ bit count
>
> This commit updates zpci_msi_teardown_directed() to free the actual numbe=
r of
> allocated MSI bits (msi_nr_irqs) instead of the maximum supported by the
> platform (max_msi). This prevents freeing bits that were not actually
> allocated, which would corrupt the shared IRQ bitmap.
>
>> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
>> index 5e934ac990ac1..e9eda846cb2d2 100644
>> --- a/arch/s390/pci/pci_irq.c
>> +++ b/arch/s390/pci/pci_irq.c
>> @@ -349,7 +349,7 @@ static struct airq_struct zpci_airq =3D {
>>
>>  static void zpci_msi_teardown_directed(struct zpci_dev *zdev)
>>  {
>> -	airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->max_msi);
>> +	airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->msi_nr_irqs);
>
> [Severity: High]
> This is a pre-existing issue, but does this leak hardware vector bits on =
CPUs
> other than 0?
>
> It looks like this only clears the vector bits for zpci_ibv[0]. Since CPU=
s
> greater than 0 have zpci_ibv[cpu] created without AIRQ_IV_ALLOC, their av=
ail
> mask is NULL, and airq_iv_free() returns immediately without clearing the=
 bits
> in zpci_ibv[cpu]->vector.
>
> If a pending hardware interrupt bit is left set on a CPU greater than 0 a=
fter
> device teardown, could reallocating that bit index to a new device trigge=
r a
> spurious interrupt on that CPU?
>
>>  	zdev->msi_first_bit =3D -1U;
>>  	zdev->msi_nr_irqs =3D 0;
>>  }

This is correct. The avail mask is NULL on CPUs greater than 0 since all
per-CPU vectors share one bit layout, so a single allocator is
sufficient. To fix this issue, we need to change airq_iv_free() to also
clear leftover interrupts bits if avail is NULL and additionally call
airq_iv_free() for all for each CPU.

Since directed interrupts are currently not used in the field, this
should be analyzed more in-depth sparately and be fixed outside this
series.

Tobias

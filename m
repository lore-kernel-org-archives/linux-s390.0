Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1936626E165;
	Tue,  1 Sep 2026 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788263058; cv=none; b=tIsySNJiWRnazd77ejFIwDFhnQB4/MI2EsyduSIhp3ZI8WN2NRz/7f06fj/MJTMvllHIFVGc4iReYUYsaxtj1U+EehvVYWOdy0cqcb3Nj6Q3o7kOxmmTbRpVmoMsiFwrCQVUjz8CoU9/Cwbi4J2m9ARTj/JkZ5eCoQQ5L3fNEoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788263058; c=relaxed/simple;
	bh=BUkjbYV758lMApBwAFvI7Bv71IVahOGeBJ9ExLaKqqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjnQFskEOJNX3kNJTK5MzN4j0sINmmMS6WYv7g4TAt53iwBekkJYHNY7SSb3mBHDsAeMQY8Aw7iXuQsdaNYIeRFA2MtULslUYyVWIwBo7fAhg3/xg5j76r2gRjVkBtdQpm/rGjMz7+nJZwrS5q05zMbP26+RaLUxSkFq1rstlVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rh/Jsoh6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rh/Jsoh6"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AVYfv3265923;
	Tue, 1 Sep 2026 11:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QPmWBm
	P82I5GiaGgd8aguFLASxy+GfhCgxgB3aMu9+U=; b=rh/Jsoh6S1QmGFAmK230YG
	OMBq/rQniI3uEHXuy+hk3YYZ5bVDm9rUBWmEtkUa3UFOV1f0Env5AE4/kXWnz1D7
	Vi3peyUBYzk2jWDawY+zXbo7Ab/xE8KdIvnWfACSEDkgdYDgefJQDUmI4LcqzQpN
	Lg4z1wPpegDjIGSOo20PIbl7HyIXmjseXe5L8CbOpbpXclGCUHUSLAozFQ8c9Koc
	CpsODoxBduTEUWc6VoDy7zU0PEvVOZauAJd6UQhYYU3X9HEyiGAuq4pMg93TipuH
	iIUI34/df4/akqIl6d+WQN+2y8HIpnX9c4nT9BlE5C3cG5VBz6YjFfIo3R7AZ1Nw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r7evf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 11:44:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681BfGmx028160;
	Tue, 1 Sep 2026 11:44:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygb8p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 11:44:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 681BiA6G45416822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 11:44:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EC0F20040;
	Tue,  1 Sep 2026 11:44:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC6F92004B;
	Tue,  1 Sep 2026 11:44:09 +0000 (GMT)
Received: from [9.111.27.156] (unknown [9.111.27.156])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Sep 2026 11:44:09 +0000 (GMT)
Message-ID: <d6fcf081-7613-4d3a-ab62-6c4f9a42816b@linux.ibm.com>
Date: Tue, 1 Sep 2026 13:44:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/20] KVM: s390: arm64: Query Available Arm features
To: sashiko-reviews@lists.linux.dev, Steffen Eiden <seiden@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-12-seiden@linux.ibm.com>
 <20260831194654.39B451F000E9@smtp.kernel.org>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260831194654.39B451F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a96ba8e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=H2J1ql-I7Lu3LdE3378A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEwMiBTYWx0ZWRfX7Rp5TiDnhW7Z
 s6tGkTTKphiYFN3rDzD3A4YJANiITqPpDo3HWgJ7OuNy1Z94P/luD8mHjNBxPrBaKo5DAA208If
 Yxt/+LNPHNejHNlj9PUldGbqrcTi7qLEYYZQWVpeCQ0GnNbke9jOD+fPpFQOmJlLHMgNqYZZfCl
 9W+MmNtOr8VIMj3y6v5PRI7Iv+Pg1iDHj5H3sL51XIPIs+d/axutCqINy/KsztJXPwKLw8+ll8A
 B5syXdk6N+5/QRUUhlmaEsHAKX3lgS9xRL3k137JMuWTPfJq9CIhpyfJr3gSbzKuJn2Pu/LG9fm
 taMwp323xeXYj5yMLyzTWmDTRKoakBLqlgQKlfk3avR2AqJeI5a1IKsHNSrozseQQRW2HhUUrEQ
 nuqS+jFV3hly20fScyRRzYllkqbflfYbK4ZDA8hSfRldLaou/0JtjIkHv3e3TVhZJIQ6jr9LgfB
 Otx2YNMHEUC5TpDKJ9Q==
X-Proofpoint-GUID: Tg0JgOrFhG86iz5Frw-Y2jhVn3D-Bx65
X-Proofpoint-ORIG-GUID: Tg0JgOrFhG86iz5Frw-Y2jhVn3D-Bx65
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEwMiBTYWx0ZWRfX6uotoSvz98jg
 hrLXAKcZNpJmScHyqLpf/SghfIxEPX4e36BFMj0Di6R2WTFGTg60N4isi+/Sf+LYqXsGb5Qf4uu
 xCN7+lftNkRnGtWW0BUoiWYrF3qQ3rc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010102

On 8/31/26 9:46 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [Critical] The EX_TABLE entry in the `qaaf` inline assembly incorrectly places the exception fixup label on the non-faulting `lhi` instruction instead of the potentially faulting `.insn` instruction, which will cause unhandled hardware exceptions to panic the kernel.
> - [High] `aef_sysfs_init()` unconditionally calls `aef_init_save_area()`, failing to skip it when the AEF facility is not present, causing a crash on older hardware.
> - [High] Off-by-two index error when accessing the QAAF registers array in `kvm_qaaf_read_ftr_reg()`, causing KVM to read incorrect memory offsets for all features.
> - [High] If QAAF initialization fails, the global capability flag `info.arm_guest_supp` is not cleared, leading KVM to initialize using uninitialized hardware capability data.
> --

[...]

>> diff --git a/arch/s390/kernel/aef.c b/arch/s390/kernel/aef.c
>> new file mode 100644
>> index 0000000000000..825e2643a8921
>> --- /dev/null
>> +++ b/arch/s390/kernel/aef.c
> [ ... ]
>> +static int  __init aef_query_info(void)
>> +{
>> +	int ret;
>> +
>> +	if (IS_ENABLED(CONFIG_KVM_S390_ARM64)) {
>> +		info.sae_avail = sclp.has_aef;
>> +		info.ptff_avail = ptff_query(PTFF_QAGTO) &&
>> +				  ptff_query(PTFF_QAGPT);
>> +		info.arm_guest_supp = info.sae_avail && info.ptff_avail;
>> +	}
>> +	if (!info.sae_avail)
>> +		return 0;
>> +
>> +	ret = qaaf(QAAF_FC_QMC, (union qaaf_block *)&qmc);
>> +	if (ret)
>> +		return ret;
> 
> [Severity: High]
> If the qaaf instruction fails and returns an error here, `info.arm_guest_supp`
> remains set to true.
> 
> Because aef_sysfs_init() is called via an arch_initcall, the initialization
> failure is ultimately ignored by the kernel. Later, kvm_s390_arm64_init()
> checks `aef_info()->arm_guest_supp` and will proceed to initialize KVM using
> the uninitialized `qmc` block.
> 
> Should `info.arm_guest_supp` be cleared before returning when qaaf() fails?

No, we can instead check the sclp bit for sae_avail and early return 
before the assignments.
I don't see a gain in having this information shadowed considering the 
two patchsets that are floating around. Maybe you need it at a later time?


sae_avail is also used in patch #20 where it makes even less sense.
Either the machine and KVM have sae capabilities or we don't need the 
sysfs files. So why even add it as a file?

It's not like UV where we need to opt in, it's either supported or not.
If it's not supported there's no need to have sysfs files.


> 
> [ ... ]
>> +static int __init aef_sysfs_init(void)

aef_info_init()?

>> +{
>> +	int rc = -ENOMEM;
>> +
>> +	if (!IS_ENABLED(CONFIG_KVM_S390_ARM64))
>> +		return 0;
>> +
>> +	rc = aef_query_info();
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = aef_init_save_area();
>> +	if (rc)
>> +		return rc;
> 
> [Severity: High]
> Will this execute the new qaaf instruction unconditionally on all hardware?
> 
> aef_query_info() correctly returns 0 if the AEF facility is absent (since
> `info.sae_avail` would be false). However, aef_init_save_area() is called
> immediately after without checking if the facility is actually supported.
> 
> Could this trigger an operation exception on older hardware?

> 


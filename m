Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC2C47ECF2;
	Tue,  1 Sep 2026 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280620; cv=none; b=qmD/DkWyLv6/hAQOqlYqoqNy5JPCIaZPcVCWlDuHkT3HFoXtrvGrmUJa3weK01TrrPXhvqFuzSSy3PuClJ98E6Xkh7I65OEoM+v2FwgaQ+B+qRneYhWRPGgRYR02/Gf9oL9PyF5rPnfsCsEEGyRP/3RkLVLQyMcBbBUNxBLF/BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280620; c=relaxed/simple;
	bh=PEvc8SXX018fS9mzHoNC3+i0cxEFrJwr2pGmrc+qz1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6ZSn9VdVHR96lhZet2jwdMC2iFrVPtj53kIuN5IiAe0scki7Uri8m3ms+E+khwZTT82S5JA3il4mTQYJPWdr3hvdWXqD6QZ4T3339Ip5wYMcN9SWzP/NU2+4PwIctY11wZd55gwWZAduXauYf/fKE2P3JV/OXPPAmtxByWmFQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X8icXGKh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X8icXGKh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681EVeHN1340849;
	Tue, 1 Sep 2026 16:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+zgrLl
	1Jg1/788LUVf6lxZA+1xgrpYI+fljhWRtn+qI=; b=X8icXGKhW9Vmjgxcyse4IW
	VKckBkVd219Uwqx1K/SivAng9DYxwgERiflwbprimWQLq3nC9UWdgRpV5P5SO4wz
	1GN7ix+qLnkKgt2Eb0p8JRpKIatYKZaBHdZjkOd9LCHU7RVTeEgL32MQaOscp5ss
	3P0bHHqB7WifkGB7GCiTA7weyfIi6yxI4h71vweHLmqBDkI89cgYmN5XrOPbqHY4
	ScgN1ks5jN8Fd0ds3SLRH4R2TnNh7FYMLICh+XQ0Lg9mBC8BcTygbXDNzv4AMhP9
	xUHYLhtdeRR2wmQqMSACsxfJ6NoZaCrA8wemhKgBVURwTI7XaJ4g1lQRClHPH3jA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhs52e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 16:36:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681GQK5J019988;
	Tue, 1 Sep 2026 16:36:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gca4w4tvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 16:36:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 681Gao5r51249470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 16:36:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0EB02004D;
	Tue,  1 Sep 2026 16:36:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BAC62004F;
	Tue,  1 Sep 2026 16:36:50 +0000 (GMT)
Received: from [9.111.65.156] (unknown [9.111.65.156])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Sep 2026 16:36:50 +0000 (GMT)
Message-ID: <b840a492-f8ba-4a43-9b29-3359cfc98fa3@linux.ibm.com>
Date: Tue, 1 Sep 2026 18:36:50 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/20] KVM: s390: arm64: Query Available Arm features
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Oliver Upton
 <oupton@kernel.org>, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-12-seiden@linux.ibm.com>
 <20260831194654.39B451F000E9@smtp.kernel.org>
 <d6fcf081-7613-4d3a-ab62-6c4f9a42816b@linux.ibm.com>
 <20260901142550.231001-C-seiden@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260901142550.231001-C-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hlG0lcVX2bCztWFUfNTiH8_GRXfE7goW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE0NiBTYWx0ZWRfXwAsKvBCUH3xo
 G0GZ3Du+Wgp4SxfFwkaOTHtmbqV9VxnYhslSDyxbUaXqbewqXinB9HCUqNFIY9w0hy32VNOzfHj
 tedL3TACDIS5i+/U/OeUJaXnBZeGiPVC15V1TWm2oDJmYhFy6vDYjtDwnpMwfp1RIu8MH6qIdms
 WgZfuR9zLheJ72n6tcSLF+G/GtlbvrwVyDBXwLWb5oa01z1FYbb1P48d221b1CFMJ7w7b7YzJ0C
 gtF6MGLmG621f8B9mHu3+lCjb+WUKBCjZ6ZKEM+MRTkKze2ZVfVptj+g7zou2sZzsb8t0ueMful
 7KY9MHWaJgYyKlHvnv3O0HJ6SUDuvwXhJrSJXwcrqZ6a7+PHx2XbNSuxnlMoOj5+uD9fmLA2gro
 QRzVhUoa4ojqkBI2xtIMzI4V+wyPdAEOIfTL0WR6ZBE/3hyIdKfv4/hiB5PV2cW8OnhZccN5Kgk
 OjlB1dum7Web0JU2JUg==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a96ff27 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=KgNF-AsUkJmxFTXnebwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE0NiBTYWx0ZWRfXx+2vpM9qnmDB
 ZMXOLIQN+Ln298hIIGbDt8btcrM+ENguseIBL0K7bqElSM4CKtMKHg0nLBrgBR1LHKpgJzXHVEX
 DVkUZCJ67d/ZK9S6aWLx4W8AfHTNQTg=
X-Proofpoint-ORIG-GUID: hlG0lcVX2bCztWFUfNTiH8_GRXfE7goW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010146

On 9/1/26 4:25 PM, Steffen Eiden wrote:
> On Tue, Sep 01, 2026 at 01:44:09PM +0200, Janosch Frank wrote:
>> On 8/31/26 9:46 PM, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
>>> - [Critical] The EX_TABLE entry in the `qaaf` inline assembly incorrectly places the exception fixup label on the non-faulting `lhi` instruction instead of the potentially faulting `.insn` instruction, which will cause unhandled hardware exceptions to panic the kernel.
>>> - [High] `aef_sysfs_init()` unconditionally calls `aef_init_save_area()`, failing to skip it when the AEF facility is not present, causing a crash on older hardware.
>>> - [High] Off-by-two index error when accessing the QAAF registers array in `kvm_qaaf_read_ftr_reg()`, causing KVM to read incorrect memory offsets for all features.
>>> - [High] If QAAF initialization fails, the global capability flag `info.arm_guest_supp` is not cleared, leading KVM to initialize using uninitialized hardware capability data.
>>> --
>>
>> [...]
>>
>>>> diff --git a/arch/s390/kernel/aef.c b/arch/s390/kernel/aef.c
>>>> new file mode 100644
>>>> index 0000000000000..825e2643a8921
>>>> --- /dev/null
>>>> +++ b/arch/s390/kernel/aef.c
>>> [ ... ]
>>>> +static int  __init aef_query_info(void)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	if (IS_ENABLED(CONFIG_KVM_S390_ARM64)) {
>>>> +		info.sae_avail = sclp.has_aef;
>>>> +		info.ptff_avail = ptff_query(PTFF_QAGTO) &&
>>>> +				  ptff_query(PTFF_QAGPT);
>>>> +		info.arm_guest_supp = info.sae_avail && info.ptff_avail;
>>>> +	}

Wait, aef_sysfs_init() already early returns if !enabled.
We'll never end up in this function if !enabled.

Generally I'd like to keep it similar to the kernel UV code.
If QAAF is available create the sysfs files and provide qaaf data.

KVM support is separate from the QAAF data.
I'll have a second look tomorrow.

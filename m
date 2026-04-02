Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA828390205;
	Thu,  2 Apr 2026 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129260; cv=none; b=pSUW3eBe+kCnq2zwhEfZ1O34pURJWOSfvkvEEcn8l2xuaHVTswKjvxEyO9YVv8grOQou3v9bjb2qMhaOFkO5odjzI6XMVEGfk0cKhYPbs03fmVe1lpySjOe8AZMV7Qwx6z9NXWst5YqLSErvo3YPndkxyDkfQ4p5imkdxKvVaTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129260; c=relaxed/simple;
	bh=EfDeelROU6o6K7Owo7XkjToyiIraH8SU/eYJ2471fYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6Y/xHZ143LZ8Cp7IX+nhwxu+5LLhA1Ge+7aBDS1vgOhar9xnNhJX6awVOAlPC3wi3kPmATfsLInMNfzqvVrr5cqpDmg3QPl/TMiXclylswQOBWIMo2OmHutM2W8xixoGZ3cgmQ67VnjbN1kNt4qJwdrYD43jRhGpOCIiNYsO6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YgF6jzFi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YgF6jzFi"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631K0WS7351518;
	Thu, 2 Apr 2026 11:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=134Al/
	W95knRgbclnuh/o+ul0rtxFJ1H52x/sjCobRs=; b=YgF6jzFipfEyAM6zl5a9Gx
	VzeJCcS4/lv3Djnz20DaNE7SeZZ/o4F0zBHs8qcfU8R+A4XbnHDonEorOHLKLd/Z
	kju5XBFDccNDppwQbDtzpjg7kAgvQPul7NckWK8cupN/675jwZsnZr06hwuHhkyd
	+c/gNiQsMoiK8GscB1oFx2cLrQ+1g6wSVmazTkPC9Kuh86vR9xLaSCF1X8d978n5
	EPGQfQS5goZAl2KiYAnGGvnsLXcBBV765e/zfNi40tCmWSmqg0h1nFhmDKroog04
	c1BxkHhaGfcOdL34LQ8Ngz82zCKTPKjvBfxhT8oES2RK5x6U4+NmkTzA/Vkh0ItQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g24jr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 11:26:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632ArD3G021651;
	Thu, 2 Apr 2026 11:26:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sassy7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 11:26:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632BQscG47448446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 11:26:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CE7820043;
	Thu,  2 Apr 2026 11:26:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB71920040;
	Thu,  2 Apr 2026 11:26:53 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 11:26:53 +0000 (GMT)
Message-ID: <c251ca9c-6fae-4f64-8e10-792f42872582@linux.ibm.com>
Date: Thu, 2 Apr 2026 13:26:53 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/27] KVM: arm64: Provide arm64 KVM API for non-native
 architectures
To: Marc Zyngier <maz@kernel.org>, Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Andreas Grapentin <Andreas.Grapentin@ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
References: <20260402042125.3948963-1-seiden@linux.ibm.com>
 <20260402042125.3948963-8-seiden@linux.ibm.com>
 <86y0j53caf.wl-maz@kernel.org>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <86y0j53caf.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69ce5283 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=z1V4dRcsYzbvUw6_Kx8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HI2DK5H5wC6ad5B9YnVOxaWLprzdU9gx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEwMSBTYWx0ZWRfX3nF5lxvZ6dE7
 FksS0fkJJanzuKM/mt/NzGShaEpUwNpTTBXziUvh2Pow3kPl5764MGt4zfosBudNpv24oVRUgYm
 jsbDHWcjLBJbNZk3kJ7PVY8LXySqOGWIOAm+PZn2Aovr1NWSyzfYZhTcAenA3VqwSS6JUGKKGm+
 NNEbXsLSHWEtDhn10yivwV2WYfTvDee6b/kMbb5xKbjJ2G2XTGbMVJ7bmespGf2xVMg9dfL3arj
 WDU1Iwx3DufEC6KPvPDIro2YCFANpGSJUbFflqHm3N1xR4l2AOIbXrrSQw0RaqGRaPXpuaWTt20
 JpmIB05IXepBc/StFDQ4V4HA3cDs6NT7lMbpjCaop0BAVPvKsyDeRZ33jTgElh8zGAWHLUevM0c
 kNgyp6gBYPStJwHraQ5Lte2qhmrtY7AEVjkaAgnAlRB66GpJQjJNwn1Hy7w4j+PKSfKoJPeFNX5
 1VEz6vTWPXj07uBaw7Q==
X-Proofpoint-GUID: HI2DK5H5wC6ad5B9YnVOxaWLprzdU9gx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020101

Am 02.04.26 um 12:08 schrieb Marc Zyngier:
>> +static inline bool kvm_supports_32bit_el0(void)
>> +{
>> +	return false;
>> +}
>> +
> 
> This looks wrong. The original file still has:
> 
> #define kvm_supports_32bit_el0()                                \
>          (system_supports_32bit_el0() &&                         \
>           !static_branch_unlikely(&arm64_mismatched_32bit_el0))
Thanks for spotting.
Yes, we will fix. Seems to be a leftover when sorting patches.

Christian

Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CBE331209;
	Wed, 12 Aug 2026 19:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786561659; cv=none; b=pZR4qSVXUGS0/5olcxYHexV/Xh0r4BVlgHF3s3Nzdia3dSrepFUxI6lQm0kg1Y6cd4v9cNobhr4fenmT0dvSSyHla6PnMHSSQw7udU1RjEI7XnQoncLIFeVBw0fqj+4OAoBTHSqs9Bn1aRsEdKFW/CBS07dWbwXqRkGXt2V6xGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786561659; c=relaxed/simple;
	bh=ROLI4YhjZIn4wBhbFzzqP3pJy4PhPKEypoC2vPIL/KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsLlVdX23eh1EYY4Wn1LCSqltrCVWsitxzouP+5EOJAbhANngLriQJxMFJjquFqSF/kUxDrHu/1Xm1buFkcgQgaMn6ysbSv33QoZ2R8c8orbWar1k489EeOmMjZoT8yKmYBjSxNPrtQwNnrcO2IAWt25m0hTo9XK1BavUyPf18I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CA9EiHjs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CA9EiHjs"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1uXt4120774;
	Wed, 12 Aug 2026 19:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=utIf9q
	pYkESZpxoFc+6cRTzy83WPklzVXzlqxHNToFc=; b=CA9EiHjseprTwJQ5VYGtgs
	KRtmVmAfdi3a+kdnxg48qcmJS7uS3a7IHY0sQOhE4NnP5/PBdb3AaEvlcZwZ80z7
	QlHszs2C08FlYsErJGJDILvMTl2z1Ma3/3Vg9lBcpnzhs644pav2UHi5KzeblgHc
	xEzTx58MBgEKMsQDP/W/kmh73oTZR3eGdmu1BzaQscL4Dq+/M/7Q15HXFT10YuAH
	idJYlwXhUElUhWNd2hGWJ1s6URrOTOFgwGA6e5pHhA6HzxQoVfywdi2o75Xj+VQJ
	QE9a+6fcIvDzlisI0e77mym+Wp09QPs/DsDHRhceydK4n9Ag6JWsfNk30xIHFC8Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwbbnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 19:07:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CIuIep019003;
	Wed, 12 Aug 2026 19:07:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h7h1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 19:07:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CJ7EVd37945744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 19:07:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68F8020043;
	Wed, 12 Aug 2026 19:07:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F8CF20040;
	Wed, 12 Aug 2026 19:07:13 +0000 (GMT)
Received: from [9.87.128.143] (unknown [9.87.128.143])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 19:07:13 +0000 (GMT)
Message-ID: <ef1dff42-5d35-4f2e-8a13-03c33b96a7d6@linux.ibm.com>
Date: Wed, 12 Aug 2026 21:07:12 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/33] KVM: s390: gmap: Make storage keys optional
To: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter
 <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-20-seiden@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-20-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7cc468 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=PCBwtEoN02dcB8kVq5UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: e7pmWi42NJwRQlwXtePs6KkKlmNqGyDr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE1MyBTYWx0ZWRfXyGUZkT8MYv1x
 TlF8wjdWFsp0uYykCiFlcBqWlf00tU+XL11wPQfb7tGRwBLeYE9Q0ZANWiSFGKeC0agLkCnIauP
 rhK5RZowRZwsa6MJ7TE4hbXeekDkRqM4izfOunCEFaWyPFchX4hM3R3/bdj5uUkltFk60CnWkCS
 Kc5+QpzQdiIXLyfCSsuQ4kBeuw4K7Q8w48MpS53XpY2nUjneB4wdqfSjlH4GtODv1o/EBJzv6yb
 MZOjG2BQUvIi2mLqXK/Y+pRzvBJee6l0QlE+w5iQC1vHnmANr7TirjdigmrN3GjZRKDow4jMgK9
 BXvZ5mQoA43jr6KdWnhHI8ig3g0FADJ/qvmGhR1U+6cdyflvKZ5/w2PUqEHSr5YyiOWsVgjDAIY
 JxjpHR+DahyiH6xCOk++5y12pgCO9MEsYFEMjkcKLVXDyMHxNsxanAjXwXVqI+Gn+ahstDf7e9j
 jVDTED2Pc1Hcl6dq18w==
X-Proofpoint-ORIG-GUID: LVy9jCCWjEPlN33hC9kn7oMuJIEOs0Sh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE1MyBTYWx0ZWRfX5BH9HXGn7ooG
 NPJI5JceKu6wd8i+9AO5kpenjzBz74mpjTxj4jNiV4vVhFpdH1pM9gw/u75ByORufmSagSMWmTD
 RxJzYyW01umkxTsOxxq9TMM0qW1qPnA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120153

Am 12.08.26 um 17:36 schrieb Steffen Eiden:
> Guard guest storage key handling behind `KVM_S390_MANAGES_S390_GUEST`.
> This enables other KVM implementations to use gmap without implementing
> storage key infrastructure. Define KVM_S390_MANAGES_S390_GUEST to 1 for
> KVM hosts managing s390 guests (in kvm_host_s390.h). A KVM
> implementation not implementing those features must define
> KVM_S390_MANAGES_S390_GUEST to 0 in its kvm_host_<guest_arch>.h.
> 
> No functional changes besides the new guard.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Maybe we find a better way in the future but this certainly works.

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF5C33064A;
	Fri,  8 May 2026 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234891; cv=none; b=WJgsEyW9PbjW+oqwmq0DCiE20HBN5YWQujO1ru3o2R5PxCqd9PwsHDLyarJDl3SP+TKgfxuQ4TJQ4LyelfpbZGi0eNGmTmpiHH+4F0VSlB/gG2idjbCb9DWtmHyJZkCbGEFTmDVBobW+2cKn0bQHOCmFebqxL/VwMvMPpM5JD80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234891; c=relaxed/simple;
	bh=oowpiSCkX+oLId3c0YgRMI8IPfRBYasH7FJDbGClctA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gw796fURsWLtIMhHrKRzUc/ioVZaMDHdtuEq1R0L7w7hR4MkvOqQLheHiW/w0kgBraiwDmDvOMukanbxULC9VLTEwrc5gkOZMIjfVFvwUIM7oTfBqcyhevP0B4BQFUlkL3nEq5P+MxpSlsJ1Iqv2jOkbc1UVdcGkRSi2QtQjNqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H6QFSLxt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H6QFSLxt"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64897vfa2197452;
	Fri, 8 May 2026 10:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GSJj2G
	T94ClYwRuSlXkKx4lW5Zp4vKHmDONAROcqMm8=; b=H6QFSLxtYGhZSgkZL3zqvs
	CBY+rujt1RL/GK7OvNyeg2EWVlSVnqI2+/ADeDhdAXQKjBp2NxF1Oxipy7Fp4BCd
	3WHVVBrQt88ARkq7ucAx7JzgupCyg+UVDgX1yDqTokZ14jABtkt1KtFYh5UGyI60
	geLyusvZRoBYEk/j08Gn/REFoGiE9kQciKEoyfDcWOGezTB0vq6bp4G6oPZXVEtq
	yYD6VWxSnrwRB3v6mLL8Xax2TePYANZI9EXoTqJwxh/lIBveTiWaYg6H/+P9Rgnh
	zT8Pzn2wMgi8tEkB1UjRAAo7Hk03PI8F7EL2vDmN+2AEO3nk1DL1PDKMX8m+gqWg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6sv19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 10:07:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6489sdap031316;
	Fri, 8 May 2026 10:07:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yqf71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 10:07:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 648A7qwp15860104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 10:07:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CE1720084;
	Fri,  8 May 2026 10:07:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA6E620089;
	Fri,  8 May 2026 10:07:51 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 May 2026 10:07:51 +0000 (GMT)
Message-ID: <1ac58dd8-1b06-42b5-9a19-67620b4fdc25@linux.ibm.com>
Date: Fri, 8 May 2026 12:07:51 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] KVM: s390: Toggle operation exception for
 userspace
To: Eric Farman <farman@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260507200836.3500368-1-farman@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260507200836.3500368-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fdb5fc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=IANEE5CLunT1K2rsnZcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lfNgwLiYyvFr_2YeCiT83DU2ZXIREa6s
X-Proofpoint-GUID: lfNgwLiYyvFr_2YeCiT83DU2ZXIREa6s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwNCBTYWx0ZWRfX4DQAX34G+GKU
 kbJtwPpHw9vUfnM/mLDPj04SXkyoM3mL8ZMqnAO7YjuMp5e1t4hUREkv6k5uA4lPNMWkjV+HW9e
 Fbnb6HYXmQO89A4Cy9hSo8qpZvcZSEVSk8u58d8rU4hdDgGENU/Vjhf5xKIEPSEBHfDypC3eEXc
 Gcqs7qOodr9QLSnqWVkvLbp8e7zY4CMqxcajx7jx9Az/BCKsKU5WfpMjLOPAJbz9M2hmVuLi5mi
 TzTEnKX+pqgucKzIHhBQCF/zFOgQ2Him6dEN0tM8EzmYjzrUfv10t/JM/I3KlU78p8i5Ct4/9Gn
 3bfDzWvlBm+D2oktY7o8QOH5XQ+sGuKof0dPTNZ2b90EcILClQ6I1u6SlgPFP1Yqfif/3qnb2dr
 PcCNEuuEc4ShEeiusfWJphzWaikJkkD6gdFQI+53NEKdau/8Eb+Nx67bybEsPGg2XEgEqMsd46r
 ukE8hoOztgMpb/OEMIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080104

Am 07.05.26 um 22:08 schrieb Eric Farman:
> Claudio, et al,
> 
> Here's an update to the USER_OPEREXEC patch I'd sent the other day.
> Besides the addition of Claudio's r-b (thank you!), Patch 1 is identical.
> 
> Patch 2 contains a couple of new selftests. As it stands, they all run
> with patch 1 applied, but I put the failing test at the end for if
> Patch 1 is missing.
> 
> Patch 3 is unrelated, but is a minor typo I stumbled on yesterday while
> looking at this. It seems small enough that a second `git send-email`
> command seems unnecessary. :)
> 
> Eric Farman (3):
>    KVM: s390: Toggle operation exception for userspace
>    KVM: s390: selftests: Extended user_operexec tests
>    KVM: s390: Fix typo in UCONTROL documentation
> 
>   Documentation/virt/kvm/api.rst                |   2 +-
>   arch/s390/kvm/kvm-s390.c                      |   3 +-
>   .../selftests/kvm/include/s390/facility.h     |   6 +
>   .../selftests/kvm/s390/user_operexec.c        | 110 ++++++++++++++++++
>   4 files changed, 119 insertions(+), 2 deletions(-)
> 

Independent from this series (which makes sense on its own)
shouldnt we add another fixup so that we send these kernel injects also to userspace?


git grep PGM_OPERATION linux/master arch/s390/kvm/
linux/master:arch/s390/kvm/intercept.c:         return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
linux/master:arch/s390/kvm/intercept.c: return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
linux/master:arch/s390/kvm/priv.c:              return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
linux/master:arch/s390/kvm/priv.c:              return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
linux/master:arch/s390/kvm/priv.c:              return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
linux/master:arch/s390/kvm/priv.c:              return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
linux/master:arch/s390/kvm/priv.c:              return kvm_s390_inject_program_int(vcpu, PGM_OPERATION)

Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA8E3E835F;
	Thu, 13 Aug 2026 07:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786607174; cv=none; b=IccUCe8WJvyX8EazYqDJ7RIyyKgn5aIBwKL8T0JG+hjCsudpVPwxBvYdrvdxnwfPZvjn8KYSECA/eT/S7KWCRVeTKnnChI61+XXgqvueVTB/1gKoKXz4t5QUrWWpjpj8A1Kz/faZUJx9eRKztXB7ee6OsfJ85XeDM0swnNPefOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786607174; c=relaxed/simple;
	bh=1vo9Y4XIVad2RZZyOvs8rxlGx9KMqiq3j+EG59t6nf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGN4qvcbf7DIYQoTQXz7yfzGf35frsFu4T1Gtcv0RExxxRX7ltj70a+i1zpnweJ7TXbKximSoYRvO/dvHrbw8UHfiHIbDLxKYumTWc3MydRByMhqX1bfDK32uhsvVLx8ATkoovaWwb22K/hpTVUasfGVkUc0zeLpA99hyPduHPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YuPBivRt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YuPBivRt"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D61hP7422639;
	Thu, 13 Aug 2026 07:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5wxhWI
	Orz2kNxcocrn9fFklfGlma0HZ/9L9pcwnG4N0=; b=YuPBivRtBNwJBu+khnt1GU
	BiVqVKwAKxqcepKWZ8fkz/1r6zPdIjqTJgCN8ZaCgM526vgNdfzCmhl1Jqa4zait
	u/hj9158GLoMkRZguwA50UP+JXMqx5CcUDCRJwfZHpCgm/b7s/GQkB7WdFGzePuB
	p6A4+SKPEG8vA8rzH5cKqNzTu6MGK6wAAEv/dfIlowcqKMrGFm8aUN/bx1ZsYLaU
	6SaHcxpqP+mVBkYXen2UQbZ6Tah1ZqitVGI9++62F2jAAWtubLKCmuKRzibAHBIP
	apKNEPDMBzz+Fxiaztdutah+pxopl1CRY2L4R02mQIhJrqV4ccmAFmnCLsodD9Bg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23y7w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 07:45:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67D7fdqe005198;
	Thu, 13 Aug 2026 07:45:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy9vuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 07:45:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67D7jdbi31785384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 07:45:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C47920040;
	Thu, 13 Aug 2026 07:45:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8C982004E;
	Thu, 13 Aug 2026 07:45:38 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 07:45:38 +0000 (GMT)
Message-ID: <ef51ea3b-784d-47e6-ade2-14bebaafa7af@linux.ibm.com>
Date: Thu, 13 Aug 2026 09:45:38 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/33] KVM: s390: Introduce arm64 KVM
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
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-1-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7d7629 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=cBNhPelFHdF66-ObYm0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1MSBTYWx0ZWRfX3scfBSEApymH
 AQgmy8l5lVkwsIPsAPois7OG8BL/l3ppbaTaVpBKPvA2HshcrCNevrSrbmEOgthAyMquWqXp6Tt
 rg9dvq887TaMwoXpN6mYXY2JFqlUWAj73/kQ4eqQy4lzuY70zwfdyDl1XZgTbhLHX8fvUFo5gIO
 xXP7774ZKIOEDIdIgwpmc1kxZhzW+ts9dom2Pl/ssMrbzAGXqP2d3cN8Tif2+Krs2NfSeEdD7P1
 hQbjrf2Pta58S3mljYyOujAmIVsx6iXnsaYmPRvNA2UleRyaDQw4hetuTWYIcAX8MZ5EvHs0pSz
 qtZ4u524R8aDB1voxRnU8lcK8ywGVx78+Zfnq5IOrrTfpHoADhQLTGoc6K00MaDYXXk1bIRBWGQ
 BGHxh5/iDfg/NptmpxLNm4qKZTEKaPe+cfJMZIYenydLZP8/WnGaCggTgw6K6ZSMxaDRmT7wnfg
 P3MjlMUXC7RJn4Scs6Q==
X-Proofpoint-ORIG-GUID: Pp0T091dZEvuATX0JOSDZWgF2LJ7OuXR
X-Proofpoint-GUID: jAEarrlgndIg1HcmIo59Vp38wsXCp6Rt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1MSBTYWx0ZWRfX2FbayEkFPgOz
 D7Ud+M6RwTnR/57QibX3eIgjozkBSL030RlMctJAH/GtK5vj5scrOuja31BRhVO8w9dsPcoYils
 M8t5QV6j9c/i1nKXUVJyb4LvmBOkHg4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130051

Am 12.08.26 um 17:35 schrieb Steffen Eiden:


> C) KVM/s390 reorganization (patches 12-22):
>     Prepare s390 for a second KVM module. Move existing s390 KVM code into
>     dedicated s390 and gmap subdirectories to make room for a second KVM
>     implementation. Refactor gmap to better integrate with the second KVM
>     implementation. GMAP hides a few features only required when managing s390
>     guests: Storage keys, CMMA, and prefix handling. Those are guarded behind an
>     #if KVM_S390_MANAGES_S390_GUEST. Only features which implementation would
>     break kvm-arm64 code are guarded. I leave the non-breaking stuff (like
>     shadow-gmaps or ucontrol) for the LTO.
> 
So I picked 12-21 for kvms390/next and left 22 for later.

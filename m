Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B5B199EAD;
	Mon, 10 Aug 2026 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367805; cv=none; b=b8EoUK0WGYnnfvHc5lt/MbvQ5UDTrBxMUEGALBs6DlZwrEhTQuHMDFa5CiPIlwMXpXeNP5o2FKTm/RJamq7qP9xIJ2A0Kz64/g7m2OkYs49+6BSospCUuOXt3DVKLBGaoiYPZWj2g8ybqYNYtvYzdGUkIHX0nIM7OYbLkwWexis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367805; c=relaxed/simple;
	bh=MUSENsZfYiYOLdqk/MmbgfDupd1hSE/zahkgybFkf0E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:Subject:From:
	 References:In-Reply-To; b=EPTm9rr1b0VctZJ760CA5+KH32rPx3ELr/wqdhxI+JwlG4PKkLftei0zLek92fL0b9Cpij1shaxqD5aMvajyAcsELxVDStqqLzOtDMzagKOQl09FMcVTesQdDE9GeFNrBwsnaRtbMmbKBqBitPbbbTmFpUFNyGDI6rdNX8GNhLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qssJh2Bt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qssJh2Bt"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AD1aU81611696;
	Mon, 10 Aug 2026 13:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=N5UPpU
	/n3twch95buO9j5jBDTdAzCGLlHELs/4qEcwY=; b=qssJh2Bta/gZ7CGv1anrc8
	vAkpYZ1UULdmRRR2XA7iSEw+m8rw/3Jrlqq3BfbccvQreU457o1/592PrWTcDwu3
	aP1X9jwguR/vohem6xrB2vJEQ6UskLrEXKM3Zd14pNa/Ey8+MuwnLIKMTUBmZvu2
	BqjYfqFPRx5KJc042P5BfW0tg6PoUYj/5hGsy/XbR8Q5lUQfI9lkKB/nfCFuPNbp
	ZkUnqq61gVH2L+x6qjX+hmQ9dRdQRQuEj3zEgWVHoL9Py8R6ooAqvQvQG8vxOlSO
	FHjkaAX291O1XdTq+NCqCZAOf7qzFP/pPgG0DI4LWINUF7eE/+CJcWWpc5wPRopQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2qqta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 13:16:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ADBLp8027883;
	Mon, 10 Aug 2026 13:16:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfxvnvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 13:16:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ADGaxV52363704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 13:16:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 588D420049;
	Mon, 10 Aug 2026 13:16:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DF7F20040;
	Mon, 10 Aug 2026 13:16:36 +0000 (GMT)
Received: from darkmoore (unknown [9.111.41.151])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 13:16:36 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Aug 2026 15:16:30 +0200
Message-Id: <DKLAJ607XEKH.3C57LOEU379HY@linux.ibm.com>
Cc: "Janosch Frank" <frankja@linux.ibm.com>,
        "Claudio Imbrenda"
 <imbrenda@linux.ibm.com>,
        "David Hildenbrand" <david@kernel.org>,
        "Heiko
 Carstens" <hca@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Sven Schnelle"
 <svens@linux.ibm.com>, <linux-s390@vger.kernel.org>,
        "Hendrik Brueckner"
 <brueckner@linux.ibm.com>,
        "Eric Farman" <farman@linux.ibm.com>
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        "Christoph
 Schlameuss" <schlameuss@linux.ibm.com>,
        <kvm@vger.kernel.org>
Subject: Re: [PATCH 0/6] KVM: s390: vsie: Small VSIE cleanup and
 improvements
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
X-Mailer: aerc 0.22.0
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
 <c16e6836-c816-402d-8457-f763aa343356@linux.ibm.com>
In-Reply-To: <c16e6836-c816-402d-8457-f763aa343356@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a79cf39 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=KBDZwit2TKa8l5wiHBwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: CU8KwODmqUhVz3zYgEvggBu50_dkmmPT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDExMiBTYWx0ZWRfX/e7tKeprQS4t
 CEEtVDeVFtz+0VYVACafOh5aeEsI5rGxHmPyNdQKXjzsSiDpGw76cpvcInf5MkC3Wc26bFtsCv0
 hT069xgZe7d3uIzmMHkcXdxxrZQYU1QGdaRZLs4O/HRrjFkXCeCFpYTX4uBG2c4PTalovgrtRYc
 FcHm3yCaBb7DTUk9FHZ1k4LH/t74+XBBQgxttEH45BouiNWqKsE6fEwk9mbPdT4NngjK6q34ku4
 vhCephixaJ9R84RjITauWXJGLJaoZ7NVoC2ghxZpOraYTpKwumFPiwYJZmuLCJUzW6xHBzhQdul
 4gfDpx98+JJaSlAKAP9o8VdNC5SAnaLbiQeKO4rTn3ryCF/ifI6t72BpcMQJGCxjVQAhFCD9GXo
 nXV7BQpj+zG2dr6xL89D9yB3iUisrdxzZgEtXf5xs5CFP2N/MM5dph1B69qUKBTW5xh6t+HzOAV
 BEhw5Jp1Rq94U1JyJSg==
X-Proofpoint-ORIG-GUID: CU8KwODmqUhVz3zYgEvggBu50_dkmmPT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDExMiBTYWx0ZWRfX55lgSr7Kj0eK
 HlByXPItM3w848Nt5l8ViWWh8h2BPs10RBWDbiTk5FrYMHbUr+VuDjVzzguyvwx6ZwgMhPRegE4
 1incMZxxIFlUSuEWFs4FxV2vLewBACs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100112

On Mon Aug 10, 2026 at 2:05 PM CEST, Christian Borntraeger wrote:
>
> Am 07.08.26 um 11:57 schrieb Christoph Schlameuss:
>> Some patches previously sent in series
>> "KVM: s390: vsie: Add VSIE SIGP Interpretation (vsie_sigpi) v1"
>>=20
>> Link: https://lore.kernel.org/r/20260709-vsie-sigpi-v1-0-ea9f12066408@li=
nux.ibm.com
>>=20
>> now in its own series as proposed by Janosch in
>>=20
>> Link: https://lore.kernel.org/all/77387525-cf7b-4617-a492-d81b6c1cef17@l=
inux.ibm.com/
>>=20
>> As well as some small additions like some of the offsets in struct
>> vsie_page do have in page offset or alignment requirements. Adding
>> assertions can actually prevent bad code changes as well as provide
>> clarity for the requirements.
>>=20
>> And introduction of simple SCB_ALIGNMENT_SHIFT constant.
>>=20
>> ---
>> Christoph Schlameuss (6):
>>        KVM: s390: Remove double 64bscao feature check
>>        KVM: s390: vsie: Remove duplicate assertion
>>        KVM: s390: vsie: Convert shift to phys_to_pfn()
>>        KVM: s390: vsie: Assert mcck_info offset in vsie_page
>>        KVM: s390: vsie: Assert crycb alignment in vsie_page
>>        KVM: s390: vsie: Create constant SCB_ALIGNMENT_SHIFT
>>=20
>>   arch/s390/include/asm/kvm_host_types.h |  2 ++
>>   arch/s390/kvm/kvm-s390.c               |  3 +--
>>   arch/s390/kvm/vsie.c                   | 19 +++++++++----------
>>   3 files changed, 12 insertions(+), 12 deletions(-)
>> ---
>> base-commit: f9a2394a23482bfd330911e9c8295b71724feacd
>> change-id: 20260716-vsie-cleanup-202607-8690ba7ac3ea
>>=20
>> Best regards,
>
> I adjusted some commit messages and applied this series. Will schedule fo=
r next.

Thanks!

(I did have the v2 ready, was just waiting if there where any more comments=
. But
it was only changes in the commit comments)

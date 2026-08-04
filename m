Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76DA46A5E1;
	Tue,  4 Aug 2026 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863938; cv=none; b=mk6v0+S6TgIbkZdxzRfXWEOA3FgdstzVda0wxYOgBoucwIOHFWoIACtxFwebyS0fKKdbyLShwX2fDzYQ0OFey0JxivNxAhvrC9OBHcuVuwbcDkfTmFMjroq7cNes+b9//dVTsuEkqaWAvYB0tEIgHrGpODeSLQrZv5m7kPikUOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863938; c=relaxed/simple;
	bh=J37+rILGjJ9tGRUFT6chBoqupmBmzzATqKwigX0Ro8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ohRRHQHFIF5U/RRhyjJTv+jBgRP60rbXuBUt36JcTpcJfVNyNwOKis6Uf3DRXxBKFsCZqIDJzrMokXtDtKQSTW5WPSup4EEnrQF1Vq1hq+zqkBuUkobYl1rJYC5UdxEpkk3po5+Zfzd33vE8HHcnYV/xviuUuRu6w4EksxplzxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lgrRDCpk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lgrRDCpk"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674FlpXL1254663;
	Tue, 4 Aug 2026 17:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iwk9LZ
	XYsgVFwdXypfXiqcaQFf6rgaoM3Waefg+32DM=; b=lgrRDCpkwQe5lVFEM+JpZs
	Dw3AOhKry+JWjGHiMg2RJ0hwc9+a6YyZkVd4EtGKjFeRaRDlF5c7T9kQojbflzf4
	iL8tTIEjh45LSgIGhsJyweKmQgkNKW0a2AgRO9R9gNSvzWhAOhfZuACrAKKJwrkr
	g0G4ivArtPpluIKXwrexsmAmuCuJ3qbWj6qFI5l8ht7V0OqukDLeVOhFJofOAEBd
	vg7wTo/8d7EI9nnf2CH4RZxGkB1A7qv+GEi97J/xSEYvYF54SZzYwCpkry7FLcCn
	JHg351QXDIi6kAeP8x6XgZqB152n97OoHlz4OFJM7ysqzf1cOUm3WAVUdk/Wd+9Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3y2tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 17:18:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674HBNQI017772;
	Tue, 4 Aug 2026 17:18:39 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qk3qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 17:18:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674HI0Jg2097792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 17:18:00 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A23258043;
	Tue,  4 Aug 2026 17:18:38 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BED258053;
	Tue,  4 Aug 2026 17:18:36 +0000 (GMT)
Received: from [9.61.86.222] (unknown [9.61.86.222])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 17:18:35 +0000 (GMT)
Message-ID: <c7908e15-1683-454e-b6d9-bd32f18ce9ca@linux.ibm.com>
Date: Tue, 4 Aug 2026 13:18:35 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] KVM: s390: Zero initialize irq in
 reinject_machine_check
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        KVM <kvm@vger.kernel.org>
Cc: Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390
 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
References: <20260804162435.28617-1-borntraeger@linux.ibm.com>
 <20260804162435.28617-4-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260804162435.28617-4-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a721ef0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WBrIipxYDB_IIsAJn0oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7ziYLvUDsiG2edn1zgR7DPO6xqAoDyfF
X-Proofpoint-GUID: 7ziYLvUDsiG2edn1zgR7DPO6xqAoDyfF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0MCBTYWx0ZWRfX4XOGfPw6uD21
 HIvpoK95CMMECQaXtj3rCjMcN/qN/VG9Vy83Guy2Z1gUCBK2hKKvmnb2cdILL2q4Zefmo8qdSSE
 c7SzFiCkmRv+1pYvTiiyj1aNeVbabMc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0MCBTYWx0ZWRfX2oxGClG83xkG
 LAJyegdOKRLv0w73D+B/+bX/EVHoosshZpSe6ft7Tj9as2ga3OK/bm2fjwHA4kzLPxmqGX194yP
 tMXHIcTtfVcf9J7FRwXtp1jW2IcBUNRLlseV9Nh6LWdu6dtwIiT8YEQEVDyjDjXfC5wE6g7aJAZ
 OYj4OR7WHhJiRDui8hM1wXHNd1e1WNz6hXmzn0VIjpZxgzHs8nCn01DNlY4/cdzR7Gk44vzwB6r
 tvXSEHoe0k+t3PUubV6gN948a1n6hK1TnQ0ppoZR/jIliSWAVfVOi5imVDg0TzyvZrlOx4TdMqB
 D6sgT75dwPw9lAKclZcqOigBzvUV8DDJZ8uUXAaR4BwqCCFB889kmmWQqxl5f3nRFfPD0GyxHDQ
 naBlE4t73g6RDpdBgat3dkU+flpTxCKdu2vbAskshr09G7TCNNG6qO8f3Dkb48QdBSW7owtefSf
 VAzTnyekaElEccRpSPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040140

On 8/4/26 12:24 PM, Christian Borntraeger wrote:
> kvm_s390_reinject_machine_check() fills cr14, mcic, ext_damage_code and
> failing_storage_address of the on-stack struct kvm_s390_irq, but struct
> kvm_s390_mchk_info also has a pad word and a 16 byte fixed_logout array.
> struct mcck_volatile_info carries no logout data, so there is nothing to
> copy there and both stay whatever was on the stack.
> 
> __inject_mchk() then memcpy()s fixed_logout into the vcpu local
> interrupt state unconditionally. This will reach the guest during
> deliver and userspace during migration.
> 
> Reflecting zeroes is the correct behaviour here, as KVM has no logout
> data for a reinjected machine check.
> 
> This needs a host machine check while the cpu is in SIE so not trivial
> to trigger.
> 
> Fixes: 4d62fcc0b692 ("KVM: s390: Inject machine check into the guest")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



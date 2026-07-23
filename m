Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC82E384CFA;
	Thu, 23 Jul 2026 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825075; cv=none; b=mi7CshmtScU/m7C6tSF+5eAL6Bz5+7q8T1AIHg03wKgo4vbKjcjlHBVhP4Ddp4mHvVWJkQ6XzpWfxAV875sBi4dNMXD1DBPGH0wwlLFW8NEkhnwLlCv4U709q5gyshQfC54jd19Lx8H4uzetbR3xwu568NXD/5YRJT5Y5eDwoIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825075; c=relaxed/simple;
	bh=nX+R6l36LDXbmRdHPj5OwIfT5YV0g47X86E8EML7lMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8wvDnduy3PjreHiKLMgiDRQJBv9gf8gdIQ5nU1aj3FyeSAHpWQ+AuSHd+goxLmoVaZxExZeVygx9zTfJwc3TBERGCkIIfBg986/7NnF3CVi8wXW6359yEVqKr5gebf7uuMR44MZTOFy1GMZyALdR0izrUroeTsDU7EzVZNv45o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=coSxHZy4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="coSxHZy4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDC6vb3015783;
	Thu, 23 Jul 2026 16:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0OB45t
	EWXRhaGgn9AYv5Ku7R6bmPhkQsunxVYXOjPtE=; b=coSxHZy4JAF0zzE0aO+RGn
	alCg0VzQwWx+PB0fS7feSLiPK0YH92pMCdB67dvI8LlQnp2Q2zXoKSAFv683pOxQ
	/NIsdFzyvqfav+dUDJcxLPfYslSvs1CWUb+wK/qBiIUokM5oWs9knt4mGLb7hnVe
	BD1oBxUJ4m/h8/Kp1PitTE1bOJI/YgjthWiSBAtHbXROw1ToUIbiS/Hsj2ipeaC5
	o9oyy+fiaHKRx8iaVdMoWpHC5hCZ279t2YLgpcpJwyxQoKdyrHWMkR70aMLT/Yup
	QDlmnnSN7Ss1oA6kFwLqcKkFLkVUxrBRGwj4aC0dwqXRzS9X1JAqxknqf+ZYsPmQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kg253-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 16:44:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NGYh2t017352;
	Thu, 23 Jul 2026 16:44:31 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqd8dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 16:44:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NGiUeU49086768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 16:44:30 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E4B75805C;
	Thu, 23 Jul 2026 16:44:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A071C5805A;
	Thu, 23 Jul 2026 16:44:29 +0000 (GMT)
Received: from [9.61.254.118] (unknown [9.61.254.118])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 16:44:29 +0000 (GMT)
Message-ID: <9116b402-3230-466b-86f3-3446794d9c9a@linux.ibm.com>
Date: Thu, 23 Jul 2026 09:44:29 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] KVM: s390: pci: Validate AIBV and AISB before
 pinning guest pages
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-7-alifm@linux.ibm.com>
 <20260722172651.848261F000E9@smtp.kernel.org>
 <4219916e-4f28-44d2-80e1-b8422555d200@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <4219916e-4f28-44d2-80e1-b8422555d200@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a6244f0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=N-qMgub3_Ycct0JBVKcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE2NCBTYWx0ZWRfXyl/sa54qN6oS
 bKULdB6l7KxUWDj4FnFQ6astek5XU/UB5YgFuV7Y1DzJYGOBaReOsRRBZ7C/OHzc7fH0UeVCLjO
 WyVUdgnaaQbk59deaVgZoA3+sdT6piQCk7JxQ8hu8EUbcBuY4rllcLpcl2B6GqlcAbS59lEM0x3
 32eGftq+CRy6SZDxrsC8OvqHPUnd/OKtRg0zjG7lV5CEg7hsX8o4IYwf3zKEEzAUyHVEWJ+/2/A
 TugZcVErJ3Kd8uTw3AABCNkTxDEybGRVncyWgsisMsq7OAyDSd0ngJiywXYITsDL55iop4lADeS
 tIlTI6z5Jj2pupFTx4pMHjygM6TFC1Qdw5qjdTqs7Aqw6vDJe8oLjKT3dwrSuO5On6FSBSrqGM8
 gn/4fyQnl7FQhqjjjj+26iKCUxi6ibGZZ/CphVNCArVnyjBWUQ8i8iAlL6fcOTQRFEis0mCpSkT
 QHqg0da4kIuEtlwl97w==
X-Proofpoint-ORIG-GUID: m_8ZmgoUW6XrwS1zw5KgZkapJHZ7AOQy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE2NCBTYWx0ZWRfX7Nvvd0gk1jrC
 n47KMHlsgpSd+8RqNbk7tRPIO1t1ie94uY5ewchHEHwIAEncSEwtxRXjZLuNpIlnh61MGBvKFbC
 OXzj7gZvCuXF9aychu5PXarZ6N0N2Uc=
X-Proofpoint-GUID: m_8ZmgoUW6XrwS1zw5KgZkapJHZ7AOQy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230164


On 7/23/2026 4:57 AM, Christian Borntraeger wrote:
>
>
> Am 22.07.26 um 19:26 schrieb sashiko-bot@kernel.org:
>> oes this size calculation artificially inflate the required AIBV 
>> memory space
>> and falsely reject valid guest configurations?
>>
>> If a guest places a 1-MSI vector AIBV near the end of a physical 
>> page, such
>> as at page offset 4088, the size formula calculates at least 9 bytes (8
>> bytes from BITS_TO_LONGS(1) plus 1 arbitrary byte).
>
> Farhan, I think this is indeed a problem.
> Would
> -    size += (fib->fmt0.aibvo / 8) + 1; │
> +    size += (fib->fmt0.aibvo / 8);
>
> be the correct solution? BITS_TO_LONGS already rounds up I think. 

Yes, I was looking at it already and sashiko is right here, was waiting 
for some more feedback before sending a new revision. And yeah we should 
just remove the extra + 1. Will fix it in v5.


Thanks

Farhan

Thanks

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793190157;
	b=Paxoae7ICNPR4yXO1ZgGw+KEH1wCViesBtAmZ5tq+TF5o+mMQ6MIBLtioeaSOWoa/vUr
	 OcbdmWq2LXisA56mqBcy1YIimNqAxa0thK/i1IHkD4GOntwQfPPemYV3W0UKwv+96IuMq
	 q2kuKdws88yF6lHWCJ2hFDwZPBJxb2mIxeJOlPSJUYQTMhBskglguVXLFHvn5ZrXPfISb
	 9MEfBZy531Vk8au1marz4QoHvh8ZKhbFeFIxF1/i0HJDCUF/txzHjiDHGNCVGOjlw1/AZ
	 mzCpZu3VrGmwbCWOv2vFceAvJyI0mUMEhmOQ98W+0BdAU85u5b0WzxjcCCJNCswkmnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190157;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=2hp+ePVo0Df0QKNzjsR8x3ObN6A0CjwbnTyVCMTeVjE=;
	b=SdLEEYp/MJh4wCvsYj4GpCZDM/9ttUdUMBtpDd+LyX83a92Zxd030P32dRxiqv1hoFpH
	 4VuOXskndA+gts8VdIUIqZDQoEkWcPCvDDD4P/WouVektB1P1EiX+KFz9PrRF/DnWHRTh
	 Goa6cGc0kp8PTC9A7DaMAgV/xzin4WULZn5vFkjkvEKefesM9X3Nsy4g6cRKX2gKsKEWG
	 F2POxAXpIIa74gcewKMjUyfJof/cNPA/QMM+QklFgjrEqxyYXq2qPLTwJmHdr1WOHZdNH
	 ImUzfrkr3r3sCUxzK6hAlxxmCL0W5tTdtR3GH6N0tUdgWMDouq5+esKuEjryTHCtOJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Hhf5PdT0;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE480606A31F;
	Wed, 28 Oct 2026 12:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE480606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Hhf5PdT0
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBi6lR1133889;
	Wed, 28 Oct 2026 12:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2hp+eP
	Vo0Df0QKNzjsR8x3ObN6A0CjwbnTyVCMTeVjE=; b=Hhf5PdT0yVPsSuwfudgTxB
	Vf7qOCp6hG4ZeqzInT5ziUkjlGMNKmu/FLQGg6PsckpE0fQfNVgaDUIzAryGUxzg
	f0d8Gn5SG+ctd1ndqrbiCMSN6wx2AgodXZxFTGm9J6CujSODHZYhOUOCOZ/dYVku
	f4XZiQGn37KrIaaETlyDGE3B74RRK63JkHsPY2+G4Y96qcwtTtDFh7yU1CSiQY8T
	90Ewhpw8nuLsYw7GhtKPYhJs5lXsYOcXZb+wNz9Rq5IUSDd1n4wYwL5b29ysehbN
	yqbwzc21fwT3SFvGZvZxbPqdualydggzMsqBRqkcU9CoShjKetDnuMy19DT0Uzhg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd74m0p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 12:22:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SC4uNJ1522922;
	Wed, 28 Oct 2026 12:22:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hk55pa751-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 12:22:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SCMV6m39518490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 12:22:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29CE620043;
	Wed, 28 Oct 2026 12:22:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2B9720040;
	Wed, 28 Oct 2026 12:22:30 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.73.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 12:22:30 +0000 (GMT)
Message-ID: <48b38efa-86df-4654-91a9-88c3118ae372@linux.ibm.com>
Date: Wed, 28 Oct 2026 13:22:30 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] s390/runtime-const: Serialize text patching with
 text_mutex
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-5-hca@linux.ibm.com>
 <034dc4fa-520b-4ad5-9d9d-8ae469692698@linux.ibm.com>
 <20261028110926.8417C5c-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261028110926.8417C5c-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6ae1e90c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=9crZ_efNTruLh8Wr0lgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0OCBTYWx0ZWRfX6HWuSOhf+wrm
 CSHHXxgqhuP8TuHNejxO0dO974rANhDDfv8dilbUO+GJMY1NbSgqNs3dUl1umIowywe+VqAmX3o
 AY2QcR75/ZWycrUGg0w/2t62pihdx+eYiz8e0jNfx9CDQAONXIZwMUH1OLygPWPcXhfQNWCJfVd
 rdC6MlXT+iD22U1whoeLxbmL2fDiWzl6SmZdyvDkAFbJ4A1lWkium47i2l+bDJsH3azpVPJm7SY
 M/cOzHmzPbWpH9jwNfDBLG6FHm+NyguDkUOsKP4bpbysWy0bG9s3ESIQ0o2QVpURz6177/rYmtN
 nuv/7qU1P5Ab47wiLUWM67OWKAFfOFBPdbj+j1eveIo0zFl4njpfU3vpr5LDhmSA+B5sCpAqTxK
 1v94PWRVSZYk7RoXGfVg7lSwzOPjlK+gbDJIrllGFtwqQ6eNmvD57FGjwZ8l00zVfZC997K+fBu
 bJh2n6QB7QTnu8l1kyg==
X-Proofpoint-GUID: vZ_ziWSG3o4lWqdOdxUT-k1uaRBNHBpT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0OCBTYWx0ZWRfXxoInPDD1FT9a
 ruu75oXxtiRorgPyQYPCcq9q0kCenM5dmxqgqCsttiftHxetnwWUBTp2pG1qehYlzH61MOlADTG
 Jlf5XNU/fDbc7eqJzhWZBXX1y8i2Vf8=
X-Proofpoint-ORIG-GUID: vZ_ziWSG3o4lWqdOdxUT-k1uaRBNHBpT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280048



On 10/28/26 12:09, Heiko Carstens wrote:
> On Wed, Oct 28, 2026 at 11:58:27AM +0100, Ilya Leoshkevich wrote:
>>> @@ -88,6 +89,7 @@ static inline void __runtime_fixup_mask(void *where, unsigned long val)
>>>    static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
>>>    				       unsigned long val, s32 *start, s32 *end)
>>>    {
>>> +	guard(mutex)(&text_mutex);
>>>    	while (start < end) {
>>>    		fn(*start + (void *)start, val);
>>>    		start++;
>>
>> Interesting, so clang is able to propagate context even through indirect
>> calls without explicit annotations?
> 
> There is no clang context analysis involved here - this is purely lockdep
> based (with the last patch of this series, which adds lockdep_assert_held()
> to s390_kernel_write()).

Ah, I see, it's stated right in the first line of the cover letter.
Did you consider using it though?

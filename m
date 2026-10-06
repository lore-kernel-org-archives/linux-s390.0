Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE51A9FBA;
	Tue,  6 Oct 2026 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301990; cv=none; b=dPIUwpWLjofNBp7EpOpUHafvseSHunBeb744by0n0mlG4bzIbveFvdILWAsQkMLR0+ujvfAcory4tcEFhMdNpbLZwjBAoGB3YBEweNaM0r1JBcdu/DVjiS42jHjltI4eTUJCKtNAgEyui92/AAUVi7NWiYXMxwmIx/OwVjkg8vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301990; c=relaxed/simple;
	bh=pn7qm1GFXxv2t2YD3JT4PZvyalBN6e40CLMDJ4Wc+Gs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XkDzckUR/FRgaNaoC+iew2rCtOp9mOGEYgZoIZAzr3RSJzC+qjmutSs7FDp0j3M5W7zhEQfZU2DGzSC0ST9GrRf2QV9Ljz8JUc8WLzSx1VIfBUrFNCM2mNY5h2xCdMhPE40PhKJda37lFfZO3uqIosnTjANgvi425ujrsKhvWiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F29jcIrY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F29jcIrY"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696Ea15M3975733;
	Tue, 6 Oct 2026 15:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=G7gu9vB4kO30xa/EfJ9r1Q5RoNzhECU2+Jv5VFgapCw=; b=F29jcIrY/uZo
	tOc8/ukNo5B0to2QfFx4VdbnzEwqniRfmRbwkz4Kh5fQB++Y84CyE/zNfEMmrBjj
	p2WdnjmJHL84F80zjzyuuhsByD4SF1yWa8YKr7vircOL9HAAjPoUqVaFvdr8LdJs
	SPvnAZlVMbSUUj+NJCvZn2kPG8F9/IEbdI+MQtXuTNuNkPMYAKoCDyaZZYOkmmrN
	XeyZwWh5YTiLz5ibKGzwczy39eK6E7YPwoVn7OGsC7rrozGkR0W7JK/HbjoD+9iE
	UQOB19YwIMtL7qm974Rvv4QkziT1B12IcsSqW4jz8FHBLpsRje90HEiWjfHwsHjW
	oFlsVtz6pg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5gvew-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 15:53:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696EHV6N387143;
	Tue, 6 Oct 2026 15:53:06 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jtjnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 15:53:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696Fr5Gu28508756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 15:53:05 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56FFD5805D;
	Tue,  6 Oct 2026 15:53:05 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B4D45805C;
	Tue,  6 Oct 2026 15:53:04 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 15:53:04 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Oct 2026 17:53:04 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko
 Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Holger Dengler
 <dengler@linux.ibm.com>,
        Finn Callies <fcallies@linux.ibm.com>
Subject: Re: [PATCH v2] s390/ap: Support new APMLM field with PQAP/TAPQ
 instruction
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20261006150932.5AD671F0089B@smtp.kernel.org>
References: <20261006145823.8421-1-freude@linux.ibm.com>
 <20261006150932.5AD671F0089B@smtp.kernel.org>
Message-ID: <a2ef55c1888274840a45b3b5792251ce@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA2MiBTYWx0ZWRfX7bAeeppo+7TU
 pEEYPy5HItB36esFDaO8C2GE5N5NzU1ydOh3EDfFOvh2R1Cwh/b+KX+zU3i/of7BtreVVqq97fZ
 o9FxH7m42CFcdrmLJ2LKb/NwyGbZoxY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA2MiBTYWx0ZWRfX5Aim9ulRhW9V
 P19qL53pODQget35Hai3hZNRw16IeeXb89DDjUyEjiQWjGVQ4at9vY55m82ceCjwKFHv3HHm4Vh
 IC8C1p1bGKRqoiSoRwDp86IvAxrSsa/oqDENaHaA1SfQ6XUEWImZFlSGdoOmwwZC3n+jVj/KVfa
 gKp4s9gii5RT8045vffOGYWZC8mBpVN+3CDI8ASU5e46+/YbD1PzPpG8IDkEQhzK7Rmiljj2Vc7
 zKdPqFjLHBaS0GUMsfLPBdhDojFFnz6N4VVdK/gvFOj6gldHkacv5FFXiTdqSu2/+bqQQLA4lnS
 pUC26g40jQlS5l5mZPBrAP7FOElQB+FrfSsx9XI84U6O9DuosR95kc71pf/2n9zbJaz5QP1EqI5
 fO2xTzDIPIvUJZaQG54ThGu7PbdHTVsUovY1ZFEnKn0aaMsPuYWXkhndA4AORahrb0HYoVicy8i
 yQdpZOroORavq7TLMXA==
X-Proofpoint-GUID: GmsaVqS6m3jzJ1N3QXVo8M0uQhx5S-hy
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac51964 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1JiTDhl_BFzrfeVkU7kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: GmsaVqS6m3jzJ1N3QXVo8M0uQhx5S-hy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060062

On 2026-10-06 17:09, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [High] s390/ap: order-8 kmalloc allocation causes DoS for crypto 
> requests
> --
> 
> commit c12ee44fe3064032047e06539777b0c95c7b1201
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/ap: Support new APMLM field with PQAP/TAPQ instruction
> 
> This commit adds support for the new AP message limit multiplier field 
> in the
> GR2 register for the PQAP instruction. It updates the HWINFO mask and
> modifies the formula used to calculate the AP maximum message limit.
> 
>> diff --git a/drivers/s390/crypto/ap_card.c 
>> b/drivers/s390/crypto/ap_card.c
>> --- a/drivers/s390/crypto/ap_card.c
>> +++ b/drivers/s390/crypto/ap_card.c
>> @@ -242,7 +242,8 @@ struct ap_card *ap_card_create(int id, struct 
>> ap_tapq_hwinfo hwinfo,
>>  	ac->hwinfo = hwinfo;
>>  	ac->id = id;
>>  	ac->maxmsgsize = hwinfo.ml > 3 ?
>> -		hwinfo.ml * AP_TAPQ_ML_FIELD_CHUNK_SIZE : AP_DEFAULT_MAX_MSG_SIZE;
>> +		hwinfo.ml * (hwinfo.mlm + 1) * AP_TAPQ_ML_FIELD_CHUNK_SIZE :
>> +		AP_DEFAULT_MAX_MSG_SIZE;
> 
> [Severity: High]
> Will this scaling of the maximum message size cause order-8 physically
> contiguous memory allocation failures?
> 
> By introducing the hwinfo.mlm multiplier, the maximum message size can 
> now
> scale up to around 960KB. This value is used to set the global maximum 
> message
> size.
> 
> However, looking at how messages are allocated in
> drivers/s390/crypto/ap_bus.c in ap_init_apmsg():
> 
> void ap_init_apmsg(...)
> {
>         ...
>         maxmsgsize = atomic_read(&ap_max_msg_size);
>         ap_msg->msg = kmalloc(maxmsgsize, GFP_KERNEL);
>         ...
> }
> 
> And similarly in drivers/s390/crypto/zcrypt_queue.c in 
> zcrypt_queue_alloc():
> 
>         zq->reply.msg = kmalloc(reply_buf_size, GFP_KERNEL);
> 
> Since these functions unconditionally use kmalloc() for the maximum 
> size,
> user-space crypto requests will trigger massive order-8 allocations. On 
> a
> system with fragmented memory, these physically contiguous allocations 
> are
> highly likely to fail. This could lead to a reliable denial of service 
> for
> hardware cryptographic services since the underlying AP instruction 
> operates
> on absolute memory addresses requiring physically contiguous memory.
> 
> Is there a plan to adjust the allocation strategy alongside this limit
> increase, or otherwise cap the unconditional allocation sizes?

Hm this leads to the question if there should be an upper limit for this
AP max message size. However this is then a protection against malicious
firmware as the both fields ml and mlm are provided via TAPQ from 
firmware.

@Holger, @Finn any suggestions ?

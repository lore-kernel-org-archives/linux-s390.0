Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577103;
	b=SS+FzRa9l1Tr21gjJWVlgCy84aDp+7ABnEtJEB8nKqSfZjA3Vjp5iSEB6RGRWJV09XxQ
	 jthktCPHRTfIhQo8O4X6NuRBkjorgFeOaLQhSl84ARNlyRWUtPfNWE4gUZCp2Wyq/aQQQ
	 1vaNAnhyN5OvGVlRKT5QxHfK0QaSoOuFmApQVnyRwgHxBRpykH2b45S4CSBPAug5AXqlK
	 M+U/DujSU/ShOwtLFCv8GHnwxuhgT2Rxo17u1RiFBtMmoRoXJekt1I4xnqV5A2JE7fOdx
	 y5ksnOLL1YAqXU8QTepGOMLxNA9iu83nqwAbRlOJfb/rZEF+XJ5IyVHKFcYyPvqLv8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577103;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:MIME-Version:Date:From:To:Cc:
	 Subject:Reply-To:Mail-Reply-To:In-Reply-To:References:Message-ID:
	 X-Sender:Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=UBTJL2rXpZZv2L1/0DtwAmPyMSPodRD0kNezd73BtPg=;
	b=w7vOpylAhSsqt18eB3twF4RrTKx6nldGUNLCkQeOg0RfDzzXknXQ/X9S15Cvz3fIIlqM
	 Ir1n+w0ufrcPboLYoRqpV33FizzuPisA5MXxm/8gs8bVlSHivYfnwWVs8V5KMPm/x3Goc
	 Ruos0cIXKAZQolzcYPW8bdQ3mVFloa6YS6eFWfm8fN4d7R1rSpRx5nw+71M9Sf5U1XFuZ
	 dJ+IX/gRXjMIh7wLSpGOpVq3rJigCX39UeOaj15lLfDzdoh9Rm/BW9hyqAL39VR5ez1ej
	 +SFRLhIYIk5uJ4kTlLumQ6AP8xm5ppGpcFl1f0+xB5ZsAS67a2qKz1cdasT/2uqzqZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WCnVFUwk;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7779606A32E;
	Fri, 13 Nov 2026 13:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7779606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WCnVFUwk
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCE6OL3085812;
	Fri, 13 Nov 2026 13:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=UBTJL2rXpZZv2L1/0DtwAmPyMSPodRD0kNezd73BtPg=; b=WCnVFUwkrtGV
	ezvqPennp+4v8+DWD22c99j3+KCO+fldrqIAME7qFp6W8zgRFu3YtyjglE38rNdI
	2RTYvbjtT1D1pVwnR4pvUjNQFGXgspNDCxF/6FUjGyfpxqUYo0M/pNf3Oe3aS8f2
	K+zlEIIoUXsNoqTd737pM/ahD5Jkzd3udHB2Wu3KgrId9ae2DL6PQ4UV+lfXrqM3
	C+DoQqSSKwRB39o+K3ND8bU57vM9J/8LHq8zCqanGGAXacKpOszO4WPP2vDCX9/S
	pCuLVf/bT/VsAZnR4EKtcK/En4LNu2Aza8mhs3WkYsNCIa+GVldhVOLqFOhMwAo6
	I8Za6KwI9A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6kv16-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 13:38:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC5EoG2294245;
	Fri, 13 Nov 2026 13:38:16 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hwjcf32kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 13:38:16 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADDcECs39190860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 13:38:14 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C125858062;
	Fri, 13 Nov 2026 13:38:14 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 670D95805C;
	Fri, 13 Nov 2026 13:38:13 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 13:38:13 +0000 (GMT)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 13 Nov 2026 14:38:12 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Sasha Levin <sashal@kernel.org>, Nicolas Schier <nsc@kernel.org>,
        Nathan
 Chancellor <nathan@kernel.org>,
        Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kbuild@vger.kernel.org, linux-s390@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, "kernelci.org bot"
 <bot@kernelci.org>
Subject: Re: [PATCH 1/2] s390/pkey: Include <linux/device-id/ap.h> for struct
 ap_device_id
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <avHpQIREsJRjpD3R@monoceros>
References: <cover.1792144769.git.u.kleine-koenig@baylibre.com>
 <179416565740.60865.16102443399828949110.b4-review@b4>
 <66e4ee9c7f9b4bc48fcee92a94b6bb6d92fe1ad2.1794233316.git.sashal@kernel.org>
 <avHpQIREsJRjpD3R@monoceros>
Message-ID: <38297cf4ed5755a0e54d781485d4bddd@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J6V4yMHi54aoGGu0oMv9hoS19I8q3_9b
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af712c9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=U0zfkUukAAAA:8
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=5DHl898QimpB5tG_JWoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rXRU1dkEVDZ1dOovDhQH:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: J6V4yMHi54aoGGu0oMv9hoS19I8q3_9b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1MiBTYWx0ZWRfX6ihovpr0qtKr
 jKvupKPGfxHnmlu5CSvoN7QxhjVhOBmZiPI9XlDjZqBvqW6CDKD6PW/XLj9/fTLy58qHHyvgrp+
 obDHDNmnZVBj4nhWNq+xbRdumfUBSkfQRq4nf+ltXPJHudB1r35pm2nmVI4uiUEqOLLsN0LE5kZ
 PsF7D+1WmOcAkfFWEnPNPQ0TNnt68kZX6C/6ggh4XGAnclaE0GCbgT/28qQUCb5LZKQIXzMz4h1
 3gOGvUITKDZPZL6OvZpYVuYuO8ii+L8ZR6NtyvqbxDsSnfMQacLgmKU4WIxWDHQSLyp+vrbbCwi
 WyzKoGmquAhOhtMc0Uceejgzwk+Op4gS3z31wjLLcT3q+ZfQmJrMij/aSi6OaOWZqx9jJjkcwed
 7mZu0Sd2D2XmcWrFip8g0XW13nUBUQWCPyf6dLTCuJ3aRojEtIOedpUOroBs/lLHtVvdQS4hi5Y
 qYtG12+0EAxkyqWwpUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1MiBTYWx0ZWRfX0fb3UnPJ6J1Z
 fE5paFLKMx7SqwR2mkQNXTWifhZkTImd5L2tejUmosMz6PeQxFHwDxW8R+A7NlLq+mKewFbSpfA
 eP40e2o0oyIrTuDxPLQ+1GbAbyVl0xQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130052

On 2026-11-09 16:48, Uwe Kleine-König wrote:
> On Mon, Nov 09, 2026 at 09:14:40AM -0500, Sasha Levin wrote:
>> pkey_cca.c and pkey_ep11.c got struct ap_device_id from
>> <linux/mod_devicetable.h> by way of <linux/cpufeature.h>. Commit
>> cdfdbc11552b ("Move struct cpu_feature to <linux/cpufeature.h>") 
>> dropped
>> that include, so s390 defconfig no longer builds:
>> 
>>   drivers/s390/crypto/pkey_cca.c:22:28: error: array type has 
>> incomplete element type 'struct ap_device_id'
>>   drivers/s390/crypto/pkey_ep11.c:23:28: error: array type has 
>> incomplete element type 'struct ap_device_id'
>> 
>> Include the header that defines it, as the other AP drivers do.
>> 
>> Reported-by: kernelci.org bot <bot@kernelci.org>
>> Closes: 
>> https://d.kernelci.org/i/maestro:7baaa311bc9c30a8ad43f42c24225ab2fead866a
>> Fixes: cdfdbc11552b ("Move struct cpu_feature to 
>> <linux/cpufeature.h>")
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/s390/crypto/pkey_cca.c  | 1 +
>>  drivers/s390/crypto/pkey_ep11.c | 1 +
>>  2 files changed, 2 insertions(+)
>> 
>> diff --git a/drivers/s390/crypto/pkey_cca.c 
>> b/drivers/s390/crypto/pkey_cca.c
>> index e8dc2f77c137b..f95d61fd5b090 100644
>> --- a/drivers/s390/crypto/pkey_cca.c
>> +++ b/drivers/s390/crypto/pkey_cca.c
>> @@ -10,6 +10,7 @@
>>  #include <linux/init.h>
>>  #include <linux/module.h>
>>  #include <linux/cpufeature.h>
>> +#include <linux/device-id/ap.h>
>> 
>>  #include "zcrypt_ccamisc.h"
>>  #include "pkey_base.h"
> 
> that makes me wonder why there is an ap MODULE_DEVICE_TABLE in
> drivers/s390/crypto/pkey_cca.c while that file doesn't seem to contain 
> a
> driver for these device IDs.
> 

This makes the pkey_cca kernel module automatically loaded when an AP 
device
(CEX4...CEX8) is detected by the kernel. Similar the pkey_ep11 kernel 
module
has a MODULE_DEVICE_TABLE entry.

>> diff --git a/drivers/s390/crypto/pkey_ep11.c 
>> b/drivers/s390/crypto/pkey_ep11.c
>> index f99c19323f3d7..f66fc97ad5adc 100644
>> --- a/drivers/s390/crypto/pkey_ep11.c
>> +++ b/drivers/s390/crypto/pkey_ep11.c
>> @@ -10,6 +10,7 @@
>>  #include <linux/init.h>
>>  #include <linux/module.h>
>>  #include <linux/cpufeature.h>
>> +#include <linux/device-id/ap.h>
>> 
>>  #include "zcrypt_ccamisc.h"
>>  #include "zcrypt_ep11misc.h"
> 
> Same here.
> 
> But anyhow, as a regression fix the change looks fine.
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> 
> Thanks
> Uwe

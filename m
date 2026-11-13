Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576662;
	b=koKl8NxoVm/+Gh9KkLm9qEqLE/ed9oJbL+J+IC5SzeJ5LlcFys6HfqNcs2efxFLyT4UK
	 PZW2mKtJwh2KzuLhVgPMZI8NOKuDdNc35teCaHFJ91VfVder1zz1YnRjF0fKLvRuFE+4S
	 q7H0nFNPKUCUpYGfP9EJVtLVRErPGXkMCvG/VixTf/08mx5yrDk26fQ9o0k23Ws+A6/AE
	 5Pfnqy4Shwa+CKe+0Khr7YFZWXK4MjUV+aKJg947Ecf9DtLPDaJ62oTMNSWngeT7Mlq1q
	 E1sBubt6gkJdBZsWlDaDnpXxm078rdTPUdGwfQvOKa/bPsP7/4YuL8y75e/YC1O+ozg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576662;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:MIME-Version:Date:From:To:Cc:
	 Subject:Reply-To:Mail-Reply-To:In-Reply-To:References:Message-ID:
	 X-Sender:Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sjfGDhqsQQgcjYHH2kwsSi64IsRr+LqbxLOZSsUHavg=;
	b=jXQ1az+zeqUau4Z/xaUdwgetrX5/u1GGXKxIINEzhdo2V6JxsIcldOVVk3auxxp22n8h
	 JfmtLFqkW0X5uE4HhDGDoHufYtj/4ndcmfoiuR2+/0j56+6Q/XHPiXnMxWSBb4nG20Kis
	 eJhshWOhSZugTqosdWfqKqCulnv47RI6P4OZFlh4HEAHKXBW7cSeotWFue21T4W6oWm2K
	 Oj5fBxb5ytFkKlj8C2zCvJVFsE4tVrOaBtC5qIjXe9KW1w9Z36rAsKjB632vTTX++EWuy
	 XcYsp3OqOXOjAJ1YySUQ6IOOe3TxzQzA4LBhebd3svzgUepT0IKcFRKSrZtmm8u+KtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FBcqAvpP;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EBB606A33B;
	Fri, 13 Nov 2026 13:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4EBB606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FBcqAvpP
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCEPf31667815;
	Fri, 13 Nov 2026 13:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=sjfGDhqsQQgcjYHH2kwsSi64IsRr+LqbxLOZSsUHavg=; b=FBcqAvpPcebE
	gm1Mg6Xfg2yNvftA6HvGkzDVDAupWZAPP1PsurYNXIv70pT/WVVpohDPlHhD0zfU
	wFfIWLO38k/oL6A2cfsKF4Ego51TmoVmz1kD1bABqdNY6FqV1FNwz8Mr8Ai9RwQ6
	/7BbLHM2jAi1uqwN+mR68d5r7Wnj6xctBdIZ7jvPLUDrIb8uo1RoT6dvg5PnVxXV
	65/Rj/mAnUnas5LJ2jeBQDpUMPDhK0MTdyMImmriNOsAYqWdDnByayFe9SU26DEC
	lM+Cp7kx+00Oj3x7tXZMa75GKmCN4qixQqetjUyvCPpA9y27d3uV3yI4GxDpB8ON
	H1PYMbgirw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdgjmrf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 13:30:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC5FMv2213383;
	Fri, 13 Nov 2026 13:30:54 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwegfbyw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 13:30:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADDUrOL63832502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 13:30:53 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8985358067;
	Fri, 13 Nov 2026 13:30:53 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E33C58043;
	Fri, 13 Nov 2026 13:30:52 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 13:30:52 +0000 (GMT)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 13 Nov 2026 14:30:51 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Holger
 Dengler <dengler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
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
In-Reply-To: <66e4ee9c7f9b4bc48fcee92a94b6bb6d92fe1ad2.1794233316.git.sashal@kernel.org>
References: <cover.1792144769.git.u.kleine-koenig@baylibre.com>
 <179416565740.60865.16102443399828949110.b4-review@b4>
 <66e4ee9c7f9b4bc48fcee92a94b6bb6d92fe1ad2.1794233316.git.sashal@kernel.org>
Message-ID: <c9762ccd45e25032384bf9d83fa39765@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af7110f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=U0zfkUukAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=fHy9Ve0kNF58s2Fdc2gA:9 a=CjuIK1q_8ugA:10
 a=rXRU1dkEVDZ1dOovDhQH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1MiBTYWx0ZWRfX2yEBsMs3Fufc
 X6ekDLWcm+zuX3nZH7lq9SbE6VKES2cB7zbRBXOKX4qnt6Kr1Zcop1JqjrMcj2u/6XuK3hoP3N+
 5IWH9kZ88j7hBXmmH6YpnLKDL5Re/ojiGWzAhhDA4+ctqHxhM7HY/MA1yGyfGLF/4U8I8a7Za6M
 0CFLE0RmDijyvQXuRxEoTA4iLGFoORWy191AcdKfRSGSImEUJOZg5oynXrcfZbqsDMOptdIP3Hb
 mRMowyejOqOlm+ZKDs7qBboJ/3E+r6JPeT1iX5eJjkcu7qOlI9bL1VTvp/8eoVPfOnsr1FieL1m
 /oCE+46hk0b5PStRwFXBqw3h3d35RJ/6GYv6YVo9G2LHYyVa+uFyW8Pi/IBUb5vUZvc+Mwg053W
 MN2bLO8iDs5vaazt6/JkPBU013CetqcIpHxuguyT/+9GPQo2ev+6O8h4aTMkvmKIPIqhBnpZYY+
 iXYmFpDK0Fipl/BioNQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1MiBTYWx0ZWRfX7nb3+ufzodPl
 KsRl5+G2CveEw3hjF3u4u2jzp3ByxtkPDzd5C8XzMvXVEd2kKQsZ8IVfsUJXOQK2RQ1gqZvmUl4
 BNKtz+8onhMo7Q/+OltEy138iMLQ2AQ=
X-Proofpoint-GUID: GMFUUyxkH7_jTqBOBqxJPpjx62uyavg8
X-Proofpoint-ORIG-GUID: GMFUUyxkH7_jTqBOBqxJPpjx62uyavg8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130052

On 2026-11-09 15:14, Sasha Levin wrote:
> pkey_cca.c and pkey_ep11.c got struct ap_device_id from
> <linux/mod_devicetable.h> by way of <linux/cpufeature.h>. Commit
> cdfdbc11552b ("Move struct cpu_feature to <linux/cpufeature.h>") 
> dropped
> that include, so s390 defconfig no longer builds:
> 
>   drivers/s390/crypto/pkey_cca.c:22:28: error: array type has
> incomplete element type 'struct ap_device_id'
>   drivers/s390/crypto/pkey_ep11.c:23:28: error: array type has
> incomplete element type 'struct ap_device_id'
> 
> Include the header that defines it, as the other AP drivers do.
> 
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Closes:
> https://d.kernelci.org/i/maestro:7baaa311bc9c30a8ad43f42c24225ab2fead866a
> Fixes: cdfdbc11552b ("Move struct cpu_feature to <linux/cpufeature.h>")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/s390/crypto/pkey_cca.c  | 1 +
>  drivers/s390/crypto/pkey_ep11.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/s390/crypto/pkey_cca.c 
> b/drivers/s390/crypto/pkey_cca.c
> index e8dc2f77c137b..f95d61fd5b090 100644
> --- a/drivers/s390/crypto/pkey_cca.c
> +++ b/drivers/s390/crypto/pkey_cca.c
> @@ -10,6 +10,7 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/cpufeature.h>
> +#include <linux/device-id/ap.h>
> 
>  #include "zcrypt_ccamisc.h"
>  #include "pkey_base.h"
> diff --git a/drivers/s390/crypto/pkey_ep11.c 
> b/drivers/s390/crypto/pkey_ep11.c
> index f99c19323f3d7..f66fc97ad5adc 100644
> --- a/drivers/s390/crypto/pkey_ep11.c
> +++ b/drivers/s390/crypto/pkey_ep11.c
> @@ -10,6 +10,7 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/cpufeature.h>
> +#include <linux/device-id/ap.h>
> 
>  #include "zcrypt_ccamisc.h"
>  #include "zcrypt_ep11misc.h"

Acked-by: Harald Freudenberger <freude@linux.ibm.com>

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83624396D09;
	Tue,  3 Feb 2026 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111597; cv=none; b=LsKEXB/zV3THbTmLm5GDCtALBIQ5i1VK/qDCKISIOeg7Q3PhxHVybfD671oCNcv3dsm4E8thHCb5g0I0RP2Yt1Wf5xxrNJcMabcms2z3ILrTWnCGh9XT8wsRZsl4QyKw11knTSqXp8eQ/uzg8LrgxXyuMssMPFo9pmdCWE24BAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111597; c=relaxed/simple;
	bh=/JhnW/rE+OLFUXqa6wh6BlfbjjD/LptFptdYONvCbUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2dGGxFICMEV/qXzUdpFJ55lM6YnNG5PcNeizbL5pEsb0IlbONfBuhGqZYNWx6ghO4FfDdoyECmzYoG1R6PLZH/PcDQvl8pUuzX8ncsO8UY0FX2sN1s48Cc+opBw0t2RfaqDlQcfZgaVKZTof/Cr7hzv+E5PPVfh33hI82ZW9HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IhArgGVo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IhArgGVo"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 612HKmGO027311;
	Tue, 3 Feb 2026 09:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=n9r7O2
	2TYZm1sAF8uBkVzCXHOLO6XYTahkcMrSNOXJo=; b=IhArgGVorWqlzzJJO3ZLyr
	I7rEF0ag6RKiQHPtafUHjmHkRGZbaCKup5I8QetR38+w6hhgPhfF/PIz1yrujdUx
	JRSWtjvzqEcslzK/HyrdvN0fLUOaM2Tam0zJfpddRmYxoRxEe+yM0BQunzBeZCHz
	OW/qabJix5IV35fsoehVht/Itu2YsGLxun5GUvfQ1HRbetbudqTaugnkkA9LacQh
	jJQlkhJijZ05MHp7CGAFXhLokZepRbdpDy7vk+ALoG0+CeqqEwRkPU6NsNmhmejU
	BjXtlrU5L4wSaWodDp/R/jJqTnpoKi5Mk1YSr4jOVp7TnNQpLvS6EpQ1cI6zDxSA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c1986cmh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 09:39:47 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 6139dkfv015686;
	Tue, 3 Feb 2026 09:39:46 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c1986cmgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 09:39:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61351IrQ009163;
	Tue, 3 Feb 2026 09:39:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1vey0mvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 09:39:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6139dhmq51642720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Feb 2026 09:39:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E07C20043;
	Tue,  3 Feb 2026 09:39:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17DA020040;
	Tue,  3 Feb 2026 09:39:43 +0000 (GMT)
Received: from [9.52.217.119] (unknown [9.52.217.119])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Feb 2026 09:39:43 +0000 (GMT)
Message-ID: <04ce261c-2cef-4575-8e2d-e13391c2a933@linux.ibm.com>
Date: Tue, 3 Feb 2026 10:39:42 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next] net/iucv: clean up iucv kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Cc: Thorsten Winkler <twinkler@linux.ibm.com>, linux-s390@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20260203075248.1177869-1-rdunlap@infradead.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260203075248.1177869-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA3NCBTYWx0ZWRfX99VNKT/uT56Z
 rUXvvzFQSGbwcnh3WLPNbWGzdJPTS2+Go9XKIgPCLoaqgiAIJean+yP0//TpkVbTc9pAvmbuwRS
 uNtlXQNa5Jv6wq5kHSG2FUNIb9lTmiliu2lPG8t0XJJmZeSgSvz96fO41mvoSt/EZsc4fgh1weg
 EMkfH4Bz9ao+mS8/ndYoiA01//ovDil+NaZpmGkxDNcoua95Ig6hJ7noUMqDymzoDEoEDo/a63S
 l3gZuSNGWP4HTjgSK9pwqmTCnxEaWoP7DRS1lPJ/x0qd6Mr1XXHzxoK925SEKuZTV038jqNVqao
 XzTYPL4nXQrAzEuuscXSCMmVPvmpIpfoDT/otJ1LO7kvp0n92ev7FMhdQ3vQalTvhQWMcxUg/eO
 0GajEgMSAOmBF3yJjFOIsEHBjFQLpNDKvoqVOXuvsQx4GfKpkFAu7c/E1qTm2MOWIscB/OyPLaH
 KSzUv6oxhToK6jFevfg==
X-Proofpoint-GUID: g9HsSR5fg-sLAR4CoswMZA4PyizlapNu
X-Authority-Analysis: v=2.4 cv=DbAaa/tW c=1 sm=1 tr=0 ts=6981c263 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JfrnYn6hAAAA:8 a=VnNF1IyMAAAA:8 a=LD9QvOGdLr9FH1oyKzoA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: 0pron7jihDVSIlL03eRLJ2fcxXswPleP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_03,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602030074



On 03.02.26 08:52, Randy Dunlap wrote:
> Fix numerous (many) kernel-doc warnings in iucv.[ch]:
> 
> - convert function documentation comments to a common (kernel-doc) look,
>   even for static functions (without "/**")
> - use matching parameter and parameter description names
> - use better wording in function descriptions (Jakub & AI)
> - remove duplicate kernel-doc comments from the header file (Jakub)
> 
> Examples:
> 
> Warning: include/net/iucv/iucv.h:210 missing initial short description
>  on line: * iucv_unregister
> Warning: include/net/iucv/iucv.h:216 function parameter 'handle' not
>  described in 'iucv_unregister'
> Warning: include/net/iucv/iucv.h:467 function parameter 'answer' not
>  described in 'iucv_message_send2way'
> Warning: net/iucv/iucv.c:727 missing initial short description on line:
>  * iucv_cleanup_queue
> 
> Build-tested with both "make htmldocs" and "make ARCH=s390 defconfig all".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v3:
> - I didn't use Alexandra'a (v2) Reviewed-by: due to the number of changes.
> - leave kernel-doc ("/**") on static functions in iucv.c (I did not
>   convert other static functions to kernel-doc comments.)

Thank you. Feel free to add
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>


There are still warnings left about missing return value descriptions:
> make W=2 clean net/iucv/ 2>&1 | grep ^Warning
Warning: net/iucv/iucv.c:691 No description found for return value of 'iucv_sever_pathid'
Warning: net/iucv/iucv.c:1099 No description found for return value of 'iucv_message_receive_iprmdata'
Warning: net/iucv/iucv.c:1856 No description found for return value of 'iucv_init'
Warning: net/iucv/iucv.c:691 No description found for return value of 'iucv_sever_pathid'
Warning: net/iucv/iucv.c:1099 No description found for return value of 'iucv_message_receive_iprmdata'
Warning: net/iucv/iucv.c:1856 No description found for return value of 'iucv_init'
Warning: net/iucv/af_iucv.c:131 No description found for return value of 'iucv_msg_length'
Warning: net/iucv/af_iucv.c:150 No description found for return value of 'iucv_sock_in_state'
Warning: net/iucv/af_iucv.c:163 No description found for return value of 'iucv_below_msglim'
Warning: net/iucv/af_iucv.c:889 No description found for return value of 'iucv_send_iprm'
Warning: net/iucv/af_iucv.c:131 No description found for return value of 'iucv_msg_length'
Warning: net/iucv/af_iucv.c:150 No description found for return value of 'iucv_sock_in_state'
Warning: net/iucv/af_iucv.c:163 No description found for return value of 'iucv_below_msglim'
Warning: net/iucv/af_iucv.c:889 No description found for return value of 'iucv_send_iprm'

Our team will fix those, unless you want to add them to this patch.

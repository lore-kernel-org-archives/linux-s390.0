Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201674;
	b=mMP6uCL6vVdnAeZDoZiB3ItopIwE29PbVMDeV9pw1iMgd+0gOEenxPUIzbPZ24wKxpjb
	 lPE+/dZgxNv+UOjm1EKytP+ATHJNdBf1XxbsLR94mXv5PKxpeyVjkSWLUzeTO2bSCvacn
	 FkGxPKviKHm/bixBtW9v/86QUQ7ui0x0EiPKmDYDOBmwBCNvFoUAzYMlPnf5zHIL3JUIs
	 FEU6iQa1+zfFYE8Uz6I8JfiH3xFMYInnK+umTjuEGy4sg3RIuvbtWq47i9gVEQbY8q0iw
	 7ZlgIn9/j3g9MvAfLoC+WiuuCLCX5p0ZICnuiJG6aU6gbCzGEkUDGYo7mqc15IZmrGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201674;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=fJh4nHfo8vDIas+JM/zBTxdDZjFMAqozk5NvMGQRHBA=;
	b=ATN/0EK8UlKtLHCHZq4NymZskGbz6mD26IIVh3NNR+qwA6rvB7gEEkoFQ79k5v06wnM8
	 jR580eN1vkYywQt78Gh644Ft/Srr3m37u4UMzT0NTBlw3I/gh/IZ63wdkbjOmPSFmxwCw
	 lAoyECGxgqyAQU0NenJyvA9NCe3Kf0IHpSu5X6+LSmiGFF8apPhqMkeU1wQ3OWlseT1ZB
	 znkifh5MfjLuhfyBopquFpCWeBlcoE9QBu3o4nh41P9Cdv4PW92lqX3CRjg6ZKhp4sUN7
	 Y742EgGWnAmxMBFjdpTLLY4nQMVH5DlVb/qWWK+7zcYy6Vc6FD4BeYuNhoKta8Wzx2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DvyKXzkj;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2A8606A31D;
	Wed, 28 Oct 2026 15:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F2A8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DvyKXzkj
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFE41L4147837;
	Wed, 28 Oct 2026 15:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=fJh4nHfo8vDIas+JM/zBTxdDZjFMAq
	ozk5NvMGQRHBA=; b=DvyKXzkjqrdeQJ985EbnmXGQ6PjX4hmQ42WfThqNE/Oumg
	0jPFfQzkio4NRlzMgHtk0SGpAJuQaw5DxokIeQhkwZ8R3hxpPx3ZaEkR7UhmlBz/
	WLgFDq/cNVYsk1YoHsqr14yvkPjnKUV7M1pOt013O27zui2CgI2qu9Uj6jgMqGwv
	aqifV+HTBBpz3aCyhaVoWSerhIOWYDj95zKCRu9Nbp3izTa2yMbNU5K7bFCUL1Fb
	l73OtA56WKkDxuDrWuz00rNW+zhqQLwAb2ozmBF6sUgJMJ3xWiVr9KwnFFuuiGPj
	x/WLMXzUkaEGnKPT+J42jH4J3ifXIdYuFgb2NZNw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbt5j38-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 15:34:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFK5pY1784791;
	Wed, 28 Oct 2026 15:34:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8gh7wfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 15:34:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SFYLhs39649706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 15:34:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9418B20043;
	Wed, 28 Oct 2026 15:34:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 616A520040;
	Wed, 28 Oct 2026 15:34:21 +0000 (GMT)
Received: from osiris (unknown [9.68.31.201])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 28 Oct 2026 15:34:21 +0000 (GMT)
Date: Wed, 28 Oct 2026 16:34:19 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Kees Cook <kees@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Anastasia Eskova <anastasia.eskova@ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/cert_store: Hold the keyring->sem while
 invalidating keys
Message-ID: <20261028153419.8417E3b-hca@linux.ibm.com>
References: <20261024144229.1546151-1-jarkko@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261024144229.1546151-1-jarkko@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2MCBTYWx0ZWRfX/uhailaaCKMx
 ANIs4L918l2swsBLRVdrjxbxmVXvA/FyhCbgLnxpxUyr0WsAie97suX/jbjAotoG17qLKI2iaX9
 qCiJFCGd3yvnFy5zrwY/NZEyXNWc8V3dvHYrwXddHBwRIPbsBSZwTF53DNs1q9V6AIhqpzI3KTi
 biNnjlV7A0rjc2TzE9bLIbHV7HxPb/wjCssch95wdhVFMZycT8vg5MoA8e2EzLxtK5az/HN8HqP
 +dddnsQfcrnrp72JUko1v0PxBKChOQZD2W5Aehz95d7t9gcl2qWVQahmz7ty4cAn+2SCsjYynpN
 fsPl8bRzVaPyUIHoym3BgtfshFdSW/ZDBgTCWB/Z3RK1nAiwLlT/wjkjw3V6Vm16aUIg/Jawymx
 DCr+gX0V6vtBQCA6twhJx4bTn/zWrm1NF/f38La62M8Gbo2UtvolhFnAU89RNZs4FFKIhy5MY19
 OQJbAHfpkH4JlmuNdDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2MCBTYWx0ZWRfX5M7xxQ9+SlmB
 a87JDv8cMBDl/V2uuMh9Vosch7oKAu2wQh41mCW+PwGQ7sxj9vg864tJMhoXPUiDdDhdYo0gWwY
 Hi2V6btNd3ijv5FtLfRA8skq6S9ARv8=
X-Proofpoint-ORIG-GUID: XE_KJxF2zpnToa9w-7rI8aTAMMwylbrO
X-Proofpoint-GUID: XE_KJxF2zpnToa9w-7rI8aTAMMwylbrO
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6ae21602 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=DPC3QgldnefEYUrkxV0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280060

On Sat, Oct 24, 2026 at 05:42:25PM +0300, Jarkko Sakkinen wrote:
> invalidate_keyring_keys() does not hold keyring->sem while calling
> keyring_read(), which is contrary to what keyring assumes from its callers,
> and can lead to reoccuring bugs.
> 
> KEY_FLAG_KEEP alone does not e.g.,  protect from  the following call path:
> 
> 1. keyctl_keyring_move()
> 2. key_move()
> 3. __key_unlink()
> 
> Address the issue by guarding the critical section.
> 
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> This came up as a side product while working on assoc_array to
> rhashtable migration and going through various callers of the keyring.
> It's made by me but please keep in mind that I don't even have a
> toolchain for s390 setup so it is based only on reading code and I have
> not even compiled this.
> 
> Just wanted to clarify the background for this fix as I'm not a regular
> contributor over here. If for any reason it turned out to be false
> positive, I'm fine with that too.

It is not a false positive. There seem to be more bugs in the code.
I'll take your patch and create a series with other fixes.

Thanks a lot!

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171003;
	b=STeWpHl873bZrUQX2ym+KEDA/sMYJmefWXSehqICuj2hj6cG+g5qfKj7kcHkqn3WcDgY
	 qdyL31njE6VjryQ0WmW7kjl2IkCW+dsWTzt8nAUaTKtoe0p00jlJZwVEYgWxznaaWQQQN
	 mnumP0+C2p9MevPWzyuPRG6RP5KUNsEzzjeF5r+Vp9pBGhIB3BRKt0bVK3TbTV4Sd5jP9
	 PRz0TeMypWk/unFiB3U7pluuGQuerRC+vNjcdn1VN4GNXAikizNQeIYlCNM3tQWllicay
	 ohegFpPh1LUEczQKOX6iDiEWsS9ZzcGiVIeJCngpH4WTAQqeuYyqv95qbnZMPnfXjwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171003;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Reinject:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=xldgaPkbiik6aZ1+1s2hEBnuSDe64JXjkrp5OGKHYXA=;
	b=tifthRKXKsSsMkKlFr8qa1HtgUUMcc/bmCWO8PJLb18D+EMBvUmx2W3zueDUQUfu4/b8
	 952zYdSZ3gX7BPH2Ug1rnP0/oPcHwo7ABPiyPg6WsnTm9pD20ObfJmD0GeEOvs1/SI8VE
	 1lfHd1IEM4o5vzWzBXpfEJMzZw8L0k2a1hZ0F3wAqkLr+jGfp3NrhX0QHnDxrhdkMZrBw
	 COykai2gqxobNdxKIOjAoKzm2b2zeQbEhahhatnt1qr3nPk2lgxHKwLgHkiuzliWfjvZF
	 oWnaEc9vr4R9Kawhh/kDzljNR+86OCfK/AiuslziZc6TtzBE02ua7PeSD9UCyAPTkWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GIt2ZSGs;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B850A606A31A;
	Wed, 28 Oct 2026 07:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B850A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GIt2ZSGs
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S4iKNj307022;
	Wed, 28 Oct 2026 07:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xldgaPkbiik6aZ1+1s2hEBnuSDe64J
	Xjkrp5OGKHYXA=; b=GIt2ZSGsga/pmV3vgPvyrcbMrNuA58ahuR5Vp8xugR+Q3x
	MN839Jgr4qk0jI9j+r81GWFlerj283CsBfvecKCAbvy+AzUAlwjt0I0A77ARm/OH
	AdYWnDnaErKWAKBTxFq5n09nkFlc5T5ZblSb7lm/JHWOpLwdjTnDhwZi2OE8LIoE
	u3B1ALYCsbz6VSfwqoooUO+2hGn/psUAieqUM99oLaBIUfW26mqhGWhk9993HIyJ
	siRCjy4JQ07tf+7GvfKzm8LDiyftaAFFtjroLb65DB3VD9gdqYM8GaPp1M7tw1OZ
	5MnAU2MlSxgAJSOHEFog3pU1jsbnUwVjDERoFpJA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmavjxf9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 07:03:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69S4YvF71030468;
	Wed, 28 Oct 2026 07:03:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjsu7v5m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 07:03:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69S73EEk16777484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 07:03:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 122D42004F;
	Wed, 28 Oct 2026 07:03:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D98A82004D;
	Wed, 28 Oct 2026 07:03:13 +0000 (GMT)
Received: from osiris (unknown [9.68.31.201])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 28 Oct 2026 07:03:13 +0000 (GMT)
Date: Wed, 28 Oct 2026 08:03:12 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Jiale Yao <yaojiale02@163.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5/6] s390/dcssblk: initialize device semaphore before
 sysfs registration
Message-ID: <20261028070312.8417Af1-hca@linux.ibm.com>
References: <20261028044828.96177-1-yaojiale02@163.com>
 <20261028044828.96177-6-yaojiale02@163.com>
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
In-Reply-To: <20261028044828.96177-6-yaojiale02@163.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6ae19e39 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=Byx-y9mGAAAA:8 a=HWHJTYK6ILqhKabdBLIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: fBfH5LHc3kmxpczVt_4FCwBahGuXfh_O
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAyNiBTYWx0ZWRfXxyNOSUqehq/5
 x0seUPC8Xjj3+fJSHcZaOI+YuoTwmj16vSA16SEx9e+u7pEWTtw/RvWpo9vEq47zeLVnVwMj1gu
 Et6WBNNfH2kw5ZKX8DcQZgupsK4tudk=
X-Proofpoint-ORIG-GUID: GwKFfQAL7qy-L7tgLIGv_uVREpNLCL1L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAyNiBTYWx0ZWRfX8Dr5dYsc8T2Y
 PIdh16hSKqaYuUmuMwdzE7dICYyeFgdPfB7UYkS8gHUNN+h0cgBW3W/G6qbtlwEyLrJdZ7tKRVS
 2AVfuMJZ6h1rncYvPdUhQuW28VLUrkJQ5FGsMBKjtL3D+p9M3oxTfFAhzsCOCDLs6BpsNH6BjwB
 5H+sQP+JZYyiIqpsv3X+A7gXP37/XebXJn1ENUdU+YBOj0iEViSlFy8IFqS2ypoXuRyUdGrmDEs
 KnHVML50Pz5re7Rx6MkHrxMfZeOkyeYSyScDEh75sTDwKEbCT7wVlzTJh8VT3k2GM94qJFtce0H
 Sxq/pDurbe9QgsvSUtzouuXr6dd49P5gHm1/dKGGedOlUL/suB3iJLbE99DLtEyngwhS93b+VfD
 bAXzt9yDbp2Amw/stHcAb5BCwWucBNFGJEUNEV0eRgT3I/wEL7iWksRoAtsJCr2bdJS3++OaErK
 jAqaRASwI67zSZvFCww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280026

On Wed, Oct 28, 2026 at 12:48:25PM +0800, Jiale Yao wrote:
> device_create_file() makes the add and remove attributes writable before
> the device list semaphore is initialized. A sysfs write racing module
> initialization can therefore acquire an uninitialized rwsem.
> 
> Initialize the semaphore before registering the root device and its
> attributes.
> 
> Fixes: c369527f18f8 ("[S390] pm: dcssblk power management callbacks.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/s390/block/dcssblk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> index e5a02c2990d0..46dd7eb9ca7d 100644
> --- a/drivers/s390/block/dcssblk.c
> +++ b/drivers/s390/block/dcssblk.c
> @@ -1013,6 +1013,8 @@ dcssblk_init(void)
>  {
>  	int rc;
>  
> +	init_rwsem(&dcssblk_devices_sem);
> +
>  	dcssblk_root_dev = root_device_register("dcssblk");
>  	if (IS_ERR(dcssblk_root_dev))
>  		return PTR_ERR(dcssblk_root_dev);
> @@ -1026,7 +1028,6 @@ dcssblk_init(void)
>  	if (rc < 0)
>  		goto out_root;
>  	dcssblk_major = rc;
> -	init_rwsem(&dcssblk_devices_sem);

I changed this to use a static DECLARE_RWSEM() declaration; and also
removed the incorrect Fixes tag - this is probably broken since the
driver exists.

Applied, thanks!

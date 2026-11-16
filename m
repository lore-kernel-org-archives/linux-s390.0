Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842802;
	b=RBhX2sE2LDHzdn7em3wpLprG94bfBrseKwAqSRDq47EGOg0tWeOb0byVXYifR0WmollZ
	 X47spyfVCVgjxVQ2LQlvWoMKTqg6t2MDrFHuNtDwj3zLXLWE3qPplaBrdYJtCyn6SCUij
	 OLPMBN+RMda3Bf2JGLuCY7zsKKH4AUGoZd4IHUyAiviyWAjk5IRh/IvaVaWyyTvjmh9Cw
	 f+VSCbRretjFtyO9JObHzpXwgqWXW/TGD/GPp4iUvBo1db17xfFuVCnS2LKtClptcJazq
	 UScp80+92YNQd3mdF5p36lKJsPlrWROVgQ0NyHOtElfjOGSNP8eHsZSUvCXXN2SAHzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842802;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=0dwK8TI6qy1OW1ri/FZaygFVxUbF5MpF9Rcdk0ygAxg=;
	b=KINLPXB6lp7Gf8B5N99+/HPkrTSxyKf8N7X+PIyxDPtLv8NF/PoIdIeZPfmFJtRB1uly
	 j25o4PiALI/IBdlbZgj/jwKpuilEqxWoEjNfoyxBO7eLhd/HhvOJAL8l81Ehv06jPQauQ
	 Kg3KihEWp3N/9z4IOB3Lp4dziQ05gkrw6Tbyu0FyPJjobupKTDXAy1fB43qmp2Gj5DSnY
	 dHAN1tObmxx76qJzK/NXSbcrkEnKREephR0d+FRe1+8xxqA7pPY4YLCeRB2PHEWh0BfIh
	 XzYWEKNlbjfu+JLhQmdltV8XFiPWr5GfLf21TSRgO88K4HeACAA3Dd39GTyVOzkj/1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SAFQEOY9;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A155606A32A;
	Mon, 16 Nov 2026 15:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A155606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SAFQEOY9
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGDuOv43631009;
	Mon, 16 Nov 2026 15:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=0dwK8TI6qy1OW1ri/FZaygFVxUbF5M
	pF9Rcdk0ygAxg=; b=SAFQEOY9K0TF6/76lgxBx3bHlrTcJ+GsIIM0PkVfkre54L
	WUrNawywEsYtALjdlz7ofXdB9p0Pp3egTKhANOUbktufoRvmRT/MzARpdiSMVZlw
	su0KVzmyx13KSmJLK/PiK3rpnVPhnEsn//9nY0gy36aoLcjLTyjFMQDbAOXVHf8j
	nyNJ/1UQMv6LuzpTiAwhdbz4U+Jd/XdoA+qUAftLY9KteWw/Q5TnnzqUtvCym1ok
	9JQbp2iasqQ/R24Kyd13VMvyjg2OER06mYerSObfIn1wg1XvQEnQj1F2xX+I2NRY
	FMNNBsgYpHZd0WqQvY0BmE/YfaMtr6q2LA0mRymA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf566bxy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 15:26:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGFGaHc1877646;
	Mon, 16 Nov 2026 15:26:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hy46fyvcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 15:26:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGFQAP552429172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 15:26:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 643D920043;
	Mon, 16 Nov 2026 15:26:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06C4C20040;
	Mon, 16 Nov 2026 15:26:10 +0000 (GMT)
Received: from osiris (unknown [9.111.42.169])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Nov 2026 15:26:09 +0000 (GMT)
Date: Mon, 16 Nov 2026 16:26:08 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 12/14] s390/sclp_ftp: Replace get_zeroed_page() with
 kzalloc()
Message-ID: <20261116152608.165348B07-hca@linux.ibm.com>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
 <20261108-s390-sclp-ready-v1-12-3e7c90eb6676@kernel.org>
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
In-Reply-To: <20261108-s390-sclp-ready-v1-12-3e7c90eb6676@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2MSBTYWx0ZWRfX28vpUqlOw2r1
 RkcZ7aGlRqN8/B2JmCvFltseg1TH2tw3HR7sWeoijQCc+GAC1EH075/kKK/AZCrVTwprGD1F9PM
 tgpccJdR/tIoS3K8ae2yMI76NUfS1a4=
X-Proofpoint-GUID: BLvltcQCLTMTj6A-iBioRX8bDKVj9MqI
X-Authority-Analysis: v=2.4 cv=ROImjIi+ c=1 sm=1 tr=0 ts=6afb20ac cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=cbU3o08U4KG32iXkhCkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: BLvltcQCLTMTj6A-iBioRX8bDKVj9MqI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2MSBTYWx0ZWRfX9sgdr1ebrgLe
 Ln76Ip40/j/6weeD6F/mfUlMpvPsE2RYi5YfpZy9gnRqQ0VFKd+HW2KAnF52RPLdkXa5qFnEKBn
 JhSiNotNAqHadAroyAGROu3gbFRVml+ffds4biAjAC2jBMGjLBRhAOeBHL0lyhnp884756IDaQC
 dUdjWb5SDOR7sjcSq6cE06ntJC2spQbZhSPY2uC2H4P7md+85wPr8NcnjkGffWYzqn09pm2LwnK
 w9zAo/+HdZ2HRZdi5y0T7RFnEqOB3ZaNbNN8oqnG3tE7NZyF2Enf8I9IPYlA4/hnPNnbXN/m42V
 pNzl88LPOd2ewtLsSIJyPhw5cYy1TUcz4wT23b3tUm0CVl34xJhhxFDVQTwWxdktM5Ac/AkYTdi
 9el8mwNmj1s/KZoWPfREvYnDmUEMQy9DF7y8tACCk5ZTWbkkTiE3pFHySe0pjffAbo/MYpsUKS8
 QjCeTO7vq4r4INxG/Mw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160061

On Sun, Nov 08, 2026 at 10:58:43AM +0200, Mike Rapoport (Microsoft) wrote:
> sclp_ftp_et7() allocates the SCCB used for an HMC file transfer request
> and sclp_ftp_startup() allocates the SCCB used to read the SCLP info in
> the debug code.
> 
> These buffers can be allocated with kmalloc() as there's nothing special
> about them to go directly to the page allocator.
> 
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
> 
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
> 
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
> 
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  drivers/s390/char/sclp_ftp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

...

> @@ -250,7 +250,7 @@ int sclp_ftp_startup(void)
>  		return rc;
>  
>  #ifdef DEBUG
> -	info = get_zeroed_page(GFP_KERNEL);
> +	info = (unsigned long)kzalloc(PAGE_SIZE, GFP_KERNEL);
>  
>  	if (info != 0) {
>  		struct sysinfo_2_2_2 *info222 = (struct sysinfo_2_2_2 *)info;
> @@ -262,7 +262,7 @@ int sclp_ftp_startup(void)
>  				 info222->lpar_number, info222->name);
>  		}
>  
> -		free_page(info);
> +		kfree((void *)info);

Sashiko is right here, the ugly cast can go away with a trivial code change.

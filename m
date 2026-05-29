Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B2B348C48
	for <linux-s390@vger.kernel.org>; Fri, 29 May 2026 11:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780052961; cv=none; b=ACZ0wOOQDU/JgG0USIyjLtbU8BFB+p/9cG7TzQ017YKphA6ghC+fF8NDzb0QkMOlFURoFr4Z0Ry2qQqVU4sfGNIc036lfXP51aHwa5u88F73YtWzVWwRIvy9iTfxLmMJbT/F2u0+B4xlMoBMirbOOrftwNd3OU+cYvxo8FWsEhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780052961; c=relaxed/simple;
	bh=Z+YvsMfZZ1ylUcgMtK2ytDQQXQ9yshVDK4k0ZC9YdWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ui+92+ithY/VG9atgA/m+81mBfOA/2H+TQadnIPsa0CT2KkBf0l4qpdDzrUf0CH8UPcTk0U3gFsqBI1PsyMyCf3kYfWaz0z1axIQ2C0aXcJE4lQe+oPy1NScmyVfEAGKlJOikQ7ueXISZ0la6w8qoZRhhd5xj77EW5rOxwgylM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gt9Ph9KP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gt9Ph9KP"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TB0OGI2418014;
	Fri, 29 May 2026 11:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=JwGS3hAEdpjrVq4aPdIJpOueDiQqDg
	QqVmwBAt5A8h0=; b=gt9Ph9KPDtsUCTp++/9OXaFYm8KXrjpGPdSKwU8DrRbKNP
	3EzH4DvHnVhihRF4ZWLoBDrIpolf+N4m5ylUJqXZTBE//g+o9sWQbc5ACs9xsLvu
	FrpN507fdRfPGOc2PZQjnSkN/GZ9VLlnfMRfkloXV9uTa1Ry+kPG+5QgYEMeK79l
	C/RV3IXOW59zhf6O2C8/LPZiTB6+VsGzBwimipRH10SRctEZCjYPtpSdWwjTPGLI
	3jPfMQ/3rbEIuU9KP3GvQWkwyg4IMmR9y/mbkzfNQdkWwIpU/k+/T/MJX90ez2kl
	0+h8wwIvvo/UYK+l9D2XKP14SvIcg4hWlBNgxCfw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884ra84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 11:09:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TB9Cic026128;
	Fri, 29 May 2026 11:09:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbd9uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 11:09:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TB9DEL52101568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 11:09:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7559E2004D;
	Fri, 29 May 2026 11:09:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE73E20040;
	Fri, 29 May 2026 11:09:12 +0000 (GMT)
Received: from osiris (unknown [9.111.13.205])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 29 May 2026 11:09:12 +0000 (GMT)
Date: Fri, 29 May 2026 13:09:11 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH 4/6] s390/qeth: replace get_zeroed_page() with kzalloc()
Message-ID: <20260529110911.26496Hac-hca@linux.ibm.com>
References: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
 <20260528-b4-s390-drivers-v1-4-b7108f54d722@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528-b4-s390-drivers-v1-4-b7108f54d722@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a1973de cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=c92rfblmAAAA:8 a=0xTEODR6Dx4qkx1z6ecA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: _CDt2_fIV7IsPUXdz5Wc7qrIDJx9rRxT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDExMCBTYWx0ZWRfX+n0GV1ZvJtXp
 YUJeojWhg6ZDHkRX6AwkNIPWcS5n8NeGj1+XjZBZEjbb3GK9xCc6TrdS+3VfhsT23PFFWNVobzL
 8xqXjC54lCclfTMl69v+4LdEyxfRZIu01b6NRLwQlSRCdHAVsvT7/Od4hzCIpPDaq2EexunHIdd
 V4E8zYJbxmLE6TGzUwalwa4PoOop/WZwpfk9gKRqYHncTMb7MJrAMnKB9afWlTcSpe88YyMtMLR
 aDHnDqfNdJ5QkFFNTGgWsEQd8IioQEks+gOIeblqm5yWvTrDM6XIREv0Cx22mIKDW/nYWcPGGSG
 Sc8gxEgGb1hzRrIdL1SDLPgfyEvnVzKDsIMnTdWfVfnPPacf6y+9ynQRU3iGNHHcljOI7Jd9oU6
 FS8IHSi38qOZu9Nx99yWrYFrkCdkVQwzpwbv6S9PnABMhALgwqnmr/4tKMQCxlRc0yrJtiBS7iY
 Dis6AYY6zFsHFJqYLCA==
X-Proofpoint-GUID: _CDt2_fIV7IsPUXdz5Wc7qrIDJx9rRxT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290110

On Thu, May 28, 2026 at 10:09:52AM +0300, Mike Rapoport (Microsoft) wrote:
> qeth_get_trap_id() allocates a temporary buffer for STSI system
> information queries used to build trap identification strings.
> 
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
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
>  drivers/s390/net/qeth_core_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
> index cf5f760d0e02..9274087557ec 100644
> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -3362,7 +3362,7 @@ static int qeth_query_setdiagass(struct qeth_card *card)
>  
>  static void qeth_get_trap_id(struct qeth_card *card, struct qeth_trap_id *tid)
>  {
> -	unsigned long info = get_zeroed_page(GFP_KERNEL);
> +	unsigned long info = (unsigned long)kzalloc(PAGE_SIZE, GFP_KERNEL);
>  	struct sysinfo_2_2_2 *info222 = (struct sysinfo_2_2_2 *)info;
>  	struct sysinfo_3_2_2 *info322 = (struct sysinfo_3_2_2 *)info;
>  	struct ccw_dev_id ccwid;
> @@ -3381,7 +3381,7 @@ static void qeth_get_trap_id(struct qeth_card *card, struct qeth_trap_id *tid)
>  		EBCASC(info322->vm[0].name, sizeof(info322->vm[0].name));
>  		memcpy(tid->vmname, info322->vm[0].name, sizeof(tid->vmname));
>  	}
> -	free_page(info);
> +	kfree((void *)info);
>  }

Hm, another thing is that Sashiko claims that kmalloc allocations are not
necessarily correctly aligned when slab debugging or KASAN is enabled [1].

I believe that Sashiko is wrong, since Vlastimil addressed that with commit
59bb47985c1d ("mm, sl[aou]b: guarantee natural alignment for kmalloc(power-of-two)")

Can you confirm that Sashiko is wrong?

[1] https://sashiko.dev/#/patchset/20260528-b4-s390-drivers-v1-0-b7108f54d722%40kernel.org?part=4

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B433C345F
	for <linux-s390@vger.kernel.org>; Fri, 29 May 2026 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049732; cv=none; b=W3t+s4YXf/l9MdRK4PF/L5ekH6NEl7I7hTb+BCGpQIIme19GgmO2NiTnGtsbzG1uuQAZQO2lrECfFAdKV6YhbPFEUdkN7AGrkhb0GGzX4xwFeFsODRL3w9rDeK/0FMumvmezqiW2f5Xts2Zf1vetcv6lRRFu7OThd/euASf8TiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049732; c=relaxed/simple;
	bh=aMpF9drK51XEB+Jinus2b8lRDdXZNysanf+Tis+G0Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZbYaXvm+bmdtpJlBptVfyxLPqluUULifZLtp7GJB9XannNt7RRxowI52v8xoiYIJ8V395ciTRMlv1tRcDJ4/JZVKIO316bHG564h3MkLe/2ddeCHZXouz9yNVyxBSg6pAvcCPiNyAZNmhp9PeP2REPKnmJcg2ICQHBhvkBKbIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y1JC3QmX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y1JC3QmX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLlgDp1467756;
	Fri, 29 May 2026 10:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=F9WNWHvD9Hesn9QQalNBhtzkj6z6eb
	aqojzNSXku5eo=; b=Y1JC3QmXTzZG3ohHEtFySG2HPb2NhOrgZiX2W+zMiZLtdU
	qeWvygb3DxXnj/4pgvifaQTtI6y0u2xEPMrUwvUVQfR2FCCvgubSn+V6g/eB9Qtc
	uZtBFji5DuCw6AbxlAE+XYl4RkJfSKqqXWs+n5luojegy5xwSfOszz3vzjceDnnu
	ppj2OfbguQGxVvfGr1X0+ZwPug4vcFrJ/zbS+dFNn4/iTHTdm3AI0A7iSXcFlKFm
	R6tFBd3mdjlSZwkLoreyoFcPckIUGNsBJYFhDNJrjalHmouDfpuDPusSfkn7oU4C
	F655N45ykTXcQS3VeAl/VoKs26DgGrybFP5aALXw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886g1md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:15:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TA9PDg029531;
	Fri, 29 May 2026 10:15:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbd2t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:15:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TAFNrS48169216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 10:15:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7F602004B;
	Fri, 29 May 2026 10:15:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67A572004E;
	Fri, 29 May 2026 10:15:23 +0000 (GMT)
Received: from osiris (unknown [9.111.13.205])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 29 May 2026 10:15:23 +0000 (GMT)
Date: Fri, 29 May 2026 12:15:22 +0200
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
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/6] s390/dasd: replace get_zeroed_page() with kzalloc()
Message-ID: <20260529101522.26496Bbe-hca@linux.ibm.com>
References: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
 <20260528-b4-s390-drivers-v1-2-b7108f54d722@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528-b4-s390-drivers-v1-2-b7108f54d722@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CLE_jMi_SPxoc5HQwFKFTgBsY1ZcUKtQ
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a196740 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=G4mMAKXYhPOcyb86gNIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEwMCBTYWx0ZWRfX3BoRXQsCz1bE
 nFFaQ2qNcIY7P9qCfOuhaAS0rGccVMVxnhAedvvASJMWFPAQiGYlyd/f+Hun630t8j4k9xn5YPP
 gp7zDfhDAPG/oqHQ5JnM62bh7aq8ObNAHGzH5TxtsXG/MfRMAH4QoI0iIpWsR876V15Oj8XRTCl
 HpwNgC1yUKUflCc1VUbCaC5neQ/1M+TPe2xjs9+zZ9c7z5Ox1F3Jc1ZvxLCb6HJHPJZuoYOWQdo
 J6DNVrs4I4iQClbR0Cxhk6KYJpCtEWWtgm1YIUHsGReKJqbpYo7LFhxmWB20/3dF9a02P5wCMS0
 V4cCeCezWoYyCfq/HrIL1yvnLY8j4skX5bf81r99aLDqidOLjRWeixLlUoV0CKEDJLTLI86w+Qk
 FvBNT2wSVBD2aIpiJNdQ1OZB9h4O3NjmOXW0S5kzza1Me75cBxDlx03i0COQLl49vCXoBm0uWwL
 WZB1olJ49m2DviY3J7w==
X-Proofpoint-ORIG-GUID: CLE_jMi_SPxoc5HQwFKFTgBsY1ZcUKtQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290100

On Thu, May 28, 2026 at 10:09:50AM +0300, Mike Rapoport (Microsoft) wrote:
> DASD driver uses get_zeroed_page() to allocate pages for the Extended Error
> Reporting software ring buffer and for a scratch buffer for formatting
> sense dump diagnostic text.
> 
> These buffers can be allocated with kmalloc() as there's nothing special
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
>  drivers/s390/block/dasd_eckd.c | 12 ++++++------
>  drivers/s390/block/dasd_eer.c  |  4 ++--
>  2 files changed, 8 insertions(+), 8 deletions(-)

...

>  static void dasd_eckd_dump_sense(struct dasd_device *device,
> @@ -6958,7 +6958,7 @@ dasd_eckd_init(void)
>  		kfree(pe_handler_worker);
>  		kfree(dasd_reserve_req);
>  		kfree(dasd_vol_info_req);
> -		free_page((unsigned long)rawpadpage);
> +		kfree(rawpadpage);
>  	}
>  	return ret;
>  }
> @@ -6969,7 +6969,7 @@ dasd_eckd_cleanup(void)
>  	ccw_driver_unregister(&dasd_eckd_driver);
>  	kfree(pe_handler_worker);
>  	kfree(dasd_reserve_req);
> -	free_page((unsigned long)rawpadpage);
> +	kfree(rawpadpage);
>  }

This is not correct. The allocation is still done with __get_free_page().

I'm not sure about the whole approach / effort, since this allows for subtle
bugs where pages are allocated and freed at non-obvious locations. All of that
works now, but these conversions may lead to subtle bugs (this particular one
is not subtle and easy to spot).

Is the net gain of this conversion really worth it?

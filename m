Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842857;
	b=kLsKBUiIjVwVz37WCXMrQJY0tuvv6SNEcEqbL39Y6XCT+97/G2VQiq8i1V8Y/Qwkomoe
	 QGaEUJAXWlxtdPYIJbSCjWIxo9k7ay3/SE1QZpTxIb/48vRfFyCatBZxyHe/vcB2fjYC0
	 3UwjdwOT4jgRQJh4hbP/r46ggz+c2AcoZz+Ly12I1KHSWmDvb2o/BdwMlPQ228Q4yPLOf
	 fUPxGFCKlknoocfOE5Cw9fbJj6fNkrdQj9xAYtAeDTvm5v8+eSGfnIMgAfQn9YgnYEZbk
	 OQsG2UwDD7rDudxaRFZ6s99z7uiLjvfB8kIEnQKkkI9S/xgEaCLfGqMeGoMT5U/W5tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842857;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zDqKDi+8QS7XpcU4OwMH+nJrC1paFAHA3qMs2v8CCWI=;
	b=B274fCZMUttA1uMOJBfpqPCX2ESN8uATFV130Qyge9HVGblrhzDo+zI6r9nRNeYY+8xp
	 1RJKQirTEAv6TeLPvAadP88dCIxCLmZXaYWALVqSOveQYwZoUFNY4UFbSpMSYUkB1sGAs
	 LlVH/L//Oj8r2+P1ptOpiVhs3RwmGZEpRfLNR3H7u/j/QuMh0/R/k30KZ7kKDCJacpA68
	 129J8VgJS26+lndH5xThOIfnEoqJF1oaQjQ08wX/noaBRPxbDA4r6EtY1QyNER/+FkjFv
	 735v4smslAMf0t2OBwgKxSaUz30wagLQ7L8d+D3/xEPxDxFCTO+RXGd8zsjY8UipCfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=frNkaEBO;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F554606A32F;
	Mon, 16 Nov 2026 15:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F554606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=frNkaEBO
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGDuLqZ1820443;
	Mon, 16 Nov 2026 15:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=zDqKDi+8QS7XpcU4OwMH+nJrC1paFA
	HA3qMs2v8CCWI=; b=frNkaEBOL64sssNvR7YtSN/DavP7rEouQLqVPSS65gK5zY
	Twji8MK6kZ3mph53RNYW/3FSlEqY/+WUc+33IDjefJ2gCBdNg+7a5ysR5sa82cBs
	qRUOwuGbAE1d7ZM8qqoZi/A4tcC2QH7R7Z6F+Wk7cN57dou85QvVqI/UQ/plOe4K
	hZg3RMDo8O0tlh3cgWy0L/rNrILS5WZErTSYnj5+ajcCtqcyaS7TLh/Il7q+fK76
	qHHKFgpLt2+dAmz7/GuDsn4/pswhLQza9hT6/U0sgXDZCNJM9Iu9rAug6Cw11A/M
	jskOBKmvciXrsPLr9KQ002LXcI+vC8m2PfxGzapA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxfasxaj2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 15:27:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGF9mwf2972493;
	Mon, 16 Nov 2026 15:27:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j00ns99ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 15:27:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGFRJ6k17564150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 15:27:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B566F2004B;
	Mon, 16 Nov 2026 15:27:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E3B720040;
	Mon, 16 Nov 2026 15:27:19 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.68.17.117])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Nov 2026 15:27:19 +0000 (GMT)
Date: Mon, 16 Nov 2026 16:27:18 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 12/14] s390/sclp_ftp: Replace get_zeroed_page() with
 kzalloc()
Message-ID: <f47dc1fa-3def-4558-acb1-5b58a3ff226a-agordeev@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2MSBTYWx0ZWRfXylraMr+QEUCv
 9MvUnVY1NWWuNuFaaQqVZdp2ZA7N5KK4bBl8OR+30lfgCajZrk2SSRLBXJyzWvVObd+r/XKiIvT
 Ok5ZZ92b6vRV/HF1q+bkVma/043WmX4=
X-Proofpoint-ORIG-GUID: lBYkfDeD4sccbWyPq-tPzYXfrltOULN-
X-Proofpoint-GUID: lBYkfDeD4sccbWyPq-tPzYXfrltOULN-
X-Authority-Analysis: v=2.4 cv=IaESymqa c=1 sm=1 tr=0 ts=6afb20e3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=0NCBxJeg4obUfdkLXI0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2MSBTYWx0ZWRfX+uX0dOR6dd0O
 GbLn1rL63pMU/GN2H4dPRkjGXfvvE1jm2RGpms2BysTwwpAtx/tSzz0rqwHWCuKCZ+PLT+ZJNjZ
 SKuClC+WnVTLZl8SEH+jirH6b+a8x4+ZxudPuUG2OgMYLXTb2jVT/tGi5N4xh8ejzVLJxp5oLTZ
 ZjH6HaZ83EWU6LNaYd7E79z443NeiXXsQqsZjWeyhyoMFxFWXse/JKgYj5OULkXO7+mYIadzWQ6
 Je14u2K+yy1HbntzuN5xefiqvYYI4rrRh6w3GlA0pOODjv/E0hWaXWommmZ32X0RhTawd517zq1
 qj4tdQmv5S8qa3T3Mq+3WIwlpcmR7K0bpywf1T77dOXsomHzDERIHijf9Zfdlz4emI/KPgSxk7h
 sv5t45uWv75RwReMs6zJvQPqXg/8OcMMJ7+PNA1aBj0mEl/aF/kIuxRoUxfyeH8xR52tscmaXpI
 2bb2yPlDDvpdiQq7kVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160061

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
> 
> diff --git a/drivers/s390/char/sclp_ftp.c b/drivers/s390/char/sclp_ftp.c
> index 853492d53953c..c46fd056e9daf 100644
> --- a/drivers/s390/char/sclp_ftp.c
> +++ b/drivers/s390/char/sclp_ftp.c
> @@ -93,7 +93,7 @@ static int sclp_ftp_et7(const struct hmcdrv_ftp_cmdspec *ftp)
>  	int rc;
>  
>  	req = kzalloc_obj(*req);
> -	sccb = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
> +	sccb = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
>  	if (!req || !sccb) {
>  		rc = -ENOMEM;
>  		goto out_free;
> @@ -155,7 +155,7 @@ static int sclp_ftp_et7(const struct hmcdrv_ftp_cmdspec *ftp)
>  	}
>  
>  out_free:
> -	free_page((unsigned long) sccb);
> +	kfree(sccb);
>  	kfree(req);
>  	return rc;
>  }
> @@ -250,7 +250,7 @@ int sclp_ftp_startup(void)
>  		return rc;
>  
>  #ifdef DEBUG
> -	info = get_zeroed_page(GFP_KERNEL);
> +	info = (unsigned long)kzalloc(PAGE_SIZE, GFP_KERNEL);

Hmm.. Why not make info struct sysinfo_2_2_2 * instead?

>  	if (info != 0) {
>  		struct sysinfo_2_2_2 *info222 = (struct sysinfo_2_2_2 *)info;
> @@ -262,7 +262,7 @@ int sclp_ftp_startup(void)
>  				 info222->lpar_number, info222->name);
>  		}
>  
> -		free_page(info);
> +		kfree((void *)info);
>  	}
>  #endif	/* DEBUG */
>  	return 0;

Thanks!

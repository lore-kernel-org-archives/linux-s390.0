Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5343ACA6C;
	Fri, 24 Jul 2026 20:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784925856; cv=none; b=N5+jdQ7pEFYj3PWEq2c+j1QKSpx7i9SBofN+w/EdaFKkB9Swyv6E/iI8bvVZOLsB3l4tMiWj75ngxG2LW387z8Gq97ByQ1lM+Hta+aKCXuRhzyIV6veeEJZCpxRGh6kNHvQO/x7WokEefbGQwDsHm3bAqZ2k/2Tr+f6Bd8nbCvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784925856; c=relaxed/simple;
	bh=iS/mwhebmyYWToIziqD02iD9GpjlCcOmOCo7RrmPunw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+ff/ASdctqyJSZzJSwPlTHK2uQ2hXHeMC/Snm5ttpyqiVJXcmmslDJUr0GDrZdDU1pqqSquEW1yXmAIltDu+FauKSexDFTgco6l9E6O0zAhzqfuNTNxvwygfqt0ZiYoySKh2aZVSNNtkUo3kpD5FHaOFn9WatyESdbfZ9QfJ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fNC4wajb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fNC4wajb"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OHBdNK555929;
	Fri, 24 Jul 2026 20:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=18zUN/
	CDKU+1yKCD11JIizr4utJDNShJniXlRran+ME=; b=fNC4wajbfankA2bMxlMs6b
	WnJ/mNJ70YiRjofAt00mmR5WcQUeveR11JPBBpFWdKusPQ3G19WurF2AZXGc7xPq
	gYlmTifGpXZPUhQWVob+MEHefP6hUDaswjFduZxPNZnwYChccq7aIzuovw+NFSFl
	QsWXLMndDEMEwjtFlxd/Z2FctGoSSzP2asFDPV6LEftkKeuYamT+0no5AMlLJ8nM
	uQIZDaPbVZdLP9XD2Z+U9qLHZypCSGEMYXksHKSae7Sy9nIOAGeYGb7SoX0A9iNS
	wcxT8lCw+gcOC0PlQM8x+j3QpCacMb4YtUOEyRq2IsyJoexVtQjIFQ+REIqPvILg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8gs9wy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 20:44:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OKYcCj031233;
	Fri, 24 Jul 2026 20:44:13 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqjstp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 20:44:13 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OKiBP019858084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 20:44:11 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FDFB58045;
	Fri, 24 Jul 2026 20:44:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D3E958050;
	Fri, 24 Jul 2026 20:44:10 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 20:44:10 +0000 (GMT)
Message-ID: <bebb434e-4923-4e39-b754-72d608a457a0@linux.ibm.com>
Date: Fri, 24 Jul 2026 16:44:09 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] s390/vfio_ccw: implement a crw lock
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-9-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260723174751.1180334-9-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE4NiBTYWx0ZWRfX9uLtI64Ddcdy
 ieTz7GNvbBNQh2i30u1Z+TMxny+7HJheqsejDMaaiQxntH7bq+VZMYFLvNhhj1fbdiOte6ee3aU
 TPNRpOusrSaLw5t+JAbMphf8wpjjqks=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE4NiBTYWx0ZWRfX7ja6Sa8wt5Yx
 1E5iGZYmAsleL3M1XtFZ1ySmS45pEK2+522VLoorHjis4tH8csHCZAPQi1Amz9yzpKKgMQCzBRj
 g2egeBBUqwbto4nPc+JMZUpf5dRThLJyds1OYVH3KWLB3EHNWdFthkmIiv4JcEGFmhMF/I61agj
 r2fn9hKsLJ/Xx65OpYn+UL28wBAwIQQarRdP7kyKVkCnryiLEjb2b0cv6rUxVxcnBcYY8ulbgOp
 sQBtkmqP4JsCYUfY4mhMw84DrUU6AIFleOdtkfXbUP49RIAN+8RjlDEAkzFG33JiN3DD30Llxq9
 cQVxOHMjVUuDSzA/mmWA0JxYJ/0MEVlpJzHNLTLdSSTn6v8a7ghewrbIX1cnjlIb+jveAN0Il89
 vzRgZt5hAjS6C55MGlDlhhP9xjpNAFE6MdJ1hcMdp2kQ1dXCwORvdcMtKYE1oc03NrV2h2vZ7B1
 Wvhw9n4xqfsluInu8+Q==
X-Authority-Analysis: v=2.4 cv=Q9LiJY2a c=1 sm=1 tr=0 ts=6a63ce9e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=givLDcII0hE-szGgeRIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mU2dyMAc8Kw6CYhwDr7flq_Lt7Ne7Nzo
X-Proofpoint-GUID: mU2dyMAc8Kw6CYhwDr7flq_Lt7Ne7Nzo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240186

On 7/23/26 1:47 PM, Eric Farman wrote:
> Unlike the channel_program struct, which covers synchronous I/O
> submissions and asynchronous interrupts, the CRW region relies
> exclusively on asynchronous events coming from hardware.
> 
> Implement a lock to manage the list of those payloads, to ensure
> they are read cohesively.
> 
> Fixes: 3f02cb2fd9d2 ("vfio-ccw: Wire up the CRW irq and CRW region")
> Cc: stable@vger.kernel.org
> Cc: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_chp.c     | 17 +++++++++++------
>  drivers/s390/cio/vfio_ccw_drv.c     |  4 ++++
>  drivers/s390/cio/vfio_ccw_ops.c     |  3 +++
>  drivers/s390/cio/vfio_ccw_private.h |  2 ++
>  4 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
> index bf678270c457..3d05aaf790fa 100644
> --- a/drivers/s390/cio/vfio_ccw_chp.c
> +++ b/drivers/s390/cio/vfio_ccw_chp.c
> @@ -93,15 +93,19 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
>  	if (pos + count > sizeof(*region))
>  		return -EINVAL;
>  
> +	mutex_lock(&private->io_mutex);
> +	i = array_index_nospec(i, private->num_regions);

Same comment as patch 6 wrt to array_index_nospec

...

> index ac5aaa78a74b..2562679b5ef5 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -121,6 +121,8 @@ struct vfio_ccw_private {
>  
>  	struct irb		irb;
>  	union scsw		scsw;
> +
> +	spinlock_t		crw_lock;

This should have a comment either here or, in keeping with the rest of
the struct, in the comment block above.

This looks good if you're trying to protect private->crw list, I don't
think it's complete if you're also trying to protect
private->crw_trigger - it looks to me like you hold the new lock over
most accesses to crw_trigger but at least not vfio_ccw_mdev_set_irqs
where you set/clear it.


>  	struct list_head	crw;
>  
>  	struct eventfd_ctx	*io_trigger;


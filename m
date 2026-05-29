Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AA331A807
	for <linux-s390@vger.kernel.org>; Fri, 29 May 2026 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050574; cv=none; b=eeZerECDuNeT6Wh7S5bJso05pTWy2F+DGoXE1+r1br2QceoZHaAarr11dkIiIxOT1fvzEoej9CphyuCdzElpiJSoVHEvPZuvXQiUKhYkKt/5YczotruOjq+xDmRd02OwkB8403DREfoJXm8ih45e3ve9UVe3RSrYjajxNbIb5gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050574; c=relaxed/simple;
	bh=5kVtBgdk/4XoPkTTPYDkMx5ffgkG1Dq6PQPihPlLiP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+EMfbIKDgbHSkxGq0/TaSQHv1wD3v6QAdrqDonrGsDO/PDWGEIaMcWbYz0XLVDMDcFvIlTGUhNHimjoKkvXwKOiyNmZHvWwCvqE1cG2yeF8Q5YdAU202uJAa5692jmhf1Gy4kTVUupJ+v7OfbS1PuVpoLgenHOeSq9xke21W68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TnKJFZXO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TnKJFZXO"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLlhFB1467776;
	Fri, 29 May 2026 10:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=YZOIp8R1zzzQsdOR4I0i4qXcenBLMJ
	pujjWZQTsdhGo=; b=TnKJFZXOQ9nTHQwy5vbiogcESj9MYzCTlU5o6Rwb1pQcmW
	Fq4TGf5FrLlQOXBlLfIPzf0TTo5bkYPyR5emWfg4WonBAYQNlvwL1mw+EfbPciVW
	cIpybG3KebMqLQWJyfPcZ8xT4eKaAxNnQL8LZOFQ2Td+90eLqBTnihOz8XbKTeup
	AWqTYCpoglphM0zv4QCqgAtVKVkUUiKBmZeT2OUYvynTOdUZc2WIyuE2edrC/ypz
	sZ9jpWWcRn268wDMZZZfA1c7gHXiFEId20VPs8sLzAa5hIPoVAnd8LrofJjwFs6H
	IPTthIiVBQfDSDLHG5vnQ4YO7SS+Z+z+wWrj8+Bw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886g3pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:29:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TAO6ru013589;
	Fri, 29 May 2026 10:29:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbd4p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:29:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TATQqT8454470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 10:29:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D92182004D;
	Fri, 29 May 2026 10:29:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69E8F20049;
	Fri, 29 May 2026 10:29:26 +0000 (GMT)
Received: from osiris (unknown [9.111.13.205])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 29 May 2026 10:29:26 +0000 (GMT)
Date: Fri, 29 May 2026 12:29:25 +0200
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
Subject: Re: [PATCH 5/6] s390/trng: replace __get_free_page() with kmalloc()
Message-ID: <20260529102925.26496Gc6-hca@linux.ibm.com>
References: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
 <20260528-b4-s390-drivers-v1-5-b7108f54d722@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528-b4-s390-drivers-v1-5-b7108f54d722@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5AZ60iKMb44GthqpX8gDv9BDLoz9hEpW
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a196a8b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=kI0hIdMbwa8tJFnrpg8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEwMCBTYWx0ZWRfX5tqyHIVDoq8O
 XMR+rnlXap7Mfo9keGiA/KtkKgT8Q2LM4UUfd3OHh0Fzb/VHP0nzC9vsP664xFv/eJlXvSoqXNZ
 Ih2XtfEI+LBIdZFj6N7GdV5t88kR2UTrUSyiywc8j31Z4FBw16gfccnJc3uYcD97LVeyIGpWfSG
 wHC1/rF6R1WsNIZZl9E0cz6u9L92CnvBoPB5wBqCOx+BDoRx9qmWuWxOZUj079ORvux6FzLPD+o
 x7ZCiGfZKi5o1AKI0hiPqCSLMCVNWMIw8kn7jd2zCy4zO9YEfxtCqCPfGOXOYxRrtzV4xeZYbBF
 8laYCVf0Jn/GdW7hJCnMFcDwxAQvSgKtxucE2+lkMMs6HiDYaMHF6hRN1jjg3ndQWOwMw5APX4N
 1HDfcDbbbZRCJBVq1sQ7/7UOkQnhYvHUDtIS0b3N8HAxllDTl2QlV2JgektIU0DYJ5ITz/u0S2d
 ll5XAyZpjOfm7JB+rgA==
X-Proofpoint-ORIG-GUID: 5AZ60iKMb44GthqpX8gDv9BDLoz9hEpW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290100

On Thu, May 28, 2026 at 10:09:53AM +0300, Mike Rapoport (Microsoft) wrote:
1;115;0c> trng_read() allocates a temporary staging buffer for CPACF TRNG
> random data before copying it to userspace.
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
> Replace use of __get_free_page() with kmalloc() and free_page() with
> kfree().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  drivers/char/hw_random/s390-trng.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

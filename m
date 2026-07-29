Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7731347426F
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785324356; cv=none; b=CyLk1eqYzTTs/9N+Pl+kUob4B1rzTpuT2LX9Bvgl+UrFELtni6VNcR2VSY3ZDfZASzo9hHF1wujVqmKOF8v1jRroW1n4NA0bf/mq7aTVU5kK/Er31s8sHNktRM7OmwX1q/DluemZUMPgPhn7ROBo3C4y5BM6UYKuqz3XwxxzXEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785324356; c=relaxed/simple;
	bh=KmrTZldF0GUs+yqGLWoYR9c/d27VFx+UPR1VIyhIXUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAQipuBMF4Z4XJe1PgNWavmJ0tFZLFRmQEje3FqpJcQMIDGbz2LVvcKjhORPWcTU4xZwKXD2tjR7yzdQJjlctgXvVw6RF1CmUXJh/M7aiouuff/tYD3gozmNqpOayk+ET+EBjdH+miIffF9kd9CFXm6wvE2iO4fZLbga7NJ9n04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g7aImI9c; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g7aImI9c"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBHY474029811
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 11:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3pTc1N8XQIB+puQz+pUrvYFcjLKBH4
	Y/J2GVExOn8oM=; b=g7aImI9cj19QJ1YBzr08TU3V6ungoo5J7hhdT2jOag7QWL
	3RXsEzON7kWEian2bBJKZbeOSUVyoYecMZnVc8cRNmzHuE+NqZQU7fodGOwfqer3
	nGYyq8B1pLZAHnwiE13rADainHfvdexSt3V8azEzX0E2jd7OQuV1EZNsnWw94/Ga
	P4n95DYzZedGqwAMYqTSmFbmI/uQBTSph9e7D359l/lkxS7Qpw+ouOVLifjqGsSH
	ZYF4zMK95IJfW3FZhRunEIQQku5MnNw3tvBV5udRk79UKbEzY67Szai+Ta5X8mnD
	cToz+wDi9aa0K3I5x+vg0C5mCXCXUT+KYsmDKTaw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7jbtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 11:25:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TAuGm6021190
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 11:25:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk6f87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 11:25:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TBPn6028967396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 11:25:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5250B20040;
	Wed, 29 Jul 2026 11:25:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15A142004E;
	Wed, 29 Jul 2026 11:25:49 +0000 (GMT)
Received: from localhost (unknown [9.87.133.185])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Jul 2026 11:25:49 +0000 (GMT)
Date: Wed, 29 Jul 2026 13:25:47 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Finn Callies <fcallies@linux.ibm.com>
Cc: hca@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        freude@linux.ibm.com
Subject: Re: [PATCH v1 0/1] Fix the length of the qd field of the TAPQ
 response
Message-ID: <ttixp2z@ub.hpns>
References: <20260723150038.93617-1-fcallies@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260723150038.93617-1-fcallies@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pQHQNOYwdpRhNcYDNRuDNLLSf0vfcdEn
X-Proofpoint-ORIG-GUID: pQHQNOYwdpRhNcYDNRuDNLLSf0vfcdEn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA5MyBTYWx0ZWRfXyfkNxNxnJQRo
 ncUoRF6RCJbHMydWwY06VFZk0S00lY3/GbD4fTGd2qSCSOOAGaqV3i1rD2NhW2hnGKZSuO7Yy4s
 chXeFjo0GKKKk0SX/tLzxOejGhvkar1p6YXenj93cQC2qfM0IyB2isrT9seyfQV+f8k1gK6d2ET
 jqQ0Zf0WICptk9S9tDtvcR7QxEoOc+nuzFJY6eRw10Rb6YNn9Tb8UxfS6lGXalRKpYDYYLk2WI2
 5S9s40E2i/+7YNcVhvS8lO6m/uyjK7yD4tQwR/Nw3VOzzyvUbiDndbriO6Sn9m7HxIE2euX+lsa
 JqC7sIRQ4v5BDJEGUmwQcg05KIOXiWzNJdHUZw6hQElOp4X20CP4U2F6YLo02sUS89OUzqMVA1b
 +vrFlj5acJAOSLrRqQxgGChs6z7/wzKoo3h+ELari00rGOt0BYEAPe3gBlHyflLlmRRg844SX3Q
 /j6MFDcccykllJ0qKLA==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a69e342 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=cxeqTIfnZHFz3sRM:21 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=ZVlsefT5FXkBDAG6p0MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA5MyBTYWx0ZWRfX2xe86/TaZ2c4
 rpJN8dLl0kLKd548+YQkr5/AAPbH1Iwwjl9HrSyTLkwbzwE3CYvjHHwQNE79SuPW80Yw1oD6wf2
 qQ9pBNgyei2S6Zwb2S7KqTkP8djGQuc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290093

On Thu, Jul 23, 2026 at 05:00:37PM +0200, Finn Callies wrote:
> ====== CHANGELOG ======
> 
> v1:
>     - initial version
>     - review from Harald
> 
> Finn Callies (1):
>   s390/ap: Fix queue depth field length
> 
>  arch/s390/include/asm/ap.h   | 4 ++--
>  drivers/s390/crypto/ap_bus.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied, thank you!

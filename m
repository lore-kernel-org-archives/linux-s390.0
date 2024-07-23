Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542B71514F3
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740714; cv=none; b=mJ7OD+cXmtX3v6uwyfakGGufjO8NTmE4wUcvRGcm1sp9P6TyQeuM/QMZDJ4p+dV5h4NvQ2ffMn9ad/7ueLNHFDedfRpvJZdfZ/jcRtgXub5YllDyBekultLt0iWTTuPWj1jhCCie8BKB4M+vY08AvVdSo6ScwnqS47gNqN3qTeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740714; c=relaxed/simple;
	bh=YV7y1nlh3aBSY1RQalU7BT9NR+sskti4+ozZq31yfAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0MMWXIXlytba9hn5F5tqQAKQCKn7o8TyZi6Ne7NotN64jUAkIvuUUTZ5CAlmHXkrObzQAV52AyZteGcals7+K6euycYRujbHy7FtGR5YqUkgFBy4jNYuFjqwOnkMeXseAPwOef7MZPXDkuw3A0SYg5WIr4IJn4QQlb7CW8sL8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mSJgBery; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mSJgBery"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NCTMI7019672
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 13:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=9oaz0mWvuXffHvtEZg4q4jcHS/H
	P2y/uRrSB7sByMVg=; b=mSJgBery+3TzqNzaTv345EjAgRRL4+YjgMWPay6GySJ
	96Syo3XRpXSjACvWqKeE9zYX2YLKie1BnN/Dyohk/+0erTS4g6g9oqmZ4f69ho3x
	PYIZERcLKGKXgDR7oo8XKIpCeJestO9lGZc+tO4SEDJAbng44OGG9YrIOwAWRXvr
	G1MBYeZSRJ6pTGkBCgs/hHPgHpypANgT6MyD2WOzTsSUjwKdLUQVSCK1UasbwbDx
	u9Uncas3hktz5bzZE/MqFtDdNSAMnoqoYHizVXTCV1PBM1GAi/FMkaTqCha6PMqS
	aYewTKmIaJ0LkZ524s1mIN36yufQrvOr13qAi0kPaow==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40jcj5g40u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 13:18:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46N9WBZ7006714
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 13:18:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gxn7agha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 13:18:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46NDIOM448234762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 13:18:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF5CB20043;
	Tue, 23 Jul 2024 13:18:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A649920040;
	Tue, 23 Jul 2024 13:18:24 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 23 Jul 2024 13:18:24 +0000 (GMT)
Date: Tue, 23 Jul 2024 15:18:23 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/2] s390/ptdump: Add KMSAN page markers
Message-ID: <20240723131823.6750-B-hca@linux.ibm.com>
References: <20240723124441.120044-1-iii@linux.ibm.com>
 <20240723124441.120044-3-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723124441.120044-3-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aFL74rGGr0254VXz3oc6mmW0A2E35D6V
X-Proofpoint-ORIG-GUID: aFL74rGGr0254VXz3oc6mmW0A2E35D6V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_02,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxlogscore=592 lowpriorityscore=0 impostorscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230092

On Tue, Jul 23, 2024 at 02:44:12PM +0200, Ilya Leoshkevich wrote:
> Add KMSAN vmalloc metadata areas to
> /sys/kernel/debug/kernel_page_tables. Example output:
> 
>     0x000003a95fff9000-0x000003a960000000        28K PTE I
>     ---[ vmalloc Area End ]---
>     ---[ Kmsan vmalloc Shadow Start ]---
>     0x000003a960000000-0x000003a960010000        64K PTE RW NX
>     [...]
>     0x000003d3dfff9000-0x000003d3e0000000        28K PTE I
>     ---[ Kmsan vmalloc Shadow End ]---
>     ---[ Kmsan vmalloc Origins Start ]---
>     0x000003d3e0000000-0x000003d3e0010000        64K PTE RW NX
>     [...]
>     0x000003fe5fff9000-0x000003fe60000000        28K PTE I
>     ---[ Kmsan vmalloc Origins End ]---
>     ---[ Kmsan Modules Shadow Start ]---
>     0x000003fe60000000-0x000003fe60001000         4K PTE RW NX
>     [...]
>     0x000003fe60100000-0x000003fee0000000      2047M PMD I
>     ---[ Kmsan Modules Shadow End ]---
>     ---[ Kmsan Modules Origins Start ]---
>     0x000003fee0000000-0x000003fee0001000         4K PTE RW NX
>     [...]
>     0x000003fee0100000-0x000003ff60000000      2047M PMD I
>     ---[ Kmsan Modules Origins End ]---
>     ---[ Modules Area Start ]---
>     0x000003ff60000000-0x000003ff60001000         4K PTE RO X
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/mm/dump_pagetables.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

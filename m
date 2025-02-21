Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFD020B7EC;
	Fri, 21 Feb 2025 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150728; cv=none; b=lPInmCTKmm59Iu3egqqx87/cYR/geyuUvYw4qu8DjgZv2yd8ETiAABE9rcOJIhmC5QlsIXnRl12IKolFNAkiWojXs4odFEQgDsNqrSqycvkjAkUR4JPObVy9coTiOZsRE9dnwhn/9VZ/JOSAGCcbeBQ9VcIWaackTJ5DsEwAhi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150728; c=relaxed/simple;
	bh=kNGEByGE+qEW+7w8ETycLku91mpx8/lbsdMWYzNVGPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKy1VXWMvPQ2VrXbetWrUZVqteU8xXnN1s257e0ecAKdxCO2F6GI+sjZv4AdXkNXGPZp6Qm5nx2kJ/zDTzNffQr9aIuv2UjHZtk5gaugj0Z+pr36HCJ4CfPbL0JYlvjaPmyUlevjE1cf/Bw2TitH9q2q+ykT8kldU9sgwf7AcNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BGie7Tlb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BGie7Tlb"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L7WjY7024969;
	Fri, 21 Feb 2025 15:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9uQ6cKznnLOXQC52YlsGF//+EDe/mB
	hAHFCZ7hcp9Rk=; b=BGie7TlbuuYHHbcgegES3qzLfSrBqfjFzDhu1tQoyTJn2Q
	5C2dnzVKjaqtnNc8tLR9nZB29Q/0mv62a/zm2G+i5gMLgDIZvFW/Hob/e5apwHET
	0E7zRgdcqo8SX4VwOKUHNxpTWSGdkODVb7dJDX7sPM1c5ujgyJp86Vywp/NW10Jg
	HPPhn0ns6CkVLdAZjnB2VEnAPayxomb4crXahiFeF6+SNW9WBz7IYuftdFqbOYez
	+H/AjmurDus2fiLH3OTTyEOeRT3+noRMIuGGZ03Z+f8d3I+E3eubxYEr0uct/3Sl
	qCqbnSpxSqAfBGFEakP8pc4h0OKI8XIUPqC3HI0A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xn6q26jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 15:12:05 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51LF8Qfo024139;
	Fri, 21 Feb 2025 15:12:04 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xn6q26jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 15:12:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51LF4b1V029794;
	Fri, 21 Feb 2025 15:12:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w024rnmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 15:12:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51LFBxEf55378298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 15:11:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39F3F20043;
	Fri, 21 Feb 2025 15:11:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA4C920040;
	Fri, 21 Feb 2025 15:11:58 +0000 (GMT)
Received: from osiris (unknown [9.179.14.8])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 21 Feb 2025 15:11:58 +0000 (GMT)
Date: Fri, 21 Feb 2025 16:11:57 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, schwidefsky@de.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] s390/sclp: Add check for get_zeroed_page()
Message-ID: <20250221151157.11661C33-hca@linux.ibm.com>
References: <20250218025216.2421548-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218025216.2421548-1-haoxiang_li2024@163.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rSwWCoUOcBwueBe9atg0vqQkBGTKsQBn
X-Proofpoint-ORIG-GUID: 0XW7OhJ5hL4UgGj1FfIQ9uk2EuR26tR4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=495 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210108

On Tue, Feb 18, 2025 at 10:52:16AM +0800, Haoxiang Li wrote:
> Add check for the return value of get_zeroed_page() in
> sclp_console_init() to prevent null pointer dereference.
> Furthermore, to solve the memory leak caused by the loop
> allocation, add a free helper to do the free job.
> 
> Fixes: 4c8f4794b61e ("[S390] sclp console: convert from bootmem to slab")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
> - Add a free helper to solve the memory leak caused by loop allocation.
> - Thanks Heiko! I realized that v1 patch overlooked a potential memory leak.
> After consideration, I choose to do the full exercise. I noticed a similar
> handling in [1], following that handling I submit this v2 patch. Thanks again!
> 
> Reference link:
> [1]https://github.com/torvalds/linux/blob/master/drivers/s390/char/sclp_vt220.c#L699
> ---
>  drivers/s390/char/sclp_con.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Ok, but this should come without Fixes and Cc stable, since in real life this
code will never be executed. It is just to make the code look saner, and to
avoid that more people look into this in the future.

Acked-by: Heiko Carstens <hca@linux.ibm.com>

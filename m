Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732293F9F4C;
	Fri,  7 Aug 2026 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099005; cv=none; b=pXaDvk8Nz5zvZ27m8Kw0K6mfpXrnTMvj1nxz1XpvnbM4zvRIHTP8URXfhmHOtFO1/GeiF5dMo+nCNgVxkakRFrpxFtFFKFP4vHU6kW4QHwD7rjiq3NrRS7duSEkBYrP3vYdObeFi2VjUotx0GTA/ZhWgB8Yr/6+Dyukg4vLxr28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099005; c=relaxed/simple;
	bh=fZSepynMSfhg/UW7+zs8f4c5ysY/w1bG+cqjCoYshiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaQ+yp9SYxsJUji4tcWw7RytGwqr6Pr1QRXOhdvtFrrvvtRJbxlsl8CqE0qEuRmLzxJegkX9frQ2Ax6vvVZ19RW1pNeZYrD/6P58f35TdjARd+uKR1K29dpwOXaqOxN4upXgTyEeI+8gpD8l+bw+xX1BoXnp2qiiThmLyIbLnew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZUWDmi8a; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZUWDmi8a"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770I8hF016847;
	Fri, 7 Aug 2026 10:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a+sNCy
	8MawgziSC44WDw2zaNUimiq9lpeYdB5P5c8xM=; b=ZUWDmi8auLrWyEYaEjKOAw
	oEVcMR+D98lMYPDfRyNgRyANURcduN/3RqEQYceEYwbiGkZX8+n8aHODBnDGgkmW
	VP5qLvDkhsX0Pp7czHhNq2TEcSih69yAQfthtEup3iUR8ty9lLf9h57JiOVQ6W/O
	79GK4WQklMC+PLIzviF/0qTKLmew3s3IV4XwizmMQsGqZSIOcAsCMkvOtxOQO/5S
	3nGE0vBbsF/8y5Fw/XT+1mn7mBLpbWtfdaVohbAHy/1CWj1CfsM6v+kXudbxH5Oz
	3c8EIkiXOOk6tiAgg4+bei8gY0VN7qtqwmOImsrWjVZq4QNydNUKsebjuzWW3weQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy00bb6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:36:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677AQFGW016593;
	Fri, 7 Aug 2026 10:36:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qye4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:36:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677AaXMh35258848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 10:36:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0021D20040;
	Fri,  7 Aug 2026 10:36:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A189F2004B;
	Fri,  7 Aug 2026 10:36:32 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 10:36:32 +0000 (GMT)
Message-ID: <3a579ade-9504-4905-a5d7-a49ba17c0686@linux.ibm.com>
Date: Fri, 7 Aug 2026 12:36:32 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] KVM: s390: vsie: Convert shift to phys_to_pfn()
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
 <20260807-vsie-cleanup-202607-v1-3-b18659b55e3d@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260807-vsie-cleanup-202607-v1-3-b18659b55e3d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3OCBTYWx0ZWRfXwISIwx3/f/ah
 SwQGUdHaWlSUH9Ce0G2c2CWiDWTAQ382pIMvEAgQ9r4zqpb1X+iddwMTkU6Vx7J6esj1BIZpleK
 ukOcU23h3eO6gLa1i3FXA7jarI8Pbg4=
X-Authority-Analysis: v=2.4 cv=VPTtWdPX c=1 sm=1 tr=0 ts=6a75b536 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=-kc_aGEoAbnUMTnETNQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RQhjHG9mMoz6aeRsoXIPT5dBSYMEEcnA
X-Proofpoint-GUID: RQhjHG9mMoz6aeRsoXIPT5dBSYMEEcnA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3OCBTYWx0ZWRfXwb7L3BYSyf6A
 ehEEksVTgb5XR8MaIuhRvUJmtIk1rUYXC61bah5jP8KqoXB7ae5pWg17HZA6XmTiMFfpeGtSDVR
 sP74UX0fKXCC/i/y5LNuQSOqQfpyQWXogcWDt4YmsT7Kd6boI9M8zpj90zbeSGuOgq+8fDPSnJy
 WQIluIhGb9HTcg760nj9zWBjjoZiFdgcwwP3Z2KJGmqJVNrOybZ/On67Yqm6yGhvT9dGyTzQyJr
 KvT3r3UySHy30HF6A56KoBccjaPo/8Z4aX4Hcp6ZeWn+ENw1NoL1I41hwq1vOeQi8bioqOh+cCE
 bso0cAyDIC78jHZzgz0IX32xYz4qs/LFZ4B4Ty9I3nR8j+R2bNPGlsC5erirQ5Cv9tqAG189WIO
 ggEZWtq3Gq8weV7xinH0Sfc3yBhtsxETd9MKIYDN6eNvzu8Ypisatzav+sQA4TsJ5IflEhGDjAf
 9CzmsB1PnaAbp7Ndd3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070078



Am 07.08.26 um 11:57 schrieb Christoph Schlameuss:
> Make the code slightly more readable.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/vsie.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 3e956c7faa4b..937f9c99bc00 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -701,7 +701,7 @@ static int pin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t *hpa)
>   /* Unpins a page previously pinned via pin_guest_page, marking it as dirty. */
>   static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
>   {
> -	kvm_release_page_dirty(pfn_to_page(hpa >> PAGE_SHIFT));
> +	kvm_release_page_dirty(pfn_to_page(phys_to_pfn(hpa)));
>   	/* mark the page always as dirty for migration */
>   	mark_page_dirty(kvm, gpa_to_gfn(gpa));
>   }
> 


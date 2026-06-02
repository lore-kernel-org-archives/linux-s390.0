Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3113DB960;
	Tue,  2 Jun 2026 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400018; cv=none; b=ccTQaMU2Yg10plfL+WymmGddGp5CEB/xx14n8TGCD3720UE37xt9p2BgbQSxwk4YEGEXAmisRiPv8mF2kdXxSU5ZY9THLbADIfkzYoqf5zz+bW0ZnoYVUN5aTI5goXUjnS9dZELY7pdU/3S9dmtIGRiOrudQptIP/m1gfCtgPGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400018; c=relaxed/simple;
	bh=ZSOSOefp5XBWSn6xmKBFRGUqGH4RLcYKgiCgvFKGXYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQnAlLeKMqmutzvRY+UOzqvHZ/jJf2EXO0S5iK7cbpWgQVkuIfgMHN8kt6Pxn03sWRCUTNBbqRDahjlqrT2LiiGKgSsYo9/Ro1C95TIxN4O5YoGN7Navbv7vCSwcWh9m3+XrNL4jjieZD6La12E3KKYlbRL1QCf9qGqudXyEx/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JDVRboUW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JDVRboUW"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6528S6UE2708324;
	Tue, 2 Jun 2026 11:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=KuNyu1ZV4ifO26Q7EhRPM0CTh9aTcY
	ScWvH4q1rDqMw=; b=JDVRboUWJZaagYRxgG9c2GwgMSE3rS3ad544Q4+dDoOoBq
	7dVdQQeN9DwjikneSEZEdMKR3x6hQGJAZ4MWIpQFEbSxgRYQHcQcH0DD/E/9wxpB
	U31toumArxDAiJzZy2ORsb7v4iIUMEIKQrJIrKzYS3SPF6oHjMN057zc902hxLEA
	5N09Znky7jGVFFxe8tmNSTvGU6W4jRkoLyvcu4EdNfzMvbKqFhNKdoX5bQrRCglV
	ehJyja/lel/qPN8zEexYUK1uAL2Ew7X3dfEXNcn20umF3KMIAefWQfRI86oLHkuG
	cNSTyPWN/HWMfa5m50t75xkJ4YEUoXZGiWYTowzQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahndsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 11:33:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652BO5M9012772;
	Tue, 2 Jun 2026 11:33:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qb6kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 11:33:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652BXVpO52625742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 11:33:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09EC920043;
	Tue,  2 Jun 2026 11:33:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81DD520040;
	Tue,  2 Jun 2026 11:33:30 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.22.2])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  2 Jun 2026 11:33:30 +0000 (GMT)
Date: Tue, 2 Jun 2026 13:33:29 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 3/7] s390/percpu: Use new percpu code section for
 arch_this_cpu_add()
Message-ID: <796d70eb-05ba-460f-931a-8e125a441a27-agordeev@linux.ibm.com>
References: <20260526055702.1429061-1-hca@linux.ibm.com>
 <20260526055702.1429061-4-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526055702.1429061-4-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEwNiBTYWx0ZWRfX1c6pR1J7JV48
 4MWDCZz13PdEqb3MukR7NgYfJ5me18p7t1WoqMkE3NHBtvWZvLx5x74KPHviN3+cXHrjbT8dl+0
 x91aZUyMK8LdmDHvql0nS7c3Z/q6vq7bKx01iSQ4lTYFyQDdhuryhZojwpCKadFlOPZhnaRhdlj
 HnU5L+ScbnNfmwX1cGcJVahfQAgsr/98mlZIzvI9ji8Dj9ix6h/crWPW0vVBDusnjhBZRMLRafd
 nEJsYZDAxWGEHNFunkNESkVfkTc8yG6TQoXAWtT6PLVg3WlehoesyA7EJNA8IHcvUrLX6bYUIbS
 wR1XRRjE1yC4QWhhyosD3xl1Xm4j+5rKPmNRfggAqN7op9yWwr8ipGpEGpMoAfTEESybJ2A/p8r
 Cb34iIaOyjCfXd3z770OARlD5EN+6HV69WN1udcFJptqRZDOGTEm4F7w6c+AGZ/dsFQPFYYzrJq
 V47c/41VAvtdDboo+mQ==
X-Proofpoint-ORIG-GUID: -js6YQ3SpbD3CnAQoMjgKycYUX6euwDd
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1ebf8f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=EnoTB24x4siXizMxxzYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: -js6YQ3SpbD3CnAQoMjgKycYUX6euwDd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020106

On Tue, May 26, 2026 at 07:56:58AM +0200, Heiko Carstens wrote:
> Convert arch_this_cpu_add() to make use of the new percpu code section
> infrastructure.
> 
> With this the text size of the kernel image is reduced by ~76kb
> (defconfig). Also more than 5300 generated preempt_schedule_notrace()
> function calls within the kernel image (modules not counted) are removed.
> 
> With:
> 
> DEFINE_PER_CPU(long, foo);
> void bar(long a) { this_cpu_add(foo, a); }
> 
> Old arch_this_cpu_add() looks like this:
> 
> 00000000000000c0 <bar>:
>   c0:   c0 04 00 00 00 00       jgnop   c0 <bar>
>   c6:   eb 01 03 a8 00 6a       asi     936,1
>   cc:   c4 18 00 00 00 00       lgrl    %r1,cc <bar+0xc>
>                         ce: R_390_GOTENT        foo+0x2
>   d2:   e3 10 03 b8 00 08       ag      %r1,952
>   d8:   eb 22 10 00 00 e8       laag    %r2,%r2,0(%r1)
>   de:   eb ff 03 a8 00 6e       alsi    936,-1
>   e4:   a7 a4 00 05             jhe     ee <bar+0x2e>
>   e8:   c0 f4 00 00 00 00       jg      e8 <bar+0x28>
>                         ea: R_390_PC32DBL       __s390_indirect_jump_r14+0x2
>   ee:   c0 f4 00 00 00 00       jg      ee <bar+0x2e>
>                         f0: R_390_PLT32DBL      preempt_schedule_notrace+0x2
> 
> New arch_this_cpu_add() looks like this:
> 
> 00000000000000c0 <bar>:
>   c0:   c0 04 00 00 00 00       jgnop   c0 <bar>
>   c6:   c4 38 00 00 00 00       lgrl    %r3,c6 <bar+0x6>
>                         c8: R_390_GOTENT        foo+0x2
>   cc:   b9 04 00 43             lgr     %r4,%r3
>   d0:   eb 00 43 c0 00 52       mviy    960(%r0),4
>   d6:   e3 40 03 b8 00 08       ag      %r4,952
>   dc:   eb 52 40 00 00 e8       laag    %r5,%r2,0(%r4)
>   e2:   eb 00 03 c0 00 52       mviy    960,0
>   e8:   c0 f4 00 00 00 00       jg      e8 <bar+0x28>
>                         ea: R_390_PC32DBL       __s390_indirect_jump_r14+0x2
> 
> Note that the conditional function call is removed.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/percpu.h | 65 ++++++++++++++++++++++------------
>  1 file changed, 43 insertions(+), 22 deletions(-)

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

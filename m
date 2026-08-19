Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B39C27A47F;
	Wed, 19 Aug 2026 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787177669; cv=none; b=fvzjTMYdkPqSqw30TMAX6fJTl8s2gkj8JSwisVsid9rSPi20y09VjXMiVxXVl3WOOjvnau1lHknA+RM2xJ4jzuKjUJBtacRanLhJDDR2ckjrLKARiz6GG6Ht+I0Z0N+YwpXxhPaGzaqftkBb4lwYL4G59Wx51WJHAq8E/x5JNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787177669; c=relaxed/simple;
	bh=X7N0jP/4Zo0fuBcNYaPsv3rzAZmRBC9xYf7+1ItNJs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgHBVXWLEppHuCbcpydjHoiL8LYU6Kttz27/lz9jfC23Q0mB8e4pE6HfA7ujIyfJhCKSG6P/s6mXauc9mK46D+SeeLxXnWRSCXRPrZwOxv1Hi8mLVCFTtqUS5uuFc8HcPBbQ88N7FDtDjeUXAyooa9mU8GDx6jKyAUsLpfGYu1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=An0CTbzy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="An0CTbzy"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JLVevP2794857;
	Wed, 19 Aug 2026 22:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=M0+9eJi8trhXUB+Swi3LsPp0hqiqZu
	dk+XeoUhViuKo=; b=An0CTbzyONnhrvK/IcXo8gFU8bt0ziAaOxfBqZ5ePwC7Up
	EA88xU05oJ5yFBLRt7sO4Jf8sngIk8mOuT8stC/lUsAnmNtd4YMFHawfDsXoxst7
	1znk2QfZAK5ZceDlUcUenlIwszBuk4gWISJbbfdt3He9dcozFmC5qWLz/33H46Ox
	eqpulXRsdPa5hFYzxLYmztEWUExbYVjY8bvxVelLnmak6ctssRce+QV+gKiOjFH2
	PZa1LXsAULK+tTF04Dau/CBNMomlMLbaOwHM8rlganXwc76R9h1q9F0fwTj4hort
	4brS3mG2w3Nn78LZkulD6D557RlPW8XcS4/iGrlg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu06fwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 22:14:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JMBJYK011551;
	Wed, 19 Aug 2026 22:14:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twb8p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 22:14:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JMEMkI49414540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 22:14:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E65320076;
	Wed, 19 Aug 2026 22:14:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC7B220075;
	Wed, 19 Aug 2026 22:14:21 +0000 (GMT)
Received: from localhost (unknown [9.111.46.147])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 19 Aug 2026 22:14:21 +0000 (GMT)
Date: Thu, 20 Aug 2026 00:14:20 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] s390/cpacf: Unpoison instruction results
Message-ID: <ttk1f3w@ub.hpns>
References: <20260814121559.1240939-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814121559.1240939-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1oVJ2675mdEXZeM-If5477Wlc546x54n
X-Proofpoint-GUID: 1oVJ2675mdEXZeM-If5477Wlc546x54n
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a862ac3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=a_y6WA_M5nSlKu-xcuEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDE3MCBTYWx0ZWRfX48HMOA3VGtfY
 3FvB3OEJ+VTaf6XEOP1cl2AOBq5Hm4hX0MrVxzz5VMmOl0SHCOMaTUDuvF3fI6m5MBdLePagrCJ
 GGKZmY9EL4AvcHHPitMPUwrJwLj0kRk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDE3MCBTYWx0ZWRfX1MR77CtorS+G
 QTHDp4wQKmAq/KswP1xnBFbwcKox5byanM4q+CuFL+MkJ8col+JAhOm06o5kl+YRHjXx7EirWIf
 1DrLxnsIIVRVD0QmiPYwHZCtFIVwnZK0KzC6ibYlXHZNEdIZTFNNSyIDDpoAkh9+PKgbbhc6MpB
 4tvXCxN4LcKlowSpj+ek+Wr4yEFj+AXzgI1H/a9Oxan5OgxmL7mMmsAFRVgd7KAWzCfNoKNigME
 reOPf0tBLLZBxbp2lSEqWgHc5fMZmmOruDLg/xKfbJsIWptHwXgqb4wHF+/nc+ROvVdNA4TmfYJ
 YJOCH0oqBjpN4fv0x0uxk81tqSn8HBYwHhRWRAuWK21qC4qjJ2gEnpoRtMsog+dlewZ9pSiei1p
 bolzc4JI89TgT/PbNTKEHn2MnsWBhIBUZ3rpIEDohb5kIvkAY4xwInArL4vCdT7AYjWU34kldW3
 CW/lh5eemWhTjgQl5ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190170

On Fri, Aug 14, 2026 at 02:15:25PM +0200, Ilya Leoshkevich wrote:
> Stop KMSAN from complaining about CPACF outputs being uninitialized.
> 
> Do not unpoison variable-length parameter blocks: mapping function
> codes (like CPACF_KIMD_SHA_256) to lengths will be ugly. So let the
> callers do this once the need arises.
> 
> Also do not touch cpacf_kma(): this wrapper does not handle cc 1 and
> cc2 at the moment and has to be reworked.
> 
> Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> 
> v2: https://lore.kernel.org/all/20260807122132.3592583-1-iii@linux.ibm.com/
> v2 -> v3: Drop cpacf_kma() change, add R-b (Harald).
> 
> v1: https://lore.kernel.org/linux-s390/20260806190223.3292580-1-iii@linux.ibm.com/
> v1 -> v2: Unpoison outputs of more instructions (Sashiko).
> 
>  arch/s390/include/asm/cpacf.h | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied, thank you!

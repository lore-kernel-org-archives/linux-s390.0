Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CACC360EDC
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037696; cv=none; b=JaUayrTDrX6FeXkdovyUKiI+4Ppwac5NqSQySXaep9E6uHMdGrAsimDcZieGIUKRI/3Dg7+9AwTj90HjVATgdfVzS8HXZ5zTPCCYBoPYYvg6KVw54lc+gCPGDCrgm3kIow4/rsjVsKZJ3TSUvzvy6HL7Hx2O0uYda69b+h4bL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037696; c=relaxed/simple;
	bh=tFwMuNx/qlTY1je9eRvr73xLQM/tX/hXq6vOWxvYYa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pemyHgv4Gf2+1dClInJGTIcFsnJmB35Ts3JYe8O+3Tfj+WKbD6cLczt0MqAF7WGCSY1xK8bUg7xOgXIQ93VpIl2ncYBZtXHM/+/NlbgOmGtDCVOlFK1Sg0HuUhLnP2vziiWctoO9SI2dvfga+31OKGzb9V4AdBmTQK/kFuEglUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZvhztyZg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZvhztyZg"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676HII9k3291286
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 17:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nNOMnJ
	iZYuxzvlSL3I/emomPjwt5OuPJGTJd5GHIg/A=; b=ZvhztyZgqTSaLf1DIdTkCG
	83O1iVfj6oZKdeU4B2eSCzun/kIbtEXw0R0ttQnDPj+bf3y7a6X01Quck3j82zpY
	aCcarvNJiAInmTajy8/z2lwmQz8tMakRi0SvlSKgytfLbuAz1NMpnE/66/VkJ6e+
	AmvNqCik1Zyr1zyPPv92ZXHHYywFUYjwYFtRdtlnKMwJaJefbD8nWw9IJIM75sMf
	ili8djsdyGgDihSXUgQssUDDVofLHJ2XhnPn7e+co9sEFtwWe+z3ce871aV3xflB
	qy4N0/WRrKTd8+NjdXDTTQj+biDe7sGX3jhN7zTxoPuRszEfO8uPZ1mAvhK8dWCg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h59mvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 17:34:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676HQj6x000847
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 17:34:52 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qvbtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 17:34:52 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676HYp7Y33292994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 17:34:51 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57BA058054;
	Thu,  6 Aug 2026 17:34:51 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C8945805D;
	Thu,  6 Aug 2026 17:34:50 +0000 (GMT)
Received: from [9.61.13.162] (unknown [9.61.13.162])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 17:34:50 +0000 (GMT)
Message-ID: <486d40b5-8550-40f4-9154-9936d655c1f1@linux.ibm.com>
Date: Thu, 6 Aug 2026 13:34:49 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] s390/vfio_ccw: Add __must_hold() attribute to
 vfio_ccw_sch_quiesce()
To: Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Eric Farman
 <farman@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
References: <20260806153849.2622576-1-hca@linux.ibm.com>
 <20260806153849.2622576-2-hca@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260806153849.2622576-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfX2ObQLE92ZJwo
 FyGQ7uRKeZTdWaZc5uZUJ/xR45WOe3d7e2u4ciyKrow4Nk+rVwA3F5bgWQOY8kFUM/3u/H0sLjR
 0UGOYwf5FinJH0cUa3g8KN2zj0TPQsg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfX8XRKaRtjz6wg
 FibsenWduLzHyVWAz2JcmzErb35xOl0lHXN8Wgjw0rsFe8Uf4ulYa6YwF3pp2qqR9rwOUA26Ncx
 VfXKN1Lt4JOOYbeOuh19vphay/FH7PUBoCkQqdU+PWZAKrcIhR/e5jTvxyZ6SpfgIyc3L2u+Lqr
 7agtFlWBjcyJURVTPRdTM49Y35DNRnJTJfrSLGoa2Q0XVJ2N13Ex8SX534O0Z6Cp6PMpqMqa01e
 DgCvDBQUK+VFpW5yLrbOhlgwhIJXsXgOu/E7dW8uZGaf3OZYbJ0EMq/wwwwSgCxq7rI0cvqUTuG
 KXRCxcFjwUdwlvR1hFYURC+m9G1RzblnkNUrUxmFnCcFeNjMb83YekNk96BtqP4bvRVYgCr2Ba/
 HqkMyB2ZG3V3QM5w6xIxAEZcx9XuToLLb7Kp+9eelvatqZHPrmCc4KgMKKKfUBaSfz6HFwxSxsg
 i96ncOQVE6i+/7Bq90w==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a74c5bd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=6g99gK50qwVVK1rWCPkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xQHsKpL8YYAa57wyVUIS-TgOOkIVDmLC
X-Proofpoint-GUID: xQHsKpL8YYAa57wyVUIS-TgOOkIVDmLC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060135

On 8/6/26 11:38 AM, Heiko Carstens wrote:
> Add __must_hold() attribute to vfio_ccw_sch_quiesce() in order to let
> clang's context analysis know that sch->lock must be held on function
> entry. This can also be easily verified when inspecting the function.
> 
> Without this annotation this leads to a valid warning when context
> analysis is enabled:
> 
> drivers/s390/cio/vfio_ccw_drv.c:55:9: warning:
>   expecting spinlock 'sch->lock' to be held at start of each loop [-Wthread-safety-analysis]
>    55 |                 ret = cio_cancel_halt_clear(sch, &iretry);
>       |                       ^
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



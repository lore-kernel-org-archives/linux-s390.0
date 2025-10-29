Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A33A37A3B7;
	Wed, 29 Oct 2025 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743544; cv=none; b=f7lnh8WV7MtBlIuAVqCTPmxrxm5BfB3v9FLKEkldAr6eyCPPqQ2IM+pEWUE4N21I+mx+mAjFDwXxbF3ydooXY7zi2o0klOenHPBNGhZ3XPZ9XfqKbXs9YNDgvx14+C8KW/1j/NJDQ/BEf1TeFEzqAmFmNv74tJTVvk0gdJ91aLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743544; c=relaxed/simple;
	bh=TYJkcOALBxjsXUbWaAeKcMNV0tf9iTo/7NmOceLJ6r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK1KzMyAKvAMPdFdjimjnmpOekt0N3+UraaJhzPoyO2XqQGwKBvEta+k6yL95vp+HB7JUqfbsk9tdKZF6HF0w29xqPzvPwsR/LUKcWENow90bIr2YQsaLF9+Kaum0dLaRf/CP4JDEwYdNTUeo6cuf6V/ynAB2RgxkktmnuKIFhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hsH6Asd7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hsH6Asd7"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TBVEoN025859;
	Wed, 29 Oct 2025 13:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ZYj+NL9hk37WZoRMnIL6BdmCdQOyG5
	1B39ht5wtBTf4=; b=hsH6Asd7ZHXHVj3d2R2QBikrkI778mfwrEQmTbu78DZdNj
	e2J30x2un0PviV5PT8C1a6z/ENoiJNLzQFyd6JoUB3sjF33otQCV4rFKLg/zz+2p
	D1+m3MRu+Htg5Xh+aSEdTZ7G5BljUpPL3wVm/wstBickh4bSx+TBoZMKVZxgRyVr
	cjO7/j3K3MDOcI/rR67dLsj/TOMHqQzhPK8V+NhPto08+NQifTjv+1E2D3/FhXOw
	FAXMot9mAJYSF1HhLbR98qoIPX4XHaxLb4SSMhaezvKairX6BM4aEdmJPpy8q19J
	6uXXWWx0p5ckgYrporSJ5GrpmIt5fqyJu/ZETl2A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34ackcsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 13:12:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59TA1mKd019510;
	Wed, 29 Oct 2025 13:12:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xy3dd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 13:12:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59TDCFLC61342192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 13:12:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E74120043;
	Wed, 29 Oct 2025 13:12:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65DB220040;
	Wed, 29 Oct 2025 13:12:15 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Oct 2025 13:12:15 +0000 (GMT)
Date: Wed, 29 Oct 2025 14:12:13 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Bo Liu <liubo03@inspur.com>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Fix double word in comments
Message-ID: <20251029131213.8393Dd6-hca@linux.ibm.com>
References: <20251029071951.17817-1-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029071951.17817-1-liubo03@inspur.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XbuEDY55 c=1 sm=1 tr=0 ts=690212b4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=F_93P0QhAAAA:8 a=dtOSQXRi-letdizDAyMA:9 a=CjuIK1q_8ugA:10
 a=v2fne3mUlQEKA94IZ0Od:22
X-Proofpoint-ORIG-GUID: EkiMZZHdauybTKVWWEKdswg6iyUc2ZGI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfXyIlrVUsZk4x4
 0VjcAIFUAStjRoTChOUSpAZ0xzlNQn5kuxOH5JdleuUWXc7iWcPsx4zCNqtdsCVoLM6Bicl+15d
 YH/unbmyyVekpK4ysnLUpTt6+X6piKRueV9YOpzH5M8Vp0684IhoXdxhLwAvnOGn1whEa2jpj38
 r0+nttMyYhxgD7IxwWFPQfcsDy0Qhit4bZ5kJyIz45cA8Gt4GokS2eZEpHmawokk9KlZTfGcsCJ
 smV1pB3Yvz8YNH4EkMQIy+gh1jXupVtnS8Y2QWRh44rdAyrWHIGZKbDBaCOTQwH9ysLH7UPwBLK
 g8wGxOyttFW8cgOk/ChZn23U2zzYVsfROFoAESTDqjULbVk4gi8A7nF273jF/PYUXSqqpGtxmiu
 5MT13t/bIIa/WUd7P/lPlTzUe5ZNpQ==
X-Proofpoint-GUID: EkiMZZHdauybTKVWWEKdswg6iyUc2ZGI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

On Wed, Oct 29, 2025 at 03:19:51PM +0800, Bo Liu wrote:
> Remove the repeated word "the" in comments.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  arch/s390/kernel/perf_cpum_sf.c | 2 +-
>  arch/s390/kernel/sthyi.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

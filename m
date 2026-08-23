Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431E330C157;
	Sun, 23 Aug 2026 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787520200; cv=none; b=Y60018yaYbB8EyQxgbdbo/XpVEFQw0MsdJ8vNLwtxocZOqK7zeXi3+vg8zVNJR8gU4fW5kR4dU3XSMaRdw6LRJcSRovdmnQ+z/zsK+PvMz8dKHGdGuIad6PySP95jpbppt775jaiWdAncQo/4IKzcyDlIEGbddPNXjI2YGHOWZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787520200; c=relaxed/simple;
	bh=QeWLowqB5eqYCSOyh6FIKcTOm+Izghm6GiuP1+dyv9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9N3VrqlA+9Q0yDPHQmbAc1BFTsHlD+5LKcFt7nwCy1D8OnuFC7wZZ4M1St4J3d2K/fpV1chW99Y3+yaLTER/YOofbTJfqbnFKoE+fD3uYSfvBuOoV2abX9UC2YpZRHh9FItkyUwox5CancrQN7HLB8w+9Xp331OldnprDr84zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cg7nxy7Z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cg7nxy7Z"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67NGVcNR3598566;
	Sun, 23 Aug 2026 21:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=N0TF+J
	bfRsqXJ/VS6bhvVUlzV41SHGDzcb5hzOfd6/4=; b=cg7nxy7ZZKpbdNO0WLSEbL
	SF9A00Yj7JMp49xuzMsNmOAUQ3CyLeUqnnbzQJa3h2E8YQUexcq5G6NuKtBlVbHy
	6XU9FiGOTkRYUpVpajIYDtvGx4TLNYl+aHJ0RKqBGyBCExGHuXcAxSH2izrK9zkk
	+mbezic2tB9umazj3UuIy7SGPP9P5Rj6FglHz/EdjdMr682/8vpIYNbE++jn/CAw
	UCYKdXSPKDTQZ/lNhReYfAeMsJD7xk4l+sPO85KIdTAHXR+5/YIqDPQJdL12+YJs
	0qWkXjZKwY55d4DxtzfhO+US5LNyMG2xD4R68kbEMIzMnWjNRwZ9g9xhCranJiEQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4ds2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Aug 2026 21:23:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67NLBICL021123;
	Sun, 23 Aug 2026 21:23:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3pttwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Aug 2026 21:23:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67NLNBdE41681342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Aug 2026 21:23:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3898D20043;
	Sun, 23 Aug 2026 21:23:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D291B20040;
	Sun, 23 Aug 2026 21:23:10 +0000 (GMT)
Received: from localhost (unknown [9.111.46.147])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 23 Aug 2026 21:23:10 +0000 (GMT)
Date: Sun, 23 Aug 2026 23:23:09 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Subject: Re: [PATCH v2] s390/ap: Drop unused member from ap_device_id
Message-ID: <ttk8rel@ub.hpns>
References: <20260806155757.1281233-2-u.kleine-koenig@baylibre.com>
 <55aa5d3b5b1794b5fca7f3ae75b48dcefa09e808.1786033091.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55aa5d3b5b1794b5fca7f3ae75b48dcefa09e808.1786033091.git.ukleinek@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Wk8gPSjPPJ3wheTXG_MiOEfVtFcNy8Dt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDE5MyBTYWx0ZWRfX2t8E6gjgmhh+
 dJJHz3Gi9Uq4urPieSBuVYpOOxsr0+CWFb45tcPK/kxK8wr58fnUkMTYqpPEtmZ9XLGuNHohlE8
 RNjf6xBGPritmysTtIJcsK6j2NZrkM4=
X-Proofpoint-GUID: Wk8gPSjPPJ3wheTXG_MiOEfVtFcNy8Dt
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8b64c3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=IpJZQVW2AAAA:8
 a=FtDqHc4jcwyDe3_RgA0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDE5MyBTYWx0ZWRfX9mJN32QX7i+X
 WDDXW4+wpFBSKXFZ9a8vb806Jyv+rYet9Wb2mmx4SMiij8G2Xaf2PptPiP4Tl6AbNl2DHZDY4pc
 f0gW+Zsan+VHKcLD8i8F30SbrgFXvMV2uK9/rW73QKYDkypWQHpkKWeLLHIIAEXf4mZ1j7gjVwz
 Jjkv0HzMBcChFjY4kUMN871g/W9DcTzb42IIIYsoaLjbQF3TpMVSqvOJQk9Vn5YkgDU2wr7nsiB
 Q24wUGThZW5NSQoS5yguv0XuaGQVENBNL3qQteBqoey5QstsWwiFwXmN31RtiwbNfCAjyJDskZh
 IVps+D+tU9HekSdj57pxsjzjm3TAuqV0A2EcPTiv3OdF7ZquIS0paRLBMTVLgQ9oTvO8iI5HF3y
 pcYa3ADg9BG5flDonRCZ85fuLwDfcakrHX9im+ub5zQUlenQEm+pg/xUzbd6PygWlfQV4IbFzic
 88QApfF7ydzH9bw7DzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608230193

On Thu, Aug 06, 2026 at 06:21:19PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> ap_device_id::driver_info is not used in the kernel. The structure is
> also not part of API/ABI, so the unused member can just be dropped.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> Sashiko was quick to identify two issues in my patch. Before someone
> gets around to review v1 by hand, here is a v2 addressing Sashiko's
> concerns:
> 
>  - remove the typedef for kernel_ulong_t
>  - s/device_info/driver_info/ in the commit log
> 
> Thanks
> Uwe
> 
>  include/linux/device-id/ap.h | 2 --
>  1 file changed, 2 deletions(-)

Applied, thank you!

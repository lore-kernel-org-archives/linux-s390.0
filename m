Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F6A3BB693
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139196; cv=none; b=p39J+PbVn1BKcJWAmj8jkbc3rTMLrPbeBTmxSis3fXQHCXUZEjKSQTJCI25xG4vVaRgAhd8EN7z/Q3PzjGAtX6pL5KfhVuxEw/lVu2Z83IWVo5uem831El3PtOZi4fwDym2d88inOWvskaiA8gmxm+gfXnnuUTSFSJhCu+H3Rl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139196; c=relaxed/simple;
	bh=a7bSks4STh2UuFMKfXv1iu3ioFBP4eJB8KHxg08ysjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbVsX7Szz5P14S5LZ9hDJzIkB6H2s2l6su35vsfth9sdpzQctvjcML1bRovUA1J/cbeyv7/5DEqbHO14cZl9XPSr9+MdKX9BChqM3J4e30R2zN+HNmYDC0Fs1mP7E2Z1t8UKoapcDwPcuerWIiXFEf0AHfWcatr21rCDjANs+ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=chS1XcLU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="chS1XcLU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDLY1T2831882
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 14:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=tIlbap3s3hQkpt6OQdXqGtEwywaqoX
	gmmJgT5lA3qJQ=; b=chS1XcLUqdaH5ZhrxiDwr8Yz9/TJvUW2OaXfGzbF5pwoOo
	PyzUllnd0CPe3DaMh1xMNkCUfGgnQQcONWt0vNErEuu1rChP7yukIXybP5zGCseT
	0YLt/A4YAQK00dM+XcnrsTxz6SDjNhSz/WP2yXyYtM9IcMGyaFv+SRAxfB3WrG31
	mnFp5vZFnIsr54COPYmvn+Ti0oHBQFG89kajh9lKkplPZUOaA6ZaVqUj2gFr7tNy
	HvNqjYXfnEt0FXaYD0+CrQdZQC1pnS8JpZhGzJ6Vu8nj4AloFXTt/EBxd/R8GyPt
	4yKdgiX6/FGh8ZOuaIe0iuhBjdUVKxcTTcFzu1eQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hj1p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 14:39:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MEYdZR029516
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 14:39:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56q6vsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 14:39:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MEdn6m43057444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 14:39:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 735CC20043;
	Mon, 22 Jun 2026 14:39:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58DD820040;
	Mon, 22 Jun 2026 14:39:49 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 22 Jun 2026 14:39:49 +0000 (GMT)
Date: Mon, 22 Jun 2026 16:39:48 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2] s390/traps: Add exception statistics
Message-ID: <626ec9fb-52d5-4d46-98bb-f5d46e25bc57-agordeev@linux.ibm.com>
References: <20260617123350.3220729-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617123350.3220729-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 46ZpCZ9-ER7aQ0OXrKvhA8bKhdf072dg
X-Proofpoint-GUID: 46ZpCZ9-ER7aQ0OXrKvhA8bKhdf072dg
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a39493a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=x1FwRNZma1D5Q_qGaIMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0MiBTYWx0ZWRfX6hSX7icHxBAF
 L+XD6s7lYD2apm9VZ0eH0AXaSONDB0ayfB/udp5iVunKq+6SW4mQqdnKWQ0GnD7xaIIZelHQfzc
 QvjYesCY/Qz5DcgHr5FNLDNK3s+sYhbSGRNAuGOJPDUIjSC+pZLwB6OgNMh3bFlqiTea1BTR+oy
 hSHsWPyzBl0v1Ei6uMdhXkI2FVs5LhrL+yUd6mD9Z+EIzVkS2hCOkWWCdDddFCs3swaABeK0OXc
 mYAr7f21OFetWQS3aBwr6ZvEy8arUVEWpqLkQuq6HrfnG0L+IZ+FyqN+nqOO2SnZDgDoKg0lr2p
 PO5rrwQxZ5Yg3NBIyild0f/KOxkDWjZM6NLrav5GOz3jADX617+w1l7g7U5sPpR/yvlX6SKHaz9
 p8bsJAYU8X6exC9FCZ+MA3GwWn4uen/UJIxJbUt5PrhtRdlUWhXRIh15aqKYaICIGH4E7kQcZMJ
 atOfZ6VAGj1vKdp9Ngw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0MiBTYWx0ZWRfX8AE1+/CTWZdX
 46nQb9a3g7TWv2ULmUqzrCy52wJYKd304XEzieY4NgZTO5RUzVveNRUezEGbfyVBHBX5s6eg1sq
 qLjFPykY//tErcJow2rppeArntpj8Hk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220142

On Wed, Jun 17, 2026 at 02:33:50PM +0200, Heiko Carstens wrote:
> From: Sven Schnelle <svens@linux.ibm.com>
> 
> Add a new debugfs file which displays the number of exceptions (program
> checks) per CPU. This is helpful for debugging purposes.
> 
> The statistics are typically available at
> /sys/kernel/debug/s390/exceptions.
> 
> [ hca@linux.ibm.com: Forward ported code, changed file location ]
> 
> Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
...
>  arch/s390/kernel/traps.c | 41 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)

Applied, thanks!

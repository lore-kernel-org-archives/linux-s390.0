Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FFD46EC69
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934916; cv=none; b=LNNxwPqXR/Y7Kz1VjislTbB3Cw1H+NLcjp5hr9yCEjrPQgc2fzmVCluWBa6SKg2cn9jXfOPXEVjdC1d606Q+OgZ4W398Bz1yAGnIHwHevfLNI6m+2Ep2sB7b8CekHdvExfMHybwBbktPLDZnFhASKzvOX1sWgHn58VZRjWXuezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934916; c=relaxed/simple;
	bh=IOajBMhsTHogfSqW7Oy4NnaBsqwEFtb4+KckxLqFefI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFMBK3ZiOgHVz4XZ4iBFf/hOF8NtB65iKoOhk4yIdsMGPqt1vS+IjYgRoH/guzHazMX9oEf2UGDbNslPX55HKBi/WE+0pi8lhiq9nOdyDgrQWiyUrAW9/D1GM6A2xvdnsPxSDlW0sVoTNvC+nqFCb+Ttegg8/dY1mx1jsccCgH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BBR0MzaX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BBR0MzaX"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675CHcUF3725260
	for <linux-s390@vger.kernel.org>; Wed, 5 Aug 2026 13:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=JIcF+FHQa+yMx7/exaNNlXgHdtM8U/
	NnXRZw70fBU40=; b=BBR0MzaXQu5WhP1wGdiU59M399kYCoSnIeJBDcGEIgL6ye
	XTF8es5UGL4r5XH0cUMMw47F138s6t5mlS4VyAfnd/JAh9xIH6gDF8sALTgZjL0E
	PQYN0XbnuTr0LZuWd0io/nlZFJ4Sjq3V4IjRCEKwheaW2I6H3dCKEiF7MBB5SLbB
	5ZAWrwZ9IdM610si1X1mbSlcsXGalRXt1+ICJEbRis+2jVp8wnsNUXhBaU/ShQD1
	PeQk2SQkBDNiAfDhMt436ZfqEA0FapudZiTnIOOFVLPjTosDQ8MKi+OUT9GpmLTA
	rfXsnDKzJqaV/7L5iOBrr+5ymcUSInWM2ZFK+Kjg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67htvrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 05 Aug 2026 13:01:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675CuJBW015778
	for <linux-s390@vger.kernel.org>; Wed, 5 Aug 2026 13:01:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw6qne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 05 Aug 2026 13:01:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675D1nLf36176306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 13:01:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4991220049;
	Wed,  5 Aug 2026 13:01:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B5162004E;
	Wed,  5 Aug 2026 13:01:49 +0000 (GMT)
Received: from localhost (unknown [9.111.52.241])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  5 Aug 2026 13:01:48 +0000 (GMT)
Date: Wed, 5 Aug 2026 15:01:47 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Finn Callies <fcallies@linux.ibm.com>
Cc: hca@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        freude@linux.ibm.com
Subject: Re: [PATCH v2 1/1] s390/ap: Fix MAPML computation
Message-ID: <ttjas6z@ub.hpns>
References: <20260805092928.26932-1-fcallies@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260805092928.26932-1-fcallies@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEwMyBTYWx0ZWRfX5Wf6OhBJZ8Dm
 8E/rUKE9UNU0+3TduElDgc/a3PIbohfyapIAgXSkQPF8n4a4G4KdTKDd2aR4vPXq3IcX9UpR3Ah
 wrYEKNl65xRrc4k69rmxPqZnUExj1iU=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a733441 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=BLOa9BIZQKHUA9siqFMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEwMyBTYWx0ZWRfX9FzgNMIpb7Yf
 oz7P4cgDfy2zFCCScJ1GeS17XYRoq9lTczLh2jjyt6qdv5w3n/OlUkC5h6yr2F1hkt4AgdKnneN
 2u/pJCGc9xXorfH6xzchv0zMoxmVbJc+gb8t7hn7uqtyK2531D796KTqf738g0xElwlQzlMUKbv
 1/NNKuZmtSRvgNKdL+9wSeifJ9RK21oyNJSwi9uuvJbTsN/nyLdNFoF0s4JPpC4uNQi6+juNkEE
 7mBYtEtzJShW3GS3bT7eS+wcO8GxR6/98MPOMao8gp2WwYTYYpFqJas2bKFGMITLZexjwZpc5jm
 v8EE80snSwcPQahPOKDclwledDdruxYXxlldgMIUWXhwxAhS8kw6IgnrYELQToQ6K5Fxi1sbF6s
 gMtsgyKUuIW3QTyoUoqB4R3DjHuSsG2tKXJ1YW7uajs1bsKB/Tu4JQsjQgJUadN8HDilJyyHQ+0
 YqZhahMpXeqZKGLRi+A==
X-Proofpoint-ORIG-GUID: KML1Fdt54kk_JQfL9Hu2e-mn6_TaWQ2P
X-Proofpoint-GUID: KML1Fdt54kk_JQfL9Hu2e-mn6_TaWQ2P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050103

On Wed, Aug 05, 2026 at 11:29:28AM +0200, Finn Callies wrote:
> When the TAPQ subfunction of PQAP returns a value between 0 and 3 in the
> ml field, the Principles of Operation states that the Maximum AP Message
> Length (MAPML) must be 12 KB.
> 
> The previous code incorrectly calculated smaller sizes for ml values 1-2:
> - ml=1: 4 KB instead of 12 KB
> - ml=2: 8 KB instead of 12 KB
> 
> While no current hardware reports ml=1 or ml=2, this fix ensures correct
> behavior for specification compliance and future-proofing.
> 
> The fix ensures all ml values 0-3 correctly use the 12 KB default, with
> only values 4+ using the formula ml * 4096.
> 
> Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
> Signed-off-by: Finn Callies <fcallies@linux.ibm.com>
> ---
>  drivers/s390/crypto/ap_card.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thank you!

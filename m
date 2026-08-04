Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6F913B293
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845473; cv=none; b=H6eUd7CEssz7XcKwrTEMd4V6d9Z86P7pRhsu5IEqlkHCbnIgWnJEk/MrgvmQIQMZJRtYNMVLFlBxpzGQLRXXEdxERt/1KKd2m2yYznzvh6IpzirzOl7NR7RbO6jLOjLXu07Oq3jCBCHTOlZc+ILY5V2vy9+jrXiS0YOzc0hOgtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845473; c=relaxed/simple;
	bh=d7bjyRrx9AkZ5tknRYk3vdpe4cbFPi/z/vT7BTQTg+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsil7Urcb+8I8naZreT9T1SjiqIWrSPzLqRLD9JpSwc5ge9/emIV0RTrxkoQ3LrH1CycgER4PcXpQT0CWGQPIJcK+YsIc9FNF9+KKCm48I0CDkq0dxUjIBmRO8+hpBBih/M4qP7IBhCXJNdvtjsVo7OpA2dwPvMmmbD+4Iy8qUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fVHvQZwi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fVHvQZwi"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748HYRt2640232
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 12:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=z7o22KVF0vEs8RIu0PTxkAUIH/KfOQ
	8dpEthhbrBPH0=; b=fVHvQZwiL4yACALmBkTDUlSLKybhlqyYFF6rTxWk4XBGU7
	yof8CINn4PAzDnK+pDfi/C8lmgYxQNHblxaVnZZ2ARCeAVGKx0/SG5yoHZZeKDVK
	bGn9vQajvJSpXAOZIbML+/FrCRGhprJ7d+IQ50fxmQc7NGEMVkmKSFNszC334wS0
	9AuUFrOOGhcXU1PCWGxhmvfPnZ8X3Rs9f54dqIrHxHKGGkALICNLo6azARiHX2l6
	ea4EjZly1NBh/bPTEMqxSngmEFozZVOT5XyMO6poLyIdr8nklPtQOZK9WI6HvX2N
	ga8KE250XBTJKVQzZe9ADwHHnksHxCxSC1jVv+ng==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqnnbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 12:11:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674BuORH020205
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 12:11:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg9mj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 12:11:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674CB5ps45744456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 12:11:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C758F2004D;
	Tue,  4 Aug 2026 12:11:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AF2720040;
	Tue,  4 Aug 2026 12:11:05 +0000 (GMT)
Received: from osiris (unknown [9.87.143.152])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  4 Aug 2026 12:11:05 +0000 (GMT)
Date: Tue, 4 Aug 2026 14:11:04 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Finn Callies <fcallies@linux.ibm.com>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        freude@linux.ibm.com
Subject: Re: [PATCH v1 0/1] Fix MAPML calculation in ap bus code
Message-ID: <20260804121104.12261B3e-hca@linux.ibm.com>
References: <20260804105811.17744-1-fcallies@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804105811.17744-1-fcallies@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FRfiQBqZaPNJyHGyrhM1NJkHhcPE4PNI
X-Proofpoint-ORIG-GUID: FRfiQBqZaPNJyHGyrhM1NJkHhcPE4PNI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA5NCBTYWx0ZWRfX3UKAb9PDNgxP
 73wIdrPvfBZOJa6YeO2+f+yFj2zuZjaTQUXSRoeiPsKQPCRiJPsG+o/dxFvrz/reg1x8kIhkldv
 7xv24NxK8184oWA4pdpBQoWTN4FX7As=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a71d6de cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=7HDjK3VWbB7MtdD6BKoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA5NCBTYWx0ZWRfXztA76YW68Dpi
 Rwg5GACA5FqHDbv+Gfa3gLfHgSszG6pMqbVlGvd/CfraUvmwwLINxlpIEr8Rirbtderk8k3Wy+Z
 zzjjq6/tFIj7u0bAP5tBqGjHtE77N1xbJ2kpxlkESTkgCLsvilloTyb3CW1iwtQN8Mhv+XxfXSn
 5Gk/Q+INhLresJ6Nl8p+qy4KshqnXBIon7JdSZ03y8Uf/Frfvj7/zX0ij4i7+YMiPccfjkVW5B3
 mkhmUPDdOuYOIRmtCZmIeOHdjlp0LZ8nu4fJVnGqIeVOQqTkmVT7fy4xQp2NuT0u08omM8oJ1CX
 ZntsN9C5hkx451884Vd5ZWwIZvfdWPzp9o1sPdKxa5iFX/PUkypMSi+OHv7rdRG48/cI5Pi3kPE
 mK59lRcV6EK084AXPvmPNBVoZC3mfnk5/uOSb5vLc0z6+vonh1ob2EAbwCblEJmuE3JkSJUyTTA
 JjCxDApPyxo2uGUWUEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040094

On Tue, Aug 04, 2026 at 12:58:10PM +0200, Finn Callies wrote:
> Pretty self explanatory...
> 
> ====== CHANGELOG ======
> 
> v1:
>     initial version

You don't need to provide a cover-letter for a single patch, however
if you provide a cover-letter, then please provide meaningful text.

"Pretty self explanatory..." is not helpful at all.

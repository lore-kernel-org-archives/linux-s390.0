Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C2346EC67;
	Mon, 24 Aug 2026 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591087; cv=none; b=XlAoQcJ7E6rhlf+WQJDCurgzDh1RsLosZzW4xI47HU3BpYRQt+/4DcC0DS4vIlF03tSHiZ5NZ+wPupagweZB0wTMYGZwCz3tg7uGNxMqtu+uc4b7jDOOgqo6EN/0AK7WGE1s9oI/ctSdLME+cW4QtpFMyJYCpmm7XP+6EXuyldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591087; c=relaxed/simple;
	bh=ECYIP3GIJ1wMVtFSVnXOqyFzX990OK/6qPACvj0P1B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuC2AconEIEpJkYQdtM4J93jN1oNFi7QbwbsNDNI0K9kIPBswBFiH6KFi0jSRCBZuLFTRI3oOc2RsskXbVsURiZtVUSU2rlgJ6ZRlowCF7ETVUr4cjpG19MmwXrtNynMLztNe3lM0Bp+eoCWv0pvrdo4Q0IhJTtPdT9TzhIkTHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VV9DMLbe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VV9DMLbe"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OG1rtq2418921;
	Mon, 24 Aug 2026 17:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BdFzGQ
	tjGO5DKJMc3KFSeCNAapmHOHX+0QSB6RJNwQM=; b=VV9DMLbeMNOPKD+gafwU/F
	4ygNHiWwmx74vEq2j5/uCrQ+xFETDfXD/MMG/2uwG+4RuG0/lMVrgATMHqsedcrj
	oyccw+dHA39cAfWTYf4+/KnrNGCC33ZQtU5Wnk/ApMEST/hNm49yheWLgXS53nfZ
	KqO5sDfUSoJUMJ6ZmJ+7u6HctA6aKLFhbfmb4ik8c9uvc9ScN3OTWLqMMzkxULs/
	qHum+3AU4uTiN5A3hEaflBcqbhzjGf7SgxH96lTpKsSXFpSLspx/dEY8zfzOMeGe
	jxM1UzEICdIvEOoAwauPWTcHvrdM7cBAM3OQy5uRehpLyNvO4vt0jmuqIwaGiteQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx2pge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 17:04:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OGuKwO004622;
	Mon, 24 Aug 2026 17:04:39 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgy820-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 17:04:39 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OH4cu430671400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 17:04:38 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13FC958063;
	Mon, 24 Aug 2026 17:04:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10C655805A;
	Mon, 24 Aug 2026 17:04:37 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 17:04:36 +0000 (GMT)
Message-ID: <0a04d793-e20a-4080-834d-eab251214c37@linux.ibm.com>
Date: Mon, 24 Aug 2026 13:04:36 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size
 in vfio_ap_mdev_cfg_add()
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260824135850.503728-1-akrowiak@linux.ibm.com>
 <20260824135850.503728-5-akrowiak@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260824135850.503728-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE0MyBTYWx0ZWRfX6aLrXJjG065a
 OqYYFqKV4Lzetj32F6urd/vhKJwwzgw52ibjDJDiZp5+3zIyAAreYJ/hmGCsWV/iu+gYqnv7aN7
 7fpQm+N36O8idrsCkRz2fo8SVfDc/WQ=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8c79a8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=hGDoPG5oOfrUUiHZLL0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 89nJTAKZ3GxyKazUp5ktokNZbAUoSXqS
X-Proofpoint-GUID: 89nJTAKZ3GxyKazUp5ktokNZbAUoSXqS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE0MyBTYWx0ZWRfXydFZvcD7xUkB
 Zg7OvX50wztdhxL3X94a+NI+IW4Te1GAIrFyV3Ec16BtPOz/XX9KY3x6CX1hF3uBewkXH9HsSQ6
 JLdbIG7igOb4wTZI4B9BFc2p97mH8R2RNHTu6gMABEsK7tEua7N9Lfpgl46WleCw/QKt1ATJ4m+
 kA5fWxuetN373uN3wJP7CL0rZO7MGJU/qQTNmShWXIg9+ipGcgqykuICdxm7WCs+L1nDww8491U
 TjoIvJDIUHzM3QnlFYXKsv6pqbKZRlzGf8N6YDKHz+UjtWxB8/kHYc/5gAlT0UyCcyyONHNoPH/
 itJ8BU6xkip9myf1ZvrOxRMmb2NAiKIrFyE1rpC5e7s1e72DxqvrlBrY/+Qy5uD+4Z7yiu0OGh8
 gsP1FnyfoHhJRrR5YlEnREBYt2Roid0OeZz1Ja7SyxVTQkvcfR1aaZmCK0y+lBU3ZLgYA5HJ9ch
 eBeNJ1VHRYYnBEIeSAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240143

On 8/24/26 9:58 AM, Anthony Krowiak wrote:
> In vfio_ap_mdev_cfg_add(), the bitmap_and() call that computes
> the intersection of newly added control domains with those
> assigned to each matrix mdev passes AP_DEVICES as the bitmap
> size instead of AP_DOMAINS:
> 
>     bitmap_and(matrix_mdev->adm_add,
>                matrix_mdev->matrix.adm, adm_add, AP_DEVICES);
> 
> Control domains are indexed by AP queue index (APQI) and their
> bitmaps are sized by AP_DOMAINS, not AP_DEVICES. The two
> constants are both 256 today so there is no functional impact,
> but the wrong constant is inconsistent with the two bitmap_and()
> calls immediately above it and with every other operation on
> adm/aqm bitmaps in the file, all of which correctly use
> AP_DOMAINS.
> 
> Use AP_DOMAINS to keep the code consistent and correct in case
> the two constants ever diverge.
> 
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Since this is not a functional bug today (constants are the same value)
I'm OK with no fixes tag here.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DC61AC45F;
	Wed, 23 Oct 2024 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685557; cv=none; b=OJgwG4LDEhUIqdFPScmE/giyP0rCWVlOg6C2n0ROmei2JKj+hGvEy1lItsRJMt71c9ariZQ0ePyXYUvODoJvKAfpH5YtaYWLb4MbvcOlS+PbxnnyPe9aaHvFK9dwdOtu+NLpwNxIjYIq7u0sj76gCrdMaKnjAEf5qwLJV20qXZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685557; c=relaxed/simple;
	bh=XWkncq3ISkdkhen6Kw1KtSDFPf0wG3L66EiYcLJlTxg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H9pj6ATrGw6veqCmHFNDzBw4MUq8v6zmSh/I9NqB5a6uBCIZFKiQICNLGDa7Ku9kCGlm4WkbtZAdN7Fomn2L13jazsnxHB+gmFCYMZq98/TresLRmzT9GlimuVKt4Zz+OTxe46UyFaa1IfW9wgdAahDLQ0ykFZeV57f71qT6XpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=doA68HFN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="doA68HFN"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N0NCmf015248;
	Wed, 23 Oct 2024 12:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=nT/3yJTGy2OB7CLqzJPLQwG7RwZiuo
	oGBhdVTy3pA8s=; b=doA68HFNQVqewv844VpybCQP9BnmXI6ELrmPL+XDqH9+s3
	GwTLXyMiqnvvQ7Ond4x8S0+i+gD0TZRM+EzjaO0BkZnQ7Clq6vZ1KddwawKTiaRG
	tB2DjEgKqF0fNb5Ysy/639IAXOXXCsqSJ+XkIJ4w+70Q29eR66degMdAJZZ8bOym
	uJKkEgNxm4/a8OXnYoJ3VbqR+q8PJ5gd6EHxDsM59dD8Wcv2ds00qOl7KINxRruZ
	mi5K8KTC6Llumaor2aagviO5hNBkYb8VRm8xCT8bzh6VF6xch97XBxvg5+zyNBGA
	jjd6O7a7vwccgYFvMwgccLPctWLxo0MVK2fmvy1Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emadtx32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 12:12:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBZfTs014317;
	Wed, 23 Oct 2024 12:12:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emhfjrp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 12:12:32 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49NCCSqo57671990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 12:12:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AAAA2004D;
	Wed, 23 Oct 2024 12:12:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 382682004B;
	Wed, 23 Oct 2024 12:12:28 +0000 (GMT)
Received: from localhost (unknown [9.155.200.179])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Oct 2024 12:12:28 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3] s390/kdump: make is_kdump_kernel() consistently
 return "true" in kdump environments only
In-Reply-To: <20241023090651.1115507-1-david@redhat.com>
References: <20241023090651.1115507-1-david@redhat.com>
Date: Wed, 23 Oct 2024 14:12:28 +0200
Message-ID: <87ttd3t3v7.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bZiwHeOPrShIqif1uDjL6RuXzWc7dQrR
X-Proofpoint-GUID: bZiwHeOPrShIqif1uDjL6RuXzWc7dQrR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=826 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230071

Hi David,


David Hildenbrand <david@redhat.com> writes:

> Similarly provide a custom is_kdump_kernel() implementation that will only
> return "true" in kdump environments, and will do so consistently during
> boot.
>
> Update the documentation of is_dump_available().

A small typo here:

is_dump_available() -> dump_available()

> @@ -587,16 +587,16 @@ int smp_store_status(int cpu)
>   *    with sigp stop-and-store-status. The firmware or the boot-loader
>   *    stored the registers of the boot CPU in the absolute lowcore in the
>   *    memory of the old system.
> - * 3) kdump and the old kernel did not store the CPU state,
> - *    or stand-alone kdump for DASD
> - *    condition: OLDMEM_BASE != NULL && !is_kdump_kernel()
> + * 3) kdump or stand-alone kdump for DASD
> + *    condition: OLDMEM_BASE != NULL && !is_ipl_type_dump() == false

Here is a typo in the condition, a redundant '!' before is_ipl_type_dump().

Otherwise, looks very good to me.

Reviewed-by: Alexander Egorenkov <egorenar@linux.ibm.com> 

Regards
Alex

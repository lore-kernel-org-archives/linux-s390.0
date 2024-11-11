Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774E419F133;
	Mon, 11 Nov 2024 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731351646; cv=none; b=g3HTk2GdDvctMtR0KQqyoIwkpblqpJyuISPQXZ4dWhREHqhEGK4qcc/ngsVz2BwkOmGS6ayBxtFHehwBXz0x/W1zhrYQwwHKP7gVGBkINi2gyN2jerv+yjK6hcpbfgqy2/q/utNRwFraHltbvnHmS/r+2Ye8NKuKU+TUZThyp0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731351646; c=relaxed/simple;
	bh=nEmV4O6Y98x1Bj7k9TTFtrwHsYFS349eDVJFb9C2BxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pm5SV5N+tu1qcwArZNieXuRI0t72A+l1ChRkEjREuiqqdUalByTR0QNj/q3/zSNhaUDcnouY3O9xSrdlVd4qQDOpJxiBSXIF1F1xSHfBZMOVQqn2ukNBgJ7hNxcM4IJ1STn86gGKgkBIiKWnPsoogfzgoi2WUDt8+IZKJ0f6ZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YAlhmFU+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YAlhmFU+"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABIeDvA007739;
	Mon, 11 Nov 2024 19:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Edm+L53qF3mjaPZMzLe4yRqmmNhA63
	TIO1n90mNl/I4=; b=YAlhmFU+5bvsRU1pv/UZ1hrMr2o5LrttXLJtY5BDxSb9Av
	LLTfzceCcHRZ+4Eda04AoCpRdnaNblYrfcxF9PQjLwUPGN0/yRETVxsHM8JLi84N
	DPISYCABB0QI+tJ/OqFJDAhhHCysD/+Uc9688A7lMqPUC6pIOJBgnfK5HwujI53C
	yMjiOKxCv85+jrY4TSQIEQ2W2nxi7Nlj6TfJp00Mtvg6otkkdDIFt0h7FAVOjLMC
	sIBQAY2GxrC+AtDPmHq2nWYhLf6jaS37ZqfnJEChv+kw/Lf+zP0LPOxmpgswIgvr
	5OoYqpBwNvsrloiCMFClFMbaAevVTvzL/AccGJ5g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42uqdb825c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 19:00:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABAtLkZ021445;
	Mon, 11 Nov 2024 19:00:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tms12q41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 19:00:41 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ABJ0ZH853215648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 19:00:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAA3C2004B;
	Mon, 11 Nov 2024 19:00:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EAFA20040;
	Mon, 11 Nov 2024 19:00:35 +0000 (GMT)
Received: from osiris (unknown [9.171.44.149])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 11 Nov 2024 19:00:35 +0000 (GMT)
Date: Mon, 11 Nov 2024 20:00:33 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] s390/syscalls: avoid creation of arch/arch/ directory
Message-ID: <20241111190033.13515-A-hca@linux.ibm.com>
References: <20241111134603.2063226-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111134603.2063226-1-masahiroy@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bV_MfayEaDPOthLUJMTqqqjzgtQ2wzUb
X-Proofpoint-GUID: bV_MfayEaDPOthLUJMTqqqjzgtQ2wzUb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 mlxlogscore=375 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411110150

On Mon, Nov 11, 2024 at 10:45:52PM +0900, Masahiro Yamada wrote:
> Building the kernel with ARCH=s390 creates a weird arch/arch/ directory.
> 
>   $ find arch/arch
>   arch/arch
>   arch/arch/s390
>   arch/arch/s390/include
>   arch/arch/s390/include/generated
>   arch/arch/s390/include/generated/asm
>   arch/arch/s390/include/generated/uapi
>   arch/arch/s390/include/generated/uapi/asm
> 
> The root cause is 'targets' in arch/s390/kernel/syscalls/Makefile,
> where the relative path is incorrect.
> 
> Strictly speaking, 'targets' was not necessary in the first place
> because this Makefile uses 'filechk' instead of 'if_changed'.
> 
> However, this commit keeps it, as it will be useful when converting
> 'filechk' to 'if_changed' later.
> 
> Fixes: 5c75824d915e ("s390/syscalls: add Makefile to generate system call header files")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/s390/kernel/syscalls/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Oh wow, this survived nearly seven years. Thanks for fixing!
Applied all three patchs.

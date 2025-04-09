Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E3F149C64;
	Wed,  9 Apr 2025 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744205509; cv=none; b=i2IaQ9ke2s9kHeq0mE0WbBgTXu7xKYeuA/tAfsLDUFg90FNpXlZMAdFkartt1YjqlLBAX5L04VHLhJy2t/byrG8Iar2N1pwx/+nbZhYLK7P3qGm8J12KvaqQAELDIA9FDTt/6YUbOZwPPanAsa7gIKUCLbnaahEGcFV9vIUO/SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744205509; c=relaxed/simple;
	bh=Kz93Uzj4cLus0XiXcFlQ1Ns1YrndBKtdlqqpAv1CNJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7KDvGvX8HMFIP/w1xvRlYmUmkOJqQQ11FM5jM14PS4GrwqTLF5puCwvqQmV35G09G/kmibjczJ4GiB1wRtlYXUmmYgL8nMz5wRqpZgoT8kXLhAT2YCzG/GC4qb/+WM+q5kPe3nzzOYvBO22DAc/h8CSj/3yR3YUHhbEuRjhZmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hsyij0vh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hsyij0vh"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539BwZug013895;
	Wed, 9 Apr 2025 13:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=pTKrCQdDq2Gpt5KWIVDEkQnxs9eFdt
	FjHzlfnJkmf7o=; b=Hsyij0vh031VFaWJrOlKI3stwC0b8sUv/C9RayNFhcapel
	dQ+32q1XN7GbevQ5A+Q1mlsDIP4fwonNKviKT+dbPI7xChLKZKil+lzpJ9E67TMF
	aG5tA7sypQjYuwIwx93rxE4YuxvY+V3fCULKTYU4bwvMee1Q26y+gW8xq2mTCxlP
	OVpAZMVmK+1ThZrVIcMSAkL1FvW4fgMdkfyCzBhho1j17FqIJn6X/Wesdb456wpl
	YKhTbv1/1N1VrKGvJb40PloOGYDtFXXg1csnpwKRnANtcyTurYZt7mIruD3KvjXF
	76Y6JpbVFJIaD1OFVr5xEEztOKDaH5FryKj4Ogkg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45w57px24w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 13:31:46 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 539DVk6o031361;
	Wed, 9 Apr 2025 13:31:46 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45w57px24r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 13:31:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5399WtTe014473;
	Wed, 9 Apr 2025 13:31:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufunqu64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 13:31:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 539DVfkC33161708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 13:31:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B4052004B;
	Wed,  9 Apr 2025 13:31:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8BCC20040;
	Wed,  9 Apr 2025 13:31:40 +0000 (GMT)
Received: from osiris (unknown [9.171.93.223])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Apr 2025 13:31:40 +0000 (GMT)
Date: Wed, 9 Apr 2025 15:31:39 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/boot: replace strncpy() with strscpy()
Message-ID: <20250409133139.7333Ccd-hca@linux.ibm.com>
References: <20250402231433.117505-1-a.jahangirzad@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402231433.117505-1-a.jahangirzad@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9XpxJSHbg9RwYsW6gmunAeFELb9foB0w
X-Proofpoint-GUID: vjQikTDZWcqYhRuC3ObMLG__wist_Cs-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=791
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090082

On Thu, Apr 03, 2025 at 02:44:34AM +0330, Amir Mohammad Jahangirzad wrote:
> From: "Amir Mohammad Jahangirzad" <a.jahangirzad@gmail.com>
> 
> strncpy() is deprecated for use on NUL-terminated destination strings
> as it doesn't guarantee NUL-termination when the source string length
> exceeds the destination buffer size. strscpy() is a safer alternative
> as it always NUL-terminates the destination and returns the number of
> characters copied (excluding the NUL).
> 
> Replace strncpy() with strscpy() for copying the bootdebug_filter value,
> using sizeof(bootdebug_filter) rather than sizeof()-1 since strscpy()
> takes the full buffer size as parameter.
> 
> 
> Link: https://github.com/KSPP/linux/issues/90
> Signed-off-by: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
> ---
>  arch/s390/boot/ipl_parm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You could have at least compile tested this before sending.

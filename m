Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D03848E0EB;
	Fri, 18 Sep 2026 10:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726382; cv=none; b=OPIx+SN74gpjWeBkli4G1+ZY0hfYYVoy0We/5oQzqXPNSINcfQqnNSW0hz77sXsf9HZPkRf99Llo8FRr2iC9+yZBZKnNv7Y5crNAHIiJBhb6r2MkbhP0A1nlv5VGbff89mXqO7dhxQCWoj2dF9nbflQwt+pU2KHfsG8P6v4cm1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726382; c=relaxed/simple;
	bh=FmtnlxlGgBnDEFGUyMnIpvCu3NgZ3Bkijcc69vnr93s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htMU1wifpzU6rBgIRDnsvqBu7Z/I/yoh1KBJMZQsOCF1zsGHEKF6to+mfD3l9kg3PSALawivo9PQPIrGZxPwTb0D6anaUdqEJOeZeqH4CnFCDMhSmQym74HSZbDHZr1oWHfXVxQW25OSRMteKThUSJX1AvnUZ05b0HQvWb6134A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ckQDWr/m; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ckQDWr/m"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA2mpU991014;
	Fri, 18 Sep 2026 10:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=0lSdrkNDltAhbRuMWme/U0ipws/Aby
	PRu0m/UnAj43M=; b=ckQDWr/mmQBFn/GfMWulIaBryHUdih6+U+MS5EAmOUrwXV
	OuehMDZsq+A3aMZ1knyopdYo6h2mImJ9kYWFT9oOpYxgTiOJHKygjhzFmhDkEz1/
	+cZMzFaaluPTwUqhbZIRMWc7YJdJpPibe+M08CwnBEqcOp3VYtFejc1XyaSd5OrC
	PWifGCbrwQR39jyZCAKBBaWfaoiwejP7QyXu0mm2pP1E+tWxHYLla81jxKgFtwec
	z2FkEZjUJz1GMKb39WOGteSX6RJHfOpJFfERJRQmNlbCm8KWA7/MUzN7pA46vok2
	zJYBqSwK+r8UR7xPV8Pnw9kEGRwin4DWY5/wNUJA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcveuj3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 10:12:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I9o8oS466646;
	Fri, 18 Sep 2026 10:12:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa6rf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 10:12:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IACrZK47972614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 10:12:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2A892004B;
	Fri, 18 Sep 2026 10:12:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DFAE2004D;
	Fri, 18 Sep 2026 10:12:52 +0000 (GMT)
Received: from osiris (unknown [9.111.38.246])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Sep 2026 10:12:52 +0000 (GMT)
Date: Fri, 18 Sep 2026 12:12:51 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Kees Cook <kees@kernel.org>
Cc: Kees Cook <kees+treewide@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] s390/keyboard: Allocate key_maps and func_table with
 ARRAY_SIZE()
Message-ID: <20260918101251.20386B25-hca@linux.ibm.com>
References: <20260917211239.i.576-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917211239.i.576-kees@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEzOSBTYWx0ZWRfX9912iJO1DwPs
 S5QPPhPf6NKGkj6Rr26obFAqMu1e0DzVrsU9w7JrN4pOxLA5rXzjefrps1rEjm4zssdNSQsEy99
 PK/p+NH82TmWDVxUCByRGLrPOggwsEA=
X-Proofpoint-ORIG-GUID: tyyMeam7HCp8G8FvVvve__JSNZgVAHN5
X-Proofpoint-GUID: tyyMeam7HCp8G8FvVvve__JSNZgVAHN5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEzOSBTYWx0ZWRfXzIUNZHu7dxw/
 tBmbCDsAHJo5ghF+/wWUsTHnd3EP9Fd/8Or8Un+PWBsj1HzbVRVvWi3T/m8IStaXd92a4sfCA0W
 FtRfkwSuBuIqICYmLxu5m2wUqVv2kXSC3UMkDDpA2eo9GkQYs4xzpnmZtirUrRYeLPUNyu6rTP8
 I2IB4hKvspWWUuzvb0yZGcl7iAEBIh4UEgkAkhtmKS9fP+VgGlFSj1DouMsiCjUQf7yMl6hLnyN
 U8Pki6uXp8FkN0rOLnfIZovurhzUqr6ZFD9mC4yc5bOKpEs4M50s96VrL74uQn7DPA1LMk+DzHv
 gGdlCdgDjsBtPGuhZl0pTA621lYrnARF+R/zLDKgpU5sADdwzGtHJfM43RHjW4sQeoefVJ56MG3
 TeipEAEMce4uCZBovtHQ4ah/3YyvIPmv+ShZqij/UQWBPrVCqo7BDLD5ENe0ofInsf8vQeI4fXG
 +IGYAcVb571JdcJoQxQ==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aad0ea9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Ez8LhxAq2v69tQbn6GgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180139

On Thu, Sep 17, 2026 at 02:12:40PM -0700, Kees Cook wrote:
> From: Kees Cook <kees+treewide@kernel.org>
> 
> In preparation for converting the kmalloc family of allocators to the
> type-aware kmalloc_obj family, we need to make sure that the returned
> type from the allocation matches the type of the variable being
> assigned. (The kmalloc family returns "void *", which can be implicitly
> cast to any pointer type.)
> 
> These allocate as many pointers as ebc_key_maps and ebc_func_table hold,
> but the sizes were taken from the whole arrays, which would make the
> allocation types pointers to those arrays rather than the "u_short **"
> and "char **" being assigned. Allocate ARRAY_SIZE-many entries instead.
> The resulting allocation sizes are the same.
> 
> Build tested ARCH=s390 allmodconfig with GCC s390x-linux-gnu 16.1.0:
> drivers/s390/char/keyboard.o
> 
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>
> ---
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: <linux-s390@vger.kernel.org>
> ---
>  drivers/s390/char/keyboard.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied, thanks!

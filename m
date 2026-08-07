Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF033EE1E0
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 09:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786094629; cv=none; b=OX2gFerfWdi4sAAhWXDg5bJXi75bn5+3cXa6wfc8DYtOr/RKnEwrtpcGQkGT/LL9rkq8HTf6by5djSgnvVoStRZUQtTgdaKW/TmRuXl63Fn6Q46OqZJCPnrUr3o2ZHJTbJ/uyobqcq81bxULrSizzBcnlVsidJejelz5OsRKYxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786094629; c=relaxed/simple;
	bh=zQfUGN061pWZSvWFC7ddPvfLVxG2i/WqDzSD/jrgrkI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q+DBmw6dccybjUDwWt9ENY+NGMWG8rUYycSjI8HR8Jj7JGFxywER1KL0U+6tE0/ZDERKZYeweL6zwnd4cnhoePmth5zzzje+PRLZKXDecX9ehH9tncbLk4ZqzBP4esA+nZTcVL3fUsoeQ7Lzzqx5h5dY/cf8MviifXruQBSrE/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DxkhNFyw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DxkhNFyw"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HttC4134477
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 09:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3DR3IlZAG1jJ1cPGcjjC7IAoYvZamr
	pFEVVP7OpA6zY=; b=DxkhNFywNH4+DcPc4UzSlTn4ZrlOAkhOTm3gSEluLwXLbY
	c+4GTZ2NllaFnKKGchYEpFESGYoIeJe+qOX03Zx6J0oHBNRwQeGPCRr21j+kavH7
	naPzkkj8BtZZS3X/iSkx605/UECiJhEfSRA84FOjaN6n7qfseOVcvQGTiil5soIL
	qGGmmY2GBKRZOfYP/Av4H08WEFqzCcKGP7A9tNRu5zj4st0Ru9t0P1ZWeYPmyY1v
	6PebTXylPk2NRaG5wk5OcYeMLVd0hYS24i8ZLfZIcAsqON0WxYwCpPEXDB1uYhxH
	G3Gfr54fhowDA8WwiOrCsOeFjPVb5qapffesvf6Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy0436pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 09:23:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6779BIho003572
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 09:23:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kf453-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 09:23:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6779Ng0x16187734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 09:23:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C71C20049;
	Fri,  7 Aug 2026 09:23:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FB9220040;
	Fri,  7 Aug 2026 09:23:42 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Aug 2026 09:23:42 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/2] s390/char: Enable CONTEXT_ANALYSIS
In-Reply-To: <20260806155303.2675932-3-hca@linux.ibm.com>
References: <20260806155303.2675932-1-hca@linux.ibm.com>
	<20260806155303.2675932-3-hca@linux.ibm.com>
Date: Fri, 07 Aug 2026 11:23:42 +0200
Message-ID: <yt9dcxvus2qp.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2OSBTYWx0ZWRfX5oHxNu49BeTO
 Mw/olEg88dk/4eBqNSa+6Z1fxZghy6j2GkBO19nKILOBwTRGodfqYRrpGEUHhlHIofxxpxTJHc4
 a75o4cA/aqxLoV3fLMovYA/GSjhYhgRXY0VcD5PMPTbVONeBrKhJjm58dJbygaUioTS7t4Vivjy
 RtvqCCGk9Mt/YmPbmprnIwjNdHoXyK0ktY3i5BRmgFZ/spP7KsAxBJFtNvJZ0dfeKDU3oBgkO84
 RT2HTqGSQf0kZOPXbYI6he17Teo/oICp7Os69eyin6PfFz1VOdGmJWJp8IdPubEgcXIbs6/Gh1U
 AjQq6ZNZ4zrrDO+q6mxpDw3gPcc4ab9Ei+N+tMq3sgNDua23JdADyTTXqzncG0is5snuTRZMoa4
 1dcwNu5km/3kh8XsdpLmMNIsbh12xpeXckhAJmRr2Z/uRoQWF2+K7lAE3X+DDzPjpKH4WN49lfJ
 yyiYBUUXpFdRLfqb48g==
X-Proofpoint-ORIG-GUID: -GsDPEe3Vh235twhFx2cB8F-8hbjbR55
X-Proofpoint-GUID: -GsDPEe3Vh235twhFx2cB8F-8hbjbR55
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2OSBTYWx0ZWRfX1XwQP3/Bteu2
 lhamTtSYRELxL/rgTGJcgO6MrmminN98QqJH8bn6JyHm1JfzlNSQLz0HeJ6veOUS37P8YKkoDIr
 wCnmoSgD12f3rQxPBmlymdF/YDKeAIw=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a75a423 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=HgAxEO-uAuhvMbp9dKAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070069

Heiko Carstens <hca@linux.ibm.com> writes:

> All character drivers pass clang's compile time context analysis.
> Therefore enable CONTEXT_ANALYSIS.
>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  drivers/s390/char/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/s390/char/Makefile b/drivers/s390/char/Makefile
> index 126a87c3c6f8..0ad960d000a2 100644
> --- a/drivers/s390/char/Makefile
> +++ b/drivers/s390/char/Makefile
> @@ -3,6 +3,8 @@
>  # S/390 character devices
>  #
>  
> +CONTEXT_ANALYSIS := y
> +
>  ifdef CONFIG_FUNCTION_TRACER
>  # Do not trace early setup code
>  CFLAGS_REMOVE_sclp_early_core.o	= $(CC_FLAGS_FTRACE)

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>

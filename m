Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E711053A7;
	Mon,  8 Sep 2025 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350353; cv=none; b=K1VJcbWtjH+oL6Lv4xvKnCow/aLS8KqseAn165zHBCTgjD3cFkuZbSbCiL31MvpNUHTXWYUJ8SlmSyAaLMr0bCZ3zGCw9q4dqxcEakJh9PxJDPy/EwC31rxSbAy21uIL0JBJCJUKlJmBJWkIyr3HOLYcIQQapPlzTMiTVMLgyPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350353; c=relaxed/simple;
	bh=ipgLsUYzarrnGrEphNm/tqTdj2rpGBlkK2qyPnJmQnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NT7ueBoxzyE+sPlSFBoTTDtUiagG4ltoVrzlG1jPpo9czPT6QBdl838FacjcUK5Qu7GvY4f7CdtjT9QDlsPQZu+4Hu5Q2ZpJIlpKRG0mFosKce6C+YVdRFO6C5SRyEKaDLyq0nTTIN/FkjdDSQDK70xal1ZcjvF+zy5JqYtSdRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s21nS9vA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s21nS9vA"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588GVwed024164;
	Mon, 8 Sep 2025 16:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=JmuvXQ+q8hDfwKRCmUkENXXZeICgnf
	iFYeYGEpjpG9U=; b=s21nS9vAVVjBmD8WOFP9JDvhQ/ZK+J2WRSbOiYXIelyUNJ
	UuJgAPvnNOGsCKVoRagh/NZEoQRPZcl6G8V7IZSf5bCWUyDY8RM05VX4TMy9DMuT
	2B5eq+fx9ZM18i3qwAoPCWq1XmUSdC5ODXdwuEzE4MGL7AbfBHbtSmEsPFGiKm5D
	lyheoTy2ERVHyE/XJmAJLYnt2aCkpzKvI+XYlU9wgE2JpgV4oeU0J/Bamvr0lAqx
	MigpQH2oPtij1AQEYGW/YsQ/ynXEgL7JpAYMGSUEJezMYhAHANJ9FqkA6WDd6beJ
	09OTzKT6srswllybmrKubxYc3DSFE9b6HL1/gRlQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsjqga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 16:52:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 588GYTFq007895;
	Mon, 8 Sep 2025 16:52:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109pf36n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 16:52:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 588GqDn556557868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Sep 2025 16:52:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DD1E20043;
	Mon,  8 Sep 2025 16:52:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00B0D20040;
	Mon,  8 Sep 2025 16:52:13 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Sep 2025 16:52:12 +0000 (GMT)
Date: Mon, 8 Sep 2025 18:52:11 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/nmi: Simplify return statement in
 nmi_registers_valid()
Message-ID: <b1bf1f70-8b4f-4e96-908a-907da1748377-agordeev@linux.ibm.com>
References: <20250908153221.383589-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908153221.383589-3-thorsten.blum@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX0iEHbOqjevkt
 bfM06hE4BNgfPk5pM+I+Ynr9g9Om02gXvKJA93qXJX5qvBahCIWW9QwpocAr76CWMjt9FXyGcMb
 BuIhy7r579IdqPiK6MKW27SJxLh/n0/H6u4e7TN26tifcfQtNGIs5zrenEs0SPwIKS6I7P31t1P
 zzfA4N0Wz8Z9YWDPk5r2h/q+K43wBs2TeryvMY1buoIZkke96gqFjPR6gWciJ1BSPEwvko/0kik
 xc/c/aX7A9YF7jPC7dkHfFCwvBilyNRjnSGHyfC2w6kf8c0dxToohSJAHeXWWJT+8TwRsxS8CqP
 E5kSYdLh4gO5c4gH0T4Y543J1Vij2WIixuRTK3KL1mC0TXRpt/UYnSCV4aEQTbcea5BE+w9xqnF
 3BbYfI6k
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68bf09c1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=5RwIgj8ufmiR05aHu9gA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Cr10bPQ9Xkj29GL-Zt9yYeKM0SPSv9QX
X-Proofpoint-ORIG-GUID: Cr10bPQ9Xkj29GL-Zt9yYeKM0SPSv9QX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010

On Mon, Sep 08, 2025 at 05:32:20PM +0200, Thorsten Blum wrote:
...
> @@ -321,9 +321,7 @@ static bool notrace nmi_registers_valid(union mci mci)
>  	cr2.reg = get_lowcore()->cregs_save_area[2];
>  	if (cr2.gse && !mci.gs && !test_cpu_flag(CIF_MCCK_GUEST))
>  		return false;
> -	if (!mci.ms || !mci.pm || !mci.ia)
> -		return false;
> -	return true;
> +	return mci.ms && mci.pm && mci.ia;
>  }
>  NOKPROBE_SYMBOL(nmi_registers_valid);

This change does not make the whole function readability better.

Thanks!

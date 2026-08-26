Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096BD1FBC8C;
	Wed, 26 Aug 2026 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787736565; cv=none; b=bYchfc41N8ZMQV3fgpo2ws9L+pNTwW46p5hhqntJgkxnGHVtRy9NGCQhjOarU98ty6D0bUo36sjBHLE8t+k8ed9gz8tw8clZ4qzQbmsboPZ8gXadk7nR8qov2+E+tQHDHhGBii6v25mBFFt/icv3LquvCgyX5cXp5sahm666XdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787736565; c=relaxed/simple;
	bh=xcrE5PrvOArpTFsoYLn2rUHZqyXsieS7j6Ul2nmR6y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlNghc7hx2P9dnEqHiLgCgk6UBSWi804qQmKdvcek4W6a3mOx4PIzHR/T7TuosEy0VKQnIyvVp8IKVAad3AE92EjZ8KjVSJ93ATSiJG/pRwQWkfG+uWWZlfhEldnsezLN5nljocHdcC+Dbxlinorh4y0cEQx/vYJh5y5vTckN00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KqxLyzGp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KqxLyzGp"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q6VXE33191436;
	Wed, 26 Aug 2026 09:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=i+HFpUj69qjlu9sucFnigBR7ywU7uH
	ToHlD9bwRzIm4=; b=KqxLyzGp0/DtwuLxH0PRjkKyWAYY/6mErDdy1eH8sS+M02
	B5DOKwwXCXzXLWVtWsIcTAT7DE4HvfDWA5efzdS8Rd5WWuadDydjDTspf8k0Dp+q
	u31J63RqeMasNkcq8gu9ksPzhoHJ2k+FL3M54WA229FyNmfTCAgM/VuKUidI5e3B
	yMC6cNkfwg/FcfoS/R8MO0rqW8Vgr05u64daW88IgWiWY+NtMbzgzoGEx+ge3wWG
	wgcagMAQ1+f8CMdvv7aMONPPhU1accF6Mw0IUy6TfknOpJdVwQdh+38ZKEcU5t22
	6VCLlOIOvOzdRHXfQRffTJdacA+oPgs4zHrvP+ag==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73945s4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 09:29:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q9Pvq2020949;
	Wed, 26 Aug 2026 09:29:22 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3q9cxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 09:29:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67Q9TIqR36569448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 09:29:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A1E620043;
	Wed, 26 Aug 2026 09:29:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FCFD20040;
	Wed, 26 Aug 2026 09:29:18 +0000 (GMT)
Received: from osiris (unknown [9.87.128.239])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Aug 2026 09:29:18 +0000 (GMT)
Date: Wed, 26 Aug 2026 11:29:16 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Warn if kernel command line contains non-printable
 EBCDIC characters
Message-ID: <20260826092916.21444Ab3-hca@linux.ibm.com>
References: <20260825150840.537653-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825150840.537653-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UlJM4E8IT7GVb4nd7z6EoL56SrZHAAVv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA3NCBTYWx0ZWRfX5DlZIqsELetC
 u8bT5iTCtssAH3Kta23bHQsXhb60ZG/TZUMM2qW4xmL4OKGvdifAlxc0zbGq3L+e1+/dMJ8n9aB
 W80hEY5zoWIYE3BzEgF+IOmuSEFudVW2vNYgvsKd5TcPYLozgul70pC0/ngL8u6aPw+GK+9h3ts
 DKy15m3tioSqh3VehCZZn0W0orKY+KimNgJb/hHFfgErYnsPkEedktBT6VtMERLOTY+TtuS4k/E
 vYdbApD+NrjsbibTus5Lm+38Y4/bUFAY/2K0VR1a8X4c//vR/QW4pgIQcyVe/F0wHABAm/+A4Cz
 Yy4ozmgDBvPwLpXQmKu2fat00qGB3jXn2e3INE9rSyB7xV9XArkZkpYMBGmAzPDF5QMyPrhrvBY
 gPMTmSZmQyXp4XjsAyN11DVEUTLrWuBcJXSbHreUxExHR9k40ixJZ29ZYBBz1rtoCg2s1h5svRd
 d/eEDe471g1ygFOL84w==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8eb1f3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=L_CarK2LVp__tvhdJJcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA3NCBTYWx0ZWRfX8xxA8puehsIW
 Z8fTMJ5fO97m0nIthY9IgKB13fvB3OlIMVxrfDjW7/GI0FQgVzvESon7Fi2wxqM+p7ElV1mnEXa
 +ctSinxj/HFeop5XUkuRUBRVUQtZBjg=
X-Proofpoint-ORIG-GUID: UlJM4E8IT7GVb4nd7z6EoL56SrZHAAVv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260074

On Tue, Aug 25, 2026 at 05:08:08PM +0200, Ilya Leoshkevich wrote:
> Users may accidentally add multi-byte UTF-8 characters to zipl.conf
> parmline, for example, by copying snippets containing non-breaking
> spaces (\xC2\xA0) from web pages.
> 
> The kernel will then interpret the entire command line as EBCDIC,
> making it unusable. Distinguish this situation from the legitimate
> EBCDIC conversion by looking for non-printable characters and issue
> a warning.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/boot/ipl_parm.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
> index 6bc950b92be76..71c0c26d56bba 100644
> --- a/arch/s390/boot/ipl_parm.c
> +++ b/arch/s390/boot/ipl_parm.c
> @@ -173,12 +173,29 @@ static inline int has_ebcdic_char(const char *str)
>  	return 0;
>  }
>  
> +static inline int has_nonprintable_char(const char *str)
> +{
> +	int i;
> +
> +	for (i = 0; str[i]; i++) {
> +		unsigned char c = (unsigned char)str[i];
> +
> +		/* isprint() is Latin-1, and we need ASCII here */
> +		if (c < 0x20 || c > 0x7e)
> +			return 1;

Hm, I guess the comment refers to a different implementation than the
kernel internal one? Since isprint() (see include/linux/ctype.h) is
true for exactly the range you open-coded, as far as I can tell.

Furthermore kernel command line parsing also allows for all sorts of
spaces, tabs, and line feeds (see e.g. next_arg()). So I guess the
above should be changed (and shortened :) ) to something like:

static inline int has_nonprintable_char(const char *str)
{
	for (int i = 0; str[i]; i++) {
		if (isprint(str[i]) || isspace(str[i]))
			return 1;
	}
	return 0;
}

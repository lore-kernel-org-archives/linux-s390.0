Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364DB1C57B1;
	Tue, 15 Oct 2024 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993679; cv=none; b=BM6A4U1aaYDmI6iVi6CU8tcagPGwp8+amO3PSU06UJAkZ9AFVDSGlW+F++N8f1I9Z2nyf/hAhGRpfUV/lxjnWCELUo+1+xsKYr7HQZGappiQs6wNjCOgQR80Gz2F3KxWpBvz8J192tXEOwxyW4Xm+B5bVNlCmCCXvn+vciWn0wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993679; c=relaxed/simple;
	bh=frGzG0exRPAvFJxx5eXtGe9i2KZlpHasEbC+y0R3c2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W56Ge/U7mFeSxr/vhWM8EIS3fIk0Faj3LJc3hD1z8wx0CF4xGxVPa93kCLbJcRr8wCAvR7cROmR98LgFgf4kFyqdPTmspGtTni8UlAhdV1+3PAoxeHvdpnyJ2+pHvavgmmOqH33zB8Je634RMp5W5j5CA/YRQo4NsfeDMeNv90U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FOlc1cxH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FOlc1cxH"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FBp4YE024353;
	Tue, 15 Oct 2024 12:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=NO4PsVxF0Vv0WpyYXQjdX0PJJIdJ00
	vvIhoHcEmfrAs=; b=FOlc1cxHN0v6a0v1EsTwvx+CJNPiXbXyGApSq0A3YdIOdA
	PSdtoFnaoef/4vQ7BFLoqSEPSrB5HE9k6QbQw5O03wbolvzm2MALDvaqd3n40wUd
	g1LNw7YoAy7swq6+UHh9UUumvBP9sGT53KN3JxfVaEm7AsNVuWjAGNFJZN6N4mwo
	s5gn09h8Jdk4p5F2ZlxI+o3a42iK7qTOu9PUVccWbZoxeJVrMtQc2VzcV6++ZF2u
	nxvwCfXSIVSx1MU84FOQmA0PmOcZyT5sF6VbCRpLKoUZO1KH4DmAi+fhoNUVZmbn
	2oPGRcCJcESz2PheTIbi0yk7Q+JIXjz/JCR+AyaA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429qvh02c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 12:01:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FBdwFo005218;
	Tue, 15 Oct 2024 12:01:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285nj3cp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 12:01:14 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FC1BjB42795302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 12:01:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57C512004B;
	Tue, 15 Oct 2024 12:01:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 367F620043;
	Tue, 15 Oct 2024 12:01:11 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Oct 2024 12:01:11 +0000 (GMT)
Date: Tue, 15 Oct 2024 14:01:09 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v3 5/6] s390/uvdevice: Add List Secrets Ext IOCTL
Message-ID: <20241015120109.7641-K-hca@linux.ibm.com>
References: <20241015112859.3069210-1-seiden@linux.ibm.com>
 <20241015112859.3069210-6-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015112859.3069210-6-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5tTULbaZ_3bVYklfEUCJaX23mSr1E4zU
X-Proofpoint-ORIG-GUID: 5tTULbaZ_3bVYklfEUCJaX23mSr1E4zU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=557 clxscore=1015 impostorscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150081

On Tue, Oct 15, 2024 at 01:28:58PM +0200, Steffen Eiden wrote:
> Add an extended List Secrets IOCTL. In contrast to the first list IOCTL
> this accepts an index as the first two bytes of the provided page as an
> input. This index is then taken as the index offset for the list UVC to
> receive later entries for the list. While at it fix some kernel doc
> issues with the list function.
> 
> Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  arch/s390/include/uapi/asm/uvdevice.h |  4 ++
>  drivers/s390/char/uvdevice.c          | 96 +++++++++++++++++++--------
>  2 files changed, 72 insertions(+), 28 deletions(-)

...

> +/**
> + * The actual list(_ext) IOCTL.
> + * If list_ext is true, the first two bytes of the user buffer set the starting
> + * index of the list-UVC.
> + */
> +static int list_secrets(struct uvio_ioctl_cb *uv_ioctl, bool list_ext)

This is not kernel-doc style :)

> +	free_pages((unsigned long)secrets, 0);
> +	return ret;

free_page() instead of free_pages()?

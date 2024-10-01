Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B17127448;
	Tue,  1 Oct 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801216; cv=none; b=TtMpe++vJG49as3ijZ4uWSxBgOlx2svJRS7J3feVHth/GLfj3Oqen/f+Gv2TCj132uiQkOoQxi6mDoZltQLU3Pztb4Emdbv3Xb/IoJhDHtaP/o/BU4FoFwvbzfROLGx96coAdiPkFeUpjwVS+0jRGoI/AaDMEehErVXzt9N/yac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801216; c=relaxed/simple;
	bh=HiG9GtWMswAaZDbUlsntDaoJGjdyT7+LdcqwzUNVv9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqW8kslWKlYG9fEvobB/2/tTlRP2p/LU/WL/h/fkiNOSYBnWYXONx23A9FaaSYfqHgltpgKnJ/iXNfZPYUhedz42ThGMyN/MvrA5gk/00QZnb9Wvh5rFcVUVFWIWv2ZFD+AhHiRdYqikQwXyeF/A5KxpGnMlK8YEwFfc4afS4NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rnQSHS86; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rnQSHS86"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491GLP9U028064;
	Tue, 1 Oct 2024 16:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	Wry+BMAdVz/iliK0KP6oFMh+89WY2VRMT2TvxGPIZQ0=; b=rnQSHS867nqPic//
	SSlBNN0YT6G5/wLp8kssJSW+Pax7/zS5HQk54pn1il6n0BN5C/gmTmDXGn7ZW3wb
	zrUvThXcDmXBLNOoS+43zeuddev7/WMnFoP9t/YSm6Etc3DSTJG9eyxHtrePvYF3
	rva9RGQWSKq/Z9sTbeXfi4DfKuUaseFfib0JvRLpq8l/cAQ7avZFvmrOqHZnaXqU
	J60Hn34hlLLNUFg++1/gR8K/YWDRNVBMXydRqafGCaDFsYSfnSIa/Qv/FxPTLkuw
	bu7YluKdWQ6mwl6x0BoZHS3ts6XRKiiRtF4vuWuq+yvQVUqMtkDkdid5ylcy/ZQp
	WjzUAA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420mhc04eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 16:46:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491Eiue3008050;
	Tue, 1 Oct 2024 16:46:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgxwqhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 16:46:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491Gkl4758327462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 16:46:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A34BD20043;
	Tue,  1 Oct 2024 16:46:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AFFF20040;
	Tue,  1 Oct 2024 16:46:47 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 16:46:47 +0000 (GMT)
Date: Tue, 1 Oct 2024 14:10:27 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Ingo Franzki
 <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank
 <frankja@linux.ibm.com>
Subject: Re: [PATCH v1 1/6] s390/boot/uv.c: Use a constant for more-data rc
Message-ID: <20241001141027.2063bf9d@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <20240930131909.2079965-2-seiden@linux.ibm.com>
References: <20240930131909.2079965-1-seiden@linux.ibm.com>
	<20240930131909.2079965-2-seiden@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hymnsFrrPdbuqE1g5EvMykud4eoqu9ZL
X-Proofpoint-ORIG-GUID: hymnsFrrPdbuqE1g5EvMykud4eoqu9ZL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_13,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=728
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010106

On Mon, 30 Sep 2024 15:19:04 +0200
Steffen Eiden <seiden@linux.ibm.com> wrote:

> Add a define for the UVC rc 0x0100 that indicates that a UV-call was
> successful but may serve more data if called with a larger buffer
> again.
> 
> Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  arch/s390/boot/uv.c        | 4 ++--
>  arch/s390/include/asm/uv.h | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
> index 318e6ba95bfd..2a71e759dc42 100644
> --- a/arch/s390/boot/uv.c
> +++ b/arch/s390/boot/uv.c
> @@ -22,8 +22,8 @@ void uv_query_info(void)
>  	if (!test_facility(158))
>  		return;
>  
> -	/* rc==0x100 means that there is additional data we do not process */
> -	if (uv_call(0, (uint64_t)&uvcb) && uvcb.header.rc != 0x100)
> +	/* Ignore that there might be more data we do not process */
> +	if (uv_call(0, (uint64_t)&uvcb) && uvcb.header.rc != UVC_RC_MORE_DATA)
>  		return;
>  
>  	if (IS_ENABLED(CONFIG_KVM)) {
> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> index 153d93468b77..94ff58336e8e 100644
> --- a/arch/s390/include/asm/uv.h
> +++ b/arch/s390/include/asm/uv.h
> @@ -28,6 +28,7 @@
>  #define UVC_RC_INV_STATE	0x0003
>  #define UVC_RC_INV_LEN		0x0005
>  #define UVC_RC_NO_RESUME	0x0007
> +#define UVC_RC_MORE_DATA	0x0100
>  #define UVC_RC_NEED_DESTROY	0x8000
>  
>  #define UVC_CMD_QUI			0x0001


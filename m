Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435E3235342
	for <linux-s390@vger.kernel.org>; Wed, 16 Apr 2025 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794018; cv=none; b=l8luO+16K2px5ZT9MpiyEkILGo2f2COv+DduTVHurbFNbawD9YgHgnu+7G9+kVMMGd6+7xRbZU1LtU34X0YKQSYGNmaM3JTiZe9v6S1tDyUM3Wkdkod++pAyLWVhEUP33tHLbDxWk3GwdtuRcNooPEL1JttqG5Jp9ieW1LjoURA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794018; c=relaxed/simple;
	bh=jLVkll89c4Asy+xV695IPYH9ZPB8pgCiLFJSk8duA8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lc+LX9bErsSs/IiGhg5zPYBUNAqoXWdQHCR+FHy3Z8+bWljmFAuVm+r3oebe0WnZBdmD2R629UJPEbmSlvr1d8lbC4HsQUmNkltID//g0pz5d7IrmuWojrLpk9OhhHy8WToZILBCVF1Phku++4eeB8xnV1/BATjjao4UhA6NGlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qM+cx98b; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qM+cx98b"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FLdqui019845;
	Wed, 16 Apr 2025 09:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=yiHDP7t71wL9HVp1eUD0VrQLBNtYKL
	TeDfUwKRZc0j8=; b=qM+cx98b8plqj8wzr5gnqTlwj+Kk83F9bGl5s42O2R/+tm
	r3VKghG6gArJGcylQZP9T4SyK4EC0tLjC0pSnwwfdYhVyNhpiRvm1HOqf8K7Uk74
	ufz0JUGGSRxMfuP5Ngykmwppe6k5rnUj7A2TtLJ7AkRec5bkdDPjn+zCg2Kg3SkW
	ABurg6gSgXS2lK6rM9XdcAowZkQmtoNxMQQjGC6Myf4LMxNklJ4CYYYu/vK7L4QA
	mKDcbqT4eevN9u4JbNKGutDnKkZKc+6S0KaH2ey86AkqGrspjEmaOmOociG6l21O
	UL+4pO5Ga61VCc7dsKuzVOZcn7cUh1TcIIlk4Bpw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461yj52gds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 09:00:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53G7TesN017207;
	Wed, 16 Apr 2025 09:00:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46040kya6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 09:00:12 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53G908ad30278014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 09:00:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90B612005A;
	Wed, 16 Apr 2025 09:00:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F9C120049;
	Wed, 16 Apr 2025 09:00:08 +0000 (GMT)
Received: from osiris (unknown [9.155.199.163])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Apr 2025 09:00:08 +0000 (GMT)
Date: Wed, 16 Apr 2025 11:00:07 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH v5 23/25] s390/uv: Remove uv_get_secret_metadata function
Message-ID: <20250416090007.150408-B-seiden@linux.ibm.com>
References: <20250415142438.118474-1-freude@linux.ibm.com>
 <20250415142438.118474-24-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415142438.118474-24-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NYMvPgERs6Pd6I_Kty0Fw00bLabF2jaD
X-Proofpoint-ORIG-GUID: NYMvPgERs6Pd6I_Kty0Fw00bLabF2jaD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 mlxscore=100
 lowpriorityscore=0 mlxlogscore=-999 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 adultscore=0 spamscore=100 suspectscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504160069

On Tue, Apr 15, 2025 at 04:24:36PM +0200, Harald Freudenberger wrote:
> The uv_get_secret_metadata() in-kernel function was only
> offered and used by the pkey uv handler. Remove it as there
> is no customer any more.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Suggested-by: Steffen Eiden <seiden@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

Thanks for the cleanup!

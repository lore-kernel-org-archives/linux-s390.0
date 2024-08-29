Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B31AE848
	for <linux-s390@vger.kernel.org>; Thu, 29 Aug 2024 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941651; cv=none; b=qWFPZfn+VAWnG/5+V9lTifid1vNKch3+L3ZhEJsyflGk+8q6am1z9cAKQDXonixkJyhWo9/TcNvsPR9OLxJX1zEf7LY0XRQP5dUW+xW6baRHi7IEpx030R/+dgufu+OdKdEEc9Vjr1P0BJW5iBxdNtnx/h74wA7CFGSgWr6J/pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941651; c=relaxed/simple;
	bh=7MzheYwtjt3orb6QkrkWnKhEAyRK20ZRytH79G30orU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4faqEPiOvJkprszr1mHJIoYkT+UPNDTnhi20C1E4V6OU5OhTiQ20xmDcMQwTmOFF+RU22JCMDfKb6uDoHckFso6nJjgtFDosaJI/EoW98y3uZinA8cdNpxTxjNPyU0aNuv9g1Hudqfx/7nGeBsJmO1kzEij9kluUIPPaVB+oTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NshUaHbk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NshUaHbk"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TCfTEE032550;
	Thu, 29 Aug 2024 14:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=HBEyYqv2w6qMHv5aFr+NtnXPd3D
	lMws0xWOQ6Gc3yxA=; b=NshUaHbkr/0RO93rWmoE2IFdRYajdPFU/GzdjvKXlua
	iwNmyDOY6BPCdHNa+04vP/EPx3FGljgV2sKgC2b+mvViK4/uixsB8b70Kc1lImzu
	/ckswl8XOfzIJ7kEzTyTSJxCw5oJzR93I5mPCG5wNVWqhaVZUqJGRWU4AlpJavDx
	tRK6iWWkEY/JI4stNv/Dx2xN/fntzhBZegY/36bkGkO0Bz2KzCgZTbNU8AAQZ4SZ
	hHxHTyxmAogzUUMGxYSy2kCyprit/OIOiXhtzmpSrs0HrxHJ5SaRJ80wQZa5wC6o
	WP1sDR3LPs1ciksRg0MK/ncS5G5roI7MFm7giXfJVdQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8u8d1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 14:27:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47TBA8D1027941;
	Thu, 29 Aug 2024 14:27:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 417ubncy1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 14:27:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47TERG3c54788594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 14:27:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74D002004F;
	Thu, 29 Aug 2024 14:27:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 296F220043;
	Thu, 29 Aug 2024 14:27:16 +0000 (GMT)
Received: from localhost (unknown [9.171.26.89])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 29 Aug 2024 14:27:16 +0000 (GMT)
Date: Thu, 29 Aug 2024 16:27:14 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: hca@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [PATCH -next] s390/hypfs: Remove obsoleted declaration for
 hypfs_dbfs_exit
Message-ID: <your-ad-here.call-01724941634-ext-8240@work.hours>
References: <20240824120749.2519368-1-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240824120749.2519368-1-cuigaosheng1@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _g6jN-OZ4juoVLFzJCs7zI1iXxiCkN3T
X-Proofpoint-ORIG-GUID: _g6jN-OZ4juoVLFzJCs7zI1iXxiCkN3T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=525 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290097

On Sat, Aug 24, 2024 at 08:07:49PM +0800, Gaosheng Cui wrote:
> The hypfs_dbfs_exit() have been removed since
> commit 3325b4d85799 ("s390/hypfs: factor out filesystem code"),
> and now it is useless, so remove it.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  arch/s390/hypfs/hypfs.h | 1 -
>  1 file changed, 1 deletion(-)
> 
Applied, thank you!

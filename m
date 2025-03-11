Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D410255E20;
	Tue, 11 Mar 2025 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713831; cv=none; b=iD1kPxWh4CKP7ac11GCosEZIIEyuGLRv7/hs2uGTKEamKJwMzx3WcWZEEFBmtKaDm0gy8bjWTGWNFfKb2fFwHQ7ICL0qajkm+5FmJHJshK75aQFXlSFXDHiKba8A78isM7K354wJlvHTPztf6x4s7lJz3/YyDfhCz503IqquUa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713831; c=relaxed/simple;
	bh=CXHCCNEXOprghwu7t9O9nASmfIr6TtyDm1pbOw1Cqxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCcML3WbVYmydp6aRoXz7qDzUFqH419SGfyZgSHZ6RO1uqDQf/WOTlruFwTDU0a38Nuo4bX9EqmDM62HjmSaSms2JcgGjBMKY7wPoAMf8+goS5e288vlze1umPQcC0eKUw5X0G6EPxfOVCeIrOYIO1VqPg1Lk+JJaKsfbYXtqGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OkywOVyy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OkywOVyy"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BE3Kts010108;
	Tue, 11 Mar 2025 17:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5u56dtQHGskTSf5+IQ68wqGEp6+oc9
	PmagGYB1VKuuw=; b=OkywOVyyDjTwd5Ra9hJluBKTT6lDermeS4faJeFKbjAdGi
	ySwoiQfoszXo5lsHNJCxz0MlMC606nNQjBZDcJ8krVS80zWrEkwY7o9ixwJuGWH+
	t0/ishJP9tjw0SJqGSaPW/DB9lf3Ze7aXiGgTqgAwEZ55iI5kXWxUlXLOkqakzPW
	K9bNUOD4Vc/dAUrvFz7MS1mkhNDgtRA9U1eWv7alAyIA5LNJAf4rrwn2R0gVEYyZ
	DVafxvT9msrp9mhTSKC+dyMDth6qvTz1d1u7wtfB4BB/+qhTTBexc1qNhzsV5+GR
	GNPKFk5ezUNNy26kRP08/o+slV+SbazlBiga2kFg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45apkrh56a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 17:23:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52BGeIjw022196;
	Tue, 11 Mar 2025 17:23:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45917nddcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 17:23:43 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52BHNd8o46137780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 17:23:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D040820049;
	Tue, 11 Mar 2025 17:23:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25A3C20040;
	Tue, 11 Mar 2025 17:23:39 +0000 (GMT)
Received: from localhost (unknown [9.171.9.82])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 11 Mar 2025 17:23:39 +0000 (GMT)
Date: Tue, 11 Mar 2025 18:23:37 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: hca@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhanjun@uniontech.com,
        niecheng1@uniontech.com, guanwentao@uniontech.com,
        chenlinxuan@uniontech.com
Subject: Re: [PATCH] s390/boot: Ignore vmlinux.map
Message-ID: <your-ad-here.call-01741713817-ext-6705@work.hours>
References: <F884C733016D6715+20250311030824.675683-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F884C733016D6715+20250311030824.675683-1-wangyuli@uniontech.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zgtopoqPN968ponBEZ9i61AE32kkFDc9
X-Proofpoint-GUID: zgtopoqPN968ponBEZ9i61AE32kkFDc9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=571
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503110107

On Tue, Mar 11, 2025 at 11:08:24AM +0800, WangYuli wrote:
> Upon compiling an s390 kernel, a vmlinux.map file might be generated
> in the current directory.
> 
> Append it to the .gitignore file so that Git does not track it.
> 
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  arch/s390/boot/.gitignore | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Vasily Gorbik <gor@linux.ibm.com>

Changed the message to
"""
When building with CONFIG_VMLINUX_MAP=y, a decompressor vmlinux.map file
is generated in the boot directory.

Add this file to .gitignore to ensure Git does not track it.
"""
And applied, thank you!

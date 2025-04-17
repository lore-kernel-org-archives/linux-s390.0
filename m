Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6929912B93
	for <linux-s390@vger.kernel.org>; Thu, 17 Apr 2025 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744890052; cv=none; b=XEEHAydgMsIBVP9bb0nsDs4TckOg66D99HGaihLED8x6sSpEqg98n6CsICNN2xjqmQBEWoMOrES8Sh5Ku5Je6qXTBMk7dBr7Ed7YXNqupWwzvbEd6RsDWqqwl5Ge8UGutkYFDTOU1VGNbGUl81eelWbH0gNWxEAtdCLM+OC/klU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744890052; c=relaxed/simple;
	bh=hTaiWSnX6h/b6so9WJ4uXP6Updtv6JoNcA+OjRX+2fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlegEGH2PTQf2DGU9C1MlBS6Zf1OFuhp9/RPPJuhgC5Tq3BKpT9DoZO2F2GWLEqz9DnEyiSGfTDGo71GC/9UBg/BiO9udSJUlT+vi11PuZ35SpwvZHKWR+sQiPvYmooY+D32yVBVziuKVQPXs+j3oYqLjjpv5k+apuyncCnLfKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DhZDqFB3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DhZDqFB3"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GNmOSW023075;
	Thu, 17 Apr 2025 11:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+g62/QKcUUnD5GJ2T6vC7zdm19m6vH
	2+YoKTH5qzEbQ=; b=DhZDqFB35QhwKrQ8LKmVd6f67aQOYbJJt+pH8235NHCKuy
	/GCQaBDxqwYevnUcCqSGUGxYjyNbEmnc1ACy9GbqQqtuqzK6+zQA2saLx3E1tXYG
	D6d00tjknOfacdk6mDbmu701ZIDp3k1aI5b1TlNkAwH1Uf1eJttEeiEqviIZUga7
	DfIFWno8jtphXwx+0SOEVSEsDic2gzwxpDB0H7bcyIj141tGYaQutNh925IERmsn
	XjtxWXtfRWY6DZO7VQeWjspVsbun3Zt9fnDGdW+g9C7+8Lxsxy+NOFlpKgaqQ2F+
	MK1Hk+Y++rQj/vv9Rx71HCZ8J27ZpzPjn8zDFgtA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462ph0aq1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 11:40:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53H95m8O001265;
	Thu, 17 Apr 2025 11:40:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4602w05nsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 11:40:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53HBee6o51970432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 11:40:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0341720043;
	Thu, 17 Apr 2025 11:40:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CF6920040;
	Thu, 17 Apr 2025 11:40:39 +0000 (GMT)
Received: from osiris (unknown [9.87.137.75])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 17 Apr 2025 11:40:39 +0000 (GMT)
Date: Thu, 17 Apr 2025 13:40:38 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, seiden@linux.ibm.com,
        linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH v6 04/25] s390/zcrypt: Avoid alloc and copy of ep11
 targets if kernelspace cprb
Message-ID: <20250417114038.12521D36-hca@linux.ibm.com>
References: <20250416135801.133909-1-freude@linux.ibm.com>
 <20250416135801.133909-5-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416135801.133909-5-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QJdoRhLL c=1 sm=1 tr=0 ts=6800e8be cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=2zEDfDRNL6zTGsh598cA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Sszhtje_3nrD_Ivo_Mn_82sM4Mnk8a9K
X-Proofpoint-ORIG-GUID: Sszhtje_3nrD_Ivo_Mn_82sM4Mnk8a9K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=752 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504170086

On Wed, Apr 16, 2025 at 03:57:39PM +0200, Harald Freudenberger wrote:
> If there is a target list of APQNs given when an CPRB is
> to be send via zcrypt_send_ep11_cprb() there is always a
> kmalloc() done and the targets are copied via z_copy_from_user.
> 
> As there are callers from kernel space (zcrypt_ep11misc.c)
> which signal this via the userspace parameter improve this
> code to directly use the given target list in case of
> kernelspace thus removing the unnecessary memory alloc
> and mem copy.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>  drivers/s390/crypto/zcrypt_api.c | 41 ++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 21 deletions(-)

This is the only patch which is missing a review. Holger, Ingo, Finn?

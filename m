Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68122110
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743413755; cv=none; b=eR+cbMxFUBfyYI30GryuFQSlWbOAx8iFdNhheIgObWmqGa6rXYZyTxQQ5jiknN0QGlcmwuyGw+bAy/F5qGWVfE7uqLYsA6LP7+1KRcP/yEh2Js4NlNsO6Pb9PozXt/dH0xVMwre2SclGlpsQGoB3+ue4gXBANPJZnW/bhAw7634=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743413755; c=relaxed/simple;
	bh=oXU78hcEMEK1//fuMNSP2/m0N/IDK/M1Zs9JB8QNyE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvjmeuFCn/GHJLXkth9CU+GKczObpzyUw0ICFJDJcwQgsOGf9NnGEyRPRuQVUgAyNCoYSINJYSKnw+nI7GUnVqLAt5e0/ws/YxIqnoaS3s2Zo4CuUXTOM7+9/EzUr8B75gcjr48dkSTMDp1wxXeup4IFZWtc6E3i2gAWtR1ZMbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ePWX3LEX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ePWX3LEX"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ULTv7l019124
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 09:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=TzZrK+byUa02iyORTM6EogAD7I/8QZ
	59YeNEjZ1qvTE=; b=ePWX3LEXIFByEZ0n+/LzMViTjVe67EfoomS6ORxbkgR8ph
	VJ1R8C3z1b2v9PxlyTx2Hb0bsNaGP0Av6jF3T0yEoe6MKX7k5rNVThwRrBdGdixg
	dgywWhGO0IsBoEHSflFfl67J2lu3CzRndduSu6RVSub48GE+UPhbDZYtOok5sqHi
	a0042oUsiFYclAOdlE0O5AEmmNGLP7XhXYNci9K2iEgSIXaY+sIDwDqXL/MzyTJf
	PFgowoGbcAZh9ulsm4NmMpUNBqb+P31cMKwopppNXg16ljfV07QLgc06myYWIUFh
	s0EFY76RfQ8Hnv+DocZXwDbJsp0j/VxIF39xBz4A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qd4q2cdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 09:35:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52V9DkeN004820
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 09:35:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pujync0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 09:35:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52V9ZlLk30868040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 09:35:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D041B20085;
	Mon, 31 Mar 2025 09:35:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54C362007F;
	Mon, 31 Mar 2025 09:35:47 +0000 (GMT)
Received: from osiris (unknown [9.179.29.62])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 31 Mar 2025 09:35:47 +0000 (GMT)
Date: Mon, 31 Mar 2025 11:35:45 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, seiden@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v1 1/1] s390/uv: Prealloc and use one work page
Message-ID: <20250331093545.25223B1a-hca@linux.ibm.com>
References: <20250327153824.61600-1-freude@linux.ibm.com>
 <20250327153824.61600-2-freude@linux.ibm.com>
 <20250328103434.11717A53-hca@linux.ibm.com>
 <f70f6f9c93a8dfb5e0f0f52da882caf7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f70f6f9c93a8dfb5e0f0f52da882caf7@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YEMoWyD2Dmr1VTmJkUVxz7zZqHArV7YE
X-Proofpoint-ORIG-GUID: YEMoWyD2Dmr1VTmJkUVxz7zZqHArV7YE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=942
 malwarescore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310067

On Fri, Mar 28, 2025 at 01:51:06PM +0100, Harald Freudenberger wrote:
> > > +	work_page = (u8 *)__get_free_page(GFP_KERNEL);
> > > +	if (!work_page) {
> > > +		pr_warn("Failed to alloc a working memory page\n");
> > > +		return;
> > > +	}
> > > +
> > >  	uv_stor_base = memblock_alloc_try_nid(
> > 
> > Did you test this? I think this cannot work. When setup_uv() is called
> > the buddy allocator is not yet initialized.
> > Please use memblock_alloc_or_panic() instead.
> > 
> 
> I only compiled this and I wanted to test this today in my
> SEL environment. The patch is a suggestion and should trigger
> maybe some feedback.

Well, you got some feedback :)

> > > -	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
> > > -	if (!buf)
> > > -		return -ENOMEM;
> > > +	mutex_lock(&work_page_lock);
> > > +	buf = (struct uv_secret_list *)work_page;
> > >  	rc = find_secret(secret_id, buf, secret);
> > > -	kfree(buf);
> > > +	mutex_unlock(&work_page_lock);
> > 
> > The commit message does not explain why memory allocation is not
> > acceptable. Usually this translates to non-sleepable context. If that
> > is the case, then using a mutex would be wrong. This needs to be
> > clarified.

But I'm really wondering about this part. Please clarify.

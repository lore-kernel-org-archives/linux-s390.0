Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AD53019CE;
	Tue,  9 Sep 2025 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399121; cv=none; b=BGa1g/xDx+NpmbsgOg0mNKGj2zxhi5sE/ZQnA8i0SE+24O3HjiZxhj8Qah2RrFFnB808wbdq0sFrhB96jXkgw1RK0y+HqYmJMUobw+RcI+yaeBcZ87Epyt5J+lZHnthI/QLcvsQRye5Je26Re62cPAZ8ufSfGmkan05jeTsnq20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399121; c=relaxed/simple;
	bh=CxjfHfaKk6Pj0Ax2XdpRiA8eBdWhCbUpfYxEce74T0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSTsJzGFNGIj3y4nF74ATGRZJkp/4S/gNFrqVbXytP05kUk3LsU/9RGt0rm0LpX/9ugFw7RVeKfGWWv2yF9oGMD60OhtSJGkyEdH0s5N/KM11LpN7mAFgCoxNeDfy7N8oQDCaVsAecYmiuUfLslZv3/qWfnKsByKsIQRjIwrN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KWWz+8or; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KWWz+8or"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588K28g9026821;
	Tue, 9 Sep 2025 06:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=WFRLdfwKB+f2Hvcm3tcdJIrkbLxkBr
	qW9aCB1YOegSg=; b=KWWz+8orQXa1+0v3ElxdEgbkowV7gbPNxTS8Y3geF7oDbP
	vovW4oM61uu57+clFaoJg18oCkuhR1lFIH+FSunA44z9i0yhoVPuRkEaDaDOvCmi
	NpyWWSWW8QvpVkYDWWvv7ThDV1GXnnWRJy+nm9YXP2jDAYXZPwP/azdhkx75CEQ9
	OsT4OhjRBUaYRf34Lg24qQN9rD3ScZ8XvCM1PBTsNwBjzIOI7PS3Y3g9k2EUt9yB
	UEivUf7CfcZ4zP3Le9exs1TQWgZsV9qlzjYrT134LX6/EgpRTMACWpXJdAaPpjkV
	7Y0PBekL/bZ+TskWafWfQp4Re6ZF4Lp2tRpNnxjQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsnnge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:25:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5895ax6Y011463;
	Tue, 9 Sep 2025 06:25:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9u9v2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:25:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5896P3DG48824760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 06:25:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28F4820049;
	Tue,  9 Sep 2025 06:25:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06C322004D;
	Tue,  9 Sep 2025 06:25:03 +0000 (GMT)
Received: from osiris (unknown [9.152.212.133])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Sep 2025 06:25:02 +0000 (GMT)
Date: Tue, 9 Sep 2025 08:25:01 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/nmi: Simplify return statement in
 nmi_registers_valid()
Message-ID: <20250909062501.8968Abb-hca@linux.ibm.com>
References: <20250908153221.383589-3-thorsten.blum@linux.dev>
 <b1bf1f70-8b4f-4e96-908a-907da1748377-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1bf1f70-8b4f-4e96-908a-907da1748377-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX6UuenHDoZcWT
 KU+V9oRAHNlnYaMjqBwZ9FW8UfrVa5Srrvg1AcEVR978NLXxvkRENYeNuWosz2oQ/naHkYDAIsA
 dfoUyeGXsMWPycHiRN+xA8zgA9ylB/yFl0Uu1EY8gkvKdRxcvKIhxehrYktkjejERWTmICuaMa7
 cmtRytL6Qty8clS4NhFfatZKQYTXFqZK1FCcWhT9xlyjZ7T5RLjn29NYVrLeLpXaJwaUhyKVfta
 2ux73848asl27cGvp3bPAgY98fMZMUXe+qAJJaPfMIC1CDFnwoIrKR/CrqCwZMJCLxt1M/CA4PP
 K7mLGkImZPOEFXZ+sSQuWVs4FfWZemtjk5HevdWCBvWFzfVDCD1GWC74YyJyIlVRgEGJKxUimer
 PRNYFp8e
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68bfc845 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=NCyeNK3DE-JQ-TOlShkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: NuLrYkicH6lIBZGHla0usWqo0XtI8Xya
X-Proofpoint-ORIG-GUID: NuLrYkicH6lIBZGHla0usWqo0XtI8Xya
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010

On Mon, Sep 08, 2025 at 06:52:11PM +0200, Alexander Gordeev wrote:
> On Mon, Sep 08, 2025 at 05:32:20PM +0200, Thorsten Blum wrote:
> ...
> > @@ -321,9 +321,7 @@ static bool notrace nmi_registers_valid(union mci mci)
> >  	cr2.reg = get_lowcore()->cregs_save_area[2];
> >  	if (cr2.gse && !mci.gs && !test_cpu_flag(CIF_MCCK_GUEST))
> >  		return false;
> > -	if (!mci.ms || !mci.pm || !mci.ia)
> > -		return false;
> > -	return true;
> > +	return mci.ms && mci.pm && mci.ia;
> >  }
> >  NOKPROBE_SYMBOL(nmi_registers_valid);
> 
> This change does not make the whole function readability better.

It actually would decrease readability since every if-statement tells
you one condition when registers are not valid. Negating the last one
makes this harder to understand.

But in general please do not send patches like this, which do not come
with a significant improvement.

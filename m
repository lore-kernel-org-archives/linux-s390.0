Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59985367288;
	Mon, 21 Sep 2026 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985909; cv=none; b=h4zFEYVEP4hoT03AIRxlnhEak8diB718vIA/VoRk3e2k2L8j5kaSAIgd/NgGW6RIZYvJkb97vcZyxwvEGQ6S6MEoczF7TeyncqNBWwWsoOfOIQsZ9WpN9rfUNq+e66DtROjAVpJX/n9tB9PV3qxb/aDybmGOl/zfdldhuPeZoQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985909; c=relaxed/simple;
	bh=LqoLVnOwwQ5C47rwMAgrsSjbn4axF7xa29XXrddh1d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZvb3Lo2FS1L/+adMBnfvHEdyfdivgKK7MSDKCf5FseLcgjU6rWmQzhgyfFBqo3E15PSUcL9upbkXtMLy2EcBO+gnSvsm7ciZ6kEiuOXJg8znd68268agM+p55h1OhtWYcALvTOAkKIJe26PFnoklJ4hygBfWrXKS3akqzRjDrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PRvTJgd6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PRvTJgd6"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZOdX818858;
	Mon, 21 Sep 2026 10:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7iikn4jbqX5ptE+PFsJOxvMt8MML9O
	BlJA3qcitaLzA=; b=PRvTJgd6D9K5EamNkrFPYGATSFU3CmIy6+z5vJIPRPlIRl
	TYtOoaKIccZajOhMHczR7hQRvMEOmDF6Wg5gpgfP2LcBdct+/i08N3QATtsXMM8C
	6HdPV6IGA18Rf1KxtyEoeBclNnSHVlWiUmZo/mFA7QSFf++gLU0snlSdcqcEM8Sc
	Y3nbCJkKe+sTOsYSO/2GR5ABYU4uZ1zRnzIFYnzsjAqhGVTxnwBC0wh+xszrOe4n
	z0cGapGR1YeNNyxLAss2S4uciTUXd347nIjSHRoF1XBpvoc+p6dQDXdPbPFHt1Gy
	+DNJOYyGkwzSeditPpLP8UUwwDJ2JfTt2zQXsfRQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg27y34-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 10:18:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HwkO844286;
	Mon, 21 Sep 2026 10:18:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjmt13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 10:18:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LAHxBE34406876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 10:17:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3658A20040;
	Mon, 21 Sep 2026 10:17:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C092B20043;
	Mon, 21 Sep 2026 10:17:58 +0000 (GMT)
Received: from osiris (unknown [9.111.14.239])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 21 Sep 2026 10:17:58 +0000 (GMT)
Date: Mon, 21 Sep 2026 12:17:57 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: David Laight <david.laight.linux@gmail.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mete Durlu <meted@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 11/11] s390/percpu: Rework to simplify percpu_entry()
 and percpu_exit()
Message-ID: <20260921101757.9433Bc4-hca@linux.ibm.com>
References: <20260921084005.4022574-1-hca@linux.ibm.com>
 <20260921084005.4022574-12-hca@linux.ibm.com>
 <20260921105518.26f3dcf7@pumpkin>
 <arEByH7VvkEvy9Fk@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arEByH7VvkEvy9Fk@J2N7QTR9R3>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: eJ_f6wGakvMO0OVlxVTBoXJ5INmUFEJW
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab1045c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=CwPWOeoUAzdWqaCKj24A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE0NSBTYWx0ZWRfX9FQomctUJGOB
 TNHJax8dvx3ap6SNCRvE0+oO4iVmEjPfP94hHCnmjeCUFoTHoQ3hYQ1ND+NUtLL7XdpNRizcwV2
 gkKrPiOLmt5tuiFU89riIkB8WK1RFuFYRIxH1ooupmFRvPoQwgyjYS9U6l4SSrcowZN9L4lfnui
 jze5QRfRmRMouE5W1p9zN/b0hC7W6HsHodQQNXN3Qp/F+/JH6dagctRNfr+vOYCkYO2trl/Lovf
 Qzidcjh79UgC9tsZ2jI/qqOXu+CE74anal8OgpxKSYJP+y6nWZoO31SgsK6Qv7TvK5fU/AIPuY+
 REs/lV5YCcskGhC2Ls4CuL/c58/eZD82tEJbogS9Zz7QIQFo7LdHKYwesz+zCjPcISkl0fV6s2Q
 huHmqZRZT/a3k1KUcYjBbHKZsryccufSVlh4xeZodR0IivGgvU76gMSVOY4qsHsBEXpYci8vRsO
 BfL8M3aLijvs02gMS+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE0NSBTYWx0ZWRfX97OCfZ0lqF4y
 hwEHpzUkGJocFaPtkvqjsf1u4381tCbZlzSmPrEgbvhYx8g6RQIdp+MLOiSYpERCQFaL+8K2/lM
 Xlkc4PCam0UcONz1pwjzKvKT1p9BFbY=
X-Proofpoint-GUID: P4F0f5y_Cdss2-HjWKz2fSlhTOvdUOpb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210145

On Mon, Sep 21, 2026 at 11:07:04AM +0100, Mark Rutland wrote:
> On Mon, Sep 21, 2026 at 10:55:18AM +0100, David Laight wrote:
> > On Mon, 21 Sep 2026 10:40:05 +0200
> > Heiko Carstens <hca@linux.ibm.com> wrote:
> 
> > > +	regpcp = FIELD_GET(PCPU_REG_PCP, regval);
> > > +	regoff = FIELD_GET(PCPU_REG_OFF, regval);
> > ...
> > > +#define PCPU_REG_PCP_SHIFT		0
> > > +#define PCPU_REG_PCP			GENMASK(3, 0)
> > > +#define PCPU_REG_OFF_SHIFT		4
> > > +#define PCPU_REG_OFF			GENMASK(7, 4)
> > ...
> > > +#define __PCPU_CALC_REGVAL(regpcp, regoff)					\
> > > +	"(" regpcp " << " __stringify(PCPU_REG_PCP_SHIFT) ") |"			\
> > > +	"(" regoff " << " __stringify(PCPU_REG_OFF_SHIFT) ")"
> > 
> > I'm not a big fan of GENMASK() + FIELD_GET() and I'm not at all sure it
> > really helps here.
> 
> It's the same pattern already used by the extable code. 
> 
> While _you_ don't like it, that's not a universal opinion (and FWIW, I
> prefer the FIELD_GET() approach).
> 
> I'll leave it to Heiko and co to choose whatever style they prefer, as
> it's their architecture port...

As Mark said: it is already used, and in addition I would like to have s390
architecture code quite similar to other architectures whenever possible.

This simplifies cross architecture changes, even though it seems unlikely that
somebody would ever touch this particular code across architectures.

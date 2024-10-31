Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A9F1862;
	Thu, 31 Oct 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377839; cv=none; b=mm6xlgvY+zquPVJNDAhd3BZvGjHC5JiY6Fs6Fm7xeje+st1Pfo1N6TlJrLxNrb607hsTYZE35wRtfRKDwbQakDMN4p52Yyc1Zy9QGDanH/6DoB09y48e00QHAxBfez43JK100i1G2kNrJaDPEo1LEYXJOc2Qv+5sCC9O8tIWpgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377839; c=relaxed/simple;
	bh=xFuBagS1Z9A145LOVwOZ0ezrppfjhWVatJEXi9PIjHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1VVAAmyLNHq5lX3U+bp31OYl4i9auMxEykgxWU0+fUplx0Ag2Dqp+R2dwdnweMxuZ6F5Zyi5urTcT1zW8gqgennfYG7dZp+IFwpb44dnRY/igDtslraU4g59bVYLh/eDKDJ44qHtgvdUjO+D+cniXPXxfD6YH0J8OziVnzm6zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CW3YEDyb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CW3YEDyb"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49V2jOnw014991;
	Thu, 31 Oct 2024 12:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Za2voK
	f14+b2cUK+VEnxfTcMq0XSBgUjrgqDzeohxJI=; b=CW3YEDyb8J1U9fRSVdPj2t
	q1KZYy6DT66GFHuRQwMV5pb23GBTc/rPWSeKVlBNcvk+l0kFYPQO3W54LZypVcJx
	KFMePaF1SZRlQxmoKREPgkd59Vhd8Y4MXCJaFlFl2h3453x61g/P5p9OnZnPSLhJ
	Nw70HIfyyZj98RewuO6lgsptfuGSPToLreEYJPopyvxbvBICkFH08gVAlId4u5wc
	afmwPHwJ2u9fNBTc2Awu3OmIH2cv3E+Yd1VDNn0gGEseHbE6fvngJ0GBSh84oBXZ
	arPoQff1Y0FnLKW6zra7xmApL7aLyg/5Ogoo7TiEWsJ8aUrNzEkXm/VJBZdd9cbQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42kkbn5u5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 12:30:25 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49VCSwqC002743;
	Thu, 31 Oct 2024 12:30:25 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42kkbn5u5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 12:30:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49V8ereZ017386;
	Thu, 31 Oct 2024 12:30:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42harsn196-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 12:30:24 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49VCULbZ40698266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 12:30:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DE1020040;
	Thu, 31 Oct 2024 12:30:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 288662004B;
	Thu, 31 Oct 2024 12:30:20 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.39.241])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 31 Oct 2024 12:30:20 +0000 (GMT)
Date: Thu, 31 Oct 2024 13:30:17 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Dust Li <dust.li@linux.alibaba.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens
 <hca@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer
 <gbayer@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Nils
 Hoppmann <niho@linux.ibm.com>,
        Niklas Schnell <schnelle@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Karsten Graul
 <kgraul@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH net-next] net/smc: increase SMC_WR_BUF_CNT
Message-ID: <20241031133017.682be72b.pasic@linux.ibm.com>
In-Reply-To: <20241025235839.GD36583@linux.alibaba.com>
References: <20241025074619.59864-1-wenjia@linux.ibm.com>
	<20241025235839.GD36583@linux.alibaba.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TJk7lCcI3xYe59SbJbLRVaIY-DSFMyzK
X-Proofpoint-GUID: P_GDh0_Y8rznInJuJ41tMm9-ETnM7C5w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=997
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410310095

On Sat, 26 Oct 2024 07:58:39 +0800
Dust Li <dust.li@linux.alibaba.com> wrote:

> >For some reason include/linux/wait.h does not offer a top level wrapper
> >macro for wait_event with interruptible, exclusive and timeout. I did
> >not spend too many cycles on thinking if that is even a combination that
> >makes sense (on the quick I don't see why not) and conversely I
> >refrained from making an attempt to accomplish the interruptible,
> >exclusive and timeout combo by using the abstraction-wise lower
> >level __wait_event interface.
> >
> >To alleviate the tx performance bottleneck and the CPU overhead due to
> >the spinlock contention, let us increase SMC_WR_BUF_CNT to 256.  
> 
> Hi,
> 
> Have you tested other values, such as 64? In our internal version, we
> have used 64 for some time.

Yes we have, but I'm not sure the data is still to be found. Let me do
some digging.

> 
> Increasing this to 256 will require a 36K continuous physical memory
> allocation in smc_wr_alloc_link_mem(). Based on my experience, this may
> fail on servers that have been running for a long time and have
> fragmented memory.

Good point! It is possible that I did not give sufficient thought to
this aspect.

Regards,
Halil

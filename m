Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC7235AC13;
	Mon, 12 Oct 2026 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811605; cv=none; b=f4NWjELS/olNLqoo3H1OSJ7yR+5Xq+4yU/A651ffSg66UEYyqVJabW0PODaCsv8gF8WlXqSYW0BOu+zBkBf/BE6+5kVwN+Rkf8xiJIW8Z50q+4bShRJW8mkWDoUwjpk9pLc6bwlH8f9adXiprIHLjwISgOC3yQVxLquiioGmbIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811605; c=relaxed/simple;
	bh=KOPO584/j4b3cUzRqGq9od57uxmo2/IwW1C7qUY+HCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dm9vQGRYXmlmybl1Oyqr0JXTjpKwnPJSl1p1CsuhKkKZSSlVuucy3HOuU24giHd7rZTkhxvksIphPrePRwSWd5LD8Pc2ynVLKqzhIS8f4RnRHp/EMePF92qnrZpQsa+2/bwJ3NqA/katHoN3A1wCmEQwbEGQ4+jLhTKgRnNKPzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zei+Myc0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zei+Myc0"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEnen2641632;
	Mon, 12 Oct 2026 13:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9a541AsLA2akKtgWs1C4s+remktZ69
	fVP5WEMMpf1Dc=; b=Zei+Myc0hBDTF5zZXqeXK9Gf2D+mMeQEpvj1Krlc9zOtnV
	Fwq5coWiBl9v2qgZ8PEj9tq0GyxwMQ1n2DtgdN0ditCb2MNt3YMITNjfYWWzf0uV
	FuImSUsUge5O4SzRGEgBO5gdn+QnoHEDsttDnhGuZb1Uf/V0FMBBNT8bWZFlwrMF
	PP8Xr4CgebicCc45Sgq419HXbk93X4Eblo//N3UBeJ/Z1hdFFWYT/G4HsS8at/eL
	AaKI9ezGYROJpxxZg1b4k+JF9E35AfdA29ZCJz54JYEKUZppIIv8ihg02BWXWybg
	aw5V40XhBCEvpH6gvE8yf2YaTPIqIeLGxq7vU2Cw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwh933n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:26:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC5Awk1238650;
	Mon, 12 Oct 2026 13:26:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppnfp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:26:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CDQc0t53018926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 13:26:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9E0B20043;
	Mon, 12 Oct 2026 13:26:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25CF520040;
	Mon, 12 Oct 2026 13:26:38 +0000 (GMT)
Received: from osiris (unknown [9.111.15.154])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 13:26:38 +0000 (GMT)
Date: Mon, 12 Oct 2026 15:26:36 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 05/32] s390/tools: Rename gen_facilities to gen_bitmaps
Message-ID: <20261012132636.19350Db1-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-6-hca@linux.ibm.com>
 <a2cce267-4d50-4509-b44a-bcf15ec1612c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2cce267-4d50-4509-b44a-bcf15ec1612c@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MiBTYWx0ZWRfX2IH1/jtdouww
 E8VVuPTz+uQkJsUf7fQXysu7u54QbKe1x50i3xch5RWnDdWREtkdhrHQuHOdoT0ryP/Ky9BM/6H
 Xo6WAx09u3IGsrztR3AS0B81TsCsvgA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MiBTYWx0ZWRfXzBVhrcWCyeVZ
 1wnIae69KVMxPNGOQC1RZNhl+ImB7cuq78YtGle5asonZDLuX6p4dzLkDkfHONRzQrkIkV7YEdZ
 vWDF71TIPCNkTzn118vwgRenb8BNwIQyt/Hn2rqlGnVKanbKK5jTEdRuXxSlnx52WzyMyvGuuxB
 BZRXGNAD/X8WgkSViXC6jtFyt+bgssR3hvJLs2JFDNEP9im/lhY+UJxFtlmBdUYz5NealNWSLbo
 MDo0ovQyHUZSQi5CVMONi8Ld0f0erygePEZkQHe+r9ioIKFQ3ZFUR18NelPoEGOoF4x/fqmv+Dz
 GiAreCrW4PASZ2gHcxFtYwg2/LbZVxLbToJFy2lRQv3ZcvEVUvh+vIFiCZsuzrtZBKXUUnlV8XB
 87GsG3Td2uCYojWg2UEE68clmPk4S65dybNBamwWGr+eJHNIoRG/mF47RJFZkNM8v2cFcWej9xF
 wf4pLfdzKFqfe1XUaOw==
X-Proofpoint-GUID: TJMtKfRDuCPkwBPreM1OPelJp4omlJS9
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acce013 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=RaO6znPNoWWx0pFsc4sA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: TJMtKfRDuCPkwBPreM1OPelJp4omlJS9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120052

On Mon, Oct 12, 2026 at 02:35:50PM +0200, Ilya Leoshkevich wrote:
> 
> 
> On 10/1/26 12:32, Heiko Carstens wrote:
> > Rename gen_facilities.c to gen_bitmaps.c and make it more generic so it
> > can be used for various bitmaps. Add command line parsing, and use it
> > to explicitly specify that the facilities header should be generated.
> > 
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > ---
> >   arch/s390/tools/.gitignore                    |  1 +
> >   arch/s390/tools/Makefile                      |  8 +--
> >   .../tools/{gen_facilities.c => gen_bitmaps.c} | 49 +++++++++++++------
> >   3 files changed, 38 insertions(+), 20 deletions(-)
> >   rename arch/s390/tools/{gen_facilities.c => gen_bitmaps.c} (83%)
> > 
> > diff --git a/arch/s390/tools/.gitignore b/arch/s390/tools/.gitignore
> > index e6af51d9d183..e07d27143172 100644
> > --- a/arch/s390/tools/.gitignore
> > +++ b/arch/s390/tools/.gitignore
> > @@ -1,4 +1,5 @@
> >   # SPDX-License-Identifier: GPL-2.0-only
> >   gen_facilities
>     ^^^^^^^^^^^^^^ This should probably be dropped now.

Left there intentionally because of:
https://lore.kernel.org/all/CAHk-=whVY4mq1Fd=Vhwy0dK8fR5cOLkiy1OZMG4QyEMaGEd9ZQ@mail.gmail.com/

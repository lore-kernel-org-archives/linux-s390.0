Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E968061C;
	Thu,  4 Apr 2024 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229039; cv=none; b=Fnc94i+olI01j9U452kuwvw8Gp3lp7kjFMdOsT6OcCWFtB0hUQ9LWxkotnPeihqWKxPI7LO97VIhHhnlQCW7b3pKOaO4knMr82BLXIdgQogPNvucun1E0AXP+P3yDLXF5Pkl7gPR7Eg+8+VK8vfbvg1fnzFwm8QLh95TfedlERQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229039; c=relaxed/simple;
	bh=WMjkJTdFFtjI0VIdYjo+49cEcxDsHkkR20fgJigQFhA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ciJk62eRbEw+nwJ5Ia317eMZksVKTu6awgCXuM1ihskeSiMHA3Xrt9zoaxUVc3nWyciJr2HcfZjcXcsoxMvvugIjoWyfk0saBJRKsakWCsL73a60Xc7SurbMy9Nhn8EO2cuRf2gKDqDAbIfZw1hYDiyF50Zpynqv4pkWY5DQ1vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dIsFVDq9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dIsFVDq9"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434AghNM003847;
	Thu, 4 Apr 2024 11:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Y7rT3wbvNimPqRZV8+pCJV9SipoHmQS0tWVux4Dh6JU=;
 b=dIsFVDq90RNMlQV9p8VjF8wXddDqpYlJ0Uj9r6SXsembIoe2YyG69JfHf9lNr/AUjKdR
 PlCbf+eVsDgqryZKQnXJsQrwCg2Bmy0pL7WrqTwvL53srkwXduuktcmyhzG3tePwZpEm
 BTQknRou08R9eYk3yuDIShFBJRbqNyHqyBMUVPXi2bXgmKilpxX09MTkdCz2n3ZBU3Jj
 reRiaNCuEhFekyTd6HA96gmPTztzUggfUvb/b+YBgKhDEbzSrximViW/lpaZ8/j7qxHB
 VqjE7u+pLO5DRDPxxzmo+4uWGLqWHghL47yWL0QIAApN4dSkMTOCJVluXRM1QJMXH44O vg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9tpar2ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 11:10:33 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 434BAWld014453;
	Thu, 4 Apr 2024 11:10:32 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9tpar2fm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 11:10:32 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434AG0XZ003612;
	Thu, 4 Apr 2024 11:10:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x9epybqut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 11:10:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434BAQGO48759092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 11:10:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA0F12005A;
	Thu,  4 Apr 2024 11:10:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6379720043;
	Thu,  4 Apr 2024 11:10:25 +0000 (GMT)
Received: from [9.155.208.153] (unknown [9.155.208.153])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 11:10:25 +0000 (GMT)
Message-ID: <cb7b036b4d3db02ab70d17ee83e6bc4f2df03171.camel@linux.ibm.com>
Subject: Re: [PATCH net 1/1] s390/ism: fix receive message buffer allocation
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Paolo Abeni <pabeni@redhat.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
        Wen Gu <guwen@linux.alibaba.com>, Heiko Carstens <hca@linux.ibm.com>,
        pasic@linux.ibm.com, schnelle@linux.ibm.com
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Alexandra Winter
 <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
Date: Thu, 04 Apr 2024 13:10:20 +0200
In-Reply-To: <68ce59955f13751b3ced82cd557b069ed397085a.camel@redhat.com>
References: <20240328154144.272275-1-gbayer@linux.ibm.com>
	 <20240328154144.272275-2-gbayer@linux.ibm.com>
	 <68ce59955f13751b3ced82cd557b069ed397085a.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.4 (3.50.4-2.fc39app4) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nLjX6XP8Y0FKlwWH22i-JIS_ZPcJZBV3
X-Proofpoint-ORIG-GUID: rRAtMI-qMNO3waY_57VCcQTalw_2_kpr
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_07,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=732 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040076

On Thu, 2024-04-04 at 10:13 +0200, Paolo Abeni wrote:
> On Thu, 2024-03-28 at 16:41 +0100, Gerd Bayer wrote:
> > Since [1], dma_alloc_coherent() does not accept requests for
> > GFP_COMP anymore, even on archs that may be able to fulfill this.
> > Functionality that relied on the receive buffer being a compound
> > page broke at that point:
> > The SMC-D protocol, that utilizes the ism device driver, passes
> > receive buffers to the splice processor in a struct
> > splice_pipe_desc with a single entry list of struct pages. As the
> > buffer is no longer a compound page, the splice processor now
> > rejects requests to handle more than a page worth of data.
> >=20
> > Replace dma_alloc_coherent() and allocate a buffer with kmalloc()
> > then create a DMA map for it with dma_map_page(). Since only=20
> > receive buffers on ISM devices use DMA, qualify the mapping as
> > FROM_DEVICE.
> > Since ISM devices are available on arch s390, only and on that arch
> > all DMA is coherent, there is no need to introduce and export some
> > kind of dma_sync_to_cpu() method to be called by the SMC-D protocol
> > layer.
> >=20
> > Analogously, replace dma_free_coherent by a two step
> > dma_unmap_page, then kfree to free the receive buffer.
> >=20
> > [1] https://lore.kernel.org/all/20221113163535.884299-1-hch@lst.de/
> >=20
> > Fixes: c08004eede4b ("s390/ism: don't pass bogus GFP_ flags to
> > dma_alloc_coherent")
> >=20

[...]

> > @@ -315,14 +319,27 @@ static int ism_alloc_dmb(struct ism_dev *ism,
> > struct ism_dmb *dmb)
> > =C2=A0	=C2=A0=C2=A0=C2=A0 test_and_set_bit(dmb->sba_idx, ism->sba_bitma=
p))
> > =C2=A0		return -EINVAL;
> > =C2=A0
> > -	dmb->cpu_addr =3D dma_alloc_coherent(&ism->pdev->dev, dmb-
> > >dmb_len,
> > -					=C2=A0=C2=A0 &dmb->dma_addr,
> > -					=C2=A0=C2=A0 GFP_KERNEL |
> > __GFP_NOWARN |
> > -					=C2=A0=C2=A0 __GFP_NOMEMALLOC |
> > __GFP_NORETRY);
> > -	if (!dmb->cpu_addr)
> > -		clear_bit(dmb->sba_idx, ism->sba_bitmap);
> > +	dmb->cpu_addr =3D kmalloc(dmb->dmb_len, GFP_KERNEL |
> > __GFP_NOWARN |
> > +				__GFP_COMP | __GFP_NOMEMALLOC |
> > __GFP_NORETRY);
>=20
> Out of sheer ignorance on my side, the __GFP_COMP flag looks
> suspicious here. I *think* that is relevant only for the page
> allocator.=20
>=20
> Why can't you use get_free_pages() (or similar) here? (possibly
> rounding up to the relevant page_aligned size).=20

Thanks Paolo for your suggestion. However, I wanted to stay as close to
the implementation pre [1] - that used to use __GFP_COMP, too. I'd
rather avoid to change interfaces from "cpu_addr" to "struct page*" at
this point. In the long run, I'd like to drop the requirement for
compound pages entirely, since that *appears* to exist primarily for a
simplified handling of the interface to splice_to_pipe() in
net/smc/smc_rx.c. And of course there might be performance
implications...

At this point, I'm more concerned about my usage of the DMA API with
this patch.

Thanks again,
Gerd



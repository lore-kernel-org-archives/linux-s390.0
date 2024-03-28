Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FCD13118C;
	Thu, 28 Mar 2024 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711641608; cv=none; b=oTpQnOJt4sDlCpPoAKs0NC3+KKwBnRgYRe8uYYtV8BWzwEtJzuwWHPLUqouU97COddYqGiFU+7BzKzvh0nVKA5geqGA10Bu9Jw+yzbNPQ3QCaM+uaYKAoSKfsMaaYN/HLkAE15fQW+R+apzuH4aIY3ZVkRC3SRiJPeA5hiDkSm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711641608; c=relaxed/simple;
	bh=uVhMu+y3FUztYcdJ2dXcf4O32bylsnvucopeOGHBa5U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ugkOisja3SNTZYHTKDwhf+F4V/PVUSQQ9fDQ9CXpQFdME2hMzFV5pJl9YGHTxkgN63YxGkMj9fWUtFYbhVdxp0/cTJkKTUFVODjcaS/5/W0+ojGUKbdtBffmedbZZHfs27lDF07RQf8dY+hUMkSzNh1YnF1LrZxXoPdAOtICmn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XTzTd8gk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XTzTd8gk"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42SFvmjj005628;
	Thu, 28 Mar 2024 16:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=/2wRlPBJsjZsl/yMZFhudzZNi3JTgbcz7TgCymz2ZGU=;
 b=XTzTd8gkw+WmZGwW6ZsW18loVKS7yXqXuvHaJ6dvb9VCSs/eGBpqv9aGYy7THzXYyS9W
 ZmcGOXr77yMWNL7EQPpkf6040RTysl2uH2dPZGkrTXv0ave3clXx6yNTPEdiVa0qKdH1
 UcEAgtFvxybzsZ3BwK4/7suPmUsJNxD2m3rWPmCYpj2MU9TAWT/8v+4VGmOMgvs2lGgJ
 +4o8Ki4H/w0XNkmzmnEYZgWHJNb3qH5osQxjIX9nmKnu6OiPpv1SrA2d55xwMU5gistx
 fFWeBhPJp4KvxAm9AIIt2nA7QY7MLclzrFAw2phFNq3YA4L9Zd8LVepO0OWcYbUE0Zv1 gw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5bn6005w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 16:00:02 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42SG02fI009753;
	Thu, 28 Mar 2024 16:00:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5bn6005r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 16:00:02 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42SEN0wu028623;
	Thu, 28 Mar 2024 16:00:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2adppdtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 16:00:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42SFxtqK50004476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 15:59:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0784020043;
	Thu, 28 Mar 2024 15:59:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DCDF20040;
	Thu, 28 Mar 2024 15:59:54 +0000 (GMT)
Received: from [9.171.12.209] (unknown [9.171.12.209])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Mar 2024 15:59:54 +0000 (GMT)
Message-ID: <1b532020394c6441634a665b7e59427002b4f79f.camel@linux.ibm.com>
Subject: Re: [PATCH net 1/1] s390/ism: fix receive message buffer allocation
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        Heiko Carstens <hca@linux.ibm.com>, pasic@linux.ibm.com,
        schnelle@linux.ibm.com, Christoph Hellwig <hch@lst.de>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Alexandra Winter
 <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>
Date: Thu, 28 Mar 2024 16:59:53 +0100
In-Reply-To: <20240328154144.272275-2-gbayer@linux.ibm.com>
References: <20240328154144.272275-1-gbayer@linux.ibm.com>
	 <20240328154144.272275-2-gbayer@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.4 (3.50.4-2.fc39app4) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: unwUFeZI_eZfd4vvsAMzGZxKCAKCjbCe
X-Proofpoint-ORIG-GUID: QH6Q4a3q3EJOwu7gRCAQHxwKSWcEPthg
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
 definitions=2024-03-28_15,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1011 impostorscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 bulkscore=0 mlxlogscore=664 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403280109

On Thu, 2024-03-28 at 16:41 +0100, Gerd Bayer wrote:
> Since [1], dma_alloc_coherent() does not accept requests for GFP_COMP
> anymore, even on archs that may be able to fulfill this.
> Functionality that
> relied on the receive buffer being a compound page broke at that
> point:
> The SMC-D protocol, that utilizes the ism device driver, passes
> receive
> buffers to the splice processor in a struct splice_pipe_desc with a
> single entry list of struct pages. As the buffer is no longer a
> compound
> page, the splice processor now rejects requests to handle more than a
> page worth of data.
>=20
> Replace dma_alloc_coherent() and allocate a buffer with kmalloc()
> then
> create a DMA map for it with dma_map_page(). Since only receive
> buffers
> on ISM devices use DMA, qualify the mapping as FROM_DEVICE.
> Since ISM devices are available on arch s390, only and on that arch
> all
> DMA is coherent, there is no need to introduce and export some kind
> of
> dma_sync_to_cpu() method to be called by the SMC-D protocol layer.
>=20
> Analogously, replace dma_free_coherent by a two step dma_unmap_page,
> then kfree to free the receive buffer.
>=20
> [1] https://lore.kernel.org/all/20221113163535.884299-1-hch@lst.de/
>=20
> Fixes: c08004eede4b ("s390/ism: don't pass bogus GFP_ flags to
> dma_alloc_coherent")

Late adding Christoph as the "blamed" committer.

> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
> =C2=A0drivers/s390/net/ism_drv.c | 35 ++++++++++++++++++++++++++---------
> =C2=A01 file changed, 26 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
> index 2c8e964425dc..25911b887e5e 100644
> --- a/drivers/s390/net/ism_drv.c
> +++ b/drivers/s390/net/ism_drv.c
> @@ -14,6 +14,8 @@
> =C2=A0#include <linux/err.h>
> =C2=A0#include <linux/ctype.h>
> =C2=A0#include <linux/processor.h>
> +#include <linux/dma-direction.h>
> +#include <linux/gfp_types.h>
> =C2=A0
> =C2=A0#include "ism.h"
> =C2=A0
> @@ -292,13 +294,15 @@ static int ism_read_local_gid(struct ism_dev
> *ism)
> =C2=A0static void ism_free_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
> =C2=A0{
> =C2=A0	clear_bit(dmb->sba_idx, ism->sba_bitmap);
> -	dma_free_coherent(&ism->pdev->dev, dmb->dmb_len,
> -			=C2=A0 dmb->cpu_addr, dmb->dma_addr);
> +	dma_unmap_page(&ism->pdev->dev, dmb->dma_addr, dmb->dmb_len,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMA_FROM_DEVICE);
> +	kfree(dmb->cpu_addr);
> =C2=A0}
> =C2=A0
> =C2=A0static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
> =C2=A0{
> =C2=A0	unsigned long bit;
> +	int rc;
> =C2=A0
> =C2=A0	if (PAGE_ALIGN(dmb->dmb_len) > dma_get_max_seg_size(&ism-
> >pdev->dev))
> =C2=A0		return -EINVAL;
> @@ -315,14 +319,27 @@ static int ism_alloc_dmb(struct ism_dev *ism,
> struct ism_dmb *dmb)
> =C2=A0	=C2=A0=C2=A0=C2=A0 test_and_set_bit(dmb->sba_idx, ism->sba_bitmap))
> =C2=A0		return -EINVAL;
> =C2=A0
> -	dmb->cpu_addr =3D dma_alloc_coherent(&ism->pdev->dev, dmb-
> >dmb_len,
> -					=C2=A0=C2=A0 &dmb->dma_addr,
> -					=C2=A0=C2=A0 GFP_KERNEL | __GFP_NOWARN
> |
> -					=C2=A0=C2=A0 __GFP_NOMEMALLOC |
> __GFP_NORETRY);
> -	if (!dmb->cpu_addr)
> -		clear_bit(dmb->sba_idx, ism->sba_bitmap);
> +	dmb->cpu_addr =3D kmalloc(dmb->dmb_len, GFP_KERNEL |
> __GFP_NOWARN |
> +				__GFP_COMP | __GFP_NOMEMALLOC |
> __GFP_NORETRY);
> +	if (!dmb->cpu_addr) {
> +		rc =3D -ENOMEM;
> +		goto out_bit;
> +	}
> +	dmb->dma_addr =3D dma_map_page(&ism->pdev->dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 virt_to_page(dmb->cpu_addr), 0,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 dmb->dmb_len, DMA_FROM_DEVICE);
> +	if (dma_mapping_error(&ism->pdev->dev, dmb->dma_addr)) {
> +		rc =3D -ENOMEM;
> +		goto out_free;
> +	}
> +
> +	return 0;
> =C2=A0
> -	return dmb->cpu_addr ? 0 : -ENOMEM;
> +out_free:
> +	kfree(dmb->cpu_addr);
> +out_bit:
> +	clear_bit(dmb->sba_idx, ism->sba_bitmap);
> +	return rc;
> =C2=A0}
> =C2=A0
> =C2=A0int ism_register_dmb(struct ism_dev *ism, struct ism_dmb *dmb,


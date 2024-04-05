Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3676E13B2B9;
	Fri,  5 Apr 2024 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313742; cv=none; b=ns0dtg7tXiSOFzFkWpdco7dOy2uJmpa7k4qy0HRxximhXg73bpL97HufO1mX8FQ1ybX9zzaQ/6F1aqrgigoYvD9dGut9Ge1ML0qxzLHwNPeDii45xjeVT1tBXeMOcvUGMcm32IYjo8atgNNN5pZny59vgnL5bMKW2XeLF/3qmjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313742; c=relaxed/simple;
	bh=1SAWkE4/sbynQ4HIQauR9XKJA67ntIPOOnBWyofSjVA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a5KAwpmNkYhX3sqf+vtBTVEAe4l2gmznooB/mLdKwEXOKS7Kz4vcHPL11suxhIWaVYcueWisv29aWVbRK/fAh58D9LqD3etAnBfOAV2az9rbRXrWHfCWE9DQ6VAVaFix4MDH28cKP5hyfEwwUI2DYT92CYGzLUqytzinrNgNTbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HxgdXFLu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HxgdXFLu"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 435AUQiq014733;
	Fri, 5 Apr 2024 10:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=H/v/GntoFeDJyqcRE6ME34EKf1XIQmWIMVCRSWiOK6s=;
 b=HxgdXFLuizNdd6Ejsc+iQCh6jRYH2gzPFS3oWOAfQndTd2q4j6/0JcbB2xEZRkNACdc+
 bHyVI4+wNbThEmeqsArZaH71hFZfftxHdcdpiww6+RXNv0fi1z/B5Ui+MuV7JiB5xSjT
 2JCMQpWlJO9e/Jnq7bM2wQR0mt0KM52hQmUPim50tdrBmMkLjsqzDqcOyh5uAqRrXtca
 6/kydTK/H94VNegOt31SamJqYOm/uGXWDJCQrbVHFzoHy31iYvOKxUWvOxQHFlyYNub/
 fAYwL1c1pNA9xQAIXpaIz4FUuPsmrUNGNBWSCWWzPZ0G9J3viXA3vxmB0ohFhl7egxvN TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xadvf8910-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 10:42:14 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 435AgE6i000647;
	Fri, 5 Apr 2024 10:42:14 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xadvf890w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 10:42:14 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4359jDeF009103;
	Fri, 5 Apr 2024 10:42:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9epy1wwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 10:42:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 435Ag6km47317432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Apr 2024 10:42:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCDBE2004B;
	Fri,  5 Apr 2024 10:42:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F53320043;
	Fri,  5 Apr 2024 10:42:06 +0000 (GMT)
Received: from [9.155.208.153] (unknown [9.155.208.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Apr 2024 10:42:06 +0000 (GMT)
Message-ID: <50b6811dbb53b19385260f6b0dffa1534f8e341e.camel@linux.ibm.com>
Subject: Re: [PATCH net 1/1] s390/ism: fix receive message buffer allocation
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>, Paolo Abeni <pabeni@redhat.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        Heiko Carstens <hca@linux.ibm.com>, pasic@linux.ibm.com,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten
 Winkler <twinkler@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Date: Fri, 05 Apr 2024 12:42:02 +0200
In-Reply-To: <20240405064919.GA3788@lst.de>
References: <20240328154144.272275-1-gbayer@linux.ibm.com>
	 <20240328154144.272275-2-gbayer@linux.ibm.com>
	 <68ce59955f13751b3ced82cd557b069ed397085a.camel@redhat.com>
	 <cb7b036b4d3db02ab70d17ee83e6bc4f2df03171.camel@linux.ibm.com>
	 <20240405064919.GA3788@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-2.fc39app4) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8sX8TKM29sS0XRnJVF5nxfmynfPXVWiK
X-Proofpoint-GUID: VBhMWf1ztUKxTcJ3cgNZr2GmTcDDezpP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_09,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404050078

On Fri, 2024-04-05 at 08:49 +0200, Christoph Hellwig wrote:
> On Thu, Apr 04, 2024 at 01:10:20PM +0200, Gerd Bayer wrote:
> > > Why can't you use get_free_pages() (or similar) here? (possibly
> > > rounding up to the relevant page_aligned size).=20
> >=20
> > Thanks Paolo for your suggestion. However, I wanted to stay as
> > close to the implementation pre [1] - that used to use __GFP_COMP,
> > too. I'd rather avoid to change interfaces from "cpu_addr" to
> > "struct page*" at this point. In the long run, I'd like to drop the
> > requirement for
>=20
> The right interface actually is to simply use folio_alloc, which adds
> __GFP_COMP and is a fully supported and understood interface. You can
> just convert the folio to a kernel virtual address using
> folio_address() right after allocating it.

Thanks for pointing me to folios.
After a good night's sleep, I figured that I was thinking too
complicated when I dismissed Paolo's suggestion.

> (get_free_pages also retunrs a kernel virtual address, just awkwardly
> as an unsigned long. In doubt don't use this interface for new
> code..)
>=20
> > compound pages entirely, since that *appears* to exist primarily
> > for a
> > simplified handling of the interface to splice_to_pipe() in
> > net/smc/smc_rx.c. And of course there might be performance
> > implications...
>=20
> While compounds pages might sound awkward, they are the new normal in
> form of folios.=C2=A0 So just use folios.

With the following fixup, my tests were just as successful.
I'll send that out as a v2.

Thank you, Christoph and Paolo!



diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 25911b887e5e..affb05521e14 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -14,8 +14,8 @@
 #include <linux/err.h>
 #include <linux/ctype.h>
 #include <linux/processor.h>
-#include <linux/dma-direction.h>
-#include <linux/gfp_types.h>
+#include <linux/dma-mapping.h>
+#include <linux/mm.h>
=20
 #include "ism.h"
=20
@@ -296,7 +296,7 @@ static void ism_free_dmb(struct ism_dev *ism,
struct ism_dmb *dmb)
 	clear_bit(dmb->sba_idx, ism->sba_bitmap);
 	dma_unmap_page(&ism->pdev->dev, dmb->dma_addr, dmb->dmb_len,
 		       DMA_FROM_DEVICE);
-	kfree(dmb->cpu_addr);
+	folio_put(virt_to_folio(dmb->cpu_addr));
 }
=20
 static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
@@ -319,8 +319,11 @@ static int ism_alloc_dmb(struct ism_dev *ism,
struct ism_dmb *dmb)
 	    test_and_set_bit(dmb->sba_idx, ism->sba_bitmap))
 		return -EINVAL;
=20
-	dmb->cpu_addr =3D kmalloc(dmb->dmb_len, GFP_KERNEL |
__GFP_NOWARN |
-				__GFP_COMP | __GFP_NOMEMALLOC |
__GFP_NORETRY);
+	dmb->cpu_addr =3D
+		folio_address(folio_alloc(GFP_KERNEL | __GFP_NOWARN |
+					  __GFP_NOMEMALLOC |
__GFP_NORETRY,
+					  get_order(dmb->dmb_len)));
+
 	if (!dmb->cpu_addr) {
 		rc =3D -ENOMEM;
 		goto out_bit;
--=20
2.44.0



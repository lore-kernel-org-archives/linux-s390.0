Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD484A8A25;
	Wed,  2 Sep 2026 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368312; cv=none; b=K7waGsKyVb7psIZnHe6stu/wNt1GvAC31m9tBp9Sl5O2NaF4Nl2oDhzVSwWXmlmjPX73dI6evJvUvo3xlFk1Z0RLlp2VpR9TbptlPRR2o0MJsHoGQWt9yI5ExWAmMw4EvXCVqCpe+uin45a5yEPPtlkCyVKg2mIwdg7iYkEjyks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368312; c=relaxed/simple;
	bh=1cD4S11PDu5NdFN7RYIo9XWJwMMqhzEEVqK8egUXLmM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IEiqWU8JLToUAdaTJmuN2gX+RIUPEIlJ0ZdzD5aJz+dQaePVSGCjRphb68R61Tf/dhqI4LbmMqTIww+pgQny4uB+p5YInE4OqsG4PEXV3BdR06uSqfQiXBdTHOifCojffnY2on5dbPIeyrrQK/P3Z+kGSyoeV+wRh4/9WlFehxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U4DO+qb2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U4DO+qb2"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682GXjxb3600700;
	Wed, 2 Sep 2026 16:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=amARHs
	hKtjSBC+168x70CO/KgvWGyu220e/FH9bh4+g=; b=U4DO+qb2zM3VcbRBpM73JA
	wQk8TFHD18UqIMLCJu9Dqt69hLuhhXRm0ZHo4M3IjTaS1aBTa2by44SNah0Ka22h
	GBAWaf6ThCq58Y2uXA3wPJ3keK/D1nIAQfERsvZ89Mf3OVkVUDKD1uu2GLr+qo2O
	WAf7lv0ynfwBbwOXAeatkeb5QEH+ZtC6fCQ5rGJrA85BfHXEv/V8Ai2NVgYh6Y2z
	/6YIEtT17kklCiR1Hl/Q4KOxezyoVhM4u2roJJtMYuTr5Ak8gFFXhBCmv2Nbid+R
	PjKAfoNnpbGSnRxrk8yss3OFaHlGhMQzmzoP3b2OEvMtG+iAqDqVIdw5GtbMmxcw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudyv2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 16:58:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682GuGvK015543;
	Wed, 2 Sep 2026 16:58:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqkamj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 16:58:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682GwHnV43975116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 16:58:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC7ED20043;
	Wed,  2 Sep 2026 16:58:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9996A20040;
	Wed,  2 Sep 2026 16:58:17 +0000 (GMT)
Received: from [9.224.92.241] (unknown [9.224.92.241])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 16:58:17 +0000 (GMT)
Message-ID: <2325d95bbd1d6e57ec46eb0ff6638e4fffa465e9.camel@linux.ibm.com>
Subject: Re: [PATCH net] s390/ism: folio_put() after error
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
        David Miller
 <davem@davemloft.net>, Jakub Kicinski	 <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet	 <edumazet@google.com>,
        Andrew Lunn
 <andrew+netdev@lunn.ch>,
        Aswin Karuvally	 <aswin@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily
 Gorbik	 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>, Simon Horman	 <horms@kernel.org>
Date: Wed, 02 Sep 2026 18:58:17 +0200
In-Reply-To: <20260902143733.433574-1-wintera@linux.ibm.com>
References: <20260902143733.433574-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1M-egrWsgnMntvlKBAlx08X9YQGf3k7v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0NiBTYWx0ZWRfXz3gKY74Of8a/
 iS4zCu3LgG/kW7EFS4dkXmMZyRE6CTg3SdCGBM1ecwXOisxQSU6ZFsSn2nhJ3RhMHEw9oJ2Bj3X
 hznLoYaNtiU+8MD4OQ7njv8C05WHhzy0ZljxSYE/PKjPXHfy/Hm7s0U+z5IfpVNY4idUgBurjWh
 9fLZxuLMWq0dDYnmxFOCeSMky9RlycdbNWYt8Q9onsiDQ5dOcJ4nhxvNqld+zoskf0+CNowK843
 xo2gmy8EYj9BQZ4kqNOHu0DtgB469YXx6pc/lBAGTV91xEjWJh1tR9v2HY2q+s9UKdpIt7E79Kj
 bFM7+cIpZMny8WQNTp6R34wss0vY/GNVMo3sampF7MyOakp2k6/vtJSPfZQUGTmS7jS22kMY9Ha
 xwPl31kN8158iVCkWYyGiMbCW4cWCK9pmnhL5tcyZpQois6UpeLUxM9RZDb5wfLuzbLRU/ac4pT
 HV0bf2vSYA1UOInmdtg==
X-Proofpoint-ORIG-GUID: VUrM42jQwtrjgOd32LkBhXOgOTwA1Brv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0NiBTYWx0ZWRfX8+uNsVArfQEa
 lm9tNAJySxp20CFv/RwgYGkJ8nnbcJ7YLgHAO2R7ysMXgkePo7inMePDO+FtA5UjEPOICU0EJO3
 +FjajWbohhfZnKGSuEstW0WBfKIIfNs=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a9855ae cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=zx-3ciY802ilKned2NYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020146

On Wed, 2026-09-02 at 16:37 +0200, Alexandra Winter wrote:
> dmb->cpu_addr was allocated via folio_alloc(). Use folio_put() instead of
> kfree() in the error exit of ism_alloc_dmb() to avoid slab allocator
> corruption.
>=20
> While at it, reset dmb->cpu_addr after folio_put to avoid unintentional U=
AF
> by future callers.
>=20
> Fixes: 83781384a96b ("s390/ism: Properly fix receive message buffer alloc=
ation")
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
>  drivers/s390/net/ism_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
> index 242da20f27e0..035b233abb4e 100644
> --- a/drivers/s390/net/ism_drv.c
> +++ b/drivers/s390/net/ism_drv.c
> @@ -231,6 +231,7 @@ static void ism_free_dmb(struct ism_dev *ism, struct =
dibs_dmb *dmb)
>  	dma_unmap_page(&ism->pdev->dev, dmb->dma_addr, dmb->dmb_len,
>  		       DMA_FROM_DEVICE);
>  	folio_put(virt_to_folio(dmb->cpu_addr));
> +	dmb->cpu_addr =3D NULL;
>  }
> =20
>  static int ism_alloc_dmb(struct ism_dev *ism, struct dibs_dmb *dmb)
> @@ -274,7 +275,8 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct =
dibs_dmb *dmb)
>  	return 0;
> =20
>  out_free:
> -	kfree(dmb->cpu_addr);
> +	folio_put(folio);
> +	dmb->cpu_addr =3D NULL;
>  out_bit:
>  	clear_bit(dmb->idx, ism->sba_bitmap);
>  	return rc;

Hi Alexandra,

thank you for catching and addressing these flaws in my patch. Feel
free to accept my

Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>

Thanks!

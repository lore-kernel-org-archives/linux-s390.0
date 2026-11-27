Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795786672;
	b=oeE0VLzBplnY0qliukCF1CC1dUU7IQBYFfHXSDfNzPAwa5TWxempV2PVix/BjkH1pnL8
	 KsSnibZrqrPsN1W1U/KVU+inBTDfMCwBggs5oAu/2i6RDLc4SRuHNDZ7gv+8I82TbWDYi
	 nisyJv7P8pP0HwcmWqvA1wawRf8u453sp0Y+uyFcwOvb0o9CV8GkpR3jh8nSZT5m1Dj4r
	 PcTvdt+o3RiO7wYiDoQ4mkzQbWlxx9J11CH1000BIfVA6xIBRt+SGOqjCXnv2sGPkyo+P
	 IhksXInFFYnB9JorsWKJTHsWXPMCEglbN4cKFAjQhOz9a5ZrbL9IueGM/MPtFYnsktQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795786672;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:Date:MIME-Version:User-Agent:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=W0ycu4cYzKGqn0c93rRpVecOeZUokR6AV8zaxl2sFK0=;
	b=wIwb8Naw5yrgc8uCtGbYXNBQkTtvvbF1dkECHtYdkzas+scdXZeOeR/GsCw60+Wd8td1
	 nxVdtO1s4xt76fENW2Pwo18u9FCU21BQz18OwsHb0U3P95p5fLJTJNhnbvjcd7OSJb58f
	 xqt1wNkSMN+ZIdJjWxvGdHpOcrs6dyoNGWVIJnKqv2r8CuDtG9cIB/7AIPhfNUBm/SuXa
	 udH1NnEWHjM9C4lVYe7gZn5dlzMPOg1/9uS99Hf/O2PrZxayiKEGdTwFEzJq4xrn1n0H1
	 9B8Am8eaNUFVTZDjzUry+jVqpWGzgbfEVq8Bz+DYh9smuqXfoL6HyCj6F0IhwcDV/SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IcF1LWaT;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66C8606A31E;
	Fri, 27 Nov 2026 13:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E66C8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IcF1LWaT
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARD4asG1532003;
	Fri, 27 Nov 2026 13:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=W0ycu4
	cYzKGqn0c93rRpVecOeZUokR6AV8zaxl2sFK0=; b=IcF1LWaTOaG9LA9h7P09Lv
	kdlL8vKhHQVosijwofd7C9GKlRlzCvdnd8Zf2wpxOeto77UO5nC13CfhQ7yVRNGf
	899Fz904lhT93SU/37+JAztYjYoB2mSTptcTWNnnGaqWQc7HC2+eIvM9WGp7qtD8
	daJwQEyG3WSUbWyOn/PmPN3Svn7ER3ATiPSE6iTiyxKrm3HhXzV4/0YwrFDznSXL
	Qs7DWGN/jtPkKcmjqNsPmKSlJuy3Aizd5REV2isIxirc7vkuGqiNKtVBkh7u7bzS
	p97HkAIfBFJ+WQavyLqtbots+wnwtfYksjgiiFHFs4gJQFEAK6HaW/W/aiy3+keg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3p14a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 13:36:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARCnF903918244;
	Fri, 27 Nov 2026 13:36:27 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j6x3h29e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 13:36:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARDaQRI25821798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 13:36:26 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F094F58050;
	Fri, 27 Nov 2026 13:36:25 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FA7058066;
	Fri, 27 Nov 2026 13:36:16 +0000 (GMT)
Received: from [9.68.2.134] (unknown [9.68.2.134])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 13:36:15 +0000 (GMT)
Message-ID: <1fa553f872490a64b05b8e8bf8027009dc76748b.camel@linux.ibm.com>
Subject: Re: [PATCH slab/for-next v2 09/14] iommu: specify SLAB_MAY_ACCOUNT
 for slab-backed page table caches
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: "Harry Yoo (Meta)" <harry@kernel.org>,
        Vlastimil Babka
 <vbabka@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren
 Baghdasaryan <surenb@google.com>,
        Johannes Weiner	 <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt	 <shakeel.butt@linux.dev>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
        David
 Rientjes <rientjes@google.com>,
        Muchun Song <muchun.song@linux.dev>, Hao Ge
 <hao.ge@linux.dev>,
        Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        "Liam R. Howlett"	
 <liam@infradead.org>,
        Alice Ryhl <aliceryhl@google.com>,
        Andrew Ballance	
 <andrewjballance@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "David S.
 Miller"	 <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>,
        Jiayuan Chen
 <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
        Kees Cook
 <kees@kernel.org>, David Hildenbrand <david@kernel.org>,
        Lorenzo Stoakes
 <ljs@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
 <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Madhavan
 Srinivasan	 <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin	 <npiggin@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)"	 <joro@8bytes.org>,
        Amir Goldstein
 <amir73il@gmail.com>,
        Casey Schaufler	 <casey@schaufler-ca.com>,
        Paul Moore
 <paul@paul-moore.com>, James Morris	 <jmorris@namei.org>,
        "Serge E. Hallyn"
 <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Richard
 Weinberger <richard@nod.at>,
        Anton Ivanov
 <anton.ivanov@cambridgegreys.com>,
        Johannes Berg
 <johannes@sipsolutions.net>,
        Eric Dumazet	 <edumazet@kernel.org>,
        Matthew
 Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer	
 <gerald.schaefer@linux.ibm.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Jernej
 Skrabec	 <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-9-7c680f02a734@kernel.org>
References: 
	<20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
	 <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-9-7c680f02a734@kernel.org>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 14:35:15 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b09875d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=tA7aZXjiAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=FlkJ-zHRAAAA:8 a=JfrnYn6hAAAA:8 a=gLrx2xznCN6jzSyFt2sA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=kIIFJ0VLUOy1gFZzwZHL:22 a=rcJ5IfC3ewqtVv14NVGK:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NCBTYWx0ZWRfX67QnvSunKV71
 HB50qh7Ykm+xBP7O1hPayJ9xJlIB9YuBfUaWIXyZ8MBQSYmLH0jy3N+oZJxIJ7NKMS8vDZFS/f2
 8x1ix6c3/k2uDhUtm2HwCx0pT0xxSfo=
X-Proofpoint-ORIG-GUID: Y-EQYadcU72fzorIXub_FEkv7kODNBsV
X-Proofpoint-GUID: eJVHf5ftAeJ4mOGEdO3BAQgbTamhdWOD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NCBTYWx0ZWRfX0x0ZwkM3MvdM
 QooPeztCuxAGIjMooY+m0bM+78gLqn1X9Qk1UYIHG4SRUy1EU9nmjZiySkhV3lh+esJ9jT1+F6z
 f0hJjn1FYsqmXqikMtyadukjxA8yzMLpmAtmQ00kDn899IwvXFaorruIWUUTq9EcT7RkEvMN8cW
 djBveOvdXltHIy5F4KoMBBV+/CV+cqY7/iQ2ML0luo348cteHbXdc/6IPkXH7yyyLmM1r5cluLR
 nG+g4QvRqBgYlC1gKyrIE8Jnt5aG0YWQb9m+tjDF6DRwB/m0WdU0D0XX0JcQjDatsVzGrq4Us8a
 h4/hYzoAwxprzkwn3vdPXghgLPyRvq1bQZloZhXIMUffjL3sj/JWm/TwluErDWG43YnSp27MxRB
 oCaqVX4VAtsm+dRa06Bo+wNoxzuYFlWUP5pjqN9Ped6w2N4lm92lbf/760WtHM4D/k6XEJjbRuL
 bNvG9yhzuyHdmZlfO/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270054

On Wed, 2026-11-25 at 21:37 +0000, Harry Yoo (Meta) wrote:
> vfio, iommufd and vhost-vdpa call iommu_map() with GFP_KERNEL_ACCOUNT
> and the gfp is passed down to the drivers' page table allocations.
> Specify SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
> __GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.
>=20
> Paths:
>   VFIO_IOMMU_MAP_DMA -> iommu_map(GFP_KERNEL_ACCOUNT)
>     -> s390_iommu_map_pages() -> dma_walk_cpu_trans()
>     -> kmem_cache_alloc(dma_{region,page}_table_cache)
>   iommu_map(GFP_KERNEL_ACCOUNT) -> arm_v7s_map_pages()
>     -> __arm_v7s_alloc_table() -> kmem_cache_zalloc(data->l2_tables)
>   iommu_map(GFP_KERNEL_ACCOUNT) -> sun50i_iommu_map()
>     -> sun50i_dte_get_page_table() -> kmem_cache_zalloc(iommu->pt_pool)
>=20
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Chen-Yu Tsai <wens@kernel.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: iommu@lists.linux.dev
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sunxi@lists.linux.dev
> Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 2 +-
>  drivers/iommu/s390-iommu.c         | 4 ++--
>  drivers/iommu/sun50i-iommu.c       | 3 ++-
>  3 files changed, 5 insertions(+), 4 deletions(-)
--- snip ---
> index a280ad4f63b7..467b97ec18dc 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -198,14 +198,14 @@ static int __init dma_alloc_cpu_table_caches(void)
>  	dma_region_table_cache =3D kmem_cache_create("PCI_DMA_region_tables",
>  						   ZPCI_TABLE_SIZE,
>  						   ZPCI_TABLE_ALIGN,
> -						   0, NULL);
> +						   SLAB_MAY_ACCOUNT, NULL);
>  	if (!dma_region_table_cache)
>  		return -ENOMEM;
> =20
>  	dma_page_table_cache =3D kmem_cache_create("PCI_DMA_page_tables",
>  						 ZPCI_PT_SIZE,
>  						 ZPCI_PT_ALIGN,
> -						 0, NULL);
> +						 SLAB_MAY_ACCOUNT, NULL);
>  	if (!dma_page_table_cache) {
>  		kmem_cache_destroy(dma_region_table_cache);
>  		return -ENOMEM;

Looks good and the explanation makes sense to me. Thanks.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com> # s390-iommu

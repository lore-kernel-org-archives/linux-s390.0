Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57D3239569;
	Thu,  6 Feb 2025 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863392; cv=none; b=mT6t11v2bHOiCH4b7AmURmPVhZhXioo5jNjJVdtKjPYEVJ0pHUubMEhauXWrEusbmpbdm49dUok/eO+OReeabJJl3bdaKuDiCueOq70vJ8CeRrvMcCXsLmDVhWG9SUHKaf4Iozo6xo6nytzPgtoPu7vMJXnvJc5HUinguGwxar8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863392; c=relaxed/simple;
	bh=d4gBXBu4ap4WuzCeqgPtbkDNvVvzmqMNjC9rIdF5Y6s=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=cocc7JQavFR97Bq4pWYXKry2Uf1SVNpD8O1afFeJFTyMYdxRAKdMOBFWGKjDzsBzvLeo43396XGUSCj76dMYhY5tlfZ9+diEaePOmkZeasVs+1qLWZi5v6ZemN5ajuvH38HmQzgKisTSrD4M7cMsGmGXDl45AYhtk6t7IbSVFbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c0u6NvTg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c0u6NvTg"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516ESKgh020344;
	Thu, 6 Feb 2025 17:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=syYJ/e
	u8dhsmwgEpaRbh4JJJ7WxUlNJv4JPugmKe2gY=; b=c0u6NvTgHIjEulRvHFLCif
	rxrJ2j6YqYVuQVLS8/Q5/CX1+gZrQg0d2kGs4RxM+RvEnirYrRikDqC+HE/qEy0l
	9nFQwgY9zBWGSo5UWO04n8zezIGyPt8lqo1VVfbT5gbmrwyQDaLeIqhqlxF8RPCL
	ELTy3yhbCASW9kIW3Q1p3ORHj7J2e1KVvf1ZjrT9lCDew0B0E04qZlP2B6FvRizb
	Qs4CMDH+kW/uGqDD3C5ZG5T+Pc4gacbG7vH+nkYO0lSDyfSQs29EFHMmQdcxQy6T
	RW/c5+S8nBYO6UsEVAMEG644IQ+eO69BlcwuHFszA1xtHgzza6WUEmuT38LFmg9w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44mpw83rhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 17:36:21 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 516HYwxu026990;
	Thu, 6 Feb 2025 17:36:21 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44mpw83rhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 17:36:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 516GaDgC021474;
	Thu, 6 Feb 2025 17:36:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j0n1q4x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 17:36:20 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 516HaGns34931278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Feb 2025 17:36:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D695200DC;
	Thu,  6 Feb 2025 17:36:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F441200DB;
	Thu,  6 Feb 2025 17:36:16 +0000 (GMT)
Received: from localhost (unknown [9.152.212.252])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Feb 2025 17:36:16 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Feb 2025 18:36:16 +0100
Message-Id: <D7LJMF6OMXFQ.1ADL6WMIWIQ5C@linux.ibm.com>
To: "Alexandra Winter" <wintera@linux.ibm.com>,
        "Wenjia Zhang"
 <wenjia@linux.ibm.com>,
        "Jan Karcher" <jaka@linux.ibm.com>,
        "Gerd Bayer"
 <gbayer@linux.ibm.com>,
        "Halil Pasic" <pasic@linux.ibm.com>,
        "D. Wythe"
 <alibuda@linux.alibaba.com>,
        "Tony Lu" <tonylu@linux.alibaba.com>,
        "Wen Gu"
 <guwen@linux.alibaba.com>,
        "Peter Oberparleiter" <oberpar@linux.ibm.com>,
        "David Miller" <davem@davemloft.net>,
        "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
        "Eric Dumazet" <edumazet@google.com>,
        "Andrew Lunn" <andrew+netdev@lunn.ch>
Cc: "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Thorsten Winkler"
 <twinkler@linux.ibm.com>, <netdev@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>,
        "Vasily
 Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        "Sven Schnelle"
 <svens@linux.ibm.com>,
        "Simon Horman" <horms@kernel.org>
Subject: Re: [RFC net-next 5/7] net/ism: Move ism_loopback to net/ism
From: "Julian Ruess" <julianr@linux.ibm.com>
X-Mailer: aerc 0.20.1
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250115195527.2094320-6-wintera@linux.ibm.com>
In-Reply-To: <20250115195527.2094320-6-wintera@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PBypoT_HftuRHrn1cpTmtdkwj9djft2b
X-Proofpoint-ORIG-GUID: RvArULKGIkziuQeR2QU1yV2L_4QgVtRR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_05,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=735 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060141

On Wed Jan 15, 2025 at 8:55 PM CET, Alexandra Winter wrote:
> The first stage of ism_loopback was implemented as part of the
> SMC module [1]. Now that we have the ism layer, provide
> access to the ism_loopback device to all ism clients.
>
> Move ism_loopback.* from net/smc to net/ism.
> The following changes are required to ism_loopback.c:
> - Change ism_lo_move_data() to no longer schedule an smcd receive tasklet=
,
> but instead call ism_client->handle_irq().
> Note: In this RFC patch ism_loppback is not fully generic.
>   The smc-d client uses attached buffers, for moves without signalling.
>   and not-attached buffers for moves with signalling.
>   ism_lo_move_data() must not rely on that assumption.
>   ism_lo_move_data() must be able to handle more than one ism client.
>
> In addition the following changes are required to unify ism_loopback and
> ism_vp:
>
> In ism layer and ism_vpci:
> ism_loopback is not backed by a pci device, so use dev instead of pdev in
> ism_dev.
>
> In smc-d:
> in smcd_alloc_dev():
> - use kernel memory instead of device memory for smcd_dev and smcd->conn.
>         An alternative would be to ask device to alloc the memory.
> - use different smcd_ops and max_dmbs for ism_vp and ism_loopback.
>     A future patch can change smc-d to directly use ism_ops instead of
>     smcd_ops.
> - use ism dev_name instead of pci dev name for ism_evt_wq name
> - allocate an event workqueue for ism_loopback, although it currently doe=
s
>   not generate events.
>
> Link: https://lore.kernel.org/linux-kernel//20240428060738.60843-1-guwen@=
linux.alibaba.com/ [1]
>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
>  drivers/s390/net/ism.h     |   6 +-
>  drivers/s390/net/ism_drv.c |  31 ++-
>  include/linux/ism.h        |  59 +++++
>  include/net/smc.h          |   4 +-
>  net/ism/Kconfig            |  13 ++
>  net/ism/Makefile           |   1 +
>  net/ism/ism_loopback.c     | 366 +++++++++++++++++++++++++++++++
>  net/ism/ism_loopback.h     |  59 +++++
>  net/ism/ism_main.c         |  11 +-
>  net/smc/Kconfig            |  13 --
>  net/smc/Makefile           |   1 -
>  net/smc/af_smc.c           |  12 +-
>  net/smc/smc_ism.c          | 108 +++++++---
>  net/smc/smc_loopback.c     | 427 -------------------------------------
>  net/smc/smc_loopback.h     |  60 ------
>  15 files changed, 606 insertions(+), 565 deletions(-)
>  create mode 100644 net/ism/ism_loopback.c
>  create mode 100644 net/ism/ism_loopback.h
>  delete mode 100644 net/smc/smc_loopback.c
>  delete mode 100644 net/smc/smc_loopback.h
>

...

> diff --git a/net/ism/ism_loopback.c b/net/ism/ism_loopback.c
> new file mode 100644
> index 000000000000..47e5ef355dd7
> --- /dev/null
> +++ b/net/ism/ism_loopback.c
> @@ -0,0 +1,366 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Functions for loopback-ism device.
> + *
> + *  Copyright (c) 2024, Alibaba Inc.
> + *
> + *  Author: Wen Gu <guwen@linux.alibaba.com>
> + *          Tony Lu <tonylu@linux.alibaba.com>
> + *
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/ism.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +#include "ism_loopback.h"
> +
> +#define ISM_LO_V2_CAPABLE	0x1 /* loopback-ism acts as ISMv2 */
> +#define ISM_LO_SUPPORT_NOCOPY	0x1
> +#define ISM_DMA_ADDR_INVALID	(~(dma_addr_t)0)
> +
> +static const char ism_lo_dev_name[] =3D "loopback-ism";
> +/* global loopback device */
> +static struct ism_lo_dev *lo_dev;
> +
> +static int ism_lo_query_rgid(struct ism_dev *ism, uuid_t *rgid,
> +			     u32 vid_valid, u32 vid)
> +{
> +	/* rgid should be the same as lgid; vlan is not supported */
> +	if (!vid_valid && uuid_equal(rgid, &ism->gid))
> +		return 0;
> +	return -ENETUNREACH;
> +}

This vid_valid check breaks ism-loopback for me.

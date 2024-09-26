Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A5D1C6B4
	for <linux-s390@vger.kernel.org>; Thu, 26 Sep 2024 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373517; cv=none; b=sJkebvfut3JUt8gWe8SnUvWbUf3L99n+GU5/Pve41pcCjIMyiS6lFMrMSTNCFO/YBaKkXSTDKgq4P9A0z1pf2mtUjD8PJRE6tJv0wUn88LEKCDhMHO1IgpfcTCmwXi3ttSVo1uB7TakqQvQQrkmxtgAtELcVjf5rY2Nbnm9WzGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373517; c=relaxed/simple;
	bh=4isJZOzS80FctzWv9SGL1ycvXSDFaJATKTny65Rgs7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y4t5sLcroOX2rmmINhQDHOHQ+3RugaeJh8bfqYz7uTXl3U0yQc2kvnUcyh2btv5wTZGJoxtSp5saI/MccVCqY8husJ344uPzl13UhEgcEE1JaUOUzsOv4Vfa540dRiT1iz9bMwQlnD4wtKaiwm1BfHj4sm5+J61rW85ixBt/HNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kx1XEw0B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kx1XEw0B"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QFJK5K004016;
	Thu, 26 Sep 2024 17:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=OTDEyPXQ7870iU9CM7jrZ7rQn9o
	xhjmvFfm/mQgMOKs=; b=Kx1XEw0BLgCrZvhVSEhXzl/HDOcr83KYhrhpvVYM51J
	APA6pcj/7Zj5rJy1TDMiMvwu5QowyJXYZeVeXRrGJeMonRuPYcioRQR1Xn6l/XZi
	pYg37aqaOMYaMezk+iMNtmxcOItYmv6AYVMJlGdEsAW5FXT4htrhnB8Pz29EJotP
	sbSgPgcBezT8+ZdNok18r5N9vk30nQPZnCEX15lpyo/cKOLV1KLKdmezScMz8mQV
	KQp+ZFFVpymu0RsmaR/pooGvV7kn4b66Tr9mtGNh4xvcC1O81+058kWxjMuOoI4t
	1u08CxQBC+BJ7grAKIQ6VPblJ+5XTTKhzGCUjq7AB2Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snnar2yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 17:58:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48QFv7au005862;
	Thu, 26 Sep 2024 17:58:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41tapmrbtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 17:58:13 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48QHw9ic34276026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 17:58:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1B3520043;
	Thu, 26 Sep 2024 17:58:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FEC620040;
	Thu, 26 Sep 2024 17:58:08 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.12.206])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 26 Sep 2024 17:58:08 +0000 (GMT)
Date: Thu, 26 Sep 2024 19:58:06 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: hca@linux.ibm.com, gor@linux.ibm.com,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>,
        Alistair Popple <apopple@nvidia.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] dcssblk: Mark DAX broken
Message-ID: <ZvWgrrvYiBaFVgN4@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <172721874675.497781.3277495908107141898.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172721874675.497781.3277495908107141898.stgit@dwillia2-xfh.jf.intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NJOKKizAeOXHbKl6nmfL3rV28dzBLW3M
X-Proofpoint-ORIG-GUID: NJOKKizAeOXHbKl6nmfL3rV28dzBLW3M
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_04,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=988 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409260124

On Tue, Sep 24, 2024 at 03:59:08PM -0700, Dan Williams wrote:

Hi Dan,

> The dcssblk driver has long needed special case supoprt to enable
> limited dax operation, so called CONFIG_FS_DAX_LIMITED. This mode
> works around the incomplete support for ZONE_DEVICE on s390 by forgoing
> the ability of dax-mapped pages to support GUP.
> 
> Now, pending cleanups to fsdax that fix its reference counting [1] depend on
> the ability of all dax drivers to supply ZONE_DEVICE pages.
> 
> To allow that work to move forward, dax support needs to be paused for
> dcssblk until ZONE_DEVICE support arrives. That work has been known for
> a few years [2], and the removal of "pte_devmap" requirements [3] makes the
> conversion easier.
> 
> For now, place the support behind CONFIG_BROKEN, and remove PFN_SPECIAL
> (dcssblk was the only user).
> 
> Link: http://lore.kernel.org/cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com [1]
> Link: http://lore.kernel.org/20210820210318.187742e8@thinkpad/ [2]
> Link: http://lore.kernel.org/4511465a4f8429f45e2ac70d2e65dc5e1df1eb47.1725941415.git-series.apopple@nvidia.com [3]
...
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/s390/block/Kconfig   |   12 ++++++++++--
>  drivers/s390/block/dcssblk.c |   26 +++++++++++++++++---------
>  fs/Kconfig                   |    9 +--------
>  fs/dax.c                     |   12 ------------
>  include/linux/pfn_t.h        |   15 ---------------
>  mm/memory.c                  |    2 --
>  mm/memremap.c                |    4 ----
>  7 files changed, 28 insertions(+), 52 deletions(-)

...

I guess you want to remove dcssblk from Documentation/filesystems/dax.rst.
Gerald is back from vacation on Monday and he will likely comment on this.

Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks!

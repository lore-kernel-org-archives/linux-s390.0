Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A8A3209
	for <linux-s390@vger.kernel.org>; Tue,  1 Oct 2024 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778592; cv=none; b=BrayYrRpwCpIt47IywCzCavAz3aEm/jIZvKOu3puWQNTNB5Ekp20d1Ef+XtkxQzJ5e8At3pj0DY59Fpk0mPvDt/7WXos8B4aiQ/P/te+uOzqmjRBGAcbJw6BYGmA0v3+4CSBFS0Lbftb3GZcTxkLia3YWWA2PUg/EBb/GISvA3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778592; c=relaxed/simple;
	bh=pe4Zj15kJgX2ARZLwJTKlT1nuioo+TiEEsNHTX8/T1w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m0Mrersqoj4kYU+30YAA5yMFF1yf+FPGgI4oZY4WImss5fPcKNb8iM7yiclGblc8lui68npesk1reqJGJHFVINYSQYS2Ic+8diztdkkObCOZctmQWeWKePjlZ7TIuLxmlwScPdgyxxjQ9u/lzv1KsyJ9PKKMzB1lIQXcMZjPV9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=odvpEnER; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="odvpEnER"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4916LVWF011804;
	Tue, 1 Oct 2024 10:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	VG3OfmvRm7AEmTWv1uILD0B/40IGpSJhbrITCHAcZ5Q=; b=odvpEnERntXHrHVk
	Yp1GAH3YkMbbayIY4Jb4p3dKxcTUAiEhoycBGIvzSQFOqtOAbnH4YFjma9TVTi6O
	zxPUmfmV64Sy5bhISku6Sp8hajV2WbUaC+8tnC1f+QcWQgrBxdLVwXQSZKAZilh7
	h/c/tWvvx6B+COIIjNLraGi9JhlbzZEzKjoMJWJi5AeTwyTtAjg201sQgSdcuQde
	D91YmEU6lXSLbPhcUtSt2ahjR1kD62MS62clq8N1qN6mPJXwgAMTH0/sIZtAM/82
	GrpLY9lH1jp2Wi7PSkr8eP7sqX9Ek8Uo45MlvTIhLIB6iHZdfXFeo3Pqo5AwUp/q
	FlXE/Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420bqs166g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 10:29:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491AKLcN013047;
	Tue, 1 Oct 2024 10:29:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxbjbffg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 10:29:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491ATSSH56295798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 10:29:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C7B420043;
	Tue,  1 Oct 2024 10:29:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4507E20040;
	Tue,  1 Oct 2024 10:29:27 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.171.59.94])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue,  1 Oct 2024 10:29:27 +0000 (GMT)
Date: Tue, 1 Oct 2024 12:29:25 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox
 <willy@infradead.org>, Christoph Hellwig <hch@lst.de>,
        Alistair Popple
 <apopple@nvidia.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] dcssblk: Mark DAX broken
Message-ID: <20241001122925.52558c08@thinkpad-T15>
In-Reply-To: <172721874675.497781.3277495908107141898.stgit@dwillia2-xfh.jf.intel.com>
References: <172721874675.497781.3277495908107141898.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ruMcx1VKO3ZyLX4ztnq2rFmxFuw6PeE0
X-Proofpoint-ORIG-GUID: ruMcx1VKO3ZyLX4ztnq2rFmxFuw6PeE0
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010066

On Tue, 24 Sep 2024 15:59:08 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

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

Thanks, that's great news! Without requiring the extra PTE bit, it should
now finally be possible to add struct pages and ZONE_DEVICE support for
dcssblk.

In the meantime, it is OK to pause the DAX support for dcssblk as you
suggested, and finally remove that ugly CONFIG_FS_DAX_LIMITED. Thanks
for bearing with us for so long!

> 
> For now, place the support behind CONFIG_BROKEN, and remove PFN_SPECIAL
> (dcssblk was the only user).

Ok, I guess that PFN_SPECIAL was there because we had no struct pages for
the DCSS memory. When we come back, with proper ZONE_DEVICE and struct
pages, it should not be needed any more.

And yes, the chance to completely remove pfn_t, after Alistair's series,
is quite impressive and even more motivation than CONFIG_FS_DAX_LIMITED.

> 
> Link: http://lore.kernel.org/cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com [1]
> Link: http://lore.kernel.org/20210820210318.187742e8@thinkpad/ [2]
> Link: http://lore.kernel.org/4511465a4f8429f45e2ac70d2e65dc5e1df1eb47.1725941415.git-series.apopple@nvidia.com [3]
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Alistair Popple <apopple@nvidia.com>
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

When you also remove the now unused dax_dev definition at the top of
dcssblk_add_store(), as noticed by kernel test robot:

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>

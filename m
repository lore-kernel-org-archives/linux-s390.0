Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC3C328611;
	Mon, 13 Jul 2026 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783968758; cv=none; b=G3NK+eLSJAtgNzAdI2urByWb0q/K3VMuMTAXugxG4w+rUpThF5DnF6eb7/P4eSNy/GK/B7zADVtM4IHWKIDHpmhbCNPi+lH3vuZkdPOxDi2DU/XHZOs8R7bn15zbglMJV7hicNpqOiDEbROU2s14BVMxGazbXQhEnvymmZe8IWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783968758; c=relaxed/simple;
	bh=aP2avos0ApLO0vmoOOsh4n4R4ISILP3Q5Gbc1IF85zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AzYNvtDJ06OgUfA5WGmeSXjQ96FdX/VqUa/9L/anNVkL/76xuWrLioxPZGTUGvm5f7+EjiuJmGTdwCx6H1ezmhP1cNPWqjxSvkU8O0lXJsGWALNLvJl+YKcp2BhvvsCsA2hbbltaNCBT1DKdNPP3TpWXLrtT+Ydc7UIaE3A4I6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LLScAaj0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LLScAaj0"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DFEVup2836331;
	Mon, 13 Jul 2026 18:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aM2rq1
	+JPcTw7o7h8Yr8quaLAa2SfKE8NZOq+/HuKII=; b=LLScAaj0QFFuIgB4X3DaIs
	Ej75gXHjqn08e9CboL6Ds6uqKPxGaSCtA9xC6aRMzIOJKfo+GzIJbFYGH0/FEz2o
	JooBtIzM8AFC+qznFSM9WC/iPGmuC/M8FFT+CqtMjvNPQbByvvqJrCtl3YYXvPdk
	xGOticK17Gv2/6aH1l5j/9DTFTtfioeSiztyiU5xvcp5ABDuuzmgDOi9PRq1n4d0
	7ZPuq3xOCV/ZO8lDXjkofW8l6wZC45FpxDPRzjD9PkYaZJyU4u5gwGA7QK5O8uwk
	iZkuVQQm9YQMKsmHv/jol1JLdv5HduA0QKnSL9OBsgWQr2rfSXvHZoZWEj/ZBXVQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxa9y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 18:52:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DIniZ2030009;
	Mon, 13 Jul 2026 18:52:32 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nh72qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 18:52:32 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DIqVAl49938804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 18:52:31 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E612C58054;
	Mon, 13 Jul 2026 18:52:30 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DF275804E;
	Mon, 13 Jul 2026 18:52:30 +0000 (GMT)
Received: from [9.61.242.131] (unknown [9.61.242.131])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 18:52:30 +0000 (GMT)
Message-ID: <c1d28b60-7976-4659-a967-248bea238cc6@linux.ibm.com>
Date: Mon, 13 Jul 2026 11:52:29 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 0/3] [VFIO] Error recovery for vfio-pci devices on
 s390x
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
References: <20260630165553.725-1-alifm@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260630165553.725-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o5_HBqG-QjaQ3udskuomfbkglZljehHe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE5NCBTYWx0ZWRfX32pSs4h9DqAw
 9LAryaIC6ANfOgLboZif1FhSF4oCB0IJveD6tInGqeHTPO2mRT5cSxxFMETihB5ZNhH9pots/wA
 32ntMssOujGobh6apdqJ9KT79cRXyK4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE5NCBTYWx0ZWRfXwx3TgBqFybT+
 hZrMOMIdAmiKyd2xoa/J/lm0iDvD/Hd11SUQfq/vPjyrREpEK9kw0hxwHRStF/rqvw7BfN4dBKb
 veR+ErYZ98ojB8YG4YqcMVRCYGpRmia3nrQ08f4lDXX3VV9cscyURrfTAA+ct44SeWIs4e0r5EA
 6zKME8+nuA5KSrGhiQQ3NJV4YSBEJ5sfZnBLmsNkRAkXBJWwh2t5iN/csipMwaxhb058RyGIJ7/
 LiTgtQPlVfHOSZd3fQhK9MBxfwAURHGvTFMLAjR9oPxDmSfvzEJB2yGsNfu1c2+BvHpEbY+9/U9
 l2B5QvbwluKZceCBlywmpCNJIlCF5HrHzbRibnhsvZEP8Qds8eagzumA1m+p7J9FkxswM9Nb5Yp
 txeWDG4tI6Pog/PRvTuNrazOhluvwBQxy/LdX6xHzMRVMecQxIGMd7+JGGk9dwn/DQ+NKvjkDXR
 f8NBG6HGK2Ph/vvFwhw==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a5533f1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8 a=29iEHxvmWTY-H69hz_cA:9 a=QEXdDO2ut3YA:10
 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-ORIG-GUID: o5_HBqG-QjaQ3udskuomfbkglZljehHe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130194

Polite ping for the series.

Thanks

Farhan

On 6/30/2026 9:55 AM, Farhan Ali wrote:
> Hi Alex,
>
> This patch set includes only the VFIO patches of the original series for
> error recovery for vfio-pci devices on s390x [1]. Breaking up the patch
> series into PCI and VFIO only patches to make merging easier based on our
> discussion [2].
>
> Thanks
> Farhan
>
> [1] https://lore.kernel.org/all/20260520171113.1111-1-alifm@linux.ibm.com/
> [2] https://lore.kernel.org/all/20260602163344.1eda12d2@shazbot.org/
>
> ChangeLog
> ---------
> v19 https://lore.kernel.org/all/20260615183616.2902-1-alifm@linux.ibm.com/
> v19 -> v20
>   - Change device feature uapi to pass the error data as opaque to
>   userspace (patch 2).
>   - Rebase on 7.2-rc1
>
> v18 https://lore.kernel.org/all/20260603182415.2324-1-alifm@linux.ibm.com/
> v18 -> v19
>   - Fix hole in struct vfio_device_feature_zpci_err.
>   - Remove reset_done() callback for vfio-pci driver.
>   - Rebase on 7.1-rc7
>
> v17 -> v18
>   - Print a warn with dev_warn_ratelimited() for copy_to_user failure.
>   - Rebase on 7.1-rc6.
>   - Break patch series into VFIO patch set.
>
>
> Farhan Ali (3):
>    s390/pci: Store PCI error information for passthrough devices
>    vfio-pci/zdev: Add a device feature for error information
>    vfio/pci: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX
>
>   arch/s390/include/asm/pci.h       |  32 +++++++
>   arch/s390/pci/pci.c               |   1 +
>   arch/s390/pci/pci_event.c         | 137 +++++++++++++++++++-----------
>   drivers/vfio/pci/vfio_pci_core.c  |  10 +--
>   drivers/vfio/pci/vfio_pci_intrs.c |   3 +-
>   drivers/vfio/pci/vfio_pci_priv.h  |   9 ++
>   drivers/vfio/pci/vfio_pci_zdev.c  |  63 ++++++++++++--
>   include/uapi/linux/vfio.h         |  23 +++++
>   include/uapi/linux/vfio_zdev.h    |   2 +
>   9 files changed, 216 insertions(+), 64 deletions(-)
>

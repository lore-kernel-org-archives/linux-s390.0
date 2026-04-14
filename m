Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F23C3DBD59;
	Tue, 14 Apr 2026 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175765; cv=none; b=lX0SZBdzY73UD+RwAyMUYhZY8ZVKjv82GyMvddHuAHWmk8Rsc5wFgn+AjknWsZo5VAewtdnbOinssqzhNQGIbfu8crXeky1lNLEJzSZRz0C0ZocU3Dv6fTD+M++eO3bnTDpFNoWtdxNeu2bVk2hMC4lwImV9lrWFqBnB2mYLxf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175765; c=relaxed/simple;
	bh=FC6Wkxbbst57Y5XcZOl8gezbYkCIWVatKXhNcU0I1xk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=faiIGTLzHQNJWywj7bl77xq/mGw06PwCKxAXxhB54udIQLtmEOwcjc5UrV3hdtsxCIiTjY4GkzNPmm99LkJ2SrcA3yJR01lova+ZOlZnC/3iwjOr5R727n+M1QlTLOani2bet1cDXvoQgpmNIVkCJy26B8m964VtHbmJxTeQ7Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KJBg/26O; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KJBg/26O"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EDUuQc1805230;
	Tue, 14 Apr 2026 14:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Dzjv3g
	OdxZg/qy/ibAPB0hyId1JXFg7fjfcqXZpWbUY=; b=KJBg/26OxUp93sDT/mVnHv
	abp2h/D5mL3nj3XsikKFoH9IY1xr369fd3CiXfE2yHPWpTqzCd4OOr2/HuMOYK0l
	USeaKQLMjBoXI28HCD10gaW56ZAlwdFXB2W26yn/lTY5QTlBrcike0mCT9xadA1Q
	VYGcGapJQK83nYevRZWHguqsYIz7iuJJYS+6dmtEWlnODGNPQoGz0mB7rLMg4bTT
	B3GIXCfHGB9CN4z6ww0f0LHmSFhYMp7F9yoer8VK2Ur9uCqj3oY1Ourn4MpLYpbe
	rUwGwUAtvDU0DaX9HvZSy/pUAq1pQ0tBq273I+0/VaBVlDQxf++drvN5uZFTUa6g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89k2y5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 14:09:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63E9rVgB004179;
	Tue, 14 Apr 2026 14:09:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24k9p7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 14:09:17 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63EE9G4v26542632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 14:09:16 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CB5E58059;
	Tue, 14 Apr 2026 14:09:16 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CAF55805B;
	Tue, 14 Apr 2026 14:09:14 +0000 (GMT)
Received: from [9.61.29.199] (unknown [9.61.29.199])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Apr 2026 14:09:14 +0000 (GMT)
Message-ID: <256d54de-759e-4855-b4c5-c955d0b63cc3@linux.ibm.com>
Date: Tue, 14 Apr 2026 10:09:13 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] s390/vfio-ap: Add live guest migration support
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
References: <20260407205100.331150-1-akrowiak@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260407205100.331150-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aBk2v-xuzVCRYusMM2TSVY9e34UcDHEl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDEzMCBTYWx0ZWRfXy/jxozXlQo+/
 +yCaUgv8G9ftDwJoOh8jPYcR6GmbEiiiyludfSepgCxlP1x3cL2rNZjyOBMdH4ILcA8XU5Nr0Fc
 OE0xHM9QYLPGoyhbt3oKjZsh56tV5VXLkdXhBRYMIEl/4k3z0HyE3IqzxBMqUQdC+ngsG8zACqw
 GVCjz4fusTgvNgH5pJlwJcXtrdglD1frLDUlIAbWYgygqztWd0kEkO1GezBS6BSWOxXJwGTzeN5
 QEdLTeTpsmvFxXdo7Hj+AfS9uBgwHQ+6GBKKJqwtdU7Pi1D1FSuFl6+LmG+iiK94E17qYruFjlt
 TLivVRwzYd++1VlFHxhezjUOfzAY7kziXAgT7BgrxVgSTO1846Rd1pKAZxxRKVEWEAJ1wqXp/wM
 McbMIzllSkDPDvorSyGR/ive3BiHUOJRXcp2yELj6lxrR+yn2UWOyaTQqrpsw84yeabA3gWNw3x
 qgSNd752257wGbqH8RQ==
X-Proofpoint-ORIG-GUID: aBk2v-xuzVCRYusMM2TSVY9e34UcDHEl
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69de4a8e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=BeJFQei6KuwYuYFmKvkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140130

PING ....

On 4/7/26 4:50 PM, Anthony Krowiak wrote:
> This patch series implements live guest migration support for KVM guests
> with s390 AP (Adjunct Processor) devices passed through via the VFIO
> mediated device framework.
>
> Background
> ----------
>
> The vfio-ap device driver differs from typical VFIO device drivers in that
> it does not virtualize a physical device. Instead, it manages AP
> configuration metadata identifying the AP adapters, domains, and control
> domains to which a guest will be granted access. These AP resources are
> configured by assigning them to a vfio-ap mediated device via its sysfs
> assignment interfaces. When the fd for the VFIO device is opened by
> userspace, the vfio_ap device driver sets the guest's AP configuration
> from the metadata stored with the mediated device. As such, the AP devices
> are not accessed directly through the vfio_ap driver, so the driver has no
> internal device state to migrate. It's sole purpose during migration is to
> ensure that the AP configurations of the source and destination guests are
> compatible.
>
> Implementation Approach
> -----------------------
>
> This series implements the VFIO migration protocol using the STOP_COPY
> migration flow. The key aspects are:
>
> 1. Hardware Information Capture (Patches 1-2)
>     - Store AP queue hardware characteristics at probe time
>     - Provide access to queue objects for validation
>
> 2. Migration Infrastructure (Patches 3-5)
>     - Define migration data structures
>     - Initialize/release migration data on device open/close
>
> 3. State Machine Implementation (Patches 6-13)
>     - Implement required VFIO migration callbacks
>     - Handle state transitions: STOP → STOP_COPY → STOP (source)
>                                 STOP → RESUMING → STOP (destination)
>     - Use file streams for AP configuration data transfer
>
> 4. Validation and Callbacks (Patches 14-15)
>     - Implement migration state and data size callbacks
>     - Required for VFIO_DEVICE_FEATURE_MIGRATION support
>
> 5. Documentation (Patch 16)
>     - Add live guest migration chapter to vfio-ap.rst
>
> Compatibility Validation
> ------------------------
>
> The series includes comprehensive validation to ensure source and
> destination AP configurations are compatible. For each queue, the following
> characteristics must match:
>
> - AP type (target must be same or newer than source)
> - Installed facilities (APSC, APQKM, AP4KC, SLCF)
> - Operating mode (CCA, Accelerator, XCP)
> - APXA facility setting
> - Classification (native vs stateless functions)
> - Queue usability (binding/associated state)
>
> When incompatibilities are detected, migration fails with detailed error
> messages identifying the specific queue and characteristic that caused
> the failure.
>
> Configuration Management
> ------------------------
>
> This implementation does not prevent configuration changes during
> migration. Configuration stability is an orchestration-layer
> responsibility, consistent with other VFIO device types. The driver's
> role is to validate configurations and provide clear diagnostics when
> incompatibilities are detected, enabling orchestration tools to implement
> appropriate policies.
>
> Change log v1 to v2
> -------------------
>
> - Removed patches that attempted to block configuration changes during
>    migration due to inherent race conditions and incomplete protection
> - Simplified approach focuses on validation and error reporting
> - Reduced series from 18 to 16 patches
> - Rewrote the description in the cover letter to better describe the
>    patch series, remove confusing comments as well as references to
>    function provided by the patches that were removed.
>
> Anthony Krowiak (16):
>    s390/vfio-ap: Store queue hardware info when probed
>    s390/vfio-ap: Provide access to queue objects and related info
>    s390/vfio-ap: Data structures for facilitating vfio device migration
>    s390/vfio-ap: Initialize/release vfio device migration data
>    s390-vfio-ap: Callback to set vfio device mig state during guest
>      migration
>    s390/vfio-ap: Transition guest migration state from STOP to STOP_COPY
>    s390/vfio-ap: File ops called to save the vfio device migration state
>    s390/vfio-ap: Transition device migration state from STOP to RESUMING
>    s390/vfio-ap: File ops called to resume the vfio device migration
>    s390/vfio-ap: Transition device migration state from RESUMING to STOP
>    s390/vfio-ap: Transition device migration state from STOP_COPY to STOP
>    s390/vfio-ap: Transition device migration state from STOP to RUNNING
>      and vice versa
>    s390-vfio-ap: Callback to get the current vfio device migration state
>    s390/vfio-ap: Callback to get the size of data to be migrated during
>      guest migration
>    s390/vfio-ap: Add 'migratable' feature to sysfs 'features' attribute
>    s390/vfio-ap: Add live guest migration chapter to vfio-ap.rst
>
>   Documentation/arch/s390/vfio-ap.rst     |  325 +++++--
>   drivers/s390/crypto/Makefile            |    2 +-
>   drivers/s390/crypto/vfio_ap_drv.c       |    4 +-
>   drivers/s390/crypto/vfio_ap_migration.c | 1095 +++++++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_ops.c       |   66 +-
>   drivers/s390/crypto/vfio_ap_private.h   |   10 +
>   6 files changed, 1395 insertions(+), 107 deletions(-)
>   create mode 100644 drivers/s390/crypto/vfio_ap_migration.c
>


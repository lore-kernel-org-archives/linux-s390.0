Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA3943CEDB;
	Tue, 28 Apr 2026 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381853; cv=none; b=IzbEVoGoEZSPPED4mI/+zkpby0qskvM2YwqODtJsKmRrhicikf/9OOyF7iT1Oqy/aNgKVBH8Im80FVYbxEIT9O3MVR9Vfr5rDO2qWoR89OatFHLg5KmPrRu4acBY+D0Q65Bf5NGKn1/+aKAh7S2R/YhpeDbl/0u5YwdOvWtHaK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381853; c=relaxed/simple;
	bh=Sid/z4CgvRLw18mvZwMqgsjNQ2pzZT2cIjSX48lVGyw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gg5DsAsPIjAyZx3tcpYK5b+e0rWi7Y2rz6vlCEKAt4jwzYSbwlCiynq2AvE0XL74zY8oV3BBxoRngM4R5xSI6wPZ99mVgVpeTr10751KhA0en9PVBgdfXfZsM8pW54Hb3faXm2TsVBXq0Li2qvw32hbCEgadrKLXsu4bLSroNN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hGP3KEmO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hGP3KEmO"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S5UTgI2888876;
	Tue, 28 Apr 2026 13:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gfRtKu
	HlVmMHJO6BW7QWn1VT81HdF1hNevAfsCHPxtw=; b=hGP3KEmOpBruOqVHNUv8MU
	ail+3tuZ5FII6c7ikBU6maUpJwbTVVxM96NSHGGBsPrGJS9FOliYoOStJbVv1Ggs
	Sf8D6YBmwFuNvgXwXaUYWoWxAyIzz8HpqItpuI3VXw0KRXLcerNuywfFvd7MKCU6
	uPXE1eWxWIceCutm6OvdT4z6wNhY+JzT2+c7OTbKAS2M8upUvNCXSQiLcyCKcPlS
	HlfvQNvA4gG/7rmqs6+AFR3ymvdNzGwYRxFO773LxQciaW+5rheR++/kmJdWnTqE
	RfkOPFtBbl56cfgBTfTzbwPLSgwZPyHmwIZ2/IuGIScQQHJ59bnvds+BdcAuo7Qw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb55km1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 13:10:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SD8nWv013775;
	Tue, 28 Apr 2026 13:10:45 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamy9js5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 13:10:45 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SDAijL30212668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 13:10:44 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6012558063;
	Tue, 28 Apr 2026 13:10:44 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C020F58043;
	Tue, 28 Apr 2026 13:10:42 +0000 (GMT)
Received: from [9.61.116.216] (unknown [9.61.116.216])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 13:10:42 +0000 (GMT)
Message-ID: <e8e07556-4618-4203-aaf7-e2e95c6fea71@linux.ibm.com>
Date: Tue, 28 Apr 2026 09:10:42 -0400
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
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f0b1d6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=BeJFQei6KuwYuYFmKvkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDExOCBTYWx0ZWRfX+1DWY3odoY9T
 vfWYBq4igT73rZt6ofA/OI1Mgv+5g3AjOoe7mpQ3Jy1PRo77WeJVG4+eYH+psCItQDEfkf0v600
 QfDEwQ4sOwgw/paBf274g+PEiX5RpGV8ZukqnOGNZA7gd0+e3m5z9JMBd3v7L7vGQfT8oaRa66B
 pHvpZ6D6ngyc8X3ALsNmMoVVYng3EAuAlIKqlaGld4MC8E/m83RQhqgvkpTKgayJ45Wgu2zmUeH
 8Z8WfLH3ebfQAsOQkzB/0irqVvYyVBHsTaUhuAiNRr5n1AGewqiI0bmJfhLjZuP2XV4BpH9sWNm
 XnQsoPxGMx6XdyS+qLxNn7FmanT8B3DVfP3K9B8iYl5HQHW8cfBe0afZtgXSfNbb2adnXaFaDU1
 3vKr0lRrfTzLH2qMKIuGJSrZOf8qzqiND/a7L6yk0uxpFcw4jFEI8rIpexMhoPFVniielQU7VUT
 eSOlM4y7RBjKCE/oSZA==
X-Proofpoint-GUID: UJ93p8TfSaY5tolP2vGV_sG5hEenNJQi
X-Proofpoint-ORIG-GUID: UJ93p8TfSaY5tolP2vGV_sG5hEenNJQi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280118



On 4/7/26 4:50 PM, Anthony Krowiak wrote:

A patch review would be greatly appreciated.

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


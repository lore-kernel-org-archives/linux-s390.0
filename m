Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF39C3CCFA5;
	Thu,  9 Apr 2026 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744593; cv=none; b=VYTmT3k2Lnvi3cezDBIQNeXTOQMNIC4HgafvWHUlhfM6S+Mw04DR1wvnOugnM3hvSMpwUvGVWWL8rqOHGq3hr+8EUTkgq0+u15gDpauVNq3LufaZ/CLfLz0FSrxqxffp0+7jA6QXWZj4nRm+ePKFuzA8udr+epwzmj4kvchUpSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744593; c=relaxed/simple;
	bh=oGD/9ZVmzzLu5MijekPKbi5ia9AHxZHxrB3rOMRMbdU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=drbFxzv2afurrRTye6EX1LBYgldgnyQOXTQHUPWabWpxykRmJYdbb40bskBzNAxjVgR+w9j2B8J1oJnn1o5zxJjL9LzKIw+fklFlBpVi/ljxZ+BZP2W4A1HCkg96kj6BtWl/zDQq+HXJ/IXk5juRNsBjkif5FL3RnNNoHQvfSxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c/DtjUtV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c/DtjUtV"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639BTVVk2318761;
	Thu, 9 Apr 2026 14:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+SADfR
	JtZpHq00wR1lgbVohFDaEDS6/zHI4cEd1P+94=; b=c/DtjUtVHCebyGademx6WF
	xAmBXUG7yNDEHSwI5hQpZJvpP5AkUoXqz4OcDCjLHu2V7fsSSfMdK10pT6T42pE1
	ClhRAuzIAopfIwB/DqvAKv5yUxTC+mcdxDIzwXWJ2hfmU4KemiUYN70Zmb8RqgFc
	Q4G52apXQxQxd8HkmWsJOYOmJEfnlZ1eAzZGqAoGH8EvlWrmKuJPLYM0VnK/zd9R
	hC8HH/24EXZGiQLBQVJoiIlk5VWQpLXqINqS0GLylfclXCBJU3IXEt91fW0ttflt
	g2u/Caxu6++SqTW+y1BaZqQ6GY8QblUDzJl9O4xMEwsHb7OMYxX4OgONQA9C1qNg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2g5d91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 14:23:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 639D1qr9007898;
	Thu, 9 Apr 2026 14:23:04 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2kwqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 14:23:04 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 639EN2Bg52494766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Apr 2026 14:23:03 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D77625805D;
	Thu,  9 Apr 2026 14:23:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E0FC58053;
	Thu,  9 Apr 2026 14:23:01 +0000 (GMT)
Received: from [9.61.93.104] (unknown [9.61.93.104])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Apr 2026 14:23:01 +0000 (GMT)
Message-ID: <1a43bf88-a2d0-49b8-9f2d-ac01c7b0e7c2@linux.ibm.com>
Date: Thu, 9 Apr 2026 10:23:00 -0400
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
X-Authority-Analysis: v=2.4 cv=FKArAeos c=1 sm=1 tr=0 ts=69d7b649 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=mDV3o1hIAAAA:8
 a=BeJFQei6KuwYuYFmKvkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: njrn64jVn4_ZrnRhwRzfzLHwOMkkYUD0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEzMCBTYWx0ZWRfX8Y4XMPWZUUOx
 jLy0SXiqp3EvvFX2Cqh7mIbTBBxAwxRrbjpYNdZ+rUQ3buHkWor9pZlr73SqRlSug2yYzG6O5zK
 +0qUYAnwGvnqy4cvIXANWwd4/QZwvkwyMcNOHgSZpshvBlu3Yq3wc683caX3T28uJfDmmeB0LiP
 uKTjb9c7WF5d6ei1e8fyvkPV4tR6xnn2CjhYGAwwLfiWOPrwghcsaa+LJh0CZAdJG3sf6bZgfSw
 N6cKgFts5IbV0KDG+s8Er0RfXUrRWU+jzTktW1ZMEofgjWeLUNDRSBThYnbgzhyT95KNkE2s/ep
 ABcXJ1ky/TG92+sI1AQEVALQrkP3990tLUFXkKQV7tzc5woB8D8rF7C7Q3u3NE9ooBW0j/jYl8F
 7XtunFFGLqK2Uya8X8v55D+GVDWdSC+oV6kIaK9RNFDD46a6JWtYeWiFOvRCDUegXJSybq01bb7
 xJ3ukwnN5wWrQ7VmwfQ==
X-Proofpoint-GUID: njrn64jVn4_ZrnRhwRzfzLHwOMkkYUD0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090130



On 4/7/26 4:50 PM, Anthony Krowiak wrote:

The corresponding QEMU 2-patch series that orchestrates live migration
of vfio-ap devices can be viewed here:

https://mail.gnu.org/archive/html/qemu-devel/2026-04/msg01421.html

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


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D14441C30E;
	Tue, 31 Mar 2026 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978965; cv=none; b=F8CP19uLXLKc4SfZyAmDiXK9ySdzaLVRrm6UUt/9WDVujm+S2FeM9p5Gvli5HSmbF2zvKKPGuoCBd42w3dQw5bjXAGYepXTApGLUuCE8nQiVRVdceiPvWZKbTlVKXuac70Bl5RVXLI0ydI1A5R5SGL+M3lYhW3cxUTIxFwqALJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978965; c=relaxed/simple;
	bh=jc+vpXWKLgGTB6nJ4vIYPstg2tTxgpwO3tFsDbyn3EE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2tVZKRlFbtuLmxfddy2jt3NFtN+FUxrvg62IcZV0oTy5f0AaAYBvAyiDJRlo2k2Ffu+gl0p/meA4rEG+98s0DZk6yJnIz2GuAhTHtd3YuvzvNl1XCjVpKda2JWEJP5jB147RFqTeyzS++2Nbw+F4bHvdYNEOGIVzDYPcuku2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rrDy0P5w; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rrDy0P5w"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V94OYc458927;
	Tue, 31 Mar 2026 17:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LDgmWT
	AFIezP44/A+JNZgWu42P/6pnwFaOlGzLO+GAA=; b=rrDy0P5wOW+oqZPA3lK++T
	0tApMu07dVDPXG0+iArTmQ6VKuhjSN7/jV5ftdjw2JS2dO3vWthlVq5d1WHgpP0y
	sOyKPYaUiibx8YoOp1AHGZlFeSX41bq5kqsPFgWzKHRdTVn+lrh/qJf+gKlN+Cx8
	CbM7C76PG00FAGkzy573ylm66a654sEq8PCf3tWMdcagQoJ8ru4xZvnu26gRNqWA
	Zw4E3HyGS0kDahlNUxVcdUVbV393WZgof3Fjy6zXScO8i2tunEGadVnS4iFX/ooJ
	oAbSMgGS1FEWAIcOKdOvWBy1irZ/cPZhIIzsqd2HqmJLQYHAs5AkTJXJEaJVTXXA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms42dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 17:42:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62VGTusT030990;
	Tue, 31 Mar 2026 17:42:29 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjt1hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 17:42:29 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62VHgRcu26215024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 17:42:28 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF93C5804E;
	Tue, 31 Mar 2026 17:42:27 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 862355803F;
	Tue, 31 Mar 2026 17:42:26 +0000 (GMT)
Received: from [9.61.9.136] (unknown [9.61.9.136])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 17:42:26 +0000 (GMT)
Message-ID: <e17202d6-8ec8-433f-ac45-77c1744bc92c@linux.ibm.com>
Date: Tue, 31 Mar 2026 13:42:26 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/7] vfio-pci/zdev: Add a device feature for error
 information
To: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        kbusch@kernel.org, schnelle@linux.ibm.com
References: <20260330174011.1161-1-alifm@linux.ibm.com>
 <20260330174011.1161-6-alifm@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260330174011.1161-6-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cc0786 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=0OExlHRRN86mAw9WzlYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE2NiBTYWx0ZWRfX2IVxEMt4PjmS
 t7mlEiWnp/s5kJOACo68kaU3e5jxv0Op3fJmWYLcgw/WSwGHAMYbN+J9e/6kAUv1iRHiY8GmF0d
 3k9SISje9efoyB0n1FkAEK6H9n5qPIJ3iZg6dpgveFKYIj/evV+XZlAl03t7bBe+eR0ZpeqEURU
 nz/j45YBOWvr/mBJAUwmXp9nW/qllDhpmFGo1Q4DbISMmC1oNT53e6yAT832WPGyphTuccUlDdP
 v704/6X7ecdRyeYPvCnlNAPeZ1MVrDciXMFPzGE1GSMAhdV3v6GRtSI762ljcMzjwc0SoEAo299
 T16WLLwWPUDh/ApDBbM3527iHlZRjcF49fL6fiiXxg8cKY/PIfx97XIY7b/70L6n1RDwGDz5O8o
 PuGER9zCSh/714cTzs9BJ/owMlbpk7Els0xm2QaosHWoEwbwkbhc4n22f8GmCN1fSbfRtnr6yyR
 pKDbu1apas9Ff+Vs5Ng==
X-Proofpoint-GUID: S5GqYrq2BMrqdTQx4Whhxe3DNZgwhw-g
X-Proofpoint-ORIG-GUID: S5GqYrq2BMrqdTQx4Whhxe3DNZgwhw-g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310166

On 3/30/26 1:40 PM, Farhan Ali wrote:
> For zPCI devices, we have platform specific error information. The platform
> firmware provides this error information to the operating system in an
> architecture specific mechanism. To enable recovery from userspace for
> these devices, we want to expose this error information to userspace. Add a
> new device feature to expose this information.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

Nits and a questions below


> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
> +			      void __user *arg, size_t argsz)
> +{
> +	struct vfio_device_feature_zpci_err err = {};
> +	struct vfio_pci_core_device *vdev;
> +	struct zpci_dev *zdev;
> +	int head = 0;
> +	int ret;
> +
> +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
> +	zdev = to_zpci(vdev->pdev);
> +	if (!zdev)
> +		return -ENODEV;
> +
> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
> +				 sizeof(err));
> +	if (ret != 1)
> +		return ret;
> +
> +	mutex_lock(&zdev->pending_errs_lock);
> +	if (zdev->pending_errs.count) {
> +		head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
> +		err.pec = zdev->pending_errs.err[head].pec;
> +		zdev->pending_errs.head++;
> +		zdev->pending_errs.count--;
> +		err.pending_errors = zdev->pending_errs.count;
> +	}
> +	mutex_unlock(&zdev->pending_errs_lock);
> +
Question: intentionally dropping so we don't hold over the copy_to_user?
 That makes sense to me; but if not then may as well use guard(mutex)
here too.  Does not affect my review tag.

> +	err.version = 1;
> +	if (copy_to_user(arg, &err, sizeof(err)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>  int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>  {
>  	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index bb7b89330d35..2552eef42000 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1510,6 +1510,24 @@ struct vfio_device_feature_dma_buf {
>  	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
>  };
>  
> +/**
> + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
> + * userspace for vfio-pci devices on s390x. On s390x PCI error recovery

'On s390x, PCI error...' (suggest comma)

> + * involves platform firmware and notification to operating system is done
> + * by architecture specific mechanism. Exposing this information to
> + * userspace allows userspace to take appropriate actions to handle an

'userspace allows it to take...' (reduce repetition of the word userspace)

> + * error on the device. The pending_errors provide any additional errors
> + * pending for the device, and userspace should read until zero.
> + */
> +
> +struct vfio_device_feature_zpci_err {
> +	__u8 version;
> +	__u8 pending_errors;
> +	__u16 pec;
> +};
> +
> +#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 12
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**


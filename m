Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C1B38F94B;
	Tue, 31 Mar 2026 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774985239; cv=none; b=dKbB7bFZ1yhOOSGMfKQ3pEp2nNIEFF7LGMq1wcFqV9fo2aquPQns/CpfQFsoiIubrUzw/xXJ8qMnFh7cJyZy2PNt4lTuqm4tpOY5DjZ0Bv5Qz6EqmIjrkNM7DzrGchJWvk9tojAQGE2Tcl1n7V3fhY/N36NnO7NX9JHGBykCYzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774985239; c=relaxed/simple;
	bh=DXAot7jA57i0vD196ntj8Llg9KGzKdZiBHf00yLox2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGXeItXhQa3p169OTl/wdukSJnxBTdVkqkJIRz/amGl2EyuAzSYgfiLtyyT/MkyHbNzwtdDuTe6UkpOSnv4z7zkc1TNigiHCH1BNUMQzK9gCGHRTtDenK85ZBuHcl6TnYDjKX1NPVrZB5gxVm0mBS8+oRKOFB8BMcfMmbeSQr7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nZmNvpPU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nZmNvpPU"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VEWbWP3415434;
	Tue, 31 Mar 2026 19:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+WdD1M
	mJOrucE6rwdPklWg5nGgFgEKWFEuXnO83wTsQ=; b=nZmNvpPUjxn+65Ifn39lCX
	7lgxqmn10rH4NXSereuc48OqIunxQ5ddGwoyJXYHMxFNc4cwOsYJduwuFzhAOBjV
	V/X/VMizWVbv/uAMFN78ZunAHfRylclQojdxqv3yTDFKlbm3xwb1HEe8TxXTdPZf
	0NZgynUX1FPH08pONQ/v5T3meE/N/IYKMGMvkYoqw1byApt7UJpcPjb8KbBuVoCw
	/W3BN5RgxI1dvRB+YODzYexmOdrrixZ96ixd+0XxVNaszcLbggMXLCqkbnM2EphS
	8z8MnYAfXgB2hwLC20fq3WlfbJ3nRpiCHHXO2wOzwYezv8tfyApPoy9cpGKCZGmg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q351bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 19:27:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62VJADhm022227;
	Tue, 31 Mar 2026 19:27:09 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tan2kh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 19:27:09 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62VJR8CE15270426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 19:27:08 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6121F5805B;
	Tue, 31 Mar 2026 19:27:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42CED58059;
	Tue, 31 Mar 2026 19:27:07 +0000 (GMT)
Received: from [9.61.250.144] (unknown [9.61.250.144])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 19:27:07 +0000 (GMT)
Message-ID: <c66f25ac-6fe6-4d3c-8005-0e09c94613b8@linux.ibm.com>
Date: Tue, 31 Mar 2026 12:27:05 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/7] vfio-pci/zdev: Add a device feature for error
 information
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        kbusch@kernel.org, schnelle@linux.ibm.com
References: <20260330174011.1161-1-alifm@linux.ibm.com>
 <20260330174011.1161-6-alifm@linux.ibm.com>
 <e17202d6-8ec8-433f-ac45-77c1744bc92c@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <e17202d6-8ec8-433f-ac45-77c1744bc92c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fDZwEfLvCt8nKTNPOcG1m12O4rC-UxTx
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cc200f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=qNG8fd7tPmr0NF9BgyQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fDZwEfLvCt8nKTNPOcG1m12O4rC-UxTx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE4NiBTYWx0ZWRfX2WsdkQnsqtN0
 sUa7h8WWlyQsyrhPX+9luEvj2tdHIYL7cu8b9fFKA8bpsOEk3mBTTwgLeWxrFwr4hOp5VAI0RYK
 N1Fa8e9kATr3dHzszhms7nu7MCjQVUdZISTfIoQCDwNPsKz67EXeEDYyTTrN1Wjmn6+YaaIvLyd
 8TM7st6F0pTQ1hk8ztBP5PWkNMJft62RZWexlHuadbE/gw1jZ0KNfZ2s9Ig/tlVBFJiXK941Tju
 U6sSZGa0xdbYdXdagIH+mWJAv2QKBReun7Zjp7W7rYv8WYskf/qQXlWd/AfzneX+dkp0Lv0+ZQr
 FsJeK4L4rSbkG5pyrfnhgXO+dCVouk6sP+7wVzVEr8lu+JzwFF+H2g+70c0EiK+uG9MrDi0KV6I
 ivFfoAlQ0L547k0xVz8UCa8U+0gQuS2WHhRZ7WdS7nCoUiLfHbG6KcjA+mAsqqXKu905vjLr+kd
 irRpTtc5g2+UrWQY06A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_04,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310186


On 3/31/2026 10:42 AM, Matthew Rosato wrote:
> On 3/30/26 1:40 PM, Farhan Ali wrote:
>> For zPCI devices, we have platform specific error information. The platform
>> firmware provides this error information to the operating system in an
>> architecture specific mechanism. To enable recovery from userspace for
>> these devices, we want to expose this error information to userspace. Add a
>> new device feature to expose this information.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>
> Nits and a questions below
>
>
>> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
>> +			      void __user *arg, size_t argsz)
>> +{
>> +	struct vfio_device_feature_zpci_err err = {};
>> +	struct vfio_pci_core_device *vdev;
>> +	struct zpci_dev *zdev;
>> +	int head = 0;
>> +	int ret;
>> +
>> +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
>> +	zdev = to_zpci(vdev->pdev);
>> +	if (!zdev)
>> +		return -ENODEV;
>> +
>> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
>> +				 sizeof(err));
>> +	if (ret != 1)
>> +		return ret;
>> +
>> +	mutex_lock(&zdev->pending_errs_lock);
>> +	if (zdev->pending_errs.count) {
>> +		head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
>> +		err.pec = zdev->pending_errs.err[head].pec;
>> +		zdev->pending_errs.head++;
>> +		zdev->pending_errs.count--;
>> +		err.pending_errors = zdev->pending_errs.count;
>> +	}
>> +	mutex_unlock(&zdev->pending_errs_lock);
>> +
> Question: intentionally dropping so we don't hold over the copy_to_user?
>   That makes sense to me; but if not then may as well use guard(mutex)
> here too.  Does not affect my review tag.

Yes, exactly. I didn't see a need to hold the lock over copy_to_user().

Thanks

Farhan

>
>> +	err.version = 1;
>> +	if (copy_to_user(arg, &err, sizeof(err)))
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
>> +
>>   int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>>   {
>>   	struct zpci_dev *zdev = to_zpci(vdev->pdev);
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index bb7b89330d35..2552eef42000 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1510,6 +1510,24 @@ struct vfio_device_feature_dma_buf {
>>   	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
>>   };
>>   
>> +/**
>> + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
>> + * userspace for vfio-pci devices on s390x. On s390x PCI error recovery
> 'On s390x, PCI error...' (suggest comma)
>
>> + * involves platform firmware and notification to operating system is done
>> + * by architecture specific mechanism. Exposing this information to
>> + * userspace allows userspace to take appropriate actions to handle an
> 'userspace allows it to take...' (reduce repetition of the word userspace)
>
>> + * error on the device. The pending_errors provide any additional errors
>> + * pending for the device, and userspace should read until zero.
>> + */
>> +
>> +struct vfio_device_feature_zpci_err {
>> +	__u8 version;
>> +	__u8 pending_errors;
>> +	__u16 pec;
>> +};
>> +
>> +#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 12
>> +
>>   /* -------- API for Type1 VFIO IOMMU -------- */
>>   
>>   /**

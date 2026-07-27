Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB17A3CBE79;
	Mon, 27 Jul 2026 21:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785189305; cv=none; b=n5ncaY3pDG6KT0RUL4ACuW8XJfvWWGddc2OrvgPkU+iugFwq7wjWMJ3y2HGD9Gmw2DsWDxCcrA0VXmG5KdSc0RXt3JYBkoTcDnamDwkM/3zdanHaFTa/mwtnd6gX5uz8jx2d1clZZYIHhTjDMf2G/V/Sb4mvf8NqUI1trcmXlJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785189305; c=relaxed/simple;
	bh=mUxnC7mrSP9pZhfJg0EgTabIMyd9VcbsCPiif50T+Mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGh9aJru/hN3tJm6MUxZb4ciZmzwL8x5NCWMB+HW+UIqcL7L+1YZQvUOPTJqmFqxHwaIHIoDN0IkD0+2i5LCxl5ZaCm//U/Y9objBSEAiA/xLNssRmZGKaPq7BBpQB+W3BhGPPDTcC649OhesJnLoJfbTLCqKgnHmPXmYOJktD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MxB6FwFl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MxB6FwFl"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RLlkIx3433163;
	Mon, 27 Jul 2026 21:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aKeCtL
	HGsYdP4t0PjwPUjDPgu7gesM2JnDnU/J8TnKU=; b=MxB6FwFlLYTClz6dIODaU1
	aLv/qkWu8Fd0lQAq6N40RdBzqEzH/ZpLZDnkNlvDgNl7KpL72ADWuqrG94rKbdMo
	eFAqF48K7jCAM6oM3ICBQzIpsLBbC7j5+EA9lgSYns8B0IhAyc760TJoeEfxPLLb
	HP8VXant8aqeXtz5wwn72QNgiRzeM5ZWIy2EEeDzhffxaBlZIqoxWFWY6rzcELy8
	qp7Vvq/p1GgLpmvgUq9UfMjf9cx8dse0icOMVtdeEcc84ZJvpK0cqkRM/D4Em9nQ
	FTVS1L1WrJyH6J8WaKA/Flwrvv/U6UAXurYp6XYBtuzRgQDPZAzof5El5XtVw8MQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcssft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 21:55:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RLg2lm029985;
	Mon, 27 Jul 2026 21:55:01 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xxvk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 21:55:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RLt0Ue29950578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 21:55:00 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2D8C5805E;
	Mon, 27 Jul 2026 21:55:00 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E5FC58052;
	Mon, 27 Jul 2026 21:55:00 +0000 (GMT)
Received: from [9.61.157.32] (unknown [9.61.157.32])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 21:55:00 +0000 (GMT)
Message-ID: <23c3c2e9-bfc6-4b17-a011-d9b02f34b7b2@linux.ibm.com>
Date: Mon, 27 Jul 2026 17:54:59 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/10] s390/vfio_ccw: cancel existing workqueues
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260727192230.2715207-1-farman@linux.ibm.com>
 <20260727192230.2715207-8-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260727192230.2715207-8-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0uD-46w9eW3P_YoY8vNx2XThw4rpZwrq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE5NiBTYWx0ZWRfX5bDgwDMb/n5X
 5mTksKO5M4vEKY6PTkSaAkV1RK4MEMeZUSWV9ONo4IdBJaQT1CMr3toBER0WByDznkWk/C5vlkx
 s/itACFVwfzkrKZGBgDDh1ImzGJarLM=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a67d3b6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=wUE47ySAcWlnlIsVtMMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE5NiBTYWx0ZWRfX+XBYUggKhbfn
 SDDYJ2z6LP0ofuOQER7SdGusIf8gqwiDzqbG59nTAy5HzllTt0Ph5hzCsrJzdRKzjtVNx5kRO4L
 0xhx1t1sKz1aihwhyRNd9fI24sVSGI2h+UGltbfJrd60Tl5t/6nppqqmZgNspg7mXvpSsrBRdVt
 /KcL83GtNGIw5ER2o9WoUQ8aE5du6opcdj0Kzr4UoinsjJMWVFexBR940B7H02f9ds3W28GKQKt
 ZiLxM0bcudLrsV+9CszY6+zBHuPsDkkhPdGDEWNDsgKwfDDLgOpGavibjgdeJ6eZjz+LGPzjhaf
 HVPqHGc+a2nj5UApBNw6WfPfZg/2KENNiIHbNv9EmJ633pxREqNQOJS9qvN3LjedXFxSL4yfAeK
 IZ7BPUL8ENLbFHdV/ELDFrRLGmhvEg/B5+mki1t1NpQviFSRNwNEPM5djla8b+jBViywVggMUTc
 0or5nqTMVYKcTyjHNMA==
X-Proofpoint-GUID: 0uD-46w9eW3P_YoY8vNx2XThw4rpZwrq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_06,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270196

On 7/27/26 3:22 PM, Eric Farman wrote:
> The initialization of the io_work and crw_work workqueues begs the
> question of whether they should be un-initialized. Add the corresponding
> cleanup tags in _release_dev to ensure work isn't dispatched after
> the private struct is free'd.
> 
> Suggested-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Fixes: e5f84dbaea59 ("vfio: ccw: return I/O results asynchronously")
> Fixes: 3f02cb2fd9d2 ("vfio-ccw: Wire up the CRW irq and CRW region")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_ops.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index 032a1cdf4df7..bd488e40e153 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -136,6 +136,10 @@ static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
>  		kfree(crw);
>  	}
>  
> +	/* Should be empty, but just in case */
> +	cancel_work_sync(&private->io_work);
> +	cancel_work_sync(&private->crw_work);
> +

I think the sashiko report here means you should do the cancel work
prior to running the crw list.  I think actually patch 10 will resolve
this as well, but moving it a bit earlier in this patch would avoid
introducing the temporary regression in the first place.

>  	kmem_cache_free(vfio_ccw_crw_region, private->crw_region);
>  	kmem_cache_free(vfio_ccw_schib_region, private->schib_region);
>  	kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
> @@ -202,6 +206,10 @@ static void vfio_ccw_mdev_close_device(struct vfio_device *vdev)
>  		container_of(vdev, struct vfio_ccw_private, vdev);
>  
>  	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLOSE);
> +
> +	cancel_work_sync(&private->io_work);
> +	cancel_work_sync(&private->crw_work);
> +
>  	vfio_ccw_unregister_dev_regions(private);
>  }
>  


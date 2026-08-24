Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9176A3A1688;
	Mon, 24 Aug 2026 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581442; cv=none; b=qvlaCsipY26jjLKQb6O1lNf3GCO2lVtrqfxC/buoLX5Gg8EYtOzR/rwoM9qRkM4Xg1UcvKSGVRFKJ1fJXni6HtL7e0GcxZxhG87jwvtbFrgv8yrlLCBufe9sF0YG/oKowaYBCvqlFD9mCZCXiMdyMSPBkD5SblB8WfwFsVitsZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581442; c=relaxed/simple;
	bh=3qM1nfqnoH+dtfk0BiEtAPDSX5CphVdmMsOeiAG5mog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kN79y+yWTylqolGU2GMP1+9TSJ1R3epuvxrQDaWdT3xu42sEuRtc/mL8L/ngK1x3HRDZd3a8WB4DrIgA8aHTOqCWN0UqyYGSa95GpJvVYQ1xo+eD1JLN8c9p22u4vE4cF3uCyoq6vIz+b1MPs+BEiUKVNrzPT9JUx1AGlul9PvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SWrdyDnL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SWrdyDnL"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1dIp826425;
	Mon, 24 Aug 2026 14:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xd4+dJ
	uYp9+UG+a5J9ulyWH3F+auUhAzMp+UHvJdADQ=; b=SWrdyDnLTpy4Qw5EsdUA19
	fr/QgELQhKai62wGudnoMtm2x7X5w1NftgtmH2KNWpHFwcS2pL7133ve/96ejuPm
	LBwMh8LpQ8/A/M67ykBIccMVIBxEi7Y6sFURRK0Tt6WMttC34l8ieCh03WFe+Pq3
	YmXxjLQ82OyXeW8mAMRbXki3sv6OQPVo5c6p4grTb3tsxOkTKfFZlGEIW9/PUQGL
	eTwwmU8oCoowxDJxYb9/BYoiNFrHEtraGOZx/BT2S9cHhYRwrP1y688+D1EzeKw/
	8Yude1ypvZ4JP3nSu9X5gFizFgXrBsCITpb3Iq5ckauMH4E3iu3XPdy5gO6W00Jw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726e9xge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:23:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEBMI2011496;
	Mon, 24 Aug 2026 14:23:42 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfvxjx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:23:42 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OEN1Oi47186286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 14:23:01 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEA595805E;
	Mon, 24 Aug 2026 14:23:40 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D09F5805D;
	Mon, 24 Aug 2026 14:23:39 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.61.159.18])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 14:23:39 +0000 (GMT)
Message-ID: <f1351d18-1646-4ab5-aa40-9b2f87ad0917@linux.ibm.com>
Date: Mon, 24 Aug 2026 09:43:22 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: Use file-based reference counting for KVM
To: Steffen Eiden <seiden@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini
 <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Claudio Imbrenda
 <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20260812-vfio-v1-1-5cfe0b1fa4e7@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260812-vfio-v1-1-5cfe0b1fa4e7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8c53ef cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=q4V7ugTeKHCNkP7_hREA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExOCBTYWx0ZWRfX4m5m08DmkbiX
 gbMU4QsKK1cEalTNwAq4gZLosj4RCSndbRN6pnF/M54xTngLe2s4AYQVxB7vHQG7yn+/bKigdhC
 dH5TGSWSmhBAtxkRspQaJS8B6+ZBebo=
X-Proofpoint-GUID: G53-uqxfYbz00oQYLLfDZ1HnxDcd7Frq
X-Proofpoint-ORIG-GUID: 77H8t3_eqQ7HFMsIA0_yR1OfHczPiFnx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExOCBTYWx0ZWRfXxyKrNOqzoY2R
 t0WGlJA0s7/tkKqu5dzebG7fKIo4z3yUxFzvoEryqFv0zTWQlLnUchkC+MFciIej/BkB5wJXY7b
 0AdCTBEvEDS24LzXgoms5wMHjZkk5GQIxU2udF6L6WVoImW5CvnJU67bANpQkgBBG6twTAm8lLk
 vdaVdyQLah4XHYb+ECmeArPpL5ZpDzaEVZR9Qb3wPIReYrIbPDuBC6LxhBP/r11yL4l9VQ2VxcT
 3Pv7DhJLwALOuGrs4egskNDBKinqzP6FOXDslb5gq4862+MA3soeEEKF9KLpxfh0oXPgmhCE0DY
 BP82FbJZq9ovSFTGed9YReeNaXPeiyiQR5AvPviARq6WHpLr52DNDO4W1pqw1e3wcFib8VyGrPf
 tBwhmRjADZEJaytU5EE36Rok95j8JsAcWPEvRUvB3XcvzVvaby+EcR4uFA3Ue/l81V4qaDZEkmS
 TXCK+rkXkbE15SbGK9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240118



On 8/12/26 2:55 PM, Steffen Eiden wrote:
> ...
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 99a0efd999ef..42d331c84e66 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -1817,17 +1817,27 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
>   
>   /**
>    * vfio_ap_mdev_set_kvm - sets all data for @matrix_mdev that are needed
> - * to manage AP resources for the guest whose state is represented by @kvm
> + * to manage AP resources for the guest whose state is represented by
> + * @kvm_file
>    *
>    * @matrix_mdev: a mediated matrix device
> - * @kvm: reference to KVM instance
> + * @kvm_file: the KVM VM file this vfio device is associated with
>    *
> - * Return: 0 if no other mediated matrix device has a reference to @kvm;
> + * Return: 0 if no other mediated matrix device has a reference to the VM;
>    * otherwise, returns an -EPERM.
>    */
>   static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
> -				struct kvm *kvm)
> +				struct file *kvm_file)
>   {
> +	struct kvm *kvm;
> +
> +	if (!kvm_file)
> +		return -ENOENT;
> +
> +	kvm = kvm_file->private_data;
> +	if (!kvm)
> +		return -ENOENT;
> +
>   	if (kvm->arch.crypto.crycbd) {
>   		get_update_locks_for_kvm(kvm);
>   		if (kvm->arch.crypto.pqap_hook) {
> @@ -1836,7 +1846,6 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>   		}
>   		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
>   
> -		kvm_get_kvm(kvm);
>   		matrix_mdev->kvm = kvm;
>   		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
>   		release_update_locks_for_kvm(kvm);
> @@ -1889,7 +1898,6 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
>   		matrix_mdev->kvm = NULL;
>   
>   		release_update_locks_for_kvm(kvm);
> -		kvm_put_kvm(kvm);
>   	}
>   }
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>


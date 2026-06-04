Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F4C382289;
	Thu,  4 Jun 2026 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593432; cv=none; b=b7g1lY5lWo/rbzJ1cPiTOPYOYsAlfFwu7Rk43+6Y8qHgkvhdNcFXgrgHKXgH7Qab4ydBp1P8oA1VeZCJcb1XgfoA4BUkR+OrCY4soK83IaYPGR9ShJkz+RtMX4Yr7AlTJzW9Snz0bAYWS82UTWPNLAF5M01HN7r7/rE/s3p2DQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593432; c=relaxed/simple;
	bh=G/5hFcQ+iI6kB80fovuEBmcW+3jgEoVYBVAIlLQoYTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMUjhGcTURMUPx8tZbSIwn87XdqoAni7fPgHHvs+ZwcovkivYKUTbvBi0Bgx76cQDZGxSfmGOD5b6ZbdKFnD9frdbBOwSBgP3nYYU2TQp01AtUV2wN8i6+vNsiSoqNpgYyrJOyRNXRFNXHOWpXohWc0IW5qtRbTjcj9RpFgIeAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lUvRXMng; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lUvRXMng"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6548MhSX063649;
	Thu, 4 Jun 2026 17:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pqcN5E
	Gn/1nb6LweImPhkhz6aq6Ht7La6VqiKryEs6M=; b=lUvRXMngk1PJAHKcQOp6Hb
	6EIqGc2PTFvdipNbdIlG5w8JjHnxIJE0inxvr9dYWZ4KAxA1mWCXCrQV8dQEduv4
	JQ1B1iKo/L/qMCW2VdcyO8/ICC8tauCkDsbP9DNtY9+9cUi9BJzls64gwPMs1JDv
	0rowkkJRWqpr/tkmcLoPIO6mVnaRSTSLOZbfyj4epssryxgFSoQPlg19youQSuAE
	N7TRyHJPuY/TQJqXHyeYfsVR0P718X9R6KXrLE+V6mlgvbTmemRAS57z1yzZ5uji
	/JdSTauQtGBR/gBil3VODIPriHg8dD5L2g956lslkdFVxoXKxaSmLGR6S5m55KDQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm58wc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 17:17:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 654H97Lp031093;
	Thu, 4 Jun 2026 17:17:06 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7ke3y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 17:17:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 654HH52A26673712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2026 17:17:05 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3530A58055;
	Thu,  4 Jun 2026 17:17:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 936D258043;
	Thu,  4 Jun 2026 17:17:04 +0000 (GMT)
Received: from [9.61.245.98] (unknown [9.61.245.98])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jun 2026 17:17:04 +0000 (GMT)
Message-ID: <d9ca420b-a1e6-4d12-bd42-3993e401d58b@linux.ibm.com>
Date: Thu, 4 Jun 2026 10:17:04 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 3/4] vfio/pci: Add a reset_done callback for vfio-pci
 driver
To: Keith Busch <kbusch@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alex@shazbot.org, helgaas@kernel.org,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Julian Ruess <julianr@linux.ibm.com>
References: <20260603182415.2324-1-alifm@linux.ibm.com>
 <20260603182415.2324-4-alifm@linux.ibm.com> <aiE3I0bL0TX1nOec@kbusch-mbp>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <aiE3I0bL0TX1nOec@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z2mQN0OpXymqbJL7E5EIooNgYz3Jq6qO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE2NyBTYWx0ZWRfXwXCxfMvZ0Our
 gVj7KLgDnKsa7EnOU8c7zvy5ZACCKyU1Y122YxLYKbZ+JmPYeuf0LopbAED+A6hOyexw5unwf3c
 9fGKr5vlpUU+70Esu7j8zQsz4g+CtShcqQcpleOxhC9euLEFqgamasahbr9mMNI5BZpLxTrdjOy
 3HzHsF2kNwlX1+vPAdBodSwpNDWy2VG/XU5CrUFnje74pfQ4dYzhEHGCBGDG5v0Vl7Wv4fNffGF
 wuGplgaIHAR0zxzUOfXIbV4ShN8NampubQGoBeL+d7r9X8oln8/8h6zC4fmql+R+Kzmpv59Izbq
 /nAPGOoM+mwNtrrWN+KYebMzDdb4VUGaJLa6R+0fOvwslpb4A22KFIvZ4K0+0bqY11Bf3l4cQ7E
 UMsyBWAuici5nR5U9z5IjJCnRJLenrpPkdwYzDHjYidETfTWTAouw1VjYwlzvNLlEDOKuwzApnH
 PyrZgvyw7UjPuwRznnA==
X-Proofpoint-ORIG-GUID: Z2mQN0OpXymqbJL7E5EIooNgYz3Jq6qO
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a21b313 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=hQvOzGRgIoEI6FeQiHcA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040167


On 6/4/2026 1:28 AM, Keith Busch wrote:
> On Wed, Jun 03, 2026 at 11:24:14AM -0700, Farhan Ali wrote:
>> +static void vfio_pci_core_aer_reset_done(struct pci_dev *pdev)
>> +{
>> +	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
>> +
>> +	if (!vdev->pci_saved_state)
>> +		return;
>> +
>> +	pci_load_saved_state(pdev, vdev->pci_saved_state);
>> +	pci_restore_state(pdev);
>> +}
> Shouldn't there be a cooresponding user space notification that the
> device has been restored? There's an eventfd on the error detected side
> so user space can know the device needs recovery, but how does it come
> to know that the reset is completed?

I think if the VFIO_DEVICE_RESET ioctl completes successfully it should 
be an indication that the reset has completed? AFAIU the ioctl will 
drive a reset via pci_try_reset_function(). If reset completes completes 
successfully the reset_done() callback is called via pci_dev_restore(). 
So I don't think we need an eventfd to notify on reset completion. 
Otherwise we would have the same problem today, where userspace is 
unaware that VFIO_DEVICE_RESET did indeed successfully reset the device, 
no? Or am I missing something?

Thanks

Farhan



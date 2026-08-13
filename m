Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889A4370AE3;
	Thu, 13 Aug 2026 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786638388; cv=none; b=PQdKOeYuPX+dVcBJkqg4yO8EbhobUA4WZjVStbmeNzRYVguA4IMb+4fHwn6W3t1a5jJLZfngyIJVp3l+y0lgpFA/SFT6ELkwplweDKF3zwzOP7+wpgCcLrQNuFXAyJ6DQcXaZ/npYlomRE2C+CBhfbF0UcTpdDGu6lWvMZFvSuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786638388; c=relaxed/simple;
	bh=7mqslmYH9+fsaB85EsqmmvZuiePbQOEBmTjiayL8CuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFwWlePBW11uICOg9vWXAKV8q7WtUqZ4h5Mn7HK67YBu/SJtXd4TsF5zfOGmUBvPX1bTkUcz4oI15zZt14OeaX/7+/wsWhmB+ME6z2kFuT28Ez4+R8UB8xngaQpGx9BSvdhtdCUlho+s68ymG5cn+r7PcIo4N5onl6qH6V3cbvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TTYKDnuz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TTYKDnuz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DFWgwU1629131;
	Thu, 13 Aug 2026 16:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YVmoYD
	JzajsqMmcqhNpEac8ETHDbvmkmlQk/Rwa28PQ=; b=TTYKDnuzHJ3gZsjDbO2NeI
	JRGFzJeOn7RaS9GoC4EN62no/Uq4hzTcMau5r7jzUrCv8k2zruOTw2XhUkqfx9KA
	Tx+0QiyJ+7JoZ+gcfNZWA6oZzttggdMoF9km2bsNctfb1PTmUiuJ7MrKev3cvPWZ
	GRNeX8OVacRYKcOAxWTULZZ4lU5n+jssxHqAh+FHGyzVwvUAnnPTBvx9bahdlpqs
	qe7Yxz/+gSaDmy2drRJLDOddyxRH2xixOS9As9gKCX6eoX5CI0SU5eY+lbjeKppT
	vMnLmKe+4FOeu4e917M2LJ8e657z4f+06ChnjmcAdzT1pvWV9IzhAAwCT8Ny6WYA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb2416rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 16:26:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DGQIwZ018343;
	Thu, 13 Aug 2026 16:26:18 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesqbw79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 16:26:18 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DGQFwb8520326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 16:26:16 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4E3F58057;
	Thu, 13 Aug 2026 16:26:15 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EAD858059;
	Thu, 13 Aug 2026 16:26:15 +0000 (GMT)
Received: from [9.61.251.149] (unknown [9.61.251.149])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 16:26:15 +0000 (GMT)
Message-ID: <ade2ea72-9491-4c03-8b67-08011c2c7328@linux.ibm.com>
Date: Thu, 13 Aug 2026 09:26:14 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 2/3] vfio-pci/zdev: Add a device feature for error
 information
To: Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
References: <20260630165553.725-1-alifm@linux.ibm.com>
 <20260630165553.725-3-alifm@linux.ibm.com>
 <20260717152650.3cfc2d10@shazbot.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260717152650.3cfc2d10@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7df02a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=qNG8fd7tPmr0NF9BgyQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDExNSBTYWx0ZWRfX7sXn35Fz5sfd
 4M+z5gFbkOsPRsfQpoVnDkQv8eJdJXVPJ90LnpOxR/UDD6noLlMtiIEXnIemmH3ZbsQrdw0oXLK
 lDquQlgDSR5SmtZRMnj4dfB6vHXUak/oURVPkemPStdyPJ/BzycEcAVyC55zceFDXu3b2ljxQF+
 xEhaVgblq0usJI/nWZ9V3lVyBu/CO6CI13v9AVhueYl6o9/z6dtmAjQCOecOzEOZ5zyxOo9arDn
 WUs2sDKTIHrzAes1n2PmYM9+e6IdVX/7P9HaqXBULuEAkIbWpkCbU6D1pWwBf3bX/sZpKDmHuXM
 QphmeL3V0ZGtk84hME1xXI5GV0cwd1qkAMVR4/1PoeK8lzLn2R6fGOXZC6QkvNcFGJv13XZvLe2
 koxdaIsnkHKSA1iP/PhaW3QF2J7064J1NhWO5ahDAjOfrXGvdi/qThgTwNys9u7HDFDMXl1OVRA
 ditbumuGUd4ueml8ZZw==
X-Proofpoint-ORIG-GUID: J6N4HrNf-QNrdiN_Z-y5ov85dotBBu6K
X-Proofpoint-GUID: J6N4HrNf-QNrdiN_Z-y5ov85dotBBu6K
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDExNSBTYWx0ZWRfX/5W4RleZKu8G
 QVOjWAjHWAqUIHbxEqhR7DrwW5w0KrDS6Cs/eSeN1zhhA2AB3PdH6v8v4+NXjTFvHbsupSoGEAD
 7y4wlYV6NZ5OZJzI3W7eJA74JtRll/k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130115


On 7/17/2026 2:26 PM, Alex Williamson wrote:
> On Tue, 30 Jun 2026 09:55:52 -0700
> Farhan Ali <alifm@linux.ibm.com> wrote:
>
>> For zPCI devices, we have platform specific error information. The platform
>> firmware provides this error information to the operating system in an
>> architecture specific mechanism. To enable recovery from userspace for
>> these devices, we want to expose this error information to userspace. Add a
>> new device feature to expose this information.
>>
>> Userspace needs to be provide a buffer of fixed size. This size is provided
>> to userspace via the VFIO_DEVICE_INFO_CAP_ZPCI_BASE capability.
>>
>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/pci.h      |  2 ++
>>   arch/s390/pci/pci_event.c        | 19 ++++++++++++++
>>   drivers/vfio/pci/vfio_pci_core.c |  2 ++
>>   drivers/vfio/pci/vfio_pci_priv.h |  9 +++++++
>>   drivers/vfio/pci/vfio_pci_zdev.c | 45 ++++++++++++++++++++++++++++++--
>>   include/uapi/linux/vfio.h        | 23 ++++++++++++++++
>>   include/uapi/linux/vfio_zdev.h   |  2 ++
>>   7 files changed, 100 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
>> index 016386f7ef4a..88a125b92bdd 100644
>> --- a/arch/s390/include/asm/pci.h
>> +++ b/arch/s390/include/asm/pci.h
>> @@ -364,6 +364,8 @@ int zpci_clear_error_state(struct zpci_dev *zdev);
>>   int zpci_reset_load_store_blocked(struct zpci_dev *zdev);
>>   void zpci_start_mediated_recovery(struct zpci_dev *zdev);
>>   void zpci_stop_mediated_recovery(struct zpci_dev *zdev);
>> +int zpci_get_pending_error(struct zpci_dev *zdev,
>> +			   struct zpci_ccdf_err *ccdf);
>>   
>>   #ifdef CONFIG_NUMA
>>   
>> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
>> index 8934b640a095..3ad16038e005 100644
>> --- a/arch/s390/pci/pci_event.c
>> +++ b/arch/s390/pci/pci_event.c
>> @@ -77,6 +77,25 @@ static int zpci_store_pci_error(struct pci_dev *pdev,
>>   	return 0;
>>   }
>>   
>> +int zpci_get_pending_error(struct zpci_dev *zdev,
>> +			   struct zpci_ccdf_err *ccdf)
>> +{
>> +	int head = 0;
> Nit, unnecessary initialization.
>
> Otherwise LGTM and I can drop the initialization on commit if there's
> no other reason for respin.  I think we just need a branch from Bjorn
> to base this on once he's happy with the PCI series.  Thanks,
>
> Alex

Hi Alex,

Bjorn has accepted the PCI patches and merged it to his pci/slot 
tree[1]. Would you be able to merge the vfio patches? I was able to 
apply these patches on 7.2-rc7 and didn't have any conflicts. But let me 
know if you need me to respin.

Thanks again for all your help reviewing this series.

Thanks

Farhan



>
>> +
>> +	guard(mutex)(&zdev->pending_errs_lock);
>> +
>> +	if (!zdev->pending_errs.count)
>> +		return -ENOMSG;
>> +
>> +	head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
>> +	memcpy(ccdf, &zdev->pending_errs.err[head],
>> +	       sizeof(struct zpci_ccdf_err));
>> +	zdev->pending_errs.head++;
>> +	zdev->pending_errs.count--;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(zpci_get_pending_error);
>> +
>>   void zpci_start_mediated_recovery(struct zpci_dev *zdev)
>>   {
>>   	guard(mutex)(&zdev->pending_errs_lock);

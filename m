Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD506299A8F;
	Wed, 11 Mar 2026 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258616; cv=none; b=ENb5aevX4lWAbDHbvo0ZmtoHQdMCxp5QBawvo2ewh3TdWkfv0caUWiQBk6vds1wPxFiJox5h5f+UhZTWRVb/oC61J53/BeGj1v8EM4M0CrLXBUuOPSz+URf6X0tgpqN/AhAPH+3FtXKFTM16Xivpj31nY+39QtxtAijYFxlewC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258616; c=relaxed/simple;
	bh=2AL7JTx/+1DwwQRRR6N/knmhizaCpKVWqkv9zjcIgoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+NyfgCLQs/klDZdeDqa4o+lU/v3N54dluh6722T0F4W0vKz7MIEvuXvtYtwzya1xcDIO4ljH/ZcHwHml5nTcTvzP4sWdpR4AklMD65Qg9xwPhzJ3l3P5+dogr6QNDCJIlPEoU+DuEzcaCCW/BmSmDG7SeufXvhMO7bFbHGTmB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M+4Vwmul; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M+4Vwmul"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BF4v3n1599036;
	Wed, 11 Mar 2026 19:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ru/sdd
	zbbVFP6SaLbKOPJ91WRvvDkw6EJkE0uSifBfc=; b=M+4VwmulVbzEjtdBxSjtXM
	Aa3VVt5ywJlDNqRAsJOGI1ciBYEQf6QoYR07W0b+Z7UnsY3Lz33QsH0DnsanpYce
	2sg3UkM+kL7vZg80b+RTnqjCVZhZ+Gr7JKW00wxMtFyW+hl5XzQrgzo/3tMW6PvK
	1mdC6kwBVmjIryQSDtsQpSR+kAXCgyVGPJFVkCcOx0VrT4t98JM1PMtN4pcOkueq
	lRjszpStqV+GCf56N5NF5Wihsx9DwE6/SLmVjs9euckVn09qvRUYsddACAD7eoNV
	VLzjgIQ1VsC9ZZFK4q5dFV3kS+6VUHPElnVUHMY9YEC+hCdl0k1C+9JNkgv32bJw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcunh6kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 19:50:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BGXZ2d015573;
	Wed, 11 Mar 2026 19:50:03 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crybnexp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 19:50:03 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BJo14r31195870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 19:50:01 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B6B45805C;
	Wed, 11 Mar 2026 19:50:01 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46FC158062;
	Wed, 11 Mar 2026 19:50:00 +0000 (GMT)
Received: from [9.61.244.205] (unknown [9.61.244.205])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 19:50:00 +0000 (GMT)
Message-ID: <420cec59-a62b-42b3-859d-707f286a49cd@linux.ibm.com>
Date: Wed, 11 Mar 2026 12:49:59 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/9] s390/pci: Store PCI error information for
 passthrough devices
To: Markus Elfring <Markus.Elfring@web.de>, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
        Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
References: <20260302203325.3826-7-alifm@linux.ibm.com>
 <9e31dbbd-561c-4352-84ea-3ee0c9aec567@web.de>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <9e31dbbd-561c-4352-84ea-3ee0c9aec567@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: x-lB_WDonL2FRB5p5PtCNnTQZdEEyZG9
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b1c76c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=P-IC7800AAAA:8
 a=UqHa9KyugJsa2jffV6oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE2NSBTYWx0ZWRfXxc/7v8XqBdy4
 FTYhvYAprzpJAgBYHnY0uFjwI+xGzVgIYfMfmVsBKMHkSYooDy+RG/GmyBt9BkEhgsool8GyI02
 mtNNz2PZCHn/PpB3IWN+/cqnw1BNWhD3Sm/Nml2lmBLEy29oumugD7dm+CxSB+YXM4YoIQs3Uir
 s/77XBMLjnJbc4yWh1ZFLP+Z8sfAvOCnYVdxt3faHQTsAbJ9UPNxu4SZBpf3/SA8c44mrlpWNzW
 GYjtrXa/VAcSaIJVui3qvvSfOHuNFgx7J1VpGeTA9EHOXnN8Dx3t2vranlScYCMdO6IV1B/Usis
 aDN+JcCE3cXMjYsNNk8HfnB23O7k1QPISKNQUoWPJ0Il5nyv6ze9qKg8w4RxlxDCuMpMUK4EqMw
 dTYwX8hrlR0T2jjDwIqlCNVK8MolnKieZUVZM9DpTZLoeEsThh5BiocscK3QA8tFpPhKK0bbD8x
 pWcFWvSvPjMN2A/WmVQ==
X-Proofpoint-ORIG-GUID: TMJBROuu6fX43RtEGraYPudlEVtyLEOL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110165


On 3/11/2026 12:30 PM, Markus Elfring wrote:
> …
>> +++ b/arch/s390/pci/pci_event.c
> …
>> +void zpci_cleanup_pending_errors(struct zpci_dev *zdev)
>> +{
> …
>> +	mutex_lock(&zdev->pending_errs_lock);
>> +	pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
> …
>> +	pci_dev_put(pdev);
>> +	mutex_unlock(&zdev->pending_errs_lock);
>> +}
> …
>
> Under which circumstances would you become interested to apply a statement
> like “guard(mutex)(&zdev->pending_errs_lock);”?
> https://elixir.bootlin.com/linux/v7.0-rc3/source/include/linux/mutex.h#L253
>
> Regards,
> Markus

Hey Markus,

I wasn't aware of this pattern. I think the guard() statement can be 
added here, will update in the next revision.

Thanks

Farhan



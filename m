Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA6431A42;
	Mon, 10 Aug 2026 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786383843; cv=none; b=g9wR+fBPEaEk2tqb8Kxw2TxdXOAAL10s3F7BjlJLqkUDZMx3PvkfTExTPQK5qhswbd7nfSY7A9pz16ZaaUC09ISNTYOrtCP3U/bqekK0Gbl8FxRs/ElyI+aZUd766eWCsZBk/QqWWSTd6usaaYJsFw+jEStFzyi5O9B43Wh49j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786383843; c=relaxed/simple;
	bh=Gb5ocijJFFMzK0NRMZFGDO85UQ8uPN9UU/nHGDwkEcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOymJ73pBHCsGH55mGslaxu3V4xty/1ieYyIY3n1beV7gaG6u2pvuWOdbkjFReQ6eGytrbixrh04+7qOvPsiHwwZozUJv+ecAtJ4LLGH2OPbcZfIjsiv8ZmxJlRLW0W05zk/ogowzn0dR0yYYjObndqum19BDymXTbyg+MbniXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LC4DNrMG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LC4DNrMG"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AGVckE2069438;
	Mon, 10 Aug 2026 17:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nOLO54
	87B8LXcsWjVYNjMIVWecochNLzqGS1agTQ/Sk=; b=LC4DNrMGGfeW5hMW/Jog6F
	kOZuf+OgDnjLGNnfQ8Ni7xpAyXdcvRxDoolISJAeZaxj/T3Ho46XN1CCTKneWNdE
	rgvBpQn5r/oPR8ELMtdulEAXdpMBJx+Uata6xjSqv4jF67F4k/dl6F87BLrIohns
	5uexBB0uPXJXvOj71dyO7QPGGkbFurpCaB+26fz/TuZwdrEx23d7B2hTGn8GgfPO
	JHrzzIOyFBac5KJLm4UhW8UfcfcPyNWbeiauxGaGf84/iExoaJ35lxwEx3WKS1zo
	yNIRnwM0yEbp5YYkkTLjJTgplKaKxmO2Ht60F/auTDjl7b9WtC+avnqRlY1WKPNg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2rwk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 17:43:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AHfLRa018903;
	Mon, 10 Aug 2026 17:43:56 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjnuce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 17:43:56 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AHhtcq6292466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 17:43:55 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08BC05805D;
	Mon, 10 Aug 2026 17:43:55 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6266F58056;
	Mon, 10 Aug 2026 17:43:54 +0000 (GMT)
Received: from [9.61.246.243] (unknown [9.61.246.243])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 17:43:54 +0000 (GMT)
Message-ID: <5dff4b7b-5ef6-43a4-8a76-9cced648320f@linux.ibm.com>
Date: Mon, 10 Aug 2026 10:43:54 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] vfio/pci: Avoid mapping BARs for devices with
 non-mappable BARs
To: Alex Williamson <alex@shazbot.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, borntraeger@linux.ibm.com, mattev@meta.com,
        schnelle@linux.ibm.com, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260729181116.1373-1-alifm@linux.ibm.com>
 <e7b2da7b-2c70-46c2-9d07-6acc6949915e@linux.ibm.com>
 <46fede14-a740-4d66-98b3-c840e03e8634@linux.ibm.com>
 <20260729143603.175f60a7@shazbot.org>
 <42a3b06d-ecaa-4339-9472-7c592694f877@linux.ibm.com>
 <20260729155021.64f7e1ba@shazbot.org>
 <c0e6803f-7e57-4dfa-a4cd-f2ee188070c8@linux.ibm.com>
 <20260803135415.2cfd37bb@shazbot.org>
 <a8f2af03-3242-40bf-bf89-e922f0768db3@linux.ibm.com>
 <e3ac5a11-b37a-48ae-b096-87f0a805cb34@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <e3ac5a11-b37a-48ae-b096-87f0a805cb34@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7a0ddd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=IRYEI1eNHJbscK6QoB4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nImi17arpchZtXcbJbDmnhRbY-o-palk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE1MCBTYWx0ZWRfXwrOte3XQ0u97
 R8zwoi8U/Z1CirxVfyoXtA2Amg9rKpNTBHkKztjWOFbwyjvjqKFl90emD4MsIgsuP6opSdIfza9
 k+JeMS7mrO7Vb58cz+XQEE+ZhXPC4r+DWWr6wi3Nvd6Z84h/Cj93hZddo6SBGcj7I4HEa+d9c7k
 WN3zJKAM4y5Cu/ZFlfWvUfKYAxsxFgOPjzIDys8Jo6wgN3tT8XuEjDJZXqnV54V4m+FMcKqB1+0
 SlXnTtD3KiOrNk5MnpfJBHJ5/qkLMwOPVQ0b74/XuSptxorzilotF3yAu8c1PbNq6vZXKN0D6Mi
 XKCRT1szv1U9zl1dnwE4WQZOBnhLhPvZh9jXwQkqV9cuou4VOAfBTz8323xRiG52U/Hkbi4GTU/
 G2v6uTSelK2+wD0mEeK9Z4cWk8w4oiArXhNidGuJOSDd7sIiTqOitoHPEoJh08t1qCBUbp0W+zg
 AzbbeG5wPwfhd/eNBIA==
X-Proofpoint-ORIG-GUID: nImi17arpchZtXcbJbDmnhRbY-o-palk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE1MCBTYWx0ZWRfX6IlODKmSqVdL
 f3jA7YSPSEdxWyB+cclbJesPDEQHBVjGyDATWf0Rma5NrjGn+EOfnG5NvVf6TGXPY6BTuhAuXdR
 CfG56N4uJafHDfjy0SV879uYNbPWKD4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100150


On 8/4/2026 6:39 AM, Matthew Rosato wrote:
>>> The bar_mmap_supported flag describes something else, whether the BAR
>>> can be mapped into the user address space.  My intention was only to
>>> point out that there are BARs that cannot be mapped to the user address
>>> space because either they're not MMIO or we can't safely map the full
>>> page, therefore bar_mmap_supported is an invalid test for whether we
>>> should request the region or iomap the BAR.
>>>
>>> Is there still a gap with the original proposal that I'm missing?
>> AFAICT this fix should be sufficient. I think Matt's question was to see
>> if there were other cases for which bar_mmap_supported were set to
>> false, that we need to consider here. But I will let him clarify to see
>> if he has any concerns.
> ^ Yes exactly that.  To be clear: I am happy from the s390 side with the
> fix as it is proposed.
>
> My questions were basically trying to generate the conversation that was
> just had in an effort to avoid another fix later.
>
> So, with the context provided (thanks!):
>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

Hi Alex,

Polite ping on this patch. Please let me know if there are any other 
concerns with this patch or if we could consider this for inclusion to 
fix the regression on s390.

Thanks

Farhan



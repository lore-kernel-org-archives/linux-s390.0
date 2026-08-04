Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B44B3749FD;
	Tue,  4 Aug 2026 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850819; cv=none; b=tD/eMILszsRWsGoRz62cE9WKI/q24wK+jKBD3xmM4zCWn+A27O9GXzETO/gOumrPbbR7Oa28ln4gotEedsIne5h1aub+x1CsXo+2x5BjYRcg628IhYlvLUYrUj+71/7zHDZTZy+q8pSvPanFtRxjOdo6FAFzFFw5MxolmxaIf+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850819; c=relaxed/simple;
	bh=dhHpasqhH9nlFEhhwwafqDM85rame7W5a+n3SHTOv5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J70M6ENy3Xi8dO0JL8QDnN0DLU0lono1jszoSn2MmKnIKxtRvHNL35pAvqXnTkgz88uG7OlKIn7xs3xriC+2z0F6RXEFYVa1dIvnl7xdmtplQBZsGD3XU2AWoIBzwxcjeM3yK6xdHvfrIH4+l9d7jWffTCBbqxSJvZz6nfBg+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FiFnJdgx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FiFnJdgx"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674CldfD3207639;
	Tue, 4 Aug 2026 13:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zgTtdZ
	CYU+eJ9gCyRLEVXHWkfRyb0pL9PZy9j/JiXJ8=; b=FiFnJdgxsT5G1LQ4Tffj6p
	19GENE3T1lLZuMYhT7LMsug72Iiymmcruo85hRMWdEJbFjDzHRnU7BFiKurv3ghn
	8D8Ja+OIkq1Qi4hCNXs3Vt7G9xMoKDt9jbOD8mf4huwWHFYEpmlYyBPdjKLoy9FX
	E317XTKAUtI2tNaDoimEPnuzI5eat6dEXz+9KTUV76GL1p7jjmVkgRB4P7SlOQTw
	5RlrYVzDBuPdUXjuZ/CaF35O7WuX9/8c8XOgBIc+FdEZH+qUY2pEzizJZBX1jDHt
	0QL4F1XvS0gvFRpLWLKBNEjSxFo68+FPveqMgbnnmeFR326Yh8XRCK+jFTAYc1Kw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqp13d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 13:40:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674DQHAo023458;
	Tue, 4 Aug 2026 13:40:13 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmha2uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 13:40:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674DeBXo19006044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 13:40:11 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 320495805A;
	Tue,  4 Aug 2026 13:40:11 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D3935805E;
	Tue,  4 Aug 2026 13:39:40 +0000 (GMT)
Received: from [9.61.86.222] (unknown [9.61.86.222])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 13:39:37 +0000 (GMT)
Message-ID: <e3ac5a11-b37a-48ae-b096-87f0a805cb34@linux.ibm.com>
Date: Tue, 4 Aug 2026 09:39:24 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] vfio/pci: Avoid mapping BARs for devices with
 non-mappable BARs
To: Farhan Ali <alifm@linux.ibm.com>, Alex Williamson <alex@shazbot.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, borntraeger@linux.ibm.com, mattev@meta.com,
        schnelle@linux.ibm.com
References: <20260729181116.1373-1-alifm@linux.ibm.com>
 <e7b2da7b-2c70-46c2-9d07-6acc6949915e@linux.ibm.com>
 <46fede14-a740-4d66-98b3-c840e03e8634@linux.ibm.com>
 <20260729143603.175f60a7@shazbot.org>
 <42a3b06d-ecaa-4339-9472-7c592694f877@linux.ibm.com>
 <20260729155021.64f7e1ba@shazbot.org>
 <c0e6803f-7e57-4dfa-a4cd-f2ee188070c8@linux.ibm.com>
 <20260803135415.2cfd37bb@shazbot.org>
 <a8f2af03-3242-40bf-bf89-e922f0768db3@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <a8f2af03-3242-40bf-bf89-e922f0768db3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i70RW7y-2qvIFReZSmXt0wXht5mFqGuU
X-Proofpoint-ORIG-GUID: i70RW7y-2qvIFReZSmXt0wXht5mFqGuU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEwNyBTYWx0ZWRfXwUsYpUslVs5T
 3WMZxIBu1O3PNk8O1wNUMxkcejei60U3ygznvPlxmDIlyANkgrdLzOJXduxHXbmicZjryi2TM9b
 YxFBmB2L7rPFIizvjAbMCwXMLbcfGOM=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a71ebbe cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=mCxOg_z8nsbM3u4HIs0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEwNyBTYWx0ZWRfX+5lEBSaV6JdY
 i7eCL25pKPXd8ZboZ+nQjk0ZysYbvyUCG85BggWyf3hLg9Q6EaHUkw0Pgx1osK20d4AVEW66Yi8
 mqL2QUgVcVnk9iUb4PFu6KMCWsiNXle/wEpZWTYA76H67J1OeO0CaiKQDRkArjewu55E8bUV7F6
 JK6DLTEjuUKhN4pPVVE7L5pQRULAnbf9t10e0U2C9zn/BJwGIHDzU5VdYCjmBShqM6Vi+0Q/8mf
 nZSlozxl7jBjmQw/ttARBoM3HgPkTmJoOR2aTZzIMPYWObHTiqB0k2kcMVt0IGVvBUCeUmnf9Ja
 yd3Du10UWz2m7YPBTKwjtXYKzMUEevJs4nexZCHm14Jca8O/BmEy1oTbAk4d+/P0ihs0vxoXZrj
 oFU8HG61YsbTRCsbsfj5pJGwmckAZkwgbeX3yMwVs5WZmc5fv9gAFcUwhMqDZ8QLbFMd6VpG1BY
 HmaFeaF4O9Y3FR89WtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040107


>> The bar_mmap_supported flag describes something else, whether the BAR
>> can be mapped into the user address space.  My intention was only to
>> point out that there are BARs that cannot be mapped to the user address
>> space because either they're not MMIO or we can't safely map the full
>> page, therefore bar_mmap_supported is an invalid test for whether we
>> should request the region or iomap the BAR.
>>
>> Is there still a gap with the original proposal that I'm missing?
> 
> AFAICT this fix should be sufficient. I think Matt's question was to see
> if there were other cases for which bar_mmap_supported were set to
> false, that we need to consider here. But I will let him clarify to see
> if he has any concerns.

^ Yes exactly that.  To be clear: I am happy from the s390 side with the
fix as it is proposed.

My questions were basically trying to generate the conversation that was
just had in an effort to avoid another fix later.

So, with the context provided (thanks!):

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


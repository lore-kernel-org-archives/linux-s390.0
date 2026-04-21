Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010352773F0;
	Tue, 21 Apr 2026 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776807531; cv=none; b=VhuA+F9JOu6SCuEMthj1r9ITEh3qrxh9Gd4iE79AMeSPQfgRW1C1L5WAbwe6N1sN+uOtQhB0A3URrqdMEUa7DeRm87nTEKSwbzmCkiR6VLzyxecaDPMzGMqfmD26uIGB15A7QmcvQbDk5Ot7hrrNN4O4kyyCGs+lvCvv9DmkMLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776807531; c=relaxed/simple;
	bh=CcnIhNX1Ct+b8gr30wn4e1tvYOD7yALVZlMLTbe45WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbjhwsnyixVBAkbeJS/rhq1zAg9VRjIs+1ooDJTC0Y8OJdT168ghbwrN/pJZC6AY3ZGDqbCN5YOMb2eQXX+qUKgMMGYQqUhsKd0Cxxm0AdMrpFhro+BWMa6prrpWbYhDarBaNClUup584SMzWy4IGkdA74HjgHaVCH9nXhHffjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V2RfIuf2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V2RfIuf2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LImJ6S590754;
	Tue, 21 Apr 2026 21:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=JUf5xe32ftQAeXDeJ8yyX8svTFp1E8fbIyIRFi3qqwg=; b=V2RfIuf2OTVd
	uZ04Bz99InlFj3o3lfgGDsv7Vu40uVn84qgNhhK2gqAXfYzcZB4EeMPaxjRVil/k
	wubxGCIk7DZptleat9lPnzogDmWUlnMFLStJ3EfL9UxwdYZ7qTSMgrVD6n36IiIi
	IMr8pzczORoW66R8+6ZoaYDc6wTQV8s8Mj+td71kUJNE9HOVVLCWy4mTq4awf2HW
	Ipo94ogE0EqhquaC9ZR1hYpcSouB3r+t/jl+IsMeNdiympChIERTJ3pV2dMTw2mK
	8O9dsxB9KlanudR+rCzum4iPipMdgLXmL3fiiW72sqW1PSJy/NPUd5g2IzsqdvKS
	OqoicaJgCA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu20jg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 21:38:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LLKRgl028602;
	Tue, 21 Apr 2026 21:38:46 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpyy27gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 21:38:46 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LLcikw18875062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 21:38:44 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C3F958053;
	Tue, 21 Apr 2026 21:38:44 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B34F358043;
	Tue, 21 Apr 2026 21:38:43 +0000 (GMT)
Received: from [9.61.249.207] (unknown [9.61.249.207])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 21:38:43 +0000 (GMT)
Message-ID: <305d85a8-660a-4063-9b47-5707d8b25fa2@linux.ibm.com>
Date: Tue, 21 Apr 2026 16:38:43 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: ramesh@linux.ibm.com
Subject: Re: [PATCH v2 1/1] PCI/hotplug: Add 'uevent' sysfs attribute to
 trigger slot events
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260416213909.705753-1-ramesh@linux.ibm.com>
 <20260416213909.705753-2-ramesh@linux.ibm.com>
 <20260421171334.GA1684602@rocinante>
Content-Language: en-US
From: Ramesh Errabolu <ramesh@linux.ibm.com>
In-Reply-To: <20260421171334.GA1684602@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: kjO1FGRRJEH0Owfen7rjb3pT3iW8W1BI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDIxMiBTYWx0ZWRfX1voHI0bWLjYr
 a3Gosp13w6l+/COI4ELRiopckOqN9o5AD2M1o5venYBKOi2xpRL4f7N2yDKB8OBCqUsgt2pvMn0
 QYi26ID5OTnF6DPbW8Ya/bEn0OfwDGa/0XaloAP5v684ofjAnCcHUdAcgb4mTNsUk4NW13vMy/J
 SXzZSTocsZH7WWtuGtecTjZUpwziyKMT/DFKunlovJw9H/MJnhvqe5KQbW30O729HigE/BzbqpE
 AINPhFk6fU8Ji2Jp1ehx6eH2su4jqvPKPKFEv09A8FD1cstceN5L7vvYher/wZwijyBNKmaBcoK
 mIbS4enTf2QEiVu1bwH/xLtB4rEXlVjW8zFIVA/koEOT7p324B6udodtwhuNV8W++9OvrD3zU5o
 bpuE+DyuayetUd6DX14m/v4j/WIJHlUaclV86ACH/Q2EMrdUuuSJctHH3Ds9aXJLG1iMlfGXH6M
 Rm7WisXx6QtMXWPxnJA==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69e7ee67 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Xe8eY8ZVJCK048dyR0cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -KZ-uPc59IxeIQQ4dM2P-GSfloP3vUUj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604210212

On 4/21/2026 12:13 PM, Krzysztof Wilczyński wrote:

> Hello,
>
>> +static struct pci_slot_attribute hotplug_slot_attr_uevent = {
>> +	.attr = {.name = "uevent", .mode = S_IFREG | 0200},
>> +	.show = NULL,
>> +	.store = uevent_write_file
>> +};
> I think, you could use the __ATTR_WO() macro here.
Use of the suggested macro is not appropriate
>
> Thank you!
>
> 	Krzysztof

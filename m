Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB183019D9;
	Thu, 26 Feb 2026 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134280; cv=none; b=poSPh+pLDgDah7B7K7J9gLav42HGwWFMcl2wGUEp+ECz3lF3Dq3A7JKl66WMWmdMxLRYKDEnmri64VDC+0XGsMxqxlWsk1/zAngaNvzHOxpzou9UtQuyfvh7P6DzzBTAILqNWw/m6jv3RYxOHZii4ZyFLhUqXP0P89bjqKnEp8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134280; c=relaxed/simple;
	bh=xoQuVDOM1fFxAA5E8Q+wcipPxOuyYUbIaekkm8oBTAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uM9FfiSG86jM671oogD7oTiiGWVJNjb+M8dIiN2UMRo/YzcWvuc2qfZKexojaNSFsenPaxWBpvDXFB9JCSeU8hwzbycV7CEA89QaSNsLpDF23E90dHzL1eq4lRkPgFUGtNq1ucQrtrR5KJJuvtd5aVi5t2/ym+a9SeQAPGE8geY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UuTF9rfq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UuTF9rfq"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QFck7b2346011;
	Thu, 26 Feb 2026 19:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=ZOpTcPK2y0nD3/uYtWpdt2bgFM99SKuyHr2lJiK3CbM=; b=UuTF9rfq/vQr
	DGgg55EgHRf3vK5PZZnS5aBTqqjx5VDtltWuBMSh/Nzb5TsxfsFm8dq2OGsPEPi/
	rNJLryJFFjAbukmcYmzrI8aUdvudfdDYYbAn4S8om1AyuxWuRsvgpfRjxZp/UQZL
	OFVpP/qOxvTb1r1+0JVZm9nAVSkAtjE34pJkiPwCsFXEUvhacN6dlFTGwG+91+sj
	NDE95AetdpJUKITIldGV20Bl4GYnI4ql1BYUcWLa+Q2jCzV7erKhnAq8rHLGE5f7
	nkP2KHo55gH9a2blC3Z1FRWcqgFf2WPheszCYHkYEqZ7Jh2v+DgJGNo3ti1+er5w
	v8Hv6bpdoA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch858x1u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 19:31:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61QIBWKN013419;
	Thu, 26 Feb 2026 19:31:09 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdydrxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 19:31:09 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61QJV7XE28967542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 19:31:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC17658056;
	Thu, 26 Feb 2026 19:31:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D33758052;
	Thu, 26 Feb 2026 19:31:07 +0000 (GMT)
Received: from [9.61.243.9] (unknown [9.61.243.9])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Feb 2026 19:31:07 +0000 (GMT)
Message-ID: <42881e7b-3e29-4024-83e5-fef5cf109ee0@linux.ibm.com>
Date: Thu, 26 Feb 2026 13:31:07 -0600
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: ramesh@linux.ibm.com
Subject: Re: [PATCH v1] PCI: Add write-only 'uevent' sysfs attribute for PCI
 slots
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260225150815.81268-1-ramesh@linux.ibm.com>
 <20260226083427.GF12611@unreal>
 <b4d83f50-c3c1-4fdf-bc7c-50a3cc8353b6@linux.ibm.com>
 <20260226183945.GL12611@unreal>
Content-Language: en-US
From: Ramesh Errabolu <ramesh@linux.ibm.com>
In-Reply-To: <20260226183945.GL12611@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE3NSBTYWx0ZWRfX6xv46VdUMlwA
 GwBcKRt1HMVy8JYCHr7BJeIKUw6aJ1VdTa5y5aNXtdZr+0lGzfW6DbOZuoNlLfGrWp/d20aBvCo
 QUADrG+NvzF5ueMsaXH2x7GezClEILyTEF5d6lSUbdYYBWkN4MrSj01UmO6aV9O5liVtoOS/2SZ
 CLFXwkEG6Nhr8Lwmc5lZp31985z/St0Qqg98BowC++p3Ju7ndY6FfS2k5xGubci5QIRhHpx3yDo
 lyOpGL2ms6/90FF7PfKJlnfAkDxXr+YS9YMDZVhs3ls2h5wZxnbI+a1H1qZMdvrpApAg+1f1RWT
 Hu8kvrvc+LoJw5CGDPJvJL54PZF2vsJTCWdDlFB2KmcjdeB2UpHhjP60QpZAirAkAic2AWiDPp7
 iw0EmsHkf4+KvPSs78WMEckcbjMBLgw3CaG0xGpqXqsRyVh/DIqR9E17P1Iuc2GecEh7a1ciPFb
 YRrDa39v5VS62kChC7Q==
X-Proofpoint-GUID: TVibkwAW4nx1_f5rVpCICBcPEW8aVTAO
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=69a09f7e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pTvyxW2jlTLOFkXi-P4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: p6U201HOV6CEXqgCLlnGTi9831XKcc-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260175


On 2/26/2026 12:39 PM, Leon Romanovsky wrote:
> On Thu, Feb 26, 2026 at 11:53:32AM -0600, Ramesh Errabolu wrote:
>> On 2/26/2026 2:34 AM, Leon Romanovsky wrote:
>>> On Wed, Feb 25, 2026 at 09:08:15AM -0600, Ramesh Errabolu wrote:
>>>> Add a new write-only 'uevent' attribute to PCI slot sysfs
>>>> entries. This provides a mechanism for userspace to explicitly
>>>> synthesize PCI slot uevents when needed.
>>>>
>>>> For cold-plugged PCI devices, slots may be created before
>>>> udev is ready to receive events, causing the initial 'add'
>>>> uevents to be missed. As a result, slot specific udev
>>>> rules that define naming, permissions, and related policies,
>>>> are not applied at boot. Allowing userspace to resynthesize
>>>> the 'add' uevent ensures these rules are processed correctly.
>>> This patch sounds like a hack to me. AFAIK, "udevadm trigger"
>>> performs exactly that.
>>>
>>> Thanks
>> AFAIK, PCI slots do not yet raise a uevent.
> Right
>
>> Secondly there is no uevent attribute in slot-id directory to submit requests to raise a uevent. This
>> patch fills that gap
> Please start from the beginning and explain what you mean by 'the gap'.
> Which scenario failed before and began working after this patch? From your
> description, it sounds like the behavior should already be covered by the
> 'udevadm trigger' command.
>
> I want to note that drivers/pci/slot.c has remained largely unchanged since 2008.
>
> Thanks
PCI slots are surfaced early in the boot process before udev daemon is 
able to run and process these uevents. As a consequence any uevents 
raised by PCI slots are lost. To apply the relevant udev rules, we need 
to raise PCI slot uevents a second time. This cannot happen if uevent 
attribute is not surface by PCI slots.

To me the sequence is as follows:

- udevadm submits a request to raise a PCI Slot uevent
- PCI slot uevent handler constructs and publishes a uevent to userspace
- udev daemon receives the uevent and processes it i.e. apply 
configuration encoded by matching udev rules


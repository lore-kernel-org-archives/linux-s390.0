Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA1B33F584;
	Mon, 22 Jun 2026 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782161355; cv=none; b=r8cDis9Ry7NT1SFAk5K0GXRTXkDvkVjiPao/xb096g/XaB5nnstlHnqwBppaItOg0hs9AecEc3dfiezE/LTs4d5E/4mx+k5s1Ljk+37JZE9oS4vQ0VTgACM9xJ2Cf/iu8E2oc9CyUB6h/cQUQsNz+eSa05Fy+tOTsA9gb3uqR20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782161355; c=relaxed/simple;
	bh=5nb06zIUKKX3YKOKNYOEW5KgpouhXO/luK3rI+Eidqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifydvBSGU7+0Z6MKglEydlh6ddoAMJrrDU3BL14fFpOPlCrRZTCBkNoF87tJNyVsZR9Di8E7wflxRbp5sWPsbCZwj/A6YRQSSn7luclFTZpVmMKvGW//jTKxw386x4ic/MZ+j/YJT8pqaC7NLc9yL2bYjk7DockMw3/RmnR8C1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ALKQ0FnC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ALKQ0FnC"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MJmo9o3992124;
	Mon, 22 Jun 2026 20:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pTPXeD
	5GdkSQA6l0cG4/0tPeXyAPzjSNT5AD5b8actw=; b=ALKQ0FnC1kIM/qCIorGKkw
	I5bBf7kqL6OqdW9ubl+JxKkRJUmF3DkgtG/I2eXupq3zX2PrOspE+8NEcOQZDB2P
	4QdY/r6fvhrCEex8l3od3U9rr/Yuu6NDglcm3slXE2D84zDLXwAaA9pSaNi8iyP4
	ZBWYrDhQOpPiDWODFz2LsSilqdkuof30Q0rCphuop5ztlVZRYhpxjFDMxr3LPbi0
	7pk4U5lVBKbS6gjhzZ5ai2K6Hzq45QdQWxLZZ5JOPXw2hpMf+XgZCAwX4ctx24+h
	VDvkXWhwVdP0s7OVd7mIpdT+t7JWLxTjvlvkjaXrOx1gCqkeEEnHQ6/njt22ArxA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3bbkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 20:49:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MKYgu7031190;
	Mon, 22 Jun 2026 20:49:09 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56q8984-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 20:49:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MKn7nG19268216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 20:49:07 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39F985805D;
	Mon, 22 Jun 2026 20:49:07 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 903A058056;
	Mon, 22 Jun 2026 20:49:06 +0000 (GMT)
Received: from [9.61.251.231] (unknown [9.61.251.231])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 20:49:06 +0000 (GMT)
Message-ID: <c8abc1c8-71e0-443f-820f-182c0ff931e9@linux.ibm.com>
Date: Mon, 22 Jun 2026 13:49:06 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 4/4] PCI/MSI: Enable memory decoding before restoring
 MSI-X messages
To: Thomas Gleixner <tglx@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
References: <20260622171840.1618-1-alifm@linux.ibm.com>
 <20260622171840.1618-5-alifm@linux.ibm.com> <87ik7al3of.ffs@fw13>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <87ik7al3of.ffs@fw13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a399fc6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=I6BqXQysMxH1PwLeqfwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwMSBTYWx0ZWRfX9/OaY6gjeOmW
 3sfThE46CAUmVmfc6bZHvi2PvEsIxagk/IP77obw/nE/QiF79xoTprIBBBcoU3g2UJYhWj0EJ8/
 MNr3u85b2SzQCsSQRYhNjI4j+rIaE2k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwMSBTYWx0ZWRfX9bbhC4mjbZ8D
 NfOBiXDa6/l5+ibRlhY7r3Ci75bAW5DMyVNPpAaBrDGfprEGHgrqYo+uyyfoxgyuw3RYBrT9/yE
 1Egr1iQFaImXE0EhVPJI0Rfkh4fPzpqjdgTtTBL3ND0VRG39XjctnrH8ww6vbko74N+HIvYBpiq
 GxOw2/IM2VG+RJ5p+YNRRstSq/gG0MQYHgxIZvUX5BfBqdiupWOuzl0TDsNuOrsE+1Nx4Dj7Lbg
 fXTVdYOZKdB3PMEXcSd8E8/zwQCJCUyivZvTpB/S3sdDICLU2A7Qse1gk8WLVziFEFWLDYBjm3T
 bA8sIyp3W9qdOYOHm+UP+5utQh9ab3pn87M5iz9ul1zu6Z9oH/XVBcC3s0OCtp3aVigrwGofZea
 5OdSGQ9yzq5jp1QZRuOdrwhNr2E1YOd3d1oH1l2tta5qdR9fR/ocEFP/cHQRJDYBOnCnYT0242P
 I8WN48tPUiwPVqIc12w==
X-Proofpoint-ORIG-GUID: Kd6CNkq9T2U5Ngh9O9AbzR5MSEOjooDL
X-Proofpoint-GUID: Kd6CNkq9T2U5Ngh9O9AbzR5MSEOjooDL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220201


On 6/22/2026 1:29 PM, Thomas Gleixner wrote:
> On Mon, Jun 22 2026 at 10:18, Farhan Ali wrote:
>> The current MSI-X restoration path assumes the Command register Memory bit
>> is enabled when writing MSI-X messages. But its possible the last saved and
>> restored state of device may not have the Memory bit enabled, even if a
>> device driver later enables Memory bit and MSI-X. Attempting to access
>> Memory space without Memory bit enabled can lead to Unsupported Request
>> (UR) from the device. Fix this by enabling Memory bit and restore
>> it afterwards.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/pci/msi/msi.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
>> index 81d24a270a79..46a0d9f68a57 100644
>> --- a/drivers/pci/msi/msi.c
>> +++ b/drivers/pci/msi/msi.c
>> @@ -874,6 +874,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>>   {
>>   	struct msi_desc *entry;
>>   	bool write_msg;
>> +	u16 cmd;
>>   
>>   	if (!dev->msix_enabled)
>>   		return;
>> @@ -882,6 +883,8 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>>   	pci_intx_for_msi(dev, 0);
>>   	pci_msix_clear_and_set_ctrl(dev, 0,
>>   				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
>> +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
>> +	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
> Can we please have a comment there which explains this? Three month down
> the road this will results in head scratching otherwise.
>
> I agree with Niklas that this wants a Fixes and a Cc:stable tag.
>
> Other than that:
>
> Reviewed-by: Thomas Gleixner <tglx@kernel.org>
>
> Thanks,
>
>          tglx
>
I can add a comment, how about something like below?

"The restored device state may not have Memory decoding enabled in 
Command register. Since the MSI-X was enabled for the device, enable 
Memory decoding before restoring MSI-X"

For the Fixes tag, do you have a suggestion for a commit? This behavior 
has been present since 41017f0cac92 ("[PATCH] PCI: MSI(X) save/restore 
for suspend/resume" which introduced these restore functions. So should 
be Fixes against 41017f0cac92?

Thanks

Farhan



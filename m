Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566AF3A168E;
	Mon, 27 Apr 2026 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281117; cv=none; b=rRx+1gCWOtCUOqntHwbwoeDVzQfpLtQYtn38nZ9N8uC9dax0nxKS1CT46jUrwmKq9ELEDdrd/vaWRYUyM5fyT4Qo51/LOifsXRyDUtm/gXEIEt8KW1aEXli6IBbsT8pbzqnWro/5u/UD7UNmv6r+jzPXKDMiDLmeu4xjX4x8BqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281117; c=relaxed/simple;
	bh=ibj90ucvfuedS/Kl6CavlfCGva/LaQk9fOMfTHKrdHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVeQoziWViDjLIY2V1bfygBqg7BOTq7ckgK9QtpqKNm3JqVs8iSPHKySS1UP1mRj08G1aq8wjmgAh4iyyApMzQM7fR94nSJFmvntJlD/BcfMH8840MOUD0lacNrTIU7AVoLaJvZWSSNjGnY2ixMEXN9ujx0tfs1hWp4y4cis77E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f4m9aPW/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f4m9aPW/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R7AU3S1471075;
	Mon, 27 Apr 2026 09:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bkawYp
	dw0MS19iYH1TnJPQfkpOrWTavfGjkEyhpOTkc=; b=f4m9aPW/Mo9E6bE8UkLEy6
	7QcovlaGTdpXfFVIiaLNojxfzkbZozwhgujMiQdNyVLU9Y30LqPLlno1eKd2UPKY
	Hs6N9eJlTBbyPrBAQCZ9MwC8isXdQA8gClm5USAgWp/Zj3DFd8t8+Yfb0ZGfIB1Z
	iAVsGwxamfYZHpskti1NRmqjZO/xLD9SFe8R2SeMKR+HWUMdk75c4+9tiLDpP8lc
	Kd3Vw504uj2Ogail555w6TUVQ6NAlWPnt0m2tQh6c8hR8NMapZHtJ4pi+vaoBRz5
	iukrW+2jJ5EeVWoQEKmX4MIynzZoo7RY+S5uWTgOn503vmZw84DZiWpOOq7aKCqw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1dpwky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 09:11:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63R98ku8031723;
	Mon, 27 Apr 2026 09:11:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xjvfuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 09:11:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63R9Bnfx55116266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 09:11:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1898E2004B;
	Mon, 27 Apr 2026 09:11:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B475120043;
	Mon, 27 Apr 2026 09:11:48 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 09:11:48 +0000 (GMT)
Message-ID: <55283723-de93-48aa-b6b6-fdb16f34b42f@linux.ibm.com>
Date: Mon, 27 Apr 2026 11:11:48 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: s390: pci: Fix aisb calculation
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, david@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260424193900.940816-1-mjrosato@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260424193900.940816-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7sl0SG6HqU9QXDJYI6FQH9gjZ2OAWWk5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA5MyBTYWx0ZWRfX+z96JQDarAHw
 lZMKZKvh5A7O21WHzQfZFoVmffQXO/21djY8ZasH9WcCRqufz125HIYM7MDu3fyTFHeRFuZkoQe
 pqhBywVUx5h9jvCHAWyLhzeZjsVytDyj3KaF7uG226amlZ3Kwgee1rQDp2Qpto4hx+o983V1WCK
 HOH/SkWpgbi2r/QeWGqxZB2DL8P+jbSdDca0yPr+FdmpMrBdddq8VcDDUy8aMuCr9En2iS9HfOe
 3qQh+paKSEGMJOU/fgYih/3RtDN8WkfEzfyhTGTS8rE1e5D0/dh8eDjHOnctSc9uM9UP7CQgmpA
 r5b3+KKqD1h4GuaBjAo5htHRAJrCAtbQga+5+bCO7rhfBUKrp/1izY7jkHKBj+ozYYyx+MDvGRg
 aYNV8t6yN7wifRQ0L0H6KVQcNMgcIAwWYHbjqvUg6WvMDVnQ2ZSOs7xzB0ILsU5+Eos5WP29sKA
 gLn7uwaZ6OLddt68Iyg==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69ef2859 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=I_NvfSCz0aYfcric7NAA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: 7sl0SG6HqU9QXDJYI6FQH9gjZ2OAWWk5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270093

Am 24.04.26 um 21:39 schrieb Matthew Rosato:
> The current implementation of aisb calculation will erroneously index
> via an unsigned long * as well as multiply by 8B for every 64-bits in
> the offset; only one or the other is required.  This throws off aisb
> calculations once the number of devices exceeds 64, and can result
> in out-of-bounds access as well as failure to indicate summary bits
> associated with those devices in guests.
> 
> Fix this by converting to a physical address before applying the
> offset, as is already done in arch/s390/pci/pci_irq.c.
> 
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>

thanks applied.

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1529E485CED;
	Thu, 27 Aug 2026 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846407; cv=none; b=S56GJMfPoaVCOnhiQ+widyeVusA9qIQHBJdlnYkL+fg8zPW0HyH5F6LqyeQyTJiJREMQ30FBcWMtWFSL4ZtJPLFAIjsjmu5dG6AzvAEcdZA57ee1fumQjZ4/9hyKxkN+GjCMruAW8uPIf7u360CKN4wo0EGNWnMK/sVP6x+eCLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846407; c=relaxed/simple;
	bh=XCoK9x2tTWApdyAMdxVvZji81rq0oOOPaF/iNZZ6XZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRm3euYQsBvzVzXN5W9et/yOtO7nISL3Sa16hezZDmfR8DUoOWxUElOLSWG0+PREGBkZKNUAoPZ0+f3nC35+1YOysw2J7JXad0Jc24E/W3EFdabKzDY2yhXdZ7GA/8is3rDfPuJAW3akRHQWdRY6Pth+kp+WbihMUJ7Zo8lsLXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nA6pQY+5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nA6pQY+5"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RF53N73355214;
	Thu, 27 Aug 2026 16:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=yvt3cWl97vF1q64PQl3PVkdFXTLVhQ
	M6q5sXf5SFUGI=; b=nA6pQY+5i/+bPFVlP60SzvSYpipuFYPk8dR2nfY+mEItWw
	6nR/nO+I50MzsejZbcn1A/93xHLYphQ1cqcq8mSCAQz9tBnxI5sb7G/Yz/XRGfD5
	7PELZJqgF3BjWHEeElawURcCjSbHHMqWbAobISJSN03tw0rf5eSUdlvXMm4jKgxe
	YbsuYUuU8X20W9GCIcvEPAyD0PAPx7IVpm90AhcXi24Q0AdOK2zwoIhjqlfb7FD9
	/QftR5Lmb7xVhNN/zADVSlK0/XoAjRWh9xHellgT2NOXfGfnu+amlfZxtWXWlQYb
	TIfhoO1f/1Sd1h76JYCO7Gn+m9ey08LCc/xLuleg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g56g99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 16:00:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RFuGpG006223;
	Thu, 27 Aug 2026 16:00:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhgv04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 16:00:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RFxv4645875608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 15:59:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 261D920043;
	Thu, 27 Aug 2026 15:59:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAFA620040;
	Thu, 27 Aug 2026 15:59:56 +0000 (GMT)
Received: from localhost (unknown [9.111.46.147])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Aug 2026 15:59:56 +0000 (GMT)
Date: Thu, 27 Aug 2026 17:59:55 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/mm: Simplify crst_table_upgrade()
Message-ID: <ttkfr3v@ub.hpns>
References: <20260827102832.3823857-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260827102832.3823857-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wYWo4jO4m6sbXUenrtU-A7ZRUBQ5ZRnF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfXxtaryh4Jovjt
 WFgsxV520NAP4P6A1TfrKuKzmXv4rznUHTE0VJ2wWaZjGXAi4GBKIWQ1+j+m33KJnzd+vpo4FxJ
 U8cAmvqPLMvCDYbfTmLJwfBdJ4pKfkQ=
X-Proofpoint-GUID: wYWo4jO4m6sbXUenrtU-A7ZRUBQ5ZRnF
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a905f05 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=xYfOwqoCNa0YIOl1ljMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX0SzfT9y8XBhP
 09p2LjhwkF9K2lOTxATNnXIUkz2+6oBtmbLo9q5XZbDSdbf3najHvYZMlIoJH62kb8SJ8/S+prQ
 eq5rgKxh4yGPluFmf1AIYQp5bxdG2zc6by7yhq6KQ/5k4ppKZ7xnZ1OxpQNHA8GLCFYahovvKql
 kXamDuJ7cFBTDMxJmj0AsVoI01msD6h3/ivcpHcP3UzrnXrTVWhHanDPgtx6KfIGXZqP/lRdlx0
 o7NaH9qWJld5Mb4SX4r4iLuuXq3s76yXG9kj1nnH6zTj9N+gYjLEJKuCFC9f8l/946Q8UunkavS
 IEaSSAVoQzCZtfWBresLReHPv4+bpLOfc79i8BPtA614RfKEoKVHJNinH3cwnWjAttyMxDrBiCm
 ikzRw2jHFWgk/nl0FHWbUpWc/9Mu+bD4IgarXaUBG5ADqRwrp9fTeicmvsWLk3kRpuFyp3NAwXj
 MTp4ac8AhFb4D/iNVLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_06,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270131

On Thu, Aug 27, 2026 at 12:28:32PM +0200, Heiko Carstens wrote:
> In case of an upgrade from four to five level page tables, and a failing
> pgd allocation, the exit path of crst_table_upgrade() would incorrectly
> dereference the p4d NULL pointer via pagetable_dtor().
> 
> Address this by reworking crst_table_upgrade(), which basically is a
> revert of [1]. Take into account that GFP_KERNEL order-2 allocation
> failures are very unlikely. Therefore keep the code as simple as
> possible:
> 
> In case of an upgrade from three to five levels, and an allocation
> failure of the fifth page table level, keep the upgrade to four levels
> instead of reverting back to three levels. This allows to keep error
> handling minimal.
> 
> [1] commit 31932757c612 ("s390/mm: optimize page table upgrade routine")
> 
> Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/mm/pgalloc.c | 89 +++++++++++++++++-------------------------
>  1 file changed, 36 insertions(+), 53 deletions(-)

Applied, thank you!

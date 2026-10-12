Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8E32D7DEA;
	Mon, 12 Oct 2026 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818899; cv=none; b=JhrMb2OdeYuNdbnIcW3OEbDVqQWej3AwWRlvZB0uWM1QvTrWkxtzOgLIF8iKVd2f9ZinKOsvfWggjzfG/MdtP6WZQTLzdxARzI4BPHeZsGOd4Cww9Z2vB9p2uayerPKx+ISL4Wlc8xfpCApPi6Cwt2zarf01oGi1vFzY4k08VE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818899; c=relaxed/simple;
	bh=22pMe/nmthIY//FQIDlTXxkLOA/wBPs1Jml53BrCbbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lD/z+bNsf8Fg2milYQYxo8OKQw4xhp9nrBS9+11TEF23wxoXsYCjpVbWnOeevMxseS5mCghLHr7G3c4oJmRYjheezlyn9iGC3NcPUo4zs7DV4qs5hEfNteQL2zPzbOeZePtlzJ19JVOogdIMEGQw1VlCBDsoIYyzCg8CSZxewnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p6RgdBn9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p6RgdBn9"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEE3o2640651;
	Mon, 12 Oct 2026 15:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ri3qhM
	VeSPiKuxJ8OlqGTzXx1+xASnW9vnSTOqfQTF0=; b=p6RgdBn9dH2ZJNNA/lmycJ
	wDgoHd1p0FFjO14BsehT2CcAmamo7b4SKZjnXvAAfUQF0Mn25yDy2Bf9VMBYGYDX
	1Jp6h0ZpZoTFxxJS9JG4wr0pwp9kLi9zn5El2z+xbuwHCUze64GGmV2L4UxA0DWq
	FmmH8MYdyC1H/C1QAy8zxwhzKYhvdEhMHEiXI1mhU39iCIqm5tO+y7kl5PU2427D
	OZLIGotZuU4vX9UaevaqmOyZfXhz9J9LbNqnhK6LpUV9OhCSAQsKuxgBxvempkJe
	g7opc04WoQ8GyylckPkDiyA2RukDva9A2dW2awuMtOLWno+a9uRvvq/gN9kHQCBA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwh9m55-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:28:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4uYs1286251;
	Mon, 12 Oct 2026 15:28:09 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cydgvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:28:09 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CFS83A33882840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 15:28:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A7B35803F;
	Mon, 12 Oct 2026 15:28:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D06858056;
	Mon, 12 Oct 2026 15:28:07 +0000 (GMT)
Received: from [9.61.99.49] (unknown [9.61.99.49])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 15:28:07 +0000 (GMT)
Message-ID: <c1f62ced-3fc3-48d8-9ee3-a905eb5dd97f@linux.ibm.com>
Date: Mon, 12 Oct 2026 11:28:07 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] s390/pci: Adjust alignment in insn trace
To: Gerd Bayer <gbayer@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Farhan Ali <alifm@linux.ibm.com>, Cam Miller <cam@linux.ibm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
References: <20261012-rpcit_trcfh_upstream-v2-0-1812db73dfa5@linux.ibm.com>
 <20261012-rpcit_trcfh_upstream-v2-1-1812db73dfa5@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20261012-rpcit_trcfh_upstream-v2-1-1812db73dfa5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MCBTYWx0ZWRfX2qNYu3hjAe8j
 PBLHoGgAu6fvRkNbModhMfV9tsUyAh6fFhhntgff4g93ap1jBcmgokrME/MMq7LFYdjWrWqi1s5
 ozW6gNEXm4iooob9aTIK5LLA9ywtU58=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MCBTYWx0ZWRfX8AYBmCntoG9A
 YUBuO8GeUoV5dw388GVll63Ptcl5tUPmBXe6+iX1sSQPDRuf/iGiHVB8Qe3N3n8xpybSZexYEAv
 XREOD5aEQr8YP51gPLjoh9chvSZLp2DbwJt6ZgvXRmPBPbzG6kI+tWk9VFf/f9pSUJB9G8/qeSs
 0CPxVGeAyPYPVXhtTy3GzgUdaTXqaIsOPcmcP+YtCnVXFyvhuvGCI6MNKZ4Xthm8kPbOvmX6F8Z
 B6Sov8WcH6nuvID94uWlHf+vGX7UWs4gB1xvQlNr0rVmduWsNQ3YaxoLuxfA8H37hsoQ/zH9J9U
 0vLIuEz1pY1yQrEgSA8H8aYwMEdsDYAuNKBx6FhP8Xak5S3W88x6HKoY91GiEC8SxX+/wI8dbs4
 Wv84tD8FVFPskY0mdJ8ZGuVDrTATlf99v0IyZIIxfmlV+fTZf6soAlDVSCpsaHWRqdLXc6bm4jU
 t8H0cHFIODvEGDa9+7g==
X-Proofpoint-GUID: NwM0GLfNnkP64LzR5vUEEXjK7C1XMqVC
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6accfc8a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=adKYCXwJefUVjfYyQAoA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: NwM0GLfNnkP64LzR5vUEEXjK7C1XMqVC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120060

On 10/12/26 10:21 AM, Gerd Bayer wrote:
> Currently we have 64bit wide fields start at odd byte-offsets in the
> insn traces for pci_error in the s390dbf debug area, which are hard to
> decode in hex dumps. At the same time, trace entries are padded at the
> end.
> 
> Drop the packed attribute on the struct definition to exploit the
> compiler's natural alignment, introduce explicit padding before and
> after the 64bit fields for humans, and add a static assertion to avoid
> accidential overruns of 2 lines in the s390dbf trace.

nit: typo 'accidental'

> 
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>

AFAICT no impact to the amount of space used in s390dbf either since we
were already claiming 2 16B entries -- but the result is far more readable.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



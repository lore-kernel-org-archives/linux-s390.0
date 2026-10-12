Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39941D9A66;
	Mon, 12 Oct 2026 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817247; cv=none; b=b7B4gUkO8iPxEKFThJEyj9Pjo5yN9LaR0qaXoalPbRf+4CUa7SvbMRjGGK3VwvmRufJ8tMdqLcoMk6/NebVuDTiHS0ey93+T/DJQL6mRXeMdm8VfIvEpPnTNhRkijjalPweY0Ef579ysRGUOM/+xPsjzNr/r/68hp/a/tLY5gs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817247; c=relaxed/simple;
	bh=MH6EBDrTK5ukk5y0vUuR9ya65ZocP97qMe2uWAQ8oDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpZ9X3is2AHHlwOwMgiM53ZefEdIR0JglMx/xYjG3lJqdD6GayDriwnwTKk3DdKWWOekPGmzXfqFWOZzhSITPexyXgSZL0XmIGsFhEsDiy4d60hC7+3De3sab2otq9GjnlMEC4elob88BejHim6VCYEBg0QwaL1XVq4TCI/cu5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZE8woj1W; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZE8woj1W"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEcoQ182992;
	Mon, 12 Oct 2026 15:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=69iTk3
	RlNbFmsGXI2D5OXVHyiJORQltkTxhCbqDIuX8=; b=ZE8woj1Wv9xwW1gXv9LwcD
	ZfGIqBcIUpcsFM6Kr+cEwiNbvvTzKrpJ28WgG1sABeoXnGoVTUhj1U6W5n1Dn83X
	TiDlXUR+ux8ICuEbQT/u4AONUnfMxqc06/G/iPMdpNn+elEDpT8MKljEuIZxJ+ms
	CMTsInGwV+4H/q5kxMf6J1ykef1Mr+N3skAyqkNJoTyYUKoc79QaH1GUN1NGBv9g
	ZUhFGBtGFKvB8CQ/nv2tUeos3s9i8RozTMpnOhzG+RivR+0KgPj/NaOMOAI/0Kic
	21sMAjvDTDI7vo1OSgMRAu5I/VT+n+L5zjh8SLWHefx06F+3r9QlEM4hZJgnRt3g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv39g0y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:00:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4vvR1286256;
	Mon, 12 Oct 2026 15:00:37 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cydd9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:00:37 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CF0aF731916428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 15:00:36 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B993A5805A;
	Mon, 12 Oct 2026 15:00:36 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8CB258056;
	Mon, 12 Oct 2026 15:00:35 +0000 (GMT)
Received: from [9.61.99.49] (unknown [9.61.99.49])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 15:00:35 +0000 (GMT)
Message-ID: <26614f2f-f268-4080-b63e-d9731a361568@linux.ibm.com>
Date: Mon, 12 Oct 2026 11:00:35 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] s390/pci: Use 32-bit fh outside of inline asm
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
 <20261012-rpcit_trcfh_upstream-v2-2-1812db73dfa5@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20261012-rpcit_trcfh_upstream-v2-2-1812db73dfa5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BvTDM5IWfLPBp2RBS7IRTVsYoldZtv0_
X-Proofpoint-ORIG-GUID: BvTDM5IWfLPBp2RBS7IRTVsYoldZtv0_
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6accf616 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=QjwOVO03zLqjE2D4bbIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1OCBTYWx0ZWRfXwj93AQlgwozU
 CZu46gzdnvll4lsbortk+5PN/paphFEtxhtONudTRci8wWaNdzsxTvbJPGuKHEuSwkKDiowiNPP
 z4pk4SM6rZGeUE8sx6ft2orsi/7fJKo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1OCBTYWx0ZWRfXwjM6/IBo81e7
 bknFrxVS64tnKdOyrltiIXUvf/HrWUvuFWu8p3TVmKsEKtWhYlrKkdZR+lUUoycedhmZQB0is6L
 NNJrLPak1qCQfcfJWxQrFC9+tsC0E2k3TbJxmtVQ7LLsWnl3DShnjL+meV40m2Sd0qv1piiooCz
 HYg3QxTqF6qU8P8rlQ7Hqz7rT8ZEny7PFEqE+RZvkR52wD/lIjunxiw/78/1Iq/7FD3cFe1t1mo
 89gfSr/RE+qkU4sN5XaLNxpAiMl5riUVit1TEaiI8WpRwgP33owYKJlqiwBnLACp8iWyN1PrlfA
 Z7xNmF0y+C+G7rSdCXpREZJxhe9OiYqWi/nC3tfYhkVVaGtLIUA0G7jOYyDJqqyzaqV7/L5w8ms
 dWEozR9Z8Sg06cTApRX1TPbRIVqADszD/kWX/3gmeGbF41zvM6zKQ0vBWN3Dd3AEAX1SLJBiC9k
 gS0mEqCiPOM/1/NhJuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120058

On 10/12/26 10:21 AM, Gerd Bayer wrote:
> zpci_refresh_trans() declared the PCI function handle as a u64 type just
> because the actual RPCIT machine instruction required that in a 64bit
> register, while the function handle is architected as a 32bit type and
> defined as such in the zpci_dev struct.
> 
> Push the extension from u32 to u64 down in the call chain to just before
> calling the RPCIT wrapper function. Since the struct of the typical
> req's matches the format expected by RPCIT, too, create one of those to
> pass along.
> 
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

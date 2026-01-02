Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC018249E5;
	Fri,  2 Jan 2026 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767356833; cv=none; b=ImCb8Wiwf5ywDcc4or/h0Dxw1ASPPg3fYarv0rW8DBNBzvHEW2ZoTYQzhGNM/IumkgHSYmQ2PheaK77azl+vV7vy9JH4obWQzhvHzvKTP1Dpj6yfTGI8NcyNforiFQCeSHtusfx/QtjQZsc579LUaBkzsreQf/KDdf/YGIGS/iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767356833; c=relaxed/simple;
	bh=nLRP2xvg/Gqu+jcPubf6ay+AO2e5WewQYbcjrwYzWSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFrXZE17S6t5EFwO8ZEojBRi27OWcJjwGbERQ0Sg1tEVCy7gGqEc8h8aDiXne3ZPXijlkJLXMpJYOrxiaf4Pqtb/8E/stCIHXESzCht17EBav31aTYJ+sKFeqU3V3grj+a4ooxwho8SSerk6jCxpHS77sWKVEGTzDwNdSWJ+eCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KvlUT2Kg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KvlUT2Kg"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 601KOuhj027398;
	Fri, 2 Jan 2026 12:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=WytNTtY26hXeOquq7wZ72AosSXoDBo
	edrG065XS6lEI=; b=KvlUT2KgaUt8f0+kMAx5l3OjDKE7itkF7sKz5Clfup7LGt
	DAUmIo5jqMp5P9qiU0/U6cHKNhPsxcoagcOT1dgy0xPpZXiZwt51nFlMj+FnevE4
	YMcjtfwPMEjOnxgZy3MnXJxagszJbnxMZOX46FmqXtmu2/XWsS7YFXkfd/hzTJjm
	Du9kRA7nUXbyNoxOSKUR4ISIe55SKtf50S78Xry01ZGbyakw3WCq108mgb8qaL9O
	S4AtU56CpU5W611cBD/hi4DUSzs2VFdmHNW5ePA+lNPkUt3QAr4FpDaQ5M0PPJp1
	YW0mibBGJM8GpKF7jLzS6wXWQoV2raU5DKuQSeTw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba73w4cv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Jan 2026 12:25:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6029uS32023931;
	Fri, 2 Jan 2026 12:25:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bat5ypfyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Jan 2026 12:25:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 602CPAbb17891680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Jan 2026 12:25:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D2BE2004B;
	Fri,  2 Jan 2026 12:25:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1719320040;
	Fri,  2 Jan 2026 12:25:10 +0000 (GMT)
Received: from osiris (unknown [9.111.41.241])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Jan 2026 12:25:10 +0000 (GMT)
Date: Fri, 2 Jan 2026 13:25:08 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Harald Freudenberger <freude@linux.ibm.com>, yunbolyu@smu.edu.sg,
        kexinsun@smail.nju.edu.cn, ratnadiraw@smu.edu.sg, xutong.ma@inria.fr,
        Holger Dengler <dengler@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/ap: fix typo in function name reference
Message-ID: <20260102122508.10318B3e-hca@linux.ibm.com>
References: <20251230154239.98756-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230154239.98756-1-Julia.Lawall@inria.fr>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8vNtZse86giOYz9XlQrrP6kIwdKNvVTq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDEwOCBTYWx0ZWRfXxe/7aCTrOvY2
 XrQWTdwRyLDwg9JWsFJ5dOxT2M5WXFG+XQbfWbEyMsvmf8RDnmPlNc0UkP8FViFj/KRZpz2Bl0T
 J5/ialtNClGIOIiFYvJ3gHFFdydTBuddjFWvC3RaLmiM3E4v+X0+oYmgytbg4t5fbaFU34snhBr
 XsfKDmzQSiGwTm1ZglTwrWv4nhLUQYvXJeWxPU8Kf/ELa6tay0cIpVJJDauol45NldCIr3Uide4
 cDcfug4W4GoRzxqXpc91gOxlBZcSCvnEMebK/iTWXR3HcVrl1EGKy6kvmbil0I5Hn91NIP3IQ+5
 DtNcu1wNQa0T2+Yx/JhRqGqYEwBsD3rPbHgQkNkyxhd5bFG1g48RKy6H5fCZvU8ReJLwCLYnrSl
 3K+Rio+t40vtxK45OVYHneipEwe/8J7f2Bta7KIRSKc/2Suh4ce/SInASL9yeqbBMDpWhCxG8xS
 OO07b0FNgKte9cndhbw==
X-Authority-Analysis: v=2.4 cv=fobRpV4f c=1 sm=1 tr=0 ts=6957b92b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ULJ_M-2MmIJxTCu8-3gA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 8vNtZse86giOYz9XlQrrP6kIwdKNvVTq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601020108

On Tue, Dec 30, 2025 at 04:42:39PM +0100, Julia Lawall wrote:
> Add missing s into ap_intructions_available.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  arch/s390/include/asm/ap.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks!

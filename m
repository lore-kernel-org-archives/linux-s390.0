Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198E627F75C;
	Thu, 11 Sep 2025 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576720; cv=none; b=J73h0nwXsv1KU2YVbnnezD0Jy9oHSx266G0Oi1qA6kCFGFJScDKruaNLxa7YwAwwDEXbZcwx4PSGI2+iDawfk0p0zd/9Uld6R65SVH/F7Uv2UdgcVEI+0dOKeSF4+GmIiG41VpX2B4fXt9raAQmkftC1xVDvl6Xjzb6Ddsv9Tgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576720; c=relaxed/simple;
	bh=NV8wqqoaTIkMTlSsCaCyS11wleJAlSb/LXomgfMVyVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1KhLqRKZRZf+c5pW5sA3nBnbi3oMHK4p6IeIrC4VRod5SCV+2mtMmdJ8gQhHG/gEj4E3WS3HCuatlQA1qvz5KWCXBtgbDsW166WFX35xtTu3KbQYSR+raaSHZmITkoNG/mKu96jGD/H2gJZrzYZmGFwmsxpI0SRR6rQCr8BkO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ggjSZJFI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ggjSZJFI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ALj16i015917;
	Thu, 11 Sep 2025 07:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=L9NvhQ/S4FY/HXtEjOx6eWFL4Nhaqp
	glhWizE44sSHE=; b=ggjSZJFIKvfLNb8hHdwUHi4YqIPQqNmgRc/5mT2Zi7kwbs
	whbm0IG7MbekB0Gh4nP1KPuOPaxWXTF/C/ZJV8enG1rBkWdp2v9Ylgy0xjmu+a4r
	xNVsGhtTOoBwhdgYgLLOnqMQ768eTVQfAlvzifOTQWOZSWNJr3wfYoctHBtRJcBO
	yC1ybVT3zbRCNfqIumYhFrXXPHBns46L0/VAFjZ8Z9uZwtH2EG6E4VLGh0/nGB07
	mqcTXc0SXkrSF6deaOEKSS+6Gea00djXllxgvFJ6yrMW6Nw9ydcHYJyI7+3z3B39
	jdKZa+B14loRxs6KwTzB4KNl6o+bKykEBRBkMKgg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cffk6vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 07:45:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58B4TTeo011434;
	Thu, 11 Sep 2025 07:45:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9umwfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 07:45:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58B7j33m6881592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 07:45:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8F1A20040;
	Thu, 11 Sep 2025 07:45:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CC2D2004B;
	Thu, 11 Sep 2025 07:45:03 +0000 (GMT)
Received: from li-3a824ecc-34fe-11b2-a85c-eae455c7d911.ibm.com (unknown [9.87.156.46])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Sep 2025 07:45:03 +0000 (GMT)
Date: Thu, 11 Sep 2025 09:45:01 +0200
From: Juergen Christ <jchrist@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 3/3] s390/bitops: Remove volatile qualifier from flogr()
 inline assembly
Message-ID: <b326445d-0aec-44af-95f0-143dda6e635c-jchrist@linux.ibm.com>
References: <20250910151216.646600-1-hca@linux.ibm.com>
 <20250910151216.646600-4-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910151216.646600-4-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z5XWPnnXBTTPlts4YTcPyDvVCihWxfHB
X-Proofpoint-GUID: z5XWPnnXBTTPlts4YTcPyDvVCihWxfHB
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c27e04 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=UgCQg_vQzY_h6LtPfmAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX7nrIzfXrmjn8
 QPb6DseKCIosABRJaVnB+BcLxmqsljK/S8OPy3vVoAn2407arTVS+sN5+En8wkEs5TTBaFkqG4E
 Cm082CYHNGr/1vruTo/zXafa03vznCNsUSya/SRXK0Je4YaHLjXyZYwQ4GxXu4bz1FKVNTxXOck
 mw6v+UmKGrrKxOtG61FvEhIVIx2BZhy74i3OUma+fj5fupGvk4nN4EVSx/4US+DO/vI8aobgnIs
 qmtuGCL1ZU6WAjj0zUx3zyMz1sG1YjE+8rBhtk5tSgQOaPwMAfQPp8Xeodl/gUvm8t3yA2gEnS1
 WixyD65CJhd9E8TxTRrCSHlSymzhqmuwC6Ft9gagIUjsuOFIsRGDY+eL/tU22AM8uZmkMBQPwI4
 VR6+9N4D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020

> The flogr() inline assembly has no side effects and generates the same
> output if the input does not change. Therefore remove the volatile
> qualifier to allow the compiler to optimize the inline assembly away,
> if possible.
> 
> This also removes the superfluous '\n' which makes the inline assembly
> appear larger than it is according to compiler heuristics (number of
> lines).
> 
> Suggested-by: Juergen Christ <jchrist@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Juergen Christ <jchrist@linux.ibm.com>

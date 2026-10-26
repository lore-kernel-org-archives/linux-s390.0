Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003578;
	b=Q7vNt5lFlM7i8HTY3+uTSim0d2ky5vE59geP+OUbWXx0RYx/87gU9RoPDsK/ew139UdX
	 6z85iCMQMURMKDuZhCeYvzgLDOxC0zoW0L3i8JqFDjM+ZDUHF4fyMVPnJ+xWJT1NuGaN9
	 zNkXVmUNb2KT0fNxHjll8+FO+a4r6tGPtk6DK9s4G+n1JsVGVq06iP0RornY46jKOJVXT
	 hXMd2FY4hIsH1bBEaYMRQMLHJ7LVj2E0Z9qvrVD7vVt6L/v4ebtd2rS2CrSAc+R2CJZPr
	 a3/4yWzMiBVbp5dBPqFB5NNP6oSsHSfzM6dwlhEz+1cWYB1jLE0oW0TO3yq/DkTWqjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003578;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:Cc:To:
	 Subject:X-Mailer:References:In-Reply-To:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rwC4GylDd9c+4eiGgcXq+Au8IRKCFRDfpJRHmKrbzu0=;
	b=n2oNOiQVCK1WApFEqVGzai7rAsyn6AFpQQcn/jxJNVcuPrf0au30ZDvspt9wd6Irzt9w
	 cdUH2T2cAwL81PoEeqIaOVTzQe8WyZPculAgQ7fQTEAP7shQwbEMebnNXLvkJcDi8KxfR
	 UqmVKerPWoa1S2banu2BmWHlMnQ+OVQ3TJ60Fh04itFNgwBrQLXObvgKq1LTkpXzExLWz
	 rxjfscVOcGIRyStNRs6CXI99cbPnSaPN2tibzXQrYoYJtNXb4kskbThLw7k/5zx7yY9F7
	 tCzOnu9LYrgLW2tr2LAaUQeLa6nmQvJnKxX/8FHNmVNZkSUFZvw2ChYXdvlojPxZ2MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=asM2Vvso;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81248606A31A;
	Mon, 26 Oct 2026 08:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81248606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=asM2Vvso
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q2ib1o1980582;
	Mon, 26 Oct 2026 08:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rwC4Gy
	lDd9c+4eiGgcXq+Au8IRKCFRDfpJRHmKrbzu0=; b=asM2Vvso7jXHjMtC/9M5L3
	dcrN5uQtdFeKeyZTdSyquIWuQPBmij/fJjxGVtic1wfGHubqTJBtBjR36rpKTgA2
	y59quEIbULrrV0ep1N5ZEPycSvqFgwvUVq0HyQhBkbejB96u5O1GuZJZw95T0kwd
	PLbprHd4K3+5N6Ejy022xOjkEDmGtJbIOAjLVWUmh4Y3N1CZbBuCXm9AQv//AKap
	dw5QlZ/beQgBaQmHupiVFlCIITdnPbA6LNaqj8aFhfjG7XZ4dA6BYONcs8s9IOCY
	eqDVuvcnJK9IbAZwOH209YESox1F1X+zBr9LQUyBpBizvzim9Si8UE+hSqw+uaWQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmav8ekd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 08:32:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q7IlYE1866617;
	Mon, 26 Oct 2026 08:32:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh7cvd21m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 08:32:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69Q8Wo6D31850944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Oct 2026 08:32:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39BB320043;
	Mon, 26 Oct 2026 08:32:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2720520040;
	Mon, 26 Oct 2026 08:32:50 +0000 (GMT)
Received: from darkmoore (unknown [9.68.0.144])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Oct 2026 08:32:50 +0000 (GMT)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 09:32:44 +0100
Message-Id: <DMEMPUIXHLZE.3GREOEACPXURN@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <borntraeger@de.ibm.com>,
        <frankja@linux.ibm.com>, <david@kernel.org>, <nrb@linux.ibm.com>,
        <schlameuss@linux.ibm.com>, <gra@linux.ibm.com>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 01/10] KVM: s390: Move some skey functions to headers
X-Mailer: aerc 0.22.0
References: <20261023155531.206113-1-imbrenda@linux.ibm.com>
 <20261023155531.206113-2-imbrenda@linux.ibm.com>
In-Reply-To: <20261023155531.206113-2-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6adf1036 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=I8xHs1_fuKMvQGz33WUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BuXP91i7icxqZzcZETifvLvOzOALyEHc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzMiBTYWx0ZWRfX5LbOnjXe6V4U
 5LJafm6/APZWF02pdYQvoYUWvU2E646ip5h3ImINBGs3lohGrUiYRXTH9AxVLEZrBXk1O5kAfVY
 dpBL17gkCjZsozJvZU34WhgCWhjd0Q8=
X-Proofpoint-ORIG-GUID: BuXP91i7icxqZzcZETifvLvOzOALyEHc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzMiBTYWx0ZWRfX11o05cxIg5EU
 U8qo7lmexJ4i5XdnTl+KSeMwBpls4FOQYdv1jy99baQaeiyzqIKs5Lb6wmguX6jGFF/TZHJm8yi
 xQIDqxknadl/GsqcpnBiVnzRmxTn/P/r9w17Ji21U09waNCwBOiAftBkcb9soPUcopwsXs/MMx7
 Pvv8rYoa4OM9sbOF1TaOeawLdkghV8bUD8aUkk4FYnWgl/zvrtqEclf6JxF9mFOOasI1BvXvrBa
 ZZuRcgcL0trOuEQiXSt+juR76TuMRV3YLgrrlWsfENoCaRP9vcTUg6enwLQNyv9EYHFy4qQ/O2T
 vrx1SZKf4ufRLrJWtera09MfpXBUvG92i/fYzDYRXpukLwctLJxeNmAnsTiflqkRUQThJAUbBUP
 H1S6X+GxXHO3d9WFR+VPLpMRjtVtY0MUNV09u0H9SUxdgqVjJ18ySdpeHoWB2YtMHsT0Wr6JRxO
 863YEj/a2vjxkEklOtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260032

On Fri Oct 23, 2026 at 5:55 PM CEST, Claudio Imbrenda wrote:
> Move some storage key handling functions to headers, since they will be
> needed from outside, and they are small, so inlining is acceptable.
>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/gmap/dat.c | 26 --------------------------
>  arch/s390/kvm/gmap/dat.h | 26 ++++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 26 deletions(-)


[...]



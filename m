Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFEF3A0B24
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882368; cv=none; b=CrfH8z2x9SZZN1lyTD70k5Oc486R88E82MwiSKh35vlXbEWJrCpWxkG8ETNtFDwyAXn8h13mrSPpKGK+oHj2N7aIDYlpWs6x5CRP4W5S4L7gmSLgZidtviYW3wC311WJcz3rtFTNgIcbym77uO9Q6qeoHVwvEXJ9W1XmavkQvJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882368; c=relaxed/simple;
	bh=u9VL4GuHh3TMLwf51Mv+EGBAFUXjVMJn9OQPeQBMBGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+zvYGRJdvCJYNsxm4U1BJnRwTTXtXQBaga6PGuby0WR9J7L0nwuLh2yal9BopCIdJIeBTU/x/hqHVk93xdL9meDNJ/Sn2bUDEarf9j8NHQHyHv4I68+V3iMiqQZNXk2OLAaFCty41P5H8/G+ZjMMIK+IvVbFo4nXPPBIQ9cynM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OxndzTLt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OxndzTLt"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2F3AN1775867
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 09:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+a6W/4SgDxqbN6o4SxJl9Ryf9FDJIe
	xJS9nEKVxVAqQ=; b=OxndzTLtYDdDFt3cow/4hyWsvvlkiWK7NILi3H+TB4fMPL
	o84Rfy6dxzYfbi4JuAdGOz1XEK/rSybg+qVYEjv4We27Ns0cx6+JzAdyYqIiUG3+
	r4mTWzLVIuyWDyPUMz5mSUNRKx4DyAOzDShrjF4bNzDG9TPtmrCUBzvQOh8IcMgT
	F9dpAQmpe6Wr+ZbVXXdEXbYbbLvm5Se8gKHcZZdh3+6f67Jl5QtwFDAaILAvrwaW
	r6nTkDRckBV36MVXOfFA+UJ7QIsjzW0pyJYgsHerPOtM9iDPcCLx0xHrJdQoS1ZI
	ppCTRTwRYooforJy71xR8ULVObX+MgnoDu83G8MA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhvr85-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 09:06:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8Tqb72660311;
	Tue, 13 Oct 2026 09:06:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7ypps5c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 09:06:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69D9602a29753620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 09:06:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A76F2004E;
	Tue, 13 Oct 2026 09:06:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1967620043;
	Tue, 13 Oct 2026 09:06:00 +0000 (GMT)
Received: from osiris (unknown [9.111.34.214])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 13 Oct 2026 09:06:00 +0000 (GMT)
Date: Tue, 13 Oct 2026 11:05:58 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] s390/sclp: Remove redundant memset after
 memblock_alloc_low
Message-ID: <20261013090558.9443A44-hca@linux.ibm.com>
References: <20261012150404.555918-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012150404.555918-1-ekffu200098@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfX5Cnb/aCRodtx
 KPc7iEUT+rhB4k+Pv9+lwk0jCFWPzyfa/wImurx1GXWCKfXFPuJtDDjtTJ2gz9SsvE3Ku2teAki
 gWO3OQmJwacrAYj0D7DKV4VMBVPCbI9Js4rfnFBXVjtubzbZYvdDVf8MPEXeX56enorv/fV9G8x
 oUwqL8R8ZQVGyJjGpodmjkYHCGjyfp4CjZ6/xjkuo1YK7BBTCg0qfrmV13ymflK6IckUFQ8TKzr
 iCd7GEys8tKIj2+qXF2IsF8ZkbyJe0bdwJtymtMatXWtL3xp/mhMVnTqH9BO8GSFM4d/18AN6Kv
 O7c5fhqFjXqS+O4Gof1V2zk+IP0vdaiX1Rydpn5GlB6WlyrS4yU0bAotNOchRRovr8OJSoQu50N
 6NH4kSA/Zm+j98/evpT+zUfWoEQOkjh6FeCIYqwqemDVk0m8lt7laMehxlAEt76B1RJENnDQkSV
 vpaExnizEpsyLfLWCGw==
X-Proofpoint-GUID: FuAaOgdS_vi7ALTLzl4LgTqcrORIJNS1
X-Proofpoint-ORIG-GUID: NFJs5XHMXJVAV5uqJMWWTic19AMoc_r5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfX3k++8u1/T3pf
 S4IDTXld+wUgfEqKZGMlmkft+BGhjOzqVP/w5ir6JnPJvQZNODdb2Iw+oR+ugme4gN7ik0BR50b
 /Gw19BdU6qkfcXAtkb+yrKC/es34rrk=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6acdf47d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8
 a=Zc1Q7ITUHv_1_6mWdr4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130034

On Tue, Oct 13, 2026 at 12:04:02AM +0900, Sang-Heon Jeon wrote:
> memblock_alloc_low() returns zeroed memory, so the memset after the
> allocation in sclp_early_get_core_info() is redundant.
> 
> So remove the memset.
> 
> No functional change.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  drivers/s390/char/sclp_early.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks!

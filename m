Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC3B3C76A6;
	Tue, 21 Jul 2026 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625259; cv=none; b=lVeW6KF6eF8LTJj3fd+RD8UJPyTzDrYvQe2ZQY265NgqEagbQ4F0u673gaArd3bgUW9OQwJ4WIAY06LJ4IW/RghXcvPA6qfIMe8DedVwDuZXOCoSzkwiJ0qXPRzc7Z2PcCS2dhvSOrr7BfEYzB/+QAhmKYfKpN49c6Dx+rKOsWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625259; c=relaxed/simple;
	bh=TxSPFC2cE8CQ1QfjVabox/SJA6owMLWuhHYXu3ToSss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icNWwge/BJwiPZdd2bJJQFBgbWr3E9g2Lk4Cnbp/q1ngo60/+p6Oq6XMGpK/t5Y6a8HKoi5K6s6CHhuyARg6s6ku6WS+fB16SVXTrrxagM5ijy8BAn+2EpPBLUK47Xmy34Hg1qG4TktDiO7YKY5F+dMaGp7WjK11olWpQorcRK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HEhi1xYE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HEhi1xYE"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNCl1Q3563393;
	Tue, 21 Jul 2026 09:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=QQuZF+nVTNyd/Jx/8iO50PYJYIERCZ
	fr4Aexu/d2NBI=; b=HEhi1xYEwq+LrvKaSBKJ7ai4KCvz0rWWA2hwfRDy5Ehn78
	faHIhJ23fXsUW0LF/sQzH1kMlCQKaWduLKROxC/WafJWXA/2U7GUSEkdNMQ2KWlZ
	fuP5X5Zla9TWQ6cDKwk2VA/EEjzUgL+rqeHv7QBdwU6SseLaTZXd7qgNIECf+DJ6
	en2ZbHnt4I6gmdo3nJSmXMRndWXo88ZCorDPaal1brjpClZ3q00paAksZR+fUsLa
	95zLVyo7uAr0zO0OeeyeEZvOQwnw2+0TpVlTLLK2bYuFo4QEzJ6ELcHx5CxiJxQB
	sZBlOTWsvYxeIYngQEfp0tgpYhLI4Ku6dasYuYJg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790us49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 09:14:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L94jkG011644;
	Tue, 21 Jul 2026 09:14:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy9asq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 09:14:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L9EDCx39125452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 09:14:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1147620040;
	Tue, 21 Jul 2026 09:14:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB6C42004B;
	Tue, 21 Jul 2026 09:14:12 +0000 (GMT)
Received: from osiris (unknown [9.111.83.28])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 21 Jul 2026 09:14:12 +0000 (GMT)
Date: Tue, 21 Jul 2026 11:14:11 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/maccess: use proper PTE accessors for copying old
 memory
Message-ID: <20260721091411.10829Aac-hca@linux.ibm.com>
References: <20260720144734.1003497-1-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720144734.1003497-1-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: L5zuabRWRIRIzANU-LhqTW10Vj3OFZ4k
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5f3869 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=BQ2Exa4mwO-u993TQAoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA5NiBTYWx0ZWRfX6FNEd6xOmw+x
 7kTXRXd6coQ2bXD10FhwCnOF+rkoyYPAOsowxKUOAgomcDPRqti1PAysXAH51amu/odPKoChLEK
 Mhq8BXmvUjQJIKXiYanb3GGWnky2eBQ=
X-Proofpoint-GUID: L5zuabRWRIRIzANU-LhqTW10Vj3OFZ4k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA5NiBTYWx0ZWRfX5iwjM3GDtuAk
 PaRr3K0YDWy0Cov+Y/h1pJ28CIW7+QvCzLvP+cNq31vmJEdAlDFE/iPmJ8Tp+qh1sedGFjO8VK+
 6TeK1iet+eSg70sE4cXllrCOnA8R6YW1RKsazk7GwO4JQqk20AdsimHytVqeak9gN3V0wtxc5TP
 ZeZM8k+TQwoaRxYJoHhtaEOkph0mE1eBB+P2RwNCLFag/F5S6dkYk4TfBNGPQqxS32uHrsf2P0B
 1sDnsqvq/6+o+fSvVPbnhk34Lbl+7XUYuUWKhJ0vsfvxnI2z3D1xZH5U2hWnmItEyTUy9ENQWcl
 vlsAgfOPbY4AI3CgYzJKxY/1COaUvTWu6POibDG6e+Fs3mMmV8JiI9MuwMd1DDM5vyFr9uyjUk2
 wE3AAUrVj5FrlJ9IU9UjfghHs+afE/y9UL3axZ0tfs86iRJdfSyYmd7Z6ejTY2My5O/slR1DckG
 j9e16PL7HV27oyts6bA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210096

On Mon, Jul 20, 2026 at 04:47:34PM +0200, Alexander Gordeev wrote:
> Follow the pattern established by commit c33c794828f2 ("mm:
> ptep_get() conversion") and use proper PTE accessors instead
> of a direct pointer dereference in memcpy_real_iter().
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/mm/maccess.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch subject needs to be fixed. Upper case "Use".
Besides that:

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

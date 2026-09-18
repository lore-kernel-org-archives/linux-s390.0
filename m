Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD394B7A31;
	Fri, 18 Sep 2026 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719478; cv=none; b=okro7t0+BWSH2FEZktVpcDkiQHloAKVuB7R6RdhaL4Ki9pU6mVZsuru/YJyU0p96j1fyNHErgtpyaYaLvQ7rwW4J9r7DQ1JxbVDMgn3iwFzLi3ULQOB+lhKDHWEt9YaeBSZSqNenWYhE9MQppRC5UlWFuOavm5IV30B0fDPsqoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719478; c=relaxed/simple;
	bh=4UMbm2EIhxXiFHfLG6a6pCV3oDz/DLBbEO5MhHosI/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSKGjvVTXz4KnsyBHjdtxGtG8x+HeTtYVOmHm86QTVaPHjIsGAwUyMCinpB1D6ukUMMzC2K0WrU3M9e2MkQoSaCBoUjduP9IvbhuTR4QHa6phbuZnbdrEzYJtHSzjOVQAyt56L3+HH/oKXMymnh71gHT5phNKdSGcKA/HG71AAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JaekGeiP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JaekGeiP"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I620tv313828;
	Fri, 18 Sep 2026 08:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=RwR6XHfl7OXFgQqWduePs1pXpmDFTyz5A7ZzC2qmzrs=; b=JaekGeiP/zg1
	demN/oS51UvPhWWue3L38/aq3f2t6p8JeTY6sIWXNjnLbdlnQHVpaTIvPhlSupge
	WhYcTaJBW4BjDp5yGeSes4l5kz/WK/U7csUoL23jiCuLlEOiQbCSPt7GvQlWtuo2
	3LkDQkXr/uducleF4ZR++5qwjgh0p9tKgqwE9Od8/bqMyWnV83CRKV7Vihe2PaJe
	PErVdGRRzQXsF/0WSUfs3xnC+Zqs3OCdH+SrrJ6HFKJFMQnnNtSP4GDas8zIuByy
	0Wuqmc7H0Jt5juR9pt9wqP9gMYCdQsZvMoIwM1e9dqUDiXkkuiPv2ijSQuhED10k
	OpstwOM98g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j6qf1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:17:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I6548G196223;
	Fri, 18 Sep 2026 08:17:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjpeh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:17:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I8HoEb56164696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 08:17:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47BBD20043;
	Fri, 18 Sep 2026 08:17:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31DD320040;
	Fri, 18 Sep 2026 08:17:50 +0000 (GMT)
Received: from p14sgen6-pf6akexs (unknown [9.224.70.27])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Sep 2026 08:17:50 +0000 (GMT)
Received: from bblock by p14sgen6-pf6akexs with local (Exim 4.99.5)
	(envelope-from <bblock@linux.ibm.com>)
	id 1x7Tn3-000000010vS-3sAb;
	Fri, 18 Sep 2026 10:17:49 +0200
Date: Fri, 18 Sep 2026 10:17:49 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] s390/pci: Fix leak of struct pci_dev reference in
 zpci_report_status()
Message-ID: <20260918081749.GA39182@p14sgen6-pf6akexs.fritz.box>
References: <20260916-fix_zpci_report_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com>
 <20260916-fix_zpci_report_status_pdev_leak-v3-1-61a2f980e71d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916-fix_zpci_report_status_pdev_leak-v3-1-61a2f980e71d@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEwOSBTYWx0ZWRfX6NY9x8D9+ADq
 /AnW+ABx0X6wCrd9mE2MxB25TdAE0lhqCMStmCHi1854ixCfU05ASfSEih2u7YFFnwsdkd8m1KS
 7zcmBZH9BAkftT/G1CUFi0L8WT81xb/lbrsMXA/dGyxyuUaKoOxP0Vw8Jk/r4OpJUWBEBRKFQ44
 4TidKEzOS3/s0eUDOC2qcJkpD8e8pqZ1NSOVkqEy/I2PsLhyTnM3TcnEFogKz5tqoN/NnpbnW/k
 VFlETzrTZDd5OD5VsPYqxEh19GECmbHTDvBFfMl4G8qzwsFqusiRhwIjwC0pZcwXaqup142dd9a
 fcxjfN6sXEdZhLMzrdN4z/7WQx3PPiOCngGS/yjRYMihvvQ41Oe1D3VKR0s7Y4E1i3BYTsPgWqi
 yu45hkIJ3F29wGGgQR2BtcNezgb9RuhpUJkAD+wbcQtGtI0bimPnyutTBA+Za/Xe8AYFLQqvFEz
 I7xn8JZ0HM9XnT2JkSg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEwOSBTYWx0ZWRfX0kTXrIkpwOgk
 dBtn1uJazeA3euFN61w497u2JumjxCe8FtFBQjkOxqkfV+AqT08A9rqkDeQ1VwAXJGJ54m30/rX
 4q8sMdeBbLreJIhfc4yVEZjNd5TsLEY=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aacf3b2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=PjM2ap6TQN7HG-kUjAwA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: LuG-er0s_Nt9UEBLG2w2Sg8Mhsyn9NSP
X-Proofpoint-GUID: LuG-er0s_Nt9UEBLG2w2Sg8Mhsyn9NSP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180109

On Wed, Sep 16, 2026 at 05:14:10PM +0200, Niklas Schnelle wrote:
> In zpci_report_status(), a reference to the pdev associated with the
> zdev being reported about is acquired using pci_get_slot(). This
> reference needs to be dropped with pci_dev_put(), but this call is
> missing, thus leaking the reference. On subsequent hot unplug, this will
> cause the struct pci_dev to not be released, leaking memory and
> preventing reattach.
> 
> At the same time, the only existing caller already holds a pdev
> reference. So instead of reacquiring and then dropping another reference,
> simply pass the existing pdev pointer to zpci_report_status(). This gets
> rid of the need for pci_get_slot() as well as the zdev->zbus check.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  arch/s390/pci/pci_event.c  |  2 +-
>  arch/s390/pci/pci_report.c | 11 +++++------
>  arch/s390/pci/pci_report.h |  4 +++-
>  3 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> index f317a1465dad..3b4941b65840 100644
> --- a/arch/s390/pci/pci_event.c
> +++ b/arch/s390/pci/pci_event.c
> @@ -298,7 +298,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev,
>  	pci_uevent_ers(pdev, PCI_ERS_RESULT_RECOVERED);
>  out_unlock:
>  	device_unlock(&pdev->dev);
> -	zpci_report_status(zdev, "recovery", status_str);
> +	zpci_report_status(zdev, pdev, "recovery", status_str);

Hmm. Wasn't one of the previous fixes to move the lock below the status
report?

Why is that missing here again?


Otherwise this looks fine.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294

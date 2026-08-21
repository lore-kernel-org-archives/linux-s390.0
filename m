Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6326C397942;
	Fri, 21 Aug 2026 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315558; cv=none; b=MpY+mH08jKQ/hPmzabF69hdAcZseFhYuGQXvlYxcn+Osn8yemMkZq2WNTSsuVrGx1Qgc/dJOLl4e8WzZuy3WsNiLl4wi5pUWG+8mQ96EuJgK+fPqjwte3mhmE6PYjoHGuHnAoVsbjMjmsU3uD9Ts2+CDY6XlBB52G66yKCurEmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315558; c=relaxed/simple;
	bh=AR30WyUVjx395FMs7M9sxLIbjyK7VCQKbkb3GDFFxmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJ3Ju1mTUJhWnc2nTpsNvkzRp75Qkum/dbYwmK2y+FgcFidn/KR47ngPqsB7+y0y9SiGjNPY18/nix+/+39JfWU6lP1KOYPMnL8qqRhv2JZ51N0LOQCfwYFKtmuDAAc3bTqqwKT8t58NEDNNCgEj4mxflAcmXPOKV2/cSkB0Lys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pR2Gr/56; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pR2Gr/56"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LC1ZAV3766824;
	Fri, 21 Aug 2026 12:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=z5bHq8JesBx1oHhzXxWcoeCHFW9iAoMojuf9zCuZM8c=; b=pR2Gr/56CELZ
	kKwd7cEOwuNbyYWhQRapqy7/Vpi7OX6tat2HY7i/hhySegX7opEeb6wD47pY9/xA
	So/rL6fQkvAB2MKStqPk+YGqDtWXBXzr5QvYn8fxhRUzyLUIZtDYPlVXTe5+oFtL
	EheYKBIeHLQ3jiKZVAe0y2ye1EbMmGarschmU8CWOjzV8XEaZCWRrX6lisA9t5Gk
	TkMzzXsEfMTniaAL4edLoF/LtIScIe10BB04/n6rsFqJWlFXgjz57IuqjoQVtc6M
	dNBIjOF/p1kn5FxruH0c8u198XPqDjXEDCzxFkIvTXyq6i6BR8t71zj7JYQw2tRs
	9H2NHIdADg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0hd9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 12:32:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LCQHOQ032537;
	Fri, 21 Aug 2026 12:32:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhmkqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 12:32:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LCWVLN16384302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 12:32:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40CD42004B;
	Fri, 21 Aug 2026 12:32:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DB0920043;
	Fri, 21 Aug 2026 12:32:31 +0000 (GMT)
Received: from p14sgen6-pf6akexs (unknown [9.224.70.27])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 21 Aug 2026 12:32:31 +0000 (GMT)
Received: from bblock by p14sgen6-pf6akexs with local (Exim 4.99.5)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wxOQA-00000000h1z-3eaN;
	Fri, 21 Aug 2026 14:32:30 +0200
Date: Fri, 21 Aug 2026 14:32:30 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] s390/pci: Fix leak of uninitialized kernel data in
 SCLP report
Message-ID: <20260821123230.GA18339@p14sgen6-pf6akexs.ehn-de.ibm.com>
References: <20260806-fix_pci_sclp_length_check-v2-1-9ee9428e659f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260806-fix_pci_sclp_length_check-v2-1-9ee9428e659f@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ko7PSslX0vMaBfDZdGocJ8vWNUxRMwxV
X-Proofpoint-GUID: Ko7PSslX0vMaBfDZdGocJ8vWNUxRMwxV
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a884564 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=LAaq5wv8XjvTlIZLZ18A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfX+/+pIth5veW+
 AV/jwbUeiswdxaB2YUFeJdaWl64QLlat58Efo92416fZKZVeBSROF2zxghmTyyGZjzH9rdniqHj
 yt5U1Nz7tMG/iOEa1wgya8ReLmCkIbY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfX9Oykqk8QVfDy
 Agm6eUTqmRQwKnyYGkrfeZaZZ3XX2V8Xg0luV353ucMgHT1B6Nvc7gHve6UmrqzJ1kWkQeDCtvx
 PGlMKdyEYilzBtzKhPzt89ow6rUJxaNdIh6aAVKppIX2xmeiZvbPdA2egnC6EA7LYhfAVfzV1FR
 V3F/+6gQounZLhLwdkdUsGTYdc4Jw9mnGlbfwAhlIdF5YbybGqUu1qop4XieyUANO7E+tO8Dqka
 jOHJ+EpatXtlO4em2+AGWhtZuyzJ8bpP6urc+lSb1LdC8A35U/V1hUH8URq3AdnxFVIrrHX7u6R
 6B66PXXsy169FU2MBEOB0wOuXHf7gd5ABy2HrDy95D8s7Hh80w994u3ApNfE2Y6MzUXTef0ZWbc
 9AyzyYuxsKulC+LGb6aiIIldh/zLnWgWgcMubLZUgkZcrnMLSMCn8ko2+nVQDx2CxCBaGLC8cLI
 sBexx94m8ADzL2txzFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210096

On Thu, Aug 06, 2026 at 11:43:39AM +0200, Niklas Schnelle wrote:
> While report_error_write() checks that the provided buffer is at least
> as large as the header struct, but not that it is large enough to
> contain the report with the length claimed by report->length. If
> user-space provides a short buffer, meaning a larger report->length than
> the actually written payload, up to around 4K of kernel data from past
> the kmalloc(len + 1) sized buffer allocated in kernfs_fop_write_iter()
> will leak into the SCLP report.
> 
> However, as the entity processing the SCLP is privileged and able to
> access at least the page including the report, this does not leak data
> that entity could not access but it is still an out of bounds read and
> a malformed error report that should be rejected.
> 
> Fixes: 368704a65be8 ("s390/pci: add report_error attribute")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Changes in v2:
> - Changed subsystem prefix to s390/pci
> - Added Fixes tag and Cc stable
> - Improved commit message
> - Link to v1: https://lore.kernel.org/r/20260805-fix_pci_sclp_length_check-v1-1-d125cb415bc3@linux.ibm.com
> ---
>  arch/s390/pci/pci_sysfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
> index d98d97df792a..bbb76113a4d0 100644
> --- a/arch/s390/pci/pci_sysfs.c
> +++ b/arch/s390/pci/pci_sysfs.c
> @@ -153,6 +153,9 @@ static ssize_t report_error_write(struct file *filp, struct kobject *kobj,
>  	if (off || (count < sizeof(*report)))
>  		return -EINVAL;
>  
> +	if (count < (report->length + sizeof(*report)))
> +		return -EINVAL;
> +
>  	ret = sclp_pci_report(report, zdev->fh, zdev->fid);
>  
>  	return ret ? ret : count;

Looks good to me.


Reviewed-by: Benjamin Block <bblock@linux.ibm.com>

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FC113B5B3;
	Thu, 13 Aug 2026 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786621689; cv=none; b=dkVWRUa+FnU4cViGehLiGJG6CHsrrnq2UqfK+cy572C8qEKh9o+zCfsld9s1FG4moGxfRHzwLSkFyzjoGUVkS9/Sh0TqII56RotzPj6rqNw4fzY7slflQp3whYSW5a1Sogt1+Pl7COxqato+sMTuKBfpMNlNTQiaBJWmuZgTovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786621689; c=relaxed/simple;
	bh=oLFX+xgNOs1pcggNEGzNlONgxQpL2Aj7MRDuipSKMCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6vRnTW0f/ha5IDCkDg7zPBiI+0sMxvK9lZQsKdikRw+tagmD+9eB6iRaP0NaqmnkBthopwIzmcfoe3k2KGKF9VTlLIyRm0mWqAr6o6VIsw9JhKxbyGNmMPe10lziOap3QTV207Y0P9UEyhUoPTBCzXVuSECWJttyCHoemAh0DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VKiLL36O; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VKiLL36O"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D98iq0041857;
	Thu, 13 Aug 2026 11:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=L8QoVVZttuU76tzv2FsMBmsOZIitj0
	tCtnClG9jDbjI=; b=VKiLL36OUgFBD/dsjlXTbYtFuIZepXhYnPT/TTm9DBUc9j
	E+fWtucvs6apaiFyRuKHILBzNX68Ja5dUvIq9M7ZpZQkwPIy5xP4uNIC6rc49UrU
	FLv5ukEPwbHfSo2DJmAWMle/aaNcatAeX8GhpPxU/I6MrJreSet8zzezHVMPsO3k
	3U3W+aBVmmJDbfBm1m+pb2mYeMe54TKrmBSDhDOZPnq6cSxiWoOoVLrw3CCWTKqq
	uCbYodOU0WDnMAK7kNSLg3viO3uSltkD0rNMNeCx96bOSzGI/tesk6WvBcCaaMdg
	5W6FRZ3rMkBjB1Vx3RK92UpEWZJ5SNHwLwBjWqqg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk07nkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 11:48:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DBfJGf032419;
	Thu, 13 Aug 2026 11:48:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesqb099-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 11:48:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DBm2tu39780840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 11:48:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 096AF2004B;
	Thu, 13 Aug 2026 11:48:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0B4020043;
	Thu, 13 Aug 2026 11:48:01 +0000 (GMT)
Received: from localhost (unknown [9.111.42.87])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 13 Aug 2026 11:48:01 +0000 (GMT)
Date: Thu, 13 Aug 2026 13:48:00 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.vom>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/2] s390/ipl: Fix NULL deref in kdump without re-IPL
 parm block
Message-ID: <ttjpi40@ub.hpns>
References: <c00-02.ttjpfvt@ub.hpns>
 <p01-02.g87de83845c5f.ttjpfvt@ub.hpns>
 <20260813111928.184701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260813111928.184701F000E9@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA4MSBTYWx0ZWRfX6ABwxvktg9Gb
 G+qrya0vY6gjpJk8BG8R7MAMdA2wOR4v3oCM5E2iliNAphKzIpO51d7tES8SBeYM3lAjOfdeVxX
 BbqY6UBPJd0nfUYKWZfjvszbBU2NRx7uiwXz6R0rE58CS4JYxyTLtu+vns9/vJe018vYwpn5ru/
 AwCCs1xQSL13BZ9MRAWffuw3lNDr9H4lTSPIvwuTiNQ7AQ7X1G8B1eQfFFxGzf9nKEyEQmt3nb/
 HaJmEEDMS5c+ePfdwtbBhMRufKtMbggSG2oaE5FwmdvFgEZYOFL/5tpHV8esUXlJFi2CKQ9fOBT
 9Brz19/XSSYljL0QneT1fgjDOwG83Kv/JpFEPdJdVVIcr+s6bxLJi+NZRZbUu3LrI9Asmxc1c9s
 sKAWRlAqYrJpkcy9fnXPezE83BMR/rCy8O6hdKNDmjN7IXxGVfqwzWeQv+TbElVsXzv7mjwPvBR
 0T5ogJpcgMEYeYRK+Mw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA4MSBTYWx0ZWRfXxxG0xQGPsxPk
 XcCF884tG0fyXqiqQhvXE9lFDsoe08iyxoC/Gv/JVehOJRYQIAenArmN+2TEQ6LnixdZwOdh/ya
 zzS1PnpDylbyyIp7KTBxM8lotqBf6ok=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7daef6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=3hd6PT9mWKKFgb9ofbUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0dTOD1nzGi9gWcUAFrx7Dfxqws2MtoTA
X-Proofpoint-ORIG-GUID: 0dTOD1nzGi9gWcUAFrx7Dfxqws2MtoTA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130081

On Thu, Aug 13, 2026 at 11:19:27AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] NULL pointer dereference in `dump_reipl_run()` when the system is booted without an IPL parameter block.
> - [High] Unbounded `memcpy()` in `reipl_type_init()` causes a heap buffer overflow in the dump kernel.
> --

...

> [Severity: High]
> This is a pre-existing issue, but looking at dump_reipl_run(), if the system
> boots without an IPL parameter block and sets reipl_block_actual to NULL,
> won't this unconditionally dereference it?

That's fixed in patch 2 of the series

> [Severity: High]
> This isn't a bug introduced by this patch, but looking at reipl_type_init(),
> could an untrusted size from the crashed kernel memory overflow the
> PAGE_SIZE buffers here?
> 
> arch/s390/kernel/ipl.c:reipl_type_init() {
>     ...
> 	reipl_block = os_info_old_entry(OS_INFO_REIPL_BLOCK, &size);
> 	if (!reipl_block)
> 		goto out;
> 	/*
> 	 * If we have an OS info reipl block, this will be used
> 	 */
> 	if (reipl_block->pb0_hdr.pbt == IPL_PBT_FCP) {
> 		memcpy(reipl_block_fcp, reipl_block, size);
> 		reipl_type = IPL_TYPE_FCP;
> 	} else if (reipl_block->pb0_hdr.pbt == IPL_PBT_NVME) {
>     ...
> }
> 
> If a malicious primary kernel crafts an os_info payload with a valid
> checksum but a size greater than PAGE_SIZE, wouldn't this cause a heap
> buffer overflow in the dump kernel, preventing the crash dump from being
> collected?

The primary kernel is not an untrusted security boundary for kdump. It
loads the dump kernel and can modify both the dump kernel image and the
data. A malicious primary kernel can therefore already prevent dump
collection or execute arbitrary code in the dump kernel. So, this
finding is outside the kernel threat model.

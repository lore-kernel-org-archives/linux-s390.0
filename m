Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E78353A7B;
	Fri, 18 Sep 2026 08:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719995; cv=none; b=P++38LK+bVBJAnJANhOxNVAufTYFlZUWMfkDDfOq1/h7gh0/wOjfOGOsVQ8Ch/7fW7x47L4x6NbPMzaTAT48FKAhMJpcOYGoMW0yqP11XpAFLPJpe2ehIhKhrEYEYr2knvLDEAzZsXslfkj2ltK94tS2jjsWi8f4t8mQLOEw6W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719995; c=relaxed/simple;
	bh=KyzFPsW4s8Nxr0iHiBHcMPoDpa3LIfipKu/R5qVYG4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvlE2gQ6KYH30HypzmyZz+MlkKaP7Vj+UVM8pRYpgVeNc8zWQyGSBybO3KT2M52qFl1t8QiDDrbowW+xoL5r7ZE66FNGLc3ZpxLJjSpZNuQVzd4uqP0+biuL2C87by1BgsS5pWV3i/FPSrmtpubQTLSPAgcPx6zgHiN1MaBfhgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K+LDdDUB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K+LDdDUB"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61gUV3490096;
	Fri, 18 Sep 2026 08:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=3Tewu9m/IPhix9Pb7yLvcw5G0LB2BRbsQv9Xw6KhLJI=; b=K+LDdDUBRgpA
	vr8LqM74pq60FMiKwsGQlCotH2V9eSi/m36tSjQ1pk5obU95JZ+CAqlaiyCsZxtE
	VQTiB1XbKWfXwIpyDWluLsNCl4P7+swF41g/Lq/2FsyH6p2VYB+Jjk3fi9Qwbqbx
	yMiSEc3W1xhB+xRegjYJ3HDrgwaqpI3nbPWhNlJs7f3QVn+0feMCQaEigQaLuab1
	plWRd6tBwnP3SicAjhsj5VRk29CypwA/FvS16D59PAh07iI/kSUE7TPSqE+Ljbti
	peTuEfYCUSIOjaRC7g54DAyVjy1hY7szFyOde38WNRWxVBJtFXEgMOUi27Qa8Vdz
	NyebC/i5PQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5eej4v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:26:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I652CY1154828;
	Fri, 18 Sep 2026 08:26:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr7gep28q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:26:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I8QRcs47120642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 08:26:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF03B20043;
	Fri, 18 Sep 2026 08:26:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA34E20040;
	Fri, 18 Sep 2026 08:26:27 +0000 (GMT)
Received: from p14sgen6-pf6akexs (unknown [9.224.70.27])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Sep 2026 08:26:27 +0000 (GMT)
Received: from bblock by p14sgen6-pf6akexs with local (Exim 4.99.5)
	(envelope-from <bblock@linux.ibm.com>)
	id 1x7TvP-000000014Ry-2TFd;
	Fri, 18 Sep 2026 10:26:27 +0200
Date: Fri, 18 Sep 2026 10:26:27 +0200
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
Subject: Re: [PATCH v3 2/4] s390/pci: Fix missing device lock in
 zpci_report_status()
Message-ID: <20260918082627.GB241998@p14sgen6-pf6akexs>
References: <20260916-fix_zpci_report_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com>
 <20260916-fix_zpci_report_status_pdev_leak-v3-2-61a2f980e71d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916-fix_zpci_report_status_pdev_leak-v3-2-61a2f980e71d@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEwOSBTYWx0ZWRfX+tbdQQyeB1m/
 cVBWOGpzW8Q6IpIv3svkEFHaPD9XqESJPk5BLczbR7dcgUeroE5U65jIZYYJLgL31aUUbmP0MGL
 dO/g27eDWeF2fg5wtt6SzP5UxigEfrNHDFUzl2ylCp7zTXebltjGqlcmpFjoN6Z0OhZvo2BXXwK
 WqY9MgP9KxT22u5BcW9BNLtBCDIylBWHxI7683XBPU7226EFWN7CiZpNe+qfFg/IzWCTfzMPOkL
 AaiiVQxLWStoRr8fVL/2D47G70YqwaLas3hiVmY55z9GylH5zSP8T4noqp8o+fTtr4X9WagEN2b
 DCAb8bMueQEyH0lzg7UFfhsxkzAjAjYFrcxQM7J3lfmOHypViYSaCAkc7bcOlElcemutiqFruxc
 zKlg7jsy9mZvZlmIMZf5cO6sEkwWcuXCh0QzazTCZiqloKU44y3Y2uRk90f6RT70g+zxAEZVP88
 479Z5D8oZg0DDfv1r3g==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aacf5b8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=w9lCKMLUrNWc0FJAO9AA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: iPpW5Am2c54iDxtN23IKjqKpImMmeQWA
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEwOSBTYWx0ZWRfXzbpYePoiP5fO
 2hdCHBQv0aHy06RvQpA6AiPH1BmDranadlh7I61Q236NZTnkyexpzOD+tJi/CY2Tu65etRhWHWT
 Pvky1DmGbLEnm+NouTpCRgzPbej8Z8c=
X-Proofpoint-GUID: iPpW5Am2c54iDxtN23IKjqKpImMmeQWA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180109

On Wed, Sep 16, 2026 at 05:14:11PM +0200, Niklas Schnelle wrote:
> When pdev is non-NULL, zpci_report_status() accesses the device's driver.
> To get a consistent state matching the recovery, the device lock needs to
> be held. Do so by expanding the existing device lock critical section.
> 
> The lock only needs to be held when the pdev is non-NULL, so extract
> the pdev-specific reporting into a helper function which also adds a
> lockdep assertion to detect calls without the device lock held.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  arch/s390/pci/pci_event.c  |  2 +-
>  arch/s390/pci/pci_report.c | 21 +++++++++++++++------
>  2 files changed, 16 insertions(+), 7 deletions(-)
> 

Looks good to me!


Reviewed-by: Benjamin Block <bblock@linux.ibm.com>

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294

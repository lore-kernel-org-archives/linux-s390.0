Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089223939A6;
	Sun, 23 Aug 2026 21:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787518859; cv=none; b=hIjVQjv7dQgNSOn24tgWN3U20c0uWTKe9uLDIzVI93Em8W8M3IkFta6jVCdVQMXS83CsoDQtVrJZNIFT58GaQeLiGGq7YJO7NWwErI+SMVWmNJq38L08lnjga6wMrjp5ixeeM04XazN54CoJoK6WGsdp1dGvj/KCge2GWTvoh04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787518859; c=relaxed/simple;
	bh=cIXHjC5vbj8ILNhWtxG1KHEsrexBGg/omZik3luOgBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgxUTf1AKoji3R2TzY2Rm2CYrIowLr7S1OUE8r5LWbppo3yMSDKii3bNhvgFomQdglnHOURiEoJf3k3P8/mdOcyXsV7/VFMjw9rNpJBauh1jLyeXJOWd/w+YAPZHfvKHR1JSfIVO8sXlTlNmYBphA31jdd9WxjvIpgzu9t1jqtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HTJBX/Go; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HTJBX/Go"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67NGWb5T3600321;
	Sun, 23 Aug 2026 21:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ZnqmZO658fE9NufXJ/RIcIA3lxKvfJ
	5z9yYUVFgrw5o=; b=HTJBX/GoDtY7W2Fjb8G3yiqAvNkD4XKYpRybmb2YCfHh1Z
	M8uUKZabBv6+8diBi/VRrTKaP8g3BQhiCOTYaZeRj9ucAMUwSC1S6bvF/WZPx8qY
	bRb6enEo/jWsJNpgRKEMudcb/DA/lKjhE8GKIbxrsCltUnFX6NeKaEyeTOfLz8S9
	SWTWeDD9eaC0HWBC9xpmibQ2obMZ0BriIA3uG/xlKRUG2QGzcW3/Z5Kbpb4eHeQe
	a7HAnw8p9oBBxi8rXGBDUIECqRHPGasPRAfhMRq+JZWYq7O6XddWujUyNyJy8XWu
	0Fp2fMexCy+u9AfinkBIyDSHiJXuQFpvrST1yYWQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4dqhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Aug 2026 21:00:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67NKuECt004611;
	Sun, 23 Aug 2026 21:00:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3pts6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Aug 2026 21:00:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67NL0ZpH47055168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Aug 2026 21:00:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 121D320043;
	Sun, 23 Aug 2026 21:00:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 637E320040;
	Sun, 23 Aug 2026 21:00:34 +0000 (GMT)
Received: from localhost (unknown [9.111.46.147])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 23 Aug 2026 21:00:34 +0000 (GMT)
Date: Sun, 23 Aug 2026 23:00:33 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Omar Elghoul <oelghoul@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/s390: Fix NULL dereference in iova_to_phys() with
 ZPCI_TABLE_TYPE_RFX
Message-ID: <ttk8qcx@ub.hpns>
References: <20260818-iommu_fix_iova_to_phys-v1-1-1cd76d2a55b8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260818-iommu_fix_iova_to_phys-v1-1-1cd76d2a55b8@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AKZt5vKNxogsEmR7SOF3PbE71PlbIQZ6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDE4OCBTYWx0ZWRfX1KJZKUiOrHCS
 dMSAH/PjU8euaWR5E9xpTJnjy5ymgl/ayaHAC9g/GRQu/md0i2fAGy118geOcb29NtyxkWM/hPR
 GIG/adpz3qqUowq2QSU7yzVFfsQa3ng=
X-Proofpoint-GUID: AKZt5vKNxogsEmR7SOF3PbE71PlbIQZ6
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8b5f77 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=jGXHogcpe6aWH39FzsgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDE4OCBTYWx0ZWRfX41DfUwSpKya3
 jOgqNDrcM5sakOTuAtGL3X0P7h5VjC0r0ZAiPJ3iDzYpJaH6L+PSFHViZ8jzx+U7dXMHDYKqKBe
 rASly2/rn6pXdyLPIn5waVNHtxev7E0LQZiE3m2Jhut+SWnKKdsJjY/8UO4mlmonrMMKi7H2MHU
 8c3j6fwMnLC+zqFjPYDoqCtzHFW6P2r128O+pTGidCf8938+gG6lUbcMAGNjrnHc+V/EF4UIkct
 olBelkTMv9Fw5t2rIG1SxuljvosA05IpgmFNoXD8j0dXdZ238745H+i8SyYa0jaVkUAaNG/k37U
 y3k6429NmRMUorh6BMvubFRR2GfMXiRk7JXin4ThXfJucb0mQ+OCgMtvDdoGAAsypDmH2Jscj1F
 9cqmnITwEqCBa5yKifwT8VjDalW2l+goK0qH6UCL9FA9fh1ObSFjMZRai57uco2x5r7bNRqJg8F
 JCONou7O1S0Ac/mJVsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608230188

On Tue, Aug 18, 2026 at 09:13:17PM +0200, Niklas Schnelle wrote:
> When using a 5-level translation table via ZPCI_TABLE_TYPE_RFX
> get_rso_from_iova() returns NULL when the region-first entry is invalid.
> Yet in get_rto_from_iova() the region-second origin rso is not checked
> to be non-NULL before accessing rso[rsx] leading to a NULL pointer
> dereference instead of a NULL return when iova_to_phys() is called on
> a unmapped IOVA. Fix this by adding the missing NULL check.
> 
> Cc: stable@vger.kernel.org
> Fixes: 81244074b518 ("iommu/s390: allow larger region tables")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/iommu/s390-iommu.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thank you!

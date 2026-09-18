Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED30430CEC;
	Fri, 18 Sep 2026 08:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720379; cv=none; b=Q5d6ex7qLAzpRInBFuV9w6vxa+d18s6AT9Pdnp4eDQ+mcUp2oz41VlL4t2wvEHVOxNVUGE7xijRR6zCL6HBAYiBRFLq6mqSv14aUmAoS2zRx29qTLg7gyrDhMRN1SoB8lLDp0KbZoCuPbjGAzYwTwljTE5M6Ft5vApGGPwS8aJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720379; c=relaxed/simple;
	bh=WUdoM1JhINJUD8bRLI0lYaFGva9cz6iJDvMGT06peoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMR8YM3XLfMY1sadyuxH94XLh+vjbsBGG411pa1o67rmvhoJuA9KxvEU39R6ND9nxCP9mXDnBGbVnIB0lX4YFU2khhZrDC/qPmtOG+mk4jvc1qvw2ErLgyXpfS7e/CTdaBs1r5BcGve9yZU0wasa3TTygnHC4PrDB/d3TyPUTbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IKCTMd2S; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IKCTMd2S"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61Xvj457232;
	Fri, 18 Sep 2026 08:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=OBqocodU7SSTa0DEX9ob6DspaG78OR9/XusMNcOZa1s=; b=IKCTMd2SHOlQ
	KvZ66lFV8Uju/RW1tbHA78783zQdLOReq5S64k89es+lkWFYmIEqqAU6+86kcDPH
	WI6ioG4oYBjmSosti+n473m/RI6JQgZ3pF+UVK/2Vkod0i+SVcRyd4IPHSvnNUt0
	s/DMEaJWZrjqdUVAK0v2j6yQwN28kePHZyGHoDdjnXcdhKuNMTTgzfjAgirDy6Yn
	WUIV3xt6CIlhRJQaKchdN8u5dYrvlulrVikWGZgxV/9mMVj2WkNugWbqvlY2L3R1
	HhADF14LinmnKqp0CCJaYFFcuMqcXZXJFIJwrwwO15mizvIHvnWKoiX9jXrHkFqd
	yQR+byD4mw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx847254-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:32:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I654in251890;
	Fri, 18 Sep 2026 08:32:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3ywj5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:32:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I8WmOx46137728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 08:32:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 759A320040;
	Fri, 18 Sep 2026 08:32:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 632342004D;
	Fri, 18 Sep 2026 08:32:48 +0000 (GMT)
Received: from p14sgen6-pf6akexs (unknown [9.224.70.27])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Sep 2026 08:32:48 +0000 (GMT)
Received: from bblock by p14sgen6-pf6akexs with local (Exim 4.99.5)
	(envelope-from <bblock@linux.ibm.com>)
	id 1x7U1Y-000000016jl-0WYL;
	Fri, 18 Sep 2026 10:32:48 +0200
Date: Fri, 18 Sep 2026 10:32:48 +0200
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
Subject: Re: [PATCH v3 3/4] s390/pci: Report SCLP status on error events when
 no pdev is associated
Message-ID: <20260918083248.GC241998@p14sgen6-pf6akexs>
References: <20260916-fix_zpci_report_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com>
 <20260916-fix_zpci_report_status_pdev_leak-v3-3-61a2f980e71d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916-fix_zpci_report_status_pdev_leak-v3-3-61a2f980e71d@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfX7Kb3j/+s1XsB
 OcpklXXefJvMG1MDnjLFpMoASbuL1wrc6zwFiqFza/fViWd0E/oyewT5QbqrJB0cqqGgiFrAZ1U
 3lN7iNB6F4ASI8PLFtTJJ6tbMgRz7fNzNWfp9TQQhhlqKkS3XIy5E3h/35RrW9PRDua1zXCnhUu
 zrCohIxHvMwZOuDv4CUcKow5WgnHXAxXRiOwKZmT1ly7pXnmCHsDQtuUlMcnR0qX8I4Wqa4rNuP
 isf8psg6wSoTem70ADPkTu2SnW69U73/V+2H2PW1UurpiElDozOaDSH/uh4lmzVnCfWTwhfGyEt
 dDtDIHhcSRlGk6qrhqPhfsOb5FuIyJwdpPa1tTDh7meYbmgI2lMmujYWxzOMLcqQOTGB6l1KSdz
 CgiU6GcYOt+VSCyNgbnnuCXDZyJGwaqVzix98t2NmhtwaUVnZReWkjk9F9OJLce3Irvun8M1oAO
 IY0tVrDZ7oFfgb2w+dg==
X-Proofpoint-ORIG-GUID: u0Q0n8-WhHxsefDmNNz1dpbWLHkIz8tX
X-Proofpoint-GUID: u0Q0n8-WhHxsefDmNNz1dpbWLHkIz8tX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfX7eynpFZxaIt2
 wOvYeCUBFZG20bHqw90u3vNpORTlJmvlb0X5xlEjUYDQaVYRLvkdOU2BLgyncqhGAcLiDAShwDN
 50acpDMl3cu9XhFUgkzG1li0gGR67uI=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aacf735 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=QYVxXew5hEVD-d0z6osA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180117

On Wed, Sep 16, 2026 at 05:14:12PM +0200, Niklas Schnelle wrote:
> With commit 4ec6054e7321 ("s390/pci: Report PCI error recovery results
> via SCLP") SCLP reports are generated when recovery is performed in
> response to an error event. If such an error event arrives but no pdev
> is currently associated with the zdev, e.g. because it was removed or
> not yet probed, no report is generated. Fix this by generating a report
> specific to an error event for a zdev without an associated pdev.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  arch/s390/pci/pci_event.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Looks good to me.


Reviewed-by: Benjamin Block <bblock@linux.ibm.com>

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4EE3B2FE4;
	Thu, 23 Jul 2026 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798194; cv=none; b=A+AAtqqGvGGsPiuonSUqPth7LXU41l9i/QcwteMFVIa30vW/+xQEO0ONIjuywcl9CeGFj9ggbFxY7w68034cXRZ/kQraId6yxQZHiiq4b0rPN+CyIj4Tf9KAcgNcVDuxDg1Mw+7x5uDLsrLkrlndm0mhsat6w2rAYp+CsWr4FQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798194; c=relaxed/simple;
	bh=X9TVd0S3jL2LA/wZdRpJvZEjpiKOvf3POXjdy+MIWiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktV2U6NwYbpfq33pOEaLaooTk8DROotgvYLWd8pdbuui9Dk1bdEqxaTfZajFmYpqaVxz32a9W5ACQYgHsNLcoTFMNG6/MAjaCsUSbKefVOG+EKuUUW/cP5MXhEcSLBGRSHm66rIj7OH9yMObecCKGcfoSllzPuHA4gZNqghDt2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tu/olsIo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tu/olsIo"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9BeYD2580160;
	Thu, 23 Jul 2026 09:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=whWIGQhup4ZG1MT5GS/0BoL6KlT64b
	IPJ8d5MKZP5LU=; b=tu/olsIoEiNTHADiFzQjtH3fF89sSa1XpY1kmuIHxy7FQ3
	FxidkF8jb8bwlwAfYG2na2wZz9cU0zmXGPmHb2WvLVYQrrRvjtuYrhjcE9jOXUT4
	fm9rs3ENy3KuBH6fbVQR3EmfoctV2MFolOTBhW6cyI2yHPBWvIStKeG96+5LEmNo
	+/Rke4FClDfoqooBpbPGv68S526bWXle8AQLOpripiwaO1C6n2UmLeT9kh24Nu1v
	9MlokDQZNjrC0tQc4+crXf53PXt9JBejz/2BQDKIZRsGUvKWab7hCYCxkJCRVYRS
	Su5qsqAlQw85xpJut9vuBNdG6AvvIh8lA1ID8dcA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abpsan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 09:16:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66N94wgD030206;
	Thu, 23 Jul 2026 09:16:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyk5xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 09:16:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N9GOJ348890280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 09:16:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 196CD20085;
	Thu, 23 Jul 2026 09:16:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78B4420086;
	Thu, 23 Jul 2026 09:16:23 +0000 (GMT)
Received: from localhost (unknown [9.87.154.205])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Jul 2026 09:16:03 +0000 (GMT)
Date: Thu, 23 Jul 2026 11:16:02 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Tobias Schumacher <ts@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Simona Vetter <simona.vetter@ffwll.ch>,
        Halil Pasic <pasic@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/pci: Fix s390_pci_mmio_write syscall error return
 without MIO
Message-ID: <ttimf2q@ub.hpns>
References: <20260722-b4-syscall_mmio_ret_fix_upstream-v1-1-6de516b33001@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260722-b4-syscall_mmio_ret_fix_upstream-v1-1-6de516b33001@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA5MSBTYWx0ZWRfX6spdQQqPxCTb
 udHLiiMeQksQH+XtG9W+IV8RzL+A5wpz5yMKcGsRjzJhTFgZJDNoN7ehG56Ohu9h3tQu8FYRwdN
 lyaszFQbDF7VAmQ71VeomTec783tDBbax6slkW7Wbm5KTqBqBOW984svY37ez4KesCCXn2M4Bu5
 cBqy0kI44qVy2cw3GXuvaKoKMAIVOUM+LxWuWxXppRRXipQKQYrl0gAmEBL5WDznBgN3E6j5vXp
 TqarURzQWFpCHrh1TWu+VsVYgQsa+b/xQKM6LjynjAl9IHmaiYvkUyi9QwLT2cFZH39GV2E0zbz
 uCAGm2Dr83ZftwkO/NPE/KAEAbqUh6L2rmyv4kl9px+4OEKjcPZj/3kKWYChk46V56tqe2Tc8Ei
 nk850y89hEh7xdoxfATSt160hawmCxLr1XYHDFb8Pf1Md8GqTJgsrbA3FkOETEJfxjFy2Kp1/p2
 Xc9drFU8f1U5JVFov2Q==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a61dbec cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Wxv1BgNQZDOi8WUB-TMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: e0JMUpIPgECwMNEelUludIF8lneE_shs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA5MSBTYWx0ZWRfXwIFmUyNhOl5f
 6WgC5dXNFp4RvOu5RUFuB+a7zFVGTUB0McGNVMZ0LCYWreZfk/G8TtjZTMhEDi+FLVIxs5VZOJH
 cPBdEsk8hIZeODxK6Gfjf1yndC8zrmM=
X-Proofpoint-GUID: e0JMUpIPgECwMNEelUludIF8lneE_shs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230091

On Wed, Jul 22, 2026 at 03:08:34PM +0200, Niklas Schnelle wrote:
> On a machine without PCI memory-I/O (MIO) support or when running with
> pci=nomio the s390 specific PCI MMIO write syscall checks if the MMIO
> cookie is above ZPCI_IOMAP_ADDR_BASE as a sanity check before even
> trying to perform the MMIO. If this check fails the return value was
> left unchanged and thus 0 from prior operations falsely indicating
> success. This could potentially confuse user-space into falsely
> believing the MMIO, on a mapping not valid for MMIO was successful.
> 
> Fix this by setting the return value to -EFAULT prior to the check
> following the same pattern as elsewhere in the same function.
> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> Fixes: a67a88b0b8de ("s390/pci: remove races against pte updates")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  arch/s390/pci/pci_mmio.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thank you!

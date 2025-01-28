Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F2C2AD2D;
	Tue, 28 Jan 2025 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738050820; cv=none; b=qxiilGGaIvNFWVCTUUiP47bu+Cjhr6ewRJPrI2Xdxf7KZOSKWRQU+NQE+CxnVfNP9GWWCqrqTuk/iveNO0ZdrFPCgxnNeYEnGeP4lDqCYqs6tEW44+kkg5eH46qb5hgdgyAnZ+rKPNi0lXahg+u3SKGhKvj79o4xPxr18qOjXAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738050820; c=relaxed/simple;
	bh=HSwvWxV/jE9mer39FiS9PQWZjXbsv7Po6yzewj8JG3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPJRCJgQXDryfpzPvbndW63/IOr/S5wjPSGpGn9RyNZCvpnV7sf7twh/W3G6EE+PV+clghwtE0LKLbTyHWZg/n4HB7v2auTixYex0JUk89e8cQ822WtfMk0MSxAhTd6z4JUGCBDkrn6Xdu7oRkBpXX88k3fzT4SBtt9ghcsf+hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iPVM7C8t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iPVM7C8t"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S17rxn009102;
	Tue, 28 Jan 2025 07:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3HKB1RfN1+emG4GOy6+Zxh9G2OH8Tb
	OVQN619J8ZjWA=; b=iPVM7C8tuF2P3l7jZQKeKo7aM1iMWymc5MDq8hqQYhTOwQ
	xo/r9t7qDRz3KvC1ddppMLTn0NjKpaPlF+hCyrqfQpz717D+Fjv1Nyz+4NLEvk9M
	ybBM6SU59SJ7X0stPIUtJbGP9fcLzHxpt54TP4b9EzqC3atslF7Td/TTGCNNYonH
	AH8JrHmoC0m/o5dvTtdswrKvRyb8z9FgNHIr1aPQj0d+xG7Vv+kBk8PIrMoiG2Pp
	UDE0f54Am2h0PCDPd8vbvKzF5VVvlIUsgKc8mMpPU/ONDCnm3/IzxMo/Qo9F132h
	konlvImgR9iovIVmkqME96nqib6QNLqaJwK0P4FQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ena9sfpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 07:53:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50S483sI003900;
	Tue, 28 Jan 2025 07:53:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44da9sadvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 07:53:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50S7rP1735127854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 07:53:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEE2C20093;
	Tue, 28 Jan 2025 07:53:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B191820095;
	Tue, 28 Jan 2025 07:53:25 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Jan 2025 07:53:25 +0000 (GMT)
Date: Tue, 28 Jan 2025 08:53:19 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] s390: Add '-std=gnu11' to decompressor and purgatory
 CFLAGS
Message-ID: <20250128075319.7058-A-hca@linux.ibm.com>
References: <20250122-s390-fix-std-for-gcc-15-v1-1-8b00cadee083@kernel.org>
 <Z5IcqJbvLhMGQmUw@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <20250127210936.GA3733@ax162>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127210936.GA3733@ax162>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U7GtxRekNpDnic4wfX0YUvOOA7glKK5R
X-Proofpoint-GUID: U7GtxRekNpDnic4wfX0YUvOOA7glKK5R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_02,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=825 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280056

On Mon, Jan 27, 2025 at 02:09:36PM -0700, Nathan Chancellor wrote:
> On Thu, Jan 23, 2025 at 11:40:40AM +0100, Alexander Gordeev wrote:
> > > Add '-std=gnu11' to the decompressor and purgatory CFLAGS to eliminate
> > > these errors and make the C standard version of these areas match the
> > > rest of the kernel.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ...
> > > ---
> > >  arch/s390/Makefile           | 2 +-
> > >  arch/s390/purgatory/Makefile | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > Applied, thanks!
> 
> I noticed that a Fixes tag got added to this change in the s390 tree but
> I do not think it is correct, as I would expect this issue to be visible
> prior to that change. I think this will need to go back to all supported
> stable versions to allow building with GCC 15. It seems like maybe the
> tags from the parent commit (0a89123deec3) made it into my change?

Yes, looks like b4 picked up the tags from my inline patch I sent as
reply to your patch. The following tags shouldn't have been added:

    + Closes: https://lore.kernel.org/r/20250122-s390-fix-std-for-gcc-15-v1-1-8b00cadee083@kernel.org
    + Fixes: b2bc1b1a77c0 ("s390/bitops: Provide optimized arch_test_bit()")
    + Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Alexander?

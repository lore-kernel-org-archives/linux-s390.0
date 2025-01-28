Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D944A1D;
	Tue, 28 Jan 2025 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052760; cv=none; b=n2I1lDWud1oYqK1DXjlgbQ/U5RYFmuYCAc2pBJCmahjG9Db28iKb5bvGLjB+SdCYtqSpUWrJrssKirA+HqzUyrP3q2cE2cDZZLuR8g3rxcWiZuwVAR7ESGfmSy6n0d7n0m0kHQeUzYoYxerso41KLcCk1QXSNku3uugvanoEQfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052760; c=relaxed/simple;
	bh=RlpNZLrir2sghEWBrqEX0wNKfVtlG7m0SV8udej2h7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i85t7CXAgZMs4cAsCd6gQK1Cz3hCxnsyqAAScsJzTas18uMc5GVYhpCm4GneK99tklcRZJtWaxYmgjZc8lphVP87v1VcWQ2t10ntnsiJLwjcnCMBE/2scSO7R5AUsDP04MwoXJ30WpVz7X1kUXpjy1nNfK/rbFCD+zb/BXW6zsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GB42xGqw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GB42xGqw"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S7WuEQ023091;
	Tue, 28 Jan 2025 08:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=4f9SV7+ALNsjKif0kHR/HdAoMUO3at
	MUKJ3vyhgFM30=; b=GB42xGqw3ZnPJxOYz0vqrn3Gqy5qt19o4SHJjBqz7/VObR
	F5Sdmh7jWbdFlzzFFaNy4ET12BjqXXe8v7rRemh2S4x0sacqTZWnYF/EvnxAt19v
	xfFGpjwMgUaheT7t5BiwhIKmThgmRfLhYbr5LfXvnd8EiZpBHrAnW3qLpkq+OfZh
	Rz1gfW7ubJAsfVyQCHiZ2WFohS15ZHVCR055IaxpcKDzFrY0wbDXUxXunQtXdeTZ
	oEaXSsbPILNOOBNFuijOfkj9bOnpOKIh0yS57lz27DMGy6tIgP35ysCmZb+fWcVg
	GDs2fd29n94rYxjDdqCx3OP21rrN3AhWkHlJbmag==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44etxrr67a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 08:25:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50S56v0q019276;
	Tue, 28 Jan 2025 08:25:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44db9mtauf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 08:25:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50S8PoGm49938882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 08:25:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACC632009D;
	Tue, 28 Jan 2025 08:25:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0C87200A1;
	Tue, 28 Jan 2025 08:25:48 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.9.127])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Jan 2025 08:25:48 +0000 (GMT)
Date: Tue, 28 Jan 2025 09:25:47 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Nathan Chancellor <nathan@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] s390: Add '-std=gnu11' to decompressor and purgatory
 CFLAGS
Message-ID: <Z5iUi9EdsPPMqlRB@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250122-s390-fix-std-for-gcc-15-v1-1-8b00cadee083@kernel.org>
 <Z5IcqJbvLhMGQmUw@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <20250127210936.GA3733@ax162>
 <20250128075319.7058-A-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128075319.7058-A-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lGCKBmyupp_lbI7tF0Fbn9Y2NNzJpU9B
X-Proofpoint-GUID: lGCKBmyupp_lbI7tF0Fbn9Y2NNzJpU9B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_02,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 mlxlogscore=796
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501280061

> > I noticed that a Fixes tag got added to this change in the s390 tree but
> > I do not think it is correct, as I would expect this issue to be visible
> > prior to that change. I think this will need to go back to all supported
> > stable versions to allow building with GCC 15. It seems like maybe the
> > tags from the parent commit (0a89123deec3) made it into my change?
> 
> Yes, looks like b4 picked up the tags from my inline patch I sent as
> reply to your patch. The following tags shouldn't have been added:
> 
>     + Closes: https://lore.kernel.org/r/20250122-s390-fix-std-for-gcc-15-v1-1-8b00cadee083@kernel.org
>     + Fixes: b2bc1b1a77c0 ("s390/bitops: Provide optimized arch_test_bit()")
>     + Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> 
> Alexander?

Yes, I think that is exactly what happened.

@Nathan, thanks a lot for pointing this out!

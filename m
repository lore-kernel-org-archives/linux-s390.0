Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07520BE5E;
	Tue, 27 Aug 2024 02:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724724854; cv=none; b=mR7SUl/6+IfBhn/Fcgdr76Rqjr1yTKRTlsghxy3Z4HT2oYuTMBPcX/q/46lerqDjCrZDwJwkrLThDTTfr8eabB9rcvgSJXR5UDC89hRO+F/fWfFS03g0YBnf9sFRG3fNJXmxHpQaybEBVSqbToC8tLm/UP2IjMBfVOuNrScQWhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724724854; c=relaxed/simple;
	bh=3TItwsJ2VFFTAQ1hNbTUaoRMMr8dd8buS5ezeBO/MEE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=q5zMpiRkXje9Bns9N2cGEmm6P5Au/PC59BL+wMHNhMVGZRM9MvBuRV5aiZ/74S2RBplB4+AkkaUPmfvqHI6sToVwOArL+W3sPr8WEWDvx7FobSZ4Nzk8bgUCgizBpfwBEPsPtw5HmR2Y4TnjYjOrkPTVT0MmNqFT4Mvbtfqq1Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gcljHJ5a; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gcljHJ5a"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R1tRLi032299;
	Tue, 27 Aug 2024 02:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=W
	yCEVvNgqhEd07zijx0fn/uqiH10IErB8xIbZaBXWe8=; b=gcljHJ5aQdFSAy36I
	Nos9uAIXYjiMGdzPtXddHICKpjCtCg5RYNzfAlrT2VRLbGvc6PQF9hbjhRFdUGRR
	vuVbgWdnGUq9d1dEegLtG1jAFKF1y3s6HjzNJrC7ZFlpcO7c2gjXss3fi696yyMJ
	hHrkXmqiuED061DT54HYZzpKtTn6tDFtl5lD11x9llvGFhmqV/ZIaM0Ves7QjB8w
	06SgUCnlOSo7hVRByAh6B5jUZUFqlHkNOp0dtFA8UnsAQ2m0Bb56pOwDGrCKdBIG
	OONAkkbdffk08S33h1Ivwost5LzdfykNLJLdQ7HqqDFMFu1iByrXVKvKCXFDKpao
	q0F4A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417ged98gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 02:13:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47QNppGi024611;
	Tue, 27 Aug 2024 02:13:55 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 417vj38dv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 02:13:55 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47R2Ds5J33686122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 02:13:54 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78B9358058;
	Tue, 27 Aug 2024 02:13:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5439F58059;
	Tue, 27 Aug 2024 02:13:53 +0000 (GMT)
Received: from [9.61.178.224] (unknown [9.61.178.224])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Aug 2024 02:13:53 +0000 (GMT)
Message-ID: <aeb4ab7f-54d2-4547-8f06-25e5421d4d92@linux.ibm.com>
Date: Mon, 26 Aug 2024 22:13:52 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/s390: Implement blocking domain
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: jgg@ziepe.ca, baolu.lu@linux.intel.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        jroedel@suse.de, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20240823203108.304054-1-mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20240823203108.304054-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FqMffSsC9E5iTPA7_JgVKsu-5jHEssX8
X-Proofpoint-GUID: FqMffSsC9E5iTPA7_JgVKsu-5jHEssX8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_18,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=749
 priorityscore=1501 phishscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408270014

>  struct zpci_iommu_ctrs *zpci_get_iommu_ctrs(struct zpci_dev *zdev)
>  {
> -	if (!zdev || !zdev->s390_domain)
> +	struct s390_domain *s390_domain;
> +
> +	lockdep_assert_held(zdev->dom_lock);

I didn't enable lockdep when testing as the bot pointed out -- This should be &zdev->dom_lock.  Will give some time for review before sending a new version that includes that fix.


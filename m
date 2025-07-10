Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E0521D3E8
	for <linux-s390@vger.kernel.org>; Thu, 10 Jul 2025 06:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752129318; cv=none; b=FhGEGVFCbsb1oCSYZql/8Qg8mr2HFht1+tHGNEmzCNLDcTf3qRaXFBjBaMS1SC9ifCMJcnBXJgmFEhvUmozvQFus1KTWStw8mV/a4axmv0Qk+gRqD5Wj9qV2aMgXN8jVDXjsIhRpGAZL22FLW3ghBDd6Jtb8cvSqcvRTJZvTgAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752129318; c=relaxed/simple;
	bh=GSmuI1B7qdDX8yb4tZLEWJ+39mIISedldrHRcpmIe0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHcovRVVc5qbwCR1zc2/yG9aDy9B4qYOPDsLvyexQASo2CtuRCV/mZgzKJUBl8uHQgMW7ujzaLGwBxaN8Kf6Nt0sV8V0MNTxsnGEhSzlYuHGWwGbqJrkfn1yoOrLRZAb1xm3p5ky1AqgluY5w1qmmRQt7+S2HsZ/gTs0Au3UlrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NL3csjPJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NL3csjPJ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569NU5DH030869
	for <linux-s390@vger.kernel.org>; Thu, 10 Jul 2025 06:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=igaggT7BpVTQM8nuZ+hq2d5+ERwqtk
	iNUlMtso2Q6fU=; b=NL3csjPJVqXyOdnGoejr8pIlznolgLtj7bFt7zH5fVb/FA
	WBLkqVVEb5X/5eXMkLFdM8Bbf/oMUjOC09pK10kGfiW8asLV5xek5uLtwv89jQcg
	F2vmYnl/E/g8BbVrdY5IfUlwrNGNNL05sI6ERhhOdE5lfhYCfKK5oyu4SJDQHa5K
	RuFKSpI9z7vhQv73RSmwwcuhLPokqSCCpbEqGoRS8tpkD/BA0LxdD/mmMzQZQV5E
	bG6vANhg7ccu5x1MkNXSHVhB3OEFqhqEnPkzX6OlwL4da/8sqresE0WcnZz2E43R
	b4cM9wcxSy34i20fpDCX8k/pH+6gwjD6awFstCrg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk4b5ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 10 Jul 2025 06:35:16 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56A6XvGT019083
	for <linux-s390@vger.kernel.org>; Thu, 10 Jul 2025 06:35:16 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk4b5ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 06:35:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56A5xkYU021566;
	Thu, 10 Jul 2025 06:35:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qectvg61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 06:35:15 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56A6ZB4d53543370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 06:35:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AD2F20043;
	Thu, 10 Jul 2025 06:35:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ECEA20040;
	Thu, 10 Jul 2025 06:35:11 +0000 (GMT)
Received: from osiris (unknown [9.152.212.133])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 10 Jul 2025 06:35:11 +0000 (GMT)
Date: Thu, 10 Jul 2025 08:35:08 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        S390 ML <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v2] s390/con3215: Use macros for hardcoded values
Message-ID: <20250710063508.9673A5a-hca@linux.ibm.com>
References: <20250709190810.13885-1-xose.vazquez@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709190810.13885-1-xose.vazquez@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA1MiBTYWx0ZWRfX21f4kly/OlSf h+0ZN/B1+VYk8m0OUTZZSVTjwBIoKFBlKH+bO7viaMkHO+UDI7jN094x9/Q5Z6y5uQ38SSVytkR nrmo7I8Il63+aPdb85h8zIJx+dNwaLrUcWecQ+a6oYNDvH60K7l5DaUXPdbXXEcfZYq38CTpTlg
 7YjTR02oFVguex51lXAos/SOJo2KuTY4S55Wn1/T8n5xIAqhr4NcD6lVA6TXLQnKy5V7u86CZnJ 8zhLUgmvtThsrSJyAa8r1VpTu7uF+Fo+nc4FS7iwtmCBFOCebP4ocXBFrmN9cvrA4UiiuUsju6p eeUD6Z7zlcBJl2kYaZ4tWJZgDw6X/0ysyPHYAPoEXBBu6zS/7YEurveHPot97/v206cmnp8MWLt
 qfpmpQKgzyLQE9/HSR5I/zwmMUmOcBE3u3rTHU0ITW9hiYgUdolydJiwccue4GgSbvwmxlK4
X-Authority-Analysis: v=2.4 cv=XYeJzJ55 c=1 sm=1 tr=0 ts=686f5f24 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=x0zQ_ckKABF35qz15WMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 58f5xQixPcOQJ2BdMEu6ePdWff8TybHH
X-Proofpoint-GUID: KC5cM7kWMlCP-lidnm726fkzX-TUZstR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 mlxlogscore=637 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100052

On Wed, Jul 09, 2025 at 09:08:09PM +0200, Xose Vazquez Perez wrote:
> Similar as in sclp_vt220
> 
> v2: fix RAW3215_CONSOLE_NAME
> 
> Cc: Heiko Carstens <hca@linux.ibm.com> (maintainer:S390 ARCHITECTURE,commit_signer:1/2=50%)
> Cc: Vasily Gorbik <gor@linux.ibm.com> (maintainer:S390 ARCHITECTURE)
> Cc: Alexander Gordeev <agordeev@linux.ibm.com> (maintainer:S390 ARCHITECTURE)
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com> (reviewer:S390 ARCHITECTURE)
> Cc: Sven Schnelle <svens@linux.ibm.com> (reviewer:S390 ARCHITECTURE,commit_signer:1/2=50%)
> Cc: S390 ML <linux-s390@vger.kernel.org> (open list:S390 ARCHITECTURE
> Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
> ---
>  drivers/s390/char/con3215.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

This, and the other patches you sent, are just pointless code churn, may
introduce subtle bugs (trivial and v2...) and eat up maintainer's time.

If this would come together in the context of meaningful code changes this
would be a different story.

Therefore NAK for all of the patches.

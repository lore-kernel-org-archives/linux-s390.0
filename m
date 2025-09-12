Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E83B296BBC;
	Fri, 12 Sep 2025 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757675461; cv=none; b=JdAqll6tW6gf5nFmUY+v8wYqAwrDQSrtYQxQ6QW2XeV3oA6xLdbK+j1bYeZpAwO/c1q1G2qovbmOkeVrdyfEFQpWNL/tRbY0kiWPWspwOoieIMaVQcaHDSKHfq2FofjSFBU1+Bmdzpyv7BU+/zW3ovWY1lbgAyGEAgK9ftW2xSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757675461; c=relaxed/simple;
	bh=KIt+Rei9zbPaLUbX2r4Ldj/4v0u+LfTiitDBTBkplns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkyaDUrXjEQL4cwmFDLRZYFpTHPUaEsl1y8G3T41YrBpZdhkKhJEcN3BpLGfiDl0m//Veck3VsyCKXD4rvkv6k7BO6wUJCCYXsZ576jAzDorupx6U22WiPDRt8M9O+O55mzKWbXhoNy2f8gB2U07m9kA2LHjhJkayWDNx5HO6xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=khCnZigs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="khCnZigs"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C6F4p8027074;
	Fri, 12 Sep 2025 11:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Ge3dlEDrpnX0RZTrXwSbi3QyqUEEWh
	lFGjUWI/DE5II=; b=khCnZigsYsZ+KFpV5cKhHaQ4fAPZ141Kf9OlA4PCKE/AYC
	Y3BtqDqGoJD5mcmLXDTZ8SlUd0QwwuFIse1ZUC8Qm1hQO8Q2lEiLlgozPSxs0dQd
	Jygm2ghRVy1o2az8EIugMP3Y9Q2Toi2w66gPZu/8hsgl9WjZwOT8PDhC86+XeQF1
	SjlRd3yKZDl9eMY2wisU8DueuXok89+4MXwVS6IXdGS2c+Ynbs+zqdC76jXYnTR5
	nR/lKWN3E9Yt5O6cnvyRB+jKr4sOfj7XxxQjdEdh29+Am8JXMfGjmHx1nSVpSwwe
	JuXdBvqQ87C4EJQg14L/TJa2yJQBznjHyYHSXf+g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bct9r66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 11:10:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58CAo15J017187;
	Fri, 12 Sep 2025 11:10:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gmtf87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 11:10:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58CBAlH253608958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 11:10:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8F542004B;
	Fri, 12 Sep 2025 11:10:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B53820043;
	Fri, 12 Sep 2025 11:10:47 +0000 (GMT)
Received: from osiris (unknown [9.111.34.207])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 12 Sep 2025 11:10:47 +0000 (GMT)
Date: Fri, 12 Sep 2025 13:10:46 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/hypfs_sprp: Replace kzalloc() + copy_from_user()
 with memdup_user()
Message-ID: <20250912111046.10147D2d-hca@linux.ibm.com>
References: <20250911214539.1483234-2-thorsten.blum@linux.dev>
 <20250912095620.10147A01-hca@linux.ibm.com>
 <D56B6A09-8633-402D-A942-1C24AE465AC8@linux.dev>
 <25EFA2E0-5119-400F-A787-D2BDB78B8BE0@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25EFA2E0-5119-400F-A787-D2BDB78B8BE0@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX6qEgsIGs44um
 gLtOY3NpYoIPFQOO8tRKuZx5eiPVdaWGgcUZOWDvUDIcRUSMW3ojCXbqd6vXcuswX8PdfC7yT2G
 Ol08dysgEhalq3jehlO6/ar+TDBzcRg/H/8mMleUyfA0psNU+KvTfr/6uxr5/Vfa0Ts3KF38QEZ
 B0SrufPubOOpXOKrRSLXScQlwtBlFQRhNv2eSSDbb209FunzWKYAdREAOK0FpH8hjYasNISrcfO
 I45zbGqUdloPzP/h7BZbAcNUkEDZWYwD6nyv6yaUdaKl1foqiHllvFxoKloSkVOW9VX87e5KHLT
 lBwUD9Sp8t6djoy2TyP3Z0ZMnMYZuxu61pAOAK26aE5ZwOnGV+53jsx7INzyZmzMIYUDVSOPr9d
 9W3mrqSA
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68c3ffbc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=1XmD8dKfQRJj2c4s6MkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: dlbwASr041L64zULTUCn_QR0f6SLMJpU
X-Proofpoint-ORIG-GUID: dlbwASr041L64zULTUCn_QR0f6SLMJpU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010

On Fri, Sep 12, 2025 at 12:51:05PM +0200, Thorsten Blum wrote:
> On 12. Sep 2025, at 12:09, Thorsten Blum wrote:
> > On 12. Sep 2025, at 11:56, Heiko Carstens wrote:
> >> This is not an improvement and also incorrect, since kfree() may now
> >> be called with an error pointer.
> > 
> > Unless I'm missing something, kfree() works just fine with error
> > pointers. See linux/slab.h:
> > 
> > DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))
> 
> And unless kzalloc() is required here, memdup_user() is an improvement,
> since it uses kmalloc() internally and avoids unnecessarily zeroing the
> memory before overwriting it with copy_from_user().

Again, there are gazillions of similar trivial cleanup patches possible. The
additional zeroing in this case doesn't matter at all, since this code is
executed once a year.

Reviewing and integrating such patches could keep us busy all day long.
So, please don't send such patches.

Patches which fix (potential) bugs are welcome however.

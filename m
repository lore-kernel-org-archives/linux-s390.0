Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE1CA55;
	Mon, 16 Mar 2026 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773666375; cv=none; b=UKR/wmT4FOx6WcWbKTPU8Wfo1y/DWWThD9hFbdZQtbMIWsqlJj9GihnPG4mUubLNgbOYh883SA6Lw8R6mvYyelZJ/oSgmtXJvkXcojN9FuO84AjGpKCPucPZapxkO8CAlWuYi7yvnIDeT6CrXxPGM5ZVj0KDNikuvBi/oyj4y+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773666375; c=relaxed/simple;
	bh=waJBSkFenb+V1D/INNqxu4uG6vZdlGnaGTP0hoDh2aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLV6VCbJXpT9RNeBCPdFwV7UROROc/+SmMc2JRVZO2mg8oeEjZQTQSWJ+O5r6ekEpQpj/npaqkrGaaaaXxAJBSyAMOoW9E9oWhFt8L7au8B1pn4rhQArnyRRbqr+qJtC/1ACaB9TspznSEwAsZEU8r+cQ3vMP7P62uIp9NKr/kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eDddw3K2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eDddw3K2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G14Cqu1188734;
	Mon, 16 Mar 2026 13:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=GxmzrlIjprK69T1v2Rr/o9Vou33tII
	VEXuRKZkkhtyg=; b=eDddw3K2Fz1jZptqxONzZnN8cscN609oE9Irjit2+q5ZRm
	BLkt3qQbAm/+QHA8G2ga3Sdsw/nUSHxK9hYw/MrN8u6nx5dKovogniKmsFEDIAaS
	UJWRsgbWxMvx/MOaEl2ks6n56E4eMpuPWRF1/KzcLIDQAt6CwZGsri7kpDePQz+E
	YGZ2x1Ks2qRBRSEyqo1DUdn8EGIJiwJGioGEwr8oajhEUEGKrHIMS7XR6u7qYPkV
	8fV44yI6CDJRsJIjvOHR5OO6YcISK9fc5fFee7W2r5izR0F4TkLlBjOEsGH/eBqz
	bhdBGl6Bdb5Phj5DLGqvQkerHhwfRVRyQpceWy/Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfa7bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 13:06:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62G9Z8Mg005412;
	Mon, 16 Mar 2026 13:06:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0s50y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 13:06:04 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GD600T50135390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 13:06:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 458AF2004D;
	Mon, 16 Mar 2026 13:06:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B097B20040;
	Mon, 16 Mar 2026 13:05:59 +0000 (GMT)
Received: from osiris (unknown [9.87.141.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Mar 2026 13:05:59 +0000 (GMT)
Date: Mon, 16 Mar 2026 14:05:58 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v2] KVM: s390: vsie: Avoid injecting machine check on
 signal
Message-ID: <20260316130558.17080Ca6-hca@linux.ibm.com>
References: <20260316122546.11573-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316122546.11573-1-borntraeger@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lmtd_AOoHAG9pbRMpUZGJFm4aNW5g3Yh
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69b8003d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=4FKylwy8VPKmDCnMVIoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5NyBTYWx0ZWRfX1dcLDr1K4gzo
 UObEwSJJ0Iy5B0P4YQw/OLN5BNysiNxAHCL++84TGXhKz31Y9GwC3Lg61tAbytCShcnzf/smwwe
 ZJAkAwywaaSqoT2+a5inivVn+BFZ+e8FTxGib8og1z6Vli8DyyiXRCRFk9TQ2eTlxAvBR1M365+
 FXmH1tiXz6Y2igGHO+KNe+glGh6ZnsCxVyhfh3A87/GoRojTH9e904owQZETWiMVO58sDu4e06W
 3u4vyEzFql7VbMJhqiMTSP+U4/vxR6VgDrVY/sVvZVFhhaxwK1Q7nY/zYqvjoCS0f+Woox0b8bZ
 mGbxw9eqWBTFAeIx5+ZEvVzD/8GevlpdQN7otSb7rgXf1B3a9HA6Tp7KKDkJRhgWru3GtINRy36
 1cPecYxRXDf2MR33aGX4X+PxmI+PvhMiHFCjwYPaPM86tycZLVxHXyZ9h2EJI8I/OaIMm6xubJ0
 FPR656L4lMNLkRt3DLw==
X-Proofpoint-GUID: lmtd_AOoHAG9pbRMpUZGJFm4aNW5g3Yh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160097

On Mon, Mar 16, 2026 at 01:25:46PM +0100, Christian Borntraeger wrote:
>  	}
> +	WARN_ON(sie_return != SIE64_RETURN_NORMAL);

WARN_ON_ONCE() instead?

> +	WARN_ON(rc != SIE64_RETURN_NORMAL);
> +

Same here. Besides that looks good to me.

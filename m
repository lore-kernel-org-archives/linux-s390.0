Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D734F25B08C;
	Mon,  8 Jun 2026 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923235; cv=none; b=ByZSsfSHCxs/bIWG0gjWxN9Sex9JnFehftri8h51g8vL9SZULkrlbYK3ooSIW8TupfVNaAPsuBm9KefuJPOWIFN4DmSa31jQ+JIpaFjoHhDhwZdPeUxHlno37R7kL7pHlH8HaIGbA9ithJT1uw1R2uqH4fXkwp95cmWZ1x8wweA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923235; c=relaxed/simple;
	bh=VNZWvVw6dn6z1Qf0SJZAjWPwvIXZgv6nu59rCzD+f+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMmI9ktU2O0d2bstaUUHn8LMU46IPHYofmXTaA7Mm1uKFK7why6Ie89koTpdbg8N2ZU6Fty6vqlebTR+lsF+zOSggPyrjp4vl/PoxMkSo4c6toa1Hy4f3xNoMz1Q9ErHFWautHq8+0OfWzhJvXQhnItobFT4aq+ojuPKzdeZP7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jr5lEsPj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jr5lEsPj"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6587X9eL1020701;
	Mon, 8 Jun 2026 12:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5HPpeq66796u9YaU1Gm5opdvKfFFJY
	HqIamyHdUqH6s=; b=jr5lEsPjq9eD+LvOTWf7Py3JG2uhW600veVCVddNGGfUic
	7xx5vXNe9eOOE5p7FP56TvmDolgdBvTD0S1zKd4Xq+p7HD77XATt3BHk6trewkvx
	YuvRFyLNPuvVQ9kXyuG+cAZol1+RdJawBOO0+KSGUgs1jPjAW09yXiJFkWg66o+S
	pMTxbBO8dwSAVR6FCBPvnEFgS0pExlW1CqoZj6NP1H69BG7WpIrQdhPZDAq+0K2c
	RHWiLljMXr0lNub7slEMoA2kxa0UpW+pAT6toX8hIWfoEJVEsAlZvgDpYtTJ50EB
	O/y6RxnmbREmAdCD8ewuOxeTrcdqJav9JZ8x8gkA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb957a53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 12:53:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658Cnefp004143;
	Mon, 8 Jun 2026 12:53:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vwerv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 12:53:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658CrlA349742276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 12:53:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0F6320043;
	Mon,  8 Jun 2026 12:53:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D8FA20040;
	Mon,  8 Jun 2026 12:53:47 +0000 (GMT)
Received: from osiris (unknown [9.87.136.35])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 12:53:47 +0000 (GMT)
Date: Mon, 8 Jun 2026 14:53:45 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: Re: [PATCH v1 3/3] KVM: s390: Allow for 2G hugepages
Message-ID: <20260608125345.100035-F-seiden@linux.ibm.com>
References: <20260603154758.234768-1-imbrenda@linux.ibm.com>
 <20260603154758.234768-4-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603154758.234768-4-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a26bb60 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=jHG5EYXQ7g7Ka50Sl8IA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: mMD_6u3g7JNAfZxYGfGsrBXUYvpRXku0
X-Proofpoint-GUID: mMD_6u3g7JNAfZxYGfGsrBXUYvpRXku0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDExOSBTYWx0ZWRfXyjdRbOJRaN+o
 k0zbyvVvceDblHfROsKTc2BriiCYdm07L30/HFYH34hwiThwA64PxIQ1Qsc3ZA4Udva6KjZ1Sad
 N45omHDfYkkYXqurH1oLTDmXYr7H70+yKBRD8gfhLcSh1YQBwqnNzxmxZD58J+9udbsO49HQlgX
 YH4/Xv/RCvAfeBbOO4gBmiIyq6YkijO5LhUeJa/I5h12Iql+qI6hSdU4HzTYehruYHhCruk0uxq
 +6v2C3tcLdlgVkedwpS1rAWrV5nxr51utTKFTmpJPyQQgtX/xCCLcfl3lWyhjFRat2W09TZJH4H
 fta2qWWhLwCMG5hzVYhOIHAOxFCFtob2P2FP30CmwfvFzieIw2pG7DfZWDZqZzTXBwKfI+H3lj4
 +uAp5tTnMAMmlfIILJK506MRZCJTHKqv5NtmDK8nQQf2586I92o4BbCLWxq2SMWN+uyYpYfuGFV
 /S2gp9V4gNPXCIzS+8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080119

On Wed, Jun 03, 2026 at 05:47:58PM +0200, Claudio Imbrenda wrote:
> Change gmap_2g_allowed() to perform the necessary checks to allow for
> 2G hugepages to be used, instead of returning false. The
> GMAP_FLAG_ALLOW_HPAGE_2G gmap flag is now taken into account.
> 
> Also add appropriate kerneldoc comments.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>


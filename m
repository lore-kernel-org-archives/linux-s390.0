Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5313C3449;
	Fri, 17 Jul 2026 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293159; cv=none; b=nHyZkcJJTfW1IdJNbxiXEJxlSx6ZsBSrJpzq/pBvnm8QKZtD1PFmRG7JpYgeUqjF5RJxtYhuHFuqoQvbY6e5D1FtKwgHfojDf2CG0WMiy6+atU4pqPKNbgmAJsD6vLU6LQcZfuctxUn6Ykm4cH0RsdSN4FMqcz7I4m96KhU1xP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293159; c=relaxed/simple;
	bh=jpW4u/rTtEELEua+gA3R2ONjiHBY76iZD3ypjcl9qYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTXr6IVBwke3IEd90uI0gLMG9zlTkkLUb5TVfedVSo7fJLV9hIGUYaHNfH5aAxlwWlxWW2ueWSDfh9C1MuuKXamV3xK/I8yg2jCr4GRpKtsTyuEQPTjpGRttEqyZrgPphAyh/q/9cSbBRvjdVenvglEL0edqMZWspB+CBUitpW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pgAIWO2P; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pgAIWO2P"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HCfYgi2047860;
	Fri, 17 Jul 2026 12:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Zy9LAFyb6D/reDYRzNV5e5WjX4UDrO
	TKYx7aV0+RXNw=; b=pgAIWO2P1/2O9UBSkZiQp72nErW468QwgJkgp9MrAZjTxW
	CgjO1Q8cvCM9i+LaaYzX5OHb58Mz1DEbVcAzHArO9+6C4v5wZfL9lCWjqnNrehXW
	A6TVVo27l+mj0Twv1CVBLcXFXa7zjWdfaQSm6uypADnSug1StTEF0nqy1523oLUD
	/zgV7wN4pZTyCV7cwEY6huiFLM05ydk2He0fDrKF5MRDxvWuCx7+olGScH37iAXw
	bERcbecTaLB8YXUyM+3GYu9qkW9h84MZPdybJ3qeHhq+9+18mpnR1GXZznAjSmso
	j1dBjGALg0fNPVsLVcwXuSiEyJnUc4z7LBevsysg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxxgqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 12:59:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HCnaUq002020;
	Fri, 17 Jul 2026 12:59:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhsn87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 12:59:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66HCxBSC46334226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 12:59:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8148120040;
	Fri, 17 Jul 2026 12:59:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A9DF20043;
	Fri, 17 Jul 2026 12:59:11 +0000 (GMT)
Received: from osiris (unknown [9.87.159.133])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 17 Jul 2026 12:59:11 +0000 (GMT)
Date: Fri, 17 Jul 2026 14:59:09 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: Re: [PATCH v2 5/7] KVM: s390: ucontrol: Add missing locking around
 gmap_remove_child()
Message-ID: <20260717125909.319936-C-seiden@linux.ibm.com>
References: <20260713150857.269954-1-imbrenda@linux.ibm.com>
 <20260713150857.269954-6-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713150857.269954-6-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _yrzn1ssRGGzvHLN3qZdvDKJRtr1NLX5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEyOSBTYWx0ZWRfXznO9KDRfeX6u
 SU4H+uknL7tO8BadsrMPnrzJAgL28haz/q6dkxZq8pPoJIPFjsvNxNw432mS7V3hSibGn5xGunf
 LpIVHKgU443Pq3jEYwhvOj6wUyEwWps=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEyOSBTYWx0ZWRfXzI6uEFzUNGct
 tGFQeZrCohAfon8ks4tVAR2u3Qn6Aj8mVPNJ1RhYd4yPM+GKaoHOVRyGiBKXfQKi+IMgsFaYNbj
 ehfgqkKlw4374OW9gaaZK5+zcLs8GBf/whwxcfIFHF7MjHx8NLd1d0yIillVBVsWngMwXKtKucO
 h/dj3a9jG+GZZObSYks8PaBrT1iz8/uekKRIx6nN7o71AjeKRDri/brr+iKtjSMt47rKw+S3Y3D
 MdE3UnRQ6RU75s+UDMY/2MFAcU8zcBx4DJhihR6AOtVAaHQevfnvhxYO2jNO6fJBTG1+rRQvq3z
 6/LNF2Lk8SM4V1CIXVSDu/9uSJWG7rDpFBqgVqtKlftGBn/SOy6VbIJL2eF96WOMRTOjzCPLRJP
 qDEHJE52rdWAQERdXscOkEkK/5RJ2Yg0QVPvcIqQ384OoBAg/veKZiINJVMf5hxaRpZqFOX7u8s
 LhB1lUTbiAkm41BlKkg==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a5a2724 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=ArR1R98Ic4aZ9UPBaNEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: _yrzn1ssRGGzvHLN3qZdvDKJRtr1NLX5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170129

On Mon, Jul 13, 2026 at 05:08:55PM +0200, Claudio Imbrenda wrote:
> gmap_remove_child() needs to be called while holding the children_lock
> of the parent gmap. This was not the case in the error handling path of
> kvm_arch_vcpu_create() for UCONTROL guests.
> 
> Fix by adding the missing lock.
> 
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>


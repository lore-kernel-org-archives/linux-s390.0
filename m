Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DEC3F8231;
	Fri, 31 Jul 2026 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497975; cv=none; b=DfVFNXZ58XG4ws5zyi6+bMlVwqP0lqky1OPm4JVx6+sjgLbdp6AMChZxFk6Nj3yRnnhDMtGuodluHhEBfWVcwmIN3mUW7n1/ogSjuxEN/8/5+CSSsx0qDSQHmdo18f8e8N94GjSqx9MZjSxurf1xRy82YE5htQfMWOkFpYxH3Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497975; c=relaxed/simple;
	bh=pLxX9VI353yIY5yVzpmavce+kJIwPOWbl8r/4uDi3k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rB0l+Qt9YvVfhQc2/S4BXjpeaOxzcgLaEdmq7tPkT5PKec4bx0TWN725AA5GtQ2Z5Lrztcs2Vws6XMcFjkQc/k2K0FO5EU/tRCD4FhK/YjZEWerVBsHt3UJVPxkSSVdW+B44ocTlZISc8NBySgvcgcnKealLLAXJhSjNJl42kG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aklwowP+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aklwowP+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V8HlMF1230489;
	Fri, 31 Jul 2026 11:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=CzEM84o+yXz+ozyXw8Nv6kwr0JFASh
	1yXBcYDXpaWSE=; b=aklwowP+G2ImoWxSUCOVOKFefnTGrJV76bE+wRxvDaK0yL
	iRbXq20ZuAOWZCEbiNkP3+fWuKiMhDckVuJH3/Obzxz8bd73LTRJWYfIDy5RXTAW
	1O+mIKPJlk4f9e1iJdiLJORjIiqVoSApfRV4P/uGgfKIbd4OOvhAXRf9d0dHdfWL
	dyePNQAZC5cWh4hFDRtVAxb5gn+HhIcf8YCCs1R1UeujDy3UQL7dNf3zMf0m9nMB
	R3knd0U81VShFscav6LalSuvwnbB3Yn0Mh6a0roL04SbRWq+QVJRx4GIC6Amo85U
	GK+hBHPneitFJ/KRbwqqB3sCS2FhPWBE+DeFwQaA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0p3qww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 11:39:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VBQj5a022323;
	Fri, 31 Jul 2026 11:39:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgqh5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 11:39:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VBd9Ef45482366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 11:39:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC67C20043;
	Fri, 31 Jul 2026 11:39:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D3C220040;
	Fri, 31 Jul 2026 11:39:08 +0000 (GMT)
Received: from osiris (unknown [9.111.91.157])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 31 Jul 2026 11:39:08 +0000 (GMT)
Date: Fri, 31 Jul 2026 13:39:06 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Kees Cook <kees@kernel.org>
Cc: Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Dominik Steenken <dost@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Maxim Khmelevskii <max@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>, llvm@lists.linux.dev,
        bpf@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] s390: Add kCFI support
Message-ID: <20260731113906.8638Bae-hca@linux.ibm.com>
References: <20260727140514.116501-1-hca@linux.ibm.com>
 <202607301639.13BBC08@keescook>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202607301639.13BBC08@keescook>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA4NSBTYWx0ZWRfX9tM+O7y1hLj4
 WwkP12Bce/f/JXTKDwiM66q+C+y0J2E4WlTRjUKa/lL+tWf5LTSUJ8O6Hx4zEUhxnIh9bRRnbCv
 ocMngQXaMjQ1Lo21vSdE00kOB6Ye7d0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA4NSBTYWx0ZWRfX9nbtUtMTfyXo
 NvcMhFT+wd3NLvuefmaQizQbWHZyNVJX8A8MffA2WG+VkLL9zsBObt2IRebPUwJze0HsQ5sns13
 f/y/MGXzuj6YSf0LAi7K47OVwdIqdRmEjuKl7f3b48LJ/Cn/AbU1n4L69EOvoIK+Ap4UN92HF7S
 11Gj+ePaSHA2k2cuDJjJNelT9uZg7glX810PKIUZvMs4W1EW/blCJNCWkdx8Cb13R+VInUP1HDA
 0XqIQBvRrclHLv/UylDX5tNTnmRYpxM2Puz9/ZJe/RPKqVIdykv0CQ3qtROyIpAdTjeae3zhxha
 OG5kvErfuwdsG0HIqtqbIUs1b4cNmSONMZMMP7lmQnAWttSkt0R02pwnzYspSf5SqcmhlPtRxqZ
 OkIE2mnZ5OpZULdE6Nv4Af1y6xumZRcWX0rDtZWg90gxGTLrJr/YjhrEaPixWkaRMrjzPWshzBS
 X9tOuWDclELChqKKrNA==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6c8962 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=CCpqsmhAAAAA:8
 a=VwQbUJbxAAAA:8 a=pBODjdVTdmWaMJCjjaYA:9 a=CjuIK1q_8ugA:10
 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-GUID: 98tj-63HqQsxebjeSATT_lVRL34uYG4n
X-Proofpoint-ORIG-GUID: kjAa2DvdE8kbMMu_wd0p0uTwvtVEAnQE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310085

On Thu, Jul 30, 2026 at 04:40:50PM -0700, Kees Cook wrote:
> On Mon, Jul 27, 2026 at 04:05:07PM +0200, Heiko Carstens wrote:
> > Add s390 kCFI support using the generic support provided by clang.
> 
> Awesome!
> 
> Is there anyone you know that might be able to review the GCC KCFI
> series[1], perhaps with an eye towards providing the s390 back-end
> implementation?
> 
> -Kees
> 
> [1] https://inbox.sourceware.org/gcc-patches/20260716005527.it.950-kees@kernel.org/

Those guys are already on cc, but I can't speak for them if they have
the resources to look into this right now.
But of course there is also vacation time currently.

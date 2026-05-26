Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194D82D6E58;
	Tue, 26 May 2026 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801448; cv=none; b=Ve7AA0B+2YaCtOi9p5goJRegTNHutwbtb/ik05RrOjQUvxNxElAGrGdmy52QmSB7UOz3bjFVwq0FzNsQtQbAQoohMJ1+OJb30rkFZSpLdkzfiTTP+/Z/Htj+qTQDqoanJls8ggnHyFCa4Z9J4BpZYkeP+osDumXtPu/nwxSzuVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801448; c=relaxed/simple;
	bh=8VD+sBKogxg9JTxks47UafF82ToziQkvyYt01a9musw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTzOdk8y+ENl867v2x0b4WyvFEBVuvPxVBHqbIEnfTlrCJcHUpy1SgoQbkwm7h1CXTcqK9cIlhRl2quUBdiPnL97H/WbdAPg4IAabjHvunkCe8fMVBPkyrBR5+/eDTgJLyngeF/BzryvdBSaHC6ZE0YGRn9sGSvcabOKqZ7irJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d0wvbliq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d0wvbliq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q9dF5D2248392;
	Tue, 26 May 2026 13:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Y1kv+CfNUNO3MeaqDjHj0Sowdx4+Vo
	UCsj8GaNvaqRU=; b=d0wvbliq1J6P5GlwAS5MU/Uss6jBgNoryS07FKPT8m9tv3
	h15yxayFExcOzFiqjxsJeA2mpg/LGlexRVA7m28EEG8l3G97bnl7YXrj6t64vQVz
	SwoWeK4oTNPF9LyDDf8e374p4jS/D7k3zMeMx5VYbOu610q/KclicxYcmNqFSboA
	w5tCq2q820kETdfMAQyrJP8pKKzNRs8kqt1MydpOUO42g6KhQ/veyEVsUXgHohb6
	wU+WJQt10D8vBXyJxge4T4qmw2RQcD9hzXxCW3hZoC5iOhpwjTY3bKSqiMVoEoO3
	bQerSsG6Gf55EMcnL7KpFJByM9K9BbWSnx4I/BkQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4pdba3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 13:17:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64QD93DZ028493;
	Tue, 26 May 2026 13:17:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ebrsg9911-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 13:17:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64QDHK5t38207776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 13:17:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C76A420043;
	Tue, 26 May 2026 13:17:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A55D920040;
	Tue, 26 May 2026 13:17:20 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 26 May 2026 13:17:20 +0000 (GMT)
Date: Tue, 26 May 2026 15:17:18 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Marco Elver <elver@google.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH] s390: Implement _THIS_IP_ using inline asm
Message-ID: <20260526131718.9778B73-hca@linux.ibm.com>
References: <20260521122727.142280-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521122727.142280-1-elver@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OdqoyBTY c=1 sm=1 tr=0 ts=6a159d65 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=mDV3o1hIAAAA:8
 a=NEAV23lmAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=kDix7j7DZTOcE0wP3AwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: fNHlpc8Dtb3xBM2K8RfIIRb1RuwkNAyg
X-Proofpoint-ORIG-GUID: m3PnYVOt16oPwZ8UZB8iqH8Tf6ZlAWfN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDExMyBTYWx0ZWRfX3F0xLZBxIGSq
 Fb1iNRqRPpo82hicXP1+srJwI7qOZOK+BYy66cC0CqQCAIH9jRny8P2VyerahCD4HRlzwXX65XG
 QDTjLnndRPR4qFaZS7xmyrvwVSUV0EbSJxC3G+fDmFvNOPLIXaXIzDYnQNVrrfRgcYLrOZhKJSn
 v416EDdHfjZsxAzY5vQxZ3eGvB2nAybTLe9TXg1FcZowbP++cgHcitwe9lIZ4+B5ncs6vc1XqZ8
 PNHbtMf8ZNOfZUz2ULk1c13DQMd3yf1WFq7t5CcWcSK/CL6xfNE82IcBRa8mdqWUkw25EFAEOZB
 p68Lvyi6SyVLurFtwlEpBdRntiVzLBQ6O8EUgRh2NSWEGxavcbH5x6XiX7zDn4D0yxKpETovm6y
 q/+VmdCFlB72gLw2ohundn0ZT/T82LYwAZVn8ayLgp/4V0ogQks3KHNPMTy5+iLFufbmnqxHNTv
 BxsuJdXyqTUE4a1NTuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260113

On Thu, May 21, 2026 at 02:27:23PM +0200, Marco Elver wrote:
> Both GCC [1] and Clang [2] consider the generic version of _THIS_IP_ to
> be broken:
> 
>         #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
> 
> In particular, the address of a label is only expected to be used with a
> computed goto.
> 
> While the generic version more or less works today, it is known to be
> brittle and may break with current and future optimizations. For
> example, Clang -O2 always returns 1 when this function is inlined:
> 
>         static inline unsigned long get_ip(void)
>         { return ({ __label__ __here; __here: (unsigned long)&&__here; }); }
> 
> Fix it by overriding _THIS_IP_ in <asm/linkage.h> (which is included by
> <linux/instruction_pointer.h>) using an architecture-specific inline asm
> version. Additionally, avoiding taking the address of a label prevents
> compilers from emitting spurious indirect branch targets (e.g. ENDBR or
> BTI) under control-flow integrity schemes.
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=120071 [1]
> Link: https://github.com/llvm/llvm-project/issues/138272 [2]
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  arch/s390/include/asm/linkage.h | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

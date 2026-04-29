Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4B534D4E2;
	Wed, 29 Apr 2026 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473731; cv=none; b=P2SeTdYNhvcV25iTQA26cu5NkTJR+eiCpcPhPv3G1hPAWxiTI2sfzuhGnGr+MCJo+4rYeyw+wfj5TTP6UYPDLdxnRi7JFWTEiShYlP5HntXSUm3apHipNtM0kTkmeSZ8YaaGYOIBAOmWk6GO0b6WM/HgNkGFsSVRYFmdkKQxVno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473731; c=relaxed/simple;
	bh=4DC5FnxLOx5oS/7N1CXQDRF0AxOA8SOrVog97hjGYX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uo64RtSQb6upYhDZnBHTtulVfK3PEBTh79muhssqaqn2yMgLMpBYnsZlVlVRhbEEM+mTxMug6ztB5WZ4LsFhLhBbP1byyP4TUH5Ynsy/RbaAYWT5wrYx14z6fMh0DrjliLwc5aANinK+dP9doaLTZctMR7ByMDiug6TQwRQQjMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VA1JIZSk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VA1JIZSk"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TBEWhu3583678;
	Wed, 29 Apr 2026 14:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Mujp2GZPdcDGR/E9gcQ1mcqPr72iGH
	hDCXAgy6P3/gU=; b=VA1JIZSkfHR1tMipMNAqrXKtnSb1vMRPnp58FnzJAFGJqH
	G2TFtAMY5+CQ6DaRRNi4e2akSAYnNotPnbg6eevSHTyrVF8vHxCLcFCMDrzkBZLC
	ZVJydLKugwFy3JPxuvcszdq67SDdbIZQi4Z56t87Aljg1SCMWvn3KLYvALVg6Ia0
	75U0bnO6ZKRXw4o9uiBM7p0ShWOxvoUtbqBXSaoDaVO7ckk8Y6qYf8rp+MpuHMQd
	AsYx9TipzoDY/J4aIeIEH5mvyk4JrfU0H2NmoWfZrtiubt1rSqrXIx1PjSZgBNsT
	SHqCbj+lVVQERC+hJSmM7eQ3D9TWineR2hEWErag==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44u4dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 14:42:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TENorg005383;
	Wed, 29 Apr 2026 14:42:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5gejet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 14:42:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63TEg4pQ15925612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 14:42:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7172220043;
	Wed, 29 Apr 2026 14:42:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B49720040;
	Wed, 29 Apr 2026 14:42:04 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.52.215.75])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Apr 2026 14:42:04 +0000 (GMT)
Date: Wed, 29 Apr 2026 16:42:03 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Julian Braha <julianbraha@gmail.com>
Cc: gor@linux.ibm.com, hca@linux.ibm.com, iii@linux.ibm.com,
        meted@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        akpm@linux-foundation.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] s390: fix dead defaults for
 S390_MODULES_SANITY_TEST and S390_UNWIND_SELFTEST
Message-ID: <a3adc8e8-ce4c-458c-a0c8-c0e66078589d-agordeev@linux.ibm.com>
References: <20260414215651.151228-1-julianbraha@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414215651.151228-1-julianbraha@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: vAlq02fFdxi_YWtHYl1Xsx4XagJwy3kf
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f218c1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8
 a=VWRJ8OvsUrwFCD2NXXAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: sk84tkLtboEhg_pmICZKMMGyG7ZtNDOW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0NSBTYWx0ZWRfX9lZWT0+bw8ko
 0ZzrRFDYhImlCI1xa5rhXJNaArupV2Ln0ouK81Faf4eKKLNkmTDrb/n5tyeZF1KDsGQULRzPABh
 o1ZTf70dyWMnR0Fk4RcAxORZr115VEFm6HR4E724INbkcpSbiI6mCwzm/NHhfGAKtRJiGE79lqx
 vhfq6plioAwlVI7guTEkZZDW6fmrLyU31PsFuzscAn18iGKtc607Z2j6xVGWh3vwsrMl0dvWLRB
 p22XBiVO3z4KpbHxVmwHzH/l0QcHRiUpKgUHSkTUwFZFT8/C46XmS4ilIKzx4T7t21l3aK+dqBS
 ux/0FJ7oTMSkE6euhCFwW1wY1cJqQJWnRrigt+yF25SJbAGIjXgvj0jTgEVP05Vp1a8G2FPRyLp
 V3XH4xt7Ju5QtUF8TUIvMVjDdoNUuo3aIc4t18VLWSetT5J33uMnigO2re0xvjEPSkXYJYgJRGw
 NflYn7omRcXye/jKcNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290145

On Tue, Apr 14, 2026 at 10:56:51PM +0100, Julian Braha wrote:
> These config options currently have unconditional defaults of 'n' from the
> def_tristate statement, which shadow the later default of
> 'KUNIT_ALL_TESTS', causing it to be dead code.
> 
> It looks to me like the commit 25d36a85c61b ("s390/test_unwind: convert to KUnit")
> added the KUNIT_ALL_TESTS default to S390_UNWIND_SELFTEST, but mistakenly
> didn't remove the previous 'n' default.
> 
> Then, the later commit 90c5318795ee ("s390/module: test loading modules with a lot of relocations")
> copied the Kconfig layout from S390_UNWIND_SELFTEST when adding the
> S390_MODULES_SANITY_TEST config option, without noticing the existing mistake.
> 
> This dead code was found by kconfirm, a static analysis tool for Kconfig.

This tool is still in development, right?

Anyway, I do not quite get what do you mean with the dead code.
Could you please elaborate?

> Fixes: 25d36a85c61b ("s390/test_unwind: convert to KUnit")
> Fixes: 90c5318795ee ("s390/module: test loading modules with a lot of relocations")
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>  arch/s390/Kconfig | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Thanks!

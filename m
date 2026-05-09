Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5414428642B;
	Sat,  9 May 2026 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778350341; cv=none; b=h65WQqRI7+WNIREiT3V+bE7vC9jylT1oJv7ZzwLA7su7SI0BCdtuQLg4KDRdOS/1dIA4wPYmq42dspTyik+mf32Y2tpi5zKQm0pGynlc1olNIUUaMJ7kMt/Sqmq9588gHvSDzZp4/dHeQgy6ETC48OeC5XP7EPTtUsKMEyVn+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778350341; c=relaxed/simple;
	bh=WYju95Cto+acvm/xY8NFBG9uSZJn9FLyizKaha0RnYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjfwKIwlnK4Qt2h65u82xPj9spHwLi9YJEZIRLMCXQU3tC3KKzXbSBtx/lQNlEdkVj7AhdFnAZ1ZRCr4GLs8zbbY6g63kKruCs+LefQirP8C2XKlMMWhUIXMa23ZcL6Wd6dI3kuFxwiyRZRncL2Dp74Bu5VMNwEfkAgPz6iWXEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=REmMKGGM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="REmMKGGM"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6493eFFx2774531;
	Sat, 9 May 2026 18:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=uPY9Lua31dXri9JtlyR3isBQX549l5
	pObTggaKqdGi0=; b=REmMKGGMCg5NiMv9YPVIFfyCwnA7cc2G8O29JnwOIjGotA
	IpCu3OBTdr/viALAbIBorLAcw4S4lRdreGqImCk2huoZPINAtgV44ZMqe+GFPZyw
	oGVU/D38sFAl9aZLRtiuH/VMtTUnVV74aEWH4adxCx+PHv/b3O+b+9AUaBMAqCFO
	qK8YtIMEaporgi4BmEprHst/amtrH48WqNFcus7/TQux9BcPlbgkxW0q7GMjUkoi
	8tMbfJ7BuW1uFuEnf0cFD4gHueCXiQSWXT1rZzcv3Kwn/XRbTQz55Zq5J0XgaG5y
	VrzuElrpTbr10LjM/hlkaD6ZNPGQvdlyXXAiRaQA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vju284t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 09 May 2026 18:10:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 649I9fYG009608;
	Sat, 9 May 2026 18:10:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yw73q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 09 May 2026 18:10:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 649IA2Ep61473186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 9 May 2026 18:10:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC34C20043;
	Sat,  9 May 2026 18:10:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93F8720040;
	Sat,  9 May 2026 18:10:00 +0000 (GMT)
Received: from osiris (unknown [9.111.50.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  9 May 2026 18:10:00 +0000 (GMT)
Date: Sat, 9 May 2026 20:09:59 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Boqun Feng <boqun@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Ada Couprie Diaz <ada.coupriediaz@arm.com>,
        Lyude Paul <lyude@redhat.com>, Sohil Mehta <sohil.mehta@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Xin Li (Intel)" <xin@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, Yury Norov <ynorov@nvidia.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arch@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 03/11] preempt: Introduce __preempt_count_{sub,
 add}_return()
Message-ID: <20260509180959.16281B62-hca@linux.ibm.com>
References: <20260508042111.24358-1-boqun@kernel.org>
 <20260508042111.24358-4-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508042111.24358-4-boqun@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=cYbiaHDM c=1 sm=1 tr=0 ts=69ff7880 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=bC-a23v3AAAA:8
 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=cJihAa_Hpov-29ePWn8A:9 a=CjuIK1q_8ugA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: XAP50UvRAKtnTxyEozsuA_cNnZj1tU7e
X-Proofpoint-ORIG-GUID: V1RKRVM_pGVbuPLBvXXFMmkEr5z1nOS_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDE5NyBTYWx0ZWRfX6t4uiKZ3eqcS
 D/FjactjMqXLpHyiInKgFhzcRaTJSHoT9lNKI7U5XANWkbFh+9qtssIYrji+Eif4f9s9vOWfe0d
 12WqM3EhhiwxNd0QE5y5DbWBI4TXRXYdAqQRSvJEb+BE6s4/qOo1mdMGCd1rfyHpImYC5Y7/vvo
 +UEr9kmXyoPO3vB3GQvnCSbVfLiWPIHsPAZnH5Wu1WLLyYQ97anB59/0bl2gPI6TuI4IowbByPz
 8du30VKWFSNZlsCRnN4VM8awQsiex3rnE6e8TsQuvfLleGWBE1BNsYZL1RSC9tXzOx/BpypZ5GM
 2ePg15k+JF0fkjfpfj1bcIpqKUm9Y1IYLWdDn4bVOkU7ppsAgEYk+L+VgNsXa0KewektiGKmBPN
 D+MFFtnyQzjqIHSd5kdV6DK8J5mFtpN9ODYu6b5sYKFhzGhhmLah3jgJwexKnzPlH93t50sUZYX
 AVAtXONKqxCMN7sMN5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_06,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090197

On Thu, May 07, 2026 at 09:21:03PM -0700, Boqun Feng wrote:
> From: Boqun Feng <boqun.feng@gmail.com>
> 
> In order to use preempt_count() to tracking the interrupt disable
> nesting level, __preempt_count_{add,sub}_return() are introduced, as
> their name suggest, these primitives return the new value of the
> preempt_count() after changing it. The following example shows the usage
> of it in local_interrupt_disable():
> 
> 	// increase the HARDIRQ_DISABLE bit
> 	new_count = __preempt_count_add_return(HARDIRQ_DISABLE_OFFSET);
> 
> 	// if it's the first-time increment, then disable the interrupt
> 	// at hardware level.
> 	if (new_count & HARDIRQ_DISABLE_MASK == HARDIRQ_DISABLE_OFFSET) {
> 		local_irq_save(flags);
> 		raw_cpu_write(local_interrupt_disable_state.flags, flags);
> 	}
> 
> Having these primitives will avoid a read of preempt_count() after
> changing preempt_count() on certain architectures.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun@kernel.org>
> Link: https://patch.msgid.link/20260121223933.1568682-4-lyude@redhat.com
> ---
>  arch/arm64/include/asm/preempt.h | 18 ++++++++++++++++++
>  arch/s390/include/asm/preempt.h  | 10 ++++++++++
>  arch/x86/include/asm/preempt.h   | 10 ++++++++++
>  include/asm-generic/preempt.h    | 14 ++++++++++++++
>  4 files changed, 52 insertions(+)

fwiw:
Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390

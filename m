Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7618343C05B;
	Mon, 13 Jul 2026 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961391; cv=none; b=rgIolARWtgNWGYy05D46h9/ZVXGaAac0cCHjMwcbabAjM/Qduihiwl8JU3gAgfB6AUoQplZcelnZuGBV7Tt/amHFh+duFdtqFse61Ve4FvAOJoomYSmo0hkRybCk1cDKimvmlJAlCzPfrXl3tEZnhz+x4nOY9SxdX5jgUXPReYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961391; c=relaxed/simple;
	bh=iBsLy9VMMlE2P+1xnzn7kzv590hlV+78bE+Uh3bXH8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gtuEzDRrWZgpjIYslbI4EBcMp+fHVKyMVFMsC9Urbq16o98IVPNZAZhqJCQRRR6PcRDwBoazAGtbo5iauopG/1OsDHBc3tBtFfEa2jZJKKhpP99JlZE2o7cBes6ex+WlmYNRnyKCB9SzAUH0eIFMflN29yt8EUJXUIE4ei5P1oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dATNxewf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dATNxewf"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DFEZvH2836434;
	Mon, 13 Jul 2026 16:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A+Hmim
	H2s1HAkSgAokpk+iJmU3+iLNnhSMTAZmUnv24=; b=dATNxewfjCQGKXJIS/MCM0
	QTbLLlxKGhSwOwXFcwj1LTf/sarWVEdoNe4J54bUjfmJCfgfqmjndvjyHAQarIw9
	IGcg3RZ3kMhE8Aax4Jf7ULuXgqxKvt8qArRqkuBfNX2aQg7bYR30L6tz3ssDaG/7
	Ci935S8ZKktDo8d/uRyjknkHr+sTSyKVmCCEvcDi8SJjKPf0JLs7mvYyfBEDF6Jk
	0uAVJ2YTkUWj0CintH8vPWJkw1Vrz+mpvW7KEhbiDrqNCYg1BCT3mVwuDaqezImH
	bzjTSiAEawiNGSPwPENBli1sWp5csJpgVUUjZYRamyYFrUdNPFZTCP2zvufuzw7g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepx9sj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 16:49:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DGYdxO030256;
	Mon, 13 Jul 2026 16:49:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uxxced-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 16:49:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DGnKLt16712004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 16:49:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 646B620043;
	Mon, 13 Jul 2026 16:49:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 585FE20040;
	Mon, 13 Jul 2026 16:49:18 +0000 (GMT)
Received: from p-imbrenda (unknown [9.87.153.197])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 13 Jul 2026 16:49:18 +0000 (GMT)
Date: Mon, 13 Jul 2026 18:38:29 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich
 <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Joey Gouly
 <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
        Nico Boehr
 <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch
 <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo
 Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand
 <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon
 <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v4 13/27] KVM: s390: Prepare KVM/s390 for a second KVM
 module
Message-ID: <20260713183829.63e570b2@p-imbrenda>
In-Reply-To: <20260706085229.979525-14-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
	<20260706085229.979525-14-seiden@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0jYii26hJDZei0ZDooDfsAPRucOj8cdX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE3MyBTYWx0ZWRfXw69rnLVWo3E4
 5PICwphPZ40aVci50nZ1eTgLri/ZuZgTAPUupH6a7IuYKwh8WxquEBRo6CTdaIfGtRLDLht4Ura
 30nqzUcyaeSOl1uJaT1mduXv7JmAKKo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE3MyBTYWx0ZWRfXxE1JTgVn45BN
 JNTRZG7vw3YykmBtc5HEf8FAJ2MFn5Iu3h/Lop0zkrDZUWx2Teqg6EEyueNiK7Uefyi0tNFNSXf
 x5T7Arpje2lMB4muAEY/hSHd7H4pQEiiuyNqIsdfolYEmsJ2Ue3GhW79GM1Z4kLEszS4IIjDlbi
 Xy6MJBkEDq7AAqMZ3S85uX0flz7PU+JcBEB3zZ9aAY/tePLz/dMLKgvy3lzWX8GXUAlEe1sjL4j
 OKCwjTuHUq5CX8cC/yBxS4EBJGegBxIifHVRtJ0VB145Ctxuyo+KdVfBV9Tje67jnV2auS6L9cf
 KySzy07y3npIC27i0w+/PP6KAtVR34RKa2KxPX7yg9mIuqibiYNd6ll8+d56X0A0Y8rsLLEaDot
 wwmXje+J2QmPY7DQI10ZXQMDuy/mIRABgQTWty02EczWVcvKA1Ac46JOE1dIT24PW0TNytau+gl
 hRHnv2oP/6nsFaBWtnw==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a551718 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=X1SsQTfnGOJPsq-MPYYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 0jYii26hJDZei0ZDooDfsAPRucOj8cdX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130173

On Mon,  6 Jul 2026 10:52:13 +0200
Steffen Eiden <seiden@linux.ibm.com> wrote:

> Lay the groundwork for a second KVM module. Guard KVM/s390 behind the
> KVM_S390 config and turn CONFIG_KVM on if selected. Move all the
> kvm_host definitions to _s390 postfixed headers. Prepare local header
> include guards for a new location. Move gamp related tracing into a
> separate file. While at it, rename the main KVM/s390 files from
> s390-kvm.{c,h} to just s390.{c,h} to match the naming scheme of other
> architectures.
> 
> No functional change.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  arch/s390/Kconfig                             |   2 +-
>  arch/s390/boot/ipl_parm.c                     |   2 +-
>  arch/s390/boot/uv.c                           |   2 +-
>  arch/s390/configs/debug_defconfig             |   2 +-
>  arch/s390/configs/defconfig                   |   2 +-
>  arch/s390/include/asm/kvm_host.h              | 774 +-----------------
>  .../asm/{kvm_host.h => kvm_host_s390.h}       |   6 +-
>  ...kvm_host_types.h => kvm_host_s390_types.h} |   6 +-

I really dislike those "almost renames". I'd prefer to have a prior
patch with the differences, and a second patch for the move.

>  arch/s390/include/asm/kvm_host_types.h        | 347 +-------
>  arch/s390/kernel/early.c                      |   2 +-
>  arch/s390/kernel/entry.S                      |  10 +-
>  arch/s390/kernel/perf_event.c                 |   2 +-
>  arch/s390/kvm/Kconfig                         |  10 +-
>  arch/s390/kvm/Makefile                        |   2 +-
>  arch/s390/kvm/dat.h                           |   6 +-
>  arch/s390/kvm/diag.c                          |   2 +-
>  arch/s390/kvm/faultin.c                       |   3 +-
>  arch/s390/kvm/faultin.h                       |   6 +-
>  arch/s390/kvm/gaccess.c                       |   2 +-
>  arch/s390/kvm/gaccess.h                       |   2 +-
>  arch/s390/kvm/gmap.c                          |   2 +-
>  arch/s390/kvm/gmap.h                          |   6 +-
>  arch/s390/kvm/guestdbg.c                      |   2 +-
>  arch/s390/kvm/intercept.c                     |   2 +-
>  arch/s390/kvm/interrupt.c                     |   2 +-
>  arch/s390/kvm/pci.c                           |   2 +-
>  arch/s390/kvm/priv.c                          |   2 +-
>  arch/s390/kvm/pv.c                            |   2 +-
>  arch/s390/kvm/{kvm-s390.c => s390.c}          |   2 +-
>  arch/s390/kvm/{kvm-s390.h => s390.h}          |   2 +-
>  arch/s390/kvm/sigp.c                          |   2 +-
>  arch/s390/kvm/trace-gmap.h                    |  45 +
>  arch/s390/kvm/trace.h                         |  14 -
>  arch/s390/kvm/vsie.c                          |   2 +-
>  include/linux/kvm_host.h                      |   2 +-
>  35 files changed, 103 insertions(+), 1176 deletions(-)

[...]

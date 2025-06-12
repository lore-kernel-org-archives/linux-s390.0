Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F5B2F4326
	for <linux-s390@vger.kernel.org>; Thu, 12 Jun 2025 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728520; cv=none; b=RENas4NAcSUOZgR4dlMjPOpmKemKyXyyFce43jFrsVl6ZW0MRZu8UURpSeVLe4hUo7g1GN/BFSSza4XiZfClvFyhZUrBPhJ8et4ym36zFGCrUhl5J1hnVEIBjPXryu2XG9On4EabrcwstL/EzKjVdJNRUD/QvmrnxpvpauYjhzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728520; c=relaxed/simple;
	bh=GvulJumOdktSaNDO1aWp3R2seFvL5sYkaqaLp5e1TDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q99XC4Vs7PawQI8IHhuxg+B64A0K/S1G/TEFcqpIWQHLHJOJZ6q4XiAQwY/PSzWlzwnXl2Wk6dJXguF366ECtiSlm0sEZi0tiff8KUG7n9kqR8sD8uAIiZ/mZAHAEqlmKssfUsguRgIxQHz5ZVNDzn8WN50GGSmGtpkPVrbp8Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rvgQrZE2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rvgQrZE2"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C2mcPq027868;
	Thu, 12 Jun 2025 11:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=DmqTXyKkn1YMewgZBr1MG2u83W8UuS
	0DIsUAssp/jWg=; b=rvgQrZE2o3v37kWj0ePLbpRuJdSl1ka07ORV1+yZO1TVhT
	Cok8cxRM2W2W8Y15GQix2jzgCuZ+YoIuSt4VolThHaziA5g4fCFvYdP96Yya8lOi
	bXIi894fFIyZBzatn7gZtpqqcVF1suenQltl/nBSr7VX1y/KZ8R5uewWLrIBEECX
	Z9B6l9BMnWJ1VLoPgFUoXtZu8I3ejUyeBGWmOFd4Hgaox4GFwwCPRxh2KLe/zJQd
	ULA+mmLrvNEidQG8VHlUvBHP6+M42NjQ0maOMN+svEsWA6S63XF2lowhQuWri6b1
	Eg5LHZUchLOizlY4NwfH5c+Un7lo1e3ypSE7ZMiA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hgusgpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 11:41:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55CAJgam014908;
	Thu, 12 Jun 2025 11:41:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rpchmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 11:41:55 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55CBfpNC60031258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 11:41:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B69C820043;
	Thu, 12 Jun 2025 11:41:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8181120040;
	Thu, 12 Jun 2025 11:41:51 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Jun 2025 11:41:51 +0000 (GMT)
Date: Thu, 12 Jun 2025 13:41:50 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3 0/2] s390: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 uapi headers
Message-ID: <aEq8/i2/oxR1ZFSo@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250611140046.137739-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611140046.137739-1-thuth@redhat.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Pfr/hjhd c=1 sm=1 tr=0 ts=684abd04 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=uPZiAMpXAAAA:8 a=RF00TdSWAAAA:8 a=NEAV23lmAAAA:8
 a=20KFwNOVAAAA:8 a=l_7QOALr140YUegvhxQA:9 a=CjuIK1q_8ugA:10 a=xRwLF-0IvUIA:10 a=_nx8FpPT0le-2JWwMI5O:22
X-Proofpoint-GUID: _yHYzivuspKdgYZ_OWSxYAvv2fnx9Wjx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA4NiBTYWx0ZWRfXwfELe10JqzvU riLzDXqqeMlLG3eRP8Hg1yu8w4mnmsR655JF65CGaAV38xG+MypiEd/gdAADFrlLuOJyvBCvMSm 00wbPRwrY9N/n0h3CIa9ZMUd/XMRpgyl31dckIbuAKcdWhkh2oeRTSf6ptISO9ntTFCudjRx9E6
 3LJ3yLFGquytDKztPjhIdfFt5knaFGC96KdieLJlW3Dp6gM6IOpTNKkLCWd+/AeCMQIClMJfgv4 oN4Qc3K0cpaKs0RhAXx16aWIfUU7GNZ+2wGQSgLeQMqFOdmieDbpsGzymaCL6fA+15/DGyWDg8D LWz9iOM/XwdDVXiGDhrD6Y3i3q8fjQqDgANu+IzHwtvTjQXT48i335wZs2lV4zGkRP5qe4wtcCu
 7/GKisRXV6y2hbju83Jgxk16Phb3ZGP758ycPO0VPOl/mm+zuuQz0u2yhUcp7Qok/PwHoUc1
X-Proofpoint-ORIG-GUID: _yHYzivuspKdgYZ_OWSxYAvv2fnx9Wjx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506120086

On Wed, Jun 11, 2025 at 04:00:44PM +0200, Thomas Huth wrote:
> The kernel Makefiles define the __ASSEMBLY__ macro to provide
> a way to use headers in both, assembler and C source code.
> However, all the supported versions of the GCC and Clang compilers
> also define the macro __ASSEMBLER__ automatically already when compiling
> assembly code, so some kernel headers are using __ASSEMBLER__ instead.
> With regards to userspace code, this seems also to be constant source
> of confusion, see for example these links here:
> 
>  https://lore.kernel.org/kvm/20250222014526.2302653-1-seanjc@google.com/
>  https://stackoverflow.com/questions/28924355/gcc-assembler-preprocessor-not-compatible-with-standard-headers
>  https://forums.raspberrypi.com/viewtopic.php?p=1652944#p1653834
>  https://github.com/riscv-software-src/opensbi/issues/199
> 
> To avoid confusion in the future, it would make sense to standardize
> on the macro that gets defined by the compiler, so this patch series
> changes all occurances of __ASSEMBLY__ into __ASSEMBLER__.
> 
> I split the patches per architecture to ease the review, and I also
> split the uapi headers from the normal ones in case we decide that
> uapi needs to be treated differently from the normal headers here.
> 
> The x86, parisc and sh patches already got merged via their specific
> architecture tree:
> 
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=24a295e4ef1ca8
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8a141be3233af7
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cccaea1d66e94b
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e2b6a188625a2b
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9cc646950eefda
> 
> So I assume the s390 patches should go via the s390 tree.
> 
> v3:
> - Split the s390 patches from the global series
>   (see https://lore.kernel.org/all/20250314071013.1575167-1-thuth@redhat.com/)
> - Rebased the patches on linux-next and fixed the conflicts
>   and new occurances of __ASSEMBLY__
> 
> Thomas Huth (2):
>   s390: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
>   s390: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
> 
>  arch/s390/boot/boot.h                  | 4 ++--
>  arch/s390/include/asm/alternative.h    | 6 +++---
>  arch/s390/include/asm/asm-const.h      | 2 +-
>  arch/s390/include/asm/cpu.h            | 4 ++--
>  arch/s390/include/asm/cpu_mf-insn.h    | 4 ++--
>  arch/s390/include/asm/ctlreg.h         | 4 ++--
>  arch/s390/include/asm/dwarf.h          | 4 ++--
>  arch/s390/include/asm/extmem.h         | 2 +-
>  arch/s390/include/asm/fpu-insn-asm.h   | 4 ++--
>  arch/s390/include/asm/fpu-insn.h       | 4 ++--
>  arch/s390/include/asm/ftrace.h         | 4 ++--
>  arch/s390/include/asm/irq.h            | 4 ++--
>  arch/s390/include/asm/jump_label.h     | 4 ++--
>  arch/s390/include/asm/lowcore.h        | 6 +++---
>  arch/s390/include/asm/machine.h        | 4 ++--
>  arch/s390/include/asm/mem_encrypt.h    | 4 ++--
>  arch/s390/include/asm/nmi.h            | 4 ++--
>  arch/s390/include/asm/nospec-branch.h  | 4 ++--
>  arch/s390/include/asm/nospec-insn.h    | 4 ++--
>  arch/s390/include/asm/page.h           | 4 ++--
>  arch/s390/include/asm/processor.h      | 4 ++--
>  arch/s390/include/asm/ptrace.h         | 4 ++--
>  arch/s390/include/asm/purgatory.h      | 4 ++--
>  arch/s390/include/asm/sclp.h           | 4 ++--
>  arch/s390/include/asm/setup.h          | 4 ++--
>  arch/s390/include/asm/sigp.h           | 4 ++--
>  arch/s390/include/asm/thread_info.h    | 2 +-
>  arch/s390/include/asm/tpi.h            | 4 ++--
>  arch/s390/include/asm/types.h          | 4 ++--
>  arch/s390/include/asm/vdso.h           | 4 ++--
>  arch/s390/include/asm/vdso/getrandom.h | 4 ++--
>  arch/s390/include/asm/vdso/vsyscall.h  | 4 ++--
>  arch/s390/include/uapi/asm/ptrace.h    | 5 +++--
>  arch/s390/include/uapi/asm/schid.h     | 4 ++--
>  arch/s390/include/uapi/asm/types.h     | 4 ++--
>  arch/s390/net/bpf_jit.h                | 4 ++--
>  36 files changed, 72 insertions(+), 71 deletions(-)

Applied, thanks!

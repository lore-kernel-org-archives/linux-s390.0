Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE7F3C553A;
	Thu,  2 Jul 2026 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980045; cv=none; b=dTRg7bP81RcyIJzQbPUHx/Jpu+Q0dU1EgAsQzVjDcKZT7h676/UCsNaZu9ZXU15g4sKfKnrX8+zouFNewkPagRwDFBmEucGR7hFz/JC+UPMOVWPQIdWRJwCxGEo2CB5uwO9Cg06O+28B4hB7XMyqV5a5ksdLmfmOIovB0SPOc8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980045; c=relaxed/simple;
	bh=hqCLUVUGlo7JiPK9HmHjC+v213ae/U7iW09vTUMaQAg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k8sR0TwivVJ32cuXQbhOjJmlPQAtHRDz5MPBkf/Z7a0WpCS6yVoEvAE6Zbkk9p/ssVQYm7DswaBWUx0cklvSqFT9lVNhjQQ/i51i3eYYJ68DFyO6GV0Gl7fgwBElbb+lNOZJWKVYQlneab9DRS6aPq66zDEkajChsYpempaKyGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pZK8TbTJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pZK8TbTJ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621KlGo2509852;
	Thu, 2 Jul 2026 08:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hqCLUV
	UGlo7JiPK9HmHjC+v213ae/U7iW09vTUMaQAg=; b=pZK8TbTJnNMAyZxjXBKemz
	WG95jwJ+gE68MwV5sSXtJd4BF5pREzpXbDk24iP/dPZpCrj+6o23XVWuWs+IAErT
	BbHfEuYE7GaSRUt7JZO2upuMd8p7Q3sOwF/X9o9jSOIZE5T+fPCCzCFNSW8Xe46S
	32wY8T03xrM5wqOEaF50gohxKSBymr4TWcd815Mm4QBvbcGQl/LZZ71WNEgVhWQ4
	Bb0xSU+IZisDQ6y8SqNyIweWlkpNOiPMVRMU0HJvrwLCKuyK5gwIrMKa6TrITK72
	04L3zVt3tzqIZh2FJIZl8F+aPVcpgj53SwloGZ6OyHO0JcrkF81IrZ/Fh3NptQ4w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe8wrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 08:12:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662855Gj005192;
	Thu, 2 Jul 2026 08:12:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gjxrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 08:12:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6628CaKk47186188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jul 2026 08:12:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C63F20043;
	Thu,  2 Jul 2026 08:12:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9CE120040;
	Thu,  2 Jul 2026 08:12:35 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  2 Jul 2026 08:12:35 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Jonathan Corbet
 <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Madhavan
 Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andy Lutomirski
 <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin"
 <hpa@zytor.com>,
        Andrew Donnellan <andrew+kernel@donnellan.id.au>,
        Mark
 Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Jiaxun
 Yang <jiaxun.yang@flygoat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mukesh Kumar Chaurasiya
 <mkchauras@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, Zong
 Li <zong.li@sifive.com>,
        Nam Cao <namcao@linutronix.de>, Deepak Gupta
 <debug@rivosinc.com>,
        Lukas Gerlach <lukas.gerlach@cispa.de>,
        Rui Qi
 <qirui.001@bytedance.com>, Kees Cook <kees@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [RFC] entry: Untangle the return value of
 syscall_enter_from_user_mode from syscall NR
In-Reply-To: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
Date: Thu, 02 Jul 2026 10:12:35 +0200
Message-ID: <yt9dechlbyj0.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: DKlldyY4bhkCnlcbefPy2HU56VqtiBGr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA3OSBTYWx0ZWRfXyOQuthEL9my+
 L3goQ8RSe3aEKWelY2bJXttBAFwFZ3nxAMd4YsPCcEXn38MypvsePfJ6K0Xa0t/CkI83BjCtnVw
 m6hD2NKtpMS8QTJ1dKDLehpY3uSIRHk=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a461d79 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=H7Grb0cKppj6FskhoBQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA3OSBTYWx0ZWRfX/oe4D2SHEsm8
 fnh8Zogh7aWRM7RCWhvCxl9KxCazzx0GZhXpTwQ6IVs2rk1Lht0I2Pw7XYWwx94bCT3Ez7rq8Dg
 lg8HV4ioS+8K8e2rqvVEnOYfMVPDiJZERcROKpg9FVgHynbSsV/0kzAosEQ+xeI4rV2SVE0ldfP
 T/9tPCQSRrH3OFOXXIOJF8xBBCWy/L2bfBCsah4ga0qm4ebPbs3ZjFLYIwziTnpFKZxHXHmd98N
 MYh5DqQ2fp7GI0HPArVfNFgaDdDflOraiPWOnzhqFhPDp2lG56c8K0xzWRL3jW6kUeiDKuXG+Nk
 YxA5p0vWRe8IkAgAj8cQkTfxSxUnmjY99x2Cj4BgrgbekYiNXkLROH5O2zrOMUrrb+POiYKlvOZ
 HnQMDbLmGSoz9dPTQu7oFDFNks2D4/MlmtTaw+2HyBz8naZWPeeOO6fVfljQpTQ/9wmpAyeBa30
 MxGwR6nRsgmgvSeCamw==
X-Proofpoint-ORIG-GUID: BbxRzj5OULkjMR0AZe7xHLImpWA5FvbD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020079

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

> The return value of syscall_enter_from_user_mode is used both for the
> adjusted syscall number and the indicator that a syscall should be
> skipped.
>
> As seccomp can be invoked on any syscall, including invalid ones this
> somewhat undermines seccomp.
>
> While the seccomp variants that terminate the process do not need to
> care about this for the filter that sets the syscall return value this
> disctinction is required.
>
> Pass the syscall number as a pointer to the inline entry functions, and
> use the return value exclusively for the indication that the syscall is
> already handled.
>
> This should avoid the need for the s390 PIF_SYSCALL_RET_SET which is the
> workaround for exactly this deficiency.

I'm not sure whether PIF_SYSCALL_RET_SET can be removed - the syscall
return might still get set by PTRACE_SET_SYSCALL_INFO when the tracee is
stopped. This might be a positive number which can't be distinguished
from a syscall number. But maybe i'm missing something? It's been quite
a while since I touched all that ptrace stuff.

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA2B1A6816;
	Fri,  3 Jul 2026 06:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059499; cv=none; b=NyWK74lZyJ45dAyPpM1jxREwGqT50TvgNmRyEUPNY6C+4phWCdFh4qk/eWnqMKlPCvssvSEhkxof06vVesfm1L2av3TjcYbAoloYgl61zprAHDqOIFA9GnT9W5Mz3eb1jl6QHNI4gjZvmLIRdYSJ9OH2SdktDkUqI0boHVkh+vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059499; c=relaxed/simple;
	bh=8pXveFmOOYSvyOo7QlW8sZ/yXA5rWNTgbkeIn+ezbyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fpq56iuHroeHLN3/Qh8HDZl6RGp+mcT/GHB7Mj7l1obIeEJN6CvNV1BPvkXd8q/lork+0cOCMqwdgW7FHQidjibftmlOzLyc/D6wVBtuec99qdTiW6W8PtXaxQVKzpawJ2JrgCpZWHGZPf+qes5BQ4q7SWQ3g8erMNvksTn905c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r7spRylS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r7spRylS"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6631IwIc1453346;
	Fri, 3 Jul 2026 06:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8pXveF
	mOOYSvyOo7QlW8sZ/yXA5rWNTgbkeIn+ezbyk=; b=r7spRylSayBaz3CBk1bvvu
	BT4KLKfrwrUU4X0hCFFldC8JyUkP1gZ+yTJQS0XAZgoDUQyT8kQsl2NN9RE+BnDp
	0Ur6gx8fKbE3nkhZnFikv0RHahFRjLZcfzpE03i1YiXm4+LzPdw+N3073CF0WKUr
	wxfQurwfnIIzFAfa474Nrqmd/Vt/icWU6UlN5SLFu/uVN6Kbr2fvufT3SNpJt7wC
	N/TRAbYtxSKETqKlFQZFcMAJWRrrEFbEF38fPnD0eUrC5144VVfDppMII8nqJLre
	80fakqbbLcZv6OeewdU95Q37nlRIp6AFiX1Dhh07/z8RmPuMx3Xeej32A8FXRYtg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qgdpy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 06:17:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66364u8k021419;
	Fri, 3 Jul 2026 06:17:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqqraa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 06:17:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6636GvOd23724404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 06:16:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E084220040;
	Fri,  3 Jul 2026 06:16:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DC3D20043;
	Fri,  3 Jul 2026 06:16:56 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  3 Jul 2026 06:16:56 +0000 (GMT)
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
In-Reply-To: <akZV7kjVh37z63Nz@kunlun.suse.cz>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz> <yt9dechlbyj0.fsf@linux.ibm.com>
	<akYreY_BHuRbxSsO@kunlun.suse.cz> <yt9d5x2xbny9.fsf@linux.ibm.com>
	<akZV7kjVh37z63Nz@kunlun.suse.cz>
Date: Fri, 03 Jul 2026 08:16:56 +0200
Message-ID: <yt9d1pdkbns7.fsf@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a4753de cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=PxzjjWZHAImlhUGC5A8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA1MiBTYWx0ZWRfX3KioJ0aE0IJK
 6GCXJHhUp1F2Z1YveNR5roy+VlB9mYaqqPi6ZnW5aiC5GW26VV2+HS77GgwsK/LiTuT7b05HLTJ
 7bqNBO0gAyrISbMT0IKHCUvnIc+Bc/c=
X-Proofpoint-GUID: MZHualSITsNhKNRwX3VbQpZ3GLr3BMiU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA1MiBTYWx0ZWRfX1xdOF6m0TbsV
 RRdovO7OWz9x9ZJwMBitj+Ms2sSe6kn4owwgid7NsQ+hw6RMIxUbpMSid4pQ0mJnsYrCDGpBWuN
 ettr7U4yik8mEnZt/EICOdu8qFM5H9i+b35dllBVZzrNmsQ0B2SVeUuCOeJ8TraSiMkYJUJO+Nc
 BJnyRM01Jj4QXANp0Io9tTz6Hj1vAd7lh+mkuzGmIJAfH0VdAS260qxw2YxoCTBvcir1LIuYlPw
 LOfBvQ9Z5gu2kgM3zQKXqocxBvBylQvTG6K1R0ZF5Oy59AM0zBTpy13iio6Fdsb3nIFuT345/oZ
 uzPcE5TicueH+0AQBY6ur7FPfScbrnIFQO95r+GaiM+KZ/cE3mSboUBKGGWCtZHTxfM/3ubcCX4
 lKnp6tSsvLMOKZt/p9bvHcVJ7wXQ4gz33Og1uvgzaO9B74gsTFQTPb0/f/1a5u1GN5Ijss+/Nej
 V3bAm3cpL0fOCvtJW1g==
X-Proofpoint-ORIG-GUID: UKYrWbQA3xg_QgCJ6b-fW3NtJr_lLQLl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030052

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

> On Thu, Jul 02, 2026 at 02:01:02PM +0200, Sven Schnelle wrote:
>> Michal Such=C3=A1nek <msuchanek@suse.de> writes:
>>=20
>> > On Thu, Jul 02, 2026 at 10:12:35AM +0200, Sven Schnelle wrote:
>> >> Michal Such=C3=A1nek <msuchanek@suse.de> writes:
>> >>=20
>> >> > The return value of syscall_enter_from_user_mode is used both for t=
he
>> >> > adjusted syscall number and the indicator that a syscall should be
>> >> > skipped.
>> >> >
>> >> > As seccomp can be invoked on any syscall, including invalid ones th=
is
>> >> > somewhat undermines seccomp.
>> >> >
>> >> > While the seccomp variants that terminate the process do not need to
>> >> > care about this for the filter that sets the syscall return value t=
his
>> >> > disctinction is required.
>> >> >
>> >> > Pass the syscall number as a pointer to the inline entry functions,=
 and
>> >> > use the return value exclusively for the indication that the syscal=
l is
>> >> > already handled.
>> >> >
>> >> > This should avoid the need for the s390 PIF_SYSCALL_RET_SET which i=
s the
>> >> > workaround for exactly this deficiency.
>> >>=20
>> >> I'm not sure whether PIF_SYSCALL_RET_SET can be removed - the syscall
>> >> return might still get set by PTRACE_SET_SYSCALL_INFO when the tracee=
 is
>> >> stopped. This might be a positive number which can't be distinguished
>> >> from a syscall number. But maybe i'm missing something? It's been qui=
te
>> >> a while since I touched all that ptrace stuff.
>> >
>> > When the syscall return value is set (in the registers) the return val=
ue
>> > which is also the modified syscall number is set to -1 indicating the
>> > syscall was handled. At least that's how the API is described.
>> >
>> > So yes, if the syscall number range is restricted or the syscall number
>> > is returned through a path different from the function return value the
>> > flag should not be needed in the entry path because the case can be
>> > detected through the return value alone.
>>=20
>> I'm still failing to see how this would work without an additional
>> flag. Assume a program (the tracee) is stopped because of a syscall
>> entry. The tracer then decides to skip the syscall and changes
>> regs->gpr2 (which contains either the syscall number or return value)
>> to contain 42. When the tracer than restarts the syscall, how does
>> do_syscall() know that gpr2 is now a return value and not a syscall numb=
er?
>
> Because then the return value from the syscall_enter_from_user_mode
> machinery would be -1 indicating the syscall should be skipped. That is
> how the return value of syscall_enter_from_user_mode is documented, I
> did not verify that it actually works that way for the tracing case on
> s390.

I read the code and tested - I think I confused the way how syscall are
intercepted by seccomp vs. ptrace. The PIF_SYSCALL_RET_SET is indeed
only required to indicate syscalls skipped via seccomp and not ptrace.

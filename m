Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6023B14AD;
	Fri,  3 Jul 2026 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783072843; cv=none; b=FAQ/PmSlTecCMYeuN9aNgYZjU+nElnYYpKkuCwKNiLdro/KAcpwujxuCB4Hkf+GZGOSwvoO3q+AjUWMZcsX0WB1E4MvDxLAR3h5JQs55az2xcpDnw6XBoMlOLRvN+lzAtwYiai1lz9CGG4PC5Mwd9CnP43cuSLIZff3hDZdqKc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783072843; c=relaxed/simple;
	bh=XkZRwCRa2XhLgna4NJMGvoHXqep1IUGIjBvB5bpJuls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HHrNUGF7EMkSPia7vZ1b1TWrBcumfIHM2BAU9lvgggZCToxgl/ES6pd1qZLVdpf8g233oEM9zq2/tcOvkiZ8Lyd2ianCiBZ4jfBBo06d/FWhv9G+5L1yxbSO2OrPhu+3znsTVB5aTH6vnQG2rnqm6vyRdnNc7RWhjCKe4t/blAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sNzsJBSJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sNzsJBSJ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636JW2R1762888;
	Fri, 3 Jul 2026 09:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=XkZRwCRa2XhLgna4NJMGvoHXqep1IU
	GIjBvB5bpJuls=; b=sNzsJBSJE0At5moOOpohmVjQzetUDhecbWJtU/m6Bze7zq
	z+RrCESoaCZmvBe++NZ1sOGEfWnxfJFd31TdIHLW/TxZO1nxuCSC7zqBofLiGUt7
	eY9t51b8vVsYwVu5zi2pHQUeRg0uooWAhwfH64a1V1CSxYVhEITXRkMoPZEwgKSI
	3LVExr7ylz5KDKZQJyFauWLV26RwjqkUwgElPJxZqNL7sPGCYZ/QkjXnAHGLxz2o
	AadgZh2Nx47mH+l9cfY2Puqix6XBXJPgRDm4gypdKviCzsIDlio9B6EBH2jOZ53r
	LP9GtE8SPV4qoBaQhkyE3iSOH/EoHLMhgyTUpSpQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk63uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 09:59:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6639na9h008970;
	Fri, 3 Jul 2026 09:59:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7wgamb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 09:59:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6639x8AG50135304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 09:59:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB02320043;
	Fri,  3 Jul 2026 09:59:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 419EF20040;
	Fri,  3 Jul 2026 09:59:08 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  3 Jul 2026 09:59:08 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
 <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov
 <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
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
In-Reply-To: <87ldbsmnie.ffs@fw13>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
	<BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com> <87h5mhnjsr.ffs@fw13>
	<yt9dwlvca8rn.fsf@linux.ibm.com> <87ldbsmnie.ffs@fw13>
Date: Fri, 03 Jul 2026 11:59:07 +0200
Message-ID: <yt9d5x2w5r84.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA5NCBTYWx0ZWRfX9FMLwetAf5KQ
 ndfxMBLSR49ue71Xv2NR40Icekc2MOvRbwixUqeEGtjdNkCalSSoGb966whocZ1gXXqpEriij7i
 lynNNC3vb2CQvMQydbLaS3VAu0jrXMOm+jrv0ORIZSdXnj7Vi1yorOQLGdSZSAOdWCDMFX3r3pN
 OuxRPVsNiZ9CQ3hGPyW9d4jjGhtQEH4JbcTwHIUqcZ7kznMyp1iLXVpiAu42PsAq9HSVzRZ1xeF
 OvamAeXQ82LGybWvpxvCiyLv5wDWgXgkKO8Hf7eaiVVVSAu3moZrspj1/CUqHGOp0ZISuFiCOfm
 6AWwmNs4Kr04L5enCaF4YgWYGrYLmt6j4D8H0M1WcGM1ayQeiM6Yok1G5GskscCRoSEIeV8DpbU
 tkC4ar4pU/D2r9uqicbUF56hge/NSmTFC3OSbbHRYF3sz6B3Za9sH3Juh93DjTwWc9D28Pc5hiX
 1sXDVTwSc86kcB2B9Rg==
X-Proofpoint-GUID: fyPeOXFOcSecTLM12SqKB2NhFn9No9dY
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a4787f2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=QZGpZFnrDBDqr2p2_-4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA5NCBTYWx0ZWRfXw6X4LK9BAJr/
 jeW91FBp5LTSjcZFRxjPIFSbzH40kzNpBhFPHP3F9N4dLBEIibxelkNLlh5TXnBBP24GksYOxGs
 cdYngkRwuJr0O4yJ1YvQBiRfSdFRCMk=
X-Proofpoint-ORIG-GUID: Zheb6wdsp5g_GwqVLO_LBTgHraVWDNxT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030094

Thomas Gleixner <tglx@kernel.org> writes:

> On Fri, Jul 03 2026 at 08:26, Sven Schnelle wrote:
>> Thomas Gleixner <tglx@kernel.org> writes:
>>> It's less than obvious and I have no objections to clean that up and
>>> make it more intuitive, but I still fail to see what Michal is actually
>>> trying to solve and what the magic flag is for. If s390 requires it,
>>> then that's an s390 problem, but definitely x86 does not.
>>
>> The difference between x86 and s390 is that on s390, regs->gprs[2] is
>> used for both the syscall number and the syscall return value.
>> That was a design mistake early in the begin about 25 years ago, but
>> it's ABI now, so it cannot be changed.
>
> Cute.
>
>> When seccomp decides to skip a syscall, it write a return value into
>> regs->gprs[2]. When syscall_enter_from_user_mode_work() returns, it
>> returns this number. If it's negative all is good - the 'if (likely(nr <
>> NR_syscalls))' conditiion would just catch it and skip the syscall.
>>
>> But if it's a positive number, the code cannot distinguish whether
>> that's a return value or a syscall number.
>>
>> So I introduced PIF_SYSCALL_RET_SET when converting s390 to generic
>> entry. This flag tells the syscall code that a return value was set in
>> ptregs and the syscall should be skipped.
>
> You also could have added a 'syscall_ret' member to pt_regs, operate
> on that for the return values (seccomp, syscall...) and swap it into
> gprs[2] right before returning to user space.

That would likely also work, but I found it easier to read and
understand to have an additional flag with a descriptive name than having
yet another 'somehow-related-to-gpr2' member in ptregs.

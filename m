Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984A83C4B93;
	Fri,  3 Jul 2026 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078819; cv=none; b=bZzwBKI0oEKphtupddSIrGywxXo4Ew5MxaFpuGGiPru98ChyhhgyLWf8JxswlMgFO/6UVXdP1M9REp/AmsZVblIMsPxoE5Trcm/yBz3nmh6VIuKtPXYxfWqLuxraxrlgk96FTMFkry5jx/0PLHT5N82Y4LkB7tRw1PczRK/VuwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078819; c=relaxed/simple;
	bh=oF3oIUV+LKz0emUew5qxSHFBM4G51YQMA7zouIB8abk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y7hpGEQBdk5RpPFQOG9XvtoxBdqnX2ZvE02oyxGpS2vVrqu6h9nQIq4fO9FdtNO4dKSgVW+auFpyWSJXC1H34YsQWhiDB4b6VU1BFdmBnMjkxgDz+8zsKsnZingqluO69/qxpMCiOojU1Hgp9BUB6l7vutY/fMITExiqAciZMLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VXVUBoyp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VXVUBoyp"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636ITbX1761163;
	Fri, 3 Jul 2026 11:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oF3oIU
	V+LKz0emUew5qxSHFBM4G51YQMA7zouIB8abk=; b=VXVUBoyppp/UHI5Y4PknK/
	64pw1LEU//x+soMgCRCdX4EdRm1zU4BCz8O9WW4oNRLNu5JhDcy4EBLyBm/6FrOQ
	hqGOcwUP7gl/7Sj9txOvVGDP8jQ9qbjCNjUToJILQOuNpLHDRC8DEuwqJjn5Bsbk
	jf3l63BG5cKpkTLnfzlDDlALQjJJoBf+gKHNlL4ClS0BXrHUc4dnXahOQIQvzOE2
	RnjFerav6HoB22z55ZqFWCNMvqeWu1Ub2Lv9DtcEBi0qc+6pcdgn8D9isf+11H2I
	9r8JlXCZvNiYvmLVs1eyz9jM/CbzeXd+fEHg62Ub1+lS6+670BWFEDmq6/u/L6Ow
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk6hfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 11:39:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663BYsLL011332;
	Fri, 3 Jul 2026 11:39:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2grf4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 11:39:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 663BdJ1R49021346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 11:39:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45EAF20040;
	Fri,  3 Jul 2026 11:39:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC89120043;
	Fri,  3 Jul 2026 11:39:18 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  3 Jul 2026 11:39:18 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet
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
In-Reply-To: <akecJWAJP-e5CYP_@kunlun.suse.cz>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
	<BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com> <87h5mhnjsr.ffs@fw13>
	<yt9dwlvca8rn.fsf@linux.ibm.com> <87ldbsmnie.ffs@fw13>
	<yt9d5x2w5r84.fsf@linux.ibm.com>
	<20260703105718.GO751831@noisy.programming.kicks-ass.net>
	<akecJWAJP-e5CYP_@kunlun.suse.cz>
Date: Fri, 03 Jul 2026 13:39:18 +0200
Message-ID: <yt9dtsqg480p.fsf@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDExMCBTYWx0ZWRfX9A1mR90iQ9fU
 Jnq5F39WZRpZmJZJo+YsMXBKsZBl5gTM0jj9mCML5R/Bd24LYkLFgakI/FJBKEk/4h15P+huPhT
 Qt4x0X5evHrib3jUNImZ7xP5zALzpi3mdHxCzHrZiWHfDxHBlxixkSy9cDZPp/nTWVn344jkMMG
 O12i1eIjoY94y3kSaaPRuWeqICdkdOzFC9qN9cXcDbd4yx6KKWE4d1phTqPs9FLJ4FlkNJ8+4fa
 /LYyk6rTIsgzLZV9WgaObJlQoHbWw7lz4c+lbe8M9Y7kkveYms1BJh6DmtlzccJMJ25zlPyUfZ8
 JmMUjXhd8ewPBbHid4BGyyAMEeqTyK6ykKlCepPfXv4InKeRsqJriegDf9oxa/3VabPxqAi+ZDP
 fSV0sApuWT7vTMVqvinurA0q0Phf9Nlh1Md0MKTtLGwkyMUTXh+Ps6RpfCKXyu2yzYMrNM67vWx
 yRdPu407r0ZBuNDOK9g==
X-Proofpoint-GUID: 0UewXK-tXcTk8FWkyPWn8VMN9H9juXe0
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a479f6c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=7COA2AqOHvKb0wdBt1EA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDExMCBTYWx0ZWRfX+Zctx0ZJQz6V
 Vq7aSPRPQpmK2s8ZW9Ab8ojRDqpVU5I5jpBSa8I4jJz5wtRMPZX84BaKOeHe7JCg0Z84TaNiznM
 cYzIAWu4Lm8wE8gWWhsc6/49iUcKYqo=
X-Proofpoint-ORIG-GUID: XUA9fyTmm3_KCsdJOv0Gf6JjV0mivGPV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030110

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

> The same could be asked of syscall_enter_from_user_mode. I find it very
> odd. Why does it conflate the syscall number with its return value?
>
> It never uses the syscall number passed in except when returning it
> unchanged. When it pokes the registers it reads the syscall number from
> them.
>
> If the caller of syscall_enter_from_user_mode only read the syscall
> number from the registers when syscall_enter_from_user_mode returns and
> indicates the syscall should be still executed this whole shenigan would

I agree. The fact that if (nr < NR_syscall) just works because -1 gets
casted to 0xffffffff and is therefore out of bounds is very odd.

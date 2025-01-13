Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC8E29D19;
	Mon, 13 Jan 2025 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782927; cv=none; b=AUGFv/QJFOnVxgyTL7mIpuQe0g1NICMt6p+VelygtNWhm6Khn2mPmR6Wo17cMNIo1ECZQQ1VEhvvMyP4dhtNIBjwl43qSxd4sjR7O771UrcTSPEsjCz+JWe7CfMuDD5BCoR7G1lbNZkFgNYUkirEteEcCfkPhmL9wY0S4zneeso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782927; c=relaxed/simple;
	bh=ezdGV1GvsLDMkgG6vD/PLW6Gg9qJx+DHYsoBas5WR/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbZZFKL2svH4VIv1YU3upLUmG4sGptjSE2XqCHxIGzoFPMur3pPtgGPIvWYHq+mLGlLC0SK9arsLFiDDkWOHOKL4XH+R6al15ID5Q7rlzywSd1noNpXh8BqBgIJp+ZUwraDr+DKUaEhXLsroiJZtXkn10nHH6BDlYfFndN88pHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VvDqV5Jk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VvDqV5Jk"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DE6HEv018414;
	Mon, 13 Jan 2025 15:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xMOmJUfZwM8up3CrPy5oYax53wSUkJ
	w0YSM9enl3yiw=; b=VvDqV5JkCneG9RHqiPSkA//pyH9r+ZZTEeWs6yeGPncs1F
	DQ0LGTIg004AsdW0334Ciw+Wi0T8Fz9s1XuQmNXzDaDzwTaJxAlB2t0a9mfBzSyx
	sNWRRwI67waTYlZgHehOA12A7/RpNLbpZbFOjE/TRJOUAvF9TwEUFm8vxDvNrGnd
	jDU8NdUXqmWgwmwMi40PFRZeAEbKwAEZsGu9rBsfSyjbTmsGrjBdLntCyX4iBQ6D
	48RdhdJpeQbtxD1FNN+OsG3JIv/zSwCIVH/1q4cQEds7uAD1+8vUA39lSLSc6YR4
	SjgFZuENWmht9VLwbK7+CGjnN3L+R6XmjpgQLTsQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4454a58e5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 15:41:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50DCNZ9v002663;
	Mon, 13 Jan 2025 15:41:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443bxxy4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 15:41:46 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50DFfidX28246616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 15:41:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BB8220043;
	Mon, 13 Jan 2025 15:41:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67A8420040;
	Mon, 13 Jan 2025 15:41:43 +0000 (GMT)
Received: from osiris (unknown [9.171.45.96])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 13 Jan 2025 15:41:43 +0000 (GMT)
Date: Mon, 13 Jan 2025 16:41:41 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [RFC][PATCH] arm64: scripts/sorttable: Implement sorting
 mcount_loc at build for arm64
Message-ID: <20250113154141.42646-N-hca@linux.ibm.com>
References: <20250107083214.5a29d429@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107083214.5a29d429@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iQ8PN44jIslB0CyVZKKQ4eWaU-hf9tMS
X-Proofpoint-ORIG-GUID: iQ8PN44jIslB0CyVZKKQ4eWaU-hf9tMS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130129

Hi Steven,

On Tue, Jan 07, 2025 at 08:32:14AM -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The mcount_loc section holds the addresses of the functions that get
> patched by ftrace when enabling function callbacks. It can contain tens of
> thousands of entries. These addresses must be sorted. If they are not
> sorted at compile time, they are sorted at boot. Sorting at boot does take
> some time and does have a small impact on boot overhead.
> 
> x86 and arm32 have the addresses in the mcount_loc section of the ELF
> file. But for arm64, the section just contains zeros. The .rela.dyn
> Elf_Rela section holds the addresses and they get patched at boot during
> the relocation phase.
> 
> In order to sort these addresses, the Elf_Rela needs to be updated instead
> of the location in the binary that holds the mcount_loc section. Have the
> sorttable code, allocate an array to hold the function addresses, load the
> addresses from the Elf_Rela entries, sort them, then put them back in
> order into the Elf_rela entries so that they will be sorted at boot up
> without having to sort them during boot up.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> 
> Note, this is based on top of my sorttable clean up code:
> 
>   https://lore.kernel.org/linux-trace-kernel/20250105162211.971039541@goodmis.org/
>   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git sorttable/for-next
> 
> I tested this on a arm64 VM (running on x86 host), with
> CONFIG_FTRACE_SORT_STARTUP_TEST enabled, which verifies the mcount entries
> are sorted at boot up.
> 
> I wonder if this will also work for s390? But I do not know s390 Elf layout.

Thanks for the hint! We look into this, but it might take some time.

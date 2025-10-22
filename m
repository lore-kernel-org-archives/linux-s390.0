Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8575A78F4A;
	Wed, 22 Oct 2025 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125441; cv=none; b=Sg5+QEPyfO/xQuNd8Dfxadkb2EaEEk1k3/gfOIsdevBbVlPNIQNlKkHB1WDT5GiYYUdOJb8vGk6PjWgR3pX3gaIJ5KqNq+6nt4oiZC1L2ZHT+CMu7JHGR91+1gBZd+0i/PaNHKkX7m/pupqKYfXykEjRbdP7frSwEIhldYov2H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125441; c=relaxed/simple;
	bh=GV6LfHCVYMBwtfvWeHry4GWCkrNjtYJRvfYYQ7s4k7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8ZyzcM9WtsMX6ryr4BJIEWL++1EWsi3RHOqC2IPyvRoXmA/f1M3LueiXgeXdu1aN4NchakYKtsP8hQCXlBILC0num1b+VyZjDf/1oWqoGpgSi8K+2cCOEnqBTsHTCawMCExPbOsC6uEDpph6sWpA+IIM5nVJEQDOsWrG2MLwKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GAeSd0g9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GAeSd0g9"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M9FOp9023244;
	Wed, 22 Oct 2025 09:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=I2HQWZv7ws2gf7MbKheFMdrup/mn/0
	mQ3w6DDAhXKnY=; b=GAeSd0g9P3WfcP6f6SSGgqTAH4Gg8hjIf6DNKvFnCpxmt8
	gtFVo6CvAFXyD3vNZgHjlO4328dZm+7KE+0lDVCePGjgSjh56P8+MHPVAg3FHvf7
	UFTJU3FN09tFIow6+YsG1dAfkSFL6zKMMRHGYDrITP12FCpRd9/GXKrCt67D3OFu
	Pv9PbjdrImzm7pOkcnlMYyG4cKgFLB5/IDTFPUqbGBVdpkzba6o8QAgjb1Oyr2Fk
	hbG6fGDc6hsRsIvZYywYsxr7OkfgREyqTAU+5vyjbXHokW596xdKpJoopAOyGI4R
	Do/Jw3VmbbF4j4cnukqky6PKE5QVfYZvFe96Oj5Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326uubt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 09:29:53 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59M9SuqM000875;
	Wed, 22 Oct 2025 09:29:53 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326uubp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 09:29:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59M805Q0002367;
	Wed, 22 Oct 2025 09:29:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejfan4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 09:29:52 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59M9TovZ10355196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 09:29:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D96D20043;
	Wed, 22 Oct 2025 09:29:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF48920040;
	Wed, 22 Oct 2025 09:29:49 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 22 Oct 2025 09:29:49 +0000 (GMT)
Date: Wed, 22 Oct 2025 11:29:47 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Andrew Chant <achant@google.com>, Sven Schnelle <svens@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Brian Gerst <brgerst@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Francesco Valla <francesco@valla.it>,
        Guo Weikang <guoweikang.kernel@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu <jeffxu@chromium.org>,
        Kees Cook <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH v2] init/main.c: Wrap long kernel cmdline when printing
 to logs
Message-ID: <20251022092947.14504A78-hca@linux.ibm.com>
References: <20251021173939.v2.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
 <CAMuHMdWAbMoQdeM5-F1YYOfEdcPrkTxdbsU8+TAYO=WuMzCqCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWAbMoQdeM5-F1YYOfEdcPrkTxdbsU8+TAYO=WuMzCqCw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68f8a412 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=cm27Pg_UAAAA:8 a=FjV1DHKLklVSAG7hgsgA:9 a=CjuIK1q_8ugA:10
 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX1mWYlSkJEKs0
 0zlGdnl10eTJxwIg3cdrnZlYWyjiFzwnQsepEjfeNTMLP9Y4ncVdzRWxJ/uQU+nEI63Z0a+74mL
 yfqVqr5dvKFMbGX+0BRiy78XU9Dfo8ruo81i5sT453Tk33mir9lTdobrziN+OTpjkG6cfeyb0eA
 ce1gT6f222fQ5GOvdEa3e5dsN0k0K5W1fHAgSfG8DLL0BCEBU/YNmoDegJlxx09noe09bZsvCze
 OELLvGWoHlKHw2Wk8vWPQmgwSY0j4Vv8xO9MioFfmp3BdkFGAOqj7v0ap5rAtT9zcH0nC4OO8Mw
 VZjUbgKHAEN+HDHJOnPtYxuGxfaOd6OyxZAO3U5mhLiFIUQOxthpPYiGYHFpjlgKECavkkCvXdi
 klVMLU2yh7xBRe+anYFlSrbV3UyRvQ==
X-Proofpoint-GUID: zZD3nkoHjh7LVE_ZMh22w963104QWy1Y
X-Proofpoint-ORIG-GUID: FzfTzG1qWiiZHe3oCnKICL44RCkP09-J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On Wed, Oct 22, 2025 at 11:16:06AM +0200, Geert Uytterhoeven wrote:
> Hi Douglas,
> 
> On Wed, 22 Oct 2025 at 02:41, Douglas Anderson <dianders@chromium.org> wrote:
> > The kernel cmdline length is allowed to be longer than what printk can
> > handle. When this happens the cmdline that's printed to the kernel
> > ring buffer at bootup is cutoff and some kernel cmdline options are
> > "hidden" from the logs. This undercuts the usefulness of the log
> > message.
> >
> > Specifically, grepping for COMMAND_LINE_SIZE shows that 2048 is common
> > and some architectures even define it as 4096. s390 allows a
> > CONFIG-based maximum up to 1MB (though it's not expected that anyone
> > will go over the default max of 4096 [1]).
> 
> Of course (unless the kernel crashes) you can also look at /proc/cmdline
> later.  However, that seems to be limited to a single page, too,
> as fs/proc/cmdline.c:cmdline_proc_show() uses seq_puts*().

proc seq_files are not PAGE_SIZE limited. If the output doesn't fit
into a single page the size of the buffer is doubled, until the output
fits into the buffer. See the while(1) loop in seq_read_iter().

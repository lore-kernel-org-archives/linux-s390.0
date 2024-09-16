Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB3615B57C;
	Mon, 16 Sep 2024 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726513176; cv=none; b=RfkY4iBjHNm8v9LCOHPdVc1o0INqujP7ttZgbsZcaxDdnr+xOSdAe/4P6ZvmytmRz+0/oQKQQD77+M0OpcrXgqbs5EcWRSz09w8MvOaDX2G4NJGO0mAx8Ua7mtyuHH9q5mJVDOtjMz9/SXt7Ihu04mv11FeUQ+34vyCk5Wl/jR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726513176; c=relaxed/simple;
	bh=UZy5kyHZF+KhpUWcZE4HLpZ4AaAlOcI9IDudMP4gees=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtv7SDYMP/BnTJ+hlv7mMs+5xA9gLPQLG1dyAXhIhBOKiLYLjJ4JCX5yG9bQJqrzqmcJaqlbNEIdXKipeQQYqchT9xjn0rC3tn06/7diHpn2wAyALqHBnTzwcsXM2+/TWmIZdMkd/uzipHwwAhD//gck3ICQTHBOXD5z1ieNMvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zi2+R4xo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zi2+R4xo"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GIV0QM030272;
	Mon, 16 Sep 2024 18:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=DfW64Zxvn/Oq5g0r72h04zyD3QR
	QSVW8Ssnqh5NzIdU=; b=Zi2+R4xoXcToC56lfXKRSqUCvTwz+Om14SXly+TDo86
	iIAH0dPGmFaA04m30KFAPlJo5kmOWRzqmNjm6YAEQzYrqT+p35WrHIAkbiuIDuK+
	0DyPCvbqJj6o3MfV2beaP9YceLIJFFWm2ebEyJ+vJG8ClEVPwV1VGkiQJmYZssli
	tKKM+hYhkqEbnh6W+igiHTd3JV+nbogi8i7vdv5ILp0g4xBVxXrRGZEds/5ehKa7
	pQ4gVECmrGw4vMONDyQ/BXw2RImziP0g1HKV0epkKJsUuXmSvx1pgJjmfjclHVVf
	daWZ/Cfu4KQrAhVWtxOnENDcf7pCGHyCHoo1gxKGk9Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41pht8b0ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 18:59:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48GH4V48000642;
	Mon, 16 Sep 2024 18:59:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nn71191h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 18:59:11 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48GIx7VK41353558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 18:59:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EE7A20043;
	Mon, 16 Sep 2024 18:59:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66DBB20040;
	Mon, 16 Sep 2024 18:59:06 +0000 (GMT)
Received: from osiris (unknown [9.171.61.102])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Sep 2024 18:59:06 +0000 (GMT)
Date: Mon, 16 Sep 2024 20:59:05 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Florent Revest <revest@chromium.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v14 04/19] function_graph: Replace fgraph_ret_regs with
 ftrace_regs
Message-ID: <20240916185905.5704-A-hca@linux.ibm.com>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
 <172615373091.133222.1812791604518973124.stgit@devnote2>
 <20240915051559.435abfcd@rorschach.local.home>
 <20240916121656.20933-B-hca@linux.ibm.com>
 <20240916122930.523af6c5@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916122930.523af6c5@rorschach.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dmOq5nxtm6ZrxtNGjiaRxXqzCOeN714R
X-Proofpoint-ORIG-GUID: dmOq5nxtm6ZrxtNGjiaRxXqzCOeN714R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_14,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=376 mlxscore=0 clxscore=1015 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409160127

On Mon, Sep 16, 2024 at 12:29:30PM -0400, Steven Rostedt wrote:
> On Mon, 16 Sep 2024 14:16:56 +0200
> Heiko Carstens <hca@linux.ibm.com> wrote:
> 
> > This does not pass the ftrace selftests. Please merge the patch below
> > into this patch. With that:
> > 
> > Acked-by: Heiko Carstens <hca@linux.ibm.com>
> 
> Thank you very much, this is why I wanted arch maintainers acks before
> taking anything.
> 
> There may be other patches in this series that I didn't Cc everyone
> (yet). Did you look at the other patches? If not, I'll go and do the Cc.
> It's a manual process.

I just had a quick look and tried Masami's git tree with the
topic/fprobe-on-fgraph branch and tried the ftrace selftests, which
resulted in the provided small fix.

But now that you ask, I can see that FPROBE is not available on s390
anymore with the full series, since HAVE_FTRACE_GRAPH_FUNC is not
available.

Also the s390 variant of arch_ftrace_fill_perf_regs() seems to be
incorrect.

Looks like some work is needed from our side.

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F1A30E0C6;
	Thu,  2 Oct 2025 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759403137; cv=none; b=r3SjLSow3hKwxbxk7cjUtG9gDGJjejsB2Va2waoS3w9/i3gFAZex0eHUZzJEVBKScNGid0Js2pptNSFUjdlM0GcjCwBQ6WRiRB0tWJiHvhRjPYl+y836eyInJp8aiSC83ISK82+tuCS2JTBK3b8kTKBB6gPq0vjLnJGEkIQ53IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759403137; c=relaxed/simple;
	bh=Gbms4G+50NJ83q+xm8/NzAd6fbZ4vf+huSYnRnfSNhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgXPcDGuF4Uf+p+sa+WgGvommQF1EliOfjhRz5EzppgkSbDWFUeSN6h+zdOeihf41THQmy020egu0BkWiPNRxP6aauoe0ReJAhSq1WJsUcWZPSJW+ujRNQbWB58h+dk1J37P1F26gnP191rxg4dJnfWqTcXHuUjGkT8mWD5ZEP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OHgRwMc3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OHgRwMc3"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5920lH9V023884;
	Thu, 2 Oct 2025 11:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hRD3zu
	0oLCOgYfE9guMupoc6bczXi8SWhb/uOhXW9d4=; b=OHgRwMc3ougy6uUCwuHj1H
	mq3nrFihwEbPIveM9WP4cpMhyzChxeLYRU8SwOy8vQ2mftSpKRo3jQkB13F+Bm3o
	Jlwq3bA2QZqabOMemMuvij9Zygdz6AK8kYymSpYNzItuixfiiBj4/4X3cFtb0IK6
	rMjb3jxXFxUYp6CNn7Cs9wW/eFG2MINqp/qoDjJGZj0ra/OsFrcwoWzg9AmEweUr
	XQ+T38ESZ6GBu4GHmjDNO+DEPIo9OgzkKwxkIw40XWBNIi5OH+Oqh9VUau2vNgGo
	QjO6JEJNJnl+6RldSDB2dwM6EnecPpk2+BbPPL6vFEiJHlKRdVmU/+YBQzz/Xs/A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7n84y7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 11:05:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5927u9Vv020064;
	Thu, 2 Oct 2025 11:05:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49et8sdscf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 11:05:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 592B5TiN52887906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Oct 2025 11:05:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 409C320043;
	Thu,  2 Oct 2025 11:05:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CC1920040;
	Thu,  2 Oct 2025 11:05:29 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  2 Oct 2025 11:05:28 +0000 (GMT)
Date: Thu, 2 Oct 2025 13:05:26 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] s390 fixes for 6.17-rc3
Message-ID: <20251002110526.7570C1c-hca@linux.ibm.com>
References: <20250822123608.142112A72-agordeev@linux.ibm.com>
 <ab3131a2-c42a-47ff-bf03-e9f68ac053c0@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab3131a2-c42a-47ff-bf03-e9f68ac053c0@t-8ch.de>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Dq8cAoC4UxGiBYd4j48VMLB2p7PbjA8w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX8tPaQDF9S2VL
 jjugdQNNiob+j3oDZ1XsC6qpCj/8PnpqOclpbvncsV1irEiSqfpAKZ8v5vsvM+jPqj16yY3OTbl
 zWJi0MSrJxCSFJgCqEOifdD3VV/vRfGcXIEmgYSRFz5DbQpIBlgQr/qjSwS58x7xxEkP9mmkGVh
 75wlc6mzcS046LNDZHDPvACTLrqfRofyXNvjBKJB1QUv0RJAMq896kIbA7fpTKikBLH2SAT3U2C
 Cm4Kk+1Y/N9A/fjhBUW79EiV0PcS2U9neEpgYGWn/ozufrdmr+ITGTyIrklODj+AvVxtE9IKmPF
 xd3mqTuoYje7h+rFn47qtPILNjTFtk9SULQPuC6gdctvYPBlwnzkhl2vo/X2h3pkon7Sh+DA7uy
 YgRLxj5vG/pry9Ugp2wa4getQBNz1Q==
X-Proofpoint-GUID: Dq8cAoC4UxGiBYd4j48VMLB2p7PbjA8w
X-Authority-Analysis: v=2.4 cv=T7qBjvKQ c=1 sm=1 tr=0 ts=68de5c7d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=7XOAULQ-JK2wxBLJYocA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

On Thu, Oct 02, 2025 at 12:44:41AM +0200, Thomas Weißschuh wrote:
> Hi Alexander, Vasily and Heiko,
> 
> On 2025-08-22 14:36:08+0200, Alexander Gordeev wrote:
> > please pull s390 fixes for 6.17-rc3.
> 
> (...)
> 
> >       s390/configs: Set HZ=1000
> 
> With this commit the nolibc testsuite for 32bit on QEMU 10.1.0 starts to
> reliably crash. 64bit is fine. Actually I encountered the same problem
> before this change, but it happened much less frequently.
> Output below for a testrun that never got to print anything to stdout,
> but the crashes can also happen later or sometimes not at all.
> 
> [    2.118473] Run /init as init process
> [    2.142148] User process fault: interruption code 0006 ilc:0
> [    2.142626] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.17.0-rc2-00002-gfcc43a7e294f #24 NONE
> [    2.142739] Hardware name: QEMU 8561 QEMU (KVM/Linux)
> [    2.142822] User PSW : 0705200080000000 00000000804087b2
> [    2.142911]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:1 AS:0 CC:2 PM:0 RI:0 EA:1
> [    2.142979] User GPRS: 0000000000000000 000000000040c060 ffffffffffffffff 0000000000000002
> [    2.143022]            0000000000000800 00000000000007ff 0000000000000000 0000000000000000
> [    2.143061]            0000000000000000 000003ff00000001 000000000040c000 000000007ff720ac
> [    2.143106]            000000007ff720a4 0000000000409540 00000000804087b2 000000007ff71ec0
> [    2.143406] User Code: Bad PSW.
> [    2.143454] Last Breaking-Event-Address:
> [    2.143483]  [<0000000000000001>]
> [    2.144705] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004
> [    2.144875] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.17.0-rc2-00002-gfcc43a7e294f #24 NONE
> [    2.144922] Hardware name: QEMU 8561 QEMU (KVM/Linux)
> [    2.144989] Call Trace:
> [    2.145292]  [<000003fffe657cf4>] vpanic+0x1dc/0x2f0
> [    2.145535]  [<000003fffe657e4e>] panic+0x46/0x48
> [    2.145586]  [<000003fffe65e4e2>] do_exit+0x3da/0x520
> [    2.145634]  [<000003fffe65e820>] do_group_exit+0x40/0xb8
> [    2.145683]  [<000003fffe66fc98>] copy_siginfo_to_user+0x0/0x60
> [    2.145735]  [<000003fffe60614e>] arch_do_signal_or_restart+0x66/0x2b0
> [    2.145787]  [<000003ffff42e2bc>] irqentry_exit_to_user_mode+0x174/0x1f8
> [    2.145902]  [<000003ffff439d5c>] pgm_check_handler+0x114/0x160
> 
> You can run the testuite for yourself:
> (run-tests.sh will download a cross toolchain)
> 
> $ cd tools/testing/selftests/nolibc
> $ ./run-tests.sh -p s390
> (Expected output, lower numbers mean failures)
> s390:          228 test(s): 227 passed,   1 skipped,   0 failed => status: warning
> 
> The full test output will be in run.out.
> 
> This doesn't feel like an issue in nolibc to me.
> Any ideas?

Hm, this looks like a qemu bug to me.

Ilya, could you have a look at this please?

The above report is a specification exception with an instruction length
code of zero, while the PSW points to a 31 bit user space address. As far
as I understand the architecture this is only possible for an early PSW
specification exception (aka invalid PSW); however the PSW looks good to
me.

So something seems to be odd here.

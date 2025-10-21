Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EE61DD9AC;
	Tue, 21 Oct 2025 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052661; cv=none; b=ItZzy08Wx94fWHJ4bnC07cjDrPlFJa1SmmVbiMIcXjjfVF371XsfPiOYqocRH6S4zSRdBI1XI77YwdV8cTeH2i8nCZe/nCTHzJD+2q/DN39lZTNxyuiMQo8la3QmO9wBvMVDEqK57SBREwyit/0JRzhKdSvX4KfQzSU2Tz/2AAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052661; c=relaxed/simple;
	bh=ktO4m9jvZD/rIB4n95XBwqKHwPZqPVtiRfnNM1GVTG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7SzsIex5ex5/Yp6yWah9CfJHBmQnSYqet1nY+1evMTLCRBjypPBpAqTDGMWT19QF6X6u//rcMtQw19g84Gts6Z22BtxO5LITBBNWD2VSJdsh0K8YJB06LK1rXQK1/rSL1l/pABwi513gOGThHEhgP1GGL42BrrbF2d88KCKJeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jJLk6CRp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jJLk6CRp"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L6ljY7006853;
	Tue, 21 Oct 2025 13:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=59kDhs
	xHhCui/zE6BV0zbA2HLqf5J0MKFlP8k3AlIVc=; b=jJLk6CRpjdktmNUTiwy22T
	1y8JkX5W6b1XDWWQuC30HJRqu0iUkILyxvN0YpLemJD6k/0zoMkcZuFSH1UQqd+a
	B5MxdEwHTXNkdjeLFQG5Y9e9c6U0h+fBVNOkMDktRwG16pKtYe03ix+4OmYpayST
	FwBeJ/zt5FWphwVvFdMX338k5ODEWSxRuMaHFgguyV1Ih6kqmFgGp1kqbAv3pXo1
	D/AgA24z1BFmMVj80HD5HT3KTidgkHHRWdW0JF6XA8jxQD/iooZm1FjfSTCZzhg/
	HMqvlWQnLZwMpMQ0TrdUAbRsn3L95GblXjHnDGFrYMu/erSTgbqb5ozEH5uV5hwQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vntfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 13:16:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59LDGdhT028829;
	Tue, 21 Oct 2025 13:16:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vntfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 13:16:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59LB2Gjw017081;
	Tue, 21 Oct 2025 13:16:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnkxu02j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 13:16:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59LDGacB50135394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 13:16:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56C1620043;
	Tue, 21 Oct 2025 13:16:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8E0F20040;
	Tue, 21 Oct 2025 13:16:35 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 21 Oct 2025 13:16:35 +0000 (GMT)
Date: Tue, 21 Oct 2025 15:16:33 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Doug Anderson <dianders@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Andrew Chant <achant@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Gerst <brgerst@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Francesco Valla <francesco@valla.it>,
        Guo Weikang <guoweikang.kernel@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu <jeffxu@chromium.org>,
        Kees Cook <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH] init/main.c: Wrap long kernel cmdline when printing to
 logs
Message-ID: <20251021131633.26700Dd6-hca@linux.ibm.com>
References: <20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
 <2d514d61-121d-44fc-aec7-637dd0920de8@infradead.org>
 <CAD=FV=VNyt1zG_8pS64wgV8VkZWiWJymnZ-XCfkrfaAhhFSKcA@mail.gmail.com>
 <CAMuHMdVT-_UVAO=1jvTPEjKO0zy7H1rUrQz1ubMfHivF4HWJNA@mail.gmail.com>
 <CAD=FV=WeXOj_hyA=V9hMLHOJ_m9ui5mP6cRv2DpjXnR62_nd2w@mail.gmail.com>
 <CAMuHMdWGb0jVt9ziBtWdHWC9omPAFMHVPBHDpv0F1XzvR0THpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWGb0jVt9ziBtWdHWC9omPAFMHVPBHDpv0F1XzvR0THpg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I-TIS4kR6Ou-Mb55i_Ay1degV3_Mx5Fl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX6yB+urCIgoIi
 6bgTPbTtxdzNQuDNbAlPfWyFzsZP0czUuCRqBrGQ88yR0qkjrAKBbvZFihPM5atVCrL1llTI+4E
 yFBwgZI0xe/HCzDvfZNVZ+8m9FiJCObDMlhwTgFw2D7vXWN5wHTFrscIsKQxg+BdtX++42p8u3a
 yTeRh81CNcqc4r8/eat0UTCsZ4yQNAQuI4oLrXukmeHQmfu9Dm1LRnlZvCB0IIj5hbjLbxV7ZoX
 BjeVDEU+uwGEc2V7KalslNq9VLJVmwGBkgtd3JFns3p9crNjSOnNQbJu/80R9aauto1pZoW3YsU
 gEPo2uFohFGSMDV+qM2UuWXJFODG1WHy4N7beZGdchGF8Qp+VF4qFija1D5Q9FrxZclXZQQyGlh
 Pruam5GVj+kawSChWFczG/9Qv9qq3Q==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f787b7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=cm27Pg_UAAAA:8 a=tBb2bbeoAAAA:8 a=EHDhFRfyqMhxxtNxYo4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Oj-tNtZlA1e06AYgeCfH:22 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: vs11V-hue1blIi2oIbSzP3wDj86PAYS3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On Tue, Oct 21, 2025 at 09:05:48AM +0200, Geert Uytterhoeven wrote:
> On Mon, 20 Oct 2025 at 18:04, Doug Anderson <dianders@chromium.org> wrote:
> > On Mon, Oct 20, 2025 at 8:42 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Mon, 20 Oct 2025 at 17:33, Doug Anderson <dianders@chromium.org> wrote:
> > > > Printing the command line to the kernel log buffer is one of the very
> > > > rare cases where:
> > > > * There's a legitimate reason to print a (potentially) very long
> > > > string to the kernel buffer.
> > >
> > > arch/s390/Kconfig:
> > >
> > >     config COMMAND_LINE_SIZE
> > >             int "Maximum size of kernel command line"
> > >             default 4096
> > >             range 896 1048576
> > >
> > > Yummy...
> >
> > Wow, what are they expecting to stuff in there? An encoded initramfs
> > or something? I kinda feel like the 1MB number isn't something anyone
> > expects but is a number picked to effectively be "unlimited".
> 
> Dunno, commit 622021cd6c560ce7 ("s390: make command line configurable")
> lacks the "why" part.

That was just a follow-on patch of commit 5ecb2da660ab ("s390: support command
lines longer than 896 bytes") which solved the real problem with a too short
maximum command line size back then. In order to never have to deal with this
sort of problem again it was made configurable.

But I doubt that anybody will change the default ever.

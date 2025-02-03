Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24F7208978;
	Mon,  3 Feb 2025 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592983; cv=none; b=SOd5ffXgOLmJ1/XSPmyyZPpjj7libH9RJSXx4oWi4p/aelABbEXvdR7sUlirVdyNo+zwfHEOVp+6svkP/CYnIvI9lx8f69mX4v8klKtuKFkp4UotU34TaJ6eVx4fH/CLFxTd6EkifCXiekFdz4pIGSeRWwYDx54XDVRvX2i79kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592983; c=relaxed/simple;
	bh=G/VTYZU/vROlGro+xn6z4lRh0HzqaSGTe/N30hboTFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5g8x3M0igYYI69CHAO1mXo7sKlxwzqO8N0FvFMhdK5XQNQacDYaN0Vdqnnon50BcbrYfQPFJpF2laL0GytbN6eqwhZEyhi/Z8RBHNZjuw3+8CY16xH0pR/L94HxDRrjrHICuu+bX62ilWphvJntPCB5aXq3cdompsBYJFOWcuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A33oIIwH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A33oIIwH"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5135Nvo1013502;
	Mon, 3 Feb 2025 14:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+Y41T2taVkSM5Zly4GCoWzp0UGRNKV
	CM5pX6RyHXVJc=; b=A33oIIwH4/FWODJ5T9YOJi3oOTP+mOSIapCdksDAGXmv4S
	oHtjSR2N6jrXVfPryAripFBFfew8bRx0FxJSByjSNPA5WIQ+bjJgIhoCZ+N2kDqC
	KnNryuRmWPVWCMfoCUZ0DwUkHfERqiH4xZV3jExHEx6Gyt/B4lpxJWczirY09HHk
	MMaUXv+jkNXbVRh09EpRZLPXrJJHdC55KaUOdiDZITG7RFf5WvAV6ggl1OWcOvZM
	GJQ2R+ea74I/ymxu+8LDDc5QriI0z9BYyTO6usdKjXCRMZn4ZV9ztQ0DiiVqk1Vy
	ZFVQTGH3FDxCSTBW1A5l0Uqc8cS2NTU1trqbpeLg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jqm7af9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 14:29:11 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 513ET92V002563;
	Mon, 3 Feb 2025 14:29:09 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jqm7af92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 14:29:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 513D0wRf005310;
	Mon, 3 Feb 2025 14:29:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05jpgqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 14:29:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 513ESwTu44368352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 14:28:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A2D82004E;
	Mon,  3 Feb 2025 14:28:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73F9520076;
	Mon,  3 Feb 2025 14:28:57 +0000 (GMT)
Received: from osiris (unknown [9.179.6.188])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  3 Feb 2025 14:28:57 +0000 (GMT)
Date: Mon, 3 Feb 2025 15:28:56 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 6/9] s390: Rely on generic printing of preemption
 model.
Message-ID: <20250203142856.8827-B-hca@linux.ibm.com>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
 <20250203141632.440554-7-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203141632.440554-7-bigeasy@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -LNFvzIEuaHgXsKwYW5YPh01zUnlDCwb
X-Proofpoint-ORIG-GUID: AGhKCUXDgYclcc2iqv0Y_j0FQjOi5yZG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=476 bulkscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030106

On Mon, Feb 03, 2025 at 03:16:29PM +0100, Sebastian Andrzej Siewior wrote:
> die() invokes later show_regs() -> show_regs_print_info() which prints
> the current preemption model.
> Remove it from the initial line.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/s390/kernel/dumpstack.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>

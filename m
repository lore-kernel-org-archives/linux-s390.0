Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75483BB9F1;
	Wed, 11 Mar 2026 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773223480; cv=none; b=IO8HhNAAotDcuNzqki0WL8mVdX/NGwS9K5zJXIz/qN26DBrfUVY+QVkcLXQcuKQV2wj6c8yG/2drPk1qvCl/X1vBbkMXfO06c0lnYuayjL7E+qRe2tl37S7TOBdeszOki+4FrH+fS13UmJeTic5C9SkPVfhf5HY8GpHvfHVE+Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773223480; c=relaxed/simple;
	bh=HhlP0sR9BWbdVqrstvSk8iUJL7QRinsa0S3+Lx3vo+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtjW1+5mg4QZxYcJCebCxC+Lmx9oybOAimGGirClBk44Zccc8fy9jb5vtTh1XE7DOHrHJv3BNt4B0cUKFDTHtgNT2odhOTu8rrqTXlZcjhByVccCfLyDXQdmdgPQ7W241u4ntvEF4cwNbs8Np+tSgYhKdzBsOE3WWLGXsmDK40Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g9CUMjBM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g9CUMjBM"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ANRRVX1765534;
	Wed, 11 Mar 2026 10:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=rPTOMk6df0t4cDvEy9NcKi+4joDZ75Tr0LGWGF1plls=; b=g9CUMjBMNPzh
	Ajz9Ibf4a00sqceDG7AEkKc1bhwUUlWO9mHrmshS77FFuEBDSgpY/lDOUBBpPmZ6
	JxD/crCBPo042b6V/byc9MZpt1FLQGYOG0P3uCzQm7/3BC7p/YqpEXdnr6aidOTr
	uys5sDomnslXQitLLLjtvFlZQiW4g0U1uPvwbYMAuUFj6hJGeR2iWtn8TRPwm17o
	gypNkVfZ1OX7yWhqBjNeBDEkBJV1DtZJYvtRPE+ceI19micViFMegmPWmG9h+RG7
	1xjxV4rqkxpw5L5MlmI0jJdKfc7Z+jtvUoAPmx4tpza1OG6NHFpWdL25dWQ4JEdE
	mpa0Es7FWA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuner60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 10:04:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62B7xSbH025041;
	Wed, 11 Mar 2026 10:04:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jk4s4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 10:04:34 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BA4W7H41484678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 10:04:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54C332006E;
	Wed, 11 Mar 2026 10:04:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 458962006C;
	Wed, 11 Mar 2026 10:04:32 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Mar 2026 10:04:32 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1w0GQZ-000000078g2-44v4;
	Wed, 11 Mar 2026 11:04:31 +0100
Date: Wed, 11 Mar 2026 11:04:31 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH] debugobjects: Allow to configure the amount of
 pre-allocated objects
Message-ID: <20260311100431.GC46248@p1gen4-pw042f0m.fritz.box>
References: <70f06193b3c3581802710ebcef74671e50c4c979.1772035270.git.bblock@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70f06193b3c3581802710ebcef74671e50c4c979.1772035270.git.bblock@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lq66W5o8IcSKWLItn_9olcEbQlzn53Zs
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b13e32 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ekmHljRe3q7W21zHFs0A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4NCBTYWx0ZWRfX/c7mr3/MLUsC
 lqCPRoQ9fvvI5UUfk1uBVh9KXntCkHVW93AANxSDz8cr7LgQJiP29HVXmLVQckLT7G6ZQksQNFa
 ghLz/rtjmFpx3DOJUQOutorCvPYg9JENeDEKhV4Z9JyatThb79qQji3bmSmf5fjgUPEyeSRoZcy
 nKvmBJr+NUx+fIXIjw1enlJRnHUOnaA8ge2///fu3zhYWaSRYKXITxVr3QZ+DLzylMn0WfAS4TK
 94vmVWTNBRC1bKrp9pvK/ABgTDSdABK/l+Dkm+K0V4M5SZ2QbnanUgI21wqFRRuLmcvUInzpWmM
 knUg2e2tvRy5oZlQQs52xz40iAIsEY0bP4UqxpJUXKytV0R5Ru9goZn/2YDjPAz6CgZhCgynGit
 M8WIUseHHBnbUv/sTicX1Mq2JEhSl/700yXsu1I2vEz3++ETxuz7fi2wzhiI00FSd0UjkvQgr3h
 Gccx5zWNZH/f1JFjwqQ==
X-Proofpoint-ORIG-GUID: lq66W5o8IcSKWLItn_9olcEbQlzn53Zs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110084

On Wed, Feb 25, 2026 at 05:05:08PM +0100, Benjamin Block wrote:
> To debug object operations a certain amount of metadata has to be kept
> per object that is tracked. During boot a static amount of pre-
> allocated objects is set aside to be used for this task until such a
> time a dynamic allocator can be used. Once a dynamic allocator can be
> used an initial amount of objects is pre-allocated to be used when
> needed.
> 
> So far the amount of such initially statically, and later dynamically
> pre-allocated objects is set fixed at `64 * 16 = 1024`. But depending on
> the system this might not be enough during boot, when only the static
> amount of pre-allocated objects is used; and once this happens ODEBUG
> disables itself permanently.
> 
> On s390 it has been observed, that even with 16384 such pre-allocated
> objects ODEBUG would still be disabled during boot.
> 
> Similarly to other debug features like KMEMLEAK add a Kconfig option
> CONFIG_DEBUG_OBJECTS_POOL_SIZE_SHIFT that allows to increase the amount
> of pre-allocated objects (in both the static and later dynamic cases).
> Use it as exponential, rather than linear value to allow for head-room
> to grow into once set in a configuration.
> 
> The calculation is done as such:
>     N_OBJECTS = 2^DEBUG_OBJECTS_POOL_SIZE_SHIFT * N_BATCH
> 
> By default it is set to 6, so the actual amount is unchanged, unless
> the new options is changed:
>     N_OBJECTS = 2^6 * 16
>     N_OBJECTS = 1024
> 
> For the previously mentioned observations on s390 it was necessary to
> increase the option to 11 in order to have enough space during boot.
> 
> Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>  lib/Kconfig.debug  | 32 ++++++++++++++++++++++++++++++++
>  lib/debugobjects.c | 15 +++++++++++++--
>  2 files changed, 45 insertions(+), 2 deletions(-)

Gentle ping, any comments at all for tis?

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294

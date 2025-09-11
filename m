Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC443218A8;
	Thu, 11 Sep 2025 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594038; cv=none; b=Cvuz2sGPv4IMVDai7dbTLEKdg+TLwqEvI4jLjf6ovS1g+cMvyVkfYreIZ3RuNuQPJ6oSod9GFzE0wgoVJS/lag4sla+6y0ALYTjWglX86Gz0ZcypLccaEQ+gw1POON+kQ7kztKhXmXAOCHNjBtagGJniW1GO8RV1EX1ExYcQWRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594038; c=relaxed/simple;
	bh=5BSLEmmZfBl3Yfv1/mzYUDJC2GYRHmDh0UNrwBqh1S8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BJTltpVtnzVKoYHKf5B0HGVxsYEE9+qJzpxFtGvuKBi/mWTJx6Qmp1kKP5uraQ3HBs/KabF0zWjVxImg2hAQDvIYdT1kSPAW12qrZeqg+GTMYXKsIq+qchNl616JjehZkRD8HgZcOFbyY8cn3F03L6H1FPzkCXJlnujNsZENXRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cjTBt33t; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cjTBt33t"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BCTbFo032212;
	Thu, 11 Sep 2025 12:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=RVFkoRRBKKz5sipdqgF9mKvUy2RClS
	ffA3CKrweZn1g=; b=cjTBt33tZraloKZ0Q9HIuzjJdeu6uh4HJfRtNATeZH4MWk
	4V1wUbl1LljoqhmZgQkzeXXuob1fk6UbvvTC/5Dyi8p8oQLre3wG8068nWrOvhjZ
	CzsYceKJmqyMuSTLeY03Nk0UVUknaB0ZSszAx/ZIp0vDpLgmvLgO7hUSDVJRN1mU
	JIqLycwZ4tbg6AVbx1DHGcJQ8hhp0Jcwzfm5+nlkJGoCxgdr58CBGxC7MZm7Nvrq
	MoO67MrkcGGCr8ukIJZDf9NofI+1EvtITVzPTgs0HHnTZvKEY40XNdmJHYsuLujs
	MvTZWFODSbWCG/Qv7IBnzklQUP2MFrCkTrgK1wqg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bct3xjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 12:33:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BAGII5017188;
	Thu, 11 Sep 2025 12:33:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gmnk8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 12:33:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BCXnqH49283398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 12:33:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D69C2004B;
	Thu, 11 Sep 2025 12:33:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73ACF20043;
	Thu, 11 Sep 2025 12:33:49 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Sep 2025 12:33:49 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Heiko Carstens
 <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/entry: Remove unused TIF flags
In-Reply-To: <27e149cc-ff11-4007-a0fe-5f7b0e8263c5-agordeev@linux.ibm.com>
	(Alexander Gordeev's message of "Thu, 11 Sep 2025 14:29:38 +0200")
References: <20250911092806.3262481-1-svens@linux.ibm.com>
	<27e149cc-ff11-4007-a0fe-5f7b0e8263c5-agordeev@linux.ibm.com>
Date: Thu, 11 Sep 2025 14:33:49 +0200
Message-ID: <yt9dms71rwwi.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX6k9cppJso/2i
 VIdW8p4UOXSVnNHMKFiGjvrcLX952/qDto/h4aYWZ0soW0E2vaZZOCfhyfcfIjqWXgFZY5KbMRX
 +H4z+hgmQagXN6GFHKsjlFF6Wco6y7z1rA7TMYJap58tbhOtwCipTWufpR00nFpI0i/tJjoHVQd
 Pe7nrCqvU7mPazE7mKpdTprc6XR2bMYvM0mi2u8Fmg2liLDCotrK26KH5E+mcRX5khKVP0dqinV
 H9squxylmG5e3hCvftHfdXcZJi4kcrd2Hf+7e3B7Chd2g23evDyg0H1CAVscXm+wXMpkQ7PXQkF
 CI89KluJpwb/Tb+vvTd5+djvg10khLRsshmzlxZzdzmM/O87LXVuA6rWjOwj9h1So0CywdqCkOz
 AO+UAbox
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68c2c1b2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=a09s8FFkOzqO_mdx6S4A:9
X-Proofpoint-GUID: lpJdG9Ut0YpC1iOhpKUg7zsBjv9jURvQ
X-Proofpoint-ORIG-GUID: lpJdG9Ut0YpC1iOhpKUg7zsBjv9jURvQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010

Alexander Gordeev <agordeev@linux.ibm.com> writes:

> On Thu, Sep 11, 2025 at 11:28:06AM +0200, Sven Schnelle wrote:
>
> Hi Sven,
>
>> The conversion of s390 to generic entry missed to remove the
>> TIF_SYSCALL*/TIF_SECCOMP flags. Remove them as they are unused now.
>> 
>> Fixes: 56e62a737028 ("s390: convert to generic entry")
>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>> ---
>>  arch/s390/include/asm/thread_info.h | 10 ----------
>>  1 file changed, 10 deletions(-)
>
> Which branch this patch is against?
> (It does not apply neither to devel nor to master).

It's against Thomas' branch:

git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/perf

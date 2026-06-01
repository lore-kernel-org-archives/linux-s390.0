Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF1B3DD87C;
	Mon,  1 Jun 2026 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335881; cv=none; b=AbbG26Fc8JZ6PijM1jq0lQpXLFOBGhmX7T4om5F6vhXl38sWJBEtK8ykKQEIloRN+SZVkHrCBJ4LlJFshaTDgepoby0g9oGQTvdqOZ5rBoMlK0fIjK2G3vHD3YpR5LxKYJDDA6Zys3eS0I8CULQfFmcZeYmdsXaZpsO0aW2hlm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335881; c=relaxed/simple;
	bh=dyEutT42YZl2x8+mcs2xKmGI5aVZXHRD0RoF0SdmJGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0jraoXSSKh+eItWusxgv1O139u7HlgMhL0vPXmZWBlzgI1VvQhEW9ec3UyclBWPX7Vdfw/tZqS8OPyiiwg8Janvi+nzpNjunzm/zzIgq86v6WyRWX6WWbjEIgqAiBxmliNZqFALLPmizsg7f+TIQXdzYOb4F7VX7k8LTRfW9h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b006s6d+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b006s6d+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65183V8H2708324;
	Mon, 1 Jun 2026 17:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dyEutT
	42YZl2x8+mcs2xKmGI5aVZXHRD0RoF0SdmJGo=; b=b006s6d+9mHMcJae45RXNY
	GpwwXLzDjy9DdW5Q5WulmQ+7NcC97FxlgqUWNir7BaJs/hj9dWUoN9no4M20zfR7
	j9X/nMQRH8qTql5a/jaZR37J0UE4Qp5rsaiXzCGowoKRj5g2jxx1illwsjC31KWT
	8AZwJ63wOhTvjOcx5X4GvTp3ER4QXpv1jaljr2YXtChnc38gXRES7AwBx5vr+GzU
	BlHrCz0CqVNX8iuXcPMJffrXjkFeBSKPHuXoqnzZ2ERGjSUcNwE818YNtzAzr9sp
	Aod9pAE1pRwWbi6nFWSIkQVLd2qk8ehIKjgOm7MXatzadVJGWPfSpX5AeALitowQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahj1f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 17:44:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Hd9sW009474;
	Mon, 1 Jun 2026 17:44:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegf5qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 17:44:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651HiCvM31588908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 17:44:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 658BD2004B;
	Mon,  1 Jun 2026 17:44:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 075FA20040;
	Mon,  1 Jun 2026 17:44:11 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.111.56.230])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  1 Jun 2026 17:44:10 +0000 (GMT)
Date: Mon, 1 Jun 2026 19:44:09 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, boqun@kernel.org, gary@garyguo.net,
        bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
        tmgross@umich.edu, dakr@kernel.org, rostedt@goodmis.org,
        ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] s390: Enable Rust support and add required arch
 glue
Message-ID: <ah3E6ZFywM4i-QcS@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260529145752.1209016-1-japo@linux.ibm.com>
 <CANiq72m7D7P=dV69FMZMOwUVy_Yr464F_4s=194-iUX4pdt-SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72m7D7P=dV69FMZMOwUVy_Yr464F_4s=194-iUX4pdt-SQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE3NCBTYWx0ZWRfXyue/0KG4Ip8C
 xjzPHE3qLwEqBpGgPGmhS+TCdSDh4Vr4MKVbirJOX5BDLNTPemeNTEhOYqByPTTdwOJL98wUFNj
 RpuIyf5b0Vt4ueZz7f4a9NHHqwptlVSDFepoh09E5qlrv+lrk0RCOaD9zGfGc8hSQAUWVSJi6Cf
 xqfNbOiNP5fMbOItr0bbNl1q11t8vUQ4gkmLMtJrWH7OoEfHHKriRLQG5uQDKsx7hT4oKa6h7CK
 RVDb3GbKi6YuB5Yx5EOYqawsS1ebt7H/cPHR7cBZj7SypCuDDx0AdTz7Yh9u6ZkwDGQ5m2gAAY1
 kPXGacf1UA425HnK7wH6eYNSE5LIZYcqnwercSjr9JzKUcOx7BCz59IvWR4AlMtraNOU9zhTtQB
 9bac/jyX97fA11Avq54ukwlXsIBBVJrf4E5kbrsSfoDV9AmxepVo0sN/tASkyBvlpiSQ8bDR6BH
 ezB+9uOPEuQLE1i+TYQ==
X-Proofpoint-ORIG-GUID: cBOjzcxTaPdpVGRbU_cwEi1EHifZSMXD
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1dc4f1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=B8-Fg6-m8CMBhuCguJEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oie2Ri6e_G5WcpLcFQ5eCN7H2GvroJgk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010174

On Fri, May 29, 2026 at 06:56:45PM +0200, Miguel Ojeda wrote:
> On Fri, May 29, 2026 at 4:58 PM Jan Polensky <japo@linux.ibm.com> wrote:
> >
> > Tested against: rustc 1.96.0-beta.7 (6be5f81e1 2026-05-17)
>
> Rust 1.96.0 is released! :)
>
> Cheers,
> Miguel
Hi Miguel,

I’ve downloaded and tested it. v5 is now on its way.

Best regards,
Jan

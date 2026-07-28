Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D202E421221;
	Tue, 28 Jul 2026 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238835; cv=none; b=dJEBx0RkS3eXO32rRPqH7hT0tN0ppQor1TlvRJMhRHnmqg6czEaOJnKzjHR4AAKrHKBJBaPVuWa5oWYq6QKRCLByaYtTvvyilOzkf0IISZR21fQpBar1q4HIX1IxmJCqxRNbsG6Kvc+/Njz0JqjiQFAoSlgiwUi+IYdb4/A6P7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238835; c=relaxed/simple;
	bh=GpA7sRKintJ1JS5smoJPjkIQ9EQwy8UmaL/2fZPUQno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YERKYE4WVNJn+zmigmHMfn79y9rPxZhrtlinxB92UQXnzFdFXjMm0rQkA71so9niCYlEjNKbfOn1db2dD1g1t8L9+ciA4moCmC2du1MfwLKxgTsdQoT/tmGV6C+Mb36biFNFlmoR1bS2JL6yz/4nCv4MvX7Ei7jHm9QgsmQvCkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LL0b6FzY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LL0b6FzY"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SBHXXb929529;
	Tue, 28 Jul 2026 11:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=cWicKoIPHrNInDfSzoIR7m5C4POiCv
	kq0VT4g6RIL3Y=; b=LL0b6FzYspXHd4QtaLQl6zAz10A16iPXcwkcCYRg+nKxxF
	ftSnLaMigHQ63Kc+t0OXjZRkUObTsREjlhsJMn34hBZjuuMS53CrA6TwJrVO0Tlh
	1QhHpxrAHGdIoM6K5m3nmDDopdiAaG8N/DNcMmcMHway6QfSrzch1IlolbcJLpUh
	hqWXaVEWyZKeDxLZJQ3Qs4ih6ZH3rl9H/ESYSEUqqMTXAeH29Iawnl0NEgagfsgZ
	cB/kMsRIi+oowBTtptlrGYuD6oUnfFjZiSU47I5El5MM2BMEYZ2THKk0V1Vo6hKI
	xGwtIhBB5ME1uIMkufbXwmk9syLK/NerUM6ZQJzA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7cwf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 11:40:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SBQfo2030041;
	Tue, 28 Jul 2026 11:40:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk1kam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 11:40:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SBeJjU33227202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 11:40:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D52B20043;
	Tue, 28 Jul 2026 11:40:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AF1320040;
	Tue, 28 Jul 2026 11:40:19 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Jul 2026 11:40:18 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Mete Durlu <meted@linux.ibm.com>, agordeev@linux.ibm.com,
        akpm@linux-foundation.org, andreas@gaisler.com,
        borntraeger@linux.ibm.com, davem@davemloft.net, gor@linux.ibm.com,
        hca@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, pmladek@suse.com,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 2/3] s390: Implement arch_do_panic
In-Reply-To: <C84A503B-3DBE-4982-A124-F3702BF9EB36@grrlz.net>
References: <8E5EEFE6-C655-4319-B659-E3817DD24954@grrlz.net>
	<5b9f08f0-4412-4841-b7c1-21de21557fe4@linux.ibm.com>
	<C84A503B-3DBE-4982-A124-F3702BF9EB36@grrlz.net>
Date: Tue, 28 Jul 2026 13:40:18 +0200
Message-ID: <yt9dqzknxrz1.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rd54aFSeey66jGI3caMB-sYY-VOJ9oJL
X-Proofpoint-ORIG-GUID: rd54aFSeey66jGI3caMB-sYY-VOJ9oJL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5OSBTYWx0ZWRfX8WyXWd2N5Z4B
 Osuf6LEGPlJvWG4THo6RZ7yvGnaZSey/wDybI5zz93kpTLSX2Sw8GTUJu35BahfjSfNBjAdIVt9
 D6wbGJrPSJXUE9D6WesVO4X+NNBo4LtCQNoBTW7ouWAzsybTLsjoMxNir+en8jf7eyFoQQcB4NK
 YSfCL1EDzx2wrEukUEN0XL/EyV6TxmaVoK1l9FNPyBZe6oXXLnovN+RG8KPqKZ9OSjJgtihn3ee
 laJiBCr67iWIjO6V8hCCgP4uxTAwf4VttBhn54xEI/JrimVbuhzq0zAXpjkwHC6elcLgEAjK5yV
 AY5CPKYQJ6fk1VWStTAMCKyNaOTI5dVEbwGDMLwccuMogaBghM4eVuTt1ELg9oMi2jgMDAaJxdz
 mnobATwMupQ63/xHCrp0JlgrElbk1EJJZe5sXzqoOGKvx7xrJEWBl3hqRNJBBJP0QzgD++vmKfx
 BqSS5Lgot4FyrYxK0/g==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a689528 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=jcFIXsoQAAAA:8 a=VnNF1IyMAAAA:8
 a=85Yt1j-L8YSk_LuRtnkA:9 a=M1-Q_cRM6PFdmZSamPpU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5OSBTYWx0ZWRfX/M/iNUSccYQU
 FVIA308JnWOwaE83QhjFlpyh+ePEfKX3EYK4RKxkefVxnSVYaqXY0dqABOjMx0fo1aZKdqBh6nX
 KyJkRXnCvw0XOOVrO9H/21K2CdhF5Ik=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280099

Bradley Morgan <include@grrlz.net> writes:

> On 28 July 2026 11:43:17 BST, Mete Durlu <meted@linux.ibm.com> wrote:
>>On 27/07/2026 15:01, Bradley Morgan wrote:
>>
>>Hi Bradley,
>>
>>>> This now means that the panic_timeout value takes precedence over user
>>>> defined on_panic behavior.
>>> 
>>> this is the part i want to poke at. distros routinely ship panic=N on
>>> the cmdline. with this change, anyone who configured on_panic=dump on
>>> such a system silently stops getting dumps, because
>>> emergency_restart() runs first and never returns. a reboot instead of
>>> the dump you explicitly asked for is strictly worse. if you and Sven
>>> want that semantic, fine, but spell it out properly and give the s390
>>> docs for on_panic a line about the new precedence.
>>
>>FWICT, there is no mention of shutdown actions in kernel documentation.
>>s390's user documentation is a different story. I agree it should be
>>documented on Linux on IBM systems documentation.
>>
>>I'd argue that specifying both on_panic=dump and panic=N (N>0) is
>>a configuration error, but maybe a pr_warn() could be added to the
>>when on_panic=dump is configured with panic=N is set. That could
>>hint what is wrong if anyone investigating dmesg and trying to
>>figure out why system didn't dump.
>>
>
>
> hey, sorry I'm out, so I can't do the most massive think ever, and I may
> embarrass myself, heh.
>
> I think a BUG would be sufficient, we would want to shut down the system
> with said bug, I know about panic on warn, but sometimes that's not always
> enabled, something like a BUG would be good, what do you think?

Err... No. You don't want to make a mistake while updating the kernel
panic parameters just to figure out that on the next boot the kernel just BUGs()
because of that. There are of course lots of reasons why changing the kernel
command line could end up in a non-bootable system but this one would
be ridiculous.

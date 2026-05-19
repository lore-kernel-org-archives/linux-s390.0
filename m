Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916174963A1;
	Tue, 19 May 2026 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185595; cv=none; b=C4URojADTH992l5ZqVnkA1xCY/CIWbKZveJ/DFcgv7fz54aD/3jIrrOyEnyLKteZIJktZbe+wYNjSc2GkH0ryZcKPm/qYTiAllhMOWGIaXei6pmsuHbfERTILOc2hCMB7kkyNR8gJ3avwkWmauxQQUCx0W/y2ImZmB/nkCQanvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185595; c=relaxed/simple;
	bh=dXpBTXGa+YMdnYnaEo11/RNepmS7/baSYCsmiLsCgIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovMAUK+bXConMBJHtPzQOlWvGFG+CX2sV2gESQsnr6YuUXAUCOkIGjb6fPAmgj7uNzEZoLTPBiW6WQH7dlZahNWPjeLDkdR6DLpEEASpJfU2AFAyxboAFdMgeS6ET3lTLTIjoPH9Jw/x/1OwfB6Fqjc/zWv47o2xJLH2eOgAIrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LPRpSWhv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LPRpSWhv"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J8oBXP789447;
	Tue, 19 May 2026 10:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=FtQMa9SqNfgMwdF7F0rrASX9TIQl9I
	AhVr1e/6dyuBA=; b=LPRpSWhvqdAYuw6E5lrgw9vHJ8vlt9N4YgvyGHosgKU3MV
	MWn/A3C0A/7uU6ViwsbJSXAYLXCM8EFPdE1+I1SKIYXG+C5EqTFT+bmjohh2FtiG
	tIMDFOPTTCdft/Mlur3BdUXCHAxBnZ5Tw2L/qFSQnupzCy5GS8vP8awuCKxxKIGF
	cPP+SB293XFpBQxcKm09s7L2ZZU4RqlpJ60NVvhw3I4voeJXJYWw4sgawqg6VgMO
	R+EL71QTuIod5l6iMe0b10EoLZgi1l4lhI8v7ROSAAOKm9DaSKCfobb85K+d3MBO
	XtYbpaacpUJNsO+RdTyHBm3aL3OnV5RiZyJIq3ZQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8bpas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 10:13:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JA9Fcd012687;
	Tue, 19 May 2026 10:13:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75ky1s41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 10:13:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JAD3cx13697442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 10:13:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EA8020043;
	Tue, 19 May 2026 10:13:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75F9220040;
	Tue, 19 May 2026 10:13:03 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 19 May 2026 10:13:03 +0000 (GMT)
Date: Tue, 19 May 2026 12:13:02 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>, Jan Hoeppner <hoeppner@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: s390/tape: iterator after loop end in tape_assign_minor?
Message-ID: <20260519101302.12398Aed-hca@linux.ibm.com>
References: <20260519100026.1970224-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519100026.1970224-1-maoyixie.tju@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA5OSBTYWx0ZWRfX47G7o3fgTLQz
 enYDccqETSQ2zXfjhT0RLOkAP4xXng/yfG7rO5GWVKxm7BG/GYN6dWhc3K6VHoFJAgAbauQ1hp1
 LxmHQXTR2Lewq/EUfgslQN6nGmN4dFRNtJprefN/dSQv+CI47QxWLYMlpFGIK4ni0sTGLxdysAy
 i39Awc5xP61rDp0wbrxtVyMr0IiLZ/iUfPhi7m13t2nu0bjb8tTVWofhNPzHPiaNTHR2WDh6QcR
 7asvV5c4Y5IExX/cScYkdqJMh7Wc9dfNT+AEV7k53A+8Y+FzbefPZNtGMyXH7bajsmKFnlp7Vuz
 fUvIiDLMdru0OiuYmvcj/R9tBhxJsPGX/ochLW1w9XSJ+ItVFIry5CEA+PgCNVJhKC6/TK2yG24
 PaErZH0XIsLosZ7UqaIPMr9O38lOJ+PQSO3XBI6VuZTLpJaeXL7atoiy5U6D2OIUoK/YHakFJJP
 kS8rcMswGH82gW4khkA==
X-Proofpoint-GUID: Ug9GiQ8hsfgCDR1wtJ5kEracvBehPVTb
X-Proofpoint-ORIG-GUID: 3oqbvu2ZgnrZ3pgsAv1Hx0m1poamiEPL
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0c37b4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=SnhycFdtAAAA:8
 a=UYqB48FbSPIZwq_26soA:9 a=CjuIK1q_8ugA:10 a=zY0JdQc1-4EAyPf5TuXT:22
 a=IdunurJ9zWQ3aaQyNLvr:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190099

On Tue, May 19, 2026 at 06:00:26PM +0800, Maoyi Xie wrote:
> Hi all,
> 
> While reading drivers/s390/char/tape_core.c I noticed
> something that looks like a past the end iterator pattern.
> I would appreciate it if you could take a look and let me
> know whether this is a real issue, and whether it is worth
> fixing.

Thanks for reporting. This something that Jan should look into.
Full quote below.
 
> The site is tape_assign_minor() (linux-7.1-rc1, around
> line 339):
> 
>     list_for_each_entry(tmp, &tape_device_list, node) {
>             if (minor < tmp->first_minor)
>                     break;
>             minor += TAPE_MINORS_PER_DEV;
>     }
>     if (minor >= 256) {
>             write_unlock(&tape_device_lock);
>             return -ENODEV;
>     }
>     device->first_minor = minor;
>     list_add_tail(&device->node, &tmp->node);
> 
> When the loop walks all entries without break (every
> existing entry has first_minor at or below the candidate
> minor), tmp is past the end. tmp->node then aliases
> tape_device_list (the list head) via container_of offset
> cancellation. list_add_tail(&device->node, &tape_device_list)
> inserts the new device at the tail of the list. That is the
> intended behaviour for a sorted insertion where the new
> device has the largest first_minor. The dereference of the
> past the end iterator is undefined per C11.
> 
> Jakob Koschel cleaned up many such sites in 2022, for
> example commits 99d8ae4ec8a (tracing: Remove usage of list
> iterator variable after the loop), 2966a9918df (clockevents:
> Use dedicated list iterator variable) and dc1acd5c946 (dlm:
> replace usage of found with dedicated list iterator
> variable). This site was not covered.
> 
> A candidate fix would track an explicit insertion target.
> Declare `struct list_head *insert_before = &tape_device_list`
> before the loop. Overwrite it to `&tmp->node` only when the
> loop breaks early. The final list_add_tail then reads
> `insert_before`. On break that points to the entry right
> after the insertion position. On fall-through it stays at
> the list head, so list_add_tail appends at the tail. The
> behaviour is unchanged in all cases, including an empty
> list and a list with one entry.
> 
> If this is intentional or already known, please disregard.
> Otherwise, I am happy to send a [PATCH] or to leave the fix
> to you. Thank you for your time, and sorry for the noise if
> this is not actually worth fixing or has already been
> spotted.
> 
> Thanks,
> Maoyi Xie
> https://maoyixie.com/
> 

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221590;
	b=G7yzZEqrqp9b0wi6ERGQPaqrE11JEBP9XOpjzXmK/8o1+fetgj+YhHah38nEq36543JX
	 gUsvmwIbU2kjHxlfdyMGnvigoP3pNJ7WohMBR9WxCy6c9FZ4lzqBjmYlF+YEcq0WvYyCW
	 zg9CZszTrsbsfy5cQq/UeERA2yHOhNlNztRTzYv0Q590Ho15+lSvG1YOYrQq5i3hMR5cd
	 bNtJKopY7OSvOQqaCnXlriUm9Ib5oEIkwi2ZHLIXPF6CZTc6Y2sQPtC3L4vsPBTj/kzEY
	 NTl7N95fk37/xZ1UZ8gQ7+7aDP3BxkKr+861p6UgegOGR/JvOQT7CCl8lZsKv7WE/LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221590;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:Date:MIME-Version:User-Agent:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=h4t0MI+h1eRU+htuap5nYwHS0+6Lfb0VFABnHiXVNGM=;
	b=keYzQhBEKDFjzgCUdX3KqDFctUDD+laHBGG6IYkf4nNOeeADvdMCZUq80GTkwCUehgYU
	 AmwI2F53OYbXsqQaptASAKwgsrTDa+n6QwXX3VsGs27tZOLslMvx+Wxb3619h65p0UuAw
	 y1hmxEPaqWLONOchWDmuJqYHBniCS7cxV9qD/qCteHwgRTi1/9cBWGymunARkfEo2fh36
	 90msoO9jEUpZNeABxHpD2A0uKTOaz0CjZYS5ZG9nCdH8U9FtpwpWzsXUQw+tMkQg1QISY
	 QUdyv7tCHxedJmc79AqTnn337MSPubCjjuF4/ol0ijR4iOBoT0tPkhhl37cwqsEP7KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SVUqE376;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEAC606A329;
	Wed, 28 Oct 2026 21:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CEAC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SVUqE376
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SJYuSa508120;
	Wed, 28 Oct 2026 21:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=h4t0MI
	+h1eRU+htuap5nYwHS0+6Lfb0VFABnHiXVNGM=; b=SVUqE376f1XVk/ln62Il+u
	komaXYBz2QsTQxlhL4p+F3USU77ycpbdcho0t8axw4Wa4u9YFKyNX78WIZ3L1PlZ
	PyUSLSyPpOj46M8bobMHzZCFRaStn1SrbrAFws6jdP2SzDWM/IUJsStWuNW6bXNl
	BR8QZgGH0JK5wyu7Jbi31spuqzr2zHJZBZlq/6DrYMdpbx3KImkWcIbbohTLj9WP
	2J7pwf5TV0iNKX0tHlxL/1U7dz5V5rajFQYjuYuPnUvVySCDGhbcuuvK6YFSdR+d
	+QagyTM1uvvXccwDHIHeBS9B96CgCinFTxWmrEGe2PSDUPMHodfLsh2lXnWjk+ww
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbt70r5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 21:06:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SIYoZ61961847;
	Wed, 28 Oct 2026 21:06:26 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjsu7y0dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 21:06:26 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SL6OAe19137130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 21:06:24 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 969CA58050;
	Wed, 28 Oct 2026 21:06:24 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9583358045;
	Wed, 28 Oct 2026 21:06:20 +0000 (GMT)
Received: from [9.111.18.3] (unknown [9.111.18.3])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 21:06:20 +0000 (GMT)
Message-ID: <65533e26b37b318bc30204d23d722890b99135f2.camel@linux.ibm.com>
Subject: Re: [PATCH v11 2/5] s390/pci: Improve function measurement state
 management
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, mjrosato@linux.ibm.com,
        alifm@linux.ibm.com, farman@linux.ibm.com, gbayer@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
In-Reply-To: <20261028154352.15108-3-oelghoul@linux.ibm.com>
References: <20261028154352.15108-1-oelghoul@linux.ibm.com>
	 <20261028154352.15108-3-oelghoul@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 22:05:19 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX9/hZb/HYOTOF
 89/fkA/Qu8QX75PgdEI3N7dAhxtq/+wVsmDMM7/riPGXaaumthZSezSbBD4d5zVUabaFy6AwyI1
 RJ+i5Oj0K+J7PQeCT26eLteTPGuncuC8bFk+lcd1S71hLHqmydyCYwUeSRcF6I5fUFM/pT4DI6L
 ldzRywUwwORfOacEtWGSFE1CXl9ofsxpK7agr/FwTne/6fNRKpxkxwWgZ8LCbrUt2X7n3Ep/Mpp
 LwJLDE0l3P4ikx2O+w4z0I3IUUvrsxvhzcINYOITig8fceV7rwdo60xhmGNB7hkktRQt6Juke44
 Srw0ghZEmjMljclg7HwyC3PVqx1MchVQK97Jb0BDtTyLLvzAjdnFSweRBJlxwM+wBQmXSoSnquY
 LILuIR44uMkdHQ60NnC/DR2/q8WAvfkYEbhZ3RnmThBg1iPF4teNo4EvqZEgzN2fgI2vgBFplp+
 Tbn1GPDEBCBxjozKULw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX4LDq0mH0lpPa
 6/7L5CUd8zZ3+m3pySIG2ZYCvTu1xsAO52DwYrotEU5BwAV/JtuFAnp7QY9F/FdtMCrSxSMcQGB
 dUY8AKyITT3GxX5ISWSIzYBymNYSXjI=
X-Proofpoint-ORIG-GUID: jBAmp3kozM70NeR1Faj0RKFh4nQJRbLe
X-Proofpoint-GUID: jBAmp3kozM70NeR1Faj0RKFh4nQJRbLe
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6ae263d3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=8N0e14jtvAtsyeb-t8YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280082

On Wed, 2026-10-28 at 11:43 -0400, Omar Elghoul wrote:
> When a zPCI function is disabled and re-enabled, the firmware implicitly
> disables function measurement while the kernel still believes it is
> enabled, leading to a disconnect between the user-visible state and the
> actual device state.
>=20
> Add the statistics_on field to struct zpci_dev to track the desired FMB
> state. Introduce the functions zpci_fmb_request_on() and off(), which
> defer to zpci_fmb_enable() or disable() to perform the actual firmware

Super nit: "off()" on its own reads as if that was the actual name. I'd
either use "=E2=80=A6_off()", "zpci_fmb_request_on()/_off()" or just the fu=
ll
name for both. Same for "disable()". If this is all it's probably not
enough of a reason to respin.

> change. This decouples the enablement or disablement step from managing
> the user's requested state.
>=20
> Preserve the state in pcibios_enable_device(), pcibios_disable_device(),

Nit: Not a native speaker but I think this isn't really "preserve" but
rather "restore" with the word changed you could drop the second half
of the sentence.

> and zpci_reenable_device(), so measurement is restored automatically
> after a re-enable. New devices start with measurement on by default,
> unchanged from before.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h |  7 +++--
>  arch/s390/pci/pci.c         | 60 +++++++++++++++++++++++++++++++++----
>  arch/s390/pci/pci_debug.c   |  6 ++--
>  3 files changed, 63 insertions(+), 10 deletions(-)
>=20

The patch looks good but I think there is an interaction with patch 3
that may cause a change in this patch. That said, I think one can also
just fix it in patch 3 or maybe me and Sashiko are just confused.
So since this patch itself is fine and may stay unchanged feel free to
add the below:

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks,
Niklas

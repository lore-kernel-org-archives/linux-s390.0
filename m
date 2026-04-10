Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EA12D7D27;
	Fri, 10 Apr 2026 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815377; cv=none; b=f14Zom9RUWVXsSXtPzFpSHGxH4Q+HvHzyBgIDSs+PxuuqRkH+JrwMNE+Yf6n2jccVlXwic+XSuwW2EJEmX9U4TrDWQyrbALMOuXeumdOyW1ts42HdfR9GQqik2crqmvCbwgGCgGez/kp9jxm3I4WETv3N98F9PGIlRYxlbiLFzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815377; c=relaxed/simple;
	bh=RzEhhD9HxoNtqmJP0WHAjow2JcI8Bsr8pPAGcU9rHIQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:Subject:From:
	 References:In-Reply-To; b=oYdF3QczNDdy7r57u0iNGG5AcIeWW46xL0TYHvee0YSplVdRst6iXsO6k5enPU7nbPSGxkLwYCtLjrbn02ZaZtaKIkshgG7ZS041ADoT6PdI6kBK8Ntx7R7a/ibQlAX8MKwa+tK01+20nLvGEXeAOYOZXoPvcNSmWcwV8WhrEhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eq51B/9L; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eq51B/9L"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A3UZwF3829159;
	Fri, 10 Apr 2026 10:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IVx4RP
	xbNkBJdGITKHK6ZxboGWEEC0G53OvLIE1vd3E=; b=eq51B/9LKULzQlbte8Gbx/
	Ryp74zqkScxnNq/3eF34yvT5+43+IGZabJohvWI4C7xIxvj7ZiRVezZnEUts/6+T
	g3hJ15quhh/w8pgdiVrt1NzWSXZKV66YIeVaMhv5LqWzj+BozmJAhW+o2RUTHhU8
	lT4geVZzC2Dn6pBiucJyDX8Utbs/TwgqDdpnYHMomkpFNxy/YidZZYru6oCKySgd
	KUnthebpCM5evirTHZ5QgO1GV3Yt/Izu6SUW/joobHCFSjMvchf5hgofZxiTo6cU
	ZNChu+rjPIAeHRXSokdp66h7ChPdrRtLcESNvTTcMH6mG7zWEigDejmpGgGQxDmQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fsb6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 10:02:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A83Z2H013827;
	Fri, 10 Apr 2026 10:02:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf4ffus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 10:02:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63AA2l6344630508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 10:02:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7B7C2004D;
	Fri, 10 Apr 2026 10:02:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 857382004F;
	Fri, 10 Apr 2026 10:02:47 +0000 (GMT)
Received: from darkmoore (unknown [9.111.44.245])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Apr 2026 10:02:47 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Apr 2026 12:02:42 +0200
Message-Id: <DHPE0B76OC4W.SXWJMC17U0ND@linux.ibm.com>
Cc: <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <borntraeger@de.ibm.com>, <frankja@linux.ibm.com>, <nrb@linux.ibm.com>,
        <seiden@linux.ibm.com>, <schlameuss@linux.ibm.com>,
        <gra@linux.ibm.com>, <david@kernel.org>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] KVM: s390: Allow 4k granularity for memslots
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
X-Mailer: aerc 0.21.0
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
 <20260402150135.196943-4-imbrenda@linux.ibm.com>
In-Reply-To: <20260402150135.196943-4-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA5MSBTYWx0ZWRfX5FeDzJo0AGbB
 KGUBbfnR/fTaeYf1/Oc6+UvWz+KVjPhDe8AtIzpULNVAgF34TO0XPI14IBTZYveg5+PEBbwibSn
 y0KKLY7kBQKQM7czpCBLVoE1+uDgRM+HbFkNo6E/tJ2dLOAbVFOl1eI1GBb3VPMZX4Ic4x3Cq+G
 JRMjIT6lgig34BPOZq7nfu7gXWGDWOKZQKyq2sR45yI8FFFXZTnqAhBG4SZCQsCcsobvSLb9GfH
 gU2Mc7VLmZj49RqQvo+bkRPxA01xR2BcjoYjFm5WBblq+c0/F+7nk/XEU1v1NFrQ3Ap/6b6rt8u
 Zl9akb/jg3oC/38G2jd/TadAAjSRhTWkBPHoRI3ySRPrrDoYBPwvCE2t5GZV/IXG+jM8TlCwqCH
 BxWLN6xCEKyPNH008KAVECC+nsyiwVFZO0s7GD3BeITR/XakUzsbkQmfsnEQ6EWAWS0SqzTE+tK
 5Etvk8arBufjTkO182w==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d8cacd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=qCOx4D0ofwUGgT_s5KUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: e7bHPMEH0SGrtGfuqnaz_mkK3BjzMcIs
X-Proofpoint-GUID: e7bHPMEH0SGrtGfuqnaz_mkK3BjzMcIs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100091

On Thu Apr 2, 2026 at 5:01 PM CEST, Claudio Imbrenda wrote:
> Until now memslots on s390 needed to have 1M granularity and be 1M
> aligned. Since the new gmap code can handle memslots with 4k
> granularity and alignment, remove the restrictions.
>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/kvm-s390.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)

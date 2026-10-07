Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D957360745;
	Wed,  7 Oct 2026 05:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352237; cv=none; b=lMgHeXa/4DP+hVG2NP9pKZjoNvO9x3SjlvN7nCeZFXviXB/fL/8+HikoR2FCBy9R9otVIpi3M1pn6eb7nwCaZiuVyRULUOhKnz1INazQ3LcSP4VJv9JhApx8/f5izxNwitfNGdnnQWxz4aBrtAthPt2UrLax1xL7ysA6XtMT9lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352237; c=relaxed/simple;
	bh=fZTDNsKn1HKr9A/yk8Fri+buAgm9cLfacIEi8U2WN5w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PZLzNGc0hzSdhF/nohx7CkYuRX8r7ixEJfEi4LZ5uZ0+a8RCsK/tS5pCA3//iH68INPGRqaONm88XI/d2dz67XkI2VJPP2w3pq+Lj8b6FbfX+Amw27D+jXKx/6jknbrYL1vZlW+R4SDSxx715d83N7kbTOzWJBbqosHLO2GVkcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VU22Ne7I; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VU22Ne7I"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6974Zd6X1408319;
	Wed, 7 Oct 2026 05:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4vBjNV
	+/119ZZ4i+mhS1W6SmCgBr9Vd6CdJHam1SOrQ=; b=VU22Ne7Ibk71xi1EZSCE8o
	jnVLqeuJfG2exIMMamqSsOo20kUfXA84ykUxT4h8roA5mpdJC+znGnrsUDx4U3Qh
	SJppP0dBCEsYCL/eSBOZCxiZW381Yy1gv/L8b8sPNwtpxzDLOefz4XzhcINVewcv
	9XiCQd0iBLN1sZfMKFbykb2yWq93Hi8BLKoY17CwFlBTUHwBbi9Qbar5RChP8p2U
	lMJA/9YxaDMRzkoq4HqSyKmOrFGyD8z+3FUHs4hXYC0YoVuw9ynS8rDi6JmbQhb3
	YcLBJVfarf9rq1GqNKnZELFzRR3S4pPiuSyj6M8Ope4mDrXZ8IzbgR1nsQr3fpyg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4ju9j4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 05:50:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6974Wp4m100626;
	Wed, 7 Oct 2026 05:50:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3tr7p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 05:50:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6975oU4k34537786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 05:50:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D72E20040;
	Wed,  7 Oct 2026 05:50:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C5BE20043;
	Wed,  7 Oct 2026 05:50:29 +0000 (GMT)
Received: from localhost (unknown [9.111.168.1])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 05:50:29 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 07:50:29 +0200
Message-Id: <DLYDD9DCCRNK.38E4BO92F0JJB@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik"
 <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Sven
 Schnelle" <svens@linux.ibm.com>, <linux-s390@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] s390/pci: Fix use-after-free race in zpci
 floating interrupt cleanup
From: "Tobias Schumacher" <ts@linux.ibm.com>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Tobias Schumacher"
 <ts@linux.ibm.com>,
        "Gerd Bayer" <gbayer@linux.ibm.com>,
        "Julian Ruess"
 <julianr@linux.ibm.com>,
        "Farhan Ali" <alifm@linux.ibm.com>,
        "Christian
 Borntraeger" <borntraeger@linux.ibm.com>,
        "Halil Pasic"
 <pasic@linux.ibm.com>,
        "Matthew Rosato" <mjrosato@linux.ibm.com>
X-Mailer: aerc HEAD-0d169b7
References: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
 <20261005-s390_irq_domain_fixes-v2-4-d45b824874c0@linux.ibm.com>
 <9551e60c73649927fb80e20230883551fa03c5a2.camel@linux.ibm.com>
In-Reply-To: <9551e60c73649927fb80e20230883551fa03c5a2.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bNXr_JoK64RBUrNyJhcHYATsBMg6MolV
X-Proofpoint-GUID: bNXr_JoK64RBUrNyJhcHYATsBMg6MolV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyMiBTYWx0ZWRfX7RGj4Mg59Vqx
 gVjIaC+Q4xevOtX6HjgR5xQ9Z99xcJBfelezGyn/CvqkIzlEy6ta9AaqHO41XFBKqWYY2oXqpq4
 WHEMUuROx8KACyI1MZIAeyy0p9/MsXA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyMiBTYWx0ZWRfX1Qf9fW9mIoxL
 jtgpyc6jb6ZYO4691cYJKDhrU01y73HDmGJ4WH4TQzt8pX+aOQI7RYbxT6bseEmqKbggei1zEJ7
 HZ4O1qRN7Wb6TvNC2xGtVFpWNs14iGb8eR7VfgLGXRU+hugljeXMNG0oy2LwJnBYCKixu2vHCkm
 ttzSyM9Ps6gyDhM4VA1w+4UOfwFzjXJqypm0n0ZuW/wNZ22z/Fnjw8tvVOsJgHCPw/EBK9mLoCj
 D5T2lD2N6OwA6WOKeAJRKLDBTIN7OyUSeIgFosbLrdCNMFDUrdR93BR1CC6OxfU7tiaEQMVNP/0
 Ald0cCUpd8jisSlA2VGe4gUtfot/bxpdN0X8gtg9Lcgwqt3PreAJDuOhJPZ0MNqhxWAs7V0Wbk+
 u5E+D4EeWZLdOF7csRU8oIQv9pbKg+lDh1SHKNE/RiYkRPnWBgDZkB5xpebpsKcqxZWXp07Nzrh
 I6JJJkjmH5cRRfqJU+Q==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac5ddaa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=6k-qjkouZABmtyerVUgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070022

On Tue Oct 6, 2026 at 5:18 PM CEST, Niklas Schnelle wrote:
> On Mon, 2026-10-05 at 14:03 +0200, Tobias Schumacher wrote:

-- snip --

>> zpci_ibv served both delivery modes, indexed by summary bit under
>
> Nit: Maybe more precisely and matching the comment: "=E2=80=A6, indexed b=
y
> function under FLOATING and =E2=80=A6"?

Agreed, will change that for v3.

> --- snip ---

>>  static void zpci_msi_teardown_floating(struct zpci_dev *zdev)
>>  {
>> +	rcu_assign_pointer(zpci_ibv[zdev->aisb], NULL);
>> +	synchronize_rcu();
>> +	airq_iv_free_bit(zpci_sbv, zdev->aisb);
>> +
>>  	airq_iv_release(zdev->aibv);
>>  	zdev->aibv =3D NULL;
>> -	airq_iv_free_bit(zpci_sbv, zdev->aisb);
>
> Not sure why the aisb free moved to before the aibv release? The commit
> message only explains why it is after the synchronize_rcu(). This way
> it's also not in the opposite order of the allocation.

No reason, this ordering change is a leftover of a previous fix attempt.
I'll move it back so the teardown mirrors the allocation again for v3.

Thanks,
Tobias

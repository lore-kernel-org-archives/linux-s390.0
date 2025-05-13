Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92741E9B14
	for <linux-s390@vger.kernel.org>; Tue, 13 May 2025 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747125091; cv=none; b=XSSP0I6+uA+LrPttnCdAJk++ZFHnqroS7AAq0NIfokrZBRSI5M0hpRONMRsZ6I7kS9vYrqdal667EWKtUrahU+1z+S4NoBAtEXJyZ4yhXrGvIcwEF7o0p0jP/volEioFF84InfxPh+j6uGR+jwbN0MAxeXNJvEq6a93NigbdqPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747125091; c=relaxed/simple;
	bh=P/Iqsqq/CYrkDDJUTOc+2oHAY9Sgl4HJz8dukYNOjfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cPQEB4qzxFwEMEmKyP2ExAt6j5gwhTflnlji5+uGqsHQMvuGFNwGf77b1IhLpPGcMVbOuXlcWtncHbEgHKO41wf00J278w9G81Q6a1/Q/tOxqrbOQI1V15BiVpavBaDvCI75mxmlqFm3KtcqsOhuQDGcO/TEKumOTN9kZzyFGbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qJ0NowsP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qJ0NowsP"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D6ZEXV007317;
	Tue, 13 May 2025 08:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=P/Iqsq
	q/CYrkDDJUTOc+2oHAY9Sgl4HJz8dukYNOjfE=; b=qJ0NowsPdoBErKirT+y0Tb
	BFGrknS3OQ7D4w3FaJnw21tXQY+YJYkoiBnvP5NAYC2H/kYuU29oO6xBSLQZxmhG
	NWNlNuLBTcHGgfRCU24zFjSjHMu2IEjHyHlb/NxyolXGgXJKgQLVr5oPzPIh8H7m
	zA2cn6oqTBOFneTfkK7zJwwjElAOZJPLPk0nyIxVnRC+XkydtridBmTbWIaYQzsg
	TMVLyZnhrA4W3g7bnOZgYs0HnFFCs83CZLG6goTxyN0r2MDzY30h1ZT8jifKGgZN
	2IcOWYPKYacMlydyogue/pI0hs6SKpwxE0etBg7jsFn5tU7HsWtVb/qurLCpwZ8Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kdugduam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 08:31:01 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54D8DH4p022100;
	Tue, 13 May 2025 08:31:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kdugduac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 08:31:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54D6LMLA024427;
	Tue, 13 May 2025 08:30:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46jjmm2296-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 08:30:58 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54D8UubW49217828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 08:30:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C7752004B;
	Tue, 13 May 2025 08:30:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA2B720049;
	Tue, 13 May 2025 08:30:55 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown [9.111.36.26])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 13 May 2025 08:30:55 +0000 (GMT)
From: "Marc Hartmayer" <mhartmay@linux.ibm.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
        Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,
        Baolin Wang
 <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Zi Yan
 <ziy@nvidia.com>
Subject: Re: page type is 0, migratetype passed is 2 (nr=256)
In-Reply-To: <1fc8eb08-7e34-4b16-a08f-c81a531ec3fb@lucifer.local>
References: <87wmalyktd.fsf@linux.ibm.com>
 <1fc8eb08-7e34-4b16-a08f-c81a531ec3fb@lucifer.local>
Date: Tue, 13 May 2025 10:30:54 +0200
Message-ID: <87frh86hfl.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OOUn3TaB c=1 sm=1 tr=0 ts=68230345 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=qFV_1G7U79d3ZsnhFI8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Uy_CNV_trabut2dUQBz4UeiM42Mgx3Le
X-Proofpoint-GUID: hGXc7uCU9vzTl5G7IbUBsK_moJZCvSRX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA3NiBTYWx0ZWRfXyW6J9uieMi34 9iCJa5A4rFaFHsL6Z8quOUvlSS9ImXfn2DfgbTnjwBYFPMkIjdvetbKjDw3G9zRgw8kaMsEUaJm nrDe0oLlb1jmR8PkqCxLmWFQUuEvMvWmJ3ueeZjJTPi4SyBw8IV2zzpNVnGZTfvsv2fp7LsM3gt
 M/VgSHvW6uHHi3ZsztZ0niR5eAraaZWwSlgwhqIDD2Pc1OwEx+XcyiTcyJvdHgdPfYuc7OCrQ9z khmbA6DgPY1N+7bbO78egPQvqVhGOw6bleP4xpM28timFuUSZCe3sCx2+Ltx/6WWhCOXT22CmnE Jla5IgkVJ5Vxv2efdDjl/Ut4TE4XI3fLGtFNfrhHAst1maoeM74pswUNbyJaE0RhIhggC/s8EhV
 d25iZMDRA177BCUVwEALXuM+HCuGwd4hzKr6Opb4KGBktNdnzHwLdTEodFo3gJRxq+FjQ0NT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130076

On Mon, May 12, 2025 at 05:16 PM +0100, Lorenzo Stoakes <lorenzo.stoakes@or=
acle.com> wrote:
> +cc Zi
>
> Hi Marc,
>
> I noticed this same bug as reported in [0], but only for a _very_ recent
> patch series by Zi, which is only present in mm-new, which is the most
> unstable mm branch right now :)
>
> So I wonder if related or a coincidence caused by something else?
>
> This is triggered by the mm self-test (in tools/testing/selftests/mm, you
> can just make -jXX there) transhuge-stress, invoked as:
>
> $ sudo ./transhuge-stress -d 20
>
> The stack traces do look very different though so perhaps unrelated?

Yep, I think it=E2=80=99s unrelated, but thanks for having a look!

[=E2=80=A6snip=E2=80=A6]
